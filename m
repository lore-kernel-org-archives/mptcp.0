Content-Type: multipart/mixed; boundary="===============7822812762370002181=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 00/13] ADD_ADDR: ports support
Date: Wed, 11 Nov 2020 17:49:25 -0800
Message-ID: <25dde319-19f3-75c8-feb0-6236e5b86678@linux.intel.com>
In-Reply-To: cover.1604984546.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6665

--===============7822812762370002181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 10 Nov 2020, Geliang Tang wrote:

> v4:
> - hold msk->pm.lock in mptcp_pm_sport_in_anno_list.
> - Merge the patchset 'Squash to "ADD_ADDR: ports support v3"' into v4.

Thanks for the fixes in v4. In last week's meeting there was a =

conversation about this patch series and the best way to handle additional =

ports. I think it will be good to talk about that some more this week and =

how to coordinate that with merging the series to the export branch and =

(later) net-next.


Mat


>
> v3:
> - add two new patches, 8 and 11
> - add more IS_ENABLED(CONFIG_MPTCP_IPV6) in patch 2
> - define TCPOLEN_MPTCP_ADD_ADDR_HMAC in patch 4
> - add flags check in patch 10
> - update the testcases
>
> v2:
> - change mptcp_out_options's port field in CPU bype order.
> - keep mptcp_options_received's port field in CPU bype order.
> - add two new patches to simplify ADD_ADDR suboption writing.
> - update mptcp_add_addr_len helper use adding up size.
> - add more commit messages.
>
> v1:
> This series is the first version of ADD_ADDR ports support. I have solved
> the listener problem which I mentioned at the meeting on 15th of October
> by adding a new listening socket from the userspace (see patch 8). Up to
> now this patchset works well.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/54
>
> Geliang Tang (13):
>  mptcp: unify ADD_ADDR and echo suboptions writing
>  mptcp: unify ADD_ADDR and ADD_ADDR6 suboptions writing
>  mptcp: add port support for ADD_ADDR suboption writing
>  mptcp: use adding up size to get ADD_ADDR length
>  mptcp: add the outgoing ADD_ADDR port support
>  mptcp: send out dedicated packet for ADD_ADDR using port
>  mptcp: add port parameter for mptcp_pm_announce_addr
>  mptcp: print out port and ahmac when receiving ADD_ADDR
>  mptcp: add port number check for MP_JOIN
>  mptcp: deal with MPTCP_PM_ADDR_ATTR_PORT in PM netlink
>  selftests: mptcp: add port argument for pm_nl_ctl
>  mptcp: add the mibs for ADD_ADDR with port
>  selftests: mptcp: add testcases for ADD_ADDR with port
>
> include/net/mptcp.h                           |   1 +
> net/mptcp/mib.c                               |   4 +
> net/mptcp/mib.h                               |   4 +
> net/mptcp/options.c                           | 107 +++++++++++-------
> net/mptcp/pm.c                                |  14 ++-
> net/mptcp/pm_netlink.c                        |  46 +++++++-
> net/mptcp/protocol.h                          |  38 +++++--
> net/mptcp/subflow.c                           |  37 ++++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 103 ++++++++++++++++-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  24 +++-
> 10 files changed, 313 insertions(+), 65 deletions(-)
>
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============7822812762370002181==--
