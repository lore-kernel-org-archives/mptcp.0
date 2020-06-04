Content-Type: multipart/mixed; boundary="===============2466935135031329683=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export ffa63ebeea ("[DO-NOT-MERGE]
 mptcp: enabled by default") (fwd)
Date: Thu, 04 Jun 2020 09:55:10 -0700
Message-ID: <alpine.OSX.2.22.394.2006040940070.40010@hpeled-mobl.ger.corp.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4585

--===============2466935135031329683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


I received the following kselftest results. The failures don't appear to =

be MPTCP-related, and there isn't much self test output in the logs. Still =

forwarding in case someone else would like to review.

Mat


---------- Forwarded message ----------
Date: Wed, 3 Jun 2020 04:54:16
From: kernel test robot <lkp(a)intel.com>
To: mathew.j.martineau(a)linux.intel.com
Subject: [kselftest UNSTABLE] mptcp/export ffa63ebeea
     ("[DO-NOT-MERGE] mptcp: enabled by default")

Check console output at http://bee.sh.intel.com:8080/job/lkp-mptcp/132/

LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : ffa63ebeea0697a99388d200e8d1bc10c0940fc2
subject: [DO-NOT-MERGE] mptcp: enabled by default
date   : 2020-06-03 16:35:14 +0800
author : Matthieu Baerts <matthieu.baerts(a)tessares.net>


Test status of ffa63ebeea0697a99388d200e8d1bc10c0940fc2 (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-------------------------+------+------+----------+------+---+------------+=
-----+
|                                                                          =
                         | pass | fail | unstable | skip | - | regression |=
 fix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts                       | 1598 | 15   |          | 4    |   |            |=
     |
| kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests       | 33   | 8    |          | 1    |   |           =
 |     |
| kselftests-netfilter-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/=
x86_64-rhel-7.6-kselftests | 7    | 1    |          |      |   |           =
 |     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests                     | 3    |      |          |      |   |            |=
     |
| kselftests-cpufreq-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests   | 1    |      |          |      |   |           =
 |     |
| kselftests-firmware-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x=
86_64-rhel-7.6-kselftests  | 1    |      |          |      |   |           =
 |     |
| kselftests-kvm-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64=
-rhel-7.6-kselftests       | 21   |      |          | 1    |   |           =
 |     |
+--------------------------------------------------------------------------=
-------------------------+------+------+----------+------+---+------------+=
-----+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.bpf_iter.fail
- kernel-selftests.bpf.test_progs.cls_redirect.fail
- kernel-selftests.bpf.test_progs.link_pinning.fail
- kernel-selftests.bpf.test_progs.pinning.fail
- kernel-selftests.bpf.test_progs.test_lsm.fail
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_progs-no_alu32.bpf_iter.fail
- kernel-selftests.bpf.test_progs-no_alu32.link_pinning.fail
- kernel-selftests.bpf.test_progs-no_alu32.pinning.fail
- kernel-selftests.bpf.test_progs-no_alu32.test_lsm.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail
- kernel-selftests.bpf.test_offload.py.fail
- kernel-selftests.bpf.test_lwt_ip_encap.sh.fail
- kernel-selftests.bpf.test_tc_edt.sh.fail

kselftests-net-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x86_64-r=
hel-7.6-kselftests
---
- kernel-selftests.net.fib_tests.sh.fail
- kernel-selftests.net.psock_snd.sh.fail
- kernel-selftests.net.test_vxlan_under_vrf.sh.fail
- kernel-selftests.net.fib_nexthop_multiprefix.sh.fail
- kernel-selftests.net.altnames.sh.fail
- kernel-selftests.net.icmp_redirect.sh.fail
- kernel-selftests.net.txtimestamp.sh.fail
- kernel-selftests.net.vrf-xfrm-tests.sh.fail

kselftests-netfilter-ucode=3D0xd6/lkp-skl-d01/debian-x86_64-20191114.cgz/x8=
6_64-rhel-7.6-kselftests
---
- kernel-selftests.netfilter.nft_concat_range.sh.fail


--===============2466935135031329683==--
