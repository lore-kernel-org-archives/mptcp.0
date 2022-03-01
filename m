Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE805A12
	for <mptcp@lists.linux.dev>; Tue,  1 Mar 2022 11:56:10 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id f8so9507773edf.10
        for <mptcp@lists.linux.dev>; Tue, 01 Mar 2022 03:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=JTrqtbARBYo1c1TSvHPt+LVFDsIm76P9PPkUEUCZ1KU=;
        b=30HLySXUj0IGMbsOHGA47CcJD3LH7u9XicBA3ROfqMbCDmijdagmkIFD+1senHUcNY
         94L1miW7gEwVEat9/oAPKKA0boaO8ghwBuKZ3hO4tSU4CdNPA6dKAqVWLrTEVXoCyDmf
         sB6GXR+UOquwxyP1FSRkKz2BhLKC0v/IXuDRh4NXFc0LsgXOrxrH+8PWhjYaJZA6UXDf
         EAAl/VzHPiq5GN/JyCK2y4XKjmFTtOA1PW5hblPbaJKh+j0O3khgVmV/fpfCaTqBMr+P
         RLe0y+juO0lDKJVi9PmamKZcnvkl6b/dRjejhReR0Nc94VouAZYsxejGlVxaLlv2nQR2
         +fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JTrqtbARBYo1c1TSvHPt+LVFDsIm76P9PPkUEUCZ1KU=;
        b=wiY7DoyAk3XiZpC71DzOAoKJiL4lKQaQ2x5yf4Wc7ParOlnzX5c4fWTJ9ntEiPJzZR
         b2Bt3SqYKRTvYHJu/pcEnm93DRJbbeTcZwHccFAs/AoM9AUQvBPaho7mK4s+YXnhbBqU
         WRcChZ+VGKfXUbLNzf+usfXR8MJNvR6wIUqekU80FijP+i5+7Z0FmxrRrXPYieIFpZ8M
         ttufPsW1SfRo/cW8qawt7UFRPWyM7okYzLCRt8pNf0atsAfgSuazWn83Nmy3N7rU+7AE
         xhJC2eftxaJOFhJUGEOeBgq04+QpBg3y4PBObKlCkcxQcTam0CO1ToLx3agmyJXhvEAz
         3U6w==
X-Gm-Message-State: AOAM5318AgiQSBy/7KPtUtDyt3i5kxkrSY+FqQ/7HoOXIpkeKtW/Xtfg
	UkV+nQc3QQSGD5yEWW04a0knFQZBuS7r+Fbe
X-Google-Smtp-Source: ABdhPJxVW96Ucl5g9Tg64jCPEV2QqIt2y9F6dorodKIDXPk0EPGLCPpdAsrKPJIAl3aqVNm6gEIXwA==
X-Received: by 2002:a05:6402:4414:b0:408:4dc0:3ee9 with SMTP id y20-20020a056402441400b004084dc03ee9mr24004608eda.203.1646135769087;
        Tue, 01 Mar 2022 03:56:09 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:9adc:7cd9:4239:a8d7? ([2a02:578:8593:1200:9adc:7cd9:4239:a8d7])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b00412e1a73c7bsm7014288edy.61.2022.03.01.03.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 03:56:08 -0800 (PST)
Message-ID: <16274837-34e1-f382-91cd-6f646722c7c8@tessares.net>
Date: Tue, 1 Mar 2022 12:56:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH mptcp-next] selftests: bpf: exercise bpf_mptcp_sock()
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <4561ea0907db7c1db98a7c6d90f831ee337da5c5.1645716043.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/02/2022 16:21, Geliang Tang wrote:
> This patch extended the MPTCP test base, to exercise bpf_mptcp_sock() from
> C test as Alexei suggested in [1].

Thank you for this patch!

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 04aef0f147dc..eba1b6d12a8c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -6,6 +6,7 @@
>  struct mptcp_storage {
>  	__u32 invoked;
>  	__u32 is_mptcp;
> +	__u32 token;
>  };
>  
>  static int verify_sk(int map_fd, int client_fd, const char *msg, __u32 is_mptcp)

Do you think we could verify that the token has been properly read and
stored here? I know there were some limitations but probably we can work
around them, no? We could store items on the msk and not the ssk for
MPTCP connections, would that not help?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
