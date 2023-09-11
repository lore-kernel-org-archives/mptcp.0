Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190CC157
	for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 11:34:58 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so45629095e9.0
        for <mptcp@lists.linux.dev>; Mon, 11 Sep 2023 04:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694432097; x=1695036897; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1AISCL349fAHMk+/FZaWgLVIDNWR7iStP/sxXdV18FE=;
        b=P6echpzbXc/e9iNrCECd8BEv+xmVar0U/JHiilVbNjLSRayE8AwcWsPHLiX75Rxfih
         MiQZXKVCjeVTtSusV5cVLE52ygC9F9oVzyCAhrERL8H9QR+o1SObvTJZ4CZowGESUmfI
         y3pIHXeqIyp94Zg4y1XBBpV41nvrbW6h4oFpEn9cJXNx+dbu03b47sLY1plcQz8d730y
         KyvajCP3RbBm6XbYoKA6M+YHx0riwe97QChN8HOOZYUAKV2IyDTeQxj800rqCEN/e0Ux
         ze/2j1SQdMireujGLahjTEq0sBjZf7Lv3c7Ovp3b748G8iI/p9T+kQVGR7tAfetbCC1n
         dpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432097; x=1695036897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AISCL349fAHMk+/FZaWgLVIDNWR7iStP/sxXdV18FE=;
        b=Pi/KKeb7XRmfhHvw4FiGnnzlG3O0zhPjCude3d1522VLqYCq+kvNKtzrT3QxHIrC1d
         VsU2HeHDiKdliMC2aOYnnCHHoBm/TgjJuCxpy5quLb/WL/z0ytuMBMkOVum41+s/RWyT
         Sl/K90p7YZ4udyovyyQbfRok7NGmXlM6JO+VRDt2AE9ALHwV4FT7vZyXjCs4cEMUkjB9
         av/AAaTzMA5IaBNxbv0PFi6YfHnM819Exnm8LISBXgEI/B2OBOwVIgKnn0fSjTY2zuFC
         2R26KdeYLKAa6hYSlIu8bt3b0NFXK/4U7Zf+QN4SsyuLE9vpvozR1bpZjvSqFE3V3m8N
         Vsyg==
X-Gm-Message-State: AOJu0YyyYM0u7kUv+4TUGCZGhD08qwAP8VnINyTOAHs0761GdFtj/iFT
	eQh4Da331jbhvsFeocO7rKf85woJTfSfyFgqHjM=
X-Google-Smtp-Source: AGHT+IHpx1p9smYJLSvS4vNcItrnaOWSHW4a8Xjx77owXoB6Uki49EE8/pufuEeM0wHnf8Ys69gsYA==
X-Received: by 2002:a7b:ce06:0:b0:3f9:b244:c294 with SMTP id m6-20020a7bce06000000b003f9b244c294mr9072577wmc.35.1694432096941;
        Mon, 11 Sep 2023 04:34:56 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003fc04d13242sm12946492wmi.0.2023.09.11.04.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:34:56 -0700 (PDT)
Message-ID: <ebd5a0b6-1633-42d5-87cf-af9281b81fa9@tessares.net>
Date: Mon, 11 Sep 2023 13:34:55 +0200
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
 <869db5c2-c1e1-46e6-8b97-ce33dfc9f7e1@tessares.net>
 <5734fb79e301d6e91ada91e3b70009f51c0fcce8.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <5734fb79e301d6e91ada91e3b70009f51c0fcce8.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2023 12:12, Paolo Abeni wrote:
> On Mon, 2023-09-11 at 10:42 +0200, Matthieu Baerts wrote:
>> On 11/09/2023 08:13, Paolo Abeni wrote:
>>> Can we keep both tags? I would like to track the dep on bbd49d114d57
>>> explicitly.
>>
>> I don't know: if we put multiple "Fixes" tags, how is it interpreted?
>> Does it mean: we backport this patch to kernel versions having all (or
>> at least?) the commits mentioned in the Fixes tags?
>>
>> As long as it is not confusing for the stable team :)
> 
> I also don't know how multiple tags are handled by the stable team. But
> I really want 
> 
> bbd49d114d57 ("mptcp: consolidate transition to TCP_CLOSE in
> mptcp_do_fastclose()")
> 
> being explicitly there in the commit message, otherwise I fear backport
> will cause more bugs then the one they are supposed to fix.

When I applied the patch, I modified the end of the last paragraph:

> The issues is actually present since the beginning, but it basically
> impossible to solve without a long chain of functional pre-requisites
> topped by commit bbd49d114d57 ("mptcp: consolidate transition to
> TCP_CLOSE in mptcp_do_fastclose()").
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")

See: https://github.com/multipath-tcp/mptcp_net-next/commit/8bf3aa786cf6

The commit bbd49d114d57 is mentioned in the commit message but not
marked as "Fixes". I can change that if you prefer and do the follow-up
with the stable team to see where they are going to backport it.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
