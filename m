Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4552F83
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 11:55:50 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id z5so12514861edr.11
        for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 04:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=U7F0NGX98PXYmsouSb085biTzo5CrH0NaqskZXwLOts=;
        b=xFiwkHy8ee32/5wu72N7xrkLe5SvyvTAv4Ei0Q1LQ51KT9DGYoAT5cRp8LlfRsfzn+
         698Hbe2amZKV1MPDId6tIFaJupLxkjNxgyxCp92twLIzqNAxtJE866XRSJlNHNYDV9Ww
         AeaVTRxR7qkor/8qQQQ7pHFJ6cGqSa0zd3Dfdf8/ARHuAs51RZX9skA5FSeza1/uFkCQ
         wmMpOBG7unZLaTmjXAvEQ0Y8EkWPDUTS6wzuJl6KNqsosMTDdWf2BQXjRDZx2t2911GM
         Is5JYr1xf0Tn4w/s6nXffL2UrCh/ul7OyQ2GXjfrAAt26pmbxttiK/5byPfnFqyY2l04
         HUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7F0NGX98PXYmsouSb085biTzo5CrH0NaqskZXwLOts=;
        b=ZJj5rMm+dSBYK9V+KZglaUCv2jMbfWxEySPDT/2d0wTX2oda+6YHJUb5xkxCQ8igK3
         n9cTF14wuT1Mlw8f1d/zkO6sZAVRVqu9tdYRafX5DWMiN8cF4dBT0O+g9kjr7HNwmUsr
         FUv4oHEKTXcXTwlQQFpqBv8M4SxpswgZynpkpTD0rN/WraPHQ63iZVr7nNn/2IatwxZt
         ZCl1ESpPwlz9/YAwd0p9dN5YZqRm3CYg59cvqsDTGfHdt7yDBn2lhikX4Jne2vPcW/2F
         /iIludEc775lPblDqBpP5M5vKEyV2uns11UpsTNc/qrFHVIfMG+2435sG6QNBHZQQ0Jz
         ZJew==
X-Gm-Message-State: AOAM533U+drq8CbdHLDHy7RJ0UJp/X/0w/wPBw/wlLHO8ar7YBXbDMYa
	uCISN6ujR2r+J4+JTGjMjPulPDdoNme21A==
X-Google-Smtp-Source: ABdhPJxpi02iTs94uGjcNGlOGndoQLbRe+EYvx7Y9UYUfFlDcI9XEU86DDTJmWyPgv2TmIGlPt6w/g==
X-Received: by 2002:aa7:d851:: with SMTP id f17mr37799379eds.372.1619006148915;
        Wed, 21 Apr 2021 04:55:48 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:d3ed:a403:6ab5:b55f])
        by smtp.gmail.com with ESMTPSA id g11sm3086472edt.35.2021.04.21.04.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 04:55:48 -0700 (PDT)
Subject: Re: [PATCH v2] mptcp: using TOKEN_MAX_RETRIES instead of magic number
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
References: <39df61d9-15f4-6fbe-3f8b-42415de50044@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <d2f4918a-0553-2e5b-09e4-fdb98a0cb942@tessares.net>
Date: Wed, 21 Apr 2021 13:55:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <39df61d9-15f4-6fbe-3f8b-42415de50044@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jianguo,

On 21/04/2021 11:03, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> We have macro TOKEN_MAX_RETRIES for the number of token generate retries,
> so using TOKEN_MAX_RETRIES in subflow_check_req(),
> and rename TOKEN_MAX_RETRIES to MPTCP_TOKEN_MAX_RETRIES.

Thank you for the new version!

It is now in our tree (fix for net) with my RvB tag:

- 72339413f908: mptcp: using TOKEN_MAX_RETRIES instead of magic number
- Results: 5938ef1e7b42..5eaa9f1d555d

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210421T115449
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210421T115449

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
