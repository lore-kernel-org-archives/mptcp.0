Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4823A6
	for <mptcp@lists.linux.dev>; Tue, 10 Jan 2023 17:37:30 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id cf18so24281758ejb.5
        for <mptcp@lists.linux.dev>; Tue, 10 Jan 2023 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EntjPMLjyrYG6b19IR0a7obEkQHplZUGRe2LWQtkNMQ=;
        b=uM56cr/vmYb5xbx4FewZaFIZ2s5dH7L1o28Y8ClM4Q4jhmSqLcJVHNlhIzJmlDlGmH
         MhfCAIY37icPFJOqtVcqavpEzwkqxlDvFaIyVUomuMM3RLD6FpLC4WWxlV0z4cMkxlLk
         aKMVHF9vWmzBW65484jZl99BF2IGz7STEkMwSfGuyEpkX+Fs2Kp02fxVMGY3HOrukWDr
         msKX76skmBm3KjDYY1pSZ7IJNoyhn94WcR+MWNOr+XHAhespoJQXHk4Me6vM1CQ+FnCu
         a1152JPyeRWzLJy67xjOdwxoBJLj66bUEj8TkHpajVC12fED/fF+0mbceRK2r70m9lTO
         obmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EntjPMLjyrYG6b19IR0a7obEkQHplZUGRe2LWQtkNMQ=;
        b=iBHz7du9bhLj84LR+O2RJeGdTQsY9pUWz9M/JP4EOyO52CsDpNwHGzGPvt08326x6s
         gnaf+2Rs2uxoPmgaoCZcBO1Kh094+wQV+MyXEbf7gHa+qlr7LyopGnZtmzcWLZJwlL9H
         CyCa7uBd3nmhpSAP1LelY6RG6TvYX+ZpFCybDSdjJaBfDeEc0l6ysnxw8F6Iq0FxH1FR
         XD/BgJX2eyhquXpnqQV1GOX8iBUbkdQOt1UlvE6bG+HWnylWeuE9xACdGy29Asigmxua
         ulG/pSRJ7Z4GSLQppvq7S3Z3rzgWhyYJ2/LJ+AIXyKPkosWcdkSEL+xkFaxHpvgC5M1J
         yC9g==
X-Gm-Message-State: AFqh2kqnCMnlHX9nYBC5XHgyWJ67k9qVDkdnTy+t5qirwAHLjzpLZUu1
	FwF1nctbPdwFf27ZXlofKfJYbw==
X-Google-Smtp-Source: AMrXdXsvbDrKhXHIoTbYI8xAhprO935hKcGq17fwM5ktsWNMOgXsRJhELF/d5op86aQujw/oDJTsHA==
X-Received: by 2002:a17:906:eda2:b0:84d:4712:9c42 with SMTP id sa2-20020a170906eda200b0084d47129c42mr7959476ejb.56.1673372248562;
        Tue, 10 Jan 2023 09:37:28 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:8604:c7e4:1c71:ce99? ([2a02:578:8593:1200:8604:c7e4:1c71:ce99])
        by smtp.gmail.com with ESMTPSA id ti5-20020a170907c20500b007c0cd272a06sm5150797ejc.225.2023.01.10.09.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 09:37:28 -0800 (PST)
Message-ID: <fa1c54e7-719d-aae4-b858-d3d5a131cff3@tessares.net>
Date: Tue, 10 Jan 2023 18:37:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Weekly meetings] MoM - 20th of December 2022
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <1f07a3b0-644f-f69a-fdd8-f4fc7a7baeb5@tessares.net>
 <CA+WQbwtFEJ06p07MypSSmJZigAWA6KLgge+72EX_eP7_O9tr4A@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwtFEJ06p07MypSSmJZigAWA6KLgge+72EX_eP7_O9tr4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/01/2023 09:12, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2023年1月3日周二 01:18写道：

(...)

>> Redundant schedulers:
>>     - Olivier Bonaventure and Gregory Detal helped me to do this list
>>
>>     - Use cases:
>>
>>         - Low latency:
>>             - bandwidth is not the priority, just quickly recover from
>> losses
>>             - Note: in this use-case, it is important to be able to
>> quickly restart a connection if we need to retransmit too much (from a
>> TCP point of view)
>>             - (but MPTCP is maybe not the best fit for that...)
>>
>>         - High losses networks:
>>             - does it really help because something transmitted over one
>> path will have to be retransmitted anyway (from a TCP point of view)?
>>             - MPTCP doesn't seem to be a good fit for that because of TCP
>>
>>     - cases where a "normal" scheduler might want to "quickly" reinject
>> the same segment over multiple subflows:
>>         - to probe one subflow:
>>             - but OK to just take the last byte(s) that have been sent
>>
>>         - a TLP algo could be implemented at MPTCP level:
>>             - alternative to TLP (tail-loss-probe):
>> https://lwn.net/Articles/542642/
>>             - Quickly reinject after a timeout? (after any RTO?
>>             - preventively send on other links the last packet(s) that
>> ends a burst/connection?
>>
>>         - opportunistic retransmission (re-injection):
>>             - when we realize we are blocked by the window, we will need
>> to re-inject the last segments over other subflows
>>             - important to reach high speed
>>             -
>> https://www.usenix.org/system/files/conference/nsdi12/nsdi12-final125.pdf
>> → section 4.2
>>             - in mptcp.org, it is tied to the scheduler which takes the
>> decision to do that
>>             - but the decision could be taken by the core → react to an
>> event
>>             - from an API point of view, this would be similar to what
>> we need for the redundant scheduler:
>>                 - small difference: just re-inject to one subflow
>>                 - maybe using the delegate action infra would be
>> possible because ↑
>>             - maybe having a "redundant flag" not to "move on" would be
>> enough?
>>
>>     - techniques:
>>         - enough to just remember the last MPTCP data seq sent per subflow?
>>         - this info should be handled by the BPF scheduler
>>
>>     - to simplify the implementation:
>>         - always send the same amount of data
>>         - if there is not enough space in the sending window: queue or drop
>>         - or only duplicate if we have chunks < mss with TCP_NODELAY
>>
>>     - listing what is needed would really be useful to (re)design the
>> scheduler API:
>>         - what is needed to solve some corner cases for the scheduler
>>         - TODO: Matth
> 
> Hi Matt & Mat,
> 
> I suspended the work of the BPF redundant scheduler in my hand,
> waiting for this redesigned new API. Please feel free to let me know
> if you need any help from me during the period. If a separate
> discussion meeting is needed, please let me know. I'm willing to
> participate if I have time.

Thank you for your reply!

This week, I will try to initiate a list of packet scheduler API
requirements when looking at "real" use-cases. The idea would be to
discuss around these requirements and see if we would prefer to extend
the current API or re-design it.

The plan would be to start discussing about that on the ML before the
next weekly meeting and see next week if it is needed to have a
dedicated meeting at a different time to continue the discussion and
agree on the new API.

Would that work for you?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
