Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F6F6121
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 15:32:17 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id w24so1727427wra.10
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681313536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzAooj34HSL4EN1ZLcIOkjvxErIRzviH+GAmi50lm6U=;
        b=OXteH1iSptma+Ht9KI9OhJdkh5+LQa2blAHH2g8pX580N8qCFknlDL8ImcmfVAfGoP
         XYVA3nGneCxHPkm7+G5SqG6nhOJpWUiGj5t1V/ipl3QmuK/Uw1nyLDF8Uq9ETZs4C9nW
         lUigTsaskIEnm5FRMZh+rR5y0XEzXpYzEdMob4IHx0nfVYrP6XKAhDRk+XlEaw6Q1UVp
         wmhDr4DD1T2MjX27MG+Mt3aqSUF6HWTI27ykUsut3haEXaGT8XDmit12AyF689OyrKe1
         ArEVN8bfObmDccBwjRSbROHglyStXf1S784/0jkgPZ2jLZZ7pGvwRgYkWXrAG0IAohb6
         psGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681313536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzAooj34HSL4EN1ZLcIOkjvxErIRzviH+GAmi50lm6U=;
        b=Kv2U9toWFpA557L5vn0L0zkJb6bxIx0/8HnS5tBlAqoLOPjeQLvJAr86IsIyIE6VTl
         hgAuc9cTWTe7bkSnXbFN39AVSwuSGbLJah2bHrVi8Wq+T8SPiEH/hMmwXORaxpaUFzDR
         54pVeFrvFw734nKqK2dNIf20hz8GQ/5fg+VyHC2JQhMYJJM9R9RyVJE6Bgq+tezyMCmv
         +j67+DrIpNCQqKJDyqqfyqb8eEoZFEl1ZttAcqQD+F7qCtCd1f3RjdIiCGXqWUtBWQL6
         vJKXjbWqv/8mkrYvpvA6SpuPOje+lI6MHB5239ZoMa3nZu5JCsRR05zoB4A4NheOxM/E
         lkRQ==
X-Gm-Message-State: AAQBX9f/oJuSL7jlxw4xTJ/sfPmpvZJSUuK1crn/msixBpOaDU0RCJUG
	WCFuH5RMFcnDHIvc7ii177e1dg==
X-Google-Smtp-Source: AKy350bLvY/UZAUM/BsRFRKnXuk2R+7ph5v1UrI2Q/t8ctGaqWbuNhkye5YjHFpFMRKXD7njxz/BOg==
X-Received: by 2002:a5d:4212:0:b0:2f5:5fa1:d816 with SMTP id n18-20020a5d4212000000b002f55fa1d816mr97730wrq.50.1681313535839;
        Wed, 12 Apr 2023 08:32:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4382:4a00:b3c9:ac57? ([2a02:578:8593:1200:4382:4a00:b3c9:ac57])
        by smtp.gmail.com with ESMTPSA id r12-20020adfdc8c000000b002d1e49cff35sm17570778wrj.40.2023.04.12.08.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 08:32:15 -0700 (PDT)
Message-ID: <472d3cef-91e0-fcc5-bec8-ab115ff197f4@tessares.net>
Date: Wed, 12 Apr 2023 17:32:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: INFO: task hung in corrupted (2)
Content-Language: en-GB
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+6921abfb75d6fc79c0eb@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, syzbot <syzkaller@googlegroups.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <0000000000004afcae05a7041e98@google.com>
 <5272b58b-59b8-9ae7-38c7-2578a304e3de@tessares.net>
 <CANp29Y5x13DD8n+aTypSGa5B7+VgOYRvCiSugHz7eFBZrKMZ1w@mail.gmail.com>
 <7c1b7cc3-82fc-4e72-7021-8d209bb3bd83@tessares.net>
 <CANp29Y4F=qM9L0F+2Yb6DH=JSiaUSdu-BSN-pSmMp4W0fpGCRg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CANp29Y4F=qM9L0F+2Yb6DH=JSiaUSdu-BSN-pSmMp4W0fpGCRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Aleksandr,

On 12/04/2023 16:36, Aleksandr Nogikh wrote:
> On Wed, Apr 12, 2023 at 4:22 PM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>>
>> Hi Aleksandr,
>>
>> Thank you for your reply!
>>
>> On 12/04/2023 12:55, Aleksandr Nogikh wrote:
>>> Hello Matthieu,
>>>
>>> Thanks for contacting us!
>>>
>>> This bug is somewhat special. Syzbot normally classifies crashes
>>> according to their titles, but there are also cases when we cannot
>>> extract a good crash title. As a result, crashes caused by unrelated
>>> problems may end up in the same syzbot bug. This is the case with
>>> "INFO: task hung in corrupted", "no output from test machine", "lost
>>> connection to test machine" and a few others. Probably we should put
>>> some explicit warning label on them and treat them differently.. At
>>> the moment it just drives bisections and subsystem recognition
>>> somewhat crazy.
>>
>> Thank you for the explanation!
>>
>> (yes, a label would be nice and it would be even better if they are
>> treated differently :) )
> 
> I've filed https://github.com/google/syzkaller/issues/3806
> Hopefully we'll get to it some day :)

Thank you!

>>> The MPTCP was mentioned in the crash from "2020/05/28 11:24":
>>>
>>> report: https://syzkaller.appspot.com/text?tag=CrashReport&x=138006d2100000
>>> syz repro: https://syzkaller.appspot.com/text?tag=ReproSyz&x=14947d26100000
>>> C repro: https://syzkaller.appspot.com/text?tag=ReproC&x=172726d2100000
>>>
>>> Though, looking at the report, it seems that mtcp was mentioned there
>>> just coincidentally.
>>
>> Yes, I confirm it looks like a coincidence.
>>
>> The two repro seem to suggest we should assign this to the USB
>> subsystem. But does it make sense to do that if there are different and
>> unrelated problems linked to the same report? Also because there were no
>> more activities for more than 2 years, it can maybe be marked as closed?
> 
> Good idea, let's just invalidate the bug:
> #syz invalid

Great, no more issues for the MPTCP subsystem \o/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
