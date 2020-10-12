Content-Type: multipart/mixed; boundary="===============4912609179286254633=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 94625945a1 ("DO-NOT-MERGE:
 mptcp: enabled by default") (fwd)
Date: Mon, 12 Oct 2020 08:14:57 -0700
Message-ID: <21762642-989c-6f9b-ad7-f3c884c5323e@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6291

--===============4912609179286254633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello everyone:

The most recent kbuild/LKP run does show a failure in the simult_flows.sh =

selftest. It did not appear in other recent builds from Friday or =

Saturday - might be intermittent.

Mat


---------- Forwarded message ----------
Date: Mon, 12 Oct 2020 04:06:47
From: kernel test robot <lkp(a)intel.com>
To: mathew.j.martineau(a)linux.intel.com
Subject: [kselftest UNSTABLE] mptcp/export 94625945a1
     ("DO-NOT-MERGE: mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/300/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 94625945a1f16c982455d57b1681236d65bb3acd
subject: DO-NOT-MERGE: mptcp: enabled by default
date   : 2020-10-12 13:08:12 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of 94625945a1f16c982455d57b1681236d65bb3acd (compared to v5.8)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
------------------------------+------+------+----------+------+---+--------=
----+-----+
|                                                                          =
                              | pass | fail | unstable | skip | - | regress=
ion | fix |
| kselftests-mptcp-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz=
/x86_64-rhel-7.6-kselftests     | 48   | 1    |          |      |   |      =
      |     |
| kselftests-bpf-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 1528 | 14   |          |      |   |      =
      |     |
| kselftests-net-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 252  | 21   |          | 15   |   |      =
      |     |
| kselftests-netfilter-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603=
.cgz/x86_64-rhel-7.6-kselftests | 64   | 1    |          | 16   |   |      =
      |     |
| kselftests-kvm-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests       | 21   | 1    |          | 1    |   |      =
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
kselftests-mptcp-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x=
86_64-rhel-7.6-kselftests
---
- kernel-selftests.net/mptcp.simult_flows.sh.fail

kselftests-bpf-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86=
_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.perf_event_stackmap.fail
- kernel-selftests.bpf.test_progs.test_bpffs.fail
- kernel-selftests.bpf.test_progs.test_local_storage.fail
- kernel-selftests.bpf.test_progs.test_lsm.fail
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_tcpbpf_user.fail
- kernel-selftests.bpf.test_progs-no_alu32.send_signal.fail
- kernel-selftests.bpf.test_progs-no_alu32.test_bpffs.fail
- kernel-selftests.bpf.test_progs-no_alu32.test_local_storage.fail
- kernel-selftests.bpf.test_progs-no_alu32.test_lsm.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail
- kernel-selftests.bpf.test_offload.py.fail
- kernel-selftests.bpf.test_flow_dissector.sh.fail
- kernel-selftests.bpf.test_bpftool.sh.fail

kselftests-net-ucode=3D0xdc/lkp-skl-d01/debian-10.4-x86_64-20200603.cgz/x86=
_64-rhel-7.6-kselftests
---
- kernel-selftests.net.tls.fail
- kernel-selftests.net.run_netsocktests.fail
- kernel-selftests.net.rtnetlink.sh.ipsec_offload_netdevsim_doesn't_support=
_ipsec_offload.fail
- kernel-selftests.net.rtnetlink.sh.fail
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.psock_snd.sh.fail
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


--===============4912609179286254633==--
