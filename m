Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176172
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631012702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKsr5oVjhVxzPpbLfvDXC5GPKaIEJMhdda1IWjtA2GQ=;
	b=NtH61w6t7gNUj4d5gyWTn5uRPrJ3prWCzTZG9lIZ3SuPBlbzfVXCt08sLOngoSfhMJ6lYP
	k223HIJ3j4q04bNjGsLUN6tyj/uQM/QBVFXWmYzsdl7j/1kQEGlGuEbXiIYyQJ5xzP1Kae
	tGW1bq2ooFJWDxqz1EDsK6lv9r4689M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-5TYcZANSPvCMMnWak7AEzw-1; Tue, 07 Sep 2021 07:05:01 -0400
X-MC-Unique: 5TYcZANSPvCMMnWak7AEzw-1
Received: by mail-wm1-f72.google.com with SMTP id p5-20020a7bcc85000000b002e7563efc4cso974062wma.4
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 04:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=JKsr5oVjhVxzPpbLfvDXC5GPKaIEJMhdda1IWjtA2GQ=;
        b=eleluQYp8sWzr81hGiGvAH+6/5BxD5weGn/16N3o3OCR6d4dT4atXI23i/ir5SWtRE
         09oKt/wODjBPSfDVb04R1iUPo4rV4ttm6yxP57XMLhXhl60sVkdKC96AEXSQ0L3rjacw
         vLWGVHbG8vBptImtJwNAG/5ive3WHXQ/xHY/iZmgZrLIO+ubcmQUdV5ch7Z9D3W5vD7c
         kLQBb1xXEu73kps0tk5B+6cposEBwHJ+gwVQkWYAYA9Ds5XLHFhY+T84Btm1Xv4lzK0b
         UsIfNLp8SuWuVd7KAOJHHcCtuM/Nh0fDRauDmPn55SdXIZdZLci6vArJxdVFpC9d6kEO
         oVnQ==
X-Gm-Message-State: AOAM533q8QazDWz+YxSVWBTcS9j23fNJr9wVeIqX6Y4kSm1RnUp8lGpb
	ZzoywAyQUlQY2yccFS09I/cHQ0HOE40FSD7gsxHZ3Htq/iL0jHFOKg3O4yqGvfnEYUuvUfXmqhM
	wE0OdLwgZRT5D4nM=
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr18318881wrg.358.1631012700318;
        Tue, 07 Sep 2021 04:05:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBolgZ9XbROTzOUnnlOPaUB2W9iLyz3CnTw3MsOda6EE/8dc1sO62lGqdYjYJqxY47ZdQIJw==
X-Received: by 2002:adf:c3d4:: with SMTP id d20mr18318790wrg.358.1631012699366;
        Tue, 07 Sep 2021 04:04:59 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id j20sm10777799wrb.5.2021.09.07.04.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:04:58 -0700 (PDT)
Message-ID: <48bc68806ca2cbcb33dffddd2f450a541b8f6500.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp-next 2/4] mptcp: add struct mptcp_sched_ops
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 07 Sep 2021 13:04:52 +0200
In-Reply-To: <4089672c8557e031d38306ef49e26e9902e7db57.1631011068.git.geliangtang@xiaomi.com>
References: <cover.1631011068.git.geliangtang@xiaomi.com>
	 <4089672c8557e031d38306ef49e26e9902e7db57.1631011068.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Tue, 2021-09-07 at 18:41 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added struct mptcp_sched_ops. And define the scheduler
> init, register and find functions.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/protocol.c | 60 +++++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  8 ++++++
>  2 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2a525c7ae920..ab72a3950f2b 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1515,6 +1515,58 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>  	return NULL;
>  }
>  
> +static struct mptcp_sched_ops mptcp_sched_default = {
> +	.get_subflow	= mptcp_subflow_get_send,
> +	.name		= "default",
> +	.owner		= THIS_MODULE,
> +};
> +
> +static DEFINE_SPINLOCK(mptcp_sched_list_lock);
> +static LIST_HEAD(mptcp_sched_list);
> +
> +static struct mptcp_sched_ops *mptcp_sched_find(const char *name)
> +{
> +	struct mptcp_sched_ops *ops;
> +
> +	list_for_each_entry_rcu(ops, &mptcp_sched_list, list) {
> +		if (!strcmp(ops->name, name))
> +			return ops;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
> +{
> +	int ret = 0;
> +
> +	if (!sched->get_subflow)
> +		return -EINVAL;
> +
> +	spin_lock(&mptcp_sched_list_lock);
> +	if (mptcp_sched_find(sched->name)) {
> +		pr_debug("%s already registered", sched->name);
> +		ret = -EEXIST;
> +	} else {
> +		list_add_tail_rcu(&sched->list, &mptcp_sched_list);
> +		pr_debug("%s registered", sched->name);
> +	}
> +	spin_unlock(&mptcp_sched_list_lock);
> +	return 0;
> +}
> +
> +static void mptcp_sched_data_init(struct mptcp_sock *msk)
> +{
> +	struct net *net = sock_net((struct sock *)msk);
> +
> +	msk->sched = mptcp_sched_find(mptcp_get_scheduler(net));
> +}
> +
> +static void mptcp_sched_init(void)
> +{
> +	mptcp_register_scheduler(&mptcp_sched_default);
> +}
> +

I think it would be nice keeping this infrastructure in a separate
file, but I have no strong opinion on it.

>  static void mptcp_push_release(struct sock *sk, struct sock *ssk,
>  			       struct mptcp_sendmsg_info *info)
>  {
> @@ -1567,7 +1619,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>  
>  			prev_ssk = ssk;
>  			mptcp_flush_join_list(msk);
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = msk->sched->get_subflow(msk);


uhm... it would be nice to avoid the indirect call, but I don't see any
solution other then IDC wrapper usage
(see linux/indirect_call_wrapper.h)

>  			/* First check. If the ssk has changed since
>  			 * the last round, release prev_ssk
> @@ -1634,7 +1686,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
>  			 * check for a different subflow usage only after
>  			 * spooling the first chunk of data
>  			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sk(sk)->sched->get_subflow(mptcp_sk(sk));
>  			if (!xmit_ssk)
>  				goto out;
>  			if (xmit_ssk != ssk) {
> @@ -2534,6 +2586,7 @@ static int __mptcp_init_sock(struct sock *sk)
>  	msk->recovery = false;
>  
>  	mptcp_pm_data_init(msk);
> +	mptcp_sched_data_init(msk);
>  
>  	/* re-use the csk retrans timer for MPTCP-level retrans */
>  	timer_setup(&msk->sk.icsk_retransmit_timer, mptcp_retransmit_timer, 0);

I think we should do the lookup in mptcp_init_sock(), and copy the
scheduler from the parent in mptcp_sk_clone().

Cheers,

Paolo

