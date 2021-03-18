Content-Type: multipart/mixed; boundary="===============0231404780407150784=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 0/3] send ack for rm_addr and
 cleanups
Date: Thu, 18 Mar 2021 10:14:16 +0800
Message-ID: <CA+WQbwtZC4k9ZrGntF5neJzR4wQ8h9KUPfuLkZj1j-o1qFZi7w@mail.gmail.com>
In-Reply-To: 77d93daf-d7ec-f854-a594-f5bb8fed3c1@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 8205

--===============0231404780407150784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
3=E6=9C=8818=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=888:09=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Tue, 16 Mar 2021, Geliang Tang wrote:
>
> > v2:
> > - add patch 1 and patch 3.
> > - update the debug output in patch 2.
> > - tag: export/20210315T064655.
> >
> > Note:
> > - Please insert this patchset between the commit "mptcp: move to next
> > addr when subflow creation fail" and the commit "selftests: mptcp: sign=
al
> > addresses testcases" when merging it.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/173
> >
> > Geliang Tang (3):
> >  mptcp: drop useless addr_signal clear
> >  mptcp: send ack for rm_addr
> >  mptcp: rename mptcp_pm_nl_add_addr_send_ack
> >
> > net/mptcp/pm.c         |  1 +
> > net/mptcp/pm_netlink.c | 24 ++++++++----------------
> > net/mptcp/protocol.h   |  1 +
> > 3 files changed, 10 insertions(+), 16 deletions(-)
> >
> > --
> > 2.30.2
>
> Geliang -
>
> Thanks for pointing out the dependency I missed when testing. Patch set
> looks good for the export branch.
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Please insert this patchset between the commit "mptcp: move to next
addr when subflow creation fail" and the commit "selftests: mptcp: signal
addresses testcases" when merging it into the export branch.

Thanks.

-Geliang

>
> --
> Mat Martineau
> Intel
--===============0231404780407150784==--
