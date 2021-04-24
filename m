Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF41871
	for <mptcp@lists.linux.dev>; Sat, 24 Apr 2021 08:53:05 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id r12so77168571ejr.5
        for <mptcp@lists.linux.dev>; Sat, 24 Apr 2021 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALo/zJs8TseE0zm20yZLSjAlpPS+/HmWPIoRWvl8zME=;
        b=eR0Y3dMOif6NMgoiTlV/QWk1c1LshB9J35iHFa4JguyRxJF1Ennm8XCBSVuw4e1PTO
         /RZf1IwTtvIznm+i/7PIUZ++Muir4cINbK4cNPNxQiDLsYvFGlcNt8suYNUowLECajO6
         l625Cp0+id2OItsqTIxPp3YF1k7Sm5Hgplak7tFpYXouEF07Be2MhiNxQ9vu8SQJJPCh
         ydREHutV6EDbxXjV5xY/55Dt6ctezqAdUlfcH/2SY4/YdYsTl92FpVNadKspKLCxwwcp
         oxW8T+i1aLPpt4kVUMdA3j8tIAy1+OZBPs9FeeCy7jsAOQxwJeA0iFQOZMq84fIoIMYk
         vlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALo/zJs8TseE0zm20yZLSjAlpPS+/HmWPIoRWvl8zME=;
        b=M2t+5xbBGg9CJkTaWMYAcB7J3oZQbJXU1YaPLr2QSVAsiForugN6R0C+G6KlE5fkdG
         xG2bV4AhdJ2BFBqz4lnUC3UTYTjBm1+t1LiC1RQikZEhmnewhJsfXo1gdcLjMm3RmbE2
         weBCkhuZLq0bnD6o44GZ9hSX/gWMaV+yBE93AMJyKkeIP8VHjMUnQLHLdP8KkHFYbUQy
         rsQFLnwxl3lPYplhuPFlM5zwOFYmaofJWoef9vATxLq6dCwQDZ11XrUF5FvKcphSdo3m
         4WN0cuQC+lKimHH0Ye2qzOeV4AzkGk4E711Jg95MZQB6hDm2N7DojM+AYeBgSXwqjEbI
         CD8A==
X-Gm-Message-State: AOAM532tDtKspIa5cvyPPA+C1C0cDrc/9/MbxV4jslWpDSGlSMW1dicU
	w3kbLzX0vcrTmBWdR7BMVvj3sA==
X-Google-Smtp-Source: ABdhPJxWRYcnr6brfLS2gEUyoyYyJZopq7DLf/TTqxS/EmpLO4FiMNE+Rh4KAcneS1g/HImdbh+JjA==
X-Received: by 2002:a17:906:600b:: with SMTP id o11mr8345595ejj.345.1619254384077;
        Sat, 24 Apr 2021 01:53:04 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([185.212.171.137])
        by smtp.gmail.com with ESMTPSA id z22sm8798352edm.57.2021.04.24.01.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Apr 2021 01:53:03 -0700 (PDT)
Subject: Re: [PATCH v2] mptcp: make sure flag signal is set when add addr with
 port
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
References: <c388d556-530c-ee11-3ab1-a8019fb2eb6f@163.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <40823af3-2edd-b334-0393-b7652f8bd735@tessares.net>
Date: Sat, 24 Apr 2021 10:53:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <c388d556-530c-ee11-3ab1-a8019fb2eb6f@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Jianguo, Geliang,

On 23/04/2021 12:25, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> When add address with port, it is mean to create a listening socket,
> and send an ADD_ADDR to remote, so it must have flag signal set,
> add this check in mptcp_pm_parse_addr().

Thank you for your patch and the review!

This is now in our tree:

- eb86a8c1aeed: mptcp: make sure flag signal is set when add addr with port
- Results: 3692d2b92d9f..5c90fe877090

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210424T085242
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210424T085242

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
