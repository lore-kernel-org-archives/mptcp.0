Content-Type: multipart/mixed; boundary="===============2844085940318016851=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 5919910fd8 ("[DO-NOT-MERGE]
 mptcp: enabled by default") (fwd)
Date: Tue, 19 May 2020 09:49:43 -0700
Message-ID: <alpine.OSX.2.22.394.2005190945510.18759@dnlloyd-mobl.amr.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4422

--===============2844085940318016851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Here's the latest kselftest update from the kbuild project.

I asked the kbuild team about only sending failures to mptcp(a)lists.01.org=
, =

but they aren't set up to do that. They're sending the reports to me now, =

and I'll forward the non-success results (like this one) to the list.

Mat


---------- Forwarded message ----------
Date: Tue, 19 May 2020 04:02:01
From: kernel test robot <lkp(a)intel.com>
To: mathew.j.martineau(a)linux.intel.com
Subject: [kselftest UNSTABLE] mptcp/export 5919910fd8
     ("[DO-NOT-MERGE] mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/113/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 5919910fd8e760ff50fe09cbac607e55b2eb380c
subject: [DO-NOT-MERGE] mptcp: enabled by default
date   : 2020-05-19 09:06:39 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of 5919910fd8e760ff50fe09cbac607e55b2eb380c (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-----------------------+------+------+----------+------+---+------------+--=
---+
|                                                                          =
                       | pass | fail | unstable | skip | - | regression | f=
ix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts                     | 2015 | 16   |          | 4    |   |            |  =
   |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 33   | 8    |          | 1    |   |            |=
     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests                   | 3    |      |          |      |   |            |  =
   |
| kselftests-cpufreq-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests | 1    |      |          |      |   |            |=
     |
| kselftests-kvm-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests     | 20   |      |          | 1    |   |            |=
     |
+--------------------------------------------------------------------------=
-----------------------+------+------+----------+------+---+------------+--=
---+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.bpf_iter.fail
- kernel-selftests.bpf.test_progs.link_pinning.fail
- kernel-selftests.bpf.test_progs.pinning.fail
- kernel-selftests.bpf.test_progs.test_lsm.fail
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.packet_variable_offset.fail
- kernel-selftests.bpf.test_align.packet_variable_offset_2.fail
- kernel-selftests.bpf.test_align.dubious_pointer_arithmetic.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_progs-no_alu32.bpf_iter.fail
- kernel-selftests.bpf.test_progs-no_alu32.link_pinning.fail
- kernel-selftests.bpf.test_progs-no_alu32.pinning.fail
- kernel-selftests.bpf.test_progs-no_alu32.test_lsm.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail
- kernel-selftests.bpf.test_offload.py.fail
- kernel-selftests.bpf.test_lwt_ip_encap.sh.fail

kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64-r=
hel-7.6-kselftests
---
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.so_txtime.sh.fail
- kernel-selftests.net.fib_nexthop_multiprefix.sh.fail
- kernel-selftests.net.altnames.sh.fail
- kernel-selftests.net.icmp_redirect.sh.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail


--===============2844085940318016851==--
