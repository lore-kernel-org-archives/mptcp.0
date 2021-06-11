Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3946E72
	for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 14:30:05 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id g8so4902661ejx.1
        for <mptcp@lists.linux.dev>; Fri, 11 Jun 2021 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+WRadAzmUuyMktvcUyi6db1M9X8II96y1UqxxgkhjPo=;
        b=i21KG1ArahMHUivp0atVwbzg59lA4zHZtlYui+FLeiSyLE769y5A4rw/bXfaHoVTd8
         1It9N9mSQyD/j5/irhFwKpAgomZFne0wEY/mqDnT9a8s9qE0W5o1fpTpAUUrvCa4lzO9
         PK9zoyHDweAsLOAylT6u50rWKd1EdDKIUJzgpHHWvIQfs5T3BKCxazhfpBcMg8LE9Xeq
         XTCio89UCzA255NiAQyfE4r3js6bYdFOrrb4MWwEfHglHsqGTTCzIMS7fwzTRWKPw+dT
         Fhn1sEGdKgdTRtxkh8tSZ3lmy0IAqtNdAPt/w5s4EA7NUcXLZugjtwGPRbz/NEEPtKfQ
         5mJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+WRadAzmUuyMktvcUyi6db1M9X8II96y1UqxxgkhjPo=;
        b=I95XAgwPCqUogL6ZerIde+bOjpootN6jy2BQApz0xeCzg/S7PHjLDu7FuXfU4qmjLT
         CRQaWaEkZnIK6g5qUq0EPHgWi+2zE1/yHEJH6U5LRUZI3EhLZ5y47oZ9EkH22VwnBXLK
         Z8R0jJss59vqfiOmv8cXeagq24egRgDUkbyylK2My4LHKYY4YMIlWzWyoohGMMEwQmJL
         KEwlfWS4/Ch5ERNK/aUIejMhTkv94QiLwDO6MTwfi7b87lpmEjfYI9zUyQqr5MZyEO6A
         y5Y6oQBxREjCE73QHNgjdZfp1XauqhEj4MjwnoeVpzOaSA5y3T43xBaNgpr+bcCmmOhF
         hR2A==
X-Gm-Message-State: AOAM531CQeB86Rv0Cf1U0mChqlFrxHFqK7fqj8iG75BZdOHt6F09VFua
	Kfa7CMQNksd3IzRC8TEki2E8xOMAj3U3A1XWv2w=
X-Google-Smtp-Source: ABdhPJzXv/I3GrM1GYCtfCvcZiRDb+lD/oLUTsqgnmKHAnxYgXk3nRe7haOGco/aLFi0omVyL8R2Rg==
X-Received: by 2002:a17:906:6d95:: with SMTP id h21mr3994333ejt.260.1623421804226;
        Fri, 11 Jun 2021 07:30:04 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:26d4:4bdb:59fd:ed42])
        by smtp.gmail.com with ESMTPSA id g11sm2691158edt.85.2021.06.11.07.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 07:30:03 -0700 (PDT)
Subject: Re: [PATCH net v2 2/3] mptcp: Fix out of bounds when parsing TCP
 options
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Maxim Mikityanskiy <maximmi@nvidia.com>, mptcp@lists.linux.dev
References: <20210610164031.3412479-1-maximmi@nvidia.com>
 <20210610164031.3412479-3-maximmi@nvidia.com>
 <82474768-2c86-b2b7-afeb-30618b2ce094@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <3643daa0-fb33-5061-ee8f-546b8ac5823e@tessares.net>
Date: Fri, 11 Jun 2021 16:30:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <82474768-2c86-b2b7-afeb-30618b2ce094@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Mat,

On 10/06/2021 23:03, Mat Martineau wrote:
> On Thu, 10 Jun 2021, Maxim Mikityanskiy wrote:
> 
>> The TCP option parser in mptcp (mptcp_get_options) could read one byte
>> out of bounds. When the length is 1, the execution flow gets into the
>> loop, reads one byte of the opcode, and if the opcode is neither
>> TCPOPT_EOL nor TCPOPT_NOP, it reads one more byte, which exceeds the
>> length of 1.
>>
>> This fix is inspired by commit 9609dad263f8 ("ipv4: tcp_input: fix stack
>> out of bounds when parsing TCP options.").
>>
>> Cc: Young Xiao <92siuyang@gmail.com>
>> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing
>> connections")
>> Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> Matthieu -
> 
> Could you apply this in mptcp_net-next so it's easier to track when the
> patch finds its way to net-next?

Sure, good idea!
Thank you for the patch and the review!

Just applied in our tree:

- fdd037a5564a: mptcp: Fix out of bounds when parsing TCP options
- Results: 083034593cec..1ba3eb627299

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210611T142646
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210611T142646

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
