Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C26FCB
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 13:38:54 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id fw30so11414655ejc.5
        for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681738733; x=1684330733;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pqhKkGWYnUKpUQfsrfMfrS0UiR6t6yyiI7bz0rF/Lc=;
        b=dtdbDz2MjWs0xGIFI4PU9BGVqKJZhb1X6kKr3mr/ZI9z0TlRjlDmcmLTUytRxlZ9qf
         NQKFL0M4c2H2FQTIb26bUn5mpM0HYhR81k9OqoLCwXGoQ60laOT1ijzdk9nYcd6hon8i
         fnjaIfhlo454dFCst50q7Je3kX/H+00gOK+Ceucta6E0JYv8P1lCI6SC68ZyOOGUd+3Z
         CpbhbGjcIn+98kD3lpCqfaLVPx9DgSkxBQpAiKVF34DuxOG+GGAkoYZI1arM9+932nvd
         dUuR6M6psDO4Pf+d2wQ5vweJXwFEfy2yep83kRUptvNZ4cz3sjUSaL9s2VGiXtEPeYPH
         lufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681738733; x=1684330733;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pqhKkGWYnUKpUQfsrfMfrS0UiR6t6yyiI7bz0rF/Lc=;
        b=hebeyJPu+7sWDCW6/egX8NjAojnC45uw4kCJeSaF50I6wn6Ev2cJgC1i0lsnU4/FP/
         47Y7GOJdjdMQI/dbyEqP5nZiZnqpgeX5y5IO+RfQvivBSxkhnNhDx26J/uyWo9CN1/gA
         41Q+2X/uypRvTpLQleLBjo+5Iw7clu7djMfyv47zLwbvLC+pZW08jQMDa4oevqDyYGGD
         Vr0J3dzgcJ4T4Ty1iodOjFCHZtU8wh4Y/t4AyQgBreEJEy8zQb6iXMSoyfW2A1zUsdQN
         Qh3lOU5hdE8ajYtZLpD2668zZMomzCBLl1bs0HxMDQ6MDwmOpHuSrtKbzaebze4vJXWp
         LrVw==
X-Gm-Message-State: AAQBX9eXcxHrWc3cvEXTjE7tF1LODC90zHnwPWPTpqO8bsUVL9Ziaz45
	kbDY1W3u3pSPC/rA04q1/Oxa5A0zDIHV1x1BzjA=
X-Google-Smtp-Source: AKy350beLC7OTofgu9kPdyIQ7Sx++14LRSQeFzthWJZcFuSFPfGbns8alrcgvO9auzEOLwrp9EEVog==
X-Received: by 2002:a17:906:7693:b0:94f:bb76:f4aa with SMTP id o19-20020a170906769300b0094fbb76f4aamr332460ejm.9.1681738733111;
        Mon, 17 Apr 2023 06:38:53 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id qb37-20020a1709077ea500b0094ee0c9a6d0sm5134059ejc.184.2023.04.17.06.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:38:52 -0700 (PDT)
Message-ID: <7e905b25-2b44-fd15-93a7-2d45f0b18513@tessares.net>
Date: Mon, 17 Apr 2023 15:38:52 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net-next 0/5] mptcp: refactor first subflow init
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <20230414-upstream-net-next-20230414-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net>
 <168171602233.1935.2357676124507584739.git-patchwork-notify@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <168171602233.1935.2357676124507584739.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

(- netdev ML and maintainers)

On 17/04/2023 09:20, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by David S. Miller <davem@davemloft.net>:
> 
> On Fri, 14 Apr 2023 16:07:59 +0200 you wrote:
>> This series refactors the initialisation of the first subflow of a
>> listen socket. The first subflow allocation is no longer done at the
>> initialisation of the socket but later, when the connection request is
>> received or when requested by the userspace.
>>
>> This is needed not just because Paolo likes to refactor things but
>> because this simplifies the code and makes the behaviour more consistent
>> with the rest. Also, this is a prerequisite for future patches adding
>> proper support of SELinux/LSM labels with MPTCP and accept(2).
>>
>> [...]
> 
> Here is the summary with links:
>   - [net-next,1/5] mptcp: drop unneeded argument
>     https://git.kernel.org/netdev/net-next/c/7a486c443c89
>   - [net-next,2/5] mptcp: avoid unneeded __mptcp_nmpc_socket() usage
>     https://git.kernel.org/netdev/net-next/c/617612316953
>   - [net-next,3/5] mptcp: move fastopen subflow check inside mptcp_sendmsg_fastopen()
>     https://git.kernel.org/netdev/net-next/c/a2702a076e73
>   - [net-next,4/5] mptcp: move first subflow allocation at mpc access time
>     https://git.kernel.org/netdev/net-next/c/ddb1a072f858
>   - [net-next,5/5] mptcp: fastclose msk when cleaning unaccepted sockets
>     https://git.kernel.org/netdev/net-next/c/8d547809a5d7

Now that these patches have been applied in net-next, do you want to ask
Paul Moore what to do with the two other patches modifying SELinux/LSM code?

I guess we are not in a hurry but I was thinking that it might even be
easier for Paul to maintain patches modifying MPTCP code now that we are
one or two weeks before the merge window: what could be done is to have
these patches sent to Linus during the second week of the merge window,
after the merge of net-next into Linus tree, possibly as part as a
second batch from Paul. Just a suggestion :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
