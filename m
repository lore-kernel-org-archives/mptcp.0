Content-Type: multipart/mixed; boundary="===============2894140954701618940=="
MIME-Version: 1.0
From: Philip Li <philip.li at intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [kselftest UNSTABLE] mptcp/export 531346f5a4 ("tcp:
 mptcp: use mptcp receive buffer space to select rcv window")
Date: Tue, 21 Apr 2020 09:32:14 +0800
Message-ID: <20200421013214.GA6996@intel.com>
In-Reply-To: 20200417012920.GB27206@intel.com
X-Status: 
X-Keywords:                  
X-UID: 4209

--===============2894140954701618940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2020 at 09:29:20AM +0800, Philip Li wrote:
> On Thu, Apr 16, 2020 at 09:38:53AM -0700, Mat Martineau wrote:
> > =

> > Philip,
> > =

> > On Tue, 14 Apr 2020, kernel test robot wrote:
> > =

> > > =

> > > LINUX COMMIT
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > commit : 531346f5a4531ca65fade2ec1d4c5beea97e5864
> > > subject: tcp: mptcp: use mptcp receive buffer space to select rcv win=
dow
> > > date   : 2020-04-09 09:17:34 +0800
> > > author : Florian Westphal <fw(a)strlen.de>
> > > =

> > > =

> > > Test status of 531346f5a4531ca65fade2ec1d4c5beea97e5864 (compared to =
v5.6)
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > +--------------------------------------------------------------------=
-----------+------+------+----------+------+---+------------+-----+
> > > |                                                                    =
           | pass | fail | unstable | skip | - | regression | fix |
> > > | kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-ks=
elftests   | 42   | 7    |          | 3    |   |            |     |
> > > | kselftests-mptcp/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-=
kselftests | 3    |      |          |      |   |            |     |
> > > +--------------------------------------------------------------------=
-----------+------+------+----------+------+---+------------+-----+
> > > =

> > > Fails
> > > =3D=3D=3D=3D=3D
> > > kselftests-bpf/vm-snb/debian-x86_64-20191114.cgz/x86_64-rhel-7.6-ksel=
ftests
> > > ---
> > > - kernel-selftests.bpf.test_progs.fail
> > > - kernel-selftests.bpf.test_align.fail
> > > - kernel-selftests.bpf.test_btf.fail
> > > - kernel-selftests.bpf.test_sysctl.fail
> > > - kernel-selftests.bpf.test_progs-no_alu32.fail
> > > - kernel-selftests.bpf.test_bpftool.sh.fail
> > > - kernel-selftests.bpf.test_tc_edt.sh.fail
> > > =

> > =

> > Are these failures also present on net-next or Linus' 5.7-rc1+ tree? The
> > message does say the test status is compared to v5.6, but the mptcp tre=
e has
> > only minor changes from net-next right now so it seems like there may be
> > underlying problems not related to mptcp.
> Hi Mat, we will follow up to provide test data.
Hi Mat, we had checked test status on v5.7-rc1, which has the below failures

  "kernel-selftests.bpf.test_progs.fail": [
  "kernel-selftests.bpf.test_align.fail": [
  "kernel-selftests.bpf.test_tcpbpf_user.fail": [	<=3D=3D new in v5.7-rc1
  "kernel-selftests.bpf.test_btf.fail": [
  "kernel-selftests.bpf.test_sysctl.fail": [
  "kernel-selftests.bpf.test_progs-no_alu32.fail": [
  "kernel-selftests.bpf.test_bpftool.sh.fail": [
  "kernel-selftests.bpf.test_tc_edt.sh.pass"		<=3D=3D pass in v5.7-rc1

v5.7-rc1 had extra "kernel-selftests.bpf.test_tcpbpf_user.fail", but with
kernel-selftests.bpf.test_tc_edt.sh.pass, which failed in 531346f5a4531c he=
re.

We haven't root caused them yet, will plan some effort to see whether the t=
est
is stable and try to resolve other failure if it is env issue.

Thanks

> =

> Currently, if the fail is not regression, which means failsure is also ex=
isted
> on v5.6. The cause can be our test environment, we will continue to solvi=
ng them
> to avoid confusion.
> =

> > =

> > Thanks for sharing the test status for the mptcp repo!
> You are welcome!
> =

> > =

> > =

> > --
> > Mat Martineau
> > Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============2894140954701618940==--
