Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19BE72
	for <mptcp@lists.linux.dev>; Tue, 12 Oct 2021 09:33:07 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id a25so62785902edx.8
        for <mptcp@lists.linux.dev>; Tue, 12 Oct 2021 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=Nd2posWink9r8SFcTiBMmEwTMy9vV3DegmAmPd6cgQo=;
        b=rxiS0V/jW6HsTBnzRYMAbgBX7MzvY9GzWQLJ4yM4mzYW+ET4AWWADxwYkKFNeIC5Ct
         B1i54XSjOZhJuP84if2IKzaVAm19Gxb1TvxE656zH7mIorjZjAtJr/5qrI6WThQekz/j
         zYMMI0ka//M0v2vNW/dbR5Gqeo3k8a6rTDwnIqBsWE0R9GIgDgJ1j7TMqNTKopRC3AaK
         PMY/QVcbMzRMArFkYcyPANGXANJebZ2zQ7BLIiPNAriWw+GbXynJgXUkNtNfLiIQNQV3
         oSuFcJzJCOxf6BE8mYYU2NuwDPXyZWkYYOJgP/OXl0VHeoUf7CoJ3omrqLU+HDGA1kFD
         E9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=Nd2posWink9r8SFcTiBMmEwTMy9vV3DegmAmPd6cgQo=;
        b=BRnM0v9fDYZkMmELDEEyLSYcOf4U88O5YlTKZf+N/agyiXOZop5fHoVdaK/hHpXaB2
         2ZXWXZGq6jHRgxdWohLccyAE2naBTlKVS1CJnJrAfYxKCQsfo6R6CZi9G021RX3ZrM1n
         SFU4cw0hzx7aULCPM6zl+4XcTKadQu5U22LeXDZ4Mt+U5I+pTJAd1sNodztqGhEGsmtU
         /aOfx9zmiLM1c5LJJP+5PtPKzvXDJlFyhnf9gpdCGAPkvUluYnYAObbvWkWdPRlaZ8EM
         7teeZt4vN6gFLi1e52hm60ecaCaLIHX4kEmJTQlw703uoo8gCuJ7HDnOqKQJVBAf0wu5
         81ow==
X-Gm-Message-State: AOAM533+oJ+KA4Yj8XWR7SSzz4PfPJSBZR5oq6aRZk5gwsSk1KXceMRN
	dDJ/1RIURcFvfHZVHFo8YwpnYw==
X-Google-Smtp-Source: ABdhPJwZlRzRs2mg0ixP/bIlaWWqS0OOkEnR9OPd9psj1ttdoOFIPK4wi46jnSjBW8rxsFbxqGM74Q==
X-Received: by 2002:a05:6402:4309:: with SMTP id m9mr50615911edc.272.1634031185668;
        Tue, 12 Oct 2021 02:33:05 -0700 (PDT)
Received: from [192.168.178.46] (94.105.102.72.dyn.edpnet.net. [94.105.102.72])
        by smtp.gmail.com with ESMTPSA id z4sm6240572edd.46.2021.10.12.02.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 02:33:05 -0700 (PDT)
Message-ID: <cb7a0291-75d8-c93d-1887-560d38805ea0@tessares.net>
Date: Tue, 12 Oct 2021 11:33:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH] mptcp: allocate fwd memory separatelly on the rx and
 tx path
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
References: <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
 Davide Caratti <dcaratti@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 05/10/2021 18:39, Paolo Abeni wrote:
> All the mptcp receive path is protected by the msk socket
> spinlock. As consequence, the tx path has to play a few to allocate
> the forward memory without acquiring the spinlock multile times, making
> the overall TX path quite complex.
> 
> This patch tries to clean-up a bit the tx path, using completely
> separated fwd memory allocation, for the rx and the tx path.
> 
> The forward memory allocated in the rx path is now accounted in
> msk->rmem_fwd_alloc and is (still) protected by the msk socket spinlock.
> 
> To cope with the above we provied a few MPTCP-specific variant for
> the helpers to charge, uncharge, reclaim and free the forward
> memory in the receive path.
> 
> msk->sk_forward_alloc now accounts only the forward memory for the tx path,
> we can the plain core sock helper to manipulate it and drop quite a bit
> of complexity.
> 
> On memory pressure reclaim both rx and tx fwd memory.

Thank you for looking at that!

(...)

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 21716392e754..1d26462a1daf 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

(...)

> @@ -155,6 +160,50 @@ static bool mptcp_ooo_try_coalesce(struct mptcp_sock *msk, struct sk_buff *to,
>  	return mptcp_try_coalesce((struct sock *)msk, to, from);
>  }
>  
> +void __mptcp_rmem_reclaim(struct sock *sk, int amount)

The public CI complained about this:

ERROR: Unable to compile mptcp source code with W=1 C=1:

  net/mptcp/protocol.c:163:6: error: no previous prototype for
'__mptcp_rmem_reclaim' [-Werror=missing-prototypes]
    163 | void __mptcp_rmem_reclaim(struct sock *sk, int amount)
        |      ^~~~~~~~~~~~~~~~~~~~

https://github.com/multipath-tcp/mptcp_net-next/runs/3868191624?check_suite_focus=true

As confirmed by Davide on IRC, marking the function as 'static' fixes
the error.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
