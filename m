Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDD7A
	for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655293279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TvV7Ep7ncCqEhPYASYMsJqknCl7vae1AFkCVKcXfxgU=;
	b=T74UDpInRGU2dqlxZx0/2HEKKQah8tFbXQLQdRpWsWdCTazOh6hA2yBiuLHcUVgkAAEwhM
	Hdbve6uBa9eOnL0y7rzplWE5I/NlIFkm5h7AweUoZ0W5v8GoQwwdsCjDizEKWdrf35h2a6
	ZiNRV+HEwPKPYzMVMlEfJYrlSS/+rhU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113--wsgQTBsOamqOEYv6VZxMQ-1; Wed, 15 Jun 2022 07:41:18 -0400
X-MC-Unique: -wsgQTBsOamqOEYv6VZxMQ-1
Received: by mail-wm1-f70.google.com with SMTP id i131-20020a1c3b89000000b0039c9a08c52bso2496609wma.4
        for <mptcp@lists.linux.dev>; Wed, 15 Jun 2022 04:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TvV7Ep7ncCqEhPYASYMsJqknCl7vae1AFkCVKcXfxgU=;
        b=DA+b7gl5dvt6LwOxA1OPWFiQfdSXup6ZF9dpcLt7wfibHjtwl3ajU1hZJrvFIzK8NR
         /hwdUqUmT+57jcEnk30Oz/83CuDTE743lXJwUIm8xbYA0pL0Io66IA/HdiOTNoK741ev
         Au3En+P44R4nWlfMrVjVutuxPk+heyIVWicLM9bUViwHHkWIogXL3VMcvKlLIWjC3n7j
         zTqUfWTiGvzq1bePD56bxtKxH6y40Anl7sz0pjBq755wuK1YOLns+YIve83AoJ3T0zvi
         GuupmfBRUanXiBurAV3wRwHt88Vo3T5zbw/FpyLfDf8D+i3NsbURgRT6HJGvOIE5yQyg
         7QJA==
X-Gm-Message-State: AJIora91BnfGkJ4VOI7hX638K6pBNprUfOLjc5VIuwhTVOt+XUg2hB/L
	AW8Uy7/sXFqiI6UzFcTtF+sY/rwtBDlaULJghzw82c544YHqvLE4WWG7XoFg/OWFWE1CzvcPsKJ
	nSQZ0LioUOy0aepR2sI5gl2fLD7JPIzNMJXXi29Jo90mV9l9kcsJwJSvw5OPKDVwv
X-Received: by 2002:adf:a44f:0:b0:21a:dfc:d459 with SMTP id e15-20020adfa44f000000b0021a0dfcd459mr9486944wra.615.1655293277282;
        Wed, 15 Jun 2022 04:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ukXIYMYNMGhH7xo3NAnIxy7BLND7EdFmmJDCfKBqMTOLFuujWeNl0xrHDgkbHGse+UL+A9+Q==
X-Received: by 2002:adf:a44f:0:b0:21a:dfc:d459 with SMTP id e15-20020adfa44f000000b0021a0dfcd459mr9486912wra.615.1655293276852;
        Wed, 15 Jun 2022 04:41:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id c130-20020a1c3588000000b0039c798b2dc5sm2220516wma.8.2022.06.15.04.41.16
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 04:41:16 -0700 (PDT)
Message-ID: <ab438a147f7da45cf30a4fa003af62a036317bef.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 3/5] Squash-to: "mptcp: invoke MP_FAIL
 response when needed"
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Wed, 15 Jun 2022 13:41:15 +0200
In-Reply-To: <a8a64e7da9f537998d49cd955abb443ee8ec7457.1655283387.git.pabeni@redhat.com>
References: <cover.1655283387.git.pabeni@redhat.com>
	 <a8a64e7da9f537998d49cd955abb443ee8ec7457.1655283387.git.pabeni@redhat.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2022-06-15 at 11:16 +0200, Paolo Abeni wrote:
