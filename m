Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF633403F5
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 07:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954159; cv=none; b=HTFibL7BHPiBcgLl0qGpQecio46FRWW8DTjZIuxApc4N/9z4FSbPcUeRCyBvVLNmDBSrl32hKHvOqf1pLHHdzHjNZ49lAiRcI0qjHOj58clONTSzu0pVQxVe5JtCuw8xoZtvQiNkJv7p595aR6YasEoEswtXLOu4P6JYarh2dSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954159; c=relaxed/simple;
	bh=eCjgGddXWK80qW/LbLm3WTMkDX9ITd0hpFZu72NP+eY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RWQnhmoQwedYAPIv4zBDhJvS2/n+OAA1zifwjW+UBtifvvPoWJlOtfD3zi2ZuBkYFlpJzg3Dheqw4kHcitZB8GOGBXL+lQfI6D94LiCScAwYE0VMyhGF/T5LXZJKbure2VbzS6CbOleeXy4A1mrfU2Hq9GjDDW1U7b9vM9RtUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOZUG5xW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOZUG5xW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779954156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7refMhM2ayZegTGBE3B1a5KuH8whkZHm9kh/K5TUMIg=;
	b=dOZUG5xWJyj1gWFcimkbHw5vRGksSDNtOkdTI5E6tvTZQdaB7VmiMWJ5mVQMcAAnXo0q2R
	onyCw/u6WY9RTzqynI+/V5WhbTHke64+4VHm9CoBwt9RSUK8pmJQRSB+P46KlC8zVWxdNY
	pdIKQrjxBlRYMoetC867lbIUHLobo3s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-xT5e1CUqMp2c5zPntybUgQ-1; Thu, 28 May 2026 03:42:34 -0400
X-MC-Unique: xT5e1CUqMp2c5zPntybUgQ-1
X-Mimecast-MFC-AGG-ID: xT5e1CUqMp2c5zPntybUgQ_1779954153
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44696b11265so15167066f8f.0
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 00:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779954153; x=1780558953;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7refMhM2ayZegTGBE3B1a5KuH8whkZHm9kh/K5TUMIg=;
        b=dCEs4ET7ey4KW267izwg4JzsRwglUeTN6R2BzonKE0INvgxtRoyPlV2HObNux3KZJB
         T4UXUqZ4Nt3mzfxFdEnmOdVpMiX2njHsxfjjAaP5JxHb3POnr+3ZbCdQKQigqF6bX554
         OI5rEGv4f4uXWQWLfXgc0Q5ydCohllULr17eMFHXHBaW5wyHAAiEGLrYAj9D5UR2a5Md
         5yyNdAfb80UA3bx99SPNVqYSfz9R0VejWd3bE0S7x6cdUkPGZsi+tWtieI+2QC+pOnZJ
         jIyYGS5QCMCk4EKbDAJEuV1sBEKhNbaye894h1MqnRMsScpGw8uHKPII3qjSFiBdNo2k
         OzCg==
X-Gm-Message-State: AOJu0YyJEclZnJaJM14uGF1ZG633gNzcukETmBNUT1lmc5NLX5ZlQiDR
	O6iNV6np5BUucHLlANO12c+2mQERdEmQs6gmTEm1Kyr1ZkI/OQFtsNtU3sr5ZMq5OSq06483DZ9
	5n/A1mzq+JjtAsqFEKo0Dd6TNyl0UyX+swyDtsTlE1BPM7YCr1zoPRn3J6rfF4RV9ZCukA6WKqb
	Ilb6s4og+liD7nSaYNaQ/1zkGDfU7tY6n8uvy2pw==
X-Gm-Gg: Acq92OGvWhQLaDxvObou1jlUnyigAZIaXjdOjerNOByIj72tzgqSZImOuME0ILprx+u
	wBaPi0OLjBxybeOI4wngFN9iPZmXm5UArqrB7WB90LrqX4CivjLqoZ7mNqeBMnhzANPNA6TySqr
	qbZZ0SANPf1QrnnVutTSZP8UFGuuboToLsljYn5GWoDoRktcBH405gxVlLVz+JDWk/v1qCqucXN
	EmwJXObOxoEbsxDHs4S34+yg+qxynMBf1ERelTK6htIHUGGzI/CJjR/jI8NNh0V2uzOQTXhgOkY
	LY4tvL/fxVqG80Y9XWIuVTrUiUQjwT1jxM11pEyVpwTIEekjNBwerFwIFyiKb3uJiSHe/6UGYIf
	G6krjKBFs/0OHio/GgY0BxH8iuen05OGn2SaQSjE2MPTLSMMAvMbjD5ksq53/jNg/eg==
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id 5b1f17b1804b1-49050580d79mr378848355e9.17.1779954153167;
        Thu, 28 May 2026 00:42:33 -0700 (PDT)
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id 5b1f17b1804b1-49050580d79mr378847845e9.17.1779954152604;
        Thu, 28 May 2026 00:42:32 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909264fbf2sm25009175e9.5.2026.05.28.00.42.31
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 00:42:32 -0700 (PDT)
Message-ID: <0bdc2f46-ed14-4066-9af9-564fb02ed1a7@redhat.com>
Date: Thu, 28 May 2026 09:42:31 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mptcp-next 2/6] mptcp: explicitly drop over memory
 limits
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
References: <cover.1779876523.git.pabeni@redhat.com>
 <6ccf1a553f1e5a3ae63b5a5608f774623d71c9da.1779876523.git.pabeni@redhat.com>
