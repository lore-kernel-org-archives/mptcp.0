Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6D2030A
	for <mptcp@lists.linux.dev>; Sun, 21 Sep 2025 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758415703; cv=none; b=uA6jp4vQWXVdazWZtmlfiIMcA+rWbs0YAbkDK9WUNR0d9rmEkqNXhgnp8SRXe6HHAdSHwrP/SI3dckJaRYvSTdddVqO05JaDTBsLuTlzeFT2/JDyvQhYa/NG9xHxpRL6Eg1HCoKVprEwTzJffW1R/MIFU4ewik9mJsRTlDmJZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758415703; c=relaxed/simple;
	bh=smCMvUirHz8h2p0jeXk26+5xYdDeAf6YNJavSP3NenM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AlZhkaFQK9oicJCWMej5AoY2aLIb/aJlW27t105zXIo4uloVicUaYBCGcAs466qkBk5gtJ8hwP6aTkev4RzDtGKZNlppPmD3sUZhZd8G96QYJFU205GCNmmB2kOxUxh80Zh6vBA3Osm+ze8v3pmSolGcu1+rDbD1m0shTGyaqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frNRgu+8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frNRgu+8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BA1C4CEEB;
	Sun, 21 Sep 2025 00:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758415703;
	bh=smCMvUirHz8h2p0jeXk26+5xYdDeAf6YNJavSP3NenM=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=frNRgu+8H0/4++e/wUIpynj+7Rw9Da4fJ9c2yWXDzg7LTE8EnzaA4F++soEpMDCAK
	 3tNTOJkU8jPyNnLavPfA3L07CGrEKimbX80EAX3OM33zlTqqacE32WxeitqydM+arM
	 LEl7o0JF6Fbkc9UJVROAMc9qx0+lXjZLRVFSozjJPV9LXoa+GsM4isO0MXQP7YSBaU
	 ECJALgzjP/A5TgjGwYnqxTvBHk8R6/fNr9eSejKWFK503bE/wZkpDRbIAuPq62w61x
	 8MJcSFKZFDd3o8gTA/MVmI/OZUWlT94eoIahmOQgZ4Q1xG2VOFtQbBlFI8ofn/jXye
	 Bbbh7vzqoCTwA==
Message-ID: <7f555610b63de81f35e7fc9d19c20034756dd22c.camel@kernel.org>
Subject: Re: [MPTCP next v3 04/12] mptcp: introduce the mptcp_init_skb
 helper.
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Date: Sun, 21 Sep 2025 08:48:20 +0800
In-Reply-To: <5917814c3e85dfc2a346e83fc3cca4eeb0868295.camel@kernel.org>
References: <cover.1758296923.git.pabeni@redhat.com>
			 <df18a15a52a3884f05ad97cb53716d92bb7c8d88.1758296923.git.pabeni@redhat.com>
		 <c5efa8750011a88d9945b6d81c36d4d00fe6b1e2.camel@kernel.org>
	 <5917814c3e85dfc2a346e83fc3cca4eeb0868295.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 2025-09-21 at 08:23 +0800, Geliang Tang wrote:
