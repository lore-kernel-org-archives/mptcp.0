Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFA15ACE
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 11:59:18 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so50276355e9.1
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 04:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686052757; x=1688644757;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ssRwvsoA+YUczrgv8DRgWspzOWfx6FQTQqxWvdSNaY=;
        b=0ZO2hpZ+OpD5lD0CXkwuDxhAyiZ15tARAM5ifRUv6w9uro802F9qR2HYfYPegZq4nS
         Rk4YgxsYfiG0tbC7QRsiRlq/9bkciiSbPP7yCBAUClZSPlYQLyVEjs37wbCQ/EvgFE/q
         e2V6vwMCJlxs/reLg37jcGtziIx73pfUyDb76WFSxGUw/+9cSqYxhrchopD91ILh82XH
         ANgcl3vrfap0/BTkyRPv5/HlIDdBhDL9Uej2D0lGtcG+eTc89zqt5RVyHOrw15cW9Skd
         JxIddglge9blwY7uqRzmtsepS0ZNWvXwOh1PDRj2GWLO8/qjhSr77BUzwFOeJwMELg6F
         RqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686052757; x=1688644757;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ssRwvsoA+YUczrgv8DRgWspzOWfx6FQTQqxWvdSNaY=;
        b=HCQsI7ldntHemNl8CuxZbLu2DSZ4aO9BMlxd3icrEmZXcTk1kedkI5Ena2Fl+hvmh2
         qgP/9DPtV7u2ke0ZCIk1gXjLS66MCYp0NL1WuqiLDNHWMyLjoK6GBo107cY0l7XJ6+ZU
         orTGL8W+CRsw+FmCusbDMwNMywSkcnk5monQqLehUqfglFofIotFkeceCtgcNfv/lefl
         UGxQ9CyoIpG+s/w9fmnHXOm7d6d50X5NbaoSfqcKzCubHaQo2SwjunfKnD8ueXd1AcKZ
         rosmHRAlwZlA6B/feyJtiPPxxZUdg1i99DQp3Dg5D9p4oQB1RaUcuMz/MN1/KgV7jyDy
         Fydw==
X-Gm-Message-State: AC+VfDzy0DgwFseBT2HyO+8QjXG+uk9LvHLUAFt3yDI5855tD59nOSrg
	BRhUb0Aux9nw74L8+AzfpNGEHA==
X-Google-Smtp-Source: ACHHUZ6FiXDyOPrmRLoaEBRQB6Hj+235/TMWn8HSbImRyCNJfe2Ec4aB8ctCMgdBNgyCQ+7x8nD85A==
X-Received: by 2002:a05:600c:21d5:b0:3f6:42ce:a384 with SMTP id x21-20020a05600c21d500b003f642cea384mr1850032wmj.11.1686052757167;
        Tue, 06 Jun 2023 04:59:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:426c:bb31:d569:3738? ([2a02:578:8593:1200:426c:bb31:d569:3738])
        by smtp.gmail.com with ESMTPSA id z24-20020a1c4c18000000b003f734ee1670sm9993049wmf.31.2023.06.06.04.59.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:59:16 -0700 (PDT)
Message-ID: <9c00808f-ee54-d8c1-1be9-65d508c1786e@tessares.net>
Date: Tue, 6 Jun 2023 13:59:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Linaro tests: parsing of the kselftests results
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux Kernel Functional Testing <lkft@linaro.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <a1e6596b-cffd-9860-9146-f8a41defd22e@tessares.net>
In-Reply-To: <a1e6596b-cffd-9860-9146-f8a41defd22e@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 01/06/2023 19:41, Matthieu Baerts wrote:
> Hello Naresh and other people behind the lkft project,
> 
> TL;DR: how can we provide results for sub-tests like it is done with TC
> selftests?

If I'm not mistaken, it is OK to provide a TAP output in the current
kselftests TAP output, right?

The parser seems to be this:

https://github.com/Linaro/test-definitions/blob/master/automated/linux/kselftest/parse-output.py

We just need a line with:

  (not )?ok \d+ Description # Directive

One special directive to mark a test as skipped:

  ok \d+ Description # SKIP


If that's just that, it should not be too hard to support subtests. It
looks like it should even be compatible with TAP 14 if we add 4 spaces
for the indentation if I'm not mistaken.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
