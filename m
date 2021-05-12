Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAA71
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620832014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eH9euYDF5JaC2/TkYww0ejBmmuySTlP7khIg1NBMYSs=;
	b=Uqa9BGKMNOomtQ6iJeT0E4uI6Erf6P1FzHKzm53jg9/gFH/e8U407ZkYfns8ggRaDvjMMG
	iAU1lbybkx2HnPz0TQr1h+CkDr0rkV6MWpto+oSGYN/zMRhgG4mJcuhByieYWozoCK++R4
	ENNv6xo+sn18xYypSl6jjvil26D/hsM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-5YayGYi0NOqqhJPK7IEXGw-1; Wed, 12 May 2021 11:06:52 -0400
X-MC-Unique: 5YayGYi0NOqqhJPK7IEXGw-1
Received: by mail-wr1-f70.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so10257265wrl.20
        for <mptcp@lists.linux.dev>; Wed, 12 May 2021 08:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eH9euYDF5JaC2/TkYww0ejBmmuySTlP7khIg1NBMYSs=;
        b=nvp28zwBg2C2ksdkLvDq4D0YoVQG3DB0kjxo/YDQaVE1axVhEkStZKxqnxYPdaP6IP
         305wMcsd67GkOZJl4Ffr3b/CtCkyMaTRpjRaBPrHlSwSWoCCB1IQME6apIClEj5FZHs6
         5itdHoduyHu7PFoNsNMdxx4LlJ1ioxU7Mi4Rhm+BE2UN0H1af0CenKIISzznld5I/LMQ
         QXwfp6kW9wumCXuLCZNV/COwYq7oYlVBI8L6fLT14Elov4Qh4Wbui0zR0weEsNpKINk+
         7KiC9SpC5jAxqmHYeFfIgBZHYCg6tztm3lXK/UbZHkPgy2sxZ+wj/2qGNcWtw0c367u3
         OA+w==
X-Gm-Message-State: AOAM531sYj2ZfwxKvoXcvC+7f7vH/VXWNjjNUsfJbSMWO8LQN3JMuIVC
	kebUMLupaEB/g86jF4RopKtzkx8LFsZD7032mf0K3qW8CjNN4iY6LCY2j66mLEEy/8/vk6ccEwI
	AqQmzJ0QQ2YA0rcE=
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr12167853wmq.100.1620832009799;
        Wed, 12 May 2021 08:06:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaXKwtUpxpxyAi6fgwftRTvdbD2OSDfhWAfAoF0Y8AZZxPRoGUT0ijrxfFv/bdtD5dKh9osg==
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr12167437wmq.100.1620832005361;
        Wed, 12 May 2021 08:06:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-107-239.dyn.eolo.it. [146.241.107.239])
        by smtp.gmail.com with ESMTPSA id s6sm7343798wms.0.2021.05.12.08.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:06:44 -0700 (PDT)
Message-ID: <e5bad85c6b9d560f30f094a1b55fa4e901170931.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 1/8] mptcp: enable busypoll from mptcp
 receive path
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Wed, 12 May 2021 17:06:43 +0200
In-Reply-To: <20210512100413.GJ4038@breakpoint.cc>
References: <20210511133659.29982-1-fw@strlen.de>
	 <20210511133659.29982-2-fw@strlen.de>
	 <83bc7a0dc52a0f362489067babfbbb5c4bd083e6.camel@redhat.com>
	 <20210512100413.GJ4038@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Wed, 2021-05-12 at 12:04 +0200, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > On Tue, 2021-05-11 at 15:36 +0200, Florian Westphal wrote:
> > > +	if (sk_can_busy_loop(sk) &&
> > > +	    skb_queue_empty_lockless(&msk->receive_queue) &&
> > > +	    skb_queue_empty_lockless(&sk->sk_receive_queue) &&
> > > +	    inet_sk_state_load(sk) == TCP_ESTABLISHED)
> > > +		sk_busy_loop(sk, nonblock);
> > 
> > If I understand the code correctly, here we need a valid sk-
> > > sk_napi_id. That field is set by the TCP input path
> > in tcp_finish_connect()/tcp_v{4,6}_do_rcv()/tcp_child_process() for the
> > subflow ssk.
> > 
> > I think sk_napi_id is not currently available for the msk?!? 
> > Copying it from the subflow requires some care, as the msk could end-up 
> > busy polling on the 'wrong' napi instance ?!?
> 
> What about:
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -303,6 +303,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
>  		if (tail && mptcp_try_coalesce(sk, tail, skb))
>  			return true;
>  
> +		sk_mark_napi_id_once(sk, skb);
>  		skb_set_owner_r(skb, sk);
>  		__skb_queue_tail(&sk->sk_receive_queue, skb);
>  		return true;
> 
> This sets the napi id to one that provided the last mptcp-in-sequence skb.

I *think* the above sets napi it to the one provided by the first
received skb.

On the flip side, updating it at every packet would probably cause
contention on a 'read mostly' sock cacheline.

What about something as crazy as the following? not even build tested,
but I hope it can illustrate the idea bettern than words.

Than we could call mptcp_busy_loop() instead of sk_busy_loop().

We could also try to be smarter, e.g. fetch all the napi_id in a single
mptcp_for_each_subflow() traversal, and store them in a small, fixed
size array, avoiding duplicate values.

Thinking again of it, this latter strategy looks much better then what
described below...
---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d21a4793d9d..f5d71aae38cc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1960,6 +1960,43 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 	return !skb_queue_empty(&msk->receive_queue);
 }
 
+/* return -1 if nr > avail subflow */
+static int napi_id_by_subflow_nr(struct sock *sk, int nr)
+{
+	bool slow = lock_sock_fast(sk);
+	int id = -1, i = 0;
+
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		if (i++ == nr) {
+			id = READ_ONCE(mptcp_subflow_tcp_sock(subflow)->sk_napi_id);
+			break;
+		}
+	}
+
+	unlock_sock_fast(sk, slow);
+	return id;
+}
+
+static void mptcp_busy_loop(struct sock *sk, bool nonblock)
+{
+	unsigned long start_time = busy_loop_current_time();
+	struct mptcp_subflow_context *subflow;$
+
+	for (;;) {
+		int nr, napi_id = napi_id_by_subflow_nr(sk, 0);
+
+		for (nr = 0; napi_id >= 0 ; napi_id = napi_id_by_subflow_nr(sk, ++nr)) }
+			napi_busy_loop(napi_id, NULL, NULL,
+			       READ_ONCE(sk->sk_prefer_busy_poll),
+			       READ_ONCE(sk->sk_busy_poll_budget) ?: BUSY_POLL_BUDGET);
+			if (skb_queue_empty_lockless(&sk->sk_receive_queue))
+				return;
+		}
+		if (nonblock || sk_busy_loop_end(sk, start_time))
+			return;
+	}
+}
+
 static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			 int nonblock, int flags, int *addr_len)
 {

