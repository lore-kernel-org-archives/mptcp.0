Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0BF23B9
	for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 08:50:44 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40472f9db24so41940825e9.2
        for <mptcp@lists.linux.dev>; Mon, 18 Sep 2023 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1695027043; x=1695631843; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d6IIg5tzCiYX7rF+o0qOoMZOGIQmzt38jJ8/k4vR3W0=;
        b=I0nEnX0LuzxOqz2UwYcc2sgY2xok5XKQuTF2a0+5ymeerz1/doUshAB34JQuL4wbAY
         KPM1piVFoIh9qXkiwCOSH4qQz2uDZZNN2NZLTsyliX+gkd1Inj3ymrpKUsNY7XPF28JF
         mrJ9qpcZacHaKNPzEP16dAtXzqaD4BYV+HVCOLeAWCIZlXBW5NaH35DCRnDiuWaIaqDO
         ovWzUjAQwNvuQkecIFgy/4rebNpjmmYiCttYdsTwPd2j9r+0b4VbEEsjvM0G4TgUL67X
         m4VXA1L2gyJIx2/Al55OnFd/Sado9UzZVKFNAnZ6Mnp4ib9C4zvJYVcsT0/HC931MgXy
         vgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695027043; x=1695631843;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6IIg5tzCiYX7rF+o0qOoMZOGIQmzt38jJ8/k4vR3W0=;
        b=l6LQoEOyeokN3oOUlIom/fqsd8h3rafuUymcjBUJNEgzKt+gunjkcp1YEKqx/Tof1L
         vGyGanjy9lPR6elT6sGW7cyTHDWUEx+6HiGmygVqcFvhrC/+HwpC91OLJSJ7vd78TEB6
         TGWQZY/ggLx1cnGWMGNiXpf4f/0lDs6QxS/jybIbHihc5WLzNFleDQz4hFQ8lx+iYLdX
         jT+mJ4EcHELLtGjeQbsQht3b7i/X9x8LQcPgUMfDc7Z7nSzlPWYmajmwD+nCBpjI7YXm
         vk6i+AiQ9K1dpiHbVfvn0nVaBVIiY38kv3I4FQhfJAyDEugtS3oc4Qz50CeARYsULmoS
         ndnQ==
X-Gm-Message-State: AOJu0Yz7NRC6zzJA9AckJPdRz4FTkMAno+vRboVoi3eWeiU5qSeezru8
	xrcrWPdNtY/3SRohq7GGb/dMvA==
X-Google-Smtp-Source: AGHT+IFJsvworC8bXCNugyiU5A6H6hKI/hXIVc5kUPmhu5L6TyIsbQQCuVwvoO56mTDXtJ3UcFctgQ==
X-Received: by 2002:a5d:40d0:0:b0:31f:ec06:20f with SMTP id b16-20020a5d40d0000000b0031fec06020fmr7967299wrq.14.1695027043021;
        Mon, 18 Sep 2023 01:50:43 -0700 (PDT)
Received: from [10.44.1.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d604f000000b0031779a6b451sm11825377wrt.83.2023.09.18.01.50.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 01:50:42 -0700 (PDT)
Message-ID: <90813b1f-c970-4bce-82fd-c3bbeabe832b@tessares.net>
Date: Mon, 18 Sep 2023 10:50:42 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 0/6] mptcp: convert netlink code to use YAML
 spec
To: Davide Caratti <dcaratti@redhat.com>
Cc: mptcp@lists.linux.dev, pabeni@redhat.com
References: <cover.1693921470.git.dcaratti@redhat.com>
 <2a1c0acc-52d2-4ffe-8216-c6fdf3e24a5c@tessares.net>
 <CAKa-r6uQaqsv7a83r1GkAzssiEcLhiuMdMUVJpnSapiL1Xv4Ow@mail.gmail.com>
Content-Language: en-GB, fr-BE
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <CAKa-r6uQaqsv7a83r1GkAzssiEcLhiuMdMUVJpnSapiL1Xv4Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Davide,

On 18/09/2023 10:07, Davide Caratti wrote:
> hello Matthieu
> 
> On Sat, Sep 16, 2023 at 1:14 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Davide,
>>
> [...]
>> I was looking at applying them but I just noticed quite a few errors and
>> warnings reported by CheckPatch. Do you mind looking at them please?
>>
>>> Davide Caratti (6):
>>>   tools: ynl: add uns-admin-perm to genetlink legacy>   net: mptcp: convert netlink from small_ops to ops
>>
>> Spaces are used instead of tabs for the indentation in
>> include/uapi/linux/mptcp.h and net/mptcp/pm_netlink.c. This code is
>> removed later but I think it is still best to avoid having many errors
>> reported by the CI when sending them upstream.
> 
> yes, and it was unintentional. Will fix that today and resend a v4.

Thanks!

>>>   Documentation: netlink: add a YAML spec for mptcp
>>
>> Can you add the path of the new file in the MAINTAINERS file please?
>> Also good to add a small description in the commit message, at least to
>> say that it is supposed to represent the YAML spec as currently
>> available today ("no behaviour change intended").
> 
> makes sense,

Thanks!

>>>   uapi: mptcp: use header file generated from YAML spec
>>
>> Please add a "*" in the MAINTAINERS file to handle the new one in uapi.
>>
>> Also, I guess we cannot fix:
>>
>>   Please use a blank line after function/struct/union/enum declarations
>>
>> in include/uapi/linux/mptcp_pm.h as it is auto-generated. (Maybe we
>> should add a comment about that in the commit message? But maybe it is
>> clear it is auto-generated?)
> 
> this can probably be fixed in a follow-up commit for ynl-gen-c tool
> (that includes a tree-wide fix for the uAPI headers, because the issue
> might also affect all headers generated until today). The commit
> message says how we use the tool to generate sources, and the header
> file has the "do not edit" caveat line - that is sufficient IMO.

I understand, thank you for the explanation. This improvement can be
done later if needed.

Fine with the current commit message, only the MAINTAINERS file needs to
be modified in this commit then.

>>>   net: mptcp: rename netlink handlers to mptcp_pm_nl_<blah>_{doit,dumpit}
>>>   net: mptcp: use policy generated by YAML spec
>>
>> If it is OK to send a v4, please also add Paolo's ACK. I think that what
>> he meant to say but he was apparently only allowed to send acronyms :-D
> 
> OK is an acronym as well AFAIK :)

:-)

> thanks for looking at this!

You are welcome!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
