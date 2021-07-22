Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0DB168
	for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 16:40:24 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id hr1so9325374ejc.1
        for <mptcp@lists.linux.dev>; Thu, 22 Jul 2021 09:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:references:from:cc:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=15iA/EdkIKwpuRmZR+N1Gq3vF4SjEZlCommuDdvmch8=;
        b=0lFL0Q2ze6cr+DHXarHNdsdjtNEGsSJJlWY7fRymGslTSP/7uqLZk691TKsBqW9h6p
         KqsZAoInEamDgSz+acFCr9Fc3TIDOLsC4JaYOCWBmDxR/NW54HOUPdZhki+2nv30FDhR
         5qVTQ1FrqMMr5s4PcXFNg+EVqz288GptQHSNKiIezreMpIBinSU21hVjid+8+7kVLMqi
         jESrldeQ1AhVVLyCkCOsEXxg+nxvBpNbtppC77yiZJII3AoxVuR+iR33SqTDaioLXtC0
         Ys9ROsGpGYnTaF95zhD7TZj5iXvbodwgicEraLwgP5EvDAhD0mUgTfPbtKJxjCBlcYxo
         HeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:cc:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=15iA/EdkIKwpuRmZR+N1Gq3vF4SjEZlCommuDdvmch8=;
        b=G59Mar1k3v/zq3os+U+CZpAiGVIro5ncV0GTioh3Ffvuq49eqluYnDdofyCKE5iWbJ
         YaJSbJcHMht8FA423nFe2FJfo4mYJe1G4HSL40gtruVW1l82jPgF6+dkU+4KjAey8SZl
         2aJzO9Ltg1rubhCXL2u6FWvQp+E1l849qJmH2pMWO720QJ5PGzulWDdKDXxi1dK5Nkfi
         xtwqcAJcKy79EabN0LHeQzsisDOVfBUzPDXftIWLlcAfrHOWOObZILCeX+LQ4ceWiKZI
         mxi5qKD8XP7An3sL/zyv1Jg4JSccEje3TV7hYM4sD4tpZJibudIyzH4VMz0egnqKFW/I
         P7tA==
X-Gm-Message-State: AOAM533d6QLKlQg7Zo0JRV1ZYe0zUfHEN6gUft0XbPOUq2GwjBOGVIe6
	z5miW/2mq5H+eqD1Kf1FsrXaZS3sVTgP0u8FZ2c=
X-Google-Smtp-Source: ABdhPJysbwi+TrKuBpuIiROGhf+gipnHwYC9dJ2MtSjBtx8lI5H7wgSfMK+6M0ZL32lOVwimDqe0MQ==
X-Received: by 2002:a17:906:2bd4:: with SMTP id n20mr760978ejg.390.1626972022396;
        Thu, 22 Jul 2021 09:40:22 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:a2dc:f69d:fe16:9f4e])
        by smtp.gmail.com with ESMTPSA id e24sm9612527ejx.100.2021.07.22.09.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 09:40:22 -0700 (PDT)
To: Florian Westphal <fw@strlen.de>
References: <20210722150154.10608-1-fw@strlen.de>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Subject: Re: [RFC] mptcp: add MPTCP_INFO getsockopt
Message-ID: <ff3627c3-7e0d-b374-3532-a5d93f7455af@tessares.net>
Date: Thu, 22 Jul 2021 18:40:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210722150154.10608-1-fw@strlen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Florian,

Thank you for looking at that!

On 22/07/2021 17:01, Florian Westphal wrote:
> Its not compatible with mptcp.org kernel one:
> 1. mptcp.org defines 'struct mptcp_info', but we already have this for
>    inet_diag.
> 
> 2. 'struct mptcp_info', as defined by mptcp.org has different layout for
>    32/64 bit arches.
>    This is a problem for 32bit binaries on 64bit kernels.
> 
> For those reasons a new 'struct mptcp_info_opt' is added which contains
> aligned_u64 fields to store the userspace buffer addresses.

Thank you for the explanation, it makes sense!

> 'struct mptcp_sub_info' is added as per mptcp.org kernel, but I don't
> like this structure.  I think 'src' and 'dst' are confusing terms.

Do you prefer 'local' and 'remote'?
Good time to change!

> AFAICS 'src' really is 'local address' (getsockname) and 'dst' is peer
> (getpeername).
> 
> Given mptcp-next has IPPROTO_MPTCP, this adds SOL_MPTCP.
> This also gives ample space to add mptcp specific sockopts.

Very good idea!

> In light of this, I wonder if it would make more sense to split the
> functionality.

Would it not start to be a bit costly to get all details if the
userspace has do a few syscalls?
- general info
- get subflow IDs
- for each suflow, call subflow info + peer/sock names

With the full structure, we could eventually allow userspace programs to
set some "*_len" members to 0 not to get all info, e.g. only get the
general info without peer/sock names for all subflows. Or without
TCP_INFO for each subflow. No?

> 
> Examples:
> 
> getsockopt(fd, SOL_MPTCP, SUBFLOW_ID, subflow_ids, &count);
> 
> sa.sa_family = subflow_ids[0];
> getsockopt(fd, SOL_MPTCP, SUBFLOW_GETPEERNAME, &sa, &len);
> ..
> sa.sa_family = subflow_ids[0];
> getsockopt(fd, SOL_MPTCP, SUBFLOW_GETSOCKNAME, &sa, &len);
> 
> tcp_info.tcpi_state = subflow_ids[0];
> getsockopt(fd, SOL_MPTCP, SUBFLOW_TCP_INFO, &tcp_info, &len);
> 
> ...
> 
> and so on.

This could be interesting if there is a demand to get info only for some
specific subflows :)

> 
> Alternatively one could overload e.g. the upper 8 bit:
> 
> getsockopt(fd, SOL_MPTCP, subflow_ids[0] << 24 | SUBFLOW_FOO, ...);

Maybe a "cleaner" workaround to set the ID? :)

> In any case, here is a tentative patch to add a mptcp.org-alike
> MPTCP_INFO getsockopt.

Thank you for sharing that!

(I didn't check the code yet)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
