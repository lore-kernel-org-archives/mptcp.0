Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82712F26
	for <mptcp@lists.linux.dev>; Thu,  3 Feb 2022 09:40:06 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so1429531wmb.0
        for <mptcp@lists.linux.dev>; Thu, 03 Feb 2022 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=igHE2RNcJzP2Dq+Sk8z1bUYADXa32Q1KXSFqaSORwe8=;
        b=yagJ74lEFJrKa9MpOv5ZQTpOvKTUcQy/VyhzOXGd4qfysQtvGMjpHwm3jJnxDMEtj6
         6ODe6XzZesetAU9JMZWNkYdFtvgExievFQqspg5ciFK18wZQ/weSbLASryFskDMjp+pg
         A3PRL8YiavcYPI6b9UJUnY06YniFBeqWjv4y8eqkucUpd45p69j4c32G286cxlVlXFQi
         Wfo8+RjLJCV/0UGy9nyXWH6u6NOgIXxAl6vNNU0S3cBFXsV5GprqearSFtPBd4v9ZJw3
         nym9VhgEIVhe1Z2wbr+l3ROMu9u/dVoCzfB1xKeTfNCUolO4nahVTyvf41Vgjhm+DSKG
         /Zww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=igHE2RNcJzP2Dq+Sk8z1bUYADXa32Q1KXSFqaSORwe8=;
        b=W8GVcLUYZXF4L4E1Y6PGDU0H92HQvg0h2F6DKLYOaIK+1fseMFivqdYE5XkaiCiCnU
         jd7/YivR0JtDXt60OvP/JoFFiPdlnkJVWctNA7yI5Og6scOf7OVOmudZCyPUKbiq+zuW
         sRPRqMox5F3uoEgTsKk+EPYJxmh0YeRRdbIhIcbg8K1eZdHxhf+1kJ935R5kgaGZSDna
         /K6/VqaNEihvMbHSMz0ELal3jeMB+mMor6k05PxZfFcClKlxNB9TrnFo/T4B/v9LnD6s
         Nyn/fYzVBwxTXDZ58+VXfr2ic7dtxEhjv5e09IsPqRRWZe68ZHFY0Z6P+0l6EjQ/GXn1
         MTJA==
X-Gm-Message-State: AOAM530FXfPM0RO+GNCKi3t1bs7v4FIIxwvRzyFtS3IC1GPHQ9z6s9gb
	ddm8+mtxlrPWpOa7okmXQPFFF8v2ViqJCA==
X-Google-Smtp-Source: ABdhPJz3vNtDxLCvCffcswWNyCBAYaXm4Y3EoGV3Psf/ZXdxxzdbmlVMEStntTKe1n38scXHqya49A==
X-Received: by 2002:a05:600c:17d2:: with SMTP id y18mr9683891wmo.165.1643881204545;
        Thu, 03 Feb 2022 01:40:04 -0800 (PST)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id c11sm23300025wri.43.2022.02.03.01.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 01:40:04 -0800 (PST)
Message-ID: <b736bc14-d4b5-f17d-59b5-10ffc25c2fee@tessares.net>
Date: Thu, 3 Feb 2022 10:40:03 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: fix diag instability
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <8e7b626d99b8c28b8638f850841707c63deb0bb4.1643825648.git.pabeni@redhat.com>
 <9455130a-c843-debe-ef6b-354e2815c7dd@tessares.net>
In-Reply-To: <9455130a-c843-debe-ef6b-354e2815c7dd@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 02/02/2022 20:35, Matthieu Baerts wrote:
> Hi Paolo,
> 
> Thank you for looking at that!
> 
> On 02/02/2022 19:15, Paolo Abeni wrote:
>> Increase the time waiting for mptcp sockets to get established,
>> to cope with very slow running host, or high jitter caused by
>> VMs.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> note: just to trigger the public CI, probably a better commit
>> message needed
> 
> I was not able to reproduce the issue #248 on my side after 650+
> attempts with a non debug kernel. I tried with that mode because the
> public CI mostly have issues with this test without the debug.
> 
> But at the end, I managed to reproduce it with the debug kernel without
> your patch. Trying your patch  in a loop on my side.

Thanks to your patch, I was not able to reproduce the issue on my side
after more than 2500 attempts with a debug kernel.

I don't know if it is important because we often miss them but just in case:

Reported-and-tested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/258

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
