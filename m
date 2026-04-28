Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90704436367
	for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 17:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396955; cv=none; b=I5K6hjvAy79wnwxkNiicayx/Ho8CKj9kSDH5N8mdA3sZcomnN0HU68py0o02qD2j1saLRnl9sW5fq7klPHwwmIYrFAeuD7p/qTYbwSuybw8A9atHHCMNqL/1YgTFyf5S+ZQk2Iq3DPy8Q7wwVEdR7JmadXE3gaio/dFS0s9e2HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396955; c=relaxed/simple;
	bh=Sdu1+sFEjY/+9cSF8CkZL8v02n31Djq8nZBoEovvjH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=CUjiWXq5MdD9xC5cRB3NtFmjzynFsGhqrb+FjKj86O/xUFcBrJeni1sxlrj1iX3LO4luuElr/4+p1yV4qmnwDgYxSdQnsLSYHjtVStEIRHCTBjswnNQUcE3+KPMXwCMNB8a6iukrHmwDdVJVlfjFscZQCbhA2JDRlQ1DVWZCsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bD+f5BVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD+f5BVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777396952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jrutjh8gf+EN4MkJZkJQBqbjX5fzctUFg1Q5h8ewVZ0=;
	b=bD+f5BVC/Kv1qM1dD+Ho17VSJ+40DqxZwVmMF1xAke1i9dtx7CB0tssx2HpKpGiHqcwcw0
	SZxuguSRP0D9Ey/loi1tym9jstp0eagIq5/WxOcwuYN3R3+d6lSi2FMeAU3lJV++wWv3Qs
	3GzMJsexrHsc6E9OT+PVIvpCiKdnkbU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-brkBpUgINISv3wCCvVX-RQ-1; Tue, 28 Apr 2026 13:22:31 -0400
X-MC-Unique: brkBpUgINISv3wCCvVX-RQ-1
X-Mimecast-MFC-AGG-ID: brkBpUgINISv3wCCvVX-RQ_1777396950
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a2ff53aso5770156f8f.0
        for <mptcp@lists.linux.dev>; Tue, 28 Apr 2026 10:22:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396949; x=1778001749;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jrutjh8gf+EN4MkJZkJQBqbjX5fzctUFg1Q5h8ewVZ0=;
        b=K/BUFg2JrhODQqiG0Xytk/T4IbqYycxd2ZfTdXZcuhPmkXFxTeiYoHDASaaWofAjhj
         P785YyB+CI1wk6e6ty3hmVVEk1Tv92Uv4j8B2JtIpt7zb9vN+qHOjrFLU9JLa7KOfvwd
         XOmZayVMKlQiYLFr2MB1n3LN5c2X/jJM1K8OLJTaB+Y7vEGXclrVIdUhNOalAjbz7ddq
         jo1VAzjczOOfD5ACVfleJuV4u51xA+rardlxn0SN+AKV2AmuSz2aEmblNYzgyMt8XYpl
         IYBmKAO9Su2zZ9Xu1meOEvBt2h9mlL1BHCaLRc0b5YTHG0jgAGzYJkume5g9iXPLro7+
         J/Gg==
X-Gm-Message-State: AOJu0Yxpc7p8JJ53hVDcC9Lzrdg/mykFs6/efCQfLao/5El6SLmqZOPp
	w+deeJl6Mlw+Vb38UferS3HMoN18ShLKA3Hw8hqMn4UmH0uYgnVVJrpsfIKddIlF8K5w0K/fPnX
	TpJ2YPpg9r4cvinmpuLVOUH1MyJTFo184TvDcAVSVC9vchEV9VDEhnSMqB9pWcrvuc3FD9jos4Q
	YBeMGfG7jDXDG2GNLGbv6EwHOs6wmMbXzy5E3W5Q==
