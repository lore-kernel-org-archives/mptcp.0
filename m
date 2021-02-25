Content-Type: multipart/mixed; boundary="===============8116515523352620279=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/5] move to next addr when
 timeout
Date: Thu, 25 Feb 2021 10:52:24 +0800
Message-ID: <CA+WQbwuAfeYUW9-3X4kCV-xFvAsDyXrQhYTSaCVXHkdh-OeDBw@mail.gmail.com>
In-Reply-To: 82d53a8e-b27-6378-5e1-d766823f113f@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7950

--===============8116515523352620279==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2021=E5=B9=B4=
2=E6=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=8810:23=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Wed, 24 Feb 2021, Geliang Tang wrote:
>
> > v3:
> > - invoke lookup_subflow_by_daddr in mptcp_pm_nl_add_addr_received.
> > - add a new patch "drop argument port from mptcp_pm_announce_addr".
> >
> > v2:
> > - invoke lookup_subflow_by_daddr in mptcp_pm_add_addr_received, not in
> > mptcp_pm_nl_add_addr_received.
> > - add a sanity check on cfg_do_w.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/151
> >
> > Geliang Tang (5):
> >  mptcp: drop argument port from mptcp_pm_announce_addr
> >  mptcp: skip connecting the connected address
> >  mptcp: move to next addr when timeout
> >  selftests: mptcp: add cfg_do_w for cfg_remove
> >  selftests: mptcp: timeout testcases for multi addresses

This patch "mptcp: drop unused subflow in mptcp_pm_subflow_established" in
the export branch should be put in this patchset like this:

  mptcp: drop argument port from mptcp_pm_announce_addr
  mptcp: skip connecting the connected address
  mptcp: drop unused subflow in mptcp_pm_subflow_established
  mptcp: move to next addr when timeout
  selftests: mptcp: add cfg_do_w for cfg_remove
  selftests: mptcp: timeout testcases for multi addresses

But I sent it alone a few days earlier. Could you please help me to insert
it back into this patchset when merging them?

Thanks.

-Geliang

> >
> > net/mptcp/pm.c                                |  6 ++--
> > net/mptcp/pm_netlink.c                        | 35 +++++++++++++++----
> > net/mptcp/protocol.h                          |  2 +-
> > .../selftests/net/mptcp/mptcp_connect.c       | 10 ++++--
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++--
> > 5 files changed, 64 insertions(+), 15 deletions(-)
> >
> > --
> > 2.29.2
>
> Thanks Geliang, I think v3 is ready for the export branch.
>
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>
> --
> Mat Martineau
> Intel
--===============8116515523352620279==--