> This tries to address a few issues outstanding in the mentioned
> patch:
> - we explicitly need to reset the timeout timer for mp_fail's sake
> - we need to explicitly generate a tcp ack for mp_fail, otherwise
>   there are no guarantees for suck option being sent out
> - the timeout timer needs handling need some caring, as it's still
>   shared between mp_fail and msk socket timeout.
> - we can re-use msk->first for msk->fail_ssk, as only the first/mpc
>   subflow can fail without reset. That additionally avoid the need
>   to clear fail_ssk on the relevant subflow close.
> - fail_tout would need some additional annotation. Just to be on the
>   safe side move its manipulaiton under the ssk socket lock.
> 
> Last 2 paragraph of the squash to commit should be replaced with:
> 
> """
> It leverages the fact that only the MPC/first subflow can gracefully
> fail to avoid unneeded subflows traversal: the failing subflow can
> be only msk->first.
> 
> A new 'fail_tout' field is added to the subflow context to record the
> MP_FAIL response timeout and use such field to reliably share the
> timeout timer between the MP_FAIL event and the MPTCP socket close timeout.
> 
> Finally, a new ack is generated to send out MP_FAIL notification as soon
> as we hit the relevant condition, instead of waiting a possibly unbound
> time for the next data packet.
> """
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/mptcp/pm.c       |  4 +++-
>  net/mptcp/protocol.c | 54 ++++++++++++++++++++++++++++++++++++--------
>  net/mptcp/protocol.h |  4 ++--
>  net/mptcp/subflow.c  | 24 ++++++++++++++++++--
>  4 files changed, 72 insertions(+), 14 deletions(-)
> 
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3c7f07bb124e..45e2a48397b9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -305,13 +305,15 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>  	if (!READ_ONCE(msk->allow_infinite_fallback))
>  		return;
>  
> -	if (!msk->fail_ssk) {
> +	if (!subflow->fail_tout) {
>  		pr_debug("send MP_FAIL response and infinite map");
>  
>  		subflow->send_mp_fail = 1;
>  		subflow->send_infinite_map = 1;
> +		tcp_send_ack(sk);
>  	} else {
>  		pr_debug("MP_FAIL response received");
> +		WRITE_ONCE(subflow->fail_tout, 0);
>  	}
>  }
>  
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b74c6ca52aee..2910105a99b0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -500,7 +500,7 @@ static void mptcp_set_timeout(struct sock *sk)
>  	__mptcp_set_timeout(sk, tout);
>  }
>  
> -static bool tcp_can_send_ack(const struct sock *ssk)
> +static inline bool tcp_can_send_ack(const struct sock *ssk)
>  {
>  	return !((1 << inet_sk_state_load(ssk)) &
>  	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> @@ -2503,24 +2503,56 @@ static void __mptcp_retrans(struct sock *sk)
>  		mptcp_reset_timer(sk);
>  }
>  
> +/* schedule the timeout timer for the nearest relevant event: either
> + * close timeout or mp_fail timeout. Both of them could be not
> + * scheduled yet
> + */
> +void mptcp_reset_timeout(struct mptcp_sock *msk, unsigned long fail_tout)
> +{
> +	struct sock *sk = (struct sock *)msk;
> +	unsigned long timeout, close_timeout;
> +
> +	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
> +		return;
> +
> +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
> +
> +	/* the following is basically time_min(close_timeout, fail_tout) */
> +	if (!fail_tout)
> +		timeout = close_timeout;
> +	else if (!sock_flag(sk, SOCK_DEAD))
> +		timeout = fail_tout;
> +	else if (time_after(close_timeout, fail_tout))
> +		timeout = fail_tout;
> +	else
> +		timeout = close_timeout;
> +
> +	sk_reset_timer(sk, &sk->sk_timer, timeout);
> +}
> +
>  static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
>  {
> -	struct sock *ssk = msk->fail_ssk;
> +	struct sock *ssk = msk->first;
>  	bool slow;
>  
> +	if (!ssk)
> +		return;
> +
>  	pr_debug("MP_FAIL doesn't respond, reset the subflow");
>  
>  	slow = lock_sock_fast(ssk);
>  	mptcp_subflow_reset(ssk);
> +	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
>  	unlock_sock_fast(ssk, slow);
>  
> -	msk->fail_ssk = NULL;
> +	mptcp_reset_timeout(msk, 0);
>  }
>  
>  static void mptcp_worker(struct work_struct *work)
>  {
>  	struct mptcp_sock *msk = container_of(work, struct mptcp_sock, work);
>  	struct sock *sk = &msk->sk.icsk_inet.sk;
> +	unsigned long fail_tout;
>  	int state;
>  
>  	lock_sock(sk);
> @@ -2557,7 +2589,8 @@ static void mptcp_worker(struct work_struct *work)
>  	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>  		__mptcp_retrans(sk);
>  
> -	if (msk->fail_ssk && time_after(jiffies, msk->fail_tout))
> +	fail_tout = msk->first ? READ_ONCE(mptcp_subflow_ctx(msk->first)->fail_tout) : 0;

For the records, the above apparently trigger an UaF in the CI debug
build on pktdrill tests.

AFAICS that is cause by the listener mptcp socket being destroyed while
the MPC is still in accept queue: the MPC socket is freed, but msk-
>first is not updated accordingly.

Note that the above issue is not related to this patch-series, but it
makes it much more easy to reproduce.

/P

