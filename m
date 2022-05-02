Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7828E0
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651500582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIlVPTHUunFtkxqrQAc8RhtzPWekoeaeaJ/BzjN3dvM=;
	b=GkIXtxi6N8TahHVxTR9UBzwWiJ43A8dnSlQVgESm6r3ThWv1TeUdN+3moMBS7+s90iZyg2
	FXG/M1SK8Fx9Var9TjcZs5Y9DbwvCkAN+71yJ5rd6OBJV+v1Tywpbi2p9dLwNj1RikJA8y
	qvrhcbkgMBi1CTd5REzKfMYASni9VEU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-fOs9d3xSMyW20YzPxd8hzg-1; Mon, 02 May 2022 10:09:41 -0400
X-MC-Unique: fOs9d3xSMyW20YzPxd8hzg-1
Received: by mail-wr1-f72.google.com with SMTP id e21-20020adfa455000000b0020ae075cf35so5378015wra.11
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 07:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WIlVPTHUunFtkxqrQAc8RhtzPWekoeaeaJ/BzjN3dvM=;
        b=x0dQW7HtCbkTp39qD4pJjjCmkm/H54uARrXZm97nQKwl09WnY+0CZ0cfGxcbd9vC6A
         1gTeTjOcxlSje4r7exxo7kiO8csGJQB3mZUD7c7OFTcT9ZeNDzYl6wJea8NedohYeFPe
         SYM3FpleFUZEMyIlHjnY15e/Ik9QhMm/JfXgwLlsGQBqd5aNjGNA/fQTG1mQWtx4+KL7
         vR/26hg+kzQx4B945/7jCsZew4kArUfgf0bprOjYNowGtSdVk8Yr+LPqwEi5XF3AH10f
         0W4v3akmwPs3m+Sd7TOs60MgoZzEqz1k5/dvf3xweymVP9Xf7ZM7/QXIBViCN7oz5TU8
         6KoQ==
X-Gm-Message-State: AOAM531T8pMOYfeT+PyJa4ZBKm2Pj27hwdqqgzkftoog0TJ3geAGxUvo
	A5kAFTTGeE9vKiTx2+iK1zpLJt6e0L1uWfZItkXkez7/M6E6lK/DdcgV0SJk0TemHlxJPQqLuXJ
	2Fcs5YqDjwL5FSg4=
X-Received: by 2002:a05:600c:214e:b0:394:31c6:b66b with SMTP id v14-20020a05600c214e00b0039431c6b66bmr8012512wml.31.1651500579972;
        Mon, 02 May 2022 07:09:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLLMx7RI32sf61IpZtFoDO/BtkUJfIqQYnWsSnAOo2Kx722GlRLAJ5gyn/EWR8olZFId41+Q==
X-Received: by 2002:a05:600c:214e:b0:394:31c6:b66b with SMTP id v14-20020a05600c214e00b0039431c6b66bmr8012493wml.31.1651500579680;
        Mon, 02 May 2022 07:09:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id q22-20020a1cf316000000b003942a244f4csm6403482wmq.37.2022.05.02.07.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 07:09:39 -0700 (PDT)
Message-ID: <6d7ce54488bd5524f750c52cf2cfd7b0ff68eb40.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v18 5/7] mptcp: add bpf_mptcp_sched_ops
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Mon, 02 May 2022 16:09:38 +0200
In-Reply-To: <2ade81287c82a673c3e6f03d8700e8f77fcfc651.1651412613.git.geliang.tang@suse.com>
References: <cover.1651412613.git.geliang.tang@suse.com>
	 <2ade81287c82a673c3e6f03d8700e8f77fcfc651.1651412613.git.geliang.tang@suse.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Sun, 2022-05-01 at 21:48 +0800, Geliang Tang wrote:
> This patch implements a new struct bpf_struct_ops, bpf_mptcp_sched_ops.
> Register and unregister the bpf scheduler in .reg and .unreg.
> 
> This MPTCP BPF scheduler implementation is similar to BPF TCP CC. And
> net/ipv4/bpf_tcp_ca.c is a frame of reference for this patch.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  kernel/bpf/bpf_struct_ops_types.h |   4 +
>  net/mptcp/bpf.c                   | 154 ++++++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)
> 
> diff --git a/kernel/bpf/bpf_struct_ops_types.h b/kernel/bpf/bpf_struct_ops_types.h
> index 5678a9ddf817..5a6b0c0d8d3d 100644
> --- a/kernel/bpf/bpf_struct_ops_types.h
> +++ b/kernel/bpf/bpf_struct_ops_types.h
> @@ -8,5 +8,9 @@ BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
>  #ifdef CONFIG_INET
>  #include <net/tcp.h>
>  BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> +#ifdef CONFIG_MPTCP
> +#include <net/mptcp.h>
> +BPF_STRUCT_OPS_TYPE(mptcp_sched_ops)
> +#endif
>  #endif
>  #endif
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index 535602ba2582..ad770deb5a72 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -10,8 +10,162 @@
>  #define pr_fmt(fmt) "MPTCP: " fmt
>  
>  #include <linux/bpf.h>
> +#include <linux/bpf_verifier.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
>  #include "protocol.h"
>  
> +#ifdef CONFIG_BPF_JIT
> +extern struct bpf_struct_ops bpf_mptcp_sched_ops;
> +extern struct btf *btf_vmlinux;
> +static const struct btf_type *mptcp_sched_type __read_mostly;
> +static u32 mptcp_sched_id;
> +
> +static u32 optional_ops[] = {
> +	offsetof(struct mptcp_sched_ops, init),
> +	offsetof(struct mptcp_sched_ops, release),
> +	offsetof(struct mptcp_sched_ops, get_subflow),

I think that the 'get_subflow' member should not be options. Otherwise
the scheduler will useless, right ?!?

Otherwise LGTM.

Thanks!

Paolo

