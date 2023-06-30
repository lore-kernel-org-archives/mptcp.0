Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2A91FB8
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 08:42:50 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-992e22c09edso46209166b.2
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 01:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688114568; x=1690706568;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0G+t9aEULTyFqyIPDSgN83xFMn0i9mbblkPre1UHPo=;
        b=I1T86TZEn0r6XW1UZ2tItPHbpHM7WMC7R6Yodvq5hFX4xTuw4HBTMqLSZ5vxgGlvuW
         RKK3rVziITXFyTdhuzJ9GYWCfMkKm+B9ck9YRV0NAkxFMg1Ui5JSl3l7gMDbb9Oq3JXG
         +8ZtQlsMrBRAcouqcx5UtCRaqZ7VoT1K+0IVuwbVkdmrOzoza9Y5rGklRD08mas52ELs
         zyvir6z/2ULviZKwIJKp2oEwSxr3iPv75KWaI9twXptdZKUiKw2wGau9e/07yOUYMnEA
         TibeWH/uALCTTZbZAa9FTGz9KDy2H5S1Kk8tbARAZwdMxPlrUk73ANSFczQquHvjUVNT
         fqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114568; x=1690706568;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0G+t9aEULTyFqyIPDSgN83xFMn0i9mbblkPre1UHPo=;
        b=HOqSanoFyu5cWRxLbWzyjTQoFawPJK4VWmdHOMoz/9yq/0pRPKId2UqaER5pz16CBD
         qhSd4cWwvsZxDnl9mu5U0+Ujb/PM+EMdCTPOFTRU5lYAYyxL0DVC7O3MHgwTafl/PJVH
         T6m8szJzh5hZeRAPaXfR0hOwVjCAjvynGIkVzj+U7XiBY/ooObZEAtp70uwfqcjPqLPW
         Rlt4SudzFBpt9lg6t1DRLU2hL8cBFO7UxVx9YnPfLArKaAp+7VBke2BgEI/Uy3jwVfWi
         znH00Y88w0iFwDJUHzuB2CmwZypN351ITz6MGpGbORl7sf593e9bFsRkrQpJ8DKyxBRK
         ZKsQ==
X-Gm-Message-State: ABy/qLaZMpiMGKO4kfzEGObYZPUnW0txGy4rajRK0JNRzcrfdKXkpNbr
	GHjPUjGthzcf5rpthkO6fJdz0lMu/h2nwCRxANWZ4F5a
X-Google-Smtp-Source: ACHHUZ7tacgbqEqXF9GyY6WsMuQV9VFnrAgiJ0/3mP/8/6yNM8yfBJbPUuzJ+jS/z2/mW3OeXStuhQ==
X-Received: by 2002:a17:906:c408:b0:96f:e45f:92e9 with SMTP id u8-20020a170906c40800b0096fe45f92e9mr1364344ejz.16.1688114568485;
        Fri, 30 Jun 2023 01:42:48 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id gw26-20020a170906f15a00b009929d998abcsm2172952ejb.209.2023.06.30.01.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 01:42:48 -0700 (PDT)
Message-ID: <ee5e8149-7c4f-31e5-d5cd-d17e30f8ba43@tessares.net>
Date: Fri, 30 Jun 2023 10:42:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next v2 1/4] selftests: mptcp: set all env vars as
 local ones
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1688092826.git.geliang.tang@suse.com>
 <0c0c8ee5bd9c49c17565d018e4bd6985901ac7d8.1688092826.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0c0c8ee5bd9c49c17565d018e4bd6985901ac7d8.1688092826.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 30/06/2023 04:42, Geliang Tang wrote:
> It would be better to move the declaration of all the env variables to
> do_transfer(), run_tests(), or pm_nl_set_endpoint() as local variables,
> instead of exporting them globally at the beginning of the file.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index e6c9d5451c5b..ad0717cb0d7e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -49,11 +49,11 @@ TEST_COUNT=0
>  TEST_NAME=""
>  nr_blank=40
>  
> -export FAILING_LINKS=""
> -export test_linkfail=0
> -export addr_nr_ns1=0
> -export addr_nr_ns2=0
> -export sflags=""
> +FAILING_LINKS=""
> +test_linkfail=0
> +addr_nr_ns1=0
> +addr_nr_ns2=0
> +sflags=""

Ah yes, you still need to make sure they are not already set before
using them later and that's why you set their default value here, right?

But then, I see you are setting the default values twice: here and in
the different functions where you declared the local variables. To avoid
that, I would suggest to either:

- "unset" the variables here and keep the default values below
- declare the default value only here at the top of the file and in the
different functions, only do:

   local XXX=${XXX}

I *think* it might be clearer to do the unset (+ a comment) and keep the
rest as it is:

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b89077510080..9fc5a78c6063 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -49,14 +49,15 @@ TEST_COUNT=0
>  TEST_NAME=""
>  nr_blank=40
>  
> -FAILING_LINKS=""
> -test_linkfail=0
> -addr_nr_ns1=0
> -addr_nr_ns2=0
> -sflags=""
> -fastclose=""
> -fullmesh=""
> -speed="fast"
> +# These var are used only in some tests, make sure they are not already set
> +unset FAILING_LINKS
> +unset test_linkfail
> +unset addr_nr_ns1
> +unset addr_nr_ns2
> +unset sflags
> +unset fastclose
> +unset fullmesh
> +unset speed
>  
>  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>  #                                (ip6 && (ip6[74] & 0xf0) == 0x30)'"

WDYT?

I can do the modifications when applying the patches if it is easier.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
