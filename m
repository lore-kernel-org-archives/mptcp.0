Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286930;
	b=r7mL5/s4iGS/2UJOJThoA++9GXvsqgm7YrWV65sEFi3Xe95GKVdDGnszc27DvRSRVBNu
	 ++h5oXILXA2OW6P0Uw95mQmkc2ntDlDplHRdtie9ywwFrc8ZvHY7a/UUHhfNuo8TRY6af
	 XXjA0oW/TkFdHZfSGqR3KUc2nrglNo8C2BEPOmdL/MN4VEbZFvUVq8I4wvBKWEIw/y5JC
	 5pYABmZMtrVQ6VQeg4FdMTFLO4sfjeQf4/PNdolo0txvkko0xxUOZoSENbMn6wPKNO2+N
	 c46ZgM5nB6FbHlVSRhbd0zcO4rSTc1AH2SBDL4S8jtpIhf1W1hkFDVZAzvd04a4xjqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286930;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=16lpQsPZNjjC3ijLF2uUeyUfA1Z8rss5BZS9YEea6oI=;
	b=KBpDeabRtad8rfuGsrIJxm4zVcMn34poqM7doRmNd34rKW6JmTUGs9fgttvSvRXoSBRy
	 oAjze8cRcCBEpxNdRm+457HVby6LIrQUkgwp2FJ7vR0YAqUJ2sd4gBDnimg3bCQ7h13xP
	 efi2LHx3lrcEj9kgUTSHBBTsPwAXspx2DGyUJeqJ2xqQpSb3h7+HCCN3TdFTgMgdsXXH9
	 a7uhOBdGNP+hwJ9fpHAkBVb+rzTMGlAdPMjKzdQo51QT8Dwx35VhGhxQ3KW/4sFTxuUGV
	 St5x02+/DkGWP7wu3d2GfRspMk262w+JsJWVrfcxcTVLQzc+GleYvSkUU7TrChroa6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh5HrPqG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4E0606A331;
	Sat, 21 Nov 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oh5HrPqG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006491F000C6;
	Sat, 21 Nov 2026 18:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795286930;
	bh=16lpQsPZNjjC3ijLF2uUeyUfA1Z8rss5BZS9YEea6oI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oh5HrPqGRkyO7ppJt6h4uSXlrvmNrWHNchgqdd6z6gxcKAeBPxGpJJyaFE2exta+c
	 8+Q1E8EcmvWswkOCt4RtRHKWOL0uja/zXXE2A0aKMuMlaBB+16sxSGI8Txwyuu6ytY
	 CdijdiMLqAWDs0g9B67aKg8C5r2T2qOzAnqs3BA9R7o0tFSq9LOc54Yj5n7DWkaeOr
	 Ex2YbDX4fI+VKowl9EldRvcTFFTW5p30eXeoscGmU4Oy4EZsXoPP7k5CMLy3MLhpx2
	 OG7jy5sFRh8hgLzo38Fstay8YIYP7uiurNCExNBP2fOoSHpSy9xe3jrYNzhRjW99Wt
	 qKu4PEbt+A3Bg==
Subject:
 Re: [PATCH v3 net-next 5/7] tcp: Allocate all new skb before collapsing.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Sat, 21 Nov 2026 18:48:49 +0000
Message-ID: <179528692954.3135.2145920714638368553@kernel.org>
In-Reply-To: <20261119071649.374106-6-kuniyu@google.com>
References: <20261119071649.374106-6-kuniyu@google.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tcp_collapse() (net/ipv4/tcp_input.c), the new
  TCP_COLLAPSE_MAX_TOTAL_SIZE overlap check throws away the whole…

--

tcp: Allocate all new skb before collapsing.

