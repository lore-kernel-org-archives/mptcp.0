Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C76121
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 15:22:39 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id l18so11230149wrb.9
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681312958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ssyy5ye3KgUlVexJG4pO7NIkqaEMEWr4ggHaOrUyEtY=;
        b=hdH8DHrc2I8icKu3rHxgEnj3AbBEqdpX6AnOBc1+dqGqoiywpAgOIT38bZVZsMldYU
         eea18iC3+Fo6WFLhbCEjiSTHY/GW5zoTLMPEEZpG0pxOL9OWyw97WFS2Mz+pLwpN8V65
         M8pPI/5K8nv7EnI3KLTPVU7ypP5CQRnRuEKaiFDtNrg2an8HITejEBgY46E3c/nn5WZS
         xt6mF7U8ncRCD2sw3nZx+QoxS5sQpM/+VuOIB36J97sEXQK6VssbdKRXVlzbJgr8mf5I
         Natsw7OQe2UotepwTA/3OvjlZjl98W/+fWX4O9jAr6I4Llb1rf5f9LtPlrxQKybg+56l
         f/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681312958;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ssyy5ye3KgUlVexJG4pO7NIkqaEMEWr4ggHaOrUyEtY=;
        b=Muc9Z7VEXTuhv/REE4G4X5TpqUkLImb55CaZMztlwrgz1sNDJCX89ufagIxF1X7dVA
         i9jt9Zz1+f7quQfVOQTtDYjQKwat/cHkfRGra2HHAlLOIgyE91iA4Fn1f2pRx9PMwMhK
         iUnW9cRZMW995wF7fyfsERa/SsAeA+DOo/FQ6LH17jguEaPey9ERPHC8X5kqu+pbY268
         tr1CyOA8AJKHbGEbdyweIqkAaV0CfTwH1oEaCvInHAm7nGluyLg2Mmy9YyopFEYPErse
         5P4aK0yT5BKCzVZ2tdQvVkVSSn31k4uluZ54JaglSd1n8TX13qTij0ErKEht9/FYOidr
         3N9w==
X-Gm-Message-State: AAQBX9dgiid/sEXhqxID0DS0fTF8RUNucQ6DoaDalOg7uS/6/5+ATAgG
	0IyM/4kK0vR3s/JVG+TGqnmwdQ==
X-Google-Smtp-Source: AKy350bM7n5TLTMn54FLWkt3p4ihKamEuJ8GvIbFBjsLMzX56SfAGnriSh3KNir9JtYsMq/Oy0IY/Q==
X-Received: by 2002:adf:e441:0:b0:2f1:d17f:cf95 with SMTP id t1-20020adfe441000000b002f1d17fcf95mr7800994wrm.12.1681312958078;
        Wed, 12 Apr 2023 08:22:38 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4382:4a00:b3c9:ac57? ([2a02:578:8593:1200:4382:4a00:b3c9:ac57])
        by smtp.gmail.com with ESMTPSA id d7-20020adfef87000000b002daeb108304sm17474744wro.33.2023.04.12.08.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 08:22:37 -0700 (PDT)
Message-ID: <405a8fa2-4a71-71c8-7715-10d3d2301dac@tessares.net>
Date: Wed, 12 Apr 2023 17:22:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com,
 edumazet@google.com, mathew.j.martineau@linux.intel.com,
 mptcp@lists.linux.dev
References: <20230406092558.459491-1-pablo@netfilter.org>
 <ca12e402-96f1-b1d2-70ad-30e532f9026c@tessares.net>
 <20230412072104.61910016@kernel.org>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230412072104.61910016@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 12/04/2023 16:21, Jakub Kicinski wrote:
> On Thu, 6 Apr 2023 12:45:25 +0200 Matthieu Baerts wrote:
>> The modification in the kernel looks good to me. But I don't know how to
>> make sure this will not have any impact on MPTCP on the userspace side,
>> e.g. somewhere before calling the socket syscall, a check could be done
>> to restrict the protocol number to IPPROTO_MAX and then breaking MPTCP
>> support.
> 
> Then again any code which stores the ipproto in an unsigned char will 
> be broken. A perfect solution is unlikely to exist.

I wonder if the root cause is not the fact we mix the usage of the
protocol parameter from the socket syscall (int/s32) and the protocol
field from the IP header (u8).

To me, the enum is linked to the socket syscall, not the IP header. In
this case, it would make sense to have a dedicated "MAX" macro for the
IP header, no?

>> Is it not safer to expose something new to userspace, something
>> dedicated to what can be visible on the wire?
>>
>> Or recommend userspace programs to limit to lower than IPPROTO_RAW
>> because this number is marked as "reserved" by the IANA anyway [1]?
>>
>> Or define something new linked to UINT8_MAX because the layer 4 protocol
>> field in IP headers is limited to 8 bits?
>> This limit is not supposed to be directly linked to the one of the enum
>> you modified. I think we could even say it works "by accident" because
>> "IPPROTO_RAW" is 255. But OK "IPPROTO_RAW" is there from the "beginning"
>> [2] :)
> 
> I'm not an expert but Pablo's patch seems reasonable to me TBH.
> Maybe I'm missing some extra MPTCP specific context?

I was imagining userspace programs doing something like:

    if (protocol < 0 || protocol >= IPPROTO_MAX)
        die();

    syscall(...);

With Pablo's modification and such userspace code, this will break MPTCP
support.

I'm maybe/probably worry for nothing, I don't know any specific lib
doing that and to be honest, I don't know what is usually done in libc
and libs implemented on top of that. On the other hand, it is hard to
guess how it is used everywhere.

So yes, maybe it is fine?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
