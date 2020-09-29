Content-Type: multipart/mixed; boundary="===============7313988344005697055=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/9] mptcp: support for queuing data at
 mptcp-level
Date: Mon, 28 Sep 2020 18:10:13 -0700
Message-ID: <alpine.OSX.2.23.453.2009281808380.6674@kemeng-mobl1.amr.corp.intel.com>
In-Reply-To: cover.1601304622.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6088

--===============7313988344005697055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 28 Sep 2020, Paolo Abeni wrote:

> This is necessary to cope correctly with large sendbuffer (larger then sn=
d wnd)
> while respecting the MPTCP level snd window.
>
> A major rework of both xmit and shudown path is required to support this
> feature (patches 6 and 7). To try to keep the related patches as small as
> possible, a bunch of new helpers is created by patches 1-5.
> Note that patch 3 can stand for it's own merit and possibly be upstreamed=
 soon.
>
> Finally patch 8 uses the MPTCP equivalent of tcp_push_pending_frames(), to
> spool queued data ad MPTCP level, as soon as the windows allow that.
>
> This iteration includes all the fixes mentioned in the ML on top of the R=
FC,
> plus some mores - all noted in the individual patches changelog. It also
> includes the sndwnd patch from Florian, rebased.
>
> Still not bugs free - I see some not-so-frequent timeouts in mptcp_connec=
t.sh
> tests and tput in simult_xmit tests are less stable, but should be notably
> better than previous iteration. I suggest considering for merge on the ex=
port
> branch.

I had a couple of questions on patch 6, and also reviewed the rest. I'm ok =

with merging on the export branch if that works ok with other patches that =

will get sent to net-next before it closes for the 5.10 merge window.

Mat


>
> Not strictily related to this series: we currently send DATA_FIN ack only=
 once
> - the behaviour is not change here. If that is dropped, we will never
> retransmit, and the peer will be stuck.
>
> Florian Westphal (1):
>  mptcp: keep track of advertised windows right edge
>
> Paolo Abeni (8):
>  tcp: factor out __tcp_close() helper
>  mptcp: introduce mptcp_schedule_work
>  mptcp: reduce the arguments of mptcp_sendmsg_frag
>  mptcp: add accounting for pending data
>  mptcp: introduce MPTCP snd_nxt
>  mptcp: refactor shutdown and close
>  mptcp: move page frag allocation in mptcp_sendmsg()
>  mptcp: try to push pending data on snd una updates
>
> include/net/tcp.h    |   1 +
> net/ipv4/tcp.c       |   9 +-
> net/mptcp/options.c  |  24 +-
> net/mptcp/pm.c       |   4 +-
> net/mptcp/protocol.c | 783 +++++++++++++++++++++++++------------------
> net/mptcp/protocol.h |  67 +++-
> net/mptcp/subflow.c  |  21 +-
> 7 files changed, 560 insertions(+), 349 deletions(-)
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
--===============7313988344005697055==--
