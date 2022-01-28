Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35F2C80
	for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 17:04:52 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id l25so12019489wrb.13
        for <mptcp@lists.linux.dev>; Fri, 28 Jan 2022 09:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Wn4XNTj1jbjyTIKjFnut6mj31n5tQ8qtiL6syj1cWdY=;
        b=EUmMXAWt2Fuyc/Fq0okkcM1q4uhxCCCZbF4TYpRg5faSj6VSLrFUenw6TvSMiRQ/2z
         +u8gCKKz0OeO1feVEq9qwmxnD7pxHdWrYedMlwBBS7XWB0aM2mrPUNu80Oe56GPqrYjA
         g+RIFYexQmKsUHOmyqPe3dGzZ56cXUoQTO3AvC30/31uEPi8JbvdNnZaNMDmPUV5EJuU
         SxFjLNR/jvrmbicGDqoQMl4re6LE0/qEK/iuWKD83X0/dDbrGq6txYisRuBSqwM6DnlP
         xLCEdblhSaPbO9VETtBZu6V7lJ5jx5TdTtEcM90aHx2Ld+1JW1FfWMMGa2SO/dUiwaOY
         lv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wn4XNTj1jbjyTIKjFnut6mj31n5tQ8qtiL6syj1cWdY=;
        b=ouDLmw/AQzQ9B48KaW1/CyWwPaW0TGHwyKp1H+WoAPkbzafWDmwGZbCqexc7SJtRuG
         lqY2lhc6zxzYrRFoUFrUVB6qjenO/eTxjFNWTRAH54s8jR+r4xQWLcP5oj5l2ll0W2Ob
         cYMhQMYzKIpgbXoeL1IqoUYd4QTehKZ5J4i+64LttKhBQpCfVp4uGYsTah0oyhBhtSLW
         TpdOFaRzeoLqr8tYflv0ULce9FlUu06Lb0VxdvZeXRNJ4AGqMO+2ih22degNy/iSH4Ro
         ycfC5dKkHBEm8Sja5+PHHyVi5a838xncCesJ3sV5LGivnEE86vko0aik4m9NO+w0vhFJ
         HCxg==
X-Gm-Message-State: AOAM531iFoM7ty5WqYUPIArLUoVqsEBY8FYrl166LDpFE76VGE7JLvTn
	poPfUx5LPvziFNV+mE68a3EByQ==
X-Google-Smtp-Source: ABdhPJyMjmcG//Sai9Y26cBXQiTe4Lk6S4AF5ZVkBUnjZ3uQyN1V7F5G8QSn018BEEIHcJhQ4780mg==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr7861348wru.513.1643389490591;
        Fri, 28 Jan 2022 09:04:50 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id b2sm6131286wri.88.2022.01.28.09.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 09:04:50 -0800 (PST)
Message-ID: <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
Date: Fri, 28 Jan 2022 18:04:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Geliang,

On 27/01/2022 01:07, Mat Martineau wrote:
> On Tue, 25 Jan 2022, Geliang Tang wrote:
> 
>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
>> checksum failures.
>>
> 
> This patch is working well with the inverted byte detection, thanks!

The public CI seems quite happy with the new version, good work :)

Here is its report:

====== 8< ======
Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/4993794666921984
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/summary.txt

- KVM Validation: debug:
  - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
  - Task: https://cirrus-ci.com/task/4682233209421824
  - Summary:
https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/summary.txt

Initiator: Patchew Applier
Commits:
https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
====== 8< ======

But if you look at the logs [1], there are probably 3 last things to
improve:

[1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log

This line is repeated 90+ times:

  tc action pedit offset 162 out of bounds

(we talked about this one at the last meeting with ideas on how to
reduce/get rid of them)

But also this one now, repeated 40+ times with different offsets:

  file received by server has inverted byte at 106565

And one last thing, we can see that now we have more than 99 tests, the
alignement is no longer OK :)


  # 101 1 MP_FAIL, single subflow            syn[ ok ] - synack[ ok ]...
  #                                         sum[ ok ] - csum  [ ok ]
  #                                         ftx[ ok ] - frx   [ ok ]
  #                                         itx[ ok ] - irx   [ ok ]

A very small detail, up to you to fix it or not ;)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
