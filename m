Content-Type: multipart/mixed; boundary="===============5674971629894030143=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 1257cb138f ("DO-NOT-MERGE:
 mptcp: enabled by default") (fwd)
Date: Mon, 09 Nov 2020 16:28:15 -0800
Message-ID: <f22010e5-59e0-ee38-9097-806198417c31@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6618

--===============5674971629894030143==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Another data point from the self tests - mptcp_join.sh passed on this one, =

so that test is still intermittent.

Mat


---------- Forwarded message ----------
Date: Mon, 9 Nov 2020 16:03:23
From: kernel test robot <lkp(a)intel.com>
Subject: [kselftest UNSTABLE] mptcp/export 1257cb138f
     ("DO-NOT-MERGE: mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/319/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 1257cb138f186d70f375923bad4a53ee29dd65b2
subject: DO-NOT-MERGE: mptcp: enabled by default
date   : 2020-11-10 02:13:16 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of 1257cb138f (compared to v5.9)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
------------------------------+------+------+----------+------+---+--------=
----+-----+
|                                                                          =
                              | pass | fail | unstable | skip | - | regress=
ion | fix |
| kselftests-bpf-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       |      | 1    |          |      |   | N/A  =
      |     |
| kselftests-net-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 260  | 27   |          | 20   |   | N/A  =
      | N/A |
| kselftests-netfilter-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603=
.cgz/x86_64-rhel-7.6-kselftests | 65   | 1    |          | 16   |   | N/A  =
      | N/A |
| kselftests-kvm-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 24   | 1    |          | 1    |   | N/A  =
      | N/A |
| kselftests-mptcp-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz=
/x86_64-rhel-7.6-kselftests     | 49   |      |          |      |   |      =
      | N/A |
| kselftests-cpufreq-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.c=
gz/x86_64-rhel-7.6-kselftests   | 1    |      |          |      |   |      =
      | N/A |
| kselftests-firmware-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.=
cgz/x86_64-rhel-7.6-kselftests  | 175  |      |          |      |   |      =
      | N/A |
+--------------------------------------------------------------------------=
------------------------------+------+------+----------+------+---+--------=
----+-----+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86=
_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.make_fail

kselftests-net-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86=
_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.make_fail
- kernel-selftests.net.tls.fail
- kernel-selftests.net.run_netsocktests.fail
- kernel-selftests.net.rtnetlink.sh.ipsec_offload_netdevsim_doesn't_support=
_ipsec_offload.fail
- kernel-selftests.net.rtnetlink.sh.fail
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.psock_snd.sh.fail
- kernel-selftests.net.udpgro_bench.sh.fail
- kernel-selftests.net.udpgro.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.fcnal-test.sh.fail
- kernel-selftests.net.icmp_redirect.sh.legacy_routing.ipv6:_redirect_excep=
tion.fail
- kernel-selftests.net.icmp_redirect.sh.legacy_routing.ipv6:_redirect_excep=
tion_plus_mtu.fail
- kernel-selftests.net.icmp_redirect.sh.legacy_routing.ipv6:_mtu_exception_=
plus_redirect.fail
- kernel-selftests.net.icmp_redirect.sh.legacy_routing_with_vrf.ipv6:_redir=
ect_exception.fail
- kernel-selftests.net.icmp_redirect.sh.legacy_routing_with_vrf.ipv6:_redir=
ect_exception_plus_mtu.fail
- kernel-selftests.net.icmp_redirect.sh.legacy_routing_with_vrf.ipv6:_mtu_e=
xception_plus_redirect.fail
- kernel-selftests.net.icmp_redirect.sh.routing_with_nexthop_objects.ipv6:_=
redirect_exception.fail
- kernel-selftests.net.icmp_redirect.sh.routing_with_nexthop_objects.ipv6:_=
redirect_exception_plus_mtu.fail
- kernel-selftests.net.icmp_redirect.sh.routing_with_nexthop_objects.ipv6:_=
mtu_exception_plus_redirect.fail
- kernel-selftests.net.icmp_redirect.sh.routing_with_nexthop_objects_and_vr=
f.ipv6:_redirect_exception.fail
- kernel-selftests.net.icmp_redirect.sh.routing_with_nexthop_objects_and_vr=
f.ipv6:_redirect_exception_plus_mtu.fail
- kernel-selftests.net.icmp_redirect.sh.routing_with_nexthop_objects_and_vr=
f.ipv6:_mtu_exception_plus_redirect.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail
- kernel-selftests.net.vrf_route_leaking.sh.IPv6_(sym_route):_VRF_ICMP_frag=
mentation_error_route_lookup_ping.Ping_received_ICMP_Packet_too_big.fail
- kernel-selftests.net.vrf_route_leaking.sh.fail

kselftests-netfilter-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.c=
gz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.netfilter.nft_concat_range.sh.fail

kselftests-kvm-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86=
_64-rhel-7.6-kselftests
---
- kernel-selftests.kvm.vmx_preemption_timer_test.fail


--===============5674971629894030143==--
