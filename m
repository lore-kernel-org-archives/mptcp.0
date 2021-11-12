Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56502C82
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 11:07:01 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mlUOY-0004yv-S2; Fri, 12 Nov 2021 12:06:58 +0100
Date: Fri, 12 Nov 2021 12:06:58 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
Message-ID: <20211112110658.GA3541@breakpoint.cc>
References: <20211111151418.17276-1-fw@strlen.de>
 <20211111151418.17276-4-fw@strlen.de>
 <246033df-61f-5b44-d7fd-9cd95cf8dc6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246033df-61f-5b44-d7fd-9cd95cf8dc6b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> > +		lock_sock(sk);
> > +		if (skb_queue_empty(&msk->receive_queue))
> 
> I'm guessing that the idea here is that answering with a nonzero value is
> enough to get the userspace program to do another read, rather than always
> imposing overhead to dig through the subflow rx buffers and
> sk->sk_receive_queue? That does seem like a good way to go, at least with
> regard to calling __mptcp_move_skbs().
> 
> Would it be useful to check sk->sk_receive_queue and splice if non-empty
> (which is relatively cheap) to get a slightly more accurate inq number? To
> maybe answer this question for myself - the socket lock was just acquired so
> it's unlikely for skbs to have been added to sk_receive_queue, and the extra
> complexity may not be worth it.

The idea was to avoid a bogus '0' answer; msk rx queue might be empty
but sk_rx q might have new data.

I can make the __mptcp_move_skbs() unconditional, as you said we already
acquired the msk socket lock so might as well splice pending subflows
and so on.
