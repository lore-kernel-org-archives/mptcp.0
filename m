Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14533B6EF
	for <mptcp@lists.linux.dev>; Sun, 10 May 2026 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778446142; cv=none; b=PyAQtXXyHQnOvf1vNeo9yzd06Y36J3EU2dPHcxROyobdH2orIQYVXeyeRRfGe9SwD4hBoIoma/tA7NYJ9WoViFAO6rr1MY964ZDyszLd03EeyhiayEwzB8nQIN1NaX0lECixTkYulya1KGb+KHc19gpwbNclh3VufDDI4bPG2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778446142; c=relaxed/simple;
	bh=3WTaxlfGjGA/cnDsj6hiOcLNQ5jnRyDwNbeFSDk+q4k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dSRgS/3jIJmyq6OgK68dbCLvc+lEn7sSOM6Ahhv2jGhNKeJrD4tcshrosoYPVWfHpFEcyiXK05h5rFvD7SBvgAnX2ucbnv7QwZiPlTJhy9aCbL8YNb327pMiV2jlr+iqTKO08PTThUM/ghFC0Zx/c6QuD5X8FsQig47O/mf9hKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK5O1w8D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK5O1w8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778446139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVGWVX09nwpG+x2FLeY297RFYPCKYpiASjoxf6gaYug=;
	b=dK5O1w8DvRfNCFU+zCyO1R0kWkMI0OSg2+QL85SIvE1GSyV8sQY8hZuZoxTOYj4xVdL8M+
	UGrRVvc0aqXCrI20XaHZ4ZIb+G67DTtqMNgzntTGn0KRfSdq3DRSRauqIrhIG5SpkJ7Y/M
	LOw6q8biOR6kfoVBuRquWY2vXOUUedQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-H30paXH2NgSJAFC77b4Zow-1; Sun, 10 May 2026 16:48:58 -0400
X-MC-Unique: H30paXH2NgSJAFC77b4Zow-1
X-Mimecast-MFC-AGG-ID: H30paXH2NgSJAFC77b4Zow_1778446137
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44b186b715aso2311835f8f.0
        for <mptcp@lists.linux.dev>; Sun, 10 May 2026 13:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778446137; x=1779050937;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bVGWVX09nwpG+x2FLeY297RFYPCKYpiASjoxf6gaYug=;
        b=tSCrr4lndqz9yI2WSyRv3V979cL+euTOxCnNk0ydgjwRLSMc27QhaF0qQbpX+XymB8
         p2V71dLesQ3qts4OpuCCloCN5egL4ffKohdLXbhsGM+i6QEI/F+Y2B0hFyUPrxoNmiG1
         sFZsnIlFPbJpHatwg7jovEU58wVFPw0OBl9d+knxU/4TeRroE6yocMqE2yvfbQe8QW1c
         cmEXa5Cyc4vqmA+Re7va84fgc7ORLo2bd+KZ9PUwhjvGB3SARrQJSXIyhF0DInAySwVu
         XZ7Gv+hae2kuS8QVrAAWSR5Hl373eNCxHssMORyb/XKX4lckYIv5SoDJzM0yxYoIXpBv
         TF1Q==
X-Gm-Message-State: AOJu0Yxr5Oo6GbzeViFdYz2ZUhzLhvm7Zdq8THquC3Dxunv62Gy1SLTE
	+A4T7v5YtJ9m12deDo64ndlktkW7GmLcjJOkRi/N7p91OK1zfamn55enDyQDLwOpHzcl13ZsR52
	Cb8jEKV2td/ArHsvMGpGtVzxC1MdwrcB6ZsyJyWyK+iyYbPHLKJlS6b17GVUYa0JOT1a3OZNi/9
	g1E8KAuXbwThJ5aYzUhebaqf2hTffsBgxjQ8GCDg==
