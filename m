Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619C5698
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 14:22:20 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id v10so22750wmn.5
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681309339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFhXj0tEAhsfyZTpC+pA0y3V6Mu8O9E7KDAbCPpVRdQ=;
        b=Vlrnn0Z4XuJP0ymjtFnDDfcj+MUCpyVK8HJ44UshYdIAtWh/PcNursx/VdvCBwO5Vf
         CegqFjWQq/SoBO3y0Vf97PUbmhLGdrJwr9xOzECxanvEfLZDoMEIhTtI1j8cKIKrWfA2
         02DdfXOjDzLEjsd47zAv3qOq4m0TVtKhWZ7xxRyHy+NszXW0D2q4IV9ELsV3Q5RqWQSg
         eobDCH4uDIHgxumvHU1R4qaz5uDtCLRSHuMGj1Mxu3MeczlRCk8dI/tj6bjDD2eoDXb5
         azJ49CURRQgkTmgaDFiOTiTnx9SQYFkBG3bz8MxRTJSDUNNQkmv7m8/sWqn5GEwlJXdK
         OuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mFhXj0tEAhsfyZTpC+pA0y3V6Mu8O9E7KDAbCPpVRdQ=;
        b=0TaE4fL8/ISYpJWOTGX7pIwvkhJyI5+8k4ioYHdpGHBviMI4YLcVu3qojPguFH8bk1
         /c249tgt3rLiCWmMzzIOAOh1snE7fuqorpe3G/I3iT3MUbPYAI3d4ot1wrc7bVd8xlnS
         OvHH21Nxrj1CUVJV4LoXgYliHfrp2RncjLzJXjQfnVANYsXDhyRSktEuP0FihmI9YPrB
         PJ/iVhEpRr9K8JSVE6yvH8MOahEGtoGN2P5nJJJtAAr+sL9Wb1auK+GEjwZzH5OotDic
         y4MTDB6P68LUTEBHM7SRm2bnyutl7o7eaUhIc05JxjKkkQEWAR4ky+Bkea66yAsCoVDu
         uS6Q==
X-Gm-Message-State: AAQBX9es388mCuXO0wzr8bqXsMsD5LkhLowyppBbviMdxAHykkNjSrx4
	o3N+18Kg4qt9JPRTSz6luXGYlA==
X-Google-Smtp-Source: AKy350YGUEGW+OzPuLFpHC/tMSlLIE8zNUdn4a0I+N/1se3bFf303AodDMW/ycIik5DsN61yeegKcg==
X-Received: by 2002:a05:600c:211:b0:3ed:c84c:7efe with SMTP id 17-20020a05600c021100b003edc84c7efemr2353191wmi.7.1681309338790;
        Wed, 12 Apr 2023 07:22:18 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:4382:4a00:b3c9:ac57? ([2a02:578:8593:1200:4382:4a00:b3c9:ac57])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c450700b003ee2a0d49dbsm2651927wmo.25.2023.04.12.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 07:22:18 -0700 (PDT)
Message-ID: <7c1b7cc3-82fc-4e72-7021-8d209bb3bd83@tessares.net>
Date: Wed, 12 Apr 2023 16:22:17 +0200
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
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CANp29Y5x13DD8n+aTypSGa5B7+VgOYRvCiSugHz7eFBZrKMZ1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Aleksandr,

Thank you for your reply!

On 12/04/2023 12:55, Aleksandr Nogikh wrote:
> Hello Matthieu,
> 
> Thanks for contacting us!
> 
> This bug is somewhat special. Syzbot normally classifies crashes
> according to their titles, but there are also cases when we cannot
> extract a good crash title. As a result, crashes caused by unrelated
> problems may end up in the same syzbot bug. This is the case with
> "INFO: task hung in corrupted", "no output from test machine", "lost
> connection to test machine" and a few others. Probably we should put
> some explicit warning label on them and treat them differently.. At
> the moment it just drives bisections and subsystem recognition
> somewhat crazy.

Thank you for the explanation!

(yes, a label would be nice and it would be even better if they are
treated differently :) )

> The MPTCP was mentioned in the crash from "2020/05/28 11:24":
> 
> report: https://syzkaller.appspot.com/text?tag=CrashReport&x=138006d2100000
> syz repro: https://syzkaller.appspot.com/text?tag=ReproSyz&x=14947d26100000
> C repro: https://syzkaller.appspot.com/text?tag=ReproC&x=172726d2100000
> 
> Though, looking at the report, it seems that mtcp was mentioned there
> just coincidentally.

Yes, I confirm it looks like a coincidence.

The two repro seem to suggest we should assign this to the USB
subsystem. But does it make sense to do that if there are different and
unrelated problems linked to the same report? Also because there were no
more activities for more than 2 years, it can maybe be marked as closed?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
