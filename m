Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0AA19BDF
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 15:59:58 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so2243336f8f.3
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685030397; x=1687622397;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6QTPgDubfvsK0wwl0ciD/6PwFJOG+Dq7LNpgkQt8R4c=;
        b=GnakL/0atOl+7qSK6oAPTbCeG3ZhcW48Ilx3XkAZVmdLfnxrQDgloxMmlgUCSYZAk2
         98WxyCaJe4QOJhrSea4XRx564MSlI0BJ7yDivd4+5FUu7J9dkr4c7hONpBQduPgFKpOv
         83t2EwpAFkJLI7mXK3ffUo/nU5AWLSyJoyFvzarlW6HgJdt/DOR51x11sQ+4Pa66Hmmn
         eNRrF/NrNVfx6AFTG/FEmt/hLBxp5tqgl9g7QaWfmr4O/XEtZ+TU+BBIGx4WokQbEB7Z
         ih4Ecx00ksgYiDn49c0iOYRpAEW0A1D9pqBuT2T6hMHHWcJw8JkLgiQPh78MDjZnwwen
         Yd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030397; x=1687622397;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6QTPgDubfvsK0wwl0ciD/6PwFJOG+Dq7LNpgkQt8R4c=;
        b=Z2W2Gx/Bw8/Yi3BJnPaEKAvqhxaegb8gF3ih0Yk6vhp+PCvQ0e8GHH+85NRzCP7uTQ
         rcc7YVUnlSbC+Zqscv7xRvpjeIIVfaf7q4NF3XpXMlys+jotTpRC/ExfF4dTxeY0ehEx
         sx1zoprdF0ECxuzL+Zd/zrc68IHRHMEPNZd7FX9au+p0BtuxJzySPW+pPVaEmp+FeVyP
         L4Hq/KJhkR/Og5yRrbgEPSPc4xwPTD5lbeVaIbh6DfDRTCKv3UePL87Lom7CB1JB5C6d
         CySavbHhinAwf1/lLVwYkohHNOK0vnJp+NuoL4/nRWKb2vdoVl4mULnHRZ+7ZhHbFepu
         rUaQ==
X-Gm-Message-State: AC+VfDxC/jiIaSc0syNDr37Kb+mn280O7TX8aNZ7pYuRy3dpnTQuSyCY
	i0TcnBgO9stOaQIphE9hKWVrxFmTihn/g/YTBiE=
X-Google-Smtp-Source: ACHHUZ4eWpBGViqshEXVFT7cmXDAVgYY3bIoM5A1V6crIu0PsqHhi9BajeBWduWRpB9vvfmkDharyg==
X-Received: by 2002:a5d:4c4a:0:b0:306:3204:3633 with SMTP id n10-20020a5d4c4a000000b0030632043633mr2733395wrt.22.1685030397029;
        Thu, 25 May 2023 08:59:57 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d6849000000b003078c535277sm2196000wrw.91.2023.05.25.08.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 08:59:56 -0700 (PDT)
Message-ID: <b1e4d5eb-788d-e20b-1692-6be4f4322086@tessares.net>
Date: Thu, 25 May 2023 17:59:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next 0/4] unify in-kernel and user PM interfaces
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1685001897.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1685001897.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/05/2023 10:07, Geliang Tang wrote:
> Unify the three PM interfaces: get_local_id(),
> get_flags_and_ifindex_by_id() and set_flags().

Good idea! Thank you for the patches and for the explanations in the
commit messages!

This series looks good to me, just a few comments/ideas, please see my
individual replies.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