X-Gm-Gg: Acq92OEWVYUzaYYGqjesl7C79f43xA+lQNxgyBzF4CFW7xGfe1pw6aL4HRmUqvvPhPv
	xtVmcG/m/qFvcDZVBE/5ByPW41jstOc+JGyQYNqoygY/EALYDZIysvVJOjHPxphdSij9v68L6BL
	jU2GMIXf99o5SnAUwl2wKd9w3V87wycaoumdBTS3bBrpUYlOY3/IK0YQSXxQVJEy+i1XQphnKBj
	/yssDHHnsdQAHFlPVfG/f6HLocheJetX3UlGAFEZljhPzofKgWDR7xXzGo2F/aOv+IGHcasnn8V
	byTNVUVHVE5TFI3nayR00DUM5lbelMLjPASWWIk+IdxnlHSgWYC5aAlMIhVhDoJPvMGutEJ+Jxa
	Ivnsw6omMYGEbT9XEVtxaiGOX2QEIK90/Y24WEb2GEtPbrks74S0nnokQ
X-Received: by 2002:a5d:64e3:0:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-4515d6bbc06mr31931709f8f.36.1778446136998;
        Sun, 10 May 2026 13:48:56 -0700 (PDT)
X-Received: by 2002:a5d:64e3:0:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-4515d6bbc06mr31931686f8f.36.1778446136414;
        Sun, 10 May 2026 13:48:56 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm24697380f8f.37.2026.05.10.13.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 13:48:56 -0700 (PDT)
Message-ID: <2e6d1ae5-9a11-4675-830a-ffa1ba44d1b4@redhat.com>
Date: Sun, 10 May 2026 22:48:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 09/12] mptcp: implemented OoO queue pruning
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <cover.1778312843.git.pabeni@redhat.com>
 <2f2a0f359e54d949cf90ebb92cc3886693b00bda.1778312843.git.pabeni@redhat.com>
In-Reply-To: <2f2a0f359e54d949cf90ebb92cc3886693b00bda.1778312843.git.pabeni@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rUz-VOn8ilR_g9W1r9juvaSQpO5xhp_7kfBEd83RIwY_1778446137
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 9:48 AM, Paolo Abeni wrote:
> @@ -1207,7 +1238,11 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		__mptcp_data_acked(subflow->conn);
>  		mptcp_data_unlock(subflow->conn);
>  
> -		if (mptcp_over_limit(subflow->conn, sk, skb))
> +		/* Will use ack_seq as limit for OoO pruning; any value would do
> +		 * as OoO queue must be empty.
> +		 */
> +		mp_opt.use_map = 0;
> +		if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
>  			return false;
>  		return true;
>  	}

Sashiko says:

---
Will this cause an uninitialized memory read?
The mp_opt struct is allocated on the stack without initialization in
mptcp_incoming_options(). Since use_map is a bitfield, assigning 0 to it
results in a read-modify-write operation on the uninitialized word, which
could trigger KMSAN warnings or other static analysis alerts.
---

No, AFAICS KMSAN handles bitfiled just fine

> @@ -1287,7 +1322,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		return true;
>  	}
>  
> -	if (mptcp_over_limit(subflow->conn, sk, skb))
> +	if (mptcp_over_limit(subflow->conn, sk, skb, &mp_opt))
>  		return false;
>  
>  	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f03f967d8679..d9aab7bbff98 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -386,6 +386,64 @@ void __mptcp_sync_rcv_sequence(struct sock *sk)
>  	MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }
>  
> +/* "Inspired" from the TCP version */
> +static void mptcp_prune_ofo_queue(struct sock *sk, u32 seq)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct rb_node *node, *prev;
> +	bool pruned = false;
> +
> +	if (RB_EMPTY_ROOT(&msk->out_of_order_queue))
> +		return;
> +
> +	node = &msk->ooo_last_skb->rbnode;

Sashiko says:

---
Could msk->ooo_last_skb point to a freed skb here?
Looking at __mptcp_check_prune() below, it calls xtcp_collapse_ofo_queue()
which can collapse and free skbs in the out of order queue. However,
xtcp_collapse_ofo_queue() only updates the ooo_last_skb pointer if it
reaches
the end of the queue.
If xtcp_collapse_ofo_queue() hits its early exit condition:
net/ipv4/tcp_input.c:xtcp_collapse_ofo_queue() {
    ...
			} else {
				sum_tiny += range_truesize;
				if (sum_tiny > sk->sk_rcvbuf >> 3)
					return collapsed;
			}
    ...
}
It returns without updating the ooo_last_skb pointer. If the skb that
ooo_last_skb originally pointed to was freed by a previous collapse
operation
in the same call, could this result in a use-after-free when dereferencing
its rbnode here?
---

No, xtcp_collapse_ofo_queue() does not currupt the rb tree status.

/P

