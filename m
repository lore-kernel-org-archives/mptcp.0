Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A247F
	for <mptcp@lists.linux.dev>; Sat, 12 Feb 2022 00:12:17 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nIg1M-0003YG-3X; Sat, 12 Feb 2022 01:12:12 +0100
Date: Sat, 12 Feb 2022 01:12:12 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 3/4] mptcp: handle join requests via pernet
 listen socket
Message-ID: <20220212001212.GC6497@breakpoint.cc>
References: <20220210152949.19572-1-fw@strlen.de>
 <20220210152949.19572-4-fw@strlen.de>
 <1571d4e58ebf36eb436b0056f3ae7254d3a3114d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571d4e58ebf36eb436b0056f3ae7254d3a3114d.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Paolo Abeni <pabeni@redhat.com> wrote:
> On Thu, 2022-02-10 at 16:29 +0100, Florian Westphal wrote:
> > +
> > +	/* pernet listener to handle mptcp join requests
> > +	 * based on the mptcp token.
> > +	 *
> > +	 * Has to be pernet because tcp uses
> > +	 * sock_net(sk_listener) to obtain the net namespace for
> > +	 * the syn/ack route lookup.
> > +	 */
> 
> A possible alternative would be proving a __tcp_conn_request() variant
> which uses an exiplicit 'net' argument. tcp_conn_request() could be an
> inline on top of the above.

Yes, we could change tcp stack to allow explicit net arg.

> Or we can use a global per-cpu set of "listeners", setting the net
> field just before calling tcp_conn_request.

I would prefer to avoid that, might get messy at least for RT folks?
If you don't want pernet, then I think additional tcp surgery is better.

> > +	sock_put((struct sock *)msk);
> 
> This should be called under the RCU lock, right? we could have
> __mptcp_token_lookup_sock variant that does not touches the msk
> reference count.

Yes, we should make token api netns safe and then use the 'exist'
variant which takes no reference count.

> > +	msk = mptcp_sk(lsk);
> > +	ssock = __mptcp_nmpc_socket(msk);
> > +	lsk = ssock->sk;
> > +	sock_hold(lsk);
> 
> If I read correctly, at this point 'refcounted' should be 'false' in
> the caller (either tcp_v4_rcv or tcp_v6_rcv), so we don't need to
> acquire a reference to lsk ?!?

Yes, the refcount increase is wrong for sure, its not needed unless
we go for 'skb->sk = lsk' route.
