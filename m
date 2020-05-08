Content-Type: multipart/mixed; boundary="===============5380701779007616937=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 0/7] mptcp: don't sleep on ssk with msk
 lock held
Date: Thu, 07 May 2020 18:52:45 -0700
Message-ID: <alpine.OSX.2.22.394.2005071840070.63842@msavoy-mobl.amr.corp.intel.com>
In-Reply-To: 20200506130228.1478-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4349

--===============5380701779007616937==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 6 May 2020, Florian Westphal wrote:

> This series reworks mptcp_sendmsg logic to avoid blocking on the subflow
> socket in an attempt to address/resolve:
> https://github.com/multipath-tcp/mptcp_net-next/issues/7
>
> It does so by removing the wait loop from mptcp_sendmsg_frag helper.
>
> In order to do that, it moves prerequisites into the callers.
>
> The worker can just reschedule in case no subflow socket is ready.
>
> The sendmsg path can use the existing wait logic.
>
> Because large send requests can result in multiple mptcp_sendmsg_frag
> calls from mptcp_sendmsg, we may need to restart the socket lookup in
> case subflow can't accept more data or memory is low.
>
> Doing so blocks on the mptcp socket, and existing wait handling
> releases the msk lock while blocking.
>
> Lastly, no need to use ATOMIC allocations for extension allocation,
> so allow to pass gfp_t arg to the helper instead of hard-coded ATOMIC
> in the core.
>
> Comments welcome.
>

After looking over the rest of the series I don't have other changes to =

suggest, series looks good. Thanks for the clarification in Paolo's =

thread.

Mat


> Florian Westphal (7):
>      mptcp: avoid blocking in tcp_sendpages
>      mptcp: make sure timer is inited/started once data is pending for tr=
ansmission
>      mptcp: avoid blocking in tcp_sendpages due to skb alloc
>      mptcp: fill skb extension cache outside of mptcp_sendmsg_frag
>      mptcp: fill skb page frag cache outside of mptcp_sendmsg_frag
>      mptcp: remove inner wait loop from mptcp_sendmsg_frag
>      net: allow __skb_ext_alloc to sleep
>
> include/linux/skbuff.h |   2 +-
> net/core/skbuff.c      |   8 ++--
> net/mptcp/protocol.c   | 100 ++++++++++++++++++++++++++++++++++++--------=
-----
> 3 files changed, 81 insertions(+), 29 deletions(-)

--
Mat Martineau
Intel
--===============5380701779007616937==--
