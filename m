Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA332C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 17:13:29 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id l25so12065472wrb.13
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 09:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=42psxXpEgtmthn8FlKYYwQMbyOAk7FVrcHusQT9CIzQ=;
        b=tzDT4CSjRostAn1in6UshZChqToC4h/fOdvVlh7bPUiszUubqAiK5ocnfS7TfCWjXN
         +HR12Hw8SlPGxeYua8sOUufPQo3uSLdDs5KX/+bDraFUt0GO+xy7eoYuccWr2ZUe8NL0
         xmrCs5l4GdT5g3PEp5O/MgGkdimamuPeg6okv9Cpdzy9bgAGjlrnqe82oCtUnzVEjl00
         7L/VC9n6rt3R/glqwg8eIZVN5GsfWqDvWbTj4GED5i+qbSmqB4xyV9iz3DjpkhgOdsn7
         RUDfD87gbtus7yBWNz5WrozwXOaYyB6Er7YkPCK31/yXuy0yp8nqOm8w7LCYUNAFYBzV
         IqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=42psxXpEgtmthn8FlKYYwQMbyOAk7FVrcHusQT9CIzQ=;
        b=5Ng9KN1I9IeOXBQ9gcT1sOz1ZyuPx0ZejkzKg7yaQKUygCvKJM+b0aIwYVekE1AYdO
         P/NJmThbvpnSeL1gJmjpoYBMMFC5JvNyI2cE0c/wxatfP6ZCk/Qnx9JvpblSdN+ZMRCl
         06wcylA48JCw8rbHRQA6Ahd21pT1rZlcFh7nggGQ+tVsV8H8eVhRqnAqzVdOAuq888o+
         X/AeZ3UOex6wfTO0aICx/pcHVZt3GPlCwE9H8+IuEjmESznD/gVjiWEqRbzPsM66p4KK
         BzmcPvW76qyWTW0xN7UldAspDKeLUIfss0EztAAor1sFFAbNURcciAU/vC6izGNcxZFz
         GQfg==
X-Gm-Message-State: AOAM533rdQodWtCJkoSk3+gH9Isy+zvbC/TVRna1s2sKOg35Lg4v+N9g
	nlmP6Aommg0fD8UL2WL8cCm/2Sb+ZW1HYQ==
X-Google-Smtp-Source: ABdhPJxzLuhrd/ISOJulDp2YC2TW48lfG2UjI7bcm1eLi9+vJWTbwera+YJ6vrje8x0vr4XVpmIUTw==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr7919221wrj.355.1643390007368;
        Fri, 28 Jan 2022 09:13:27 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i11sm6317033wry.102.2022.01.28.09.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:13:27 -0800 (PST)
Message-ID: <bc1b2072-985d-a253-099c-1b7be930e8a9@tessares.net>
Date: Fri, 28 Jan 2022 18:13:26 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next v2] Squash to "mptcp: infinite mapping sending"
 - fix csum
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <f2761a60658d4f54e0d39fbf4b4fe45e387e5b32.1643250449.git.geliang.tang@suse.com>
 <f4a41e6-d098-13e-f085-8a9f404d8bab@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <f4a41e6-d098-13e-f085-8a9f404d8bab@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 27/01/2022 17:24, Mat Martineau wrote:
> On Thu, 27 Jan 2022, Geliang Tang wrote:
> 
>> Fix the checksum value of the infinite map.
>>
>> mptcp_make_csum() will return a non-zero value when mpext->csum is set to
>> zero.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> v2:
>> - add a comment for the checksum value of the infinite mapping.
> 
> Thanks! Looks good to me
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Thank you for the patch and the reviews!

- 608ee7eca5cd: "squashed" in "mptcp: infinite mapping sending"
- Results: 6cf1fda75aaf..fa314fbb2be0

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220128T171211
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
