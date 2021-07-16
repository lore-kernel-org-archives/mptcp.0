Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84829168
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 10:01:59 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id go30so14296130ejc.8
        for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JdgMQy1JmuTXrsxRnrDoyyxrww7ts080SeSR3bWB/jU=;
        b=2CEBodi8w3X3fUWeOfEvh9Nd9B5PjlOsDqEkienBWeIEwu/5ZzOt31l5G1LA1wtDM+
         J2AZ6hoxSxjjSu/aDjvbhGda+UIuFYFtMQ0V8yKCqR4YdUmKzEAtNY8royhw5HzfskjI
         BYs+xPZOsS/1fPwp8HT4bTtW1cgG+89tN44NezHE5kXDZzuG2ZTzpYCdpI48AbK5koAD
         DrBaQVfBu5NKgF4QEwzLTOqomgekU7kFoWY3WC8JJtI0hL8Pr//JIhKLFxsoXx1yWBlu
         AcWwTazZ+M30B1Izr8+ElEJ3MIJvlss75BZNjqfzUEUFQ84iVMT4R3lSXYyttvnKL7Ic
         376w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdgMQy1JmuTXrsxRnrDoyyxrww7ts080SeSR3bWB/jU=;
        b=eICFhNqjE9kedDBnL0gNc0eZf8drxID4mdspg61Hq8RWXq4BZxagRQTuvQ/zaY+2it
         Z1OFw57Za77Az1dVumULkNprfq2eU4aFLQfHbYzoJkhrNxG5aBTmK4JZv0Gg98FB5vQs
         RWSpqe0gWZwrX1nc2o5lAW9/OdrB3g45SVwigkp3KRyS61YmMj0ofhWbpSem3YcfeHwV
         +H16f9VBas/4It+2ZPC99/Cm+AVGP93NnvGcldidyTh7G92lA9fFRRYwIVw+xcfxkmLy
         qoIGjB+m8baxPHL26sUj4P76reLJTbOoRt3klSZcl6wLph2txgLnmxHI44oblM+mBSIo
         ELRQ==
X-Gm-Message-State: AOAM531tjwvR7T+4FvBCzay1MFpCavFsenOkFBakv3R7qRLRwD048Lc0
	FMnXlaRKx39nnnyuO7Nxi39Hxw==
X-Google-Smtp-Source: ABdhPJynhKlpTv+Vlhh4F6BkMXOTW5y1XeRmcyQPtUnj6C8sEJoBNdyo3It6BR4tMr7cYRHMbMN/BQ==
X-Received: by 2002:a17:906:b099:: with SMTP id x25mr10998317ejy.72.1626429717795;
        Fri, 16 Jul 2021 03:01:57 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b258:fe9e:46f7:ea69])
        by smtp.gmail.com with ESMTPSA id u26sm2723020ejx.8.2021.07.16.03.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 03:01:57 -0700 (PDT)
To: Paolo Abeni <pabeni@redhat.com>
References: <cover.1626210682.git.pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Mat Martineau <mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH v2 mptcp-next 0/8] mptcp: refactor active backup
Message-ID: <5bc5654b-2bcc-de8d-6e55-ddb70e1ffca1@tessares.net>
Date: Fri, 16 Jul 2021 12:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1626210682.git.pabeni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Paolo, Mat,

On 13/07/2021 23:13, Paolo Abeni wrote:
> This series addresses a bunch of issues somewhat related to active 
> backup handling. The most visible functial issue addressed here is:
> 
> https://github.com/multipath-tcp/mptcp_net-next/issues/191
> 
> This series also add some specific self-tests, to cover both 
> active-backup switch-over and proper usage of backup link.

Thank you for the patches and the reviews!

I just added them in our tree without a few typo spot by 'checkpatch.pl
--codespell' and Mat's RvB tags:

- ff602fc7b2be: mptcp: more accurate timeout
- bf507fd9b493: mptcp: less aggressive retransmission strategy
- 9e0347b01fcd: mptcp: handle pending data on closed subflow
- d3b26c3a88d3: mptcp: cleanup sysctl data and helpers
- fb36094314d3: mptcp: faster active backup recovery
- ba4708d59438: mptcp: add mibs for stale subflows processing
- d44276b1443d: mptcp: backup flag from incoming MPJ ack option
- 9975dc21bcc4: selftests: mptcp: add testcase for active-back
- Results: 1187a6e1e0e7..0cff4b614c2d

- dc374a0e2daa: "squashed" (with conflicts) in "mptcp: faster active
backup recovery"
- 58258485522d: conflict in t/mptcp-add-mibs-for-stale-subflows-processing
- dc374a0e2daa: Squash-to: "mptcp: faster active backup recovery"
- Results: 0cff4b614c2d..047cd75a9837

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210716T100127
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210716T100127

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
