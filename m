Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AD89A5
	for <mptcp@lists.linux.dev>; Wed,  7 Sep 2022 17:22:29 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id z8so20734119edb.6
        for <mptcp@lists.linux.dev>; Wed, 07 Sep 2022 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WK12/Via43Q0TYZkazkjE42+9Za6r2UY63gstg2V1kY=;
        b=K2S72GIiNz+gEiaSbvUBGAeISU1GnmheX1yIiDnrsOMAI/GBE0FDDCUeuSW4o1iJVs
         rEmlgHY0AcMP2UTca6sznO1Yp1l8XVamtb31d6AtZ6C5cMZvyj0eSHiEr2SNAL9cldMv
         ivRjUK/mXaE7SdhSOhxvo1cF/UhJlD6/IeUxtmDDvdVcRtmRZCPKvQzCGjgAMVDJq+P5
         2vVzt5ByQTHcQS70CshtyZqse/PPa6A/zUeIwz7AusLnPk/ARz0XTs2X1OCqKKFMgk6a
         j5YAxzaC++X2OazdAg5uJPseiAwUFMVckXnfpjf+IFq5rV9q7xfs0B2hFrLNnbUhkbbG
         7IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WK12/Via43Q0TYZkazkjE42+9Za6r2UY63gstg2V1kY=;
        b=IuDF1Hd1/DucxCqZGR2PgYQuJRxM/iOE8wENsgGAzIL6PCdDeJ0oLnuaXLdTsZP0q8
         h7ej0bI7uqSUrUcuylDMtN2STLgJZEQzjyhTehq8awmt44DwD5aMavx3QSPPNlfMUP2f
         pZxbF4JEKJszuRNit3qS3CxSCX+xpc9y1bN9xba8Y/sDYOG++nz+sT17Glt5fWCC54L+
         VFTHbv7aX0rRwnnqUsLroQ34eERVxY0VaYLObpZZPCKTDdZyfNNrpmU+bCEAO13ZFgNT
         hMsr6Z3rAATkCZA/BepwIUHB8LVF+N3Oj8YSreNvIvCrKC1VrhSbWfjGHmgYiWG6LKeU
         peSw==
X-Gm-Message-State: ACgBeo2nCdtccxh8fMlxVz5QnTEp/vvN64ojmtdJVpQoCZsmghlslR1W
	T8khUGDmapyjf2LFYc6W7AVNqfU2OHzWJIED
X-Google-Smtp-Source: AA6agR4zwOMPardMOCAYm4Ny/NR+xFBCWoflFeyXjo7WfvD9n072wY1W69pCG+jB6u8Ki0OgJKZA8Q==
X-Received: by 2002:aa7:c610:0:b0:44e:9a0f:753a with SMTP id h16-20020aa7c610000000b0044e9a0f753amr3884958edq.140.1662571347977;
        Wed, 07 Sep 2022 10:22:27 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:6db7:c94e:7f7:7f98? ([2a02:578:8593:1200:6db7:c94e:7f7:7f98])
        by smtp.gmail.com with ESMTPSA id i23-20020aa7c9d7000000b0044e7d69091asm6861530edt.85.2022.09.07.10.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 10:22:27 -0700 (PDT)
Message-ID: <86057d75-499c-8e30-ef15-7cd67cbc2344@tessares.net>
Date: Wed, 7 Sep 2022 19:22:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v3 mptcp-next 1/3] mptcp: propagate fastclose error.
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5e26963328ae04aa375089a713ec40f5eb6adacd.1662051551.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 01/09/2022 19:31, Paolo Abeni wrote:
> When an mptcp socket is closed due to an incoming FASTCLOSE
> option, so specific sk_err is set and later syscall will
> fail usually with EPIPE.
> 
> Align the current fastclose error handling with TCP reset,
> properly setting the socket error according to the current
> msk state and propagating such error.

Thank you for the patch and sorry for the delay!

I have some questions here below:

> Additionally sendmsg() is currently not handling properly
> the sk_err, always returning EPIPE.
Could it be seen as a bug-fix and deserving a dedicated commit?

> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/protocol.c | 45 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index f4891db86217..b04f184695e4 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1685,9 +1685,13 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  	if ((1 << sk->sk_state) & ~(TCPF_ESTABLISHED | TCPF_CLOSE_WAIT)) {
>  		ret = sk_stream_wait_connect(sk, &timeo);
>  		if (ret)
> -			goto out;
> +			goto do_error;
>  	}
>  
> +	ret = -EPIPE;

Regarding this line above... (see below)

> +	if (unlikely(sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN)))
> +		goto do_error;
> +
>  	pfrag = sk_page_frag(sk);
>  
>  	while (msg_data_left(msg)) {

...Could we eventually have no data left and no going through the while
loop?

In this case "copied" will be 0 and we will return the new -EPIPE, maybe
not what we want, no?
Or should we change 'ret' value just before calling 'goto do_error' to
avoid that?

(...)

> @@ -2404,12 +2410,31 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
>  		unlock_sock_fast(tcp_sk, slow);
>  	}
>  
> +	/* Mirror the tcp_reset() error propagation */
> +	switch (sk->sk_state) {
> +	case TCP_SYN_SENT:
> +		sk->sk_err = ECONNREFUSED;
> +		break;
> +	case TCP_CLOSE_WAIT:
> +		sk->sk_err = EPIPE;
> +		break;
> +	case TCP_CLOSE:
> +		return;
> +	default:
> +		sk->sk_err = ECONNRESET;
> +	}

Should we eventually move this out of tcp_reset(), export it (inline
function?) and re-using it here to avoid the duplication (and eventually
being out-of-sync in case of changes on TCP side? even if I guess this
would not change but well)

> +
>  	inet_sk_state_store(sk, TCP_CLOSE);
>  	sk->sk_shutdown = SHUTDOWN_MASK;
>  	smp_mb__before_atomic(); /* SHUTDOWN must be visible first */
>  	set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags);
>  
> -	mptcp_close_wake_up(sk);
> +	/* the calling mptcp_worker will properly destroy the socket */
> +	if (sock_flag(sk, SOCK_DEAD))
> +		return;
> +
> +	sk->sk_state_change(sk);
> +	sk_error_report(sk);
>  }
>  
>  static void __mptcp_retrans(struct sock *sk)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