> On Sat, 2025-09-20 at 08:03 +0800, Geliang Tang wrote:
> > Hi Paolo,
> > 
> > Thank you for the v3. All tests pass on my end, including my
> > "implement
> > mptcp read_sock v11" test case.
> > 
> > I have a few minor cleanup comments to make the patch clean. There
> > is
> > no need to send a v4 or block the merging of this series. Matt can
> > make
> > the changes when he merges it, or I can send some squash-to patches
> > to
> > address these after merging. Either approach would be fine.
> > 
> > On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
> > > Factor out all the skb initialization step in a new helper and
> > > use it. Note that this change moves the MPTCP CB initialization
> > > earlier: we can do such step as soon as the skb leaves the
> > > subflow socket receive queues.
> > > 
> > > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > > v1 -> v2:
> > >   - drop subflow argument from mptcp_init_skb()
> > >   - change msk args to sock arg in __mptcp_move_skb()
> > > ---
> > >  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++--------------
> > > --
> > > --
> > > --
> > >  1 file changed, 25 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index c9fcdbaf50874..3aa03da781ba3 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -326,27 +326,11 @@ static void mptcp_data_queue_ofo(struct
> > > mptcp_sock *msk, struct sk_buff *skb)
> > >  		mptcp_rcvbuf_grow(sk);
> > >  }
> > >  
> > > -static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock
> > > *ssk,
> > > -			     struct sk_buff *skb, unsigned int
> > > offset,
> > > -			     size_t copy_len)
> > > +static void mptcp_init_skb(struct sock *ssk,
> > > +			   struct sk_buff *skb, int offset, int
> > > copy_len)
> > 
> > nit:
> > 
> > static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb,
> >                            int offset, int copy_len)
> > 
> > is better.
> > 
> > >  {
> > > -	struct mptcp_subflow_context *subflow =
> > > mptcp_subflow_ctx(ssk);
> > > -	struct sock *sk = (struct sock *)msk;
> > > -	struct sk_buff *tail;
> > > -	bool has_rxtstamp;
> > > -
> > > -	__skb_unlink(skb, &ssk->sk_receive_queue);
> > > -
> > > -	skb_ext_reset(skb);
> > > -	skb_orphan(skb);
> > > -
> > > -	/* try to fetch required memory from subflow */
> > > -	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> > > -		MPTCP_INC_STATS(sock_net(sk),
> > > MPTCP_MIB_RCVPRUNED);
> > > -		goto drop;
> > > -	}
> > > -
> > > -	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> > > +	const struct mptcp_subflow_context *subflow =
> > > mptcp_subflow_ctx(ssk);
> > > +	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> > 
> > nit, how about keeping it as the original code to make this patch
> > smaller:
> > 
> > -	struct mptcp_subflow_context *subflow =
> > mptcp_subflow_ctx(ssk);
> > -	bool has_rxtstamp;
> > -
> > -	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> > 
> > Reviewed-by: Geliang Tang <geliang@kernel.org>
> > Tested-by: Geliang Tang <geliang@kernel.org>
> > 
> > Thanks,
> > -Geliang
> > 
> > >  
> > >  	/* the skb map_seq accounts for the skb offset:
> > >  	 * mptcp_subflow_get_mapped_dsn() is based on the
> > > current
> > > tp->copied_seq
> > > @@ -358,6 +342,24 @@ static bool __mptcp_move_skb(struct
> > > mptcp_sock
> > > *msk, struct sock *ssk,
> > >  	MPTCP_SKB_CB(skb)->has_rxtstamp = has_rxtstamp;
> > >  	MPTCP_SKB_CB(skb)->cant_coalesce = 0;
> > >  
> > > +	__skb_unlink(skb, &ssk->sk_receive_queue);
> > > +
> > > +	skb_ext_reset(skb);
> > > +	skb_dst_drop(skb);
> > > +}
> > > +
> > > +static bool __mptcp_move_skb(struct sock *sk, struct sk_buff
> > > *skb)
> > > +{
> > > +	u64 copy_len = MPTCP_SKB_CB(skb)->end_seq -
> > > MPTCP_SKB_CB(skb)->map_seq;
> > > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > > +	struct sk_buff *tail;
> > > +
> > > +	/* try to fetch required memory from subflow */
> > > +	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
> > > +		MPTCP_INC_STATS(sock_net(sk),
> > > MPTCP_MIB_RCVPRUNED);
> > > +		goto drop;
> > > +	}
> > > +
> > >  	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {
> > >  		/* in sequence */
> > >  		msk->bytes_received += copy_len;
> > > @@ -678,7 +680,9 @@ static bool
> > > __mptcp_move_skbs_from_subflow(struct
> > > mptcp_sock *msk,
> > >  		if (offset < skb->len) {
> > >  			size_t len = skb->len - offset;
> > >  
> > > -			ret = __mptcp_move_skb(msk, ssk, skb,
> > > offset, len) || ret;
> > > +			mptcp_init_skb(ssk, skb, offset, len);
> > > +			skb_orphan(skb);
> 
> One more small request: could you also put skb_orphan(skb); into
> mptcp_init_skb, placing it on the last line, and then replace it in
> patch 12.

And please delete the sentence in the subject of this patch too.

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> > > +			ret = __mptcp_move_skb(sk, skb) || ret;
> > >  			seq += len;
> > >  
> > >  			if (unlikely(map_remaining < len)) {
