Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FB71
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 09:08:06 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lgkqa-0006N7-Rp; Wed, 12 May 2021 11:08:04 +0200
Date: Wed, 12 May 2021 11:08:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp
 receive path
Message-ID: <20210512090804.GI4038@breakpoint.cc>
References: <20210511133659.29982-1-fw@strlen.de>
 <20210511133659.29982-2-fw@strlen.de>
 <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Tue, 2021-05-11 at 15:36 +0200, Florian Westphal wrote:
> > The setting is only relevant for the msk socket.
> > While at it, also handle rcvlowat/rcvtimeo this way.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  net/mptcp/protocol.c | 7 +++++++
> >  net/mptcp/sockopt.c  | 8 ++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 652e55a0c6e8..86e599eb4403 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/atomic.h>
> >  #include <net/sock.h>
> > +#include <net/busy_poll.h>
> >  #include <net/inet_common.h>
> >  #include <net/inet_hashtables.h>
> >  #include <net/protocol.h>
> > @@ -1982,6 +1983,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> >  	if (unlikely(flags & MSG_ERRQUEUE))
> >  		return inet_recv_error(sk, msg, len, addr_len);
> >  
> > +	if (sk_can_busy_loop(sk) &&
> > +	    skb_queue_empty_lockless(&msk->receive_queue) &&
> > +	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> > +	    inet_sk_state_load(sk) == TCP_ESTABLISHED)
> > +		sk_busy_loop(sk, nonblock);
> 
> If I understand the code correctly, here we need a valid sk-
> >sk_napi_id. That field is set by the TCP input path
> in tcp_finish_connect()/tcp_v{4,6}_do_rcv()/tcp_child_process() for the
> subflow ssk.

Can this patch just be dropped from the series?
