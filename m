Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017132F21
	for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 12:26:06 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso3794367wms.4
        for <mptcp@lists.linux.dev>; Thu, 10 Feb 2022 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5I3LTKt5KSkZK72HI2IULBet5tdMOqWU3rTwYPUPAoI=;
        b=I6aCezqfNsNNWy1oBui3KRHR+w0/t9i4KWU8QFvlAG353uj9B+KeMoM3P0ZCo8NmwW
         LOV+xDL0tPbKhYq03cc/T+FrCIyiJpqEKIanpDlGnD/mqlOxKiltSdLAUxyURMya4xpM
         78QPcwIbvSxnAJukltunUviiV1pNQEztun2zdu/71n/aFv/2INMP+wTzTfZsai9vITMd
         eUBC/cEMHH/ZphhqLXNvd4+jERDN2BnGVOLmszzaHiv8BR31yz+KGe09W00tyx6VG2Ng
         qL++Y2Yv7aL/cHMlDNiO+G2ylOYiqgDL5OM2CirhjUpwwaBydZHva9i/4jqPFBcMTBjP
         rnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5I3LTKt5KSkZK72HI2IULBet5tdMOqWU3rTwYPUPAoI=;
        b=asBhpbaKXqHUWbfHMqTQPo+3k4eID9sSnomWirzdwN3XBTMXwFi2OPyk+V6Tvfugmo
         mJv41UVFmtnRJR4lT/Og5tWxrTH7suOcS7L30ynhxobf2Omsa8g33b5imBwASd4FPr1i
         sf/VwoS5+wdYW2Cv8lMV6u0KpMuD7yYJpfiF63qwdbq/hK5iq7Q8X2ecdhrdWXP5p2sG
         d2URJ87fvW/SYpUQ0Kk2MP9/B3oi//sO0egcwxmTmFhmpExf1+ZpCXQxcEs+HQB3wF74
         b9nASM02YK1CbSHG+Dj59bQJEyfgitz1CVUFbVFBK6JLCGXTEJCYNpODbep7rULqv0G5
         ua0w==
X-Gm-Message-State: AOAM533vH+OumXzMAVb1C586xN1Dso6Litoqs1z3adDoeyZlBY9Ze9oo
	4uHO9kCSHtPLczWR1HDZHiNyYg==
X-Google-Smtp-Source: ABdhPJz/LH0umyJZApdPML03cPsY0L24HzCH+7gVA00e3pVAdocu8mlsG0/+R0SHwiDDU8CVV6p/5Q==
X-Received: by 2002:a05:600c:2211:: with SMTP id z17mr1976019wml.59.1644495965276;
        Thu, 10 Feb 2022 04:26:05 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id c18sm9691548wro.81.2022.02.10.04.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 04:26:04 -0800 (PST)
Message-ID: <4be787ed-eba9-c3ef-9f56-93612e70d066@tessares.net>
Date: Thu, 10 Feb 2022 13:26:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next] selftests: mptcp: improve 'fair usage on
 close' stability
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <eb310fd3bdfe3315ff17ebb865fd2f1e2957fd02.1643999595.git.pabeni@redhat.com>
 <d938eba9-0bbd-8cea-9148-a36afadbb31a@tessares.net>
 <1fa1f387-d647-de45-83ee-34182e67de5d@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <1fa1f387-d647-de45-83ee-34182e67de5d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 10/02/2022 01:55, Mat Martineau wrote:
> On Sat, 5 Feb 2022, Matthieu Baerts wrote:
> 
>> Hi Paolo, Mat,
>>
>> On 04/02/2022 19:33, Paolo Abeni wrote:
>>> The mentioned tests has to wait for a subflow creation failure. The
>>> current code looks for TCP sockets in TW state and sometimes misses
>>> the relevant event. Switch to a more stable check, looking for the
>>> associated mib counter.
>>
>> Thank you for the patch and the review!
>>
>> It has been running all night on my side, more than 2000 attempts,
>> without issues!
>>
>> Now in our tree (fixes for -net) with Fixes, my R&Tb and Mat's
> 
> Hi Matthieu -
> 
> I noticed both this patch and "selftests: mptcp: fix diag instability"
> were listed as mptcp-next, but queued in the export branch in the "fixes
> net" section. Is this accidental or did I miss some discussion?

It was intentional:

https://lore.kernel.org/mptcp/510a18db-2949-e95d-050f-942e15e9ea96@tessares.net/

But it is true that it was not really clear I did the same for this one
as well, I'm sorry for that.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
