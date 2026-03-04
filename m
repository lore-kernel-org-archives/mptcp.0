Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2456E3988FC
	for <mptcp@lists.linux.dev>; Wed,  4 Mar 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772617093; cv=none; b=BFwNWtF4XszQQyjQJhiuHqbqAgoYEPM63nJcYibyaohyT/C7/68BQcHg21V9nHnqx28EFp++r4qnr7MTQcpOX0KBmtoY9ZMjdZ5Omfmm7iZrPeSrss8aOusv764HORGKa4Ye1ULV3//N8u3f2c+OfnJ0a0CTBsN4PKoPiFQaU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772617093; c=relaxed/simple;
	bh=zOjV9G/E5kEE7rU0o6VCU6dYLOBv6HltxVIxOK5Xz8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmhHexZ+H+K+SsB5HDCjHZANjpP+PHDeasHQls+ojuLISJiljFAEQyAw3ziMDBOyFrkjZ8p8PsQLODXs0GJLZqm5zHYfN32U4XaTqAtqBaqiDgHpBzSpJJv45YlIeBdUQ8/fn3aT71NP+kGFSKU5wf54rMyYVoGMp0mvNh2mJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aE0NKBd+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE0NKBd+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772617091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwH9nBhlw7SiaLrCiaRSy0D6mo7wMqo2GQ+mrsiKXtM=;
	b=aE0NKBd+Y2Nd7FUBnNr1m327ToPWaUMB2TasdXjwziv/6X8YL+CZyIxkWotBUSnc4IpEpQ
	LJgINh0aQo950UmZl+PU4xoc8M2WjYj12nuBBY8dnwqXO9+GF8KJYsNNuBOvLEAoHyX8C5
	TKFMDmR8nMEyq0qLji7PghYYfBLm+LM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-b8hYd5DsONyEtfMdnjMPQg-1; Wed, 04 Mar 2026 04:38:09 -0500
X-MC-Unique: b8hYd5DsONyEtfMdnjMPQg-1
X-Mimecast-MFC-AGG-ID: b8hYd5DsONyEtfMdnjMPQg_1772617089
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so54703525e9.2
        for <mptcp@lists.linux.dev>; Wed, 04 Mar 2026 01:38:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772617088; x=1773221888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwH9nBhlw7SiaLrCiaRSy0D6mo7wMqo2GQ+mrsiKXtM=;
        b=X8JLdYfy1Rlu5FSuVKbL5FHw3QtZ5qcqvthJAvNqw2xhdr3SbeO3CYjumPe/s3IYyK
         IFpQhHAEIPn0o4RPeh2jdSrIJr2zyIEjuedcl4/3jy6gRbTd0crgWaXYFVZ21xqcOrjN
         EIUcLVFcYDyZCEG7Iule8cI0LQPnULpFhQTkRPT217J2ykRuJT4/H8oo4NSTTmZHg6Is
         hG/9amd7gf8FsPaatg5WwpDl7mgJHvYMwc/v4GlQMuysrHz5mPhGgylgkGtN989CsNDR
         SoXzPM6LmLMnO38LgvwGBdm87QuOXQlHHLJJnQdMb6EwYu6SxNa6il7BbCkOhEIvgBjb
         95XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUBar1WqssAeCotzbOqtwOx4CaGRwcBnXKGAhu1CiHyxX5j2TQTo0GWKw6+fOP2MatI4NE+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmlRjt2xRiNlxuTg2iz7/SaUK8HplunFEocpiD5J1TzdnJFGSP
	se36fvf1JWf7R8c3MoyMMcUa864ay/spBM+kFVDNoY8B4C3+NlfbIRvX8j1QJv8oqbLQ4Ewgau2
	ubKT5rdrtF/d/ZonT44dS+1v+uZ4ShThTPc4xPdqj/TQXsJL0RwUqROr4cOdnsksh
X-Gm-Gg: ATEYQzxStWEMJlEk68msPcZpwEOzJSxKuq6ykfs1QpsmsASBs09KM34+zbyOIz93dGw
	WADvW2deX6UaUoTk7h3U899oaAVD6CYRAMWsHbth+rrU21HSk5V+xjtwppTiDXS1zmuVb3qN6Ew
	fZgnRnkR40lreoSTN6zVN8swabF3PbyOiCe9ZVP1/VVtph4x1WvbwKV6vBk0fRTSRAio0dG0bna
	dftwGTTWh0ATiRZVQRkoP3s+6aw4E05vbBCB0qK/KztEq4wutfClGhDvvyUtx32tCHkrRwDp5Iq
	SigNaGAydFCSTu+H4sQOKrU8xB9FucnnbFHVacHvEAxpLhDU4aujTVbK5LzI4V/hgEkv94gG5PK
	w6J033fiq/bFXjMJx39HRvGq4Og==
X-Received: by 2002:a05:600c:6091:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48519837bb1mr23793055e9.5.1772617088331;
        Wed, 04 Mar 2026 01:38:08 -0800 (PST)
X-Received: by 2002:a05:600c:6091:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-48519837bb1mr23792525e9.5.1772617087823;
        Wed, 04 Mar 2026 01:38:07 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851881264fsm36172745e9.14.2026.03.04.01.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 01:38:07 -0800 (PST)
