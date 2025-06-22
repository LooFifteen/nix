{ ... }:

{
  boot.kernel.sysctl = {
    # disable core dumps
    "kernel.core_pattern" = "/dev/null";

    # improve network performance
    "net.core.netdev_max_backlog" = 16384;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_mtu_probing" = 1;
    "net.core.default_qdisc" = "cake";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}