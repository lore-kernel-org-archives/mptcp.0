Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDC323B
	for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 09:36:45 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id cq23so52156236edb.1
        for <mptcp@lists.linux.dev>; Fri, 24 Feb 2023 01:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4g6Pog0uKfNtReecQwAr8HANdq8gx5xyaSwfGoRsToI=;
        b=c4xu8Uv5Sac5Z5UMiU2FUSOhOI1Du1ge5QYhwbjWGcOVWXZeZnOBKd9q6cZlFItCXS
         MEDgLYMwJS8Sn1Tr0ynZdPWhGIhbGNaGRrkTMLtL5eBI3IViWZgHagQagBkEz7owqtRl
         Wpc2ZR02Z8miQ58kPNYxbCS7QgnvpBKcMVctTgVuIwxSEc+Y2rci0h5OEYfJjzEACpOM
         q8rlyc8st9K318URxxvi5f+T2pifXAllAzcEsTf2/AP+N9TYRR3smnKg1SvMVqBBM/+s
         KpjwpfpL0oO9Z3WpDT2h8uM5tIccGEfvcEVgFckiJZ/pfxgkR3tf3v4Acn8RgdA7TVVF
         Omlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4g6Pog0uKfNtReecQwAr8HANdq8gx5xyaSwfGoRsToI=;
        b=eB90d3wAH30Ek9r1rvGqJQqv/IKJ/C31RCyvTTWgpz7+6LZUvLGY98bnNkwPELRov6
         R9f2jjtmMGDC7F4YUdskeq+57XI5LCcBreiZ7d1pDPXOJFNMeAqN3+bsW3ExzUDiB4dP
         pSPpieoDMO/ZcPvhuIoTmJucXWJ63ToxSiFCD+ZC6oshVSvkWz1Yhi8Hj/M5VbZHE1f/
         QncswJRHS/Xu9a4I/aRbwf2Ie3/JMVVxusajchosqQSlaj+FByRE/dWHBZMdvFPJPBMy
         EcGnRxky10d/1oOZCUBeRGswScmmWZvmf4ugju0Po5dev+c2YjTyDmBOVrKpOXLPmePi
         b0fg==
X-Gm-Message-State: AO0yUKUFr84jTLBXfHQf4JPt0EnsDDH7ZTCuK1hTa6Cdx+cWcA/A+bkI
	U1EMmGRRQ1Igs5HGFZT/uDg8XBL4aPFVKrxqqs0=
X-Google-Smtp-Source: AK7set+r5ROOPr2nfGE3s77JdgcPnegwtuFHNEjbGpaGSCCDQdIbIhLCxGfI/9qjGz17AoHIup0lmg==
X-Received: by 2002:a17:906:b06:b0:8b2:abcd:624 with SMTP id u6-20020a1709060b0600b008b2abcd0624mr23158075ejg.0.1677231403658;
        Fri, 24 Feb 2023 01:36:43 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id kf26-20020a17090776da00b008e51a1fd7bfsm3418398ejc.172.2023.02.24.01.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 01:36:43 -0800 (PST)
Message-ID: <edd1c0a6-b6fe-6518-9ffa-d220ee36e71f@tessares.net>
Date: Fri, 24 Feb 2023 10:36:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH mptcp-next] mptcp: add ro_after_init for
 tcp{,v6}_prot_override
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <f2d3a14b9382645f8770ad6496fcba6db699ad19.1677123443.git.geliang.tang@suse.com>
 <4ff31862-96a4-53d2-37ce-9fd69c38c7ae@tessares.net>
 <20230224012920.GA2968@bogon>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230224012920.GA2968@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/02/2023 02:29, Geliang Tang wrote:
> On Thu, Feb 23, 2023 at 02:57:35PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 23/02/2023 04:37, Geliang Tang wrote:
>>> Add __ro_after_init labels for the variables tcp_prot_override and
>>> tcpv6_prot_override, just like other variables adjacent to them, to
>>> indicate that they are initialised from the init hoos and no writes
>>> occur afterwards.
>>
>> Thank you for the patch!
>>
>> Now in our tree (fix for -net):
>>
>> New patches for t/upstream-net and t/upstream:
>> - 14b7f49f8c61: mptcp: add ro_after_init for tcp{,v6}_prot_override
>> - Results: 32f1046d667c..2d0e2918d1a9 (export-net)
>> - Results: 7264bacd3544..e438a165544f (export)
>>
>> Tests are now in progress:
>>
>> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230223T135546
>> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230223T135546
> 
> Matt, you forgot to help me change 'hoos' to 'hooks' in the commit log.
> :)

Good catch, I got distracted by the Fixes tags and I forgot this, my bad!

Fixed now in export/20230224T093441 and export-net/20230224T093441:

- 63df269b74e8: tg:msg: fix typo s/hoos/hooks/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
