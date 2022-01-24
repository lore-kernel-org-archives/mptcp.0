Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B88173
	for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 09:47:45 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id a18so55371545edj.7
        for <mptcp@lists.linux.dev>; Mon, 24 Jan 2022 01:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=FCswft9QDTZqXMAxMasiPM3ROxMHbJs1CoRSnFMqBP4=;
        b=Iq93EJnCP2ksFqTXCbvz4HMXA/rbMzHvrHGJi+/fhp7Wd3TM35qTz7QZZOO78EjofO
         EAFllSZ+jeQHdV4wEY17aa173kwC2VXn6z/ui+fGQD14rsF865XSZC+A0z1J4dfFEKH7
         gDKcVJSzVB4NlSeauDCqrB/xOB2CLCB03es1EIctRICm5VHh9uB7sa02Em37KDORr/Bg
         UmNjU8Yf2Krv9ZQiZot80yu3Nr1L7Z/MUwDFW9BTMCH3nXGl5RmxPBZPpzIKaBi9F3q4
         KX+J/Tc2YPq7Rd38uCCrgsBq48q3MoI0IT3St/m+14ErP02K+x4liQwWujrE5VCFPaYk
         SOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=FCswft9QDTZqXMAxMasiPM3ROxMHbJs1CoRSnFMqBP4=;
        b=5u9hkZ98M+mfeV4L2M4ffBm9vANqv29AtuVGtxlVmJkcy3cb0Bid1IDfQmM1aYWtaN
         ksi6jtwOfVxgChkx1GOg/LGtLsrdUit59tWgrHEkdVVlFkreqlCW4X+T6Tqi7JU1QODj
         rARkZZPQC0I2gMygA22x5N+HwO9jCRcKePsbNfVevEXslb7MRvZ5czQT2QsPCmdn2bQo
         Msrx4zRdQC8gnoVaA0Yvjg5GuJ9vwSCmNzQWcPExkOFa7rMXc9AZT2p+BGjTUjVMtj4S
         c8Z06x7q+KrZXY4c9XJGDrYu4rRszenYUxlKzVVikCVElA1nyj1LpdqmGFe7uJSbnKS0
         aDxA==
X-Gm-Message-State: AOAM530qmYc/A6JYEFRVAVec3rE9cwpexA1UVNzvSNoXokToPkb9Vumv
	naqtEiNHUkZTrzYECQu4KOBCYg==
X-Google-Smtp-Source: ABdhPJwCS3j9TpyfaL7XWudRFWu+MdOdYeRQDjd8hadeLpna8CV4TiQVqrvDPTtIzAu9wmrNDmQURA==
X-Received: by 2002:a05:6402:650:: with SMTP id u16mr15413342edx.163.1643017663305;
        Mon, 24 Jan 2022 01:47:43 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:34ac:d0ea:17a3:8b08? ([2a02:578:8593:1200:34ac:d0ea:17a3:8b08])
        by smtp.gmail.com with ESMTPSA id q6sm4660902ejz.150.2022.01.24.01.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 01:47:43 -0800 (PST)
Message-ID: <e40ac28b-eba6-fa06-7e9e-df5cc5ae3dc0@tessares.net>
Date: Mon, 24 Jan 2022 10:47:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: selftests: mptcp: add mp_fail testcases: Tests Results
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>
References: <28db1152f29194bec48ad28dd37b7706cb92446b.1643011961.git.geliang.tang@suse.com>
 <8c351fc3-c76c-64b8-9522-ea489e7bc47f@gmail.com>
Cc: mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <8c351fc3-c76c-64b8-9522-ea489e7bc47f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

FYI, the public CI has some issues validating your new tests with and
without a "debug" kernel, please see below ("summary" links):

On 24/01/2022 10:25, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal:
>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/4549900066095104
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4549900066095104/summary/summary.txt
> 
> - KVM Validation: debug:
>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>   - Task: https://cirrus-ci.com/task/5675799972937728
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5675799972937728/summary/summary.txt
If you look at the serial output ("Task" links, then click on the "Run
test" instruction), we can see a lot of:

    tc action pedit offset 162 out of bounds

Could we reduce sent data or reduce data only in one way, where the TC
rule is applied, to avoid TCP pure ACKs causing that?

Cheers,
Matt

> 
> Initiator: Patchew Applier
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/18e69ba94769
> 
> Please note that some efforts might still be needed to stabilise the tests
> suite when ran on a public CI like here. It is then possible some reported
> issues are not due to your modifications. Do not hesitate to help us
> improving that ;-)
> 
> Cheers,
> MPTCP GH Action bot

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
