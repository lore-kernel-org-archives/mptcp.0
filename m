Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D316F1867
	for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 16:44:54 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id ks6so4794764ejb.1
        for <mptcp@lists.linux.dev>; Wed, 20 Apr 2022 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=9Zaw5kuNfcm7m+MLhnzIeSUrB0wW1dmoDeBdQ4KCLYU=;
        b=U4Q5zkGAIee/Ygg/7z3bXpgIVpLpMXFLbP+hIuMPFskoy7BOmWYgpiisqwl9zu/jnR
         xRV9Lj1JQAOLZP4etsEQDlCM2CAcjEiikiZFH8sLepH0J3dNo1keesqRYqnpJLIn5aBC
         of6dnsskBtFWOTy6JG7CvDJ1zmyQNM2tTMqLPhRTiBsi0RwGDhTPBJLudM0Yy//cKrmG
         PZFh87tVQWoyc5TB20V5idyM2A8nitAy+xW9b6Ai8FkYIMESbFr4QE5Rc43R7mdg0MZf
         VluLsjQiVobiOt6pC7LBmC9t0Oh3/IHDb3eW5u5F1OZrwJjL96lCXeGx6E28rNUbJAmd
         r8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Zaw5kuNfcm7m+MLhnzIeSUrB0wW1dmoDeBdQ4KCLYU=;
        b=Sr8TR5/8uyivP/UajQIxgYeOH5wLw+jLgU0WIwBdvlauaTMxp+3lBkmJUYLkVs5IFC
         NnQkzVc7pfAYX//Lh58zQTACpP1gBB5b8e19L2KxTOT/NR6fakIBZu65k0Ydpy3aEoLe
         Ofq7zL7WgcoTz05JC8OPrvyyFX7FUkjKfzXwtK5xh07NrWfSpAgcOytIQZt6FYYE4NSV
         zK6amghn7GhtlrGL+T1YnJ+4Fu4Ps6N2OZab83SuY1CrOL2510FJ7i0XeI1i/Cqs1/gi
         ow9ckeV8BNj/9DiUPZTBWwvJmkyTtis43rFHW+IlBXfhHmrfM5Yp6Pl8P9MCYT0G18wc
         5tYg==
X-Gm-Message-State: AOAM5315kdIl967+VTC5zUQIOZnJlj3f2vB8C4EA0FNFokKWjjW8o5kr
	rig4dtiyIq/bvuUrLp9bseT3SQ==
X-Google-Smtp-Source: ABdhPJw8TmwsmBZ0bhlUWWmJRx/cejC0QgTZO9gAfOmNYroeK21IVkRz1dTwkf4xWpFFd1yYmhodPA==
X-Received: by 2002:a17:907:96a7:b0:6ef:f8db:218a with SMTP id hd39-20020a17090796a700b006eff8db218amr4676963ejc.532.1650473092819;
        Wed, 20 Apr 2022 09:44:52 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:a8ef:af16:f14e:5d01? ([2a02:578:8593:1200:a8ef:af16:f14e:5d01])
        by smtp.gmail.com with ESMTPSA id q22-20020a170906771600b006cf8a37ebf5sm6931765ejm.103.2022.04.20.09.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 09:44:52 -0700 (PDT)
Message-ID: <df590145-d72b-92a9-964d-fbfeb0b371f7@tessares.net>
Date: Wed, 20 Apr 2022 18:44:51 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v12 07/10] mptcp: add last_snd write access
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1650430388.git.geliang.tang@suse.com>
 <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 20/04/2022 06:57, Geliang Tang wrote:
> This patch exports the member last_snd of struct mptcp_sock in
> bpf_mptcp_helpers.h, and adds BPF write access to it.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/bpf.c                                 | 16 ++++++++++++++++
>  tools/testing/selftests/bpf/bpf_mptcp_helpers.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index e849fc3fb6c5..bd3c50b07ab2 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -40,6 +40,7 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
>  {
>  	const struct btf_type *state;
>  	u32 type_id;
> +	size_t end;
>  
>  	if (atype == BPF_READ)
>  		return btf_struct_access(log, btf, t, off, size, atype,
> @@ -55,6 +56,21 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
>  		return -EACCES;
>  	}
>  
> +	switch (off) {
> +	case offsetof(struct mptcp_sock, last_snd):
> +		end = offsetofend(struct mptcp_sock, last_snd);
> +		break;
> +	default:
> +		bpf_log(log, "no write support to mptcp_sock at off %d\n", off);
> +		return -EACCES;
> +	}
> +
> +	if (off + size > end) {
> +		bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %lu",
> +			off, size, end);

A small note about this line: the CI[1] seems to complain about it when
compiling in i386:

>   net/mptcp/bpf.c: In function 'bpf_mptcp_sched_btf_struct_access':
>   net/mptcp/bpf.c:69:71: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>      69 |   bpf_log(log, "access beyond mptcp_sock at off %u size %u ended at %lu",
>         |                                                                     ~~^
>         |                                                                       |
>         |                                                                       long unsigned int
>         |                                                                     %u
>      70 |    off, size, end);
>         |               ~~~                                                      
>         |               |
>         |               size_t {aka unsigned int}
>   cc1: all warnings being treated as errors

I think you need to use %zu.

https://github.com/multipath-tcp/mptcp_net-next/runs/6089328349?check_suite_focus=true

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
