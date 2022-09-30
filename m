Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C523633D6
	for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 14:13:26 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso2306583wmq.2
        for <mptcp@lists.linux.dev>; Fri, 30 Sep 2022 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JiWkBz/UN+3n8DVvC9kg2k8Mg3yN9elUc+CSUEVa7X4=;
        b=FlpSyHUruMsFswpXlNR2/96enjF2vpZn0yiqygYIwuJcDL/h1DfU90HgdnI6bkpkW4
         BIB4wJ1mY9dKpIhnyCBNE5zElQuWLISNyBZGm2VC7U/EVZ6nLimHsW3PwuNbLG4+9sZf
         39G0mC75LvdrpL1hvd0go5kw0fPUYHtK54Vh6IGwA6EpKqoBovTB5UWgBIiR9W2QUoh5
         KdHaoOrWkTBReW+SRknZSyfd2uKPDNYjsHMKyuchxlSPRxFxR3HsNJq8i27S5NPIo1jg
         vkeWpRsXPaGOfS08n8fvzRoeLAGwXAqV1Vt/ZVITvzHkffvzfzrJeZW4qXXNdPRQOMXI
         nyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JiWkBz/UN+3n8DVvC9kg2k8Mg3yN9elUc+CSUEVa7X4=;
        b=Ry4+grdiw0A9lHpqtAwgaiafYY7QKBkWO8wlq64B9WpY/Bud5Z4PTZM5Ivem5twFlI
         RvUlmlQ/f9Dhczo2ggZjXumUuh673ByeZ7n5C0Kko3QzbzOMS6vUEHM9jRISPipx/5XA
         NjBYHzm+DlhLlmVF8u54ld9pzBDio2XF3+cEhzMiJ8bzTavjZXe+NIikfsEOpQcCeJFq
         hus8CTopzhJPV4Bmeu+dAJbIyOaFxPPLTPE5H2PPmZ7tKqycusFZYDxaUtSgLO5opaJK
         376t9rqC7zJd4BlEgmuOcITAmrUH72WWvDIqJkT9TJBMSBFXLgNMnrG2Lz14Bmj/y9Di
         90Pw==
X-Gm-Message-State: ACrzQf2dxVuoJdQeyL5YvIZO4dbqidS0hAncpDAj6EL/BWOyfH2EGPl9
	dT3Luk7eH/km7QhQ9WxFvTnoAlMnZCyM1A==
X-Google-Smtp-Source: AMsMyM6KIEqkGSyhU8cLyFbRPPvWkzgVuTSsEagTDe75ouAppkOlu8eCCeD4CESTr5bFPTokQGfg4Q==
X-Received: by 2002:a05:600c:4f45:b0:3b4:9c9a:7077 with SMTP id m5-20020a05600c4f4500b003b49c9a7077mr6203071wmq.109.1664547204592;
        Fri, 30 Sep 2022 07:13:24 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id j11-20020a056000124b00b0022a3517d3besm2151169wrx.5.2022.09.30.07.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:13:24 -0700 (PDT)
Message-ID: <3aa928ca-92af-c903-b40d-f087815c5d28@tessares.net>
Date: Fri, 30 Sep 2022 16:13:23 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: MPTCP upstreaming, week of 26-Sept-2022
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <57e168ae-9de0-c986-cab1-a130e72e4e95@linux.intel.com>
 <2d24f789-9fc1-0229-4b37-ff570c4be080@tessares.net>
 <0a6a01130bc558691a0fcd8dab0f2ac77fda199f.camel@redhat.com>
 <397e0988-7a03-3073-ea12-4845a44b85b7@linux.intel.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <397e0988-7a03-3073-ea12-4845a44b85b7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat, Paolo,

On 30/09/2022 00:54, Mat Martineau wrote:
> On Tue, 27 Sep 2022, Paolo Abeni wrote:
> 
>> On Tue, 2022-09-27 at 10:07 +0200, Matthieu Baerts wrote:
>>> Hi Mat, Paolo,
>>>
>>> On 27/09/2022 02:10, Mat Martineau wrote:
>>>>
>>>>     - Features for net-next:
>>>>
>>>>         - [ef4a93571133] mptcp: propagate fastclose error (Paolo Abeni)
>>>>         - [885cab8b5203] mptcp: use fastclose on more edge scenarios
>>>> (Paolo Abeni)
>>>>         - [13c82c8b0d9f] selftests: mptcp: update and extend fastclose
>>>> test-cases (Paolo Abeni):
>>>>             - can wait a bit, Paolo would like to have a look at the
>>>> modification on packetdrill side
>>>>
>>>>
>>>> The net-next patches are slightly more complicated:
>>>>
>>>>  * They were updated with a squash-to patch today
>>>>  * Need to wait until fastopen patches are merged
>>>
>>> We should at least wait for the fastopen patches to be applied I
>>> suppose.
>>>
>>>>  * There is a minor conflict with the -net patches (just diff context)
>>>>    in "mptcp: use fastclose on more edge scenarios".
>>>>
>>>>
>>>> Regarding the conflict, I could wait until Friday for a likely
>>>> net/net-next sync.
>>>>
>>>> Another option is to modify the patch slightly by moving
>>>> mptcp_check_readable() before __mptcp_check_send_data_fin(), it doesn't
>>>> make the diff any larger and avoids the -net conflict. What do you
>>>> think?
>>>
>>> We can also add a note in the commit and explain how to fix this
>>> conflict. I think the function is at the right place but it can also be
>>> moved if it eases stuff.
>>
>>
>> I think there is no rush for that patches. If the net patches will land
>> upstream soon, they will be likely merged by EoW. If there will be
>> another RC, we can rebase the net-next and send out still for 6.1,
>> othewise the fastclose patches can wait IMHO a few more weeks.
>>
> 
> Thanks Paolo.
> 
> With the net and net-next patches for MPTCP just merged today, and the
> backlog in netdev patchwork, I'll wait on the fastclose changes:
> 
> ee1e43f10dc5 mptcp: update misleading comments.
> d1c02fee7732 selftests: mptcp: update and extend fastclose test-cases
> 61fc1bc2edeb mptcp: use fastclose on more edge scenarios
> 20af637811c9 mptcp: propagate fastclose error

Just in case you still see an opportunity to have this in the next 6.1,
that would be great to have it.
I say that because it is looking like a fix -- we were hesitating
between net and net-next -- and it seems needed for some use-cases to
mimic TCP + also it is only affecting MPTCP :)

But if it is too late, I understand :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
