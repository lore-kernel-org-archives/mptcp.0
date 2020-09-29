Content-Type: multipart/mixed; boundary="===============3449100802787716790=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export d94d08e790 ("DO-NOT-MERGE:
 mptcp: enabled by default") (fwd)
Date: Tue, 29 Sep 2020 11:51:05 -0700
Message-ID: <alpine.OSX.2.23.453.2009291140420.18559@pengyang-mobl1.ccr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6099

--===============3449100802787716790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


The LKP project is sending updates again for test results. I will check =

out the failures, it's not clear how many are actually mptcp-related.

--
Mat Martineau
Intel

---------- Forwarded message ----------
Date: Tue, 29 Sep 2020 03:43:32
From: kernel test robot <lkp(a)intel.com>
To: mathew.j.martineau(a)linux.intel.com
Subject: [kselftest UNSTABLE] mptcp/export d94d08e790
     ("DO-NOT-MERGE: mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/282/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : d94d08e790ff5a06bb2e418870a1e1114ea8f277
subject: DO-NOT-MERGE: mptcp: enabled by default
date   : 2020-09-29 12:53:31 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of d94d08e790ff5a06bb2e418870a1e1114ea8f277 (compared to v5.8)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
------------------------------+------+------+----------+------+---+--------=
----+-----+
|                                                                          =
                              | pass | fail | unstable | skip | - | regress=
ion | fix |
| kselftests-bpf-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       |      | 1    |          |      |   |      =
      |     |
| kselftests-net-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 250  | 24   |          | 13   |   |      =
      |     |
| kselftests-netfilter-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603=
.cgz/x86_64-rhel-7.6-kselftests | 64   | 1    |          | 16   |   |      =
      |     |
| kselftests-kvm-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 20   | 2    |          | 1    |   |      =
      |     |
| kselftests-mptcp-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz=
/x86_64-rhel-7.6-kselftests     | 49   |      |          |      |   |      =
      |     |
| kselftests-cpufreq-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.c=
gz/x86_64-rhel-7.6-kselftests   | 1    |      |          |      |   |      =
      |     |
| kselftests-firmware-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.=
cgz/x86_64-rhel-7.6-kselftests  | 151  |      |          |      |   |      =
      |     |
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

kselftests-netfilter-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.c=
gz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.netfilter.nft_concat_range.sh.fail

kselftests-kvm-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86=
_64-rhel-7.6-kselftests
---
- kernel-selftests.kvm.vmx_preemption_timer_test.fail
- kernel-selftests.kvm.debug_regs.fail


--===============3449100802787716790==--