Message-ID: <f4d04706-9061-4642-bc3e-31e8f0f06e0c@redhat.com>
Date: Wed, 4 Mar 2026 10:38:06 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH mptcp-net v2] mptcp: fix stall because of
 data_ready
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <20260228011511.440437-1-gang.yan@linux.dev>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260228011511.440437-1-gang.yan@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ygKxeJS62cSKe_x8EZWXsn21WxLYKOl3BjdIcyKEh4o_1772617089
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/28/26 2:15 AM, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch fixes the second type of backlog_list stall issue that
> occurs when the data_ready callback attempts to trigger data transfer.
> The issue reproduces at approximately a 20% rate (once every five runs)
> when running multi_chunk.sh tests.
> 
> The stall occurs under the following conditions:
> 1. A large amount of out-of-order (OFO) data causes sk_rmem_alloc to
>    exceed sk_rcvbuf
> 2. The skb matching the current ack_seq is not present in backlog_list
> 3. Data reception relies on data_ready callback notification
> 
> In this scenario, the data_ready callback (via mptcp_data_ready() ->
> sk->sk_data_ready()) attempts to trigger data movement, but
> __mptcp_move_skbs_from_subflow() repeatedly moves the ack_seq skb into
> backlog_list and returns false:
> 
> '''
> msk->ack_seq:3442119990924456661, map_seq:3442119990924456661, offset:0, fin:0
> [MPTCP_BACKLOG] #0 map_seq=3442119990924655746 end_seq=3442119990924660542 len=4796
> [MPTCP_BACKLOG] #1 map_seq=3442119990924491850 end_seq=3442119990924500364 len=8514
> [MPTCP_BACKLOG] #2 map_seq=3442119990924660542 end_seq=3442119990924726001 len=65459
> [MPTCP_BACKLOG] #3 map_seq=3442119990924508114 end_seq=3442119990924514971 len=6857
> [MPTCP_BACKLOG] #4 map_seq=3442119990924726001 end_seq=3442119990924731093 len=5092
> [MPTCP_BACKLOG] #5 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #6 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #7 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #8 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #9 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #10 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #11 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> [MPTCP_BACKLOG] #12 map_seq=3442119990924456661 end_seq=3442119990924464310 len=7649
> ...
> '''
> 
> The fix allows moving in-sequence SKBs (map_seq == ack_seq) even when
> the receive buffer is full, preventing the stall condition.
> 
> Fixes: 6228efe0cc01 ("mptcp: leverage the backlog for RX packet processing")
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
> 
> Notes:
>     changelog:
>       v2:
>        - As suggested by Paolo, the previous empty‑queue check on the
>          receive queue has been replaced with a check that permits
>          in‑sequence SKBs.
>       v1:
>        - Paolo has reviewed at:
> 	 https://patchwork.kernel.org/project/mptcp/patch/de0a7e3ea6a3cac75b3c2c811695c5d674d929ef.1770273341.git.yangang@kylinos.cn/
> 
>  net/mptcp/protocol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c020882521b4..25ed246db7fb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -739,7 +739,8 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
>  
>  			mptcp_init_skb(ssk, skb, offset, len);
>  
> -			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
> +			if (own_msk && (sk_rmem_alloc_get(sk) < sk->sk_rcvbuf ||
> +					MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq)) {
>  				mptcp_subflow_lend_fwdmem(subflow, skb);
>  				ret |= __mptcp_move_skb(sk, skb);
>  			} else {

It just occurred to me since commit 6787b7e350d ("mptcp: avoid
processing packet if a subflow reset") we could early drop OoB skb in
mptcp_incoming_options() and possibly/likely completely remove the check
from here and elsewhere, something alike the following:

---
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ac16e4bd496f..4834b2cd8142 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1167,6 +1167,9 @@ bool mptcp_incoming_options(struct sock *sk,
struct sk_buff *skb)
 	struct mptcp_options_received mp_opt;
 	struct mptcp_ext *mpext;

+	if (sk_rmem_alloc_get(msk) > READ_ONCE(subflow->conn->sk_rcvbuf))
+		return false;
+
 	if (__mptcp_check_fallback(msk)) {
 		/* Keep it simple and unconditionally trigger send data cleanup and
 		 * pending queue spooling. We will need to acquire the data lock
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c020882521b4..78ce00b14b23 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -739,7 +739,7 @@ static bool __mptcp_move_skbs_from_subflow(struct
mptcp_sock *msk,

 			mptcp_init_skb(ssk, skb, offset, len);

-			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
+			if (own_msk) {
 				mptcp_subflow_lend_fwdmem(subflow, skb);
 				ret |= __mptcp_move_skb(sk, skb);
 			} else {
@@ -2176,10 +2176,6 @@ static bool __mptcp_move_skbs(struct sock *sk,
struct list_head *skbs, u32 *delt

 	*delta = 0;
 	while (1) {
-		/* If the msk recvbuf is full stop, don't drop */
-		if (sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
-			break;
-
 		prefetch(skb->next);
 		list_del(&skb->list);
 		*delta += skb->truesize;
@@ -2207,9 +2203,7 @@ static bool mptcp_can_spool_backlog(struct sock
*sk, struct list_head *skbs)
 	DEBUG_NET_WARN_ON_ONCE(msk->backlog_unaccounted && sk->sk_socket &&
 			       mem_cgroup_from_sk(sk));

-	/* Don't spool the backlog if the rcvbuf is full. */
-	if (list_empty(&msk->backlog_list) ||
-	    sk_rmem_alloc_get(sk) > sk->sk_rcvbuf)
+	if (list_empty(&msk->backlog_list))
 		return false;

 	INIT_LIST_HEAD(skbs);
---

Note there could be unexpected side effects, it would need a bit of
testing in fast and slow env with/without drops, but on the flip side it
should also solve the more problematic "receive stalls when 'ack_seq' in
backlog_list"

/P

