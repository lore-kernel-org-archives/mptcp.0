Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A460840
	for <mptcp@lists.linux.dev>; Wed, 24 May 2023 12:37:19 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f603ff9c02so7634355e9.2
        for <mptcp@lists.linux.dev>; Wed, 24 May 2023 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684931837; x=1687523837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmgk7+QKFaoCuRsarHv/LwGCFnjj1Shn+Ghlbo/+4G4=;
        b=yYyhBwgguAspOdryOYb7bW+w8Z195ER1WfC76qA3s/KEBGwOIaSJgGjwd6PbJKD1CA
         MLbG8YYoHWqvz4spd2g2xdBtNd6EFWbn8tbVdtl7GbW2IwLokvXJoFb+rwj8sNXiFtlD
         lom0PJiEQV8cJ9lOkJpQBdyZKj+ZPwwgNky6Q1iFGM+EN2YsqRSN69gE6duYDXGWitf/
         F1UX1Otie1Ycy3ul5ml88rQoM3w9Jg3M5toOgEalYc5X6rjAxyfisuHoQScdhntcqkZX
         LZZmxbMg2d4i07rvsUADOtMLQ5pPSAEbk3cuT7iIYXTiqQoBCSAwTVD9t61E4xoi99Me
         JsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684931837; x=1687523837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmgk7+QKFaoCuRsarHv/LwGCFnjj1Shn+Ghlbo/+4G4=;
        b=gmtVq05aw2m7LWf6LKAuNczabY4Aw37+5SR+1Ls+iERAw2H7ckSvShb5Xo9NqFh3NL
         1lMTcT42X09aNfhI+vTQPvIuQHuemCnOZpper0m4KbTUtd68Ldp3vZ/sX5KayOpH0+FH
         6fD3pzVOG57mddlufnofyuO5W+2KyMkvnvtuRR26DYaXlIy43vqztHWBWAkSyoTZ39pM
         LysHfJuPdZ/F8X24lFS8UCK/QEf1Gy88tDuvLyncbYtgvvoq50s4FRdkmqjifFmvjafN
         /9FtPOz8gOJ8UcOz8bcTpvUQmdEEBsNfCHjM0hAO6SyTvYVanSE8BniUyQu+H13YEocV
         Zwuw==
X-Gm-Message-State: AC+VfDwdv380JZrNy/6yCTz4Tg7qBGUxeQlYxmpXZeEHg2XZChZO2IDV
	2z9nsWynJyfXpu7Ug2WPkMYLwcqfkYOxp5gFpOX1kw==
X-Google-Smtp-Source: ACHHUZ42z2HPQzOzxjUGDXTahgYUpkuSraYOD0I8NNjMfTSBsXFF/sxjwPtps6O7Evl4kzs7Jp6PZQ==
X-Received: by 2002:adf:f342:0:b0:306:3c04:e4df with SMTP id e2-20020adff342000000b003063c04e4dfmr13372244wrp.58.1684931837532;
        Wed, 24 May 2023 05:37:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:735b:1ad0:911b:4361? ([2a02:578:8593:1200:735b:1ad0:911b:4361])
        by smtp.gmail.com with ESMTPSA id d6-20020a5d6446000000b00307a83ea722sm14364803wrw.58.2023.05.24.05.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 05:37:17 -0700 (PDT)
Message-ID: <a6a9cf24-c087-c07d-1396-6daae60cedad@tessares.net>
Date: Wed, 24 May 2023 14:37:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 mptcp-next 2/6] mptcp: introduce MPTCP_FULL_INFO
 getsockopt
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <cover.1684863309.git.pabeni@redhat.com>
 <67b6345847e8f23fadaf22c14609d4d387eed952.1684863309.git.pabeni@redhat.com>
 <ZG0FL9XM-MFgfyQ-@strlen.de>
 <62d7d915a3536e9bf37770952838308d8f41ad8b.camel@redhat.com>
 <20230524095653.GD17561@breakpoint.cc>
 <477af94a-d47e-d0c2-ba42-285dc5597fa4@tessares.net>
 <20230524122256.GB12567@breakpoint.cc>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230524122256.GB12567@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian,

On 24/05/2023 14:22, Florian Westphal wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> wrote:
>>> I added the "num_subflows_copied" for ease-of-use on userspace
>>> side but I agree that its not required and userspace has
>>> enough info to figure out which upper cap to use.
>>
>> If I understand properly, it means that num_subflows_user and _kern will
>> only be used to know the size of the arrays:
>>
>> - num_subflows_user: size of the arrays in the buffer
>> - num_subflows_kern: what has been written by the kernel, max _user
> 
> This is why I had the '_copied' in my proposal :-)
> 
> With only _user and _kern:
> 
> _user: size of the arrays in the buffer
> _kern: subflow count of the kernel, i.e. can be larger than _user.

Thank you, that's clearer, so _kern would be the subflow count, not just
what has been copied.

>> I think it is still important to have somewhere a num_subflows field to
>> know how many subflows are attached to an MPTCP connection (also for the
>> userspace to know if it missed some info because it gave a too small
>> buffer).
> 
> Yes, userspace must be able to infer that it only got partial
> information due to lack of space.
> 
> E.g. if userspace expects a maximum amount of 16 subflows but connection
> has 240 subflows then num_subflows_kern is 240 and _user is 16.
> 
> Userspace can only access up to 16 (since thats what it
> provided/allocated).
> 
> The _copied proposal would have made this easier on userspace side
> (_user is the allocated space, _kern what the kernel would like (real
> count), and _copied what was written out).
> 
> But as Paolo said userspace can infer the valid count by checking
> if _kern > _user, so it does:
> 
> bool truncated = kern > user;
> subflows_copied = truncated ? user : kern;

OK then it is fine if we can use min(_user, _kern) to know the number of
subflows written by the kernel and '_kern' for the actual number of
subflows attached to an MPTCP connection.

Maybe we should rename 'num_subflows_kern' to 'num_subflows'? and even
'num_subflows_user' to 'num_subflows_buffer' or 'size_array(s)'?

Or maybe enough with the comments from the example you provided?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
