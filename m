Content-Type: multipart/mixed; boundary="===============1412558811041228299=="
MIME-Version: 1.0
From: kernel test robot <lkp at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [kselftest UNSTABLE] mptcp/export 531346f5a4 ("tcp: mptcp:
 use mptcp receive buffer space to select rcv window")
Date: Tue, 14 Apr 2020 11:21:13 +0800
Message-ID: <5e952c29.hibd7Wq+qFFl5Fc6%lkp@intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4159

--===============1412558811041228299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


LINUX COMMIT
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
commit : 531346f5a4531ca65fade2ec1d4c5beea97e5864
subject: tcp: mptcp: use mptcp receive buffer space to select rcv window
date   : 2020-04-09 09:17:34 +0800
author : Florian Westphal <fw(a)strlen.de>


Test status of 531346f5a4531ca65fade2ec1d4c5beea97e5864 (compared to v5.6)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+--------------------------------------------------------------------------=
-----+------+------+----------+------+---+------------+-----+
|                                                                          =
     | pass | fail | unstable | skip | - | regression | fix |
| kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts   | 42   | 7    |          | 3    |   |            |     |
| kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests | 3    |      |          |      |   |            |     |
+--------------------------------------------------------------------------=
-----+------+------+----------+------+---+------------+-----+

Fails
=3D=3D=3D=3D=3D
kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftests
---
- kernel-selftests.bpf.test_progs.fail
- kernel-selftests.bpf.test_align.fail
- kernel-selftests.bpf.test_btf.fail
- kernel-selftests.bpf.test_sysctl.fail
- kernel-selftests.bpf.test_progs-no_alu32.fail
- kernel-selftests.bpf.test_bpftool.sh.fail
- kernel-selftests.bpf.test_tc_edt.sh.fail


--===============1412558811041228299==--
