Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0E233704
	for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865932; cv=none; b=pNUO8ol8rUjRtWBw+GP1/BeZF5deIvIwa9lph3RsGT0rqe2gRl8sqZVvubd4EnESrPGD81iMP/vrKEdvpcz9g2yOu7HylkRxfIS/2OBus6XXLdnBpEmaLSTTeuJHUxuz3UZtoNVqn6j0/UfJtGJjP7oZOo5bo87XBnxdfW6t9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865932; c=relaxed/simple;
	bh=FinX88tVtqohGgVWhbO3j5h4eWT/4q18+66GEVCg1kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPMtAKecBD+fskZeTOhQQElZaFPl8b/RE31IsO2TYkC1/Q0jjJjw82n9w2h210PqpfE86RM4bb1ElT27/PaWvoQ6Bawkex/yp6uFWib20zPO+82eUrx9IhAWusjlacNXWk5lWkC44O9vAcJmTIVSB7yh9cooy1OLg2LElSb117g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fqz5XWz1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqz5XWz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776865930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qFJ3Oe6hSxhMeBbeLsUE7Rx9fPyR4qwpGR0YXzFQvsk=;
	b=fqz5XWz1+b1t6yR9dm4End4UjvhPAdvMwkWYpru5zhInuZMabW3JJSss7DUhjsfKD4529/
	Fi7gSUF785ewFwx6pS4Cr0bGSOXzTFagk+Px1U2IqMDtFIhRjH/vRlB8cN2q1wwt5MV/jU
	MtPBAzErLhyhwB4pW6QckwMEdgU/EZc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-711-7pfeIx2OPqCkTV-TdKmEHA-1; Wed, 22 Apr 2026 09:52:08 -0400
X-MC-Unique: 7pfeIx2OPqCkTV-TdKmEHA-1
X-Mimecast-MFC-AGG-ID: 7pfeIx2OPqCkTV-TdKmEHA_1776865928
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dbd1866b66so13209712a34.1
        for <mptcp@lists.linux.dev>; Wed, 22 Apr 2026 06:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776865928; x=1777470728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFJ3Oe6hSxhMeBbeLsUE7Rx9fPyR4qwpGR0YXzFQvsk=;
        b=Z8A31jJhv9dVZRxX7l1HJvQPw7VO1bHNVotnxpPnfkmGc24mypq3q112RG+n7FMoBq
         VaoMZ5JWx/eOoLHJvjj4pAq2AOclH08HFpzIi72ITBmM/jDmc+cSN80oGuGbqKPfWLHr
         D11vVAc6+jv3ULimUQDOd4DMi2Su33zzVg5os8XfH/sBbsFmrdTYinmH9mowiNQJ435s
         xvT1ihEOZ3P1r/SHWZRrt3NSzmX9CFrceERhUlYGuakqVvlqj5vSb93SjG14Bwl7Nar2
         OVfddS7im1B5+fKuSGXf7UE8sMt7RgAbxxzoAGKl+LIGnd+tAojj2lby6Da5wDURt+FH
         L5ew==
X-Forwarded-Encrypted: i=1; AFNElJ8F33KD+QROgpZbr6Y7g7Sqs0CvtI6H5sSYFLHeYir03U2iDk4A1UhpcDPJbRjeiIR5EcAAEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAHukQqQ84R9hd6QLA+/CWCg44goRXVusIef2rn0Ml5CrqZbw/
	Zq16lmxOTR9ASfXnHueKt23wqNvhMNhednoHOY1eAyLSObk1piW+ADE2Uj/k5Iw/nRVy4hsNKl+
	4wyPZZUTkbpMcd51bHZnGz3X0qN0NXGzMmNwmqceoBsbvh5rdVL9RDAot
X-Gm-Gg: AeBDieuS4IA5sY929cXjNj+hkAGQX8Vz0ALmrnR7V7ZodtbUP0Zikdic3i/bqSlP5wh
	AEMbglcBO5QkeHIhS1uumVgprwiO+0jjzt0rRKIHzhUgFFkpvjGZpoZb5uYCnt2A1jiS7OIJugo
	rB7l66z2c3185kRW65QYsEBvc5OFdq2+lib/3i4ffQHdvxjIUOhRdn5mYFoDbIUfn2X2/6qFwpg
	wHODoOryU7kJLruWVDqTI8Zj1O5cmdKeRC2PSRaVfgyqxRNUDi+dIBwayJkWzEl6PCfN00WjwIr
	J7e7UHkUkJcWWMJf4LEY79UodvDRaO0p/z+VrYhzGiK/dAEFvEfVjb3oTtIZJQvPNTE0W1Wl15K
	l1dJ5Rb/EADtXsuZAm4lU8KgNJ3DKayj2fk/MEKcTTHt52grQAEyfQTWCJKSAgz4Jmqo=
X-Received: by 2002:a05:6830:911:b0:7d7:e57a:bcd with SMTP id 46e09a7af769-7dc9521a821mr14384605a34.20.1776865928154;
        Wed, 22 Apr 2026 06:52:08 -0700 (PDT)
X-Received: by 2002:a05:6830:911:b0:7d7:e57a:bcd with SMTP id 46e09a7af769-7dc9521a821mr14384583a34.20.1776865927721;
        Wed, 22 Apr 2026 06:52:07 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm4919147a34.11.2026.04.22.06.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:52:07 -0700 (PDT)
Message-ID: <fc2ca10a-1fa8-48f8-b140-6c59595fc08b@redhat.com>
Date: Wed, 22 Apr 2026 15:51:54 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: do not drop partial packets
To: Shardul Bankar <shardulsb08@gmail.com>, matttbe@kernel.org,
 martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com, Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260422120954.8877-1-shardul.b@mpiricsoftware.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VpRd18hNX6DXIVRUQeP5J3was0svA1w1d6z95LsSph4_1776865928
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/26 2:09 PM, Shardul Bankar wrote:
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 614c3f583ca0..6858e6e283e3 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -397,12 +397,27 @@ static bool __mptcp_move_skb(struct sock *sk, struct sk_buff *skb)
>  		return false;
>  	}
>  
> -	/* old data, keep it simple and drop the whole pkt, sender
> -	 * will retransmit as needed, if needed.
> +	/* Completely old data? */
> +	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> +		mptcp_drop(sk, skb);
> +		return false;
> +	}
> +
> +	/* Partial packet: map_seq < ack_seq < end_seq.
> +	 * Skip the already-acked bytes and enqueue the new data.
>  	 */
> -	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
> -	mptcp_drop(sk, skb);
> -	return false;
> +	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
> +	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;

here MPTCP_SKB_CB(skb)->offset is always != 0 ...

> +	msk->bytes_received += copy_len;
> +	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> +	tail = skb_peek_tail(&sk->sk_receive_queue);
> +	if (tail && mptcp_try_coalesce(sk, tail, skb))

... so mptcp_try_coalesce() will always fail.

/P

