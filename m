Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6272
	for <mptcp@lists.linux.dev>; Wed, 10 Nov 2021 10:17:35 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mkkfc-0001R4-Vv; Wed, 10 Nov 2021 11:17:33 +0100
Date: Wed, 10 Nov 2021 11:17:32 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] mptcp: add TCP_INQ cmsg support
Message-ID: <20211110101732.GE16363@breakpoint.cc>
References: <20211108105711.16200-1-fw@strlen.de>
 <20211108105711.16200-2-fw@strlen.de>
 <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add0921a-4ce2-a3d4-d4d-442d4e88365f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Mon, 8 Nov 2021, Florian Westphal wrote:
> 
> > Support the TCP_INQ setsockopt.
> > This is a boolean that tells recvmsg path to include the remaining
> > in-sequence bytes into a cmsg data.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/224
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> > net/mptcp/protocol.c | 33 +++++++++++++++++++++++++++++++++
> > net/mptcp/protocol.h |  1 +
> > net/mptcp/sockopt.c  | 37 +++++++++++++++++++++++++++++++++++++
> > 3 files changed, 71 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index b0bfe20d6bb0..b4263bf821ac 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -46,6 +46,7 @@ struct mptcp_skb_cb {
> > 
> > enum {
> > 	MPTCP_CMSG_TS = BIT(0),
> > +	MPTCP_CMSG_INQ = BIT(1),
> > };
> > 
> > static struct percpu_counter mptcp_sockets_allocated;
> > @@ -2006,6 +2007,29 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> > 	return !skb_queue_empty(&msk->receive_queue);
> > }
> > 
> > +static unsigned int mptcp_inq_hint(const struct sock *sk)
> > +{
> > +	const struct mptcp_sock *msk = mptcp_sk(sk);
> > +	const struct sk_buff *skb;
> > +	u64 acked = msk->ack_seq;
> > +	u64 hint_val = 0;
> > +
> > +	skb = skb_peek(&msk->receive_queue);
> > +	if (skb) {
> > +		u64 map_seq = MPTCP_SKB_CB(skb)->map_seq + MPTCP_SKB_CB(skb)->offset;
> 
> MPTCP_SKB_CB(skb)->offset is an offset within the skb payload, not related
> to the map_seq.
> 
> I think MPTCP_SKB_CB(skb)->end_seq has the sequence number you need for
> hint_val?

I don't think so.

INQ should return all bytes that are still pending for read().

ack_seq is the largest in-sequence number we've seen, so ack_seq - map_seq yields
the in-sequence byte count of the skbs that have been queued for reading.

I could probably use skb_peek_tail() instead of skb_peek() and then grab
->end_seq instead of using msk->ack_seq, but I fail to see the advantage.

Because userspace might have partially read some data, we need
to add the offset that userspace might have consumed already.

e.g., one skb queued, with 10 bytes of data, userspace calls read(, ..., 1);
so the inq hint should return 9, not 10.

(read() increments MPTCP_SKB_CB(skb)->offset if skb wasn't consumed).

> I did run in to a selftest failure, but could not reproduce:
> 
> $ sudo ./mptcp_sockopt.sh
> Created /tmp/tmp.Kj9eQSvhn3 (size 1024 KB) containing data sent by client
> Created /tmp/tmp.qOpE4X43Jp (size 1024 KB) containing data sent by server
> tcp_inq is larger than one mbyte
> copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
>  client exit code 1, server 2

Hmm, could not repro either so far.
