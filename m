Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5AD2F3B
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1654685308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hJI8lsfot8Vxqn6lTHRDk2NuVpawRDZ3PI9+lVqyyY=;
	b=RcTeCyrdmltTwT2/SfY+gkjUCRaa/PL5BL5T0QGd1Tx2W/7mqF2IhlXfyigWi7T7E6yFsN
	D+c4dJ4l9AnDi0RHD6r8u5PXtVnGN6SU4XiB3YYgB85Pwqc3F29Hcf6KLNmkI0o95GjTZa
	2wgzrQW6Wg8P1roRNB2uI7WQGjw2uqs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-m71_cRQNMjqoiUAzKWBLDQ-1; Wed, 08 Jun 2022 06:48:28 -0400
X-MC-Unique: m71_cRQNMjqoiUAzKWBLDQ-1
Received: by mail-qk1-f200.google.com with SMTP id bq11-20020a05620a468b00b006a71592a2abso365115qkb.21
        for <mptcp@lists.linux.dev>; Wed, 08 Jun 2022 03:48:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1hJI8lsfot8Vxqn6lTHRDk2NuVpawRDZ3PI9+lVqyyY=;
        b=n27uwAn0YCP8ilqsgTEYACxjhwYtu+g4DTqj7L3jBzJfhj9DnhM71hwmZlX7JCRlYo
         SiK/goCayNTkfmlKrDHcRlDDhIj8mPVvA13idUWm3fHFeOwqsJykW5ySx1PHEYGIk/Ij
         tNO5Zm0pY6Uon8fPOyNh/HxftH6RYgvszqCeSEP6Qpg3jpCNIP/+ItKQ327yRrzE9po2
         UC3z1L4WShh8Qrt52xOVvbzNsNM4HtZdVPUbf80dOg4Y0BEp42uoJSaAkZkCe+NnUI8c
         j0UizHXH5Hw5uoVDTwwqh6oSj9FdfFn6PX4iEBq/gF8iu1AF/h/zSYjoOhFPQ5odcXRg
         54Ug==
X-Gm-Message-State: AOAM533sOc61MaOGB20SzU16gBT5K8pYfzzFPWaADrq+7hR1uEsyyV6S
	3mLbSsfWq1khl7Fp1KL+PPVfFqqTZbQ4tsf9UhKYrHqC2GyvseeNutDVGAnqoXrSH3Q0yc6dmYb
	IsxWE6oH/n4U70d8=
X-Received: by 2002:a05:622a:1305:b0:2f3:e1b1:c622 with SMTP id v5-20020a05622a130500b002f3e1b1c622mr26066082qtk.137.1654685307294;
        Wed, 08 Jun 2022 03:48:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX9DncHcWIXsD8yUstOofFwsNQnKwAsLRNEFOvRE7qQgaoRzRjiO7ptGZ5EC5kxdCK+poc4g==
X-Received: by 2002:a05:622a:1305:b0:2f3:e1b1:c622 with SMTP id v5-20020a05622a130500b002f3e1b1c622mr26066072qtk.137.1654685306967;
        Wed, 08 Jun 2022 03:48:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a424d00b006a69ee117b6sm12924739qko.97.2022.06.08.03.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:48:26 -0700 (PDT)
Message-ID: <93eb0422ac4f7bcd908efcfab8773d59a5267c33.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: call mp_fail_no_response only when
 needed
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Date: Wed, 08 Jun 2022 12:48:23 +0200
In-Reply-To: <8c8d4ab88bfb43cda2ffa0b5e43595cad8c83512.1654680717.git.geliang.tang@suse.com>
References: <8c8d4ab88bfb43cda2ffa0b5e43595cad8c83512.1654680717.git.geliang.tang@suse.com>
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

