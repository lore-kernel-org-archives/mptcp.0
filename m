Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D2320A
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 08:42:26 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-401187f8071so25736965e9.0
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694421745; x=1695026545; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/BhMu1ddiaGN7rVE+mQh2AbsdNShTjyNO2k9io+z+U=;
        b=UTJY/Uc1s/K2whMih/6hTb3bzEFq7A9yvAFYqg4yI0sTGo3Rr2WJIUEU7HnsQo70t2
         SUksfSDKlKzEIv1J5E7d5imqw2WmBfMdu7hqDGiuNTkFGfV2Te5/Af+j2oGmoWwLF59e
         e2ZtIs94NO/KPC2VKPK/m5Nk/VyPGpI+XT2stg3z3e70fAiVUsgqDc0P2XKk3vMHAHdY
         SYKCwPFUJ4MTer16WM8YTX+2JmjKI8V9uMAPcOGcfi47f6p4ibEMatQJlQob4oVD8OaF
         KsqGrXLsEnTA1c3M0HAVgSBSyQfNJhMG3LsZTM3jMlLVwlDS1h39tswlKtYrqYRgo39i
         Tzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694421745; x=1695026545;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/BhMu1ddiaGN7rVE+mQh2AbsdNShTjyNO2k9io+z+U=;
        b=gUhh+0OLmZYy1HV1dGNIs6Nmr6ttxoTQFQF1lo14LMh1SyEEccrbF0fbYyClcHXRDR
         ocrU025fcAy0r0VJvJbHKe+f0DFe+NDXfZtciXBXhJh8yVvd+fFPqgQ5OpDNRWKN1V0e
         WwjBgBZVoRTvKPXlPV7VQy9dGaGl1+L6avfxuZvIlp3SPYd+vnnIQgdPyBmcP7xP9lpT
         MufM4C2OwQKGw5wEgEoS0yMchlj6RZbSZZgVazTZEiM+CqB7c7FE/lMl91vAsbtUYXyR
         fNZ5GK3flziQwebwD/Z6dKQI42q3PFzDwN9/Dw5Yk8JOdjk8Ts/vVYJhVTrB1oR0SRmS
         6KgA==
X-Gm-Message-State: AOJu0YwlV8Kt0MwzLzHT+yT5Jkm1UlVGF56cgg2RAIJ0teRCF95MEa8e
	GJEum5m/u96Pz+ZDVwLf2GcMpt47WcKA9uzqGoU=
X-Google-Smtp-Source: AGHT+IHQWjMfJpGqSORXbSASZ3N7gJeC1ozmeQp7afeKG61N3LUAuUiN+RftMKoUadWsRYj+1mE37A==
X-Received: by 2002:a1c:720e:0:b0:3fe:1fd9:bedf with SMTP id n14-20020a1c720e000000b003fe1fd9bedfmr6060818wmc.11.1694421744681;
        Mon, 11 Sep 2023 01:42:24 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o8-20020a1c7508000000b003fe29dc0ff2sm9470206wmc.21.2023.09.11.01.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 01:42:24 -0700 (PDT)
Message-ID: <869db5c2-c1e1-46e6-8b97-ce33dfc9f7e1@tessares.net>
Date: Mon, 11 Sep 2023 10:42:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v5 2/2] mptcp: fix dangling connection hang-up
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1693988314.git.pabeni@redhat.com>
 <c6eb12bdaa092d1f98ae15adb99729c8192d8939.1693988314.git.pabeni@redhat.com>
 <4f8e9b17-e19a-44a3-adac-38771b5fac51@tessares.net>
 <982b3b51305db17ed5a8371c7cb3abb41c05ab97.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <982b3b51305db17ed5a8371c7cb3abb41c05ab97.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 11/09/2023 08:13, Paolo Abeni wrote:
> On Sat, 2023-09-09 at 17:50 +0200, Matthieu Baerts wrote:
>> On 06/09/2023 10:30, Paolo Abeni wrote:
>>> According to RFC 8684 section 3.3:
>>>
>>>   A connection is not closed unless [...] or an implementation-specific
>>>   connection-level send timeout.
>>>
>>> Currently the MPTCP protocol does not implement such timeout, and
>>> connection timing-out at the TCP-level never move to close state.
>>>
>>> Introduces a catch-up condition at subflow close time to move the
>>> MPTCP socket to close, too.
>>>
>>> That additionally allow removing similar existing inside the worker.
>>>
>>> Finally, allow some additional timeout for plain ESTABLISHED mptcp
>>> sockets, as the protocol allows creating new subflows even at that
>>> point and making the connection functional again.
>>>
>>> The issues is actually present since the beginning, but it basically
>>> impossible to solve without a long chain of functional pre-requisites
>>> topped by the blamed commit below.
>>
>> Would it not be better to put another "Fixes" tag and mention that
>> bbd49d114d57 is required for the backports?
>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
>>> Fixes: bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in mptcp_do_fastclose()")
>>
>> My fear is that this patch will not be automatically selected to be
>> backported below 6.5.
>>
>> Instead, I suggest to use:
>>
>> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
>>
>> The issue was certainly there before but hard to backport without that
>> one anyway.
> 
> Can we keep both tags? I would like to track the dep on bbd49d114d57
> explicitly.

I don't know: if we put multiple "Fixes" tags, how is it interpreted?
Does it mean: we backport this patch to kernel versions having all (or
at least?) the commits mentioned in the Fixes tags?

As long as it is not confusing for the stable team :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
