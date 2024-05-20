import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salicta_mobile/db/model/order_model.dart';
import 'package:salicta_mobile/theme/constants.dart';
import 'package:salicta_mobile/ui/root_page/root_cubit.dart';
import 'package:salicta_mobile/ui/root_page/root_state.dart';
import 'package:salicta_mobile/util/widgets/cards/order_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: kOffBlack,
              size: 20,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "MY ORDERS",
            style: kMerriweatherBold16,
          ),
          bottom: TabBar(
            labelColor: kOffBlack,
            labelStyle: kNunitoSansBold18,
            unselectedLabelColor: kTinGrey,
            unselectedLabelStyle: kNunitoSans18,
            indicator: BoxDecoration(
              color: kOffBlack,
              borderRadius: BorderRadius.circular(4),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2,
            indicatorColor: kOffBlack,
            indicatorPadding:
                const EdgeInsets.only(left: 16, right: 16, top: 43),
            tabs: const [
              Tab(
                text: "Pending",
              ),
              Tab(
                text: "Delivered",
              ),
              Tab(
                text: "Cancelled",
              )
            ],
          ),
        ),
        body: BlocBuilder<RootCubit, RootState>(
            buildWhen: (previous, current) =>
                previous.orderItems != current.orderItems,
            builder: (context, state) {
              final delivered = <OrderModel>[];
              final processing = <OrderModel>[];
              final canceled = <OrderModel>[];

              for (OrderModel item in state.orderItems) {
                if (item.status == 'pending') {
                  processing.add(item);
                } else if (item.status == 'shipped') {
                  delivered.add(item);
                } else if (item.status == 'cancelled') {
                  canceled.add(item);
                }
              }

              return TabBarView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                  itemCount: processing.length,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final order = processing[index];

                    return OrderCard(
                      orderNumber: order.orderId,
                      dateString: DateFormat("dd-MM-yyyy").format(order.createdAt.toDate()) ,
                      quantity: order.itemCount,
                      totalAmount: order.amount,
                    );
                  },
                ),
                  ListView.builder(
                    itemCount: delivered.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = delivered[index];

                      return OrderCard(
                        orderNumber: order.orderId,
                        dateString: DateFormat("dd-MM-yyyy").format(order.createdAt.toDate()) ,
                        quantity: order.itemCount,
                        totalAmount: order.amount,
                        orderStatus: 0,
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: canceled.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final order = canceled[index];

                      return OrderCard(
                        orderNumber: order.orderId,
                        dateString: DateFormat("dd-MM-yyyy").format(order.createdAt.toDate()) ,
                        quantity: order.itemCount,
                        totalAmount: order.amount,
                        orderStatus: 2,
                      );
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }
}
