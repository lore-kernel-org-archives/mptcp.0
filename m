Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9C71
	for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 16:54:29 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id j28so19389358edy.9
        for <mptcp@lists.linux.dev>; Fri, 30 Apr 2021 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ockIHPEax9F02Qbn74rnZ3kMw5LuYIpJ+km9YQDmDmo=;
        b=G07Cd5O/pIOAvP7Gt+TaJ1qDBWaHtYaUNxDatNa7l4Cbhg8PbGJV663NGcM/3Y4Yvr
         5dQt/CsMUFfM+cMM7+ph0dnLHeQhmo2IjlcKcZ6lHiU7JZ1e8nn0ateMQ4z+fScTKizT
         Iqmtat+6lS2MOkS60dqXaOCz1pjljTyZgg2r68mA2D5Sgf0uad1zwtbuj82D4AopSDXu
         Y3DpN3FMm44UlpH/aTD+QLZEb8ZeUuYDPwns6uaEA4bAUcDNqM7N6cBVn41PDkMLUA4H
         rf1+rV64O2aZfyyUV/22Gd5waotzlPwIGzz29tyoxO87wqDLJyth2ogxuGgmCwzyTsZs
         xB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ockIHPEax9F02Qbn74rnZ3kMw5LuYIpJ+km9YQDmDmo=;
        b=lhSaxmlHDW6QrW9zqXQ7PE5tYDpl2398me/BiDZgk0x6o/2MLA4q8dB0zaTdZ+BIqK
         TUfGcUJO1dKCXQjdE8D1d8/wlIwZHMRZ9DSLjEPCyxhzOopbzGCE8Czf9TvA2TtjS6PO
         ImRGSgLIFcoPurtzmBuZC1miDU3o16gL2bLmXnYme86BPEqmE+OHVqTgQXIQ5C6fTddz
         TgS06SDN2utMpEjStHfKZeUlxRx2Ensls3S0z+WYhbBvqkzHVEW4RdKc3Ax93qJSnOou
         GQJkJZIazHiaAPB+2+ah0yRIZsYVM2bA7LIK8TkfBL5zXO5ZoxOogc8525rIXH5N0V8W
         R8rg==
X-Gm-Message-State: AOAM533CEI/razW7Poe8NsCOXiHnAKUcuqJXGBmdwTvvRY/nfysrCwD6
	U1XDxogulEyiINHtXy6SRINN8b9/+sUDRNNY
X-Google-Smtp-Source: ABdhPJw8Y0pTHxMezfUt20irisBHzzd8eaFUauSwlXgtosPnIZLUm3+AHXYXzBT6i5ydAqzZhzm1MA==
X-Received: by 2002:a05:6402:36d:: with SMTP id s13mr7211032edw.103.1619801668419;
        Fri, 30 Apr 2021 09:54:28 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:b92a:fcbd:82a0:9dba])
        by smtp.gmail.com with ESMTPSA id l15sm1673250edb.48.2021.04.30.09.54.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 09:54:28 -0700 (PDT)
Subject: Re: [PATCH mptcp-next] mptcp: support SYSCTL only if enabled
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <20210429145912.2022531-1-matthieu.baerts@tessares.net>
 <9c92075-e759-baed-c1a5-7f167bfa60f9@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <b3a6e37b-0397-9a21-9ecc-3d30d873d9f2@tessares.net>
Date: Fri, 30 Apr 2021 18:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9c92075-e759-baed-c1a5-7f167bfa60f9@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 30/04/2021 02:07, Mat Martineau wrote:
> On Thu, 29 Apr 2021, Matthieu Baerts wrote:
> 
>> Since the introduction of the sysctl support in MPTCP with
>> commit 784325e9f037 ("mptcp: new sysctl to control the activation per
>> NS"),
>> we don't check CONFIG_SYSCTL.
>>
>> Until now, that was not an issue: the register and unregister functions
>> were replaced by NO-OP one if SYSCTL was not enabled in the config. The
>> only thing we could have avoid is not to reserve memory for the table
>> but that's for the moment only a small table per net-ns.
>>
>> But the following commit is going to use SYSCTL_ZERO and SYSCTL_ONE
>> which are not be defined if SYSCTL is not enabled in the config. This
>> causes 'undefined reference' errors from the linker.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>
>> Notes:
>>    The "following" commit is "mptcp: restrict values of 'enabled'
>> sysctl".
>>
>>    The goal is to place this patch before this commit.
>>
>> net/mptcp/ctrl.c | 28 ++++++++++++++++++++++------
>> 1 file changed, 22 insertions(+), 6 deletions(-)
>>
> 
> Looks good to me, thanks Matthieu.
> 
> Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

Thank you for the review!

Now in our tree:

- 2c38407bd1c5: mptcp: support SYSCTL only if enabled
- Results: f937cef8ab9f..f6df9e9d3336

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210430T165402
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210430T165402

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
