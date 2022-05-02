Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C428E0
	for <mptcp@lists.linux.dev>; Mon,  2 May 2022 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1651499731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XvKghsbsT5mhlqQ+WMKWbeaUStFU3OWuBe89b1Nd55g=;
	b=OWmtpbZ9aA12asj6MFY8EWkLE3wbBxwgVdBLlolU6eEl6ArfGzBfGg8ZdRRytTDuaPoRmi
	q6lzS8ArX/Uranoq2+FPfsWiJbbDt9J/fyAEOZa8ev2oUTvZRGvNJfcK+aeFgx5VmR3ppc
	cXiOWM2p2ZMUVqNOJF975ktFNHg/XOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119--Nd06YxJMXa_Ag5VrsrvdA-1; Mon, 02 May 2022 09:55:30 -0400
X-MC-Unique: -Nd06YxJMXa_Ag5VrsrvdA-1
Received: by mail-wr1-f71.google.com with SMTP id j21-20020adfa555000000b0020adb9ac14fso5326289wrb.13
        for <mptcp@lists.linux.dev>; Mon, 02 May 2022 06:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XvKghsbsT5mhlqQ+WMKWbeaUStFU3OWuBe89b1Nd55g=;
        b=713XkvkL+5uPApPTRiiZ1BQdw5tm7yirIXiO6JYMAaFj1LhTdzlpe0pTey6pXvj7+p
         GqZ0R5hQRDEjP7rt47O9ayW1aVobY2+gEJBJqsnv6o0eON9go4x2EgqbmlHEe7tnYgzl
         K2uk+bPlQWuhJp9PQwrPGTVfWXDnm5qdckEDXZylQQo1WeCHo8xXhL1lbKBVrF5JJNvJ
         6oJVQy7j6q9pXM56JxUZC1NgxyK7qtV0qMEbsvW2NNIpqSFJB4I4QOCQdGB6tYQeXkw9
         irNFK9GcTGRo4orU7Aia3ePHCB26mNuLbui1UmVM7L8L7wfYMLUmpzvci7+TeiKPnRwI
         WSyw==
X-Gm-Message-State: AOAM531PqaWisfZdOJ+ECva6ztK5YY5m37Qcg8gBszKqFjN9yDWzjVH6
	hb/nKJjkZJrvckL/mHrQSG9/XMa4E9pqftDUKe4EdHv4+TBAE2Gb/LTqPirujltVX/9uUTw6Lil
	hPhZFya9O4aXyndw=
X-Received: by 2002:a5d:5983:0:b0:20c:4bf8:e0a5 with SMTP id n3-20020a5d5983000000b0020c4bf8e0a5mr9730493wri.349.1651499729294;
        Mon, 02 May 2022 06:55:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzf23h8dQLyTq/piZMjAuJegfHbOvdcNBzT03S6WpKx0RxYWO0dOQuLbxBzw3L6yJs3sbeKrQ==
X-Received: by 2002:a5d:5983:0:b0:20c:4bf8:e0a5 with SMTP id n3-20020a5d5983000000b0020c4bf8e0a5mr9730477wri.349.1651499729001;
        Mon, 02 May 2022 06:55:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-115-66.dyn.eolo.it. [146.241.115.66])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0a5500b003942a244f3bsm6222281wmq.20.2022.05.02.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 06:55:28 -0700 (PDT)
Message-ID: <9561e194e1ccaf6e91c97b94973ed58984f361ec.camel@redhat.com>
Subject: Re: [PATCH mptcp-net 1/2] mptcp: fix subflow accounting on close
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 02 May 2022 15:55:27 +0200
In-Reply-To: <cfad224c-fe81-beaa-751d-fa54f7b21be9@linux.intel.com>
References: <84bfd492fa6e4a5ca5c90201283c48ed07318aa9.1651165091.git.pabeni@redhat.com>
	 <cfad224c-fe81-beaa-751d-fa54f7b21be9@linux.intel.com>
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

