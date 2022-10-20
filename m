Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481B3C20
	for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 14:24:44 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id v1so5504755wrt.11
        for <mptcp@lists.linux.dev>; Thu, 20 Oct 2022 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xWbvYe1TQCIkJM2NeXpDglY0Nr56P7RXNcXpQE+rdEE=;
        b=LWTZQwX04R/gHUcuqJt+QCU5bPusftuIeQal9hh1tOec3+KETrbbjEmbpDxon8C8i2
         L47cCCN5rEo8veT0wEUqaU8Lk4QBfedP0a4WPd6+cYvM/rEdYw/lqoOwU/uOeaLqzykn
         iQdk/5PzE6EZTZnh68Smu/7NJ3KYjFw85oWCP00GB2pTCOtzBwrPq/XlGdcUZQ9tHxbF
         ZNzXTjSEdrgbTSHZu5mRbqc7Rzdj70QuUnDsjrxgbz0khF1sYYZTniMkgC5lYcGuwOpy
         WxR7FRpAoRH53nixYdTFUqIiG5466dDBcsYkwB3uIHXNqeyN+y9ZBXDBQf4U1/oQ4HT1
         J0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xWbvYe1TQCIkJM2NeXpDglY0Nr56P7RXNcXpQE+rdEE=;
        b=i14Rzt2ALM+ihCs7YgFWJbtZgaboaycRGKhyEBD4brkyTn9twoZcA5enWG/Aqpg/v2
         lc/3bQEEmcLM+YHZZIm3sIQ1Tg1+wJmlwQuabFk6nUJb58mJGkcHmF8Gk20Imy/8zpHi
         Cv7bRg6HEan2d+OP3gcDOsu6DQERMOSZG8BL6Mtx+zRWK+VD/AoZSlM41CjI0p+mpU9E
         c/VoB0fJod044BICgjXhcdImAKDQe2zoyEVvfkeqhNkCGYJTVxhLDDQilmgoYHqpxbew
         ToJhZlrNLXKjiE+ArlcET6+SsXpWzUfmeU6a6oWDcmGDyoFYP8Vqhz5dNAHUQGHBqPH/
         sgdA==
X-Gm-Message-State: ACrzQf0qvo3GzqV0xtoFt6k8Wlus4liX9UkR1n5WYptQFC+RBYnWLuMZ
	x42bfXDPSveaaoVPNzZ3yu3lfg==
X-Google-Smtp-Source: AMsMyM47IVhlrmeXwsBv0VZqPk+YuA2MRtSJb3JEskFd5qOa6HV+dLLWKw7y4x94WC+GGTSLXot9UQ==
X-Received: by 2002:adf:ea42:0:b0:22e:3ca8:c269 with SMTP id j2-20020adfea42000000b0022e3ca8c269mr8701495wrn.186.1666275881934;
        Thu, 20 Oct 2022 07:24:41 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:d3a7:8451:3ef5:2fdf? ([2a02:578:8593:1200:d3a7:8451:3ef5:2fdf])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c4ecc00b003b4ac05a8a4sm4225891wmq.27.2022.10.20.07.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 07:24:41 -0700 (PDT)
Message-ID: <a33a5b25-3498-f745-465d-850e7c0501ee@tessares.net>
Date: Thu, 20 Oct 2022 16:24:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-next v9 0/4] refactor push pending
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <20221018110312.22510-1-geliang.tang@suse.com>
 <23006926-3427-35b4-242a-dac886f992e5@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <23006926-3427-35b4-242a-dac886f992e5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 19/10/2022 02:16, Mat Martineau wrote:
> On Tue, 18 Oct 2022, Geliang Tang wrote:
> 
>> v9:
>> - move "register default scheduler" out of this series.
>> - add missing "first = false" in patch 4
>> - patch 2 could be merged before the commit "mptcp: add
>> struct mptcp_sched_ops" as a non-bpf cleanup.
>>
> 
> The first 3 patches look good to me:
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the patches and the reviews!

I just added these patches in our tree (feat. with net-next) with Mat's
RvB tag:

- f7b33377ef44: "squashed" patch 1/4 in "mptcp: add get_subflow wrappers"
- abc20912434f: tg:msg: update commit message
- 810d6dba28d6: mptcp: use msk instead of mptcp_sk
- 3afbefdac9ae: mptcp: change 'first' as a parameter
- Results: e4c052c32f02..1f94545f93dd (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221020T142332

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
