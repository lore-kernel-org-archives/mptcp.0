Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADD1866
	for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 12:48:45 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id h1so1722662edj.1
        for <mptcp@lists.linux.dev>; Wed, 23 Mar 2022 05:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=uLwAfs96DUZkgg6CbdUu7PmVs9Aa5xzp1NMna189Rxo=;
        b=JO/46l5Pn7NhygeekX4IpubOHiqKIbowGhmhuB4dmgXh7tzNTSaAfFghGX5twy8IHd
         /WFJiuvFPPELJjl0dravjrIpE0E6ntkjC5VNH+hVSbUTdXPVFY6p5Rot4JWuOO5+iJvm
         3D8xKmeesWr1bwxEkJ+QaCLYAGFEwKl0SghjOXHmn5chBY4N3CT2lC6bPuPTIO3/99Lc
         IpYaLrUZ25dcUAwalgkJ/9sRkZKOwiRFEFf+HYOxB8aat8GIVW5z4GNP7UhE6b0CaX59
         k+Gt5A8ooaXAn24ZjkZ1Ydi65pbgPaZfTv3OuDRNpfwS/Bx67NMHtM4A04j7oamQvExE
         cb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uLwAfs96DUZkgg6CbdUu7PmVs9Aa5xzp1NMna189Rxo=;
        b=K16kdLTk2F+a7pETx3fIMwhzyVIz1tXAuRWPx8Al4U1FJUqN8Yv4d8kAE5gm1Eudk+
         714UNMyj5rf+3WSOQkEOTjHiLgnnI+0fCc09gpGv/DIQb95YBOqYaVlMmlX1MLD5ahec
         MqfURrXWFy4mhj6WWFuBZs1zK9nxyGTnllgZACKdlR1p1s4NTpPiXNxP/y7cACAlyM0L
         6R6+UASWExQm7HmKJbKormmzJ3yfbwvQUA8FMxXrH77O/nocxwN8FO4P6RABAJb0tXXj
         Kmxu1/AD6XJBiTteM55WW4OU+L0Qv4szPCKmw8pgJv2wRU+D6JSEPqWvVXePoPpMBAJ3
         A9zg==
X-Gm-Message-State: AOAM532MzYfdwcyN+95OeN8yEvrpquFWBAGnbVS1zOIlY3REVABJ3Rmn
	LknZAfaU1ewT/fIrAQ9iYoYL1v+mdy4nnDsm
X-Google-Smtp-Source: ABdhPJyWO+Vx+4MSryq1ZQvuor1wKLNyLbz1ThP6F8u7Cg4NDIIgtkfVHEk90zFzlvAjkpU/RC1A4w==
X-Received: by 2002:a50:9b4f:0:b0:419:49af:429c with SMTP id a15-20020a509b4f000000b0041949af429cmr15158788edj.276.1648039723406;
        Wed, 23 Mar 2022 05:48:43 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:bcec:deb8:e83:5d9a? ([2a02:578:8593:1200:bcec:deb8:e83:5d9a])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709066b8200b006bbea7e566esm9689558ejr.55.2022.03.23.05.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 05:48:42 -0700 (PDT)
Message-ID: <2a05164c-4247-af3f-a3d7-19153314a64a@tessares.net>
Date: Wed, 23 Mar 2022 13:48:42 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH mptcp-next v11 0/7] add skc_to_mptcp_sock
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1648025307.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cover.1648025307.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 23/03/2022 10:09, Geliang Tang wrote:
> v11:
>  - merge "check more values from mptcp_sock" series into this series.
>  - patch 2:
>    - rebased.
>  - patch 3:
>    - rebased.
>    - add 'Copyright' entry as Matt suggested in v9:
>    https://patchwork.kernel.org/project/mptcp/patch/d6d33be9899118c5f542a6ce43f868d4e9e2766b.1646745228.git.geliang.tang@suse.com/
>  - patch 4:
>    - add test__start_subtest.
>    - add some 'Copyright' entries.
>  - patch 5:
>    - change monitor_log_path to static
>    - drop bpf_trace_printk()
>  - patch 6:
>    - use TCP_CA_NAME_MAX instead of strlen(val.ca_name) in strncmp().
>    - use 'sysctl -b net.ipv4.tcp_congestion_control' to get ca_name.

Thank you for the v11 and your patience!

I already applied the two first patches because they have already been
reviewed before and they were causing conflicts with latest BPF changes:

- 83c2e9333801: "squashed" patch 1/7 in "selftests: bpf: add
bpf_mptcp_sock() verifier tests"
- 3e1cf22ec63a: "squashed" patch 2/7 in "bpf: add 'bpf_mptcp_sock'
structure and helper"
- Results: 170b2a907bd7..b3fcb6331ff3 (export)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
