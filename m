Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A6322A
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 14:28:35 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id ud5so34218704ejc.4
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 06:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Zt7dGt6i3jN1vkTDQAwO0Ste6Wv+USUNACY12g/r14=;
        b=NfMNYxj8MuKEBHzEsvf1x3qInrRon9r18dBLp7MtNvD1xl54smlYUgaze5inKK7knl
         m+Yu0fDDeTYVe5sK+P8PEZffi+7EqOMkvj74y+yM6VIyR1XPBVl328F8Va1atbzzlqoe
         nHxfHkSNtAuO6tfzKYlHUAy+dQLbhbSNkLYO15cwsZIA1L9zeT5QLwgoiDGCQSDBVxnm
         kw3WKjErzKU81t+gjcTLjEdfj+ki09YxBGpDD0eYeYI8bPoVi8oU9hGC2ntmre2sH+EC
         xVcslPRMS+cCYk4KZ7V0uoissad/Lgsf3jKd58WktNk2vYHj2OQWctd2bUWRe0G7+gTG
         fBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zt7dGt6i3jN1vkTDQAwO0Ste6Wv+USUNACY12g/r14=;
        b=w2e2etv0S+Z7lv1D43YyeDoffmmxA1j54PBYeZMiHRlQVR7ImMgea38+jBOQ/BXNNi
         cBJtpJtvUOxDtpfX77BANqf6w/SOxVfz70UNmSkQKY9HjZAHynCMlu7QQA1816ovrBrI
         Rx15ngs+USbDg4stdwjQgLkj+41q7G1bUOaKA2qBGku8stQOLO5hPqOYam5SuK3f8TBh
         j4USZCp6mtCmmqMaeXTDiRiHp9taZh7EyA0LgF6HyoANtf4EUWg7CBuY5gadBUgcBwGP
         xaj2p3KNJLkEv9q88Ez0/qSLQuWF2EO3hb3sbQgNAIvbqrG4e03I4et3NIp4Zd3/p8wn
         cj/w==
X-Gm-Message-State: ANoB5pnsLMmNhHG4qIRIHLtKyjat55+jdgCLcOQD6v7iMl8vjz82IQ7A
	Wti4aM9b+dFqLvCn7CqoYp5RRTs7oxW81sdj
X-Google-Smtp-Source: AA0mqf77fZsCru1WczLYQsM2nf/BPr0oEvzImlM8v/pTy452Ya6aGalRoEuNBxkZo6H/dUKnMurFrQ==
X-Received: by 2002:a17:906:2a85:b0:7ad:cc9f:4ae0 with SMTP id l5-20020a1709062a8500b007adcc9f4ae0mr46278098eje.504.1669732113514;
        Tue, 29 Nov 2022 06:28:33 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:3be0:1872:32a:ea75? ([2a02:578:8593:1200:3be0:1872:32a:ea75])
        by smtp.gmail.com with ESMTPSA id j9-20020a1709066dc900b007ba46867e6asm6328458ejt.16.2022.11.29.06.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:28:33 -0800 (PST)
Message-ID: <37d76d5a-a034-2dac-b152-e9c4ce916f29@tessares.net>
Date: Tue, 29 Nov 2022 15:28:32 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next] Squash-to "bpf: Add bpf_mptcp_sched_ops"
Content-Language: en-GB
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>
References: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 29/11/2022 15:20, Matthieu Baerts wrote:
> The BPF API around btf_struct_access() has been modified recently, see
> commit 6728aea7216c ("bpf: Refactor btf_struct_access").
> 
> Adaptations have been done, similar to what was done in the mentioned
> commit, e.g. by looking at changes around bpf_tcp_ca_btf_struct_access().
> 
> Without this modification, we have compilation errors:

(...)

> Fixes: 6728aea7216c ("bpf: Refactor btf_struct_access")
> Link: https://cirrus-ci.com/task/5509843558072320?logs=test#L3300-L3262
> Cc: Geliang Tang <geliang.tang@suse.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> 
> Notes:
>     I suggest not to wait before applying this patch to be able to continue
>     compiling and validating the export branch.

As suggested, I just applied it:

- 3c77cc8397df: "squashed" in "bpf: Add bpf_mptcp_sched_ops"
- Results: 8c1a5e594de5..2f61edcc034c (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20221129T142751

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
