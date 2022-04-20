Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C173185B
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 16:22:15 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id y10so4586341ejw.8
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 09:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=q75U+I2qBFnGkcCLhkTMhB/4FmLSxU1s/WhnoB0UOgE=;
        b=ZK6rxif30x9FgKsjFQK4CocJyFdA23+1xWNPMZupmuzDtiLljYB9YclSfm5ZX8swG4
         tXklI6AxuGtFDJ9fflWEOTibwCpg5NqVSnUgX7qXJFz+y6vQNDosGdUHqKvZtGsVnKmV
         MXtvIIWB87PKBmrjQ1rVUd/MUMVSwCfY+p5el6zxhwZXU/vpQjVW8Au5oh/ywIDwNim/
         JZPoHcxROC/i7sWf//08OkNDEuaGDuqTo8ToELp7JsAhx0PFFkDglU34n5KldXAeBcKU
         LrIkl3phiagaaDgp3DqY1uv9+Xu8Wc/V8ltao3jGtmVSoawoszUDfyxLQIfjRDfQyKrN
         c0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q75U+I2qBFnGkcCLhkTMhB/4FmLSxU1s/WhnoB0UOgE=;
        b=acyfXIlviDKwYaSb/TkpASsavgOe6CEroDkZNACXB1S906VW2ULlIwG77gy+Lbva1V
         C09eR4uCzGRA8PdpSDJWxUiCRBv0m/A2GgpVk0PO7IuZIoHbNMKSydTnLk68hxzkMswc
         MohoeuZgvu0ctokD/NeduiQR93zQXwG0DKRyl/HUZ/iIm03KgBkN9gQByWPmxhIod9FZ
         NcocxY/HkUuPn1HNDSZSu+dOCbDIvFbvYlm3zjr79g/7zv/GfbPGrFcuBfGGvwV64h4k
         9y9gwJUMrD6IF72PmBYbMcTbWHRd8IG9Elq+gQoJqedXbpXK27SdzFF0MBOwoZ4liBai
         fbCQ==
X-Gm-Message-State: AOAM531qQOIjoBveOmugKDnxXmxM1YhP/Wq2OnJRU51YxVUZfMH1xgWA
	RLWX2tt/1MDWS0tdOY2Uo/rdQFduKxKg/w==
X-Google-Smtp-Source: ABdhPJyyPCpOV1GRhrh/83kEou6Z7VmAvd5PXhLmGZt3dEhzfzUgeZ0T3E71QxwW2wNnWjpLMApAKA==
X-Received: by 2002:a17:907:1c28:b0:6f0:fb8:6ba4 with SMTP id nc40-20020a1709071c2800b006f00fb86ba4mr1746912ejc.274.1650471733387;
        Wed, 20 Apr 2022 09:22:13 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a8ef:af16:f14e:5d01? ([2a02:578:8593:1200:a8ef:af16:f14e:5d01])
        by smtp.gmail.com with ESMTPSA id nd31-20020a170907629f00b006dff863d41asm6896063ejc.156.2022.04.20.09.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:22:12 -0700 (PDT)
Message-ID: <8e64bbff-8a41-63dc-09ba-f95b40a0dc43@tessares.net>
Date: Wed, 20 Apr 2022 18:22:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v12 01/10] mptcp: add struct mptcp_sched_ops
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1650430388.git.geliang.tang@suse.com>
 <9112f71e4901f8dd719c515b26581c8d747fab45.1650430388.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <9112f71e4901f8dd719c515b26581c8d747fab45.1650430388.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2022 06:57, Geliang Tang wrote:
> This patch defines struct mptcp_sched_ops, which has three struct members,
> name, owner and list, and three function pointers, init, release and
> get_subflow.
> 
> Add the scheduler registering, unregistering and finding functions to add,
> delete and find a packet scheduler on the global list mptcp_sched_list.

Thank you for looking at that!

> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  include/net/mptcp.h                           | 13 +++++
>  net/mptcp/Makefile                            |  2 +-
>  net/mptcp/protocol.h                          |  3 +
>  net/mptcp/sched.c                             | 56 +++++++++++++++++++
>  .../testing/selftests/bpf/bpf_mptcp_helpers.h | 12 ++++
>  5 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 net/mptcp/sched.c
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 877077b53200..78a5cb44fccd 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -95,6 +95,19 @@ struct mptcp_out_options {
>  #endif
>  };
>  
> +#define MPTCP_SCHED_NAME_MAX 16
> +
> +struct mptcp_sched_ops {
> +	struct sock *(*get_subflow)(struct mptcp_sock *msk, bool retrans);

May I suggest using "reinject" name instead of "retrans". To avoid
confusions, the RFC uses "reinjection" word when a packet was previously
sent to a different subflow and the goal is to reinject it to another
one. It is different from retransmitting the same packet over the same
subflow: TCP level retransmission with the same TCP seq num.

(same below + in other new functions, e.g. mptcp_get_subflow_default(),
mptcp_sched_get_subflow(), etc.)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
