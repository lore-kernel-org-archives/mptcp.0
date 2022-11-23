Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB90F1C04
	for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 16:50:09 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id o30so13513523wms.2
        for <mptcp@lists.linux.dev>; Wed, 23 Nov 2022 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7A4rzfnPqHYnpHhIo1vde/ZjYmulTIPx1486L/BaHcI=;
        b=dlBPZlzuIsDA0e/rz5+n2X+my17kDGAf/wsFTuQ97tVdOJvyDOcLU0zSpHzuAw729C
         Fv+NWJy+BfDaHm9Wc+NlxRGriSCAayCgIaDYanX3KrH3D95xjZr7E2xrIciKaNFmUY46
         iAZPsmLCooStMS4a0Yo+rQOi8yWF6iyRSOm7rdAy/oseU1Mf0tdcu7GwjxiJtXN4nFKi
         Jh6GJfyoDpBIb0GkH7bQ1ShqJmmcI2gitzN1uXg3Pn1Vrv7EIgHobDQHE+CUJTpC6uJa
         6WLQ1m7eP9zQoNDkqMCW59Tj98lDVbISnr87bFfquVWsXK/JQn1FejmT+3yFAWRDWNkn
         BWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7A4rzfnPqHYnpHhIo1vde/ZjYmulTIPx1486L/BaHcI=;
        b=uLeffmZajUiDTp46qeWcGlm9SzesvCY2y0Zg05FJ4CG+VeUyr734SqtOm4nOi2IMsw
         KxGeybXvUaQvy+5ZKNWR8iPEPnGdWibZw9SBYeQNlYEKOx5hQHGcoAmmlCG3ZCdcs/WK
         m0CYP2eQyZ7dkPIC718HAzW9knj38BZyUpDV4aZNl91IjaPnbKLGxeGjfB4A6CQylh+d
         Iy+hskK4dp68G9WnIZr+OXf7nuMOsudscu/SdEY/7N9DCAwVdjD2iSmnkLhCGbGXZX0q
         h6d/P85xWnGVgPRDUTwx8ZX4Rpmb4X9g2m6UHwkkqsViHn5XSo/VMR03rg0lt2akDBTx
         pqYg==
X-Gm-Message-State: ANoB5pn2Y98IG0ok5Ltw6ZWR4ME7PD44v9HEgcOctqvgujdUa4YfbMbR
	GrbbgVN3BYkDcMi+eFpbQB4cMg==
X-Google-Smtp-Source: AA0mqf4eJuYOTC9ZBcEC9Pi9Cs+FA2soEMudLhy11NQJmKYBSbnG/8OzGtqSLx8vnstHKCo3qKYV+A==
X-Received: by 2002:a1c:6a04:0:b0:3cf:77cc:5f65 with SMTP id f4-20020a1c6a04000000b003cf77cc5f65mr14443293wmc.25.1669222207507;
        Wed, 23 Nov 2022 08:50:07 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:aeed:e7e9:2ae2:91e2? ([2a02:578:8593:1200:aeed:e7e9:2ae2:91e2])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b003cfd0bd8c0asm3286486wms.30.2022.11.23.08.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 08:50:06 -0800 (PST)
Message-ID: <63889555-b03a-03e5-83cc-bfae01cd70dd@tessares.net>
Date: Wed, 23 Nov 2022 17:50:05 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-net] mptcp: fix sleep in atomic at close time
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Jiang Biao <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
References: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <feee93bcba06bf05a9308188f91007e7f6cbe5f4.1669201422.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/11/2022 12:23, Paolo Abeni wrote:
> Mat reported a splat at msk close time:

(...)

> We can't acquire call mptcp_close under the 'fast' socket lock veriant,
> replace it with a sock_lock_nested() as the relevant code is already
> under the listening msk socket lock protection.

Thank you for the patch!

Now in our tree (fix for -net) with my RvB tag (and the 3 other small
fixes mentioned in my previous email)

New patches for t/upstream-net:
- ff05017f41a8: mptcp: fix sleep in atomic at close time
- Results: 4b0094499418..515e95912b40 (export-net)
- Results: 3d12c8bc8c2c..e97e3cfdc32b (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221123T164310

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
