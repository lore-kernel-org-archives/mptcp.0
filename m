Content-Type: multipart/mixed; boundary="===============5149509167718607826=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/2] Squash-to: "mptcp:
 remove addr and subflow in PM netlink v9"
Date: Wed, 16 Sep 2020 10:37:10 +0800
Message-ID: <CA+WQbwv=gPBHpB-2QQtxV7qA=QWU_2Pg_c9anj02Vq8SiLHAKA@mail.gmail.com>
In-Reply-To: 92808529-48b6-7680-a982-1eca0fb0710e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5890

--===============5149509167718607826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt, Paolo,

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B49=E6=
=9C=8816=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi Geliang, Paolo,
>
> On 15/09/2020 15:04, Paolo Abeni wrote:
> > On Tue, 2020-09-15 at 19:59 +0800, Geliang Tang wrote:
> >> v3:
> >>   - use "goto next" in mptcp_nl_remove_subflow_and_signal_addr
> >>   - update mptcp_destroy_common
> >>
> >> v2:
> >>   - add mptcp_pm_remove_anno_addr and update logic in
> >>   mptcp_nl_remove_subflow_and_signal_addr
> >>   - call mptcp_pm_free_anno_list in mptcp_destroy and mptcp_sock_destr=
uct
> >>   - add mptcp_destroy_common helper
> >>
> >> Geliang Tang (2):
> >>    Squash-to: "mptcp: remove addr and subflow in PM netlink"
> >>    mptcp: add mptcp_destroy_common helper
> >>
> >>   net/mptcp/pm.c         |  1 +
> >>   net/mptcp/pm_netlink.c | 91 +++++++++++++++++++++++++++++++++++++++-=
--
> >>   net/mptcp/protocol.c   | 10 ++++-
> >>   net/mptcp/protocol.h   |  3 ++
> >>   net/mptcp/subflow.c    |  3 +-
> >>   5 files changed, 98 insertions(+), 10 deletions(-)
> >>
> >
> > Both patches LGTM, thanks!
>
> Thank you for the patches and the review!
>
> Just to be sure, can I squash the two of them in the same "mptcp: remove
> addr and subflow in PM netlink" commit? (+ update the commit message as
> written in 1/2 patch)

Please only squash 1/2 patch to "mptcp: remove addr and subflow in PM netli=
nk"
commit. And apply patch 2/2 (mptcp: add mptcp_destroy_common helper) as a
new commit.

Thanks.
-Geliang


>
> Cheers,
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
--===============5149509167718607826==--
