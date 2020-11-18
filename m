Content-Type: multipart/mixed; boundary="===============8683025071980968948=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 00/13] ADD_ADDR: ports support
Date: Wed, 18 Nov 2020 20:24:56 +0800
Message-ID: <CA+WQbwuW0n-1giRdoeCgH-=TXh-D35DhYNqtd8479oYRDWUMnw@mail.gmail.com>
In-Reply-To: 25dde319-19f3-75c8-feb0-6236e5b86678@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6773

--===============8683025071980968948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat & Matt,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
11=E6=9C=8812=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=889:49=E5=86=99=E9=
=81=93=EF=BC=9A



>
>
> On Tue, 10 Nov 2020, Geliang Tang wrote:
>
> > v4:
> > - hold msk->pm.lock in mptcp_pm_sport_in_anno_list.
> > - Merge the patchset 'Squash to "ADD_ADDR: ports support v3"' into v4.
>
> Thanks for the fixes in v4. In last week's meeting there was a
> conversation about this patch series and the best way to handle additional
> ports. I think it will be good to talk about that some more this week and
> how to coordinate that with merging the series to the export branch and
> (later) net-next.
>

Hi Mat & Matt,

I want to split this patchset into two parts.

Part 1, includes patch 1 to patch 8, is the basic for ADD_ADDR ports
support. This part is ready for upstreaming. So please apply them into the
export branch.

Part 2, includes patch 9 to patch 13, is for the testcases of ADD_ADDR
ports support. This part still needs to be improved, like adding the
listening socket in the kernel space. I'll send out the new iteration of
part 2 recently.

Thanks.

-Geliang

>
> Mat
>
>
> >
> > v3:
> > - add two new patches, 8 and 11
> > - add more IS_ENABLED(CONFIG_MPTCP_IPV6) in patch 2
> > - define TCPOLEN_MPTCP_ADD_ADDR_HMAC in patch 4
> > - add flags check in patch 10
> > - update the testcases
> >
> > v2:
> > - change mptcp_out_options's port field in CPU bype order.
> > - keep mptcp_options_received's port field in CPU bype order.
> > - add two new patches to simplify ADD_ADDR suboption writing.
> > - update mptcp_add_addr_len helper use adding up size.
> > - add more commit messages.
> >
> > v1:
> > This series is the first version of ADD_ADDR ports support. I have solv=
ed
> > the listener problem which I mentioned at the meeting on 15th of October
> > by adding a new listening socket from the userspace (see patch 8). Up to
> > now this patchset works well.
> >
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/54
> >
> > Geliang Tang (13):
> >  mptcp: unify ADD_ADDR and echo suboptions writing
> >  mptcp: unify ADD_ADDR and ADD_ADDR6 suboptions writing
> >  mptcp: add port support for ADD_ADDR suboption writing
> >  mptcp: use adding up size to get ADD_ADDR length
> >  mptcp: add the outgoing ADD_ADDR port support
> >  mptcp: send out dedicated packet for ADD_ADDR using port
> >  mptcp: add port parameter for mptcp_pm_announce_addr
> >  mptcp: print out port and ahmac when receiving ADD_ADDR
> >  mptcp: add port number check for MP_JOIN
> >  mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
> >  selftests: mptcp: add port argument for pm_nl_ctl
> >  mptcp: add the mibs for ADD_ADDR with port
> >  selftests: mptcp: add testcases for ADD_ADDR with port
> >
> > include/net/mptcp.h                           |   1 +
> > net/mptcp/mib.c                               |   4 +
> > net/mptcp/mib.h                               |   4 +
> > net/mptcp/options.c                           | 107 +++++++++++-------
> > net/mptcp/pm.c                                |  14 ++-
> > net/mptcp/pm_netlink.c                        |  46 +++++++-
> > net/mptcp/protocol.h                          |  38 +++++--
> > net/mptcp/subflow.c                           |  37 ++++++
> > .../testing/selftests/net/mptcp/mptcp_join.sh | 103 ++++++++++++++++-
> > tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  24 +++-
> > 10 files changed, 313 insertions(+), 65 deletions(-)
> >
> > --
> > 2.26.2
> > _______________________________________________
> > mptcp mailing list -- mptcp(a)lists.01.org
> > To unsubscribe send an email to mptcp-leave(a)lists.01.org
> >
>
> --
> Mat Martineau
> Intel
--===============8683025071980968948==--
