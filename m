Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DD82F5B
	for <mptcp@lists.linux.dev>; Wed, 17 May 2023 16:41:43 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f420618d5bso7286395e9.1
        for <mptcp@lists.linux.dev>; Wed, 17 May 2023 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684341701; x=1686933701;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIR659ygUlOIeEVvXoXy8ZWQyjvihbMCHQyNU+YS+uE=;
        b=mB4IXyZHf66gEwnkGXWQu4JMrZS6MH9Z64U1VWH5xZU+U3W08/ZkEzMsyip0PZDR81
         SFgHmsE4FKKFOI4sBygi8VKYfy+LxAeSTAdJeAVlDygqpbQUQWYmz38rQLOAyVN423DL
         khvOwsZIjLy5PjLYf5abPXTlwtA+fRGoStc8YciVwhfIA88BsnR57Hpl2hZm0a+XOLlY
         0/tMFzZz0Kn7o7WMnz6CK69hGwy3R8FgQkX0FhTyKZHBkW/695nfZcSue2DNPr4Qb31X
         EG6gmCHUzu604vIY9aJ28aPvzp8smlr9Yuf0Q+3/hU6ZtVKBIHRH0+tebVq0LOURdV4w
         II1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341701; x=1686933701;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIR659ygUlOIeEVvXoXy8ZWQyjvihbMCHQyNU+YS+uE=;
        b=cmk5nVhoyXHsIyNhZQFB8QlxR02PzGHjdKztftg7dnXFdQDsSsu4JrSgiGJNXM8DnB
         Jb0gAiXpYp4nkYkAgyzfWdcnkJ1uDnj3Uu3OjTm1SvFdOYyBK/AZQYrJA8NuWsy9HE/n
         K+uwJl/iVX6NR8jg5ZcicUh3//YoNRSZZwH2ARRoSI4mN3lGP39mWwdRJIhTYOfrJkIK
         LK6uGLoousCmbGFr15CMmxd5o4eQlxiMpkRjajeHJSOr3EjpryfdwxF0Gw+Fd9lBwNAv
         XBKZj54VmMv/KX/eoX0r54Ti3Xz+uUs5vFbVvgRof+pAswXjCV5eD5pY8SuCdArJ9fRD
         8vXg==
X-Gm-Message-State: AC+VfDzmUtyfLmemw5M3qbzFVAeWn3zP10haLZHLeV7/Dx7m1JueNdFO
	9JcXeY68J8DclOJ0wYmyN5cMb6UpEIpKPef1WJQ=
X-Google-Smtp-Source: ACHHUZ6HtB2blbWdIP9S5ZE9v24LRKc2cw7Mh/H7WBJDd7Ma00hxKjdDrXF7MCJFGs5yoe8S0mhGXA==
X-Received: by 2002:a1c:6a08:0:b0:3f4:3562:f799 with SMTP id f8-20020a1c6a08000000b003f43562f799mr19062848wmc.28.1684341701529;
        Wed, 17 May 2023 09:41:41 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a66b:672f:3b69:b6da? ([2a02:578:8593:1200:a66b:672f:3b69:b6da])
        by smtp.gmail.com with ESMTPSA id z6-20020adfec86000000b002f9e04459desm3196771wrn.109.2023.05.17.09.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:41:41 -0700 (PDT)
Message-ID: <acde849a-c002-7e7b-3294-ba306bd582e1@tessares.net>
Date: Wed, 17 May 2023 18:41:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH mptcp-next v13 7/7] selftests: mptcp: set endpoint out of
 transfer
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1684116357.git.geliang.tang@suse.com>
 <bd1066b5d9c1eb7c3b917677e9bd96b3c820aff8.1684116357.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <bd1066b5d9c1eb7c3b917677e9bd96b3c820aff8.1684116357.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 15/05/2023 04:10, Geliang Tang wrote:
> This patch moves endpoint settings out of do_transfer() into a new
> function pm_nl_set_endpoint(), then addr_nr_ns1 and addr_nr_ns2
> arguments can be removed for do_transfer() and run_tests().

(...)

Good idea, it looks clearer!

I only did a very quick review, please see below.

> @@ -2148,10 +2152,14 @@ remove_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 -1 slow
> +		run_tests $ns1 $ns2 10.0.1.1 0 slow 2>/dev/null &
> +		local tests_pid=$!
> +		pm_nl_set_endpoint 10.0.1.1 0 -1
> +		wait_mpj $ns2
>  		chk_join_nr 1 1 1
>  		chk_rm_tx_nr 1
>  		chk_rm_nr 1 1
> +		wait $tests_pid

I think this will cause some issues:

- if you run in a slow environment, not all events might be triggered
before checking the join and remove addresses: I guess you should wait
for the transfer to finish before checking the different conditions, no?

  run_tests (...)
  pm_nl_set_endpoint (...)
  wait (...)
  chk_(...)

- if you launch run_tests() in the background, we will no longer detect
errors during the transfer I think. Plus it sounds like a bad idea to
use "2>/dev/null". I think you should have 2 new helpers that would
split do_transfer in 2:

  - the first part to launch "mptcp_connect": what you have now up to
"wait $cpid"
  - and the second part from "wait $cpid" to wait for the transfer to be
over, stop captures and check the transfer.

  → run_tests() would then call the two new helper so we would no need
to change all subtests

  → in the tests requiring pm_nl_set_endpoint, you can then have
something like:

  start_transfer $ns1 $ns2 10.0.1.1 0 slow
  pm_nl_set_endpoint 10.0.1.1 0 -1
  wait_transfer
  chk_XXX

WDYT?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
