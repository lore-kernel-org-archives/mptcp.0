Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60BB71
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 12:29:12 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id u3so7947484eja.12
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7+ek49xjMp2FYjFvt+0RdTwvRCTxGKQeUOk3Syg05ew=;
        b=GEgZYgBeewzV4G8gczdxjuOCgyE5On30ZT4AXoQTDSvQBT8NYR1ghaRM1Yvg037xPa
         qBRwsVyNuQbb97VC5OVTBOOIxACWFYBI7UnI20fUyEqn1hNVIqAIk5H3T16Tkolo/HEU
         NxnJiWPv1fNqJPCs/wz9Eyt4IpH4MYkO9x2cy69l+nnpdK0Zp2ik1+SWVk5AFUXiVMEr
         4LeTCtMsT5MbnLFKag5DgrbeYalD7EZWw96mx+GgS5RqVo2H8cGH0kqGzyLfGhI96+hV
         54R5eoEzhM5u4GPWvyNVZwfAsZ5te1piF7zYpNgs5eeMeBvEK7biex4XKObZHeDdK0ZH
         R0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7+ek49xjMp2FYjFvt+0RdTwvRCTxGKQeUOk3Syg05ew=;
        b=o+OkdJgGQZKm7AulGoqGsxhorpWo43JZfyN3RdnsKbbbhJQK6T8N8ZQ7yuRzvXbsR5
         n0xisJcjBGpMMQFZ4PZ/cEiPSoypyUs2Vs+qFSj5svkjpDExctNlroySF6CnK/m6OZCb
         srrI9KIJ93YEeoZC0Acfa+e6qvW6kyUI5N6N6Dg7BWR2usShXoGAoFBIhRI2CtOYOYr5
         LBWqgSdpQM/tE3eIUCiYr0e/XBPsJSDmqGBTX9CZrzBOCWNK1KgNZVHjO3J2wblN0zC1
         B4iYn6WcBBcZYrSkOT9RNnYYhzD+RajwEonRQANUyzm5UCBwFXK3eLXkB8ycyTYksUiQ
         QmLg==
X-Gm-Message-State: AOAM532LdlWiw+mXYzb5icLHUEepDnWQjuiJ8udJF8L0q2ldsQYd5I4P
	F8QeiUAEajUqOcgLsgAJBlblXMHiZ2iwa1/ySVqnYg==
X-Google-Smtp-Source: ABdhPJzz1Cug0ysT/ZpTBMvNOBC0F9RI9xSN6RQZRTczFYnxGgk5hb5FimOjeQVBB6meNyCi30tV9w==
X-Received: by 2002:a17:906:cc48:: with SMTP id mm8mr4105920ejb.344.1620304150835;
        Thu, 06 May 2021 05:29:10 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2955:d350:566e:2ff2])
        by smtp.gmail.com with ESMTPSA id y21sm823764edv.77.2021.05.06.05.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 05:29:10 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add a new sysctl
 checksum_enabled"
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev
References: <20210506103734.3845725-1-matthieu.baerts@tessares.net>
 <CA+WQbwu+cr0DW=REfMpUKao2sCtHnGCC5u_Kzufh0jdTXRuUrQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c0189cc3-122f-f182-658c-333e7adce137@tessares.net>
Date: Thu, 6 May 2021 14:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwu+cr0DW=REfMpUKao2sCtHnGCC5u_Kzufh0jdTXRuUrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/05/2021 13:23, Geliang Tang wrote:
> Hi Matt,
> 
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年5月6日周四 下午6:38写道：
>>
>> Fix a compilation error without CONFIG_SYSCTL:
>>
>>   ld: net/mptcp/protocol.o: in function `__mptcp_init_sock':
>>   protocol.c:(.text+0x43e): undefined reference to `mptcp_is_checksum_enabled'
>>   ld: net/mptcp/subflow.o: in function `subflow_v6_route_req':
>>   subflow.c:(.text+0xa0a): undefined reference to `mptcp_is_checksum_enabled'
>>   ld: net/mptcp/subflow.o: in function `subflow_v4_route_req':
>>   subflow.c:(.text+0xabd): undefined reference to `mptcp_is_checksum_enabled'
>>   ld: net/mptcp/subflow.o: in function `mptcp_subflow_init_cookie_req':
>>   subflow.c:(.text+0xb74): undefined reference to `mptcp_is_checksum_enabled'
>>   ld: net/mptcp/options.o: in function `mptcp_syn_options':
>>   options.c:(.text+0x68a): undefined reference to `mptcp_is_checksum_enabled'
>>
>> Simply moved this function outside CONFIG_SYSCTL with the other ones.
> 
> Thanks for this fix.
> 
> Acked-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the quick review!

Applying it now to unblock the CI:

- d1af2c92ce6e: Squash to "mptcp: add a new sysctl checksum_enabled"
- Results: e2c6acaa5239..dd923e74b091

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210506T122849
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210506T122849

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
