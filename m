Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD791C06
	for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 14:59:41 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so2961665a12.1
        for <mptcp@lists.linux.dev>; Fri, 28 Jul 2023 07:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1690556380; x=1691161180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNN6i6we2q38vKWePDW8ZPNvwf1rLAfJf4eOPcGhvyM=;
        b=zkP/Fm7ZgR/0dZqq+LpZeNznpeGBMStjKMjnwzfMBhlMcc1Yj93qPvfiOay8/T1fqu
         Lf1PTv7eQ6p7dnIW97Erl1SHlC/1URaHe58B4Xx6JzV8duO+suJHIfmzXuKt9vACkq/S
         VgovLXArP3b6JC2agnabESUXdYLXiJpjolbqi1hN9tFq/IUeBAC2gwmR/5gS+nb3k6Xd
         /CqidB6SMn2H6XwZUWhDEEFAb9+i8DwMDsM0pFgDhUxMDaig6GqhdlP094S/4+JktA6V
         G88H3iyOdVWeRE2vfijf/YU23c10MBG6n6/4pqSXMJp6+ww7akgpuMvyWFpHksUjgXzr
         rPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690556380; x=1691161180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNN6i6we2q38vKWePDW8ZPNvwf1rLAfJf4eOPcGhvyM=;
        b=ZTn1W3Qu2+ynA+0/fIOcXMYcUDfha9cA34D1kLmOTwZ5gFz+K/3OKAQrb9Li/rXI7v
         ljxtkHwymgiFDkogFC9LOYjAp+G0EilFuXLAjANAYY51P820n3XqB+SFp4X7Hb6G2ixo
         K6GQRD0UfuFetRI6gRv6pd04HJvf/0Fv34qbbBcfEB42fk/NlmHu4RqRqdjpoRBfXJJA
         PL6aBU8XUSfeHb0QA78f+9zXzmL61q0WLV1ETg3Il7Wex0gDISoqAGhgJOT8l/YYygvH
         7fPEYMFnlxNu0izAu5NkE1FAzueOMXdxHP2KUcz9fkBYfagKQlv4ryBQD9VrBV9tZgJz
         6eLw==
X-Gm-Message-State: ABy/qLbmaK6sNz0GvIcecdNcMkZ8rzYdcOi4ncAOBPSYxP37Yqp+4Jny
	iWVoak/Izku48mZ92dkmLeavYA==
X-Google-Smtp-Source: APBJJlHRy1Wkicp+QKzkOTzDezpVz6yE9GEJUlwN8xYDiZgc29ixmWnTRctj5daOL07FMoJwnOK4Og==
X-Received: by 2002:a17:906:8a7c:b0:994:5340:22f4 with SMTP id hy28-20020a1709068a7c00b00994534022f4mr2172206ejc.6.1690556379728;
        Fri, 28 Jul 2023 07:59:39 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gr16-20020a170906e2d000b00977cad140a8sm2126035ejb.218.2023.07.28.07.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:59:39 -0700 (PDT)
Message-ID: <d9fb660d-c45f-e8e4-4995-9dba6de2d1f9@tessares.net>
Date: Fri, 28 Jul 2023 16:59:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1.y] mptcp: do not rely on implicit state check in
 mptcp_listen()
Content-Language: en-GB
To: stable@vger.kernel.org, gregkh@linuxfoundation.org,
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>,
 Christoph Paasch <cpaasch@apple.com>, "David S . Miller"
 <davem@davemloft.net>
References: <2023072119-skipping-penalize-15f0@gregkh>
 <20230727141625.2524544-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230727141625.2524544-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Greg, Sasha,

On 27/07/2023 16:16, Matthieu Baerts wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit 0226436acf2495cde4b93e7400e5a87305c26054 upstream.
> 
> Since the blamed commit, closing the first subflow resets the first
> subflow socket state to SS_UNCONNECTED.
> 
> The current mptcp listen implementation relies only on such
> state to prevent touching not-fully-disconnected sockets.
> 
> Incoming mptcp fastclose (or paired endpoint removal) unconditionally
> closes the first subflow.
> 
> All the above allows an incoming fastclose followed by a listen() call
> to successfully race with a blocking recvmsg(), potentially causing the
> latter to hit a divide by zero bug in cleanup_rbuf/__tcp_select_window().
> 
> Address the issue explicitly checking the msk socket state in
> mptcp_listen(). An alternative solution would be moving the first
> subflow socket state update into mptcp_disconnect(), but in the long
> term the first subflow socket should be removed: better avoid relaying
> on it for internal consistency check.
> 
> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/414
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> Backport notes:
>   - Conflicting with a cleanup that has been done after v6.1, see commit
>     cfdcfeed6449 ("mptcp: introduce 'sk' to replace 'sock->sk' in
>     mptcp_listen()").

Sasha just backported this commit cfdcfeed6449 ("mptcp: introduce 'sk'
to replace 'sock->sk' in mptcp_listen()") so 0226436acf24 ("mptcp: do
not rely on implicit state check in mptcp_listen()") can be applied
without conflict. Thank you for that, good idea, it works for me!

Please drop this patch here then.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
