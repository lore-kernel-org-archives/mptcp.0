Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11D12B95
	for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 14:55:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fe8a158fcbso47073345e9.2
        for <mptcp@lists.linux.dev>; Wed, 16 Aug 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692197751; x=1692802551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPKyvMy6HNjsxTQAXmULEDrkah4znpC2wN0hqnfR+dU=;
        b=ccbE9//xyhTLYHABFiAQ3YE4s07Oky3uWcwKM9xmp/mLNJCwIKN0aPQvcBbSXjSYMB
         b1tt2wRlsMNHE9GFX/cX6bO7WhHXSIZM8t8SkN/S1RmtSAN02QPw75uBFevToSgR+Vqm
         bjvOXCOtmN0oscdHx539QAfnbCP8Vdx422as7/lkQeaf4YkJozg4DoqNgCQMxME2yJzs
         LnLr3y8b1J+gWXvHOAhEFV8ozsYCdsB68uLGW8IyI+dQmQnB0pP0+fzukO8hfU3gsLWd
         qXdm8e2mjmeiH5j4VzuqamGsY+7psnRLwK2ppfVaOJ3k59X5tPZCI7hxGHwDLLBPbHuC
         eWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197751; x=1692802551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPKyvMy6HNjsxTQAXmULEDrkah4znpC2wN0hqnfR+dU=;
        b=IyvS1cD6vND40muEu1chkSDtifIIcgc+BeU8suqwrUHAjF5b4osAS2Y1wfKx7npFeg
         zCp8AZ7bEPaRVaz//6MKMGCCsDKdhY57OFgml8xSxpzAO8nAfoie3aK7FmKVG7qtazZ1
         0Td1cMssnBi+85vbWXLldc6z28Q73lbNqG4hMp7OyBI60Y9hpQ+WCO8nIMCsuavRpVsc
         l0R5Wj+YmfOoiMN97tzvl417/OHbGE7uTxcj/c8HNwxtTwHOwLsd8ruo+JWZUq48spgU
         POPeXgMxG0engLa0QgJiIVUfpqQdUFd7dR/uI4YWTI8PVekaS9XMBqCKIBUIHRaUkbjp
         w0DQ==
X-Gm-Message-State: AOJu0YyyMPWk96p5DrkCyZnLHIRj5NjTm43WdFNyElKxgytu0XFQ3d7b
	BTjPAqBCh+jmRHl/iH0oxubDLiS9t9HZKWiyzZ8=
X-Google-Smtp-Source: AGHT+IFlSL6dhm5M7Ztf5Fd0Za2ZdNjaKuyMFOtpgkeDCgY/gaWIejBvmcQpSvEJtx/mWrnkJmKY2w==
X-Received: by 2002:a05:600c:3b23:b0:3fe:2b60:b24e with SMTP id m35-20020a05600c3b2300b003fe2b60b24emr1817166wms.29.1692197750967;
        Wed, 16 Aug 2023 07:55:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9191:2283:c4d7:5cd7? ([2a02:578:8593:1200:9191:2283:c4d7:5cd7])
        by smtp.gmail.com with ESMTPSA id l10-20020a7bc44a000000b003fc06169ab3sm24220176wmi.20.2023.08.16.07.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 07:55:50 -0700 (PDT)
Message-ID: <174ddedd-5135-4b54-9994-897cda0b6611@tessares.net>
Date: Wed, 16 Aug 2023 16:55:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Documentation for path management plugin creation
Content-Language: en-GB
To: Alexander Witte <alexander.witte@blueflag.consulting>,
 "mptcp@lists.linux.dev" <mptcp@lists.linux.dev>
References: <F3D79FEC-8248-4710-87D1-925051CE5750@blueflag.consulting>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <F3D79FEC-8248-4710-87D1-925051CE5750@blueflag.consulting>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 16/08/2023 15:11, Alexander Witte wrote:
> Apologies if this is going to the wrong place (it probably is)

You can ask general questions about mptcpd here. You can also the GitHub
project:

  https://github.com/multipath-tcp/mptcpd

> I am looking to get started understanding how to develop a custom MPTCP path manager plugin for use with mptcpd.  Can anyone point me to some documentation or anywhere to get some guidance?

You can probably find what you want on this page:

  https://mptcpd.mptcp.dev

From there, you can find links to a README (Getting Started - for mptcpd
in general, not specific to the plugins), the wiki and the documentation
(API).

To create new plugins, a good starting point is this wiki page:

  https://github.com/multipath-tcp/mptcpd/wiki/Plugins

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
