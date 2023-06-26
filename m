Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB58F70
	for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 13:21:00 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-313e12db357so3513435f8f.0
        for <mptcp@lists.linux.dev>; Mon, 26 Jun 2023 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687785659; x=1690377659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGpgthD8pV4+ANAWJEifB+UqmknnjA0SAvtv41YMSPs=;
        b=01sOVCqH42Nh8Vc9c+UeKKe2Da/AxI3cMjLBOdSExgOLw7Rkvm4Q7XP+ekhGUoiXAF
         K1bzT3UrJMiiymNxDOD3qRb46J+QnwWEON0D0i2zZpKp/dJdSQsSIqaxJJDSVZCwbnuu
         gpMj+b6m6+7Vdv+4s4mN8VSoL+1Qzy9V2+2E3Df/8NoNtCGgN8rHzoQOlbQ/J9QQBSFR
         9OhRjKL7ArQy6Qbv3LRQNFOquvlsKd4/iW4ljSqAIx65D+7cWHRZJeL5Dh7fzyorrkzZ
         V5w/fxvREzHTJgoImb7UiChVCZ6VJ8TFWDiXjXjdv/5KY4vX6CyGJlj3NDFXGssroo3s
         vRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687785659; x=1690377659;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGpgthD8pV4+ANAWJEifB+UqmknnjA0SAvtv41YMSPs=;
        b=HKxLNTngoSTZTe+h8C2zWxQsJrjDX+RFmNejAvsxmvsSe3g01yIuWrK+YjtubUP1ec
         uY+UPple4ssOquqvDXRAgINOF3P65d8bIM5d2nHQ/PdjLPOXku0whe90RIT/AluIMIb8
         +iatMQ1iMo3P1yDn9QZQhUCmnWt1g+YhCsUL6DWJmtGfTmgPfue1U0yMRHyWKRQwWqOZ
         3s6TBZZbmfe1ti6/PsWlw5FkzceXmP5AfxJyioIotNE3SBfUr7HAcadqvm84XAZGphsA
         xztoNvPFVDlHfOqSRZ0qjPLu/ypdl+3q8RGgBr8nqPPRcFvaXDyNq4Rft/i3kYpcykRB
         JqJw==
X-Gm-Message-State: AC+VfDz5cSS5b8H3jsgg9mLWHLJzO+zSIZnWgm55QHpvO0YNjpwxP93q
	nISw+z7RPu11we2z4YIuECPnvfvcQuSx8Sj7pcV9Cw==
X-Google-Smtp-Source: ACHHUZ5pvRLaN28ztjkJkvs1ALJ+PQix89OCvQ/F1LQzlqa0MsNfOryn2OM4DpKbDbcq/3P7wvKZ0A==
X-Received: by 2002:a5d:420b:0:b0:313:e8bf:a6f with SMTP id n11-20020a5d420b000000b00313e8bf0a6fmr7861790wrq.23.1687785659098;
        Mon, 26 Jun 2023 06:20:59 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b003095bd71159sm7509519wrn.7.2023.06.26.06.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:20:58 -0700 (PDT)
Message-ID: <c199a3b4-0d93-4ae8-07e7-1e716fd919af@tessares.net>
Date: Mon, 26 Jun 2023 15:20:58 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net] mptcp: ensure subflow is unhashed before
 cleaning the backlog
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <73f793566f58e53e7c132711cd75fa7ea211d6f4.1687531836.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 23/06/2023 16:51, Paolo Abeni wrote:
> While tacking care of the mptcp-level listener I unintentionally
> moved the subflow level unhash after the subflow listener backlog
> cleanup.
> 
> That could cause some nasty race and makes the code harder to read.
> 
> Address the issue restoring the proper order of operations.

Thank you for this fix!

I was surprised to see the CI complaining about the "fastclose server
test" test, with *and* without the debug kernel config. But I don't see
the link with that, it looks like this test is not stable. I just updated:

https://github.com/multipath-tcp/mptcp_net-next/issues/324

The patch looks then good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
