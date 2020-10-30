Content-Type: multipart/mixed; boundary="===============5706863724390657235=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Weekly meeting - 29 October 2020 /!\ 16:00 /!\ UTC (9am
 PDT, 5pm CET, 12pm CST)
Date: Fri, 30 Oct 2020 11:16:26 +0800
Message-ID: <CA+WQbwucWOZ4q19u=9hOU+0_cxWBVWnP8G+NUpBtYE158dDpew@mail.gmail.com>
In-Reply-To: 9abef8b9-3678-0024-487f-16e170dc24ba@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 6483

--===============5706863724390657235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

Sorry I missed yesterday's meeting, here are my answers for the two
questions related to me:

> 1389827: New: [mptcp-next] mptcp: add mptcp_pm_should_add_signal_echo hel=
per:
>     - New helper (nice) but unclear why it is alone.
>     - is it to be squashed earlier?
>     - is it to be applied before another one already in the export branch?

This patch is a cleanup for the commit "mptcp: change add_addr_signal type"
in the export branch. It is for the "ADD_ADDR IPv6 support" series, so I di=
dn't
put it in the "ADD_ADDR: ports support" patchset.

It is better to squash this patch to the original commit. So I just
sent out a new
version of it to ML as:

[PATCH v2 mptcp-next] Squash to "mptcp: change add_addr_signal type"

> 1389851: New: [mptcp-next,1/8] mptcp: add ADD_ADDR port support for writi=
ng options
> 1389852: New: [mptcp-next,2/8] mptcp: add the outgoing ADD_ADDR port supp=
ort
> 1389853: New: [mptcp-next,3/8] mptcp: send out ack for ADD_ADDR with port
> 1389854: New: [mptcp-next,4/8] mptcp: add port argument for mptcp_pm_anno=
unce_addr
> 1389855: New: [mptcp-next,5/8] mptcp: add the incoming ADD_ADDR port supp=
ort
> 1389856: New: [mptcp-next,6/8] mptcp: add ADD_ADDR port support for netli=
nk
> 1389857: New: [mptcp-next,7/8] selftests: mptcp: add ADD_ADDR port suppor=
t for pm_nl_ctl
> 1389858: New: [mptcp-next,8/8] selftests: mptcp: add testcases for ADD_AD=
DR with port:
>     - to be reviewed
>     - seems the cover-letter was not sent to the ML

I have just resent the cover-letter to the ML as:

"[RESEND][MPTCP][PATCH mptcp-next 0/8] ADD_ADDR: ports support"

Hope it can be received this time.

Anyway, I paste it here too:

"""
Subject: [RESEND][MPTCP][PATCH mptcp-next 0/8] ADD_ADDR: ports support

This series is the first version of ADD_ADDR ports support. I have solved
the listener problem which I mentioned at the meeting on 15th of October
by adding a new listening socket from the userspace (see patch 8). Up to
now this patchset works well.

TODO:
I added 2 octets padding in ADD_ADDR port suboption for alignment. (see
patch 1). We need to drop this padding.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/54

Geliang Tang (8):
  mptcp: add ADD_ADDR port support for writing options
  mptcp: add the outgoing ADD_ADDR port support
  mptcp: send out ack for ADD_ADDR with port
  mptcp: add port argument for mptcp_pm_announce_addr
  mptcp: add the incoming ADD_ADDR port support
  mptcp: add ADD_ADDR port support for netlink
  selftests: mptcp: add ADD_ADDR port support for pm_nl_ctl
  selftests: mptcp: add testcases for ADD_ADDR with port

 include/net/mptcp.h                           |  1 +
 net/mptcp/options.c                           | 80 +++++++++++++++----
 net/mptcp/pm.c                                | 14 ++--
 net/mptcp/pm_netlink.c                        | 28 +++++--
 net/mptcp/protocol.h                          | 31 ++++---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 26 +++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 18 +++++
 7 files changed, 162 insertions(+), 36 deletions(-)

-- =

2.26.2
"""

Thanks.

-Geliang

Matthieu Baerts <matthieu.baerts(a)tessares.net> =E4=BA=8E2020=E5=B9=B410=
=E6=9C=8829=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:12=E5=86=99=E9=
=81=93=EF=BC=9A



>
> Hello everybody!
>
> Our public MPTCP upstreaming weekly web conference is scheduled for
> tomorrow.
>
> The list of topics is available here:
> https://annuel2.framapad.org/p/mptcp_upstreaming_20201029
>
> Feel free to add/modify topics!
>
> Anybody can join the meeting using Google Meet website/app/phone:
> https://meet.google.com/edk-rkrk-vaj
>
> Speak to you tomorrow!
> Matt
> --
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============5706863724390657235==--
