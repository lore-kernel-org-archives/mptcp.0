Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0105428B7D3
	for <mptcp@lists.linux.dev>; Fri,  4 Jul 2025 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619307; cv=none; b=r6m9X8q732M5Ndf07VXprW5/epNWk/stfcuSiVNFIvXSHmOvgiOj1Cu2oDnym41lAB71yn5wU1D1vpNgc5aESGYCH8vx+kK0qMCxbVgCu0NcZgxdIWED6fh4vAI+foU9wSIGWgoK3q4dn+OhbCcLaZV38kRh/xgi+pvgEqfpx+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619307; c=relaxed/simple;
	bh=0xCeXEOUF1POTj4t+kRwDS3fdOcuajU+njkGxRa0b7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BZOOP9ODxMbQhCrINV68aEXVYuDf4PcskXcVpB8BiQ4DYVQNJEuY5fZ77iav23GNFbnTbXw3Wfj/5iaKMYUrR33oHymGYLsOm0RtRFajz5KBqwDZ9dP8bSCSUhSuqDRKseXe1pyM8vS2LLQnAtCxYcIatwc67R5QPRyOAiD66D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gudJgIYI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gudJgIYI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751619304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8fJLyCmWLI7np+/QwTyDcJ0ZEy7op4iqnY8WtN1zks=;
	b=gudJgIYIwFme0Zugb3h0wRjXDGI8Oi/70Z/YgXuYISGJhi+g8KPNZpgNYlkVD4llVfaBIA
	ee2/FX80EKlNVCTOO13YmqtmqOp48/+1OSrE7l8L2EVg+Xxk0UV4pefKxYu81rEqcD+Q/q
	05H1TOOznuTFDdYqMVSzpBTI29lX8U8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-4S7l1iNHOOeMjeqLpDpUew-1; Fri, 04 Jul 2025 04:55:03 -0400
X-MC-Unique: 4S7l1iNHOOeMjeqLpDpUew-1
X-Mimecast-MFC-AGG-ID: 4S7l1iNHOOeMjeqLpDpUew_1751619302
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4536962204aso2761555e9.3
        for <mptcp@lists.linux.dev>; Fri, 04 Jul 2025 01:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751619302; x=1752224102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8fJLyCmWLI7np+/QwTyDcJ0ZEy7op4iqnY8WtN1zks=;
        b=VdmAd/2zytJKfSnxCz/lXBZxEJSiSlSiFWAJudASgNAllrEJ5qjcZsutXW2SZ+KrQ4
         MiiTk4xm2Dk8UCH+4fZx0QZJ6kYoK4t6HL4X7xzTA2s2kvpo9X/oRx0ICRDx7LhnM2kq
         0dxuz/sXQfvQdVxN40dLk1zCVK4rbETLaGgCEo1LNKiCiidoMX1LKWy5T4H45uyjHTaO
         frZytdm6muSISR5bWE02DCZQW8TI5qP4G0sIjn/VlkAQ6/KaAIIu4tSkRkfpf2l6PRrH
         9KP74Z7B1K0PgyGzmdMn/G7qK1pV7xtb3GSfHN0QuhAdhH+DxyJLr0C4UODdEk3DyzlF
         lr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgsb0tl11L/DNAMvy1BOeROBhEGE4y7G+yQHxeUg2QKorlD78dNNPKSlT0tqW/loykOgo7ow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzyf7TFHdzrneebW2RdUKqAOlP+u6wOng3WPQ+uSNbnYUnULfd6
	m6SLVmK6Pmd0Ly5ic7qkzRsiLjrTHtzagZJmeWdWP7Udo2atWjBg9r9ceAGq/cJrT5SDn2RkDXn
	jlb3mXzaukdSJcQhNaQKHAGKN5jZ9bMhc6M+WA6oq9+5mRDf/5vWhPrzq
X-Gm-Gg: ASbGncvlAIJqfB6ERSvk+5m4GCHnfN2jIF1T2+8Ql+7wq9E18R/BCp/7atZFsH9dcRw
	BqOdz460tJ6FA5KZBOOrTHnQzRkSx2IPIxPp0yskReS2oJ3eujEPZ48O3YT6trmpSo3M/GLepLn
	ZroS7wiI9PSbHNOdsXJ6JDuROaAKevcHBgL5q7BDZBysdvSdV0ODjq0Mf6RW0e/S21ZG/sICiuy
	F5v0AO5ZD83ljRk/Kqlb3Vr4DNpG3wKgcSQN/x3RHkFKNgHo/6AnMSruSZi2AslRl4Izm30BPuh
	8/M3lvPaqvdOoVKkl6gA+uhmTp3GeuLVewrUv/GJjJD3L91HwXrrrXA517qSkOF6XTE=
X-Received: by 2002:a05:600c:a144:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454b5c39759mr6919035e9.33.1751619302107;
        Fri, 04 Jul 2025 01:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgqw+W5xG0RTjUrtudamqeBFFbxGO4CHHWlMuSZCjwK5PVj5vhigouibNIVqd8pMDjk44A9Q==
X-Received: by 2002:a05:600c:a144:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-454b5c39759mr6918825e9.33.1751619301577;
        Fri, 04 Jul 2025 01:55:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b188e84dsm20070585e9.38.2025.07.04.01.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 01:55:01 -0700 (PDT)
Message-ID: <3daadbbd-631d-4738-9a91-434995bf9b6e@redhat.com>
Date: Fri, 4 Jul 2025 10:55:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v5 1/5] mptcp: use sk_eat_skb in recvmsg_mskq
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev, hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1751093346.git.tanggeliang@kylinos.cn>
 <4a309ea09d8398ea08588aafba020b676f57616e.1751093346.git.tanggeliang@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4a309ea09d8398ea08588aafba020b676f57616e.1751093346.git.tanggeliang@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ap23nVuRU57-2IO7uMpy76LWPxY257zeAs1T3-5YAvI_1751619302
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 8:57 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch uses sk_eat_skb() helper in __mptcp_recvmsg_mskq() instead of
> open-coding it.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/mptcp/protocol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1de42dc4e8ea..2f747ab730e5 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1890,8 +1890,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk,
>  			skb->destructor = NULL;
>  			atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
>  			sk_mem_uncharge(sk, skb->truesize);
> -			__skb_unlink(skb, &sk->sk_receive_queue);
> -			__kfree_skb(skb);
> +			sk_eat_skb(sk, skb);
>  			msk->bytes_consumed += count;
>  		}
>  

Reviewed-by: Paolo Abeni <pabeni@redhat.com>

