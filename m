Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019802472B1
	for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758537855; cv=none; b=A+hIFW3AwTERchEe+L3IWoWHfBlwy5AY8nBzdA7i6Bj4/HctQ1F9PDw8/x3XDsxFyVSG/dE6omU+uenBI6svaLuI95Eh9fhrtIptLS+SxmDVx7E2Ir8gfQaf24IjjZfe6svix7BSjMI0w7kdZeLAG789cGqW/Xe/p0A+PeUSDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758537855; c=relaxed/simple;
	bh=6ct9Ybmn3ONooHP0wfdY7pz9K11cgBo7YHuYA7MyfRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sSIN0F6Yc1p5k6PghBjVamcJYFs/3uqsdVAlcTanUPKXO7yHv0ZEcH4WUWHCUFBaP/vyT0x54q1pxB9oOGR9DDSZwXQYrDTIVUi/DmEI7lJuib/gEi7Fw+oxLrzbZcdpzKLbA3SXxwp8QYITkQ1s56dsn+zKHdQerx1sAmNVaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sxvdyox8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sxvdyox8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758537851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjnyyVP6zre+DER7kloeAQjhaJICFTNKcx7/ENjuyus=;
	b=Sxvdyox8YQkKSmo1LNsHdJR1S9Us4SfGW7aELwOyMaRzvH5rUSn7HjQbpNpwC0ArdAH/TD
	sDx/ocInmiiMx3XyMAHyQ//c1ycUYZCMXIb8eGB6bX0vttvpck1O02JdMSaJwB8Eh4aFJU
	iAz0EPSoDKohWwjpCiQAPWg/WZmzRSI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-a2Ql25GyOC6ura9SC0cklA-1; Mon, 22 Sep 2025 06:44:10 -0400
X-MC-Unique: a2Ql25GyOC6ura9SC0cklA-1
X-Mimecast-MFC-AGG-ID: a2Ql25GyOC6ura9SC0cklA_1758537850
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46c90948deaso9977225e9.3
        for <mptcp@lists.linux.dev>; Mon, 22 Sep 2025 03:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758537849; x=1759142649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjnyyVP6zre+DER7kloeAQjhaJICFTNKcx7/ENjuyus=;
        b=q5fxHO021fFC2UL3mhwVb9sK13BRHjRqd45/O9HCnmr1WcONqwgOk3ZeCkhL5FiVkb
         1ankzwGJid9ecEKJvk2d1b4vFU4fmOE9KipJXr5ZZG+KA0Ek78MC7CGhpy/d3GT8/Mkp
         MWjbAn4ADY5v7NtY1BPRvNHD0sQz3XWNBWtmYyC7pj/+qfNLy73aoPhjrRzJe+cZrsjT
         yzyVJ/lFtyE2ks3rUBmqGwCmIO4hfVzkOvV53JoBlP3b+I0hRxqelAlplSkCuMas5TXR
         w7QtZHgqBuecW4L9Q02cZxE2hJmT2/P/VmpMIB7ZcetpfLFZgHp5rdnUxXcwdWXCdkls
         1FsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWanGSievcKT/P6G3r9WjvK1+zVKNj7kLHhTGQks5jE099y7iPlw3kvu61YfHr+ne0iddL1Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXaUUrlcSZtO8NWlfiouBcBOKoSe7YoHTCTzB1tuTvsLRjhS/X
	d9ydO6z5+EDEY3qmLEMO6Sbvl9LP2DhVt2uFuZmtAczT8p/d+GgXflHuEvPIcCd2rJy3TlV1Odq
	xOR3UqFI5HsgNrTJOdGY+prVpZN6z4Cn+kidyWVAft5acWGt/68Rk3fx+qknN+Fi6
X-Gm-Gg: ASbGncv3PhLmQaJunzXKwad/BtBvmMRgAH1mCszvziS3Qr2zZONfLKhB7s8xz13Vsl/
	9eIs5vTaBxcJjlPJJ1rYTx+WoH0DhnhVtUQLVUvsJho+1RpFQXuPvPO5xVKTm4UwkSRruNijB9n
	LTaNHxkZB19S0PsZOYeyIeLaWTyviPkYzlFAyrAx8ttv5Z49W5M7kwzU9a3LgfEkI0YG3hgKX+H
	FSCDw9GjdfZAkgo28A4zqCpAhT3b/DF2KskBhMgQE0vrqEfRv3NLFN8m1PhwuJLjDmqPraqMLLc
	8gCfeWkDNZ0HLHHarGfKKg6tQGgLXi7mktSmCDvLf9o3Ab2COyk2yCszzAgqLTfrElrGQHk+XpM
	CtleXXBnnGtFZ
