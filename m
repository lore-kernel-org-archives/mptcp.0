Content-Type: multipart/mixed; boundary="===============0054655626030373615=="
MIME-Version: 1.0
From: Philip Li <philip.li at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [kselftest UNSTABLE] mptcp/export 531346f5a4 ("tcp:
 mptcp: use mptcp receive buffer space to select rcv window")
Date: Fri, 17 Apr 2020 09:29:20 +0800
Message-ID: <20200417012920.GB27206@intel.com>
In-Reply-To: alpine.OSX.2.22.394.2004160930310.50963@ajherdri-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4194

--===============0054655626030373615==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 09:38:53AM -0700, Mat Martineau wrote:
> =

> Philip,
> =

> On Tue, 14 Apr 2020, kernel test robot wrote:
> =

> > =

> > LINUX COMMIT
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > commit : 531346f5a4531ca65fade2ec1d4c5beea97e5864
> > subject: tcp: mptcp: use mptcp receive buffer space to select rcv window
> > date   : 2020-04-09 09:17:34 +0800
> > author : Florian Westphal <fw(a)strlen.de>
> > =

> > =

> > Test status of 531346f5a4531ca65fade2ec1d4c5beea97e5864 (compared to v5=
.6)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +----------------------------------------------------------------------=
---------+------+------+----------+------+---+------------+-----+
> > |                                                                      =
         | pass | fail | unstable | skip | - | regression | fix |
> > | kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-ksel=
ftests   | 42   | 7    |          | 3    |   |            |     |
> > | kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-ks=
elftests | 3    |      |          |      |   |            |     |
> > +----------------------------------------------------------------------=
---------+------+------+----------+------+---+------------+-----+
> > =

> > Fails
> > =3D=3D=3D=3D=3D
> > kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-kselft=
ests
> > ---
> > - kernel-selftests.bpf.test_progs.fail
> > - kernel-selftests.bpf.test_align.fail
> > - kernel-selftests.bpf.test_btf.fail
> > - kernel-selftests.bpf.test_sysctl.fail
> > - kernel-selftests.bpf.test_progs-no_alu32.fail
> > - kernel-selftests.bpf.test_bpftool.sh.fail
> > - kernel-selftests.bpf.test_tc_edt.sh.fail
> > =

> =

> Are these failures also present on net-next or Linus' 5.7-rc1+ tree? The
> message does say the test status is compared to v5.6, but the mptcp tree =
has
> only minor changes from net-next right now so it seems like there may be
> underlying problems not related to mptcp.
Hi Mat, we will follow up to provide test data.

Currently, if the fail is not regression, which means failsure is also exis=
ted
on v5.6. The cause can be our test environment, we will continue to solving=
 them
to avoid confusion.

> =

> Thanks for sharing the test status for the mptcp repo!
You are welcome!

> =

> =

> --
> Mat Martineau
> Intel
--===============0054655626030373615==--
