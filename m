Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E579C5F
	for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 13:44:45 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id j3so19362658edp.11
        for <mptcp@lists.linux.dev>; Mon, 22 Mar 2021 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UGQ3VqXHuBHwm61X01LflHH+tl7OzYNGvS8cksQ0eTc=;
        b=nJGF6Wtar95iFQXzjoGgWw38ci4lbJD1/fw/RsPuBwaSm+ybTRrTGX8mGQvy0TSQum
         ygPo64RaTi4H0OCjYJ9NNk/PdtVD2OccFAI0WilO92o0sP/fRGWmDsvSw1gzJ7T8INP+
         vrnPtPCZkg//xQkMcdLQBO6sVBOK01yuD2aTvV/xTnj2GhoPZUx++WOIYWRFugR8NhE9
         z8F+VB+KINRQxZDAEyXxEq0C6j0xa74LISz+r2F+n586t6xm9SfWRCUqGyi5PELLQtov
         UQcCgPaBVDHwTNalz7hoWJieQBOhWFrXQregemBViTQxrG/9K2J04X0aWByttBWHLlxn
         jOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UGQ3VqXHuBHwm61X01LflHH+tl7OzYNGvS8cksQ0eTc=;
        b=NVLaGvKYdIbpONV1oYXKrKMNyL4lxQtNAQsU8/mKuQZVH51Boy5jBizrZOWd0W/uEX
         D2G9mamz2P3mvH1FAy2wJ+D2ndZ7LZ/T5z8aoYJq9TnpRdl+CfgeCY55djXM71IHbIlW
         Tq4YeJDMq76ejjHfhKlpbaJIsaQJTB637yzLmyNKm2HvqZxWNdReLmaM6I0HN5X2aZBj
         jLCilKPAeZoXUPAlDzOh6kmbOuLcCFgA636BaJ0oHRuzgnB7TReYI/v1CItF8kzDZhFS
         skY28OihdFJ1OQ7aTP3kEvq2p9u/vrcA8neyJPXMggLFelT19B40yQ0mZOdZJH+HjCJU
         X5sg==
X-Gm-Message-State: AOAM533JDmWwkKUmfIveMu98ZpGgK2cGc2ccQA2zjkWepkA6+A/NDeSq
	is8KUzrmNehG12L3cDGzWx1O3QHMPKuelw==
X-Google-Smtp-Source: ABdhPJzNnD+IYLKX2BbVtsd5xMLp0Uu8HQBjbQTjbnxlOrBe38iID5weMRVbNqSHNdSmV8ZVOdJioA==
X-Received: by 2002:a05:6402:170f:: with SMTP id y15mr25800819edu.127.1616420683930;
        Mon, 22 Mar 2021 06:44:43 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:2747:b141:c895:b440])
        by smtp.gmail.com with ESMTPSA id m9sm9657553ejo.65.2021.03.22.06.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 06:44:43 -0700 (PDT)
Subject: Re: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 0/7] refactor
 mptcp_addr_info and cleanups
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.01.org, MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1615966219.git.geliangtang@gmail.com>
 <22cecfe9-709a-f4f2-b137-63df1227ed43@linux.intel.com>
 <76cc940b-096b-91f3-6cd0-23def55d5ba1@tessares.net>
Message-ID: <4d1b4dcb-67dd-742c-25fe-6af5f12d9e4b@tessares.net>
Date: Mon, 22 Mar 2021 14:44:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <76cc940b-096b-91f3-6cd0-23def55d5ba1@tessares.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hello,

On 20/03/2021 12:13, Matthieu Baerts wrote:
> Hi Geliang, Mat,
> 
> On 19/03/2021 22:49, Mat Martineau wrote:
>> On Wed, 17 Mar 2021, Geliang Tang wrote:
>>
>>> v3:
>>> - Add new parameters flags and ifindex to __mptcp_subflow_connect.
>>> - Drop the patch "mptcp: drop unnecessary CONFIG_MPTCP_IPV6" in v2.
>>> - Add a new selftest patch.
>>>
>>
>> Thanks, Geliang. v3 with the squash-to patch from today looks good to 
>> merge.
>>
>> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> 
> Thank you for the patches and the reviews!
> 
> These patches have been added to the tree with Mat's RvB tag:
> 
> - 7d9c5e39d716: mptcp: move flags and ifindex out of mptcp_addr_info
> - adbca536f2e0: mptcp: use mptcp_addr_info in mptcp_out_options
> - f7431619f09f: mptcp: drop OPTION_MPTCP_ADD_ADDR6
> - d535bedb2c1d: mptcp: use mptcp_addr_info in mptcp_options_received
> - 5f105703ff28: mptcp: drop MPTCP_ADDR_IPVERSION_4/6
> - 3f11612d8302: mptcp: unify add_addr(6)_generate_hmac
> - aa87ce506334: selftests: mptcp: add the net device name testcase
> - Results: 6fc4aa6765fd..9bc1436cd72d
> 
> And the squash-to one:
> 
> - 79c9e16f9824: "squashed" in "mptcp: use mptcp_addr_info in 
> mptcp_out_options"
> - Results: 9bc1436cd72d..7a40c945f992
> 
> Tests + export are in progress!

FYI, the export has failed because there are some new sparse warnings. 
I'm looking at them.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
