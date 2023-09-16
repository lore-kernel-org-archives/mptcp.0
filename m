Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D469F2109
	for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 11:49:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31ff7535aa6so1221673f8f.0
        for <mptcp@lists.linux.dev>; Sat, 16 Sep 2023 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694864945; x=1695469745; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJhs20QAgAfYRPQJiJu26Y2Rso0POjK1FGZCSdR9fHE=;
        b=4CtUEwChenwUDNL9RiYMLluRYICLegj7HYKx39ZvdrAQIU6qQjV/H1mTTP1v3ypWH6
         5yeUMsmV0BTY19kbOzOfyz2z+1qsTEqFRiP8l8hMIVT+ZeKl+dj6wfpZ7nJwLedMrLFK
         73oq1FVDdFy568rn9sc/vtSklnaWs8ipsHWhNkCl0KqBXVj6GJt8suE46NqpJgV6HYaT
         HJlthzgjCQqIKVPkICV7kv7+oNJGdhymxb0bpC4gdDnk5wSfo3RnJK37TvJciOcYjB6i
         oc6IhIg1JWWiN7MP1Q1RULynBwAVN5LFXKbPHzv64CZP4JDetk9oTr38tpBgR5B3hqzF
         CJaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694864945; x=1695469745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJhs20QAgAfYRPQJiJu26Y2Rso0POjK1FGZCSdR9fHE=;
        b=cvV5ftR7zR2Aeuk5fOmfrsuzC+My8AaRG4iLU855svsVYYfvCAxcy4uv7C6DqFvSoi
         dBWWzVLnYjfRYnIWKLQ96NvAp0WLgOEdG/bHHnVIckyaEcNFqX20abGPweDDYIf7RYA7
         rYxU/xpSEHA5Az9pUgTLPl2hVFBj0aSvP+hv1O4fqKebY4QP6dProRu93OiCr9AgzGz2
         uwtHVl9Kb5peQRMc1ZKjkSgbJM4B8M80ddU+nKesOj5XSfMmGV7xHMhqE+Tsbb3mxAta
         iEzRpiZ0iIzBxIv8zAgY+WVlzfLlIceIe0BIQ7R/f0bH8atRAQLzs66XjMonOWiC0HyI
         kUyw==
X-Gm-Message-State: AOJu0Yx62EllHrQDPIeBQhiSfYZ9QV7XNOTde/aqLrAF9mxMkNEczhWB
	XU5krZhyymx8PZ86mDWXlBqN9Q==
X-Google-Smtp-Source: AGHT+IFnXqPEYrD5oGlZOhjqn6eiXshlX3BhHLHWRjlqXXiREcdKha3lFqQ5rVOg1cMpLHpWXixl3w==
X-Received: by 2002:adf:de90:0:b0:31f:a4fa:130a with SMTP id w16-20020adfde90000000b0031fa4fa130amr4436694wrl.14.1694864944902;
        Sat, 16 Sep 2023 04:49:04 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3867:6b1f:fd8b:a841? ([2a02:578:8593:1200:3867:6b1f:fd8b:a841])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d4dd0000000b0031c6cc74882sm6973645wru.107.2023.09.16.04.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 04:49:04 -0700 (PDT)
Message-ID: <d752c4cd-53af-4c7c-ab3a-6fdc7b80b23f@tessares.net>
Date: Sat, 16 Sep 2023 13:49:03 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 0/9] BPF packet scheduler updates part 4
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1693820153.git.geliang.tang@suse.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <cover.1693820153.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Mat,

On 04/09/2023 11:39, Geliang Tang wrote:
> v3:
>  - store burst in msk->snd_burst instead of in sk_storage.
>  - make mptcp_sched_data_set_contexts static.
>  - rename mptcp_subflow_ctx_by_pos to bpf_mptcp_subflow_ctx_by_pos, and
>    add "__bpf_kfunc" before it.
> 
> v2:
>  - keep sched API unchanged.
>  - use bpf_sk_storage_lookup to get snd_burst from BPF context.
>  - applied after "add bpf_stale scheduler v3" serise.
> 
> v1:
> 
> There's a bug in bpf_burst. snd_burst stored in mptcp_burst_storage in
> BPF context is not used. msk->snd_burst is still used in kernel space.
> To fix this, add two new interfaces in mptcp_sched_ops to get and set
> scheduler's paramters from BPF context to kernel space.

Thank you for the patches and the review!

I just applied these patches in our tree. Please make sure I correctly
fix the different conflicts and I didn't miss any instructions.

New patches for t/upstream:
- 5eed4d815c41: "squashed" patch 1/9 in "bpf: Export more bpf_burst
related functions"
- 764bf652d4bf: "squashed" patch 2/9 (with conflicts) in "mptcp: add
sched_data helpers"
- 9906c014e61a: "squashed" patch 3/9 in "bpf: Add bpf_mptcp_sched_ops"
- 816a6f2cad25: conflict in t/bpf-Add-bpf_mptcp_sched_kfunc_set
- ff8a0c543074: "squashed" patch 4/9 (with conflicts) in "selftests/bpf:
Add mptcp sched structs"
- a0098f3f355d: "squashed" patch 5/9 in "selftests/bpf: Add bpf_first
scheduler"
- d9c7f7c37051: "squashed" patch 6/9 in "selftests/bpf: Add bpf_bkup
scheduler"
- 2e2e1a1bfb70: conflict in t/selftests-bpf-Add-bpf_rr-scheduler
- 6c22024f0008: "squashed" patch 7/9 in "selftests/bpf: Add bpf_rr
scheduler"
- 684e5a0e4824: "squashed" patch 8/9 in "selftests/bpf: Add bpf_red
scheduler"
- 6b458f5734d3: conflict in t/bpf-Export-more-bpf_burst-related-functions
- 24d78ea20a36: "squashed" patch 9/9 in "selftests/bpf: Add bpf_burst
scheduler"
- Results: 6b6b68bc221b..fe720f4b5da8 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20230916T114711

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
