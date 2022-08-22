Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5397B
	for <mptcp@lists.linux.dev>; Mon, 22 Aug 2022 12:32:14 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1oQ6b8-0003mL-BE; Mon, 22 Aug 2022 14:32:06 +0200
Date: Mon, 22 Aug 2022 14:32:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH RFC mptcp] net: tcp: prevent transition to FIN_WAIT2 when
 mptcp has unacked data_fin
Message-ID: <20220822123206.GF11586@breakpoint.cc>
References: <20220818162123.30198-1-fw@strlen.de>
 <09c08d1262325db726f2d3d2d6e4efd351612a87.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c08d1262325db726f2d3d2d6e4efd351612a87.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> > Full test case stashed here for the time being:
> > https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9
> > 
> > Its possible to either change tw_sk to have enough mptcp context to be
> > able to send a packet back, or we can supress/delay the tw_sock
> > transition.  This is what classic TCP is doing when it receives another
> > FIN while in FIN1 state.
> > 
> > This change makes the test case work (another dss ack is sent), but
> > there may be other corner cases where we need to delay the sk ->
> > tw_sk transition.
> > 
> > If the general idea looks ok, perhaps its better to replace
> > 
> > tcp_time_wait(sk, skb, ..
> > 
> > with a mptcp aware helper, e.g.  tcp_time_wait_check(sk, skb, ..
> > and place the option parsing for mptcp-subflows there?
> 
> _if_ (big if) I read correctly, this patch "always" (most common
> shutdown sequence should match the condition checked here, right?)

Really?  I had to fudge with the test case a long time to get the needed
transition, I'm not even sure the test case is legit.

https://github.com/fw-strlen/packetdrill/commit/60a3f57ea309f910643e06dbf123236741c7f8d9

is that even correct?!
(See line 43f., it acks the tcp-level fin, but retransmits the data_fin).

> delay the tw_sk transiction for mptcp sockets, keeping alive the whole
> mptcp and subflow socks for a ??? timeout. Is that correct?

Yes.

> If so, and the mptcp_tw socket is not too invasive (again, big if), I
> think implementing the mptcp_tw could be better: a busy server could
> keep a lot of memory around for the shutting-down-socks.

Hmm, not sure, see above and below.

> I think the mptcp_tw will not need a reference to the mptcp sock, it
> just need to know the mptcp-level data_fin seq to be acked.

Agreed.

> > +		} else if (sk_is_mptcp(sk) &&
> > +			   mptcp_incoming_options(sk, skb) &&
> > +			   mptcp_subflow_pending_data_fin_ack(sk)) {
> 
> Possibly ENOCOFFEE here, but could the above 2 function being replaced
> by checking if the incoming packet carries a data_fin option?

Is that needed? AFAIU we ONLY need to respond if we have a pending
fin_ack, i.e. if we know the data_fin ack is completed we don't need to act?

If we need this unconditionally then of course your proposal makes more
sense, i would then rework this to handle this as an extension of
'tcp->fin set' case with same handling (pass to tcp_data_queue()).

> (not sure if worthy and its very subjective, it "sounds" a little bit
> clearer to me)
> 
> > +				inet_csk_schedule_ack(sk);
> 
> Why we explcitly need to schedule the ack, and the plain TCP-fin case
> does not need it?

Yes, I could rework this.  For normal tcp, there are two cases:
1. pure ack -> no action needed, transition to FIN_WAIT2 + mini-tw-socket
2. fin set -> pass the skb to tcp_data_queue (this can't be seen from
   the context diff, but this is where the skb will end up, this will
   then call tcp_fin() again.
   In this case, the socket doesn't move to tw state.

Thanks,
Florian
