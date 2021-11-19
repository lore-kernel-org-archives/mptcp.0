Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC092C82
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 17:20:01 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id w1so45548161edc.6
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 09:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jewM59c6kfB/6LBtpSk4Z/fTGQGdNQuuF3tF1aD10tY=;
        b=BbV/7+bLn2fOOdKY5N3YFNqb4aiuN3UJoUc2R6V4tjdkyI4B6098RIMg0EcfBNxLRF
         GNb86YPOHg9WwgJvS1WR7QMpsfzI0BbiOgWrTEr3SBD7ZFgYe8ljCzb3+hvVz8e2oERT
         6Ryd1WSFyt2l7HZXYR70hTQgdNSc61Kz5WELTv6LsJ50W7G33p+NdX546bzpOP9Aq93H
         xWuv6uaHz7xSJc9w/yKfN5s7G5gavqmCOB0XcSwHpQ0eQHVTeGpYLfE9s6JlQY+Gi38n
         FlBjgATLlzLXg6wd5EyrkXpzlikQ4i5cAXpoblpYuGgwpvdZi29A4azAim9TX+1twMe9
         XkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jewM59c6kfB/6LBtpSk4Z/fTGQGdNQuuF3tF1aD10tY=;
        b=yee7MSDK+UDuC24uN9CuXDGbu6GGN7zx3TqMV/irnizwV+NpaolURb8XiztwB+WyIY
         4NpavOc5oRS9DvMlkdkqhpcCAAHvfM0oVxNUQUgSZde1jxUkjZWuJtuD5WYSRyO65quC
         8PQLjbq+PTe7RfD5dZyAOQzR61QRnCPYHGSgT1Gk6qizynCeRe7h/uC9qjhIA1s0Ii5w
         q0c9eUz5rTAAhm6ws63D16J4D4L0M8XvPMOklFM+eAFKV7DKcqnfFlS5qOywgcYCBzlF
         rhIiGOps9bVZQyzRsLbUD1Skw85I2Kt9Goees0aJKq1u+xyhXNPOrwuCPN5BKd3zBTG4
         kbJw==
X-Gm-Message-State: AOAM530vOtjR8FXF2d/6DJpL9zNbP4DUu5FKe814zwpDHJEmtZeNsiNR
	qKNWaopdEdDTDLe+ymc8W70AGSo+2D7Uk7AI
X-Google-Smtp-Source: ABdhPJwQmIrDOuHaN2kpRyi0aPfmZo3iCXpbwwa3XOolLClgJqEExdQL9qqbwc+e4QQcKoJZsxmwog==
X-Received: by 2002:a05:6402:1e90:: with SMTP id f16mr26643526edf.91.1637342399717;
        Fri, 19 Nov 2021 09:19:59 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id hr17sm189172ejc.57.2021.11.19.09.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 09:19:59 -0800 (PST)
Message-ID: <3decfe27-907e-255c-5903-d34def1b2a82@tessares.net>
Date: Fri, 19 Nov 2021 18:19:58 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH mptcp-next v2] mptcp: allow changing the "backup" bit by
 endpoint id
Content-Language: en-GB
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <bc909f9556f6696220611f4691913329624f0edc.1637243913.git.dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bc909f9556f6696220611f4691913329624f0edc.1637243913.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Davide, Mat,

On 18/11/2021 15:00, Davide Caratti wrote:
> a non-zero 'id' is sufficient to identify MPTCP endpoints: allow changing
> the value of 'backup' bit by simply specifying the endpoint id.

Thank you for the patch and the review.

Now in our tree (feature for next) with Mat's RvB tag:

- 61df278130b4: mptcp: allow changing the "backup" bit by endpoint id
- Results: 209223221ddf..ad41cf142fb3

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20211119T171947
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/158

I left the "Link" tag as the ticket cannot be closed yet.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