In-Reply-To: <6ccf1a553f1e5a3ae63b5a5608f774623d71c9da.1779876523.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eNMacN_u6UYZKPif-e1UsyBOlXeGcI9K7tg9iTdeJFw_1779954153
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 12:45 PM, Paolo Abeni wrote:
> Currently the enforcement of the rcvbuf constraint is implemented
> when moving the skbs into the msk receive or OoO queue, keeping the
> incoming skbs in the subflow queue when over limit.
> 
> Under significant memory pressure the above can cause permanent data
> transfer stalls, as the skb needed to make forward progress can be
> stuck in a subflow queue.
> 
> Over memory limits, drop the incoming skb, relaying on MPTCP-level
> retransmissions.
> 
> Note that fallback socket must perform the limit before the skb reaches
> the subflow-level queue, as dropping an in-sequence already acked skb
> would break the stream.
> 
> This is not a complete fix for the stall issue, as the drop strategy
> needs refinements that will come in the next patches.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v7 -> v8:
>  - removed non fallback check in mptcp_incoming_option(): that is an
>    tput optimization (avoid rejections) for a slowpath case (sender
>    is misbehaving) and needs too much additional complexity.
>  - move here from later patches mibs definition
> 
> v6 -> v7:
>  - fix sign extension issues
> 
> v4 -> v5:
>  - fix possible u32 overflow in mptcp_over_limit
> 
> v3 -> v4:
>  - schedule TCP ack on drop
>  - enforce limits in __mptcp_move_skb() and __mptcp_add_backlog(), too
>    but only if not fallback.
> 
> v1 -> v2:
>  - deal correctly with tcp fin and zero win probe
> 
> RFC -> v1:
>  - limit vs actual buffer size
>  - use CB info instead of skb->len
> 
> Note that:
>  - this needs the follow-up patches to really fix the stall
>  - sashiko can assume ZWP carries unacked data and may be silently dropped.
>    AFAIK that is false.
>  - sashiko apparently can't graps mptcp subflow never hit the tcp rx
>    fastpath, and the mptcp_incoming_options in tcp_rcv_state_process
>    is hit, the peer can't transmit any more data.
>  - the memory comparison is intentionally very rough, as
>    the msk socket lock is not currently held where the condition is
>    now enforced. This should require some refinement, shared as-is
>    to avoid more latency on my side

Sashiko has some comments on this patch; TL;DR: can be safely ignored.

---
Does this code incorrectly handle transient negative values?
sk_rmem_alloc_get() returns a signed int. If sk_rmem_alloc transiently drops
below zero, assigning it to a u64 causes the negative integer to sign-extend
into a very large positive 64-bit value.
This would cause the subsequent limit check (mem <= sk_rcvbuf) to
evaluate to
false, erroneously dropping valid packets.
---

negative sk_rmem_alloc() values are only possible when the amount of
memory in the queue is above INT_MAX, i.e. the value is really a large
positive one. The above concern does not apply.

sk_rmem_alloc() can raise above INT_MAX when sk_rcvbuf is INT_MAX as the
RX path accepts one more packet above sk_rcvbuf.

---
Does this code leak memory charges and sk_forward_alloc credits?
mptcp_borrow_fwdmem() transfers the skb's truesize from the subflow's memory
to the MPTCP socket's sk_forward_alloc. However, the skb's destructor was
cleared by mptcp_subflow_lend_fwdmem() prior to this.
If the skb is then dropped via mptcp_drop(sk, skb) before skb_set_owner_r()
is called, the skb is freed without triggering a destructor. The truesize is
never subtracted from sk_forward_alloc, and global tcp_memory_allocated is
not replenished.
Could this allow an attacker to repeatedly hit this path by sending data
while
the buffer is full, inflating sk_forward_alloc infinitely and causing a
system
memory exhaustion regression?
---

Pre existing because we already have the exact same drop path.

May deserve a follow-up patch.

/P

