Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353544;
	b=eKeItr8vWi3AhBJHJ9OkfLP7HOdJbc73fvefqoVCcxLR+WY+PF+OzMriCg/S+14shn3f
	 xnXgzs3Z671QyrzWT/x/hTCWYRdlszm9HiIhvUO6Zdd5Zd9rGmMxZkl8PQDk0w+y+c2Nu
	 vI+pbPqsGolzvYEtUVcdxqoM8uRbn6roN/Cq0a2PQ1nyCZZ4NgnHZbnOFr7dn+QgGlLzW
	 dQVK7Jtw/x8JlG0jfF6oQXoA2B+9ulbwpF6MzZEaacF0aJdJAvMLjwQzegXXpZEJ48XMW
	 NGK+T+QGJ7fc6au9usQ4X62mOoMfXiHiqj8/kJ/IDfrFqWSBW11Y1IpA3M0ak0rvZeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353544;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=B2hx3G7JY2a02VL7ZjsWkp+8bYy+uMwmCOtRFuMVSaQ=;
	b=d+UTzKqbl/X5wVFWB9gHoMaoYPmfLmYJq98vQuHJIft9mJbfBseHxPlixjOcwn9ClHiB
	 Jry4aFcp1SRg3nH/fpRU+3FdwIh/CHmHNWbow4HW5kPJhaoAelWIS/yT53V6uV021Nh/P
	 i9xiTkxnbVkiRjRkPyKyXQPgzhnftCk0loG4pEpy0YUFnLt9ytGpdvxrKGCdgYvQjmIhZ
	 aL1Yfgp366DL3eu1YG6oBKhAkMKLowam7Q8SxWFuL1ENqrGg1osmnTEfD2h4wWwDpLQyL
	 jGjHiFo8ykij8sYAtrzZWzxtzZPq+CNNW8pTQM9MsmX3HigPjFv+UnmhJwKpvBnngCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enuXwnVj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2A606A321
	for <mptcp@lists.linux.dev>; Tue, 10 Nov 2026 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enuXwnVj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E31F00A04;
	Tue, 10 Nov 2026 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794353544;
	bh=B2hx3G7JY2a02VL7ZjsWkp+8bYy+uMwmCOtRFuMVSaQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=enuXwnVjZc8hNFsrBZU3wb/ic9AMaRN3lIr8kjU8yghlmmxmvRDFfEtpHulaZ5+Fs
	 TwHoCZAHDeYLqejTveGgIVh6RmBcvTWi8dwV31wHUbSVFKQLsB0RwhWejwWIt/4/Mj
	 +fd298wG/2cYe5WbcUtx3+XwGeLx/4flkm62MeiOkb8FizSHb/CIShjwxikbXqeyQj
	 h+yJqBF2w6aIaJwhhy7u4wYx2l3QzH7bMb9r1EhoKmJO5hObNzgCfvJCsFn6Eugs8d
	 8ljpkMWSYe+VrOhogPyrXZr5bK/Go06a9Ur9SLbyBHNQTvJJoURoShj3bomkti9U0r
	 vPM8XiRelrDzA==
Subject:
 Re: [PATCH mptcp-next v24 7/8] mptcp: sync mptcp skb cb layout with tcp one
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 10 Nov 2026 23:32:23 +0000
Message-ID: <179435354363.488855.16913226200081069114@kernel.org>
In-Reply-To: <3ba0e47d2142efad6579687bb74379dcd779a42d.1794215614.git.tanggeliang@kylinos.cn>
References: <3ba0e47d2142efad6579687bb74379dcd779a42d.1794215614.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message never says why the MPTCP CB layout must match
  TCP's.
- [Low] The patch puts mptcp_skb_cb.flags at the same offset and width as
  tcp_skb_cb.tcp_flags (u16 at offset 12) and adds a BUILD_BUG_ON for it.

--

mptcp: sync mptcp skb cb layout with tcp one