X-Received: by 2002:a05:600c:c1d7:10b0:467:f71c:28b with SMTP id 5b1f17b1804b1-467f71c063amr71122765e9.19.1758537849185;
        Mon, 22 Sep 2025 03:44:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzi1M3JAfANx+NH9zl2SrtPybjO8K5ebXJ+dy5+49WHLuJ9J6rH3Dzo0+LqdFsfXqaNn26Ew==
X-Received: by 2002:a05:600c:c1d7:10b0:467:f71c:28b with SMTP id 5b1f17b1804b1-467f71c063amr71122565e9.19.1758537848662;
        Mon, 22 Sep 2025 03:44:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad1b0sm221093275e9.21.2025.09.22.03.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:44:08 -0700 (PDT)
Message-ID: <6a0941e4-8948-4688-8cc4-607dfaec976a@redhat.com>
Date: Mon, 22 Sep 2025 12:44:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [MPTCP next v3 04/12] mptcp: introduce the mptcp_init_skb helper.
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <cover.1758296923.git.pabeni@redhat.com>
 <df18a15a52a3884f05ad97cb53716d92bb7c8d88.1758296923.git.pabeni@redhat.com>
 <15dd99fe568a6a00da55ef5b95b3e41c9e6b6604.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <15dd99fe568a6a00da55ef5b95b3e41c9e6b6604.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: heFyntPh9lKYTO_xgMVdb66sNAxHbIF1woExl0JsXN4_1758537850
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/20/25 2:01 AM, Geliang Tang wrote:
> On Fri, 2025-09-19 at 17:53 +0200, Paolo Abeni wrote:
>> Factor out all the skb initialization step in a new helper and
>> use it. Note that this change moves the MPTCP CB initialization
>> earlier: we can do such step as soon as the skb leaves the
>> subflow socket receive queues.
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> v1 -> v2:
>>   - drop subflow argument from mptcp_init_skb()
>>   - change msk args to sock arg in __mptcp_move_skb()
>> ---
>>  net/mptcp/protocol.c | 46 ++++++++++++++++++++++++------------------
>> --
>>  1 file changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index c9fcdbaf50874..3aa03da781ba3 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -326,27 +326,11 @@ static void mptcp_data_queue_ofo(struct
>> mptcp_sock *msk, struct sk_buff *skb)
>>  		mptcp_rcvbuf_grow(sk);
>>  }
>>  
>> -static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock
>> *ssk,
>> -			     struct sk_buff *skb, unsigned int
>> offset,
>> -			     size_t copy_len)
>> +static void mptcp_init_skb(struct sock *ssk,
>> +			   struct sk_buff *skb, int offset, int
>> copy_len)
> 
> nit:
> 
> static void mptcp_init_skb(struct sock *ssk, struct sk_buff *skb,
>                            int offset, int copy_len)
> 
> is better.
> 
>>  {
>> -	struct mptcp_subflow_context *subflow =
>> mptcp_subflow_ctx(ssk);
>> -	struct sock *sk = (struct sock *)msk;
>> -	struct sk_buff *tail;
>> -	bool has_rxtstamp;
>> -
>> -	__skb_unlink(skb, &ssk->sk_receive_queue);
>> -
>> -	skb_ext_reset(skb);
>> -	skb_orphan(skb);
>> -
>> -	/* try to fetch required memory from subflow */
>> -	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
>> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
>> -		goto drop;
>> -	}
>> -
>> -	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
>> +	const struct mptcp_subflow_context *subflow =
>> mptcp_subflow_ctx(ssk);
>> +	bool has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;
> 
> nit, how about keeping it as the original code to make this patch
> smaller:
> 
> -	struct mptcp_subflow_context *subflow =
> mptcp_subflow_ctx(ssk);
> -	bool has_rxtstamp;
> -
> -	has_rxtstamp = TCP_SKB_CB(skb)->has_rxtstamp;

I would like to keep the 'struct mptcp_subflow_context' constantness,
helps GCC generating better code.

> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Tested-by: Geliang Tang <geliang@kernel.org>

Thanks,

Paolo

