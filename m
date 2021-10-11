Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCE472
	for <mptcp@lists.linux.dev>; Mon, 11 Oct 2021 16:09:09 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id d3so42265718edp.3
        for <mptcp@lists.linux.dev>; Mon, 11 Oct 2021 09:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=G533sdFKQwvVOSdcmM/6u7H7qdX6jYBajxX1YY/K0SY=;
        b=wU7r2KKaLtJWEbDXrWM9X2R5r9N9PXhooD4xY9A9sHIRLzmcF1BqcjE+keh8TuxuGS
         GIl+s1Z+1t9HsJWnBLWD/n1DOlwfpPNtmbeZnG4wTn8nIX0Vgp353PH3WDhLFGUngoYO
         OQp2udgLWkKAWbyXV1in6DCjvGjeTP2rpgJLG8TudaAqJ4Lzzv9/0fhvHUWroFS6EEd5
         uLArZVaecRYduYam4c1/pM9iU/kclnsqok0NpWsjGU4WZdxH75uTR1qVEn7vDbIiZktu
         H3LUaNJuhXVABAe6W6CiXloZIyJKSMsWR3K8BzFVtTESmHCCLHWwxHROrMULPZkOu2SR
         mY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G533sdFKQwvVOSdcmM/6u7H7qdX6jYBajxX1YY/K0SY=;
        b=Y9p/wrvbUmRYPt9leqSS3EFc8a5h4xLkwxbVP8WtjdGO/WSschrm4zfgscv2aOK4E4
         aLHs+UD4n2tdNt/y32RhabZdVFyGhL4CxWKnLhHQJtQT/ppadbL0QxV8OecMAv43d1Z4
         mI7uw8FlKvl1W7HTLUBrwvMCmnGy3Vq81x3MxHs0mTpr6U3hHWvUO/KzoN+7FEenMhoZ
         8ehGi2Zaw6xK2Ql3Cbu6Q9ahcPSWaFwhLHQXK+lIllVoPWintGrhkrfmnAJn8jmrTG6p
         TqwxAkujMQGs3eBydkk1dkYKKq80Kuq/q1nMfdr062hISWTYx9CZGRKsUeffKrNLuVwh
         cmRQ==
X-Gm-Message-State: AOAM533LcxTGOBr4aCaCnVYgVbyuBWB122lxPlza7jNCIPkszPjqZfHZ
	wwaTglYzCSPQsk/QjPXmY4P0ftd3f5qDtw==
X-Google-Smtp-Source: ABdhPJw0eNzufWRe/QKG8IEHPP3crwd5gaev9Juzw8qVv1WxueaHlI1DyIAhHtQxnqGFMlF4TxsMhw==
X-Received: by 2002:a50:d84e:: with SMTP id v14mr42227729edj.85.1633968547770;
        Mon, 11 Oct 2021 09:09:07 -0700 (PDT)
Received: from [192.168.178.46] (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id l5sm3624114ejx.76.2021.10.11.09.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 09:09:07 -0700 (PDT)
Message-ID: <ed428aeb-8d9f-90c8-60cf-5c714b3460e5@tessares.net>
Date: Mon, 11 Oct 2021 18:09:06 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH mptcp-next] mptcp: increase default max additional
 subflows to 2
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 08/10/2021 19:27, Paolo Abeni wrote:
> The current default does not allowing additional subflows, mostly
> as a safety restriction to avoid uncontrolled resource consumption
> on busy servers.
> 
> Still the system admin and/or the application have to opt-in to
> MPTCP explicitly. After that, they need to change (increase) the
> default maximum number of additional subflows.
> 
> Let set that to reasonable default, and make end-users life easier.
> 
> Additionally we need to update some self-tests accordingly.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm_netlink.c                          | 3 +++
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
>  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
>  3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 050eea231528..f7d33a9abd57 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -2052,6 +2052,9 @@ static int __net_init pm_nl_init_net(struct net *net)
>  	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
>  
>  	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
> +
> +	/* Cit. 2 subflows ought to be enough for anybody. */
> +	pernet->subflows_max = 2;

Sorry for the late reply, I just thought about something when looking at
applying this: let say that in a typical setup we would have 2 subflows
per connections because the client has 2 interfaces and connect to a
server not announcing other addresses. With this setup, could we arrive
in situations where we would (internally) have 3 subflows?

I mean, could we arrive in a situation where 1 (or 0) subflow is OK, 1
is being deleted (network reconnection?) and the PM is already trying to
create a new one? In this case and because of the limit, the PM might
not try to create this 3rd subflow and might not retry when the dying
subflow is actually being deleted? Or maybe the PM already wait for the
full deletion before re-trying to establish a new subflow?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
