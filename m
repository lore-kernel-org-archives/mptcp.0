Content-Type: multipart/mixed; boundary="===============5396488517065838857=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [kselftest UNSTABLE] mptcp/export 531346f5a4 ("tcp:
 mptcp: use mptcp receive buffer space to select rcv window")
Date: Thu, 16 Apr 2020 09:38:53 -0700
Message-ID: <alpine.OSX.2.22.394.2004160930310.50963@ajherdri-mobl.amr.corp.intel.com>
In-Reply-To: 5e952c29.hibd7Wq+qFFl5Fc6%lkp@intel.com
X-Status: 
X-Keywords:                  
X-UID: 4192

--===============5396488517065838857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Philip,

On Tue, 14 Apr 2020, kernel test robot wrote:

>
> LINUX COMMIT
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> commit : 531346f5a4531ca65fade2ec1d4c5beea97e5864
> subject: tcp: mptcp: use mptcp receive buffer space to select rcv window
> date   : 2020-04-09 09:17:34 +0800
> author : Florian Westphal <fw(a)strlen.de>
>
>
> Test status of 531346f5a4531ca65fade2ec1d4c5beea97e5864 (compared to v5.6)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +------------------------------------------------------------------------=
-------+------+------+----------+------+---+------------+-----+
> |                                                                        =
       | pass | fail | unstable | skip | - | regression | fix |
> | kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests   | 42   | 7    |          | 3    |   |            |     |
> | kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-ksel=
ftests | 3    |      |          |      |   |            |     |
> +------------------------------------------------------------------------=
-------+------+------+----------+------+---+------------+-----+
>
> Fails
> =3D=3D=3D=3D=3D
> kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselftes=
ts
> ---
> - kernel-selftests.bpf.test_progs.fail
> - kernel-selftests.bpf.test_align.fail
> - kernel-selftests.bpf.test_btf.fail
> - kernel-selftests.bpf.test_sysctl.fail
> - kernel-selftests.bpf.test_progs-no_alu32.fail
> - kernel-selftests.bpf.test_bpftool.sh.fail
> - kernel-selftests.bpf.test_tc_edt.sh.fail
>

Are these failures also present on net-next or Linus' 5.7-rc1+ tree? The =

message does say the test status is compared to v5.6, but the mptcp tree =

has only minor changes from net-next right now so it seems like there may =

be underlying problems not related to mptcp.

Thanks for sharing the test status for the mptcp repo!


--
Mat Martineau
Intel
--===============5396488517065838857==--