On Wed, 2022-06-08 at 17:33 +0800, Geliang Tang wrote:
> mptcp_mp_fail_no_response shouldn't be invoked on each worker run, it
> should be invoked only when MP_FAIL response timeout occurs.
> 
> This patch adds a new msk flag MPTCP_WORK_TIMEOUT, set it in
> mptcp_timeout_timer(). And test it in mptcp_worker() before invoking
> mptcp_mp_fail_no_response().
> 
> Check the SOCK_DEAD flag on the subflow in mptcp_mp_fail_no_response()
> to make sure it's a MP_FAIL timeout, not a MPTCP socket close timeout.
> 
> Now mp_fail_response_expect_subflow() helper is only used by
> mptcp_mp_fail_no_response(), move the definition of the helper right
> before mptcp_mp_fail_no_response().
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/281
> Fixes: d9fb797046c5 ("mptcp: Do not traverse the subflow connection list without lock")
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  net/mptcp/protocol.c | 41 ++++++++++++++++++++++++-----------------
>  net/mptcp/protocol.h |  1 +
>  2 files changed, 25 insertions(+), 17 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d6aef4b13b8a..123fa2b3f200 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2167,25 +2167,13 @@ static void mptcp_retransmit_timer(struct timer_list *t)
>  	sock_put(sk);
>  }
>  
> -static struct mptcp_subflow_context *
> -mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> -{
> -	struct mptcp_subflow_context *subflow, *ret = NULL;
> -
> -	mptcp_for_each_subflow(msk, subflow) {
> -		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> -			ret = subflow;
> -			break;
> -		}
> -	}
> -
> -	return ret;
> -}

I think you don't need to move mp_fail_response_expect_subflow() around

> -
>  static void mptcp_timeout_timer(struct timer_list *t)
>  {
>  	struct sock *sk = from_timer(sk, t, sk_timer);
>  
> +	bh_lock_sock(sk);
> +	__set_bit(MPTCP_WORK_TIMEOUT, &mptcp_sk(sk)->flags);
> +	bh_unlock_sock(sk);

This is not correct: the caller must always manipulate msk->flags with
atomic operations. No need to acquire the msk spin lock

>  	mptcp_schedule_work(sk);
>  	sock_put(sk);
>  }
> @@ -2505,6 +2493,21 @@ static void __mptcp_retrans(struct sock *sk)
>  		mptcp_reset_timer(sk);
>  }
>  
> +static struct mptcp_subflow_context *
> +mp_fail_response_expect_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow, *ret = NULL;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (READ_ONCE(subflow->mp_fail_response_expect)) {
> +			ret = subflow;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;
> @@ -2513,9 +2516,12 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
>  
>  	subflow = mp_fail_response_expect_subflow(msk);
>  	if (subflow) {
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		if (sock_flag(ssk, SOCK_DEAD))
> +			return;

I *think* /guess it's better to check the msk SOCK_DEAD flag?!?
Additionally, if you do that, you can move the check in mptcp_worker()

Note that if mp_fail timeout overlap with the close timeout things will
be quite fuzzy. Very complex to follow/understand at best.

What about the following?
- subflow_check_data_avail() does:

	msk->mp_fail_subflow = subflow;
	msk->mp_fail_stamp = jiffies;
	sk_reset_timer((struct sock *)msk,
			&((struct sock *)msk)->sk_timer,
			jiffies + TCP_RTO_MAX);

- no changes to mptcp_timeout_timer()

- mptcp_worker does:
	if (msk->mp_fail_subflow &&
	    time_after(jiffies, msk->mp_fail_stamp)) {
		subflow = msk->mp_fail_subflow;
		pr_debug("MP_FAIL doesn't respond, reset the
subflow");

                ssk = mptcp_subflow_tcp_sock(subflow);
                slow = lock_sock_fast(ssk);
                mptcp_subflow_reset(ssk);
                unlock_sock_fast(ssk, slow);
	}
	
No need to traverse the subflow list and mp_fail will co-exist with
close timeout.
Note: mp_fail_stamp and mp_fail_subflow are new fields.

WDYT?

Thanks!

Paolo

