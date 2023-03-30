Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E888C02
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 17:20:46 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id w9so79388542edc.3
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680196844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hpOpMYhfTl6i9hBrNq3ZUj1YE9/JPinNwJBMJTjAcxo=;
        b=fp+H0IEzBIBrnrUiIx2XWP4GXWBfoa3A1wmN67oPo8YWFe9Zu7Uq6MueHeu3kY0SxL
         CKsr/9rsBqqzy4HFmkuVTjzodckbQsdvJ971pxvcaE0m0AuqtK3i3KURMbcFThbSTp7d
         105QTx9stUg6cXRjrY91DQUpiIIRE6vsc8NyWDJZ8Lu14uhv12cZcRb/Dr3R2/cqh2bU
         Xl6JjW1FYKnkbWTGhpIk5K5V1d+u/Bf9xc3pQqX48ohhWx5ltnsCuU2SDmOvTc8otXiY
         vDgl4Zse4isHDxNelPEaBACr4mFh/oQEirjGR3ABUMr8Po1ZeNp6LVsIUsEcT9gDz07j
         EomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196844;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hpOpMYhfTl6i9hBrNq3ZUj1YE9/JPinNwJBMJTjAcxo=;
        b=WiiSoETTGZYd8Ru3TCxm9jhTcI25C8B5+4aazMOGLkNqLDIHBoQFgGO0HXZhGMjifo
         6cqmEoDW6pOQVzew2ORyWd2QEkTNIUg4d1JkMpkWqmB5qMV9unmaSW3FYPKaLyIfc7dw
         S8NXGvSm6rH5XUMzi+RUKtQjs/gdk9iDQWVgsQs+lsYS4GDu+voRyb8uQH9esNVS9FLX
         AmuH/mPHiJH/ixL3JoWccQJzfLMp5kzmTHN/8SaY54HpaKVrwttS0tYXBFoUUbPPkisz
         7yj55/g70NjeZQQsgogBzTUO+bbt25UEuxLb+/JPojN7s3SWrRzJvQEX5yu2fYlEiVoG
         DqNw==
X-Gm-Message-State: AAQBX9fECtWTq3+nu2E2SdyI3xCnuIPANXjDnHv+RgUHXUr58Zbq36Vr
	1FM2P4OovoQZqX9/4vZRHXkuPg==
X-Google-Smtp-Source: AKy350Y7InQ/RBmxjxB69mqijjFUt94/Xit2cg6V4z+ytQtrQ25GUFB9MOGEM04nsUW5DncCwJfiqw==
X-Received: by 2002:a17:907:6b06:b0:93f:50c7:2f5f with SMTP id rm6-20020a1709076b0600b0093f50c72f5fmr19586268ejc.63.1680196844592;
        Thu, 30 Mar 2023 10:20:44 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9495:b05f:3abb:31b3? ([2a02:578:8593:1200:9495:b05f:3abb:31b3])
        by smtp.gmail.com with ESMTPSA id hg15-20020a1709072ccf00b00939e76a0cabsm46969ejc.111.2023.03.30.10.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:20:44 -0700 (PDT)
Message-ID: <c181f78a-ce58-a9b3-c86b-c33c63771882@tessares.net>
Date: Thu, 30 Mar 2023 19:20:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH mptcp-net v2 2/2] mptcp: fix accept vs worker race
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <cover.1680110912.git.pabeni@redhat.com>
 <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <93685516f6f6d543c831013f957a03a21f774fd9.1680110912.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for this patch!

On 29/03/2023 19:32, Paolo Abeni wrote:
> The mptcp worker and mptcp_accept() can race, as reported by Christoph:

(...)

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d90267da9114..d9f5dcc734b1 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

(...)

> @@ -1846,18 +1848,25 @@ void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_s
>  	release_sock(listener_ssk);
>  
>  	for (msk = head; msk; msk = next) {
> -		struct sock *sk = (struct sock *)msk;
> -
>  		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
> +		sk = (struct sock *)msk;

Just to be sure, you do the lock_sock_nested() on the previous 'sk' and
then switch to the new one on purpose?

It is a bit too late for me to do a useful review. I will better check
tomorrow :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
