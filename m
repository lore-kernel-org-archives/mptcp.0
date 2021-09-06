Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224A3FC0
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1630912245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/F9RUCNJhR0YTd4dqQtXNk1LZUovURWXiVbgp4iOmx8=;
	b=CXO5f1jiqOWwhzJR8Rnuwq9nYRBui73bBaHHRhFM3/7acl7O6rf7fdZa3zub8rKGE11TP4
	LcI4EaoC6yTBER2jl54ulYDjF9aKd2hyeIgRmZzNCvTO0PQEM9ecFGCGjY1zFpoMWPfA/9
	JcXtHBIBL7+Gg9FS3jUJt4uaPaOVmyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-J4qHuy-BP2G39ThxRrRuQA-1; Mon, 06 Sep 2021 03:10:44 -0400
X-MC-Unique: J4qHuy-BP2G39ThxRrRuQA-1
Received: by mail-wr1-f72.google.com with SMTP id z16-20020adfdf90000000b00159083b5966so893974wrl.23
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/F9RUCNJhR0YTd4dqQtXNk1LZUovURWXiVbgp4iOmx8=;
        b=Th4ZGkHLKQVXXzVYJ21iEZgGLZRBipMch4MW+o39BTgEjotBxbtmTZlm+StVYVBSXI
         dL9Z8uJW+ebunv9dezoZ8K02nQrLn6S2eVTspOVbsQjVZrYjePTVw2GWsH0VFsTzBfeo
         Nl0vAi+yTXOGon4krWCckFA+0BLLJKhmGTSojphAtd0R/Y1A9UozPxgtMJrvIREuZKw+
         mXssTKdGWYZkMRsnkAMBO5DBkH/aRbu7pWM2dDxJtBn/1XtidKeFu7fhD9LLv1fAPn2X
         AwqkzTK/8TrS1OzV1IDr6K4425WF1qHOVnezppae6JlMEBRXqP0cvLkye0JDVXD/Bz3d
         oYmA==
X-Gm-Message-State: AOAM532S+Q8dwnzjtpxdy64HsXwzYVtC/Y0yH4HdAkCnZ7kZ04AdwqpZ
	fQsBvdQMera1vHGan7rwbuXFDmqq0QvnLL7vCWZ72DD7JyitknAEhhwHtNFbNyK6BZGq5wjUdao
	Twdi1QllNL7+XGnA=
X-Received: by 2002:a1c:2086:: with SMTP id g128mr9914702wmg.46.1630912242686;
        Mon, 06 Sep 2021 00:10:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoFnmfJQBGC9xjE/sqaML149CLeBqXmXi/xTnIBPHYefk9dh7vGwRc3ncA7ndoTA06Cmxpdw==
X-Received: by 2002:a1c:2086:: with SMTP id g128mr9914687wmg.46.1630912242414;
        Mon, 06 Sep 2021 00:10:42 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-185.dyn.eolo.it. [146.241.233.185])
        by smtp.gmail.com with ESMTPSA id l15sm6192125wms.38.2021.09.06.00.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:10:42 -0700 (PDT)
Message-ID: <0f89768f2901544563989dec7c23d880a8f833f3.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 2/4] mptcp: stop relaying on
 tcp_tx_skb_cache.
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev
Date: Mon, 06 Sep 2021 09:10:41 +0200
In-Reply-To: <9f09512c-0d95-2869-57bb-ffb538ead9b9@tessares.net>
References: <cover.1630595171.git.pabeni@redhat.com>
	 <ae127a2e3d2fb31e6f1687cb96128d39490f6be0.1630595171.git.pabeni@redhat.com>
	 <9f09512c-0d95-2869-57bb-ffb538ead9b9@tessares.net>
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

