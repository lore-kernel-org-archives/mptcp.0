Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9EE36AB77
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034582; cv=none; b=UuHGMIsC/1cd2tOM6ZPVBqnqMNxJZfzZm/xHJnneNiDWbZBKzh25+yMWb9KSBpGyJuVOMRzcwhdYidYFr5hqI9xLzM5P3valTBqHaST7HD/oAQVnGCSnGvVkPge39Ei2MdR4EwlVFPHLY1G7NG7RQyOwRvy9G81WchBwb5a2UN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034582; c=relaxed/simple;
	bh=RkrVMNdlnGqKMwKp+gZZrJ2jV+HN3CiJzVI2/xLg39w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=vE4bGo1lUxgW+PcJvtL78cjUGYEcqwGidhQRUzUf+hV/VUfrADR8XjtkvHIPd93r6VUXQSk8dzl+3lqkawEoU+bfGcJx2+/jP3IJu3WA+SGN3PZFal/td5hsTwkWfxreiatUpY8YmsELTsWfZ35YqU/98pytYgB0RyvBc1qfPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEfNXKft; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEfNXKft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786034579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0gJaJg+Sgnkf8o6vg6z0U/xt4tvRo7aqhBR/GyGLmkI=;
	b=PEfNXKftJvovS4l83mHRaDultysqIJH5Q/a7vVqT0F5SIvdry2gR/RmA1ht5hsQqatpQxL
	+GoQNSY5RMJ9fc/JaNel4iV7sFDX3SNKcZ9Uk81FTQ+wpRO6gb4iwHMTyU20p7HIHLT8RL
	7mGhDD1QLaY6BESFY672SANxU3DYDbc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-ZOItsvLUNxWgQBe2ew6SiA-1; Thu, 06 Aug 2026 12:42:53 -0400
X-MC-Unique: ZOItsvLUNxWgQBe2ew6SiA-1
X-Mimecast-MFC-AGG-ID: ZOItsvLUNxWgQBe2ew6SiA_1786034572
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-472c330e555so1179325f8f.1
        for <mptcp@lists.linux.dev>; Thu, 06 Aug 2026 09:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786034572; x=1786639372;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0gJaJg+Sgnkf8o6vg6z0U/xt4tvRo7aqhBR/GyGLmkI=;
        b=qfsIk1eI2xw7qmLrcKn6BwKtd9ah+Ntxm8/Y2Mcl7ioYUsGSnJ67enPfA+YuNksAMA
         Fa4XaB0UIbwg+0eIxehfBXgbACxT2RQq0g5Yl9+LtofvZ1/FhvYLKt87Wzar+5cqUzO6
         ZC16IiBtsSPexcsP7+d4qqlFCxabQQncRtt9MBW+8M+laBshuv7fZGZEofPcBxrPLWRw
         YoIXC/HrlgbQz846KMLoNCIz/I0qMkDt/zmqYuX7dOXzOp37cq261bhcb7Y4LFB4IUcP
         +2U9Co7qrTPa6jEOnKm9yRtE9zMMXI0zNXkdZ9kyXCINZO5BFu4qpzJmGPAuKL0gUs0Z
         EkaQ==
X-Gm-Message-State: AOJu0YxW9JRx5LrK4MxA6N1lSTRhyjU/qX0hYbXaRPBS9Wrni+HA0mXL
	4dAm+Bbby6LR86099qVe0jpp+LIoLwVGMCPOVHqZaoufhUXWFIa/xY1QVZrPBAjC99uWHjfPxpe
	GQ011TpnlPVHa8I7jILQTeiE04DzRy3RUf7nnMElpNFTHwPTSlrJAwUES5WCWPbq6sT0UWorgy6
	H5cPNujIshtuvvV5LA/03o+XTlQbN2m3Yl6jOirA==
X-Gm-Gg: AR+sD12MkRyO3KQpWzxylzDV1KLlueb6nyKhlnZNmiKgXZFbIUvQwe+p7PtAD6fVMxN
	pFPW9HkRldRUCzg9uGnAeGxX3crYtzpeczUR21udehLtiG20yCn2Cr4a2inSZ4iqtKE5Ad2B/pl
	27YWQ1fYwjAqIUXaGRl/LZy6k+3zuafOVt1ZT80MnD/QDDBpJJNjnSb8yq0Z95NUrg+QIHMncDF
	clFq2OXCH5Y1MAiC0g6UvaRIZdH9iYdjjf8DDYm3G8y6fPGlD36z6JFoC/GniwFeIsJNHZPDY+5
	xX0NGoJ5SeQOHFEtOpuS3gc8kCvn31W9mIeyJDoCc81Mg20PXs0xqOIXzbNhlRSY5voBTIAore5
	bvM8TQs+atcZ4xLujq8rU8vKSc3axkV27VcY4x69wJhWoA8KwqQAJJT1p/ZXU02oR1RwEXH54r6
	4=
