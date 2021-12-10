Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696332C80
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 09:00:12 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1mvbl6-0003t3-Ar; Fri, 10 Dec 2021 10:00:04 +0100
Date: Fri, 10 Dec 2021 10:00:04 +0100
From: Florian Westphal <fw@strlen.de>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/2] mptcp: clear 'kern' flag from fallback sockets
Message-ID: <20211210090004.GF26636@breakpoint.cc>
References: <d5c4d25c-7498-46c5-54b6-4fd067d075f2@linux.intel.com>
 <20211206212650.1895-1-fw@strlen.de>
 <bf919f98-d135-fffe-e586-873810a81f4d@linux.intel.com>
 <6c32d24c-d4d-727d-27a9-75478838157e@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c32d24c-d4d-727d-27a9-75478838157e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Mat Martineau <mathew.j.martineau@linux.intel.com> wrote:
> On Mon, 6 Dec 2021, Mat Martineau wrote:
> 
> > On Mon, 6 Dec 2021, Florian Westphal wrote:
> > 
> > > The mptcp ULP extension relies on sk->sk_sock_kern being set correctly:
> > > It prevents setsockopt(fd, IPPROTO_TCP, TCP_ULP, "mptcp", 6); from
> > > working for plain tcp sockets (any userspace-exposed socket).
> > > 
> > > But in case of fallback, accept() can return a plain tcp sk.
> > > In such case, sk is still tagged as 'kernel' and setsockopt will work.
> > > 
> > > This will crash the kernel, The subflow extension has a NULL ctx->conn
> > > mptcp socket:
> > > 
> > > BUG: KASAN: null-ptr-deref in subflow_data_ready+0x181/0x2b0
> > > Call Trace:
> > > tcp_data_ready+0xf8/0x370
> > > [..]
> > > 
> > > Fixes: cf7da0d66cc1 ("mptcp: Create SUBFLOW socket for incoming
> > > connections")
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > ---
> > > v2: also handle early-return
> > 
> > Thanks - v2 looks good to me.
> > 
> > Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > 
> > > 
> > > net/mptcp/protocol.c | 4 +++-
> > > 1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 8319e601bc2d..4a8f2476cc75 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -3013,7 +3013,7 @@ static struct sock *mptcp_accept(struct sock
> > > *sk, int flags, int *err,
> > > 		 */
> > > 		if (WARN_ON_ONCE(!new_mptcp_sock)) {
> > > 			tcp_sk(newsk)->is_mptcp = 0;
> > > -			return newsk;
> > > +			goto out;
> > > 		}
> > > 
> > > 		/* acquire the 2nd reference for the owning socket */
> > > @@ -3025,6 +3025,8 @@ static struct sock *mptcp_accept(struct sock
> > > *sk, int flags, int *err,
> > > 				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> > > 	}
> > > 
> > > +out:
> > > +	newsk->sk_kern_sock = kern;
> 
> Florian -
> 
> I was about to upstream this for -net, but have another question first.
> 
> Is there anything else in newsk that needs to be updated when changing
> sk_kern_sock? sk_alloc() handles some reference counts differently for kern
> socks, and sock_lock_init() sets things up differently for lockdep.

AFAICS no.

The tcpsk inherits these settings from its parent (listen) sk, so they
always have 'kern = 1'.

Even before this change, lock depclass is not correct (kernel, not user).

Need to export code from core to change this.

The netns refcount bump is not needed, but at this point it has already
happened so even if we undo+clear ->sk_net_refcnt it won't buy anthing.

So only alternative I see is to toss this patch and use a different
sk marker to block mptcp ulp on normal tcp sockets.

This would not change the incorrect lockdep class in this case of course
but would avoid messing with this.

tp->is_mptcp would come to mind, we only need to set it to 1 before
adding the mptcp ulp from inside the kernel rather than in the mptcp ulp
init function.