This commit changes tcp_collapse() to preallocate every new skb for a
sub-range into a temporary pool before copying. An alloc_skb() failure
then no longer leaves partially collapsed duplicates in the queue. To
bound that preallocation, the sub-range is capped at
TCP_COLLAPSE_MAX_TOTAL_SIZE, except when the range is a single first skb.
Overlapping OOO ranges that go over the cap are skipped.

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 27ed9ba11ec9c..990e348963734 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5822,6 +5822,11 @@ static struct sk_buff *tcp_skb_next(struct sk_buff *skb, struct sk_buff_head *li
>  #define TCP_COLLAPSE_SCALING_RATIO				\
>  	((TCP_COLLAPSE_MAX_SIZE << TCP_RMEM_TO_WIN_SCALE) /	\
>  	 (SKB_TRUESIZE(TCP_COLLAPSE_MAX_SIZE)))
> +/* Cap pool preallocation per sub-range to at most 16 skbs in seq
> + * space.  A single first skb exceeding this is still collapsed,
> + * whereas an exceeding overlapping ofo range is skipped.
> + */
> +#define TCP_COLLAPSE_MAX_TOTAL_SIZE (TCP_COLLAPSE_MAX_SIZE * 16)
>  
>  static bool tcp_collapse_skb_bloated(const struct sk_buff *skb,
>  				     u32 start, u8 scaling_ratio)

[ ... ]

> @@ -5926,8 +5933,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  		}
>  
>  		if (!overlap &&
> -		    !tcp_collapse_skb_bloated(n, sub_end,
> -					      TCP_COLLAPSE_SCALING_RATIO))
> +		    (TCP_SKB_CB(n)->end_seq - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE ||
> +		     !tcp_collapse_skb_bloated(n, sub_end,
> +					       TCP_COLLAPSE_SCALING_RATIO)))
>  			break;
>  
>  		sub_end = TCP_SKB_CB(n)->end_seq;
> @@ -5935,25 +5943,38 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  		n = tcp_skb_next(n, list);
>  	}
>  
> +	if (sub_end != TCP_SKB_CB(skb)->end_seq &&
> +	    sub_end - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE)
> +		goto skip;

[Severity: Medium]
Does this goto skip discard the whole [start, sub_end) range in
tcp_collapse()? That would include the bloated non-overlapping skbs
gathered before the overlapping one.

In the second loop, the new size cap is only checked when overlap is
false. An OOO skb where

    overlap = !list && before(TCP_SKB_CB(n)->seq, sub_end);

is true gets added to sub_end with no size check. If that pushes
sub_end - start past TCP_COLLAPSE_MAX_TOTAL_SIZE, skip sets
start = sub_end and skb = n. None of the earlier skbs get collapsed,
even though they were collapsed before this patch.

Would it work to collapse only the prefix and stop before the skb that
the overlapping one overlaps? tcp_data_queue_ofo() inserts a partial
overlap after its predecessor, so the rbtree ordering should still hold.

TCP_COLLAPSE_MAX_TOTAL_SIZE is 16 * SKB_MAX_ORDER(0, 0). With 4 KiB pages
that is 60416 bytes of sequence space, which is less than one 64 KB
GRO/TSO skb. Can a single overlapping retransmit that was re-segmented
or GRO-aggregated trigger this?

As an example, take contiguous bloated OOO skbs A1..A15 (about 22 KB),
followed by B, which partially overlaps A15 and extends about 40 KB
further.

Before this patch the range is collapsed, saving roughly 16 KB of
truesize. After it, nothing is collapsed, and the same thing happens on
every prune while B stays queued. tcp_prune_queue() then falls back to
tcp_prune_ofo_queue(), which drops OOO data.

The commit message says:

    Legitimate overlaps (retransmits with a different segmentation)
    only involve a few skbs, so if an overlapping OOO chain reaches
    the limit, we simply skip it.

Is this accurate, given that the check counts bytes and not skbs? The
message also doesn't mention that the non-overlapping skbs before the
overlap are skipped as well.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119071649.374106-1-kuniyu%40google.com
