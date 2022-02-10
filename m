Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F72F20
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 14:52:49 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id j9-20020a05600c190900b0037bff8a24ebso931720wmq.4
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=aPG50Wew5aYjhaQELL4SJj+zpshCSawcGMQJ0fH+aNk=;
        b=5B8um+C+DNBouBE2Wkcs2AmdWO3wzPvtrrYKvu0tnXap5R2Rq6oDh/PNWRSgrT7L8G
         lfx9OiHSq4aGSIoh9gLOqeic6dyu6u1d8mFGULPpTVnaz5WIeIWJ9ShP9+2BcLWSPA+w
         0MiFrPe4zyQnuxzhqlAdcta4jd9xy/5P8eaGHsx7c6xPHOR5keATej54KxTeFkGHDs2q
         +48cYDsGUfT0z3TXHROhZV9Gy0jxmkALq5rX2Wx2Jbv8JyN6xqh4P4iuVMFpNrdjxLoe
         Nn/JzxIP0tsVU1IgUn0f5PljWBtJDYsV3MhY4ctjeGoVSC6tFg3zbm1lIEtQu2DbGrwK
         Slsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aPG50Wew5aYjhaQELL4SJj+zpshCSawcGMQJ0fH+aNk=;
        b=jTUVpVi1S1c3/zHZrhSB5yzHjgXLPRHWgxbCGv5LZEKfw2yRn2k5C+dYfLkToA1OpM
         gneMq+YVbz76y2FK7LrnWOWBvCrbQARdJ6cb++Pu4QoETlXOnkZJK5hp87va4GtYo9Jz
         2ffaH2Ys9mfIUzf5Ib9xkiEoFada7x+SeKRZqzKxbQ2fe3T+3G2qkttRqOOsMINRw+v3
         ZjmCcvuyCWlxWuVVLBvcKUCJX+u3kgF6GSgJBjUntWNav1mZWEMdBD8pUMDz8IK5MFfb
         mvxcLtyCQ9POLWxRIQWsfzLK3jp8OsL/EdAmEzk6FB3QVeLJbbQJiv+cuGbkeIGYTZ2i
         RFtQ==
X-Gm-Message-State: AOAM533aMsB3dfBYAsByGz/ddrBGsF54qRMSe8o09lBWZ/FvYr5O1EAU
	wnWFF47gUWBVb0q6bOyWDSeie0McP15JajTo
X-Google-Smtp-Source: ABdhPJzZ00jMm9QPftg3Qll7LxagzJOmeQ55wisTCO6e9DlZ374sanLLj6um/+K2x/23OOqSKz4w/Q==
X-Received: by 2002:a05:600c:3c9f:: with SMTP id bg31mr2486498wmb.86.1644504767432;
        Thu, 10 Feb 2022 06:52:47 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id n11sm1776985wms.13.2022.02.10.06.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 06:52:47 -0800 (PST)
Message-ID: <6c39dbc8-bd94-fedc-ad53-0a55c3aaf1f8@tessares.net>
Date: Thu, 10 Feb 2022 15:52:46 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] mptcp: mark ops structures as ro_after_init
Content-Language: en-GB
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
References: <20220209102933.20873-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220209102933.20873-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Florian, Mat,

On 09/02/2022 11:29, Florian Westphal wrote:
> These structures are initialised from the init hooks, so we can't make
> them 'const'.  But no writes occur afterwards, so we can use ro_after_init.
> 
> Also, remove bogus EXPORT_SYMBOL, the only access comes from ip
> stack, not from kernel modules.

Thank you for the patch and the review!

Now in our tree (feat. for net-next) with Mat's RvB tag:

- 6072c8a8fe34: mptcp: mark ops structures as ro_after_init
- Results: bfba92ddd537..af8e6fcc9de1

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220210T145230
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
