Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F67210B
	for <mptcp@lists.linux.dev>; Fri, 13 May 2022 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652432125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fKF5A4OgTywzQbns5nG0wmeC43eRUDr7vsTW2av5gN0=;
	b=hj4fjQIMo+NMswIyDgpLG3HmH9mnlV4YXmggHPmOIoneA8Cfsf4cRinyu0UtRqwPu7lX0g
	O7CnkezpP7/wvR0RCblZYXIyP4K+ONn1wma3Hqh9bIBvCuxyCQzcywSCq2fHyWzK4WmuiY
	sA4CM53RxQ31FlqBkYmnft8K/tLgFas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-IZiBSoOsNreMq9gY8IL2Uw-1; Fri, 13 May 2022 04:55:24 -0400
X-MC-Unique: IZiBSoOsNreMq9gY8IL2Uw-1
Received: by mail-wm1-f72.google.com with SMTP id bi5-20020a05600c3d8500b0039489e1d18dso5662704wmb.5
        for <mptcp@lists.linux.dev>; Fri, 13 May 2022 01:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fKF5A4OgTywzQbns5nG0wmeC43eRUDr7vsTW2av5gN0=;
        b=wUOa0I2wePBlKN8hNKkrDfhxJrBgswmMmEf5rKwYZta3ocOjv083ptC/2gmnJWAS62
         /kv3NgyBtVhKdcHttdrOAbDLo6eC6m5gyQ6Y4TMnn3lfnXC4KSoVoJkfm2DPIhqa/HOd
         U8CkbezMFZbxTWVG5leo+w7KiJohwQsFkvhK8iyRfsk7QFSuZ+AwTpHIAA+pnELMPHJO
         nTz62GBehM3Qq2LwFws4BoH9ulLvcdrFB6GcoeFLPL0QryU/ugUUihXwGpTb3pXUMLFQ
         VSSdjLapckVjGLqx0c9FQsxb04o8/Vh1rIfoLqUmLQDZZLObdGJiTF+rZAWVE7swgX61
         IQFQ==
X-Gm-Message-State: AOAM531TlFDVU1PfxV95UnKJEGwilgp60/lwy9RfV1YwDixcEw3yMcTt
	kl2STppCxDEVixGVQ9F7BVa4SkqYlWnIe6XqjmiwKL6AK9za+K8576jR0MIQsUHEbLJYngrj7Sb
	kENHc2ZZn7o4fvOw=
X-Received: by 2002:a5d:4b48:0:b0:207:9abd:792a with SMTP id w8-20020a5d4b48000000b002079abd792amr3003413wrs.118.1652432123579;
        Fri, 13 May 2022 01:55:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBJSFMghe0XK4YZ6ohNI1z0xse3Kt6+H9VDWSZPbvy0HibheyKJkKba2NtbEw3HqeC0PICaw==
X-Received: by 2002:a5d:4b48:0:b0:207:9abd:792a with SMTP id w8-20020a5d4b48000000b002079abd792amr3003400wrs.118.1652432123315;
        Fri, 13 May 2022 01:55:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-184.dyn.eolo.it. [146.241.112.184])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b003942a244ed1sm1747148wms.22.2022.05.13.01.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 01:55:22 -0700 (PDT)
Message-ID: <3c51bc2850aa3d31eaf2e685d3c584d17a0e059d.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2] mptcp: Do not traverse the subflow
 connection list without lock
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Fri, 13 May 2022 10:55:22 +0200
In-Reply-To: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
References: <20220513003521.548193-1-mathew.j.martineau@linux.intel.com>
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

On Thu, 2022-05-12 at 17:35 -0700, Mat Martineau wrote:
> The MPTCP socket's conn_list (list of subflows) requires the socket lock
> to access. The MP_FAIL timeout code added such an access, where it would
> check the list of subflows both in timer context and (later) in workqueue
> context where the socket lock is held.
> 
> Rather than check the list twice, remove the check in the timeout
> handler and only depend on the check in the workqueue. Also remove the
> MPTCP_FAIL_NO_RESPONSE flag, since mptcp_mp_fail_no_response() has
> insignificant overhead and can be checked on each worker run.
> 
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Fixes: 49fa1919d6bc ("mptcp: reset subflow when MP_FAIL doesn't respond")
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
> 
> v2: Remove flag.
> 
> ---
>  net/mptcp/protocol.c | 16 +---------------
>  net/mptcp/protocol.h |  1 -
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3c55e7f45aef..d6aef4b13b8a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2182,23 +2182,10 @@ mp_fail_response_expect_subflow(struct mptcp_sock *msk)
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
>  	mptcp_schedule_work(sk);
>  	sock_put(sk);
>  }
> @@ -2575,8 +2562,7 @@ static void mptcp_worker(struct work_struct *work)
>  	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>  		__mptcp_retrans(sk);
>  
> -	if (test_and_clear_bit(MPTCP_FAIL_NO_RESPONSE, &msk->flags))
> -		mptcp_mp_fail_no_response(msk);
> +	mptcp_mp_fail_no_response(msk);
>  
>  unlock:
>  	release_sock(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9933c711b787..9ccbe25dcc3e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -117,7 +117,6 @@
>  #define MPTCP_WORK_EOF		3
>  #define MPTCP_FALLBACK_DONE	4
>  #define MPTCP_WORK_CLOSE_SUBFLOW 5
> -#define MPTCP_FAIL_NO_RESPONSE	6
>  
>  /* MPTCP socket release cb flags */
>  #define MPTCP_PUSH_PENDING	1

LGTM, Thanks!

Reviewed-by: Paolo Abeni <pabeni@redhat.com>

BTW it looks like my recent patch made the infinite mappting test less
stable, but I still can't reproduce the issue locally :(

/P

