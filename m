Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECD68
	for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 09:18:42 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id g14so7275363edb.8
        for <mptcp@lists.linux.dev>; Wed, 24 Nov 2021 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=8wOvxgQdrseGiXUcHSMNACTWKoYTQ1atdTsY3KEtFb4=;
        b=HOafm0OBBJyYwd40GDM3Zzi/LFJeKHUTnaLkp56hPDKtPh7JLVMharZvAKpSccg8mK
         JlIvs8WWOzPXOZWf+vUXtTd9v/+NTlQ0bGsDPpIQ2tIMpQwF+q6aSUqF8IeCorDsWarB
         sjFcrulGpSfn0wwB5PYSjdgN6NN1uG4MesPSKwDLjt88aCQa7p2wpgnuLSHkk/mCejcF
         aH6Q3gOrU78dBeExpV6kJYpMCP9yU7W9G1QAEKETG5CwVgsrTPN04FAhMhWsZvrbUOYR
         D34DNeBEB5l81krYCfazcga5LIe7zqZYk84Tz36Il43B5VRzvmT/hiOh3MUJDCyL/L+c
         z5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=8wOvxgQdrseGiXUcHSMNACTWKoYTQ1atdTsY3KEtFb4=;
        b=Tv5B66mZd+HV2WdWSUtH+bs2J3T4PSJvpG82FyIhlURrViUL25GpY8Zz6WaG8Tc/9H
         B1+dFbmkgRwRtoz/L9oG9Grbm+dWu7mXi/6VO4WF1FhdFQHxSzULSz2a4vHvgXPzjvQR
         28f+1Gd1DHCDrAeCC78to99CvAUPQjzjv6wV+4QiJH9cKS5w6pELi6t4/4UNMhyFZadp
         LgM3Qltkh7eKDfAA5qb32aTR0aPhb+/R6QCZSKxLclq3X3xsYgaQ8ff0fWOv8uz6EuDd
         jJ0Y7uGaKgLxwoEPo/NAXGyraKB6hZ3lU1tusetgf2J8FsgC6N7GdvGRv19W/NgqOk42
         yQSQ==
X-Gm-Message-State: AOAM530lYk7jamIB5+yldAj0h6M0BTYILvUd+B4AnM2/HWe1wuGdXAZa
	jRA92seKoXOaa0V0Wh0+MqE2IQ==
X-Google-Smtp-Source: ABdhPJz12IW1TdZ7ZgXrYqOE7teFX+jTfdr68Cs1AhpZbgfywuHFYzQ88tfVnTnYnI5aAXgCSa8w9w==
X-Received: by 2002:a50:998c:: with SMTP id m12mr21845290edb.19.1637745520312;
        Wed, 24 Nov 2021 01:18:40 -0800 (PST)
Received: from [192.168.178.33] ([213.211.139.36])
        by smtp.gmail.com with ESMTPSA id kw10sm6328024ejc.71.2021.11.24.01.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 01:18:39 -0800 (PST)
Message-ID: <70d81be5-f9f4-ce03-56c0-60bacb40d5da@tessares.net>
Date: Wed, 24 Nov 2021 10:18:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH mptcp-next 3/3] mptcp: support TCP_CORK and TCP_NODELAY
Content-Language: en-GB
To: Maxim Galaganov <max@internet.ru>
References: <20211123070708.2897469-1-max@internet.ru>
 <20211123070708.2897469-4-max@internet.ru>
 <65424687fe3f108285b6b42669d28e61254349f1.camel@redhat.com>
 <50e883b0-9776-c440-8b8d-1f9024c50a31@tessares.net>
 <e8e6a28c-6062-44d7-1718-42715596f9d3@internet.ru>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e8e6a28c-6062-44d7-1718-42715596f9d3@internet.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Max,

On 24/11/2021 02:44, Maxim Galaganov wrote:
> On 23.11.2021 19:09, Matthieu Baerts wrote:
>> Do you mind if we wait a bit to have these tests before applying your
>> patches?
>>
> 
> I don't mind at all and I think it's preferable to add more test
> coverage before applying this series. Though it may take some time to
> get ahold of the tool.

Great!
Do not hesitate to ask for help on this ML or on IRC ;-)

Also, if you need a virtual environment to quickly test, you can have a
look at:

https://github.com/multipath-tcp/mptcp-upstream-virtme-docker#packetdrill

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
