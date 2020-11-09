Content-Type: multipart/mixed; boundary="===============0549267081962063634=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 4d7fed49af ("DO-NOT-MERGE:
 mptcp: enabled by default") (fwd)
Date: Mon, 09 Nov 2020 14:31:45 -0800
Message-ID: <61b9edf-4c43-a249-ec6a-58a2f7f2f960@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6616

--===============0549267081962063634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone -

The LKP builds have resumed, here's the most recent status.

I have asked about getting some logs for the mptcp_join.sh failure that we =

see intermittently with the LKP automation.

Mat


---------- Forwarded message ----------
Date: Sun, 8 Nov 2020 23:19:04
From: kernel test robot <lkp(a)intel.com>
Subject: [kselftest UNSTABLE] mptcp/export 4d7fed49af
     ("DO-NOT-MERGE: mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/318/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 4d7fed49af880e263dd31b6fe86ae88de8b5662a
subject: DO-NOT-MERGE: mptcp: enabled by default
date   : 2020-11-08 14:09:49 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of 4d7fed49af (compared to v5.9)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
------------------------------+------+------+----------+------+---+--------=
----+-----+
|                                                                          =
                              | pass | fail | unstable | skip | - | regress=
ion | fix |
| kselftests-mptcp-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz=
/x86_64-rhel-7.6-kselftests     | 48   | 1    |          |      |   | N/A  =
      | N/A |
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
kselftests-mptcp-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests
---
- kernel-selftests.net/mptcp.mptcp_join.sh.fail

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


--===============0549267081962063634==--