On Fri, 2022-04-29 at 12:03 -0700, Mat Martineau wrote:
> On Thu, 28 Apr 2022, Paolo Abeni wrote:
> 
> > If the PM closes a fully established MPJ subflow or the subflow
> > creation errors out in it's early stage the subflows counter is
> > not bumped accordingly.
> > 
> > This change adds the missing accouting, additionally taking care
> > of updating accordingly the 'accept_subflow' flag.
> > 
> > Fixes: a88c9e496937 ("mptcp: do not block subflows creation on errors")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/pm.c       |  5 ++---
> > net/mptcp/protocol.h | 14 ++++++++++++++
> > net/mptcp/subflow.c  | 12 +++++++++---
> > 3 files changed, 25 insertions(+), 6 deletions(-)
> > 
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index cdc2d79071f8..59fdab2d0c27 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -181,15 +181,14 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> > 	struct mptcp_pm_data *pm = &msk->pm;
> > 	bool update_subflows;
> > 
> > -	update_subflows = (ssk->sk_state == TCP_CLOSE) &&
> > -			  (subflow->request_join || subflow->mp_join) &&
> > +	update_subflows = (subflow->request_join || subflow->mp_join) &&
> > 			  mptcp_pm_is_kernel(msk);
> > 	if (!READ_ONCE(pm->work_pending) && !update_subflows)
> > 		return;
> > 
> > 	spin_lock_bh(&pm->lock);
> > 	if (update_subflows)
> > -		pm->subflows--;
> > +		__mptcp_pm_close_subflow(msk);
> > 
> > 	/* Even if this subflow is not really established, tell the PM to try
> > 	 * to pick the next ones, if possible.
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 4672901d0dfe..06b8ebc15204 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -893,6 +893,20 @@ unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
> > unsigned int mptcp_pm_get_subflows_max(const struct mptcp_sock *msk);
> > unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
> > 
> > +/* called under PM lock */
> > +static inline void __mptcp_pm_close_subflow(struct mptcp_sock *msk)
> > +{
> > +	if (--msk->pm.subflows < mptcp_pm_get_subflows_max(msk))
> > +		WRITE_ONCE(msk->pm.accept_subflow, true);
> > +}
> > +
> > +static inline void mptcp_pm_close_subflow(struct mptcp_sock *msk)
> > +{
> > +	spin_lock_bh(&msk->pm.lock);
> > +	__mptcp_pm_close_subflow(msk);
> > +	spin_unlock_bh(&msk->pm.lock);
> > +}
> > +
> > void mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk);
> > void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk);
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 6d59336a8e1e..75c85ce9a19e 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1444,20 +1444,20 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> > 	struct sockaddr_storage addr;
> > 	int remote_id = remote->id;
> > 	int local_id = loc->id;
> > +	int err = -ENOTCONN;
> > 	struct socket *sf;
> > 	struct sock *ssk;
> > 	u32 remote_token;
> > 	int addrlen;
> > 	int ifindex;
> > 	u8 flags;
> > -	int err;
> > 
> > 	if (!mptcp_is_fully_established(sk))
> > -		return -ENOTCONN;
> > +		goto err_out;
> > 
> > 	err = mptcp_subflow_create_socket(sk, &sf);
> > 	if (err)
> > -		return err;
> > +		goto err_out;
> > 
> > 	ssk = sf->sk;
> > 	subflow = mptcp_subflow_ctx(ssk);
> > @@ -1515,6 +1515,12 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> > failed:
> > 	subflow->disposable = 1;
> > 	sock_release(sf);
> > +
> > +err_out:
> > +	/* we account subflows before the creation, and this failures will not
> > +	 * be catched by sk_state_change()
> > +	 */
> > +	mptcp_pm_close_subflow(msk);
> 
> __mptcp_subflow_connect() is also called by the userspace PM, which 
> doesn't use this accounting. How about having the caller be responsible 
> for doing mptcp_pm_close_subflow() if __mptcp_subflow_connect() returns an 
> error other than -EINPROGRESS?

Additionally we probably want to take care of  to take care of
mptcp_pm_subflow_check_next(), which is called regardless of the active
PM and can touch subflows, too.

On the flip side, touching 'subflows' when the active PM is the user-
space one should not have any effect - beyond likely be confusing.

I propose to handle all the above with a cleanup net-next patch after
the relevant -net merge, so we can leverage the mptcp_pm_is_userspace()
helper and keep the code as simple as possible.

WDYT?

Thanks!

Paolo

