Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8919D185E
	for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 10:36:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id gr7so5766753ejb.5
        for <mptcp@lists.linux.dev>; Mon, 30 Jan 2023 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjnp2B7Yi43iYzfkobJY21EmaNEzSfNQNY8RNWkvuBE=;
        b=7e+/XrWkZSUvOq2rEhpblX8mPDc4VX1nZIMOTAfiGvoZqnOnMFNEIViCFI8sL/m6HG
         ZjnP5tZnczZaldS5ho4fhV+g9tn0ZAxfrqhpTbvOXUfmOn7PHElbZKw9/3MOSJYwziuu
         D74PaeSBxF74coBhrgyIPJN62RsqotRwRlcdDNxtTZCgNFMtrJlKr4LoK9OeOoXE8MIe
         MZH0VzejmYlwPai83K7fAh4LZSQ874bN7517CK0jdZ9E6w/yoNIS0p7+4Bp76S5nebip
         +6FDuTNGskEXQgm6LhdhEBnKQJajxFPCIbcV+Af0j0sAIQZwsLEeb+zkw5Ef8RdDnjXW
         Eiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fjnp2B7Yi43iYzfkobJY21EmaNEzSfNQNY8RNWkvuBE=;
        b=DFNcGg0CCMZ6rQykd5enUi9HXGRYYnIQrENHcv+kpQOxX3C+V8rgdB/J6yUMI8ze4L
         Ag6r7P1vtSAC1z3n/A6rOCJZaS+UBvB1HR7aTRuoNS3M0WNF7VgGZ8qlTM0RYNAQdFKa
         N+FtbDKMfXW4ipjE9sNKL+STy39n7oHSF/FKWfK988V1rGmmfb5SAypsgwTK43UueS3/
         TB1KYhUIBqHIpyrWjqWC5opjP4K9DYvJbq/B16P0S1iSGq0vuwaGDZJoUVQU+8pC4U+K
         8mvYXse1qznizBoC3HDNOv68oEGWuZ1/BNz1R9Z0awAqn2lrd8dHLYjlXbSz1tsNxEE7
         wAWg==
X-Gm-Message-State: AFqh2kprakJKo1cAPd1xACCTPHsOKLTTSsbM/EqKkZyQbt3jZkHiPF5h
	YcFPHahgCiI7dDFaupyE6wLDkWzl/4TYUiMjwhc=
X-Google-Smtp-Source: AMrXdXt/L8VYJ/7asMvT6O+QMfz5eTErZ8jvR/+MFcgL9I4hdxe6wYXxZBEaBfVnGZC0tw9a5HnmNg==
X-Received: by 2002:a17:907:29c4:b0:86e:a761:c5bd with SMTP id ev4-20020a17090729c400b0086ea761c5bdmr41277643ejc.34.1675074995540;
        Mon, 30 Jan 2023 02:36:35 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id pk9-20020a170906d7a900b00883410a786csm3461398ejb.207.2023.01.30.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 02:36:35 -0800 (PST)
Message-ID: <9ab4aead-51c0-3a3d-974a-7cdfa8ab3236@tessares.net>
Date: Mon, 30 Jan 2023 11:36:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net v2] mptcp: be careful on subflow status
 propagation on errors
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d2091b4407a0d54f561f44fcc438555454d9fb47.1674844826.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 27/01/2023 19:40, Paolo Abeni wrote:
> Currently the subflow error report callback unconditionally
> propagates the fallback subflow status to the owning msk.
> 
> If the msk is already orphaned, the above prevents the code
> from correctly tracking the msk moving to the TCP_CLOSE state
> and doing the appropriate cleanup.
> 
> All the above causes increasing memory usage over time and
> sporadic self-tests failures.
> 
> There is a great deal of infrastructure trying to propagate
> correctly the fallback subflow status to the owning mptcp socket,
> e.g. via mptcp_subflow_eof() and subflow_sched_work_if_closed():
> in the error propagation path we need only to cope with unorphaned
> sockets.

Thank you for the update!

I just have one small comment below (no need to send a v3)

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/339
> Fixes: 15cc10453398 ("mptcp: deliver ssk errors to msk")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> --
> v1 -> v2:
>  - propagate the status for non orphaned sockets
> ---
>  net/mptcp/subflow.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 5e57a9a7178b..39a4b60f6d6b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1404,6 +1404,7 @@ void __mptcp_error_report(struct sock *sk)
>  	mptcp_for_each_subflow(msk, subflow) {
>  		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>  		int err = sock_error(ssk);
> +		int ssk_state;
>  
>  		if (!err)
>  			continue;
> @@ -1414,7 +1415,14 @@ void __mptcp_error_report(struct sock *sk)
>  		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
>  			continue;
>  
> -		inet_sk_state_store(sk, inet_sk_state_load(ssk));
> +		/* We need to propagate only transition to CLOSE statue and
> +		 * orphaned socket will see such state change via
> +		 * subflow_sched_work_if_closed() and that path will properly
> +		 * destroy the msk as needed

Do you mind if I "break" the sentence above in two?

> We need to propagate only transition to CLOSE status.
> Orphaned socket will get such state change via
> subflow_sched_work_if_closed() and that path will properly
> destroy the msk as needed.

If it is OK for you, I can do the modification when applying the patch!

Other than that, it looks good to me :-)

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
