Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE5F71
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 18:25:01 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id s15so50492868edd.4
        for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oEec09zBLanYyKuVU13xdn0Ly+JfsfiOkrN9MielukI=;
        b=hMajEO+Sbu9HGPrquo8LYzefvTgsqDKPCU6pF5aR2j+wmgijQkysAWucpZWOavFP0W
         gLitfwZUNFo4/oPKM7ymizD0o0Zz+hqmk/8ky8aU0D9ghgApRHBOFL7mewAJ3tLXKqXX
         8QXuuNUZiEYlT2tsxFfXFWgWsZmdGKpj2dH091X5WdUUaA1n03vJSFCO9QEnPQo57yWz
         wk0XTr9rOcffJWkVH+efYGizxPjmk1tPEa1tNWnsQaKC4EoVz3Kj2ELQj5advME4U3cw
         8VhgQ9oiQ7UdOetDx1DY+pJwiP5wGORighP/G2jlGuxkm1Xw2RUK7XzTzoxC2bSCMLTv
         wdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oEec09zBLanYyKuVU13xdn0Ly+JfsfiOkrN9MielukI=;
        b=BaA9luldxM8v9ifP37AcAVuozgVRQhOx3Oy9ID/uRUeepmGlWwRFeRtuMG92VQputw
         m1mg3LqW0gRl75kq8VAqAtGZSZ3x3ECOVkBlzpNOF5eDu1XGOTJEynBecI0uVxg5vFu7
         T4xsaY6Vt37PAuJtXO9Ap2+UqAHJwPdPPkTErEK0FF5GOm/NqDJNAl1g1Ep+1/1rmKrQ
         Szm/Zh17RcdjLv2t204e2ymUui4RrjTI0IgKKC5QjsLAX3WXYmQXluLTY6UYuuKmeZoI
         1f98Muzs2MMMlzP/zsC4l58KIpeGpJbuNtej7KjsYA83VNp4pKGxPu2KPmUwUrOk2Djs
         ZCgA==
X-Gm-Message-State: AOAM532DfMyQa47t9g6Hta2ZT4CnnSfZ7hFxdwcq2UuTIpzJY3fs+4RL
	qMHGMeE0hI9JFMjyRHcmA5w4ERDd82Wmo7yq
X-Google-Smtp-Source: ABdhPJy9GuTbCrp5KvhCTYvpsNQZNv9KKKOew5Ky7t/4k11ZDxAHLPN6GYVRULtbtoCdHYIe/co68w==
X-Received: by 2002:a05:6402:17a8:: with SMTP id j8mr31255174edy.43.1619029499917;
        Wed, 21 Apr 2021 11:24:59 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:708a:41af:f01e:2dd])
        by smtp.gmail.com with ESMTPSA id i19sm141384eds.39.2021.04.21.11.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 11:24:59 -0700 (PDT)
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: pabeni@redhat.com, mptcp@lists.linux.dev
References: <20210421153805.210668-1-mathew.j.martineau@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2] mptcp: Retransmit DATA_FIN
Message-ID: <9c36342d-cce9-3883-3cbc-17ebb20a4c64@tessares.net>
Date: Wed, 21 Apr 2021 20:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20210421153805.210668-1-mathew.j.martineau@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Mat,

On 21/04/2021 17:38, Mat Martineau wrote:
> With this change, the MPTCP-level retransmission timer is used to resend
> DATA_FIN. The retranmit timer is not stopped while waiting for a
> MPTCP-level ACK of DATA_FIN, and retransmitted DATA_FINs are sent on all
> subflows. The retry interval starts at TCP_RTO_MIN and then doubles on
> each attempt, up to TCP_RTO_MAX.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/146
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
> 
> v2: Simplify timeout limits, move function to avoid -net conflict
> 
> v1: Add backoff
> 
> Paolo and Matthieu mentioned sending to -net instead of net-next on IRC,
> I will test out on that branch too.

Thank you for the patch!

As discussed on IRC, I just applied this patch in our tree without
Paolo's ACK. It seems you correctly addressed all the comments so no
need to wait. We can apply some squash-to patches later if needed.

- 7137c5d18e29: mptcp: Retransmit DATA_FIN
- Results: 5eaa9f1d555d..c5409d6a14e5

Builds and tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20210421T181432
https://github.com/multipath-tcp/mptcp_net-next/actions/workflows/build-validation.yml?query=branch:export/20210421T181432

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
