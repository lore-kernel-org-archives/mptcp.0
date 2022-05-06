Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3733C4
	for <mptcp@lists.linux.dev>; Fri,  6 May 2022 19:31:14 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id i19so16240842eja.11
        for <mptcp@lists.linux.dev>; Fri, 06 May 2022 12:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=oISN9ay4MvhuRgnxaF3218en3a6y0HJ6HmjgEVNIulU=;
        b=ZpxoCDfsZrWbcQEMnVdXEen6NQud9011h1a0aFtkJQDCvsP64KJywLRD1GfceCh+3O
         SzH7r90Id0qJA85JJTMK0Goqw0N6KFlCwwz5MA3YiVsID5/0fB2Ovu4WyC7Erw+u/q75
         ylPGMLvOfym12U+38RbYQLf1MsjgWIZR3HNlNq0G+QcDgwya5Qse/uJ00IN4h1O+8ooq
         iNfawW9C0AXgXVX5si5wV8Cgj7ljfbVpsSmUQqIFGXagGtzzB+0x42b5YS/c63dtzQcR
         WyF5TqzXgQQymA+mEbUmoKsweWG3I0NzB+9Gf/bbBjhQ5fUjcVIMscKkybt44mEFXY6C
         RjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oISN9ay4MvhuRgnxaF3218en3a6y0HJ6HmjgEVNIulU=;
        b=dJWZ8iqoG3YUZUulS0dqL0Cz+nJEQn7ncjqeAruLqD3iOxOLhxC/VK82wy0EM0TENg
         zEAvFgoKrnmIiNax5G3Jd/rXZEheW46VDwa1eZ6wycQ8YKE48dJ+Gvj0niyUYXxfH+FZ
         jXShDwWSlkPr4TsWDpMY7QKOxa8VqkawNDtW6bYUyG1tTFNjlEHBVo8qVPzB0gIv/wv0
         sC6KIWQiUaCuZoILO5qeRZXnIbGxW96Z14pUbYKI6cURXl3PXh99xvjUCE2q+j84VDdu
         8t51NS9Bv4aQsHUWf4kA8ILyxOyocpUHSqnbo4nlzrU2bpNjePASlbJw+zWyveEPoZDa
         JBiQ==
X-Gm-Message-State: AOAM530gT0ZV31OMBwmtHa0eTgHJKkRtH4uydEoSHoxbyB3eXg2LbzSn
	p0NSxPuEp23+kQy8aIWDamWj1w==
X-Google-Smtp-Source: ABdhPJyQ3Jw5ao6XTgB1Ko8SeaR1nqILC02w6XTnFdnleHS7O3ytPoKJqhiKLAC6zPgHEojBMRObeQ==
X-Received: by 2002:a17:907:11c7:b0:6f3:941a:83c2 with SMTP id va7-20020a17090711c700b006f3941a83c2mr4397264ejb.33.1651865473088;
        Fri, 06 May 2022 12:31:13 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a? ([2a02:578:8593:1200:b63e:f9ca:c9c4:cf8a])
        by smtp.gmail.com with ESMTPSA id eb20-20020a170907281400b006f3ef214e71sm2177956ejc.215.2022.05.06.12.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 12:31:12 -0700 (PDT)
Message-ID: <c1a331f6-3a9b-8538-3faf-5d455de379e9@tessares.net>
Date: Fri, 6 May 2022 21:31:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v2] Squash to "selftests: mptcp: add MP_FAIL
 reset testcase" - cleanups
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <5f8677f1bf662a25beea0504c7981ab2e4c5531e.1651724227.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5f8677f1bf662a25beea0504c7981ab2e4c5531e.1651724227.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 05/05/2022 06:19, Geliang Tang wrote:
> Drop '+'s passed to chk_csum_nr, with Paolo's fix [1] for act_pedit, no
> extra checksum failures now, no need to add '+'s anymore.
> 
> [1]
> net/sched: act_pedit: really ensure the skb is writable

Thank you for the patch and the review!

- f0356d33bafd: "squashed" in "selftests: mptcp: add MP_FAIL reset testcase"
- Results: 9a52d7243fda..9a06ad1b6cf2 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220506T192929
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
