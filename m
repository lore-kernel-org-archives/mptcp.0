Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA2185B
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 16:23:29 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id f17so2990133edt.4
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ca7eOhdp+MlP2gypZ3BNf4ov3jfybCTNk9Rhqciun8Q=;
        b=eEIyQfstTFiNpFgBKvBavK+uUJ1Msc8yWgmWZ78xpjQsU4a+rRskRwd4LC9ixGj/3e
         7tU9XJo5jhR9NWvw4XqA7YHYWGoe9uZWO7rhgMAbrNG9bOf/G0d2UPgZLqHkzZYlFseE
         izAZKmvNfFQruXecKkfLR1OkQGanSfzavSp+UDNeL4VOeHoB8x5/P285492s7ftPTM1+
         sY2OnSPbyC5uV+thDAUy3pKkN62r679dGm9r6DkwB3CG+DonWKwcJKuZBzqnfsDloqpV
         u6JQLCZCadNxw5y6F7FvS0haY6WAiwaSwR9/Gw6Ob3WQLqQ63jhMMj0EKcXsikv/qXwE
         BoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ca7eOhdp+MlP2gypZ3BNf4ov3jfybCTNk9Rhqciun8Q=;
        b=bMf6loKssLGysl9pFLAPdIGo3drEzuAph5jjr3tPF+9SlY9dmHN7sPizSMxO9yDpmX
         xc2xpcGaigU2Aaqmpp7r67fmykfANKecgkcAkJxgqNtb9/Azd1+RTAQW1fdfhaMSfAsM
         qz/s+1eGo2GeFMXGyP5+77jXXHCErCW6uhnSc6qfeQXMBvE0gqHohauZDpsPKheUA4Er
         aPQOxyVTnNrPK3aw3OUPwVbe/fK23Cgaln4bFCR0V7kixeeztD7mVbEcE2COQLwxjY3P
         JLsPBL/ukmWUz9FrcmaxUoyZ3namVWYDuRG+QbYz9zOvy86zg0B5G2QYLJ4/di60gXDJ
         lMFQ==
X-Gm-Message-State: AOAM530a0Ym4y4Y4ZhPjNhKSdLGn2ECtqOIQ2fYD20vn9p/cm83UIr0q
	eW5hE8FHZJkyh3ZV+AWtvnRl2A==
X-Google-Smtp-Source: ABdhPJz3laln3N4r4hICZBm9lByKDMKZ5XCGz1+d+dIqEnumigDtM9z1+GKTu0oF+wwDqGyLIgup/Q==
X-Received: by 2002:a05:6402:34c7:b0:423:d44a:4c6c with SMTP id w7-20020a05640234c700b00423d44a4c6cmr22152578edc.356.1650471807893;
        Wed, 20 Apr 2022 09:23:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a8ef:af16:f14e:5d01? ([2a02:578:8593:1200:a8ef:af16:f14e:5d01])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906044f00b006e897e110fcsm6884036eja.48.2022.04.20.09.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:23:27 -0700 (PDT)
Message-ID: <ecdf9234-ad37-0bb5-6a73-870f31b11a26@tessares.net>
Date: Wed, 20 Apr 2022 18:23:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v12 07/10] mptcp: add last_snd write access
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1650430388.git.geliang.tang@suse.com>
 <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2022 06:57, Geliang Tang wrote:
> This patch exports the member last_snd of struct mptcp_sock in
> bpf_mptcp_helpers.h, and adds BPF write access to it.

Do we really need the have the different schedulers modifying it? Could
we not let the caller of "sched->get_subflow()" setting it?

I mean: 'last_snd' should always be the same as what get_subflow() will
return, no? If yes, why not setting it in mptcp_sched_get_subflow()?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
