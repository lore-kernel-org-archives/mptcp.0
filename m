Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D209A1A8407
	for <mptcp@lists.linux.dev>; Tue,  8 Apr 2025 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081756; cv=none; b=caL0X2SuZRgVhCkZN4Blj9A6589GwdLiYPlU8Btcl0wHnsezloHLVz3N60ZB03yU+jT5ZYbnP0NlBEf/+/U2RWWVQjBXpSp+kQ8CzotVv6NhSYcUrUarTLiAN91SJhquB2l3qfVFfINpnaQA44j7A/Bdpc/Pdns9G5xikWta8AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081756; c=relaxed/simple;
	bh=9bXBAqjwsMH7aUBaipURQXJeh98g4OYHsd+AsP53j/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGIv3+Tq9hf410w4xinwxAmKf3V6XJyTE/5ltmH5L0mAdyqQ9iepl3mOrNJgeX6v7GpPxU7PBwLnkLk64v5240MrXymKDnKtWejhAi9Y6YoWWyT4rWp2IygmCd4RrDc3Cftn1w7lnJSe9CP/Mg1PpqKpdHhY/ipgk7q+OKARzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YWyp/rf/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YWyp/rf/"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399838db7fso4452862b3a.0
        for <mptcp@lists.linux.dev>; Mon, 07 Apr 2025 20:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744081753; x=1744686553; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPuw2Ymw6aEL6CjIynPBldeAGkGLHtU6wbCawr07JKA=;
        b=YWyp/rf/uqxjyOSpAZwMbzJ7ovSPKGYQGoHx7KFT7wTR/jY1/Jn6AC+592lLlVySht
         CWSi/MNl7kHiN8ALi2f3b6VmHza2y3gEA1Lc6BwJSpAaq+CDqZd1S9v173qzYAFU+9ei
         w5pwMy/Vr3DQKZ2YBHijvtDzSHH5HwNOXrzJRBfgMLDwgiMGcco0LLIa9ySknD+197jv
         jhCFULUkjHdQVCk3/oNrQY5rwwMzY8448d/JJwDRF81Y66/VoHB+1qSXvNAFq226W7Ys
         iNIDxWePr1fz6GAy9fxj/ve8D8L7ywbj5sHcwRuYPYxA5yfM0V2yWmH/Q9m5dCT/JQD9
         QVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744081753; x=1744686553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPuw2Ymw6aEL6CjIynPBldeAGkGLHtU6wbCawr07JKA=;
        b=vaKwqFRUcTClB+pg1aHj8maAJGMxBFFiMPedZ/fs6l9U7euhq5Cu/0iUyRIkfYJtAm
         FMbTKZiA2nGMujy8gNZQ8vDoE6BVgP8lTqCLwtUok28kPryD8DWCzj2F2IRJYFigiT/O
         z19K5kC5sXrhspnlTEfNlr4ZtEN9ZyPaN5VncGmXiH2iGjCVs1Fphg/293p36vu5NMj7
         kohxcvQh4bhiaUjCm9dp8/SIlcjoKVF2u98ltGLstKL83wzS03fceO9JhQCJgDXuRKLa
         kL7hfwKBozwvGpxMzRgZ8SO7egQyskkNX0zRAZXr2vnEIs4hBlu5r6/YNmiqfyg+p1C7
         CHpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1y8NO8oglEO6ISEdTvi12rGXzJS8LR7ouWxM+POdJJCoB3hD8wqA+Pq9FDwYS9VV77Gg4qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzG4vS6Y1lBY5I0Fnt0JEjWNyzKUnWuXfyC1nsy9HzBokiO9Qub
	QqyTo8XaGAsSxSFqYEHVB8R7nGWgKpt3Edhx4PelrhzCMjPYmeiHjMSO3gNCcrg=
X-Gm-Gg: ASbGncsEEw+v3Z00H1MXszOUpEmuHgoe0NIZHzV04GTQtoi5/TFbfNrnDIRGjCfKoXN
	Zcd70UrV2e7+LV7XPbbPVe3Q2IQRuzVQRQVUuk6QursyRyMY+PEYLwIJVLfEwXILA7FqqGyLxA+
	eJcYLdx0owBt9oD9Hly9Dne90LpHsP9EnC8X1C0kLwAH5w/nTMvRc+/VYIeqb+SFiLyMt/XspN1
	OkWaHiE7LSU3tfIi9voDw2DPfODSsUPyYeSJlv3TgIYomYmBs4bc25NBYxOQt17D8swX7PUqccO
	prQ8qDZt3dMSi8Ze51H6RPt43PYcQcQ3fqbwZt5tBzE/uv6DFD0=
X-Google-Smtp-Source: AGHT+IEwH96uV5EtxaP2ImURK29zECcTWq13GuIUlA74sMLhltZ9xgPDSZDjYcQ7xrW9wkCK0hHxtA==
X-Received: by 2002:aa7:875a:0:b0:736:b3cb:5db with SMTP id d2e1a72fcca58-73b9d4019ddmr2344723b3a.11.1744081752836;
        Mon, 07 Apr 2025 20:09:12 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d1881sm9372280b3a.3.2025.04.07.20.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 20:09:12 -0700 (PDT)
Message-ID: <0de20ab7-9f1c-4a13-a8d2-295f94161c4e@bytedance.com>
Date: Tue, 8 Apr 2025 11:09:07 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH] selftests: mptcp: add comment for getaddrinfo
To: Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Cc: matttbe@kernel.org, martineau@kernel.org, viktor.soderqvist@est.tech,
 zhenwei pi <zhenwei.pi@linux.dev>
References: <20250407085122.1203489-1-pizhenwei@bytedance.com>
 <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <ae367fb7158e2f1c284a4acaea86f96a7a95b0c4.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/8/25 09:43, Geliang Tang wrote:
> Hi zhenwei,
> 
> On Mon, 2025-04-07 at 16:51 +0800, zhenwei pi wrote:
>> mptcp_connect.c is a startup tutorial of MPTCP programming, however
>> there is a lack of ai_protocol(IPPROTO_MPTCP) usage. Add comment for
>> getaddrinfo MPTCP support.
>>
>> Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>>   tools/testing/selftests/net/mptcp/mptcp_connect.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> index c83a8b47bbdf..6b9031273964 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
>> @@ -179,6 +179,18 @@ static void xgetnameinfo(const struct sockaddr
>> *addr, socklen_t addrlen,
>>   	}
>>   }
>>   
>> +/* There is a lack of MPTCP support from glibc, these code leads
>> error:
>> + *	struct addrinfo hints = {
>> + *		.ai_protocol = IPPROTO_MPTCP,
>> + *		...
>> + *	};
>> + *	err = getaddrinfo(node, service, &hints, res);
>> + *	...
>> + * So using IPPROTO_TCP to resolve, and use TCP/MPTCP to create
>> socket.
>> + *
>> + * glibc starts to support MPTCP since v2.42.
>> + * Link:
>> https://sourceware.org/git/?p=glibc.git;a=commit;h=a8e9022e0f82
> 
> Thanks for adding getaddrinfo mptcp support to glibc. I think we should
> not only add a comment for getaddrinfo mptcp here, but also add an
> example of using it in mptcp_connect.c. I will work with you to
> implement this example in v2.
> 
> Thanks,
> -Geliang
> 

Good idea, thank you Geliang!

>> + */
>>   static void xgetaddrinfo(const char *node, const char *service,
>>   			 const struct addrinfo *hints,
>>   			 struct addrinfo **res)
> 

