Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE212F25
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 08:59:59 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id cn6so3647538edb.5
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 00:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Cop7j+Ps7ibj+4A35wSZzz+SpB+TjIsVVUEbapwLIFI=;
        b=4PDAKFJMsECcNYfeRD5RXum22YGa+hEnDCJuvp/enEF/XenZT62YPFOeKfkmer4dW0
         2mK3kpVvuvjMk1vSMZ2mdpMcUG4bHAwQcHAGEPHC9l30uvGtidCaIVAO2aEfNvbDJNzA
         YCOX4K1dUGSZdtcYtAcTy4ePEzVPCpeOml5jZtJFFOM6H/+vkNuA7jJ8zF1e5WyP1UlB
         aDiLy+K5rMooBHpezpBxZr8um6cg7HS6NcebimGsVDmRRGESwbTZMgZLNdiTIloV7Tb3
         VPviBHOAKtW18VC83aaCwa+xXO8BrDCkunlIFw62ElJt7su2SzUm9NkYzZSTLt5lhVlU
         dWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Cop7j+Ps7ibj+4A35wSZzz+SpB+TjIsVVUEbapwLIFI=;
        b=d7FIaxyEpJWSTihCG5op/aQZol5Uk4dE5HZ2mf2OvGinP+gJvDPn37Uiz9bhFxGjT7
         8miZedbPmIQJu/ofvNRk6t0rlNT15QpFtQKDS/xQ5BSjFvxrUKxnfm2wWUeHC5PSKZO7
         M7fadawsFM6TTjKB3HDtuq+jUv7oVAVqKieZKQ3X04A0i3sgiyPioGD/vUYczFpO2Or4
         pMBAXzh3yv7tySrc35d4w68QiPdhsO9bpukonJ4AIH7iX1xdqUcoaxG3ZrIRO2We/kcX
         aZu30LzuTGj3F63pZ2P9uVcswKtUwv0GYrrG3ph1XzSsdQG5EqxsWqzIKTqNI6KP5qbV
         +BZA==
X-Gm-Message-State: AOAM530DhlZ0e0eowKXwP2ZeRnGt4a5guF90ono6GD/6dNjzTPc5AbzF
	lFjHG/EBuSnWHyKMpvsNxjZ9Xbu8WYmUKyK7Y9g=
X-Google-Smtp-Source: ABdhPJyQdzExm059Os8bA15PRPjfxtWeaXfmq5uxh4TxNbewKWC52QumowRASHBrmHl8l6nB8JeqdA==
X-Received: by 2002:aa7:d6ce:: with SMTP id x14mr1343466edr.266.1644397197772;
        Wed, 09 Feb 2022 00:59:57 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:43c2:5bca:4e2c:3c7d? ([2a02:578:8593:1200:43c2:5bca:4e2c:3c7d])
        by smtp.gmail.com with ESMTPSA id n2sm6000756ejl.55.2022.02.09.00.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:59:57 -0800 (PST)
Message-ID: <5a9e9189-47cb-ad51-d277-103e4fa3b246@tessares.net>
Date: Wed, 9 Feb 2022 09:59:56 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1644364562.git.geliang.tang@suse.com>
 <846d7cac1f134fe9d3b6e8ac2b0c0ab47defc341.1644364562.git.geliang.tang@suse.com>
 <358eb7b4-84fe-d8e5-c0fa-e172c8deb7@linux.intel.com>
 <20220209054758.GA29565@dhcp-10-157-36-190>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220209054758.GA29565@dhcp-10-157-36-190>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 09/02/2022 06:47, Geliang Tang wrote:
> On Tue, Feb 08, 2022 at 06:10:20PM -0800, Mat Martineau wrote:
>> On Wed, 9 Feb 2022, Geliang Tang wrote:
>>> +fail_tests()
>>> +{
>>> +	# multiple subflows
>>> +	reset_with_fail 2
>>> +	pm_nl_set_limits $ns1 0 2
>>> +	pm_nl_set_limits $ns2 0 2
>>> +	pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
>>> +	pm_nl_add_endpoint $ns2 10.0.3.2 dev ns2eth3 flags subflow
>>> +	run_tests $ns1 $ns2 10.0.1.1 3
>>> +	get_nr_mp_fail 2
>>> +	chk_join_nr "$nr_mp_fail MP_FAIL, multiple subflows, MP_RST" 2 2 2 $nr_mp_fail
>>
>> Is the first $nr_mp_fail supposed to be in the test description? It's not
>> clear what it means in the test output.
> 
> I renamed nr_mp_fail to pedit_action and get_nr_mp_fail to
> pedit_action_happened in v3. And updated the test descriptions like
> this:
> 001 MP_FAIL MP_RST: 1 pedit action       syn[ ok ] - synack[ ok ] - ack[ ok ]
> 002 MP_FAIL infinite map: 1 pedit action syn[ ok ] - synack[ ok ] - ack[ ok ]
> 
> I put the variable pedit_action in the test description to distinguish
> between the following two cases:
> 
> 1
> Created /tmp/tmp.vizRgvd6NM (size 512 KB) containing data sent by client
> Created /tmp/tmp.UZqbnNdWAK (size 512 KB) containing data sent by server
> 001 MP_FAIL MP_RST: 0 pedit action       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                          sum[ ok ] - csum  [ ok ]
>                                          ftx[ ok ] - frx   [ ok ]
>                                          itx[ ok ] - irx   [ ok ]
> 
> All checks passed, and no inverted byte received. In this case, no
> checksum failure happened.

I don't think we can say the test was a success in this case, no?
We expect one MP_FAIL. If we didn't have any, that's an issue.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
