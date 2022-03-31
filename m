Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE0E7E0
	for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 13:26:52 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id bi12so48188457ejb.3
        for <mptcp@lists.linux.dev>; Thu, 31 Mar 2022 06:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ed578Dst+v1c6V9JqglZt6RfMiyRB6RyoSaIGXBJ7z8=;
        b=sUkW6L1DsgMW/nbsYFhH+vhToQOCttHVD3bvDeMDFK0m9AzL7tL4o324/bDzKypjd2
         z05t9R6oEDSbywoC70b1SK4JYkzZR9/NnZBKTug52BdWKnllMoyjrptcls+btGlDi/+D
         BHKJuyyvVWdEg5UiJySCJ6t/F0EQa/RtFHdJqBS1HCdRm6/sHGzERIw4nyaqhjFt06cO
         NWAJz84M+sEzZ45OCoBmd0L7CqEZtfyYOlKHVLx2XLDjTxzTUoilNyoNg+0URsJF+Z04
         dwOXjVgDM9De7xS6YUWgrbc1Jt9N107OFfR74eyAkVUVmhw3xZIsWZZ0G6U2eoU4/Fv6
         zsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ed578Dst+v1c6V9JqglZt6RfMiyRB6RyoSaIGXBJ7z8=;
        b=CUJUA/jHZJsqHBy4DgyAk2fnfg1DjqSyeVz36zaM2bWo2hm95rKDWm7M8A2bAeVmJ+
         1JjspQI1pspvwmjzqQWTaZ53XC8jGVlEoPDhjpJrbr8FljRwBqr8qStmd3pS7Ej8vK8q
         tjsNt6R6m0gIKW8K+22LBFS0OjpwTypzlG/QauVoxvzfPZphjB7Qz9G8/O2cZcXgRkDA
         It+JkW14F6K204cVwPeuD9Hjt4kniJ4eDw7FG7PT6ON3RVW7htdVkKPNtqgxtzLsMPSi
         DuLTl5KHs0urkwIKnI2KXfSdOFr+CuB5/hsADZisp5KMYo3cW14iX98F+HsqdQToh8Lx
         ehvA==
X-Gm-Message-State: AOAM5313NoKtLMkyXOyNgP68bD8LVV/Hetfr5hOwQqsUufq875XwXTt/
	tdwHqftUBtrOlP8hQkpk3jFXX2VC7ClTBA==
X-Google-Smtp-Source: ABdhPJxYVWqy07jhWZlLnq0912Sc5JaMmg/hWisH7E2Ltnnua6ySF/Fesf/VHGG8FNENBKHF6zbzlQ==
X-Received: by 2002:a17:906:2a0c:b0:6df:ec76:af8c with SMTP id j12-20020a1709062a0c00b006dfec76af8cmr4889738eje.269.1648733210396;
        Thu, 31 Mar 2022 06:26:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:67bb:4772:e0be:4bc4? ([2a02:578:8593:1200:67bb:4772:e0be:4bc4])
        by smtp.gmail.com with ESMTPSA id d1-20020a50fe81000000b004197f2ecdc2sm11163356edt.89.2022.03.31.06.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 06:26:49 -0700 (PDT)
Message-ID: <24f4964d-43d2-463a-1219-b5f28c9fd409@tessares.net>
Date: Thu, 31 Mar 2022 15:26:49 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next] Squash to "selftests: bpf: add MPTCP test
 base"
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <edcb9bcf557a7205a8301f755688dcbc22b279e6.1648714427.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <edcb9bcf557a7205a8301f755688dcbc22b279e6.1648714427.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 31/03/2022 10:14, Geliang Tang wrote:
> Update newly added files in MAINTAINERS.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d91f6c6e3d3b..778cbf7c5a3b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13745,6 +13745,8 @@ F:	include/net/mptcp.h
>  F:	include/trace/events/mptcp.h
>  F:	include/uapi/linux/mptcp.h
>  F:	net/mptcp/
> +F:	tools/testing/selftests/bpf/progs/mptcp_sock.c
> +F:	tools/testing/selftests/bpf/prog_tests/mptcp.c

Thank you for the patch. I applied it a bit differently:

  tools/testing/selftests/bpf/*/*mptcp*.c

See commit 4a7ea84d46b3 ("MAINTAINERS: add MPTCP-specific BPF files"),
being published soon.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
