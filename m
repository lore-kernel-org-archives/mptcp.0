Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3E47F6
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 10:07:48 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id c10so28614444ejs.13
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kfN2Cuxk3em8yzuVp7MfRis066Wi2zuvWXcL/HRCblQ=;
        b=bTGDjPAyviYsI/aPmJcko7gAlXXFNYVKPf4w9lmYd33CLXaWVphRAHG2RO5IbEb95u
         oywMRwzh68mSnuLHVfdBqGNH3Oa8HczAsfpgRy22CxyhbtF5NArYlnDR+j9cCk1ywIEN
         bTN5Gnnmv4bxctglOaAw7O7z12x2RuJ3UDyH8VVnnpR/EpyAkUHy0wXQzF4+2s0Fqxgu
         dGPl48HFTN+jXtFuSayD9qQq2AeKwxo/krXUhZIyfT+fAyvWVomjY91f2TZW25fD7Pw4
         o1fEBCvaYZ2JLct62hxGEVDJuemt89jdgxt9oSkI60TWBgTltkWlFTsKLdBeeM8LDA0o
         llVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kfN2Cuxk3em8yzuVp7MfRis066Wi2zuvWXcL/HRCblQ=;
        b=b2a/RkqV42y8XQKAQkXo58MOr/tkLE3iYXsSN3rdDWzt12O5Z4GDUN8PH8TD8y/5M2
         nMul2Y6cMhIIu9lx0fKKnMeFUi7Iwp7sqvjBMuOEE8k9+PlE8HUirWlcvMwpXwhCj+G7
         +bEEEFaMoaox3C1xBV1ifhuGlHhX0zroPEnmRTShzyaPUOgXALmFIUkkyzkPx3fUsjlm
         z1TTNOUE1eUwvz2sPhfu+mi0fMxjmp0gdRpg5lpZ3ZKPLJaAw0NUy7oNSfVthHJN7XDH
         U0f2aB8DaMtD0ss1uArqshGajLMO0tjyUWZskkLptCb9xie1FC226nUIiRAHypasRS87
         VESQ==
X-Gm-Message-State: AOAM532G05vnmaaDl/srj0SYH0asuQXZkUH68Tekjkdy/XIgAvTukSii
	KviG2SxCtXlaF9jxAHzoU8vcuw==
X-Google-Smtp-Source: ABdhPJzP641yvwZ0J/RIs+WdEZt0VfTfZS81lZs7dsWiadPN0gzFjIJwCuO5s8W80+HsTnfHdLLaUA==
X-Received: by 2002:a17:906:c10d:b0:6e0:dc2a:338d with SMTP id do13-20020a170906c10d00b006e0dc2a338dmr4220452ejc.538.1648721266875;
        Thu, 31 Mar 2022 03:07:46 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm9008833ejl.185.2022.03.31.03.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 03:07:46 -0700 (PDT)
Message-ID: <7fb77cd5-4d97-0697-d88f-f20348a79347@tessares.net>
Date: Thu, 31 Mar 2022 12:07:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add bpf_first
 scheduler v8"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <e6bb3c020929be2e6a41ef994e740eafe7fedce9.1648714973.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <e6bb3c020929be2e6a41ef994e740eafe7fedce9.1648714973.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2022 10:23, Geliang Tang wrote:
> - Move mptcp_sched_ops to bpf_mptcp_helpers.h.
> - Update MAINTAINERS.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  MAINTAINERS                                         |  1 +
>  tools/testing/selftests/bpf/bpf_mptcp_helpers.h     | 12 ++++++++++++
>  tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 12 ------------
>  tools/testing/selftests/bpf/progs/mptcp_bpf_first.c |  2 +-
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40a62dc29e31..852e21ca47f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13746,6 +13746,7 @@ F:	include/trace/events/mptcp.h
>  F:	include/uapi/linux/mptcp.h
>  F:	net/mptcp/
>  F:	tools/testing/selftests/bpf/bpf_mptcp_helpers.h
> +F:	tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
>  F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
>  F:	tools/testing/selftests/bpf/prog_tests/mptcp.c

Maybe we should start using '*' to avoid having to update this file all
the time :)

  tools/testing/selftests/bpf/bpf_mptcp_helpers.h
  tools/testing/selftests/bpf/*/*mptcp*.[ch]

WDYT?

I know in 2020, we didn't list these files here not knowing who would be
"officially" maintaining them. But I guess it is best to list them here
to be notified when they are modified.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
