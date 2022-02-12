Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3377F
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 00:08:24 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nIfxU-0003W3-TP; Sat, 12 Feb 2022 01:08:13 +0100
Date: Sat, 12 Feb 2022 01:08:12 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220212000812.GB6497@breakpoint.cc>
References: <20220210152949.19572-1-fw@strlen.de>
 <20220210152949.19572-4-fw@strlen.de>
 <2fca6a8-62b3-9f8-d08-62bf352c071@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fca6a8-62b3-9f8-d08-62bf352c071@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Thu, 10 Feb 2022, Florian Westphal wrote:
> 
> > Currently mptcp adds kernel-based listener socket for all
> > netlink-configured mptcp address endpoints.
> > 
> > This has caveats because kernel may interfere with unrelated programs
> > that use same address/port pairs.
> > 
> 
> It looks like they still interfere with each other, but now in the opposite
> way: TCP listeners can now be created that interfere with MP_JOINs (and the
> MPTCP side loses).

Yep, I'm not sure its a good idea to announce random addresses:ports.

> Since mptcp_handle_join() is only called if the listener lookup fails, if a
> TCP listen socket has been created for an address & port advertised by
> MPTCP, that TCP listener will be looked up, process the SYN, and send a
> regular TCP SYN/ACK. The peer will then reject it due to lack of correct
> MPTCP options.

Correct.  Its easily fixable by doing mptcp_handle_join() before the
lookup, but that means a new conditional in tcp fastpath.

I'm not sure TCP maintainers will eat that, but its certainly doable.
Idea would be to have __mptcp_handle_join() make a listen socket lookup
and then assign 'skb->sk = magic_listen' if there is none, just like TPROXY.

> Seems like a few more TCP changes are needed to handle this listener
> collision well for both TCP and MPTCP, and without too much overhead. Is it
> too expensive to look for MPTCP options in every incoming TCP SYN header?

I'm not worried about that, Its just the extra
if (th->syn && !th->ack && ...
conditional inside mptcp_handle_join().

ATM the extra conditional is hit only in the error path, not for every
packet.
