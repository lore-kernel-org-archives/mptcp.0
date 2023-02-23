Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457723A5
	for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 09:14:54 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so5651019wmq.2
        for <mptcp@lists.linux.dev>; Thu, 23 Feb 2023 01:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFeQNQ+M/pRvAUpMJU33ATQotaa0khSm2jpw9oSt3zk=;
        b=12PnSYQvC8x8DM4hDE6mc6CrPvaYJcMvcxFQYjyh0DqLE9KJdq1JuXXNgMwzTECV9V
         U+AlnScjnEKLxg0+A4+O6qktTJIWEBe0d4M+yVmNxlmr+YRTFENpOxZmRh7avgqR7GrO
         Q42qkE/iAvGDSWgM9Mb0r52iZ+cOBb30e5LqiBy3izCqBfFmVuM91zytN0ZxAnHwoTvu
         V5kkg40J6KVk1Dk7On3Rs5DIz2/8YLmx2LjzqRShxY0c0xH6J5a1gNURl2Oz9BZHu3Ye
         rznVMWex7qUSoIB8h3gLIxMqYeBsgnpLn3ySBMcbjrrWEntwOmCC1uPwaO1UCd2vda9R
         MTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFeQNQ+M/pRvAUpMJU33ATQotaa0khSm2jpw9oSt3zk=;
        b=59bdbbLJS+Qez0xPVZpTsKKvFFeZ+PZ/H7M1HSvPr3hcf8WFO9cC443+J5nKI2nfpA
         pursq4batRsi86TeG4MkzrDzqEd+NamWnWC52YU0BC4UP2ekrLjqYWshDxUpChqE8J5s
         0GBIS+nwzh189caNFVS1Cy9BGjEt3dIwEpw5ZqaQ3J8GUhKCY1F3CSUybshqhClbIRxO
         QGYpV6u1YUBavlZLaeVdQcTe/mccFRZZ4GZQNuT3FWaJKFuQCwDRdBUwmWv46zm8vMML
         AgM4XVAmvmC6NbX/nCQh15bcigPnbXR8WUUzMDjIOGiBcpX02t4GFjK8TLmQbp3kLFxA
         v8FA==
X-Gm-Message-State: AO0yUKWooZRd5aF/cO8nZNIAuKwopUz1Q+y8KRT1RSNGOn8hj4m5BB6w
	RTN0PkvcDDFC+n/+Nl52eN8Ylzyo1hdgxFLR9XE=
X-Google-Smtp-Source: AK7set+Nc7XzZu8PrWM4FZnfb0/Sp2zo6u10tyB+xD2075y/4TtBCL0N17lGEC6i5rVIa3LBgiqvNw==
X-Received: by 2002:a05:600c:3b86:b0:3dc:4fd7:31e9 with SMTP id n6-20020a05600c3b8600b003dc4fd731e9mr9217553wms.7.1677143693105;
        Thu, 23 Feb 2023 01:14:53 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:b5a0:3898:2dad:3d15? ([2a02:578:8593:1200:b5a0:3898:2dad:3d15])
        by smtp.gmail.com with ESMTPSA id j29-20020a05600c1c1d00b003e204fdb160sm5093240wms.3.2023.02.23.01.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:14:52 -0800 (PST)
Message-ID: <403ade13-2cc8-d8ab-63a1-592881b4ff66@tessares.net>
Date: Thu, 23 Feb 2023 10:14:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: userspace pm: fix printed
 values
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20230216-mptcp-selftests-userspace-pm-typo-expected-v1-1-e004734154d6@tessares.net>
 <CA+WQbwuNVam8nM-pbNupxznZECiKb43-0RgRiEddF92vPjEsDA@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwuNVam8nM-pbNupxznZECiKb43-0RgRiEddF92vPjEsDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 23/02/2023 06:55, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年2月16日周四 18:23写道：
>>
>> In case of errors, the printed message had the expected and the seen
>> value inverted.
>>
>> This patch simply correct the order: first the expected value, then the
>> one that has been seen.
>>
> 
> Matt, this patch looks good, please add my acked-by tag:
> 
> Acked-by: Geliang Tang <geliang.tang@suse.com>

Thank you for your review!

Now in our tree (fix for -net):

New patches for t/upstream-net and t/upstream:
- ca6c4a980444: selftests: mptcp: userspace pm: fix printed values
- Results: 0b504c8bc901..32f1046d667c (export-net)
- Results: 6bb4cfee7e04..7264bacd3544 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230223T091254
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230223T091254

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
