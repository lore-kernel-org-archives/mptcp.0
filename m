Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751517758
	for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 07:49:31 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so73496175e9.2
        for <mptcp@lists.linux.dev>; Wed, 13 Sep 2023 00:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694591369; x=1695196169; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kh2G9El9RUfr1ey5s4Xml/jucDppHUsSzrZoawNT0Ck=;
        b=eXe938H+29EN3wSkl07lYb2USlGenPNJ2GYopK27ps1TdiL7gJiFhFJyKXGGLTuc7h
         mU37EEoYjLarX0C0vtaOeCMoHnMqwmCqbTwVtB/TlcKy8GycUXjnZDLApaOzUFmMqpvj
         tbcg8fMD0Y7TY4jiBeK8TwmC+qSqoRg4HVqd4zMWFsEZpwjFElmxXZF8jhfR+8P46d05
         HelU8t96rpCHKuqq/5n+BOpZYyfcLS00iKKnOf++ITYyT+yE68AodsbM5Y6pRJVOmmbk
         IkXlqhbNrObgn9m6k3k0m0vdRv2tliHpwiHCiIkZth8I0CwxrvbYPiBb1zIwldgjDOKm
         ja/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591369; x=1695196169;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh2G9El9RUfr1ey5s4Xml/jucDppHUsSzrZoawNT0Ck=;
        b=Y5PQfCd9lfzLglwI3Zqz5eQzNRHzBLEhMgXYucFK+DtklilEIsamG9PfKvGXjUgA7+
         8P3dmcDIF8n+3E40b51t7NYyVpXfGXc1hWbcFwXC6rFAWGWuxKLKwtMirtR1XltABytp
         /fCVNMz/SJ0sAUuWhz23YtVd6XdI5vcINAurrzv3cFBe1jw5gYV/TNrVbxuvfVt16EZ3
         39celeIGN0th8d8PAp9gobKyALDfcJqB9/bZgQG2+ZwLd7xZjZMzODGz2YBjdqfVSX58
         VL+cNUE0boyf5LrqfW9NyzAq6ssKOXO0kluqOU9fASG1ekdzhRopA3b36YlFqbxuKCWH
         k3fA==
X-Gm-Message-State: AOJu0YwG7iXuwpXKd0x0ALhCLu8HsODHWIsQF8YwoxvwyfB2HhbYrKtq
	A37KxjIivZKpPC3nt3NF99Uc5yhhHIpLkA+UWlY=
X-Google-Smtp-Source: AGHT+IF6SShAH5F2aXc+hK3tWqnkHurdFm5A8p4lg956hSfUVoncAA7IBqxgyC6ODq94sxTpQ0P09A==
X-Received: by 2002:a05:600c:b52:b0:402:f8ea:be3e with SMTP id k18-20020a05600c0b5200b00402f8eabe3emr1325917wmr.7.1694591369380;
        Wed, 13 Sep 2023 00:49:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9266:f354:6181:e472? ([2a02:578:8593:1200:9266:f354:6181:e472])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c2a5400b003fe601a7d46sm1190065wme.45.2023.09.13.00.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:49:29 -0700 (PDT)
Message-ID: <0b89565e-678f-4c38-a4d9-1fa024c1850b@tessares.net>
Date: Wed, 13 Sep 2023 09:49:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 0/2] mptcp: fix another close hang-up
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1693988314.git.pabeni@redhat.com>
 <f4e8f6cc-d557-4b60-9d22-096595cd2ffb@tessares.net>
 <c2c5bcae-931c-f094-7247-ce844765eeb9@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <c2c5bcae-931c-f094-7247-ce844765eeb9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

(I just noticed I forgot to press "Sent" yesterday)

On 11/09/2023 22:16, Mat Martineau wrote:
> On Sat, 9 Sep 2023, Matthieu Baerts wrote:
> 
>> Hi Paolo, Mat,
>>
>> On 06/09/2023 10:30, Paolo Abeni wrote:
>>> If the TCP subflows close silently due to timeouts, the msk socket
>>> can hang-up indefinitely.
>>>
>>> Implement an additional close timeout triggered with the last subflow
>>> close event and move the msk to TCP_CLOSE when it fires.
>>>
>>> Should address issues/430 and issues/431.
>>>
>>> v4 -> v5:
>>>  - let the tout always expire for dead socks (Mat)
>>>  - fix comment type (Mat)
>>>  - targeting net, added fixes tag
>>
>> Thank you for your patience (sorry for the delay), the new version and
>> the previous reviews! It looks good to me!
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> (@Mat: I can add your RvB tag as well, especially because you did the
>> previous reviews.)
> 
> Sure, series looks good to me as well:
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you, done:

- 7af61f39531d: tg:msg: add Mat's RvB tag
- ca5fe234927d: tg:msg: add Mat's RvB tag

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
