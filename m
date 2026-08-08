Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8D2D781B
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786156310; cv=none; b=kmXSKFfrZbhbEIMcFWaoMPrr4t93iwtoukPcyvcX3bf/J/fndbhruyfeNyMwwERBal7knvtNflZVeLkWTYN5XVCmhlOvrFXfDj6/SJLNeAmeMs3ZTG29ksisPzZ74ImhKWejbpsOzCGB6P/wuBx78G67NZJIQdBVmJk09j9b0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786156310; c=relaxed/simple;
	bh=hJufL492QkEFERPWXxJbouCl2XmsPlxcPrxYjSu91vg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RNakLzzN/UFlmYwodTMjJSMUdm3Y4gQ1psOU3jqucNt/TpjvHqez1DpOeJ+GNuagRP3lAEBZ0zy8FjjVqmTqjPOlhgl7RQQwISpbC/mgOajVTW/VK+8cQVpd4Evvba3XLHJeKuJmXm5jgwuEW4oi6eWuyaK5CcYB/iA9w/JwgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpfvqboo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpfvqboo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB7A1F000E9;
	Sat,  8 Aug 2026 02:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786156308;
	bh=WMfqcwV5JewQJLkhqtVI/RWWo2LGH6tv5mvCW4N/UgM=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Jpfvqbooe1RKpiu62bsaTAebyV02PJsrt8pNEkWViPHcVWs0Dsjc265lopmwsSZdr
	 Wo1V+wCAksEwo/JmS3gOpnUgMGLXy/ErfcrOOAEW2zvPLDcizsFcF2Efi/HSsZ1sHP
	 E1kiZlo9M9WW1ORW2BxSKy6zHF57W3OvMbJoFz0Ke5WkBXGA9pXyxzeNcg/FQBct5R
	 X/fUk+uZ72bgvvX/ulS+4LbiGOkWgxz6toCON4kS6P8mAiVIx0FMD8ErRhL8KpZD+W
	 mRcFOZkx9N/anZddv5MPOK9/gNnaWU1VnYJuhw6gfcYCc56s4UXlvcdWbIzGndK1mf
	 0zRUDW6RgQRkA==
Message-ID: <a8cf012f365d1885f773d5959829cb42298477bb.camel@kernel.org>
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	mptcp@lists.linux.dev
Date: Sat, 08 Aug 2026 10:31:46 +0800
In-Reply-To: <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
References: <cover.1786026372.git.pabeni@redhat.com>
	 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
	 <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
	 <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2026-08-06 at 18:46 +0200, Matthieu Baerts wrote:
> On 06/08/2026 18:42, Paolo Abeni wrote:
> > On 8/6/26 4:45 PM, Paolo Abeni wrote:
> > > When moving incoming skbs in the msk receive queue and the latter
> > > is above limits, prune it as needed quite alike what TCP is doing
> > > at the subflow level. The main difference relies in the stop
> > > condition:
> > > since MPTCP does not perform collapsing, it's better off dropping
> > > the
> > > bare minimum to fit the (newer) incoming packet.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > Tested-by: Gang Yan <yangang@kylinos.cn>
> > > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > v<n> -> v<n+1>:
> > >   - prune only for new data
> > >   - reorganize the code to follow more closely TCP
> > > ---
> > >  net/mptcp/mib.c      |  1 +
> > >  net/mptcp/mib.h      |  1 +
> > >  net/mptcp/protocol.c | 81
> > > ++++++++++++++++++++++++++++++++++++++------
> > >  3 files changed, 73 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> > > index ef65e2df709f..2569385bab7c 100644
> > > --- a/net/mptcp/mib.c
> > > +++ b/net/mptcp/mib.c
> > > @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[]
> > > = {
> > >  	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
> > >  	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
> > >  	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
> > > +	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
> > >  };
> > >  
> > >  /* mptcp_mib_alloc - allocate percpu mib counters
> > > diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> > > index 9271205f682e..3a3425e258a7 100644
> > > --- a/net/mptcp/mib.h
> > > +++ b/net/mptcp/mib.h
> > > @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
> > >  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero
> > > window probe */
> > >  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory
> > > limit */
> > >  	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory
> > > constraints */
> > > +	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue
> > > pruned */
> > >  	__MPTCP_MIB_MAX
> > >  };
> > >  
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index 63f2c18bc01f..ec874d2ead6a 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -242,6 +242,65 @@ static bool mptcp_rcvbuf_grow(struct sock
> > > *sk, u32 newval)
> > >  	return false;
> > >  }
> > >  
> > > +/* "Inspired" from the TCP version; main difference: stop as
> > > soon as the MPTCP
> > > + * socket is under memory limit.
> > > + */
> > > +static void mptcp_prune_ofo_queue(struct sock *sk,
> > > +				  const struct sk_buff *in_skb)
> > > +{
> > > +	struct mptcp_sock *msk = mptcp_sk(sk);
> > > +	struct rb_node *node, *prev;
> > > +	bool pruned = false;
> > > +	u64 mem;
> > > +
> > > +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> > > +		return;
> > > +
> > > +	node = &msk->ooo_last_skb->rbnode;
> > > +
> > > +	do {
> > > +		struct sk_buff *skb = rb_to_skb(node);
> > > +
> > > +		/* Stop pruning if the incoming skb would land
> > > in OoO tail. */
> > > +		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
> > > +			    MPTCP_SKB_CB(skb)->map_seq))
> > > +			break;
> > > +
> > > +		pruned = true;
> > > +		prev = rb_prev(node);
> > > +		rb_erase(node, &msk->out_of_order_queue);
> > > +		mptcp_drop(sk, skb);
> > > +		msk->ooo_last_skb = rb_to_skb(prev);
> > > +
> > > +		mem = (unsigned int)sk_rmem_alloc_get(sk);
> > > +		if (mem <= sk->sk_rcvbuf)
> > > +			break;
> > > +
> > > +		node = prev;
> > > +	} while (node);
> > > +
> > > +	if (pruned)
> > > +		MPTCP_INC_STATS(sock_net(sk),
> > > MPTCP_MIB_OFOPRUNED);
> > > +}
> > > +
> > > +/* The stack can't drop packets for fallback socket at the msk
> > > level, or the
> > > + * stream will break.
> > > + */
> > > +static bool mptcp_can_ingest(const struct sock *sk)
> > > +{
> > > +	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk-
> > > >sk_rcvbuf)) ||
> > > +			__mptcp_check_fallback(mptcp_sk(sk));
> > The above should obviously be: 'likely(...)'
> > 
> > @Matttbe: please LMK if you prefer a repost or you could adjust
> > that
> > while applying to the export branch.
> No problem, I can adjust them when applying them (if there are no
> other
> big modifications required, but I guess no).

It seems you forgot to update this on the export branch.

Thanks,
-Geliang

> 
> Cheers,
> Matt
