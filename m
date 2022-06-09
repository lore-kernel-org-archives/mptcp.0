Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9AA3210
	for <mptcp@lists.linux.dev>; Thu,  9 Jun 2022 16:28:31 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id m20so48451092ejj.10
        for <mptcp@lists.linux.dev>; Thu, 09 Jun 2022 09:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=53XjsaI9xTGUuOywoIP9s26OLP3W1DXLG73cFFs/Or4=;
        b=AWQ5jRjGDe8H2jtPPyZwvzDWh7t21NiS5m7xVOCcQyA81e+TuITGX+g5uBky8LS3Hj
         cCFsFLGb6Emn0VPtWRqE9jfsfsjP5eDf2zMMUGVnhiNi/v4Pxq4PXl3B99L//Is7WJt0
         TMZkaU3hxtpZIpSLKKf7eqcRqQ50mZBqfV1+hxKSom+6+7WIobj1vwmxPJObx2ZAWYrx
         zGYEj74E4HmHoljQsNYpop2PxNuEqGPaT+KhilWvapoMWu2t7g416v3/rBYKVwA8maGZ
         Sdf2kBhWf9NLrXjs1lSAwhzK+WTSLk8VRRubeUiwuNEPeKsQhzJDw1mw7V3ClbIQN2pB
         Fz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=53XjsaI9xTGUuOywoIP9s26OLP3W1DXLG73cFFs/Or4=;
        b=CLPpn7hL2EIe1CGqdeQvrqlgdEeh0XQMU3s3T5QAAPiUxo0cRm/xIVC2Ox7w9UW6DJ
         /qn/LqJ/UkKXkgvCrYf+KYE9GhRcR8nZdrEzfFwt73rbxVEHfgaUok3w94FkLPQB6Grf
         PWQFcasfGmcDhJfOL6XLKmG1vbTBG7jXvQC3Miu5zjQgHWzmn/f/x/Mf9OFvgIkqNRcf
         Eq/VdtZ9iN7wDkqENq5dieXnIDpaCSY/PtidAGA34xQDddmVLU9CDuGsJzbOovCBByck
         /KxJwEQ+q2AL5TaiVfzKQK4CTPLQfpA9lZCXSaTKJenOb6yHEy0zaFd8nMvfHZf8NWNT
         k2cw==
X-Gm-Message-State: AOAM5305q8f+oiZa1ztojWfyyjnhne8LrI2NhJUpGXkUmsV9VhtysKDd
	xlQXKJcO9y/Mkvfx6zSFWm7/QYbGwgMinruoJTw=
X-Google-Smtp-Source: ABdhPJxaxSSr+efXRhBQlf/NhTRvAN8LjbBTyX53dd5cdpQ+hp2wchzzRjMOUV+WONHCPYARD8RnmA==
X-Received: by 2002:a17:907:3da3:b0:711:ca9a:ae23 with SMTP id he35-20020a1709073da300b00711ca9aae23mr20853818ejc.709.1654792109850;
        Thu, 09 Jun 2022 09:28:29 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:b617:e76d:ff8b:2261? ([2a02:578:8593:1200:b617:e76d:ff8b:2261])
        by smtp.gmail.com with ESMTPSA id dc5-20020a170906c7c500b006f3ef214db7sm10901353ejb.29.2022.06.09.09.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 09:28:29 -0700 (PDT)
Message-ID: <7c6d1d5e-fcfe-f86e-d8e2-07d805c59b29@tessares.net>
Date: Thu, 9 Jun 2022 18:28:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add bpf_first test"
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <f5ce13a35164d0c81c47b807d146632795f6255c.1654752190.git.geliang.tang@suse.com>
 <44b26c1-f88c-6131-f81e-da719114d744@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <44b26c1-f88c-6131-f81e-da719114d744@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 09/06/2022 17:27, Mat Martineau wrote:
> On Thu, 9 Jun 2022, Geliang Tang wrote:
> 
>> A small cleanup, separate the code of base subtest and sched subtest, do
>> not mix them together.
>>
>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>> ---
>> tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++------
>> 1 file changed, 6 insertions(+), 6 deletions(-)
>>
> 
> Fine with me to rearrange this test code and squash this, thanks Geliang.

Thank you for the patch and the review!

- 0729c68393d5: "squashed" in "selftests/bpf: Add bpf_first test"
- Results: 19fb763aac71..a9fc640fbfb4 (export)

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20220609T162747
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
