Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5E3232
	for <mptcp@lists.linux.dev>; Thu, 12 May 2022 13:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652362402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5rYDI/kPnNQFXejPUSq5AUnJOvb+scdza8oA0B0R8k=;
	b=FEOjJxoze+j4lPwkQ39J82azCec1k2txl6vC8fwTXMf/CKxFZvxnbBUJzbXX3PdfhQPvoh
	xEnjj+oWcj3d9g0EsNUjYGlMP7SxWsZss+qifgMTEPi5pGaVjGcxpuG8ON3OA4r5NpSIhe
	+GnVCiqbU/gX0yUDHm03GaZS6bE5ug8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-JYBvX2TAMcCuV8H3crIIxA-1; Thu, 12 May 2022 09:33:21 -0400
X-MC-Unique: JYBvX2TAMcCuV8H3crIIxA-1
Received: by mail-qk1-f197.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so4075824qkb.16
        for <mptcp@lists.linux.dev>; Thu, 12 May 2022 06:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=m5rYDI/kPnNQFXejPUSq5AUnJOvb+scdza8oA0B0R8k=;
        b=rQD2NrapL3h+qaSo2KTdHyAEQTJ0BKjTVNP7DbOKOM7TbeH2X1xZEVr26LIZtL3POO
         mQu5CQcMyurlJwT10pNh7EMEhbfrqgxs1RQjMngFt0wJ6bwAPJ7I/b57AxTs0VnXp2+F
         wi44/LptFXQXUEwiIu5om1RbQI/mv+fYz7ipGYQBV2aGXbe4Lz46V6m30ZWPov9MsErb
         1C3VILEoJre2h8CVzyHrqbs7SbFyHkHCr8dG3+Yl89Iz/Hz+LcI6LUtq37O/RMOxg3VU
         hcwlzxPxpugfcLPS6UwWJu3lUn6x2aLu/5ShJPj/KnTDr7nHc+xSpQJR+c+Q2lCV8OFr
         wUpw==
X-Gm-Message-State: AOAM533ReBTKM8U8yT8JujJX2stvnR5ctMneyb2Twr9msitHGGUjXr6J
	OHe39VRlcSKH9R4ODc2x3JAQTCra/3uLtYLTUMDs+Bd5DO8kJPZFesNM2sQ43prnNTm8rHNlPZe
	6mlhAPUyLaCj3k6I=
X-Received: by 2002:a05:622a:164d:b0:2f3:d474:144c with SMTP id y13-20020a05622a164d00b002f3d474144cmr21168453qtj.17.1652362400346;
        Thu, 12 May 2022 06:33:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyElhbk9ZYnGkmwE7FbN/nedxQXQPkchPTiu8TcgZ/JpnneR/TfKCutPfmQ7UxCwmLl/XVXyg==
X-Received: by 2002:a05:622a:164d:b0:2f3:d474:144c with SMTP id y13-20020a05622a164d00b002f3d474144cmr21168389qtj.17.1652362399623;
        Thu, 12 May 2022 06:33:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id bp11-20020a05620a458b00b0069fc13ce1fesm3254450qkb.47.2022.05.12.06.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:33:19 -0700 (PDT)
Message-ID: <9f3f7f33e4fb662d85046205018f9cffd93aac44.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/2] mptcp: Do not traverse the subflow
 connection list without lock
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Thu, 12 May 2022 15:33:15 +0200
In-Reply-To: <20220512002308.445416-2-mathew.j.martineau@linux.intel.com>
References: <20220512002308.445416-1-mathew.j.martineau@linux.intel.com>
	 <20220512002308.445416-2-mathew.j.martineau@linux.intel.com>
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

On Wed, 2022-05-11 at 17:23 -0700, Mat Martineau wrote:
> The MPTCP socket's conn_list (list of subflows) requires the socket lock
> to access. The MP_FAIL timeout code added such an access, where it would
> check the list of subflows both in timer context and (later) in workqueue
> context where the socket lock is held.
> 
> Rather than check the list twice, remove the check in the timeout
> handler and only depend on the check in the workqueue.
> 
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Fixes: 49fa1919d6bc ("mptcp: reset subflow when MP_FAIL doesn't respond")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  net/mptcp/protocol.c | 16 ++--------------
>  net/mptcp/protocol.h |  2 +-
>  2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3c55e7f45aef..11e1c58dcbcf 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2182,23 +2182,11 @@ mp_fail_response_expect_subflow(struct mptcp_sock *msk)
>  	return ret;
>  }
>  
> -static void mptcp_check_mp_fail_response(struct mptcp_sock *msk)
> -{
> -	struct mptcp_subflow_context *subflow;
> -	struct sock *sk = (struct sock *)msk;
> -
> -	bh_lock_sock(sk);
> -	subflow = mp_fail_response_expect_subflow(msk);
> -	if (subflow)
> -		__set_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags);
> -	bh_unlock_sock(sk);
> -}
> -
>  static void mptcp_timeout_timer(struct timer_list *t)
>  {
>  	struct sock *sk = from_timer(sk, t, sk_timer);
>  
> -	mptcp_check_mp_fail_response(mptcp_sk(sk));
> +	set_bit(MPTCP_WORK_TIMEOUT, &mptcp_sk(sk)->flags);
>  	mptcp_schedule_work(sk);
>  	sock_put(sk);
>  }

I'm wondering if at this point we could get rid also of the
MPTCP_WORK_TIMEOUT flags. In case of mptcp-level timeout we just
schedule the worker and let it do it's check.

Other than that the series LGTM, thanks!

Paolo

