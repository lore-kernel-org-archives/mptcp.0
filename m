Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493911F185
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 20:18:21 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe0c566788so2375051e87.0
        for <mptcp@lists.linux.dev>; Thu, 03 Aug 2023 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691093900; x=1691698700;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSLerfEC8x2ZkqZ+PaoDn6gSM0nuTqxqr5ipewapCfs=;
        b=MwbVI+dgU5ctise91WzaGFh5YVQLP1EGUzZthMBoMUMmRYqITRp8yuFbGPr9F9ay8f
         qPs+iGYYf2wP0UvZ+5Y9aAM8LaXgMOiIaQZRaxsw1+8rPI/LQbBb2KSAvS5pf4yIAHL9
         Nnru1c8wKwqUvELV9YBY0BlnbCyqCC75MZZdRMEJ6y+5GA/+ov5YIK5rh6AXbPHbd1Xd
         SsZH2RtWcSuQEDEO7mATUmbwm3GrOQjnrWKo9t/clz1qM45hHyeZxi18PjGh6u33ms1H
         p9HgYAy0wroAbCjQe60IBV6SWu1KOb7FycDj0lEdFUEuqL4oXjRR8Izi7CjLXJz5wf69
         Ef6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691093900; x=1691698700;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TSLerfEC8x2ZkqZ+PaoDn6gSM0nuTqxqr5ipewapCfs=;
        b=GYJMJdVxS6aCHFo4W8r6dm00I3v68B8QsBb2wj0dH+X4W8HA1Hh0YJVPqqosRda7+8
         qtQlhktN5rk69jcByqFo53RIV3/Ypy3edRR8RDjWOT1MMHRRPL45y8IVYNPkY76ZYsOz
         d6A0KpjczqNqR11DII5keWmMeEqAz8UHpqY1L3pIGqKTSrDLGHfD5d255HwxbVObykSQ
         URaCSCKGzbcy70kZchhQTp7dhbBzqNzF3wE3GYxH8xH+uvAUdlESZwPh9Nu7d/QvYs/f
         oQa8874g5Up3ytRHme0E89mY2JxRJIbO5KeqpX0HZfVs0P9OzSu33PdzGX6EYxsZ7HAN
         C56Q==
X-Gm-Message-State: ABy/qLZHNXVUY8d3OjQqxx5TFf3Pg99z8gqWwaTnoUsWYMPszDrQznJg
	iMmz1yENPjiEOXVK/5a9cxkqgg==
X-Google-Smtp-Source: APBJJlH/3JOBWYhu7XpAFjh9q56ctcvvHbv5DykqLhxq1qtDXz0u6Iy8AwP9+mE69rygOVKQYeAC/A==
X-Received: by 2002:a05:6512:210d:b0:4f9:607a:6508 with SMTP id q13-20020a056512210d00b004f9607a6508mr6559144lfr.50.1691093899644;
        Thu, 03 Aug 2023 13:18:19 -0700 (PDT)
Received: from [127.0.0.1] ([146.70.190.136])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7d609000000b0051bfc85afaasm231854edr.86.2023.08.03.13.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 13:18:19 -0700 (PDT)
Date: Thu, 3 Aug 2023 22:18:18 +0200 (GMT+02:00)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiang Yang <xiangyang3@huawei.com>, martineau@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Message-ID: <21fad913-dd47-4d45-865a-3af877990246@tessares.net>
In-Reply-To: <20230803110424.5ca643c9@kernel.org>
References: <20230803072438.1847500-1-xiangyang3@huawei.com> <d3fa9b41-078b-4bb5-9f5c-d8768b787f4d@tessares.net> <20230803110424.5ca643c9@kernel.org>
Subject: Re: [PATCH -next] mptcp: fix the incorrect judgment for
 msk->cb_flags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <21fad913-dd47-4d45-865a-3af877990246@tessares.net>

Hi Jakub,

3 Aug 2023 20:04:26 Jakub Kicinski <kuba@kernel.org>:

> On Thu, 3 Aug 2023 18:32:15 +0200 Matthieu Baerts wrote:
>> This Coccicheck report was useful, the optimisation in place was not
>> working. But there was no impact apart from testing more conditions
>> where there were no reasons to.
>>
>> The fix is then good to me but it should land in -net, not in net-next.
>>
>> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>
>> I don't know if it is needed to have a re-send just to change the subject.
>
> Looks trivial enough to apply without a repost, but are you sure
> you don't want to take it into your tree? Run the selftests and all?

Thank you for asking that! All patches sent to our mailing list are automatically tested but the report is only sent to our mailing list not to annoy too many people. This patch passed all tests we have:

https://lore.kernel.org/mptcp/20230803072438.1847500-1-xiangyang3@huawei.com/T/

I already applied it on our side. For non-trivial fixes or features, we usually prefer to keep them a bit only applied on our side for longer tests and to have syzkaller stressing them. But here, because this patch looks trivial enough, it seems fine to me to have it applied in -net directly.

Cheers,
Matt
--
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