X-Received: by 2002:a05:6000:420c:b0:47f:6f6a:6a7f with SMTP id ffacd0b85a97d-47fec512242mr25589350f8f.8.1786034571887;
        Thu, 06 Aug 2026 09:42:51 -0700 (PDT)
X-Received: by 2002:a05:6000:420c:b0:47f:6f6a:6a7f with SMTP id ffacd0b85a97d-47fec512242mr25589271f8f.8.1786034571391;
        Thu, 06 Aug 2026 09:42:51 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b819dsm7681190f8f.16.2026.08.06.09.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:42:50 -0700 (PDT)
Message-ID: <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
Date: Thu, 6 Aug 2026 18:42:50 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
References: <cover.1786026372.git.pabeni@redhat.com>
 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
In-Reply-To: <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: edicur8yIjuDB7UlREVexQft0REXT_gJ-gV8gfZQetM_1786034572
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 4:45 PM, Paolo Abeni wrote:
> When moving incoming skbs in the msk receive queue and the latter
> is above limits, prune it as needed quite alike what TCP is doing
> at the subflow level. The main difference relies in the stop condition:
> since MPTCP does not perform collapsing, it's better off dropping the
> bare minimum to fit the (newer) incoming packet.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Tested-by: Gang Yan <yangang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> v<n> -> v<n+1>:
>   - prune only for new data
>   - reorganize the code to follow more closely TCP
> ---
>  net/mptcp/mib.c      |  1 +
>  net/mptcp/mib.h      |  1 +
>  net/mptcp/protocol.c | 81 ++++++++++++++++++++++++++++++++++++++------
>  3 files changed, 73 insertions(+), 10 deletions(-)
> 
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index ef65e2df709f..2569385bab7c 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -87,6 +87,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
>  	SNMP_MIB_ITEM("WinProbe", MPTCP_MIB_WINPROBE),
>  	SNMP_MIB_ITEM("BacklogDrop", MPTCP_MIB_BACKLOGDROP),
>  	SNMP_MIB_ITEM("RcvPruned", MPTCP_MIB_RCVPRUNED),
> +	SNMP_MIB_ITEM("OFOPruned", MPTCP_MIB_OFOPRUNED),
>  };
>  
>  /* mptcp_mib_alloc - allocate percpu mib counters
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 9271205f682e..3a3425e258a7 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -90,6 +90,7 @@ enum linux_mptcp_mib_field {
>  	MPTCP_MIB_WINPROBE,		/* MPTCP-level zero window probe */
>  	MPTCP_MIB_BACKLOGDROP,		/* Backlog over memory limit */
>  	MPTCP_MIB_RCVPRUNED,		/* Dropped due to memory constraints */
> +	MPTCP_MIB_OFOPRUNED,		/* MPTCP-level OoO queue pruned */
>  	__MPTCP_MIB_MAX
>  };
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 63f2c18bc01f..ec874d2ead6a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -242,6 +242,65 @@ static bool mptcp_rcvbuf_grow(struct sock *sk, u32 newval)
>  	return false;
>  }
>  
> +/* "Inspired" from the TCP version; main difference: stop as soon as the MPTCP
> + * socket is under memory limit.
> + */
> +static void mptcp_prune_ofo_queue(struct sock *sk,
> +				  const struct sk_buff *in_skb)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct rb_node *node, *prev;
> +	bool pruned = false;
> +	u64 mem;
> +
> +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		return;
> +
> +	node = &msk->ooo_last_skb->rbnode;
> +
> +	do {
> +		struct sk_buff *skb = rb_to_skb(node);
> +
> +		/* Stop pruning if the incoming skb would land in OoO tail. */
> +		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
> +			    MPTCP_SKB_CB(skb)->map_seq))
> +			break;
> +
> +		pruned = true;
> +		prev = rb_prev(node);
> +		rb_erase(node, &msk->out_of_order_queue);
> +		mptcp_drop(sk, skb);
> +		msk->ooo_last_skb = rb_to_skb(prev);
> +
> +		mem = (unsigned int)sk_rmem_alloc_get(sk);
> +		if (mem <= sk->sk_rcvbuf)
> +			break;
> +
> +		node = prev;
> +	} while (node);
> +
> +	if (pruned)
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_OFOPRUNED);
> +}
> +
> +/* The stack can't drop packets for fallback socket at the msk level, or the
> + * stream will break.
> + */
> +static bool mptcp_can_ingest(const struct sock *sk)
> +{
> +	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk->sk_rcvbuf)) ||
> +			__mptcp_check_fallback(mptcp_sk(sk));
The above should obviously be: 'likely(...)'

@Matttbe: please LMK if you prefer a repost or you could adjust that
while applying to the export branch.

/P