On Sat, 2021-09-04 at 10:00 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 02/09/2021 17:52, Paolo Abeni wrote:
> > We want to revert the skb TX cache, but MPTCP is currently
> > using it unconditionally.
> > 
> > Rework the MPTCP tx code, so that tcp_tx_skb_cache is not
> > needed anymore: do the whole coalescing check, skb allocation
> > skb initialization/update inside mptcp_sendmsg_frag(), quite
> > alike the current TCP code.
> 
> (...)
> 
> > @@ -1287,23 +1280,29 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> >  			      struct mptcp_sendmsg_info *info)
> >  {
> >  	u64 data_seq = dfrag->data_seq + info->sent;
> > +	int offset = dfrag->offset + info->sent;
> >  	struct mptcp_sock *msk = mptcp_sk(sk);
> >  	bool zero_window_probe = false;
> >  	struct mptcp_ext *mpext = NULL;
> > -	struct sk_buff *skb, *tail;
> > -	bool must_collapse = false;
> > -	int size_bias = 0;
> > -	int avail_size;
> > -	size_t ret = 0;
> > +	bool can_coalesce = false;
> > +	bool reuse_skb = true;
> > +	struct sk_buff *skb;
> > +	size_t copy;
> > +	int i;
> >  
> >  	pr_debug("msk=%p ssk=%p sending dfrag at seq=%llu len=%u already sent=%u",
> >  		 msk, ssk, dfrag->data_seq, dfrag->data_len, info->sent);
> >  
> > +	if (WARN_ON_ONCE(info->sent > info->limit ||
> > +			 info->limit > dfrag->data_len))
> > +		return 0;
> > +
> >  	/* compute send limit */
> >  	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
> > -	avail_size = info->size_goal;
> > +	copy = info->size_goal;
> > +
> >  	skb = tcp_write_queue_tail(ssk);
> > -	if (skb) {
> > +	if (skb && (copy > skb->len)) {
> >  		/* Limit the write to the size available in the
> >  		 * current skb, if any, so that we create at most a new skb.
> >  		 * Explicitly tells TCP internals to avoid collapsing on later
> > @@ -1316,53 +1315,76 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
> >  			goto alloc_skb;
> >  		}
> >  
> > -		must_collapse = (info->size_goal - skb->len > 0) &&
> > -				(skb_shinfo(skb)->nr_frags < sysctl_max_skb_frags);
> > -		if (must_collapse) {
> > -			size_bias = skb->len;
> > -			avail_size = info->size_goal - skb->len;
> > +		i = skb_shinfo(skb)->nr_frags;
> > +		can_coalesce = skb_can_coalesce(skb, i, dfrag->page, offset);
> > +		if (!can_coalesce && i >= sysctl_max_skb_frags) {
> > +			tcp_mark_push(tcp_sk(ssk), skb);
> > +			goto alloc_skb;
> >  		}
> > -	}
> >  
> > +		copy -= skb->len;
> > +	} else {
> >  alloc_skb:
> > -	if (!must_collapse && !ssk->sk_tx_skb_cache &&
> > -	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
> > -		return 0;
> > +		skb = mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held);
> > +		if (!skb)
> > +			return -ENOMEM;
> > +
> > +		i = skb_shinfo(skb)->nr_frags;
> > +		reuse_skb = false;
> > +		mpext = skb_ext_find(skb, SKB_EXT_MPTCP);
> > +	}
> >  
> >  	/* Zero window and all data acked? Probe. */
> > -	avail_size = mptcp_check_allowed_size(msk, data_seq, avail_size);
> > -	if (avail_size == 0) {
> > +	copy = mptcp_check_allowed_size(msk, data_seq, copy);
> > +	if (copy == 0) {
> >  		u64 snd_una = READ_ONCE(msk->snd_una);
> >  
> > -		if (skb || snd_una != msk->snd_nxt)
> > +		if (skb || snd_una != msk->snd_nxt) {
> 
> If I'm not mistaken, 'skb' will always be != NULL here.
> 
> Should we only have these 2 next lines if 'copy == 0'?

We still need to check for 'snd_una != msk->snd_nxt'. I'll send a
squash-to patch.

Thanks!

Paolo