This commit shrinks the MPTCP skb cb map_seq and end_seq fields to 32
bits so that map_seq, end_seq and flags share offsets with tcp_skb_cb's
seq, end_seq and tcp_flags. It adds map_seq64 to hold the full 64-bit
DSN, and the receive path now uses 32-bit before()/after() comparisons,
with map_seq64 used for window admission and coalescing checks. A
build-time check in mptcp_proto_init() enforces the shared offsets.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 30933dd9f0b1d..683ffa8f6c7a2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -4918,11 +4927,23 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
>  	return work_done;
>  }
>  
> +#define CHK_CB_FIELD(mptcp_field, tcp_field)	\
> +	({					\
> +		BUILD_BUG_ON(offsetof(struct mptcp_skb_cb, mptcp_field) !=    \
> +			     offsetof(struct tcp_skb_cb, tcp_field));	      \
> +		BUILD_BUG_ON(offsetofend(struct mptcp_skb_cb, mptcp_field) != \
> +			     offsetofend(struct tcp_skb_cb, tcp_field));      \
> +	})
> +
>  void __init mptcp_proto_init(void)
>  {
>  	struct mptcp_delegated_action *delegated;
>  	int cpu;
>  
> +	CHK_CB_FIELD(map_seq, seq);
> +	CHK_CB_FIELD(end_seq, end_seq);
> +	CHK_CB_FIELD(flags, tcp_flags);
> +

[Severity: Low]

The commit message says:

  This allows updating the MPTCP CB layout so that key fields with
  corresponding TCP-level data (map_seq/seq, end_seq/end_seq,
  flags/tcp_flags) use the same offsets inside the CB itself.

It doesn't say why these fields need to share offsets. Could the
changelog say which code is expected to read msk-level skbs through
TCP_SKB_CB()?

Nothing in this patch does that. Nothing up to the end of the series
("mptcp: defer read_sock cleanup to mptcp_worker") does either. Every
TCP_SKB_CB() user in net/mptcp/ works on subflow skbs before
mptcp_init_skb() rewrites the cb.

The only hint is the "upcoming TLS-over-MPTCP" mention in the last patch
of the series. net/tls/ only reads TCP_SKB_CB(skb)->seq, so why do flags
and tcp_flags also need to alias?

The subject says "sync mptcp skb cb layout with tcp one", but only three
fields line up. has_rxtstamp at offset 14 sits on tcp_skb_cb's sacked.
map_seq64 at offset 16 covers the txstamp_ack/eor/has_rxtstamp bitfield
byte and ack_seq. Would a narrower subject be more accurate?

[ ... ]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fd3326518ee5c..8c868bcbafb8c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -131,10 +131,12 @@
>  #define MPTCP_SKB_CB_F_OFFSET	0x01
>  
>  struct mptcp_skb_cb {
> -	u64 map_seq;
> -	u64 end_seq;
> +	u32 map_seq;
> +	u32 end_seq;
> +	u32 unused;
>  	u16 flags;
>  	u8  has_rxtstamp;
> +	u64 map_seq64;
>  };

[Severity: Low]

MPTCP_SKB_CB_F_OFFSET is 0x01, which is the same bit as TCPHDR_FIN:

include/net/tcp.h:
    #define TCPHDR_FIN	BIT(0)

Now that flags sits on top of tcp_flags, mptcp_init_skb() writes a value
that TCP would read as FIN:

net/mptcp/protocol.c:mptcp_init_skb() {
    ...
	MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;
    ...
}

These skbs keep the flag when they land in the msk OFO queue or in
sk_receive_queue. Suppose a TCP-style reader later handles msk-level
skbs with a check like the one in tcp_recv_skb()/tcp_read_sock():

	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)

Would it treat these skbs as FIN, then account seq wrongly or stop
reading early?

CHK_CB_FIELD(flags, tcp_flags) in mptcp_proto_init() checks only offsets
and sizes, not whether the bits mean the same thing.

Could F_OFFSET use a value that doesn't collide with the TCPHDR_* bits?
Alternatively, could the code document that tcp_flags must not be read
on msk skbs?

There is a similar overlap with map_seq64. At offset 16 it covers the
txstamp_ack/eor/has_rxtstamp bitfield byte of tcp_skb_cb. On
little-endian systems those bits would come from the low byte of the
peer-chosen DSN.

No in-tree code reads TCP_SKB_CB() on msk-level skbs today (net/tls only
reads ->seq), so this only matters for future users of the shared
layout.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794215614.git.tanggeliang%40kylinos.cn
