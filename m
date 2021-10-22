Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D6F2C9F
	for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 11:25:32 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id g10so263894edj.1
        for <mptcp@lists.linux.dev>; Fri, 22 Oct 2021 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=evOW/91lHPzDl/JMN2MfEH/jLbeBJxzFqKTK/uNFH4s=;
        b=BJf+SNqV2tvYGjHnCNNX3PZxBr8P+Jnw9XhgmHVS1OplWmTAQxLXEz/xMWT1oLgjLu
         8R3CDEdoRF7wzJvjsJ/lLS/IKjphLzNiigdBsStO1TlWGL6plZwTJ3gtkeJbRW7Obzau
         HcmSHNDbZ3BBBRQdxPDjxV07zi5V79oXIqrJLoIiM2pKvPE0nPELd03t8zlfDVRphqTI
         UmILEMO+qRs42Puv3ziNaNvplWgr8fgMX6weCwl4LwuRa+yFTxQYziysZbn3e47u0JaT
         YDPI37OeDVFLRmyu9MMduOOXZVaFWnGeW1xZfFLtWu/SFiUbDXhsgFdjA15DXphZ0Ufe
         vr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=evOW/91lHPzDl/JMN2MfEH/jLbeBJxzFqKTK/uNFH4s=;
        b=HDFO/6T3zdADFeNXqEW1Q061aHo8sxn1CZ+7Xl9frmDsD2yp/5jDgFq5Z4zIw7wON6
         T9OUbmXPmAwB8M+hJWwd7Ute/vgF+7f8YmFbnFQ7eNLI3oWBL9XI+6sSGJ5BLQJ1Bh2C
         VazKMU6arHX270qURnKVvqIkzH5WvrNn601Z/xcEk0KhPOq7VGu2sxy10rJlncOddO1w
         uWX104AQIWeYO965bKIO8TCjZYTmrPx66quW8ZiLaDDyN8iWUpc8fyE4wnUHJiAg7fxw
         QHSlAO4ObUL7ZMRT/kLPdbREIAVVfz1J0lajPZaisnkU9VtAPe6tJ7XA8Swq+q6fhqQK
         i7GQ==
X-Gm-Message-State: AOAM531vJo+Jjjgfi8KcF68O5Bfnn+3CeHxhZgU1s+row2l55qpWn2Cs
	TbVcyOIF0NAgatOZrLXfAV7MYfu+6Oo=
X-Google-Smtp-Source: ABdhPJwPacl+qC7fOoP9UkYmvkOgDC9V29xOnWvOvMAftiHqI97LWiqbAc1Yi3TTb025M3LfyojynA==
X-Received: by 2002:a05:6402:1390:: with SMTP id b16mr15898953edv.166.1634901930554;
        Fri, 22 Oct 2021 04:25:30 -0700 (PDT)
Received: from [192.168.178.46] ([213.211.156.121])
        by smtp.gmail.com with ESMTPSA id n23sm4362625edw.75.2021.10.22.04.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 04:25:29 -0700 (PDT)
Message-ID: <304c130a-41ea-8e0a-4d88-d22edb14ef9f@tessares.net>
Date: Fri, 22 Oct 2021 13:25:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next v7 8/8] DO-NOT-MERGE: mptcp: mp_fail test
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>, Davide Caratti <dcaratti@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1634531093.git.geliang.tang@suse.com>
 <2e9a15d32cd39483dd1e18174d6c73b33e0566b5.1634531093.git.geliang.tang@suse.com>
 <7e1c37e5-a636-68f1-aaa-329f951b2c55@linux.intel.com>
 <CA+WQbwt4dk5vQyoPgxv7=ctsaNetcbt855Md+SL6juFZcLUPgA@mail.gmail.com>
 <YW6BzNwiyR9i8KSQ@dcaratti.users.ipa.redhat.com>
 <f61714c1-09cb-e4a0-f78c-5294bcaea890@tessares.net>
 <CAKa-r6vQo+=tQDMRkyG2xczR8wMYPufRD4LU7Xj9+xbP2zVWGw@mail.gmail.com>
 <8d7963f3-1983-0086-dcbe-16e950230f0a@tessares.net>
 <YXEwoTyTQxN3dcQx@dcaratti.users.ipa.redhat.com>
 <a025ed1d-eb63-b5df-9f38-77487f72d5e0@tessares.net>
 <CA+WQbwsM-27sNRKbb-whDWbA-+Gg1H=mtjS83ELn3Y+m4Wx=oQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwsM-27sNRKbb-whDWbA-+Gg1H=mtjS83ELn3Y+m4Wx=oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Davide,

On 22/10/2021 09:37, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年10月21日周四 下午8:51写道：
>> On 21/10/2021 11:19, Davide Caratti wrote:
>>> On Wed, Oct 20, 2021 at 04:49:35PM +0200, Matthieu Baerts wrote:

(...)

>>>> The only thing is that netem will introduce errors at random positions,
>>>> maybe in IP/TCP headers but it is maybe not an issue. If the TC filter
>>>> command is enough, it might help to produce more controlled tests.
>>>
>>> maybe TC flower + action is even more accurate then netem: because it leaves
>>> you the freedom to "corrupt" only packets after the 3WHS (or only the 3WHS,
>>> depending on the match arguments of flower).
>>> You can obtain the same randomization as netem by using TC "act_gact" random
>>> feature ("CONFIG_GACT_PROB=y")
>>>
>>>  # tc filter add dev vetha egress protocol ip prio 1001 flower \
>>>   > ip_proto tcp \
>>>   > tcp_flags 0x10/0xff \ <-- only the ACK BIT is set
>>>   > action pass random determ pipe 10 \    <-- 1 packet every 10 goes to pedit, others go out unmodified
>>>   > pedit munge offset 148 u32 invert pipe csum tcp <-- corrupt the payload and recompute checksum
>>
>> Good point!
>> I don't know if Geliang wants to have all packets transporting data that
>> are being corrupted or a random one out of X packets or only a specific one.
> 
> I want to have only a specific packet to be corrupted, like sending 10
> unmodified packets, then sending 1 corrupted packet, then sending 10
> unmodified packets. How can I do this?

I didn't find any man page about TC GAct, I guess we would need to look
at that code to have a "statistic way" like you want.

A workaround could be to insert the rule after the creation of the
connection, no? In this case, you don't need "pass random determ pipe
10": all packets carrying data would be corrupted.
Or maybe "one every 10 packets" is enough?

Then you can remove the rule if you need to send unmodified packets but
I don't think you need this, do you?

Or maybe Davide has a better idea or knows how TC GAct works? :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