X-Gm-Gg: AeBDies3puLYlarmalTS882QkyL2EczdrUb7Qh3NqJfP3N585ZATohqeSST0IYTMHgu
	tgFd5zfy0xfG6DLDh93S1jdofCjKLOaK6jWtNf5GfZeEUc+NLmt7oXabHAZfJQ5FDITAI9sIeUM
	YJDpb3c00OdbDFXv+3c2S7olO0k0z3GzOCEvSVr+EZOL7xk7e/oL97/Y/OsyZEFK1VBQbmFWLeZ
	qmCPHjVuMyxTkMa8ajXq3vrPFQUd6cRlPRDzd+G6uWfVqOatX4nOjErPEBy851jkp0CLqvgs0Sb
	n7MvzVn084/1Dc4Jis/AsrJ9YNKnCR4IUgxYOkJNUdbNnXVVUP6biMlwBZICK8rcmboIsMP5hxy
	OzWhPeq+Y/0pPNd9LvkIxKYiEuS7XCsL+mfrFwkJSGn4eCHFmmVesVCz3rN2G2BF/dA==
X-Received: by 2002:a05:600c:8b85:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-48a77af3dcdmr65477255e9.6.1777396949293;
        Tue, 28 Apr 2026 10:22:29 -0700 (PDT)
X-Received: by 2002:a05:600c:8b85:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-48a77af3dcdmr65476495e9.6.1777396948544;
        Tue, 28 Apr 2026 10:22:28 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc26b69sm457655e9.10.2026.04.28.10.22.27
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 10:22:28 -0700 (PDT)
Message-ID: <2feee48e-27d2-4e45-a925-4ee9195cbea8@redhat.com>
Date: Tue, 28 Apr 2026 19:22:27 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v2 00/10] mptcp: address stall under memory
 pressure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
References: <cover.1777318959.git.pabeni@redhat.com>
In-Reply-To: <cover.1777318959.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Mfu_vmNXTOPd7iWOKgO80c7VPhnRjWBLklf6mbhlRHY_1777396950
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/27/26 9:51 PM, Paolo Abeni wrote:
> This an attempt to fix the data transfer stall reported by Geliang and
> Gang more carefully enforcing memory constraints at the MPTCP level.
> 
> Patch 1/10 moves the bound check before entering the TCP socket.
> Patch 2, 3, 4 and 5 are cleanups/refactors finalized to safely re-using
> TCP helpers on MPTCP skbs.
> Patch 6 makes TCP pruning related helpers available to MPTCP and patch 7
> makes use of them. Patch 8 addresses an edge scenario that could still
> lead to transfer stall under memory pressure.
> Finally patch 9 and 10 improve the MPTCP-level retransmission schema to
> make recovery from memory pressure significanly faster.
> 
> Note that the diffstat is biases by the quite large patch 4/9, which
> contains mechanical transformation of existing code; "real" changes are
> noticiable smaller.
> 
> Tested successfully vs the test cases proposed by Geliang and Gang and
> vs the selftests.
> ---
> Notes:
> - Sashiko apparently can't understand that mptcp_data_lock() &&
> sk not owned by the user-space is equivalent to the sk socket lock. As a
> consequences marks incorrectly as racy a few accesses under the data
> lock to the sk_rcvbuf.
> - mptcp_join with "4 subflows with under pressure" may require longer
> than default timeout, as the transfer in such condition can be really
> slow.

Sashiko says:
---
> +static bool mptcp_over_limit(struct sock *sk, const struct sock *ssk,
> +			     const struct sk_buff *skb)
> +{
> +	if (likely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)))
> +		return false;
> +
> +	/* Avoid silently dropping pure acks, fin or zero win probes. */
> +	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq ||
> +	    TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN ||
> +	    !after(TCP_SKB_CB(skb)->end_seq, tcp_sk(ssk)->rcv_nxt))
> +		return false;
Will this silently drop 1-byte Zero Window Probes (ZWPs)? For a standard
1-byte ZWP where seq = rcv_nxt and end_seq = rcv_nxt + 1, it seems it
would fail these conditions, returning true and dropping the packet.
Also, if mptcp_incoming_options() returns false due to being over limit,
does this cause tcp_data_queue() to execute __kfree_skb(skb) and return
without sending or scheduling a TCP ACK? If so, could this bypass standard
drop handlers (like goto out_of_window) and cause connection timeouts by
not informing the sender of the zero window condition?
---

this is wrong: zero window probes use already acked sequence numbers.

