Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE62F9A
	for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 07:48:34 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id j7so6944581eds.8
        for <mptcp@lists.linux.dev>; Tue, 20 Apr 2021 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aGg6sSyYIuU7IgfRK4Qs9Jhn2XZT3EuiHl30j0twH8g=;
        b=Jdqj5ldn8jxgRbHWuauW1csg0sEMwijU6WMSsLaatp2tzLOoiRBGvCp1CRuGRI2rhG
         7oifYFXLhPRbkPFQvNud+4A/s5RAFEbgV9ERl+6c/zpvoQe/kPHaVE4nvPZKvU6L3Ifw
         R6lyFnCwsVyzE1HFeitBxVncBdfMiANrfEaK+DoxM+XtAEbZm4tksamsYSzLK1qwemCJ
         usUt2NtMC6xWiq5lc3t8aPEjHpbxpjs7j/2Bme8xCPyxqHotSXm3+R5ahz1jhbWIx7YL
         Tbj3hNy/fqC72JqH7Al1Xhz/j5HhylCKNl2Hdt/SMk7zPT7aSGSa26ev6hKxEGn6Nk5h
         6xWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aGg6sSyYIuU7IgfRK4Qs9Jhn2XZT3EuiHl30j0twH8g=;
        b=uJ+QgTn0LhyqWoBK9LBaGjGW8isJQv5JzRDY9+9R1tLhRiwtLPq+a8Yj3hXuVMAe5R
         HaLSr6jZ09h74uLL6319VRkO+bZIfgjjk9F8ijUmxWk2d0TivPSQyTELcDYnJoOQvoB4
         LcwtJ27eIW3VZJRyBBcc4l2HqJHUaFeAOUvYA5eB/1REznxi8ztR8wCIGagkLyZYUNl5
         0VWXIiacGpv8V1x092MFE8I/lj7PvKl9Tee1ezYnBEoiSF6ky/Qu2JjF1V4KJhOtsrEf
         XQH2+hFloKo5rixrP713s1nCdiEw0ia00cbCVS1zzG1tAIsjnQBtUpQ/BIAX7iijLeFD
         UT2A==
X-Gm-Message-State: AOAM533j8qIp5+c5NQmX7xoI4IcgqGRCav2qZQJKmMbT6aBN4zrYIS8i
	czR9yl9EhIn52ea22+iAGV2CZA==
X-Google-Smtp-Source: ABdhPJxLqz21EBJZpyTQ4UY01ZIpEIhZB9F7UDxE/zemvmcPNojxNBKpcv2GfoMe79rBmwUdUitt5A==
X-Received: by 2002:aa7:d3c6:: with SMTP id o6mr23057428edr.359.1618904912694;
        Tue, 20 Apr 2021 00:48:32 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:ad10:5b35:8c26:bd5b])
        by smtp.gmail.com with ESMTPSA id e16sm15006399edu.94.2021.04.20.00.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 00:48:32 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, Yonglong Li <liyonglong@chinatelecom.cn>
References: <20210419203355.3937162-1-matthieu.baerts@tessares.net>
 <313ddde-a5d4-2c27-3b7-edc1e6751d38@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 0/3] Squash to "selftests: mptcp: add a test
 case for MSG_PEEK"
Message-ID: <eaf02c70-f4f1-ca6e-5168-cf96361c655e@tessares.net>
Date: Tue, 20 Apr 2021 09:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <313ddde-a5d4-2c27-3b7-edc1e6751d38@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 20/04/2021 00:28, Mat Martineau wrote:
> On Mon, 19 Apr 2021, Matthieu Baerts wrote:
> 
>> I started this because I prefer avoiding setting a global variable before
>> calling a function and reset it later in order to take a specific path
>> in the
>> called function. While at it, I also reduced duplicated code.
>>
>> But good thing, I also fixed two unwanted behaviours, see patches 1/3
>> and 2/3.
> 
> Hi Matthieu -
> 
> These look good to squash, thanks for the fixups!

Thank you for your review!

I just added these patches in our tree and I added your RvB tag to the
patch "selftests: mptcp: add a test case for MSG_PEEK". I hope that's
alright. I can remove it if you prefer. I guess you will replace it with
your SoB when sending them anyway :)

- 56b3332ce650: "squashed" patch 1/3 in "selftests: mptcp: add a test
case for MSG_PEEK"
- 2c2ca30de1d6: "Signed-off-by" + "Co-developed-by"
- 7d6c15c30c4c: "squashed" patch 2/3 in "selftests: mptcp: add a test
case for MSG_PEEK"
- 739a1c5fe1d6: "squashed" patch 3/3 in "selftests: mptcp: add a test
case for MSG_PEEK"
- ebcf2d3b0e42: tg:msg: add Mat's RvB tag
- Results: 04c5ff771be8..e69889ce0094

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
