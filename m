Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D88125A9
	for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 15:08:56 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51d946d2634so922907a12.3
        for <mptcp@lists.linux.dev>; Thu, 29 Jun 2023 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688051335; x=1690643335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Co6TGnRbUyF72FhFExbL3/Ya87aGV22dT08AmIx/b4=;
        b=GLo35H3+l6KKTcuu89P6obyfJfbYMlzxWaGEOcacXaKMlUfvqo4360gmlyCU++cukV
         xBGHDtz8g54p15lwbpDyPEH1fAid7DmwraC10KAPu/6s2gJ+fDnB115UHCYqp8FjdolP
         s5IGQMCAPJTHwebE+KMg6AdVFakoorGGEVjj4swx3wz3N9qqluOAINqKU0Z68KkgOYPE
         SFsMpWc7hrDevb5oDgSKDwJiBnSqGgcOzE+shtrDHC9a26AvqicpBZqv2efq+7uZb/zX
         Q2u73NeKDObl5GRU26Irc+Z/Z1qxMPzp7eb8lH/SZSck2qdCnXNyX+Xhf2+3RrcbnkHf
         z3AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051335; x=1690643335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Co6TGnRbUyF72FhFExbL3/Ya87aGV22dT08AmIx/b4=;
        b=K+5hUUAxVlFifaE90hhOEvxsseCoYYSVoaBNrEOQDrZ6SvP0GeTWWYCOK7hpX7FUmT
         iuEAuMyOCPQzOtc5/3458IbI3F4g1iS8XMeJOla7uFz6cExMTfacg/DK4RLPeEPm4NDo
         XiYRTx4aTZrfBJvBjmkCURT+b0dzOfl4O6Au7iF2iYgua9hs5x3bgTTY9KdMZVE0KozL
         Uzbc2ekOiDrPTKZNK0QojkNPX7h2y+7oS5hL4ku++2iCrXlRSVqQbpaGz5tNV650VV24
         y88UGihZ1ZXyETP76zYxERdiTAsR1p0BIfqzIKQhic7XHGZFEXkGycgKU3bzR+YIO45k
         YDwQ==
X-Gm-Message-State: AC+VfDy+Qk5pkJXnmtriCLSQ/xsTWh4yFzFYPm+PE6bJBae/sYjdjN3h
	VlOxpZZSWxB2PMQIfzMJfmHhPw==
X-Google-Smtp-Source: ACHHUZ7vpk+ktiHULwSBmPYToUh6X7SXv4G8tJcNC3mEu7YM123u/5SBteoYgGhGlN3nwxu/4hiepA==
X-Received: by 2002:aa7:d4d5:0:b0:51d:3747:f88a with SMTP id t21-20020aa7d4d5000000b0051d3747f88amr11257453edr.31.1688051335257;
        Thu, 29 Jun 2023 08:08:55 -0700 (PDT)
Received: from [10.120.18.108] ([84.17.46.13])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b00988b32160dfsm6850362ejg.222.2023.06.29.08.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 08:08:54 -0700 (PDT)
Message-ID: <0a5f1944-17b9-daa4-c7ff-6aac38b362d5@tessares.net>
Date: Thu, 29 Jun 2023 17:08:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net] mptcp: do not rely on implicit state check in
 mptcp_listen()
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Christoph,

On 28/06/2023 13:27, Paolo Abeni wrote:
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
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This is basically a new version of "mptcp: fix bogus socket state update",
> but since it uses a quite different logic, no revision increase ;)
> 
> Should close issues/414

Thank you for the patch! It looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

I guess we can also add:

Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/414

Just applied in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 40575a81e44f: mptcp: do not rely on implicit state check in mptcp_listen()
- Results: 1dacd2512f3b..40787b521a4a (export-net)
- Results: ba5bf7787049..d99b5b5a67e4 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20230629T150635
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230629T150635

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