---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 718e910ff23f..77d7c7fbe8ef 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -739,7 +739,7 @@ static bool __mptcp_move_skbs_from_subflow(struct
mptcp_sock *msk,
>
>  			mptcp_init_skb(ssk, skb, offset, len);
>
> -			if (own_msk && sk_rmem_alloc_get(sk) < sk->sk_rcvbuf) {
> +			if (own_msk) {
By removing the sk_rmem_alloc_get() limit check here and moving the limit
enforcement exclusively to mptcp_incoming_options() in the TCP slow path,
can this bypass the MSK receive buffer limit for fallback connections
taking the TCP fast path?
If an MPTCP connection falls back to plain TCP, it appears packets take
the TCP fast path in tcp_rcv_established(), bypassing tcp_data_queue()
and mptcp_incoming_options(). These packets would go directly through
tcp_data_ready() to __mptcp_move_skbs_from_subflow(), which now
unconditionally moves the packets to the MSK.
Since ownership is transferred to the MSK, the subflow's sk_rmem_alloc
would remain near zero, preventing it from falling back to the slow path.
Could this allow unbounded memory growth in the MSK queue if a sender
transmits an infinite amount of data?
---

This is wrong, mptcp_incoming_options() is always invoked even for
fallback msk, as msk explictly disables the header prediction.

---
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 28a7482b3887..26b9a23c63a9 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -352,9 +350,9 @@ static void mptcp_init_skb(struct sock *ssk,
struct sk_buff *skb, int offset,
>  	 * mptcp_subflow_get_mapped_dsn() is based on the current tp->copied_seq
>  	 * value
>  	 */
> -	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow);
> -	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;
> -	MPTCP_SKB_CB(skb)->offset = offset;
> +	MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
> +				     offset;
Could this cause packets with an offset greater than 0 to be incorrectly
dropped?
If map_seq represents the sequence of the entire SKB rather than just the
unread data, and __mptcp_move_skb() checks if
MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq, valid packets with an offset
(due
to TCP retransmissions or overlapping segments) might fail the in-order
check and be permanently dropped as old data.
---
this is wrong, the main point is that this series has a functional
dependency on "mptcp: do not drop partial packets".

---
> @@ -4364,7 +4355,7 @@ static struct sk_buff *mptcp_recv_skb(struct
sock *sk, u32 *off)
>  		mptcp_move_skbs(sk);
>
>  	while ((skb = skb_peek(&sk->sk_receive_queue)) != NULL) {
> -		offset = MPTCP_SKB_CB(skb)->offset;
> +		offset = msk->copied_seq - MPTCP_SKB_CB(skb)->map_seq;
>  		if (offset < skb->len) {
>  			*off = offset;
>  			return skb;
Similar to the issue in mptcp_inq_hint(), if copied_seq evaluates to 0
due to
deferred initialization, could this offset calculation wrap around?
Since map_seq is the crypto iasn, 0 - map_seq would wrap around to a large
u32 value. This would cause offset < skb->len to evaluate to false and
could lead to unconditionally dropping valid, unread SKBs via
mptcp_eat_recv_skb() when called from __mptcp_read_sock().
---
This is wrong; due to __mptcp_sync_rcv_sequence() `copied_seq` can be
zero only if map_seq is 0, too.

---
Also, what happens if __mptcp_push_retrans() successfully queues some data
but returns a len less than dfrag->data_len?
The loop will continue and pick the same dfrag again since retrans_seq
advanced but still falls within the fragment. However, looking at
__mptcp_push_retrans(), it appears to always start from the beginning:
static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag
*dfrag)
{
	...
	info.sent = 0;
	info.limit = READ_ONCE(msk->csum_enabled) ? dfrag->data_len :
						    dfrag->already_sent;
	while (info.sent < info.limit) {
		ret = mptcp_sendmsg_frag(sk, ssk, dfrag, &info);
	...
}
Since it doesn't take retrans_seq as an offset, will this incorrectly
retransmit the first len bytes of the fragment multiple times, artificially
incrementing retrans_seq until it exceeds the fragment bounds, and
ultimately skipping the tail of the fragment entirely?
---
AFAICS here the LLM is allucinating a lot, as the main termination
condition for that loopis `dfrag->retrans_seq < than dfrag->data_len`

The other comments looks valid and I'll try to address them in the next
revision. I'm not sure how to guide sashiko on the above, I'll try
adding more notes in the cover letter.

/P

