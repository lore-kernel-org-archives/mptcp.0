Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5445B7F6
	for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655720124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NC62eavcBfkyF+GTuxYknGDHrwzho+DEDzlWv28EXq8=;
	b=fiw+30iLaM0GC2YU5dJdQKpsg8MgATg29HCo1SozFGXBpx+CadaRU80fg2jkYmhkbqPHfi
	LhcUNvVVIpxD4Xpsl6CKNjhiXunl7DzBh3O2ccX1M9wJAKb7v/+yCjFpb261z6ek4zvSpL
	ZoEgBh/F/l0XYuYuzgj0d0LhTINrwGw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-rWJ8J0stM8a9WzVPY-8ZrQ-1; Mon, 20 Jun 2022 06:15:23 -0400
X-MC-Unique: rWJ8J0stM8a9WzVPY-8ZrQ-1
Received: by mail-qv1-f69.google.com with SMTP id jo22-20020a056214501600b004646309a886so11312701qvb.2
        for <mptcp@lists.linux.dev>; Mon, 20 Jun 2022 03:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NC62eavcBfkyF+GTuxYknGDHrwzho+DEDzlWv28EXq8=;
        b=W2SgWi2vuMR/N5GWzbYh2vpfHffqMQbdht4B6lXFu2/E1S3bx+Q43i6+Zfq59ts9P1
         Stj6u/9wc2KT+ZcYLyY44ziuEkf3TCzQPDwtaAK106N+3WdQdVy8tQoGWJkLA8A1Ymb/
         Q8+dBmmJ+aM51p+Sd1a/hpnIWkjA8aM5KVoEGFt5dSu3BLrcjlScrXGK/TKfYJwV7Rw0
         w5olmFXEoiI/USz6XBQ+3QGX3D18CjdilhR3iStwUqaQkwsO7kCPARkkp+2KMnwqPk7R
         U86ZNrPVW0tIEopcWJzQRNxqbjECbdvaN4tiXqrbcZHtAaR/3C0doAIMJi1HwCq5Ej01
         kDvA==
X-Gm-Message-State: AJIora89svDkXJMFP8cZkszhlcPfV7fwo90AUZbsMsdOF3Qek3pBOyj2
	5iLQf1FBKri6MX0K8jRG3uNpIyJ24/BHVAFn53oNHeORmUSNDyScmcO+Nq6UrrYXshZlkCreRVZ
	EXkD3O+NwFTUsoDI=
X-Received: by 2002:a05:620a:d83:b0:6a7:a68c:6118 with SMTP id q3-20020a05620a0d8300b006a7a68c6118mr15432242qkl.337.1655720122323;
        Mon, 20 Jun 2022 03:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u5bWlScrhnWQuexLVxWyY8mAtsUEjDITFPhiya/kytQbjvlJsNGUMW+znB8EtrothFYKuyBw==
X-Received: by 2002:a05:620a:d83:b0:6a7:a68c:6118 with SMTP id q3-20020a05620a0d8300b006a7a68c6118mr15432227qkl.337.1655720121933;
        Mon, 20 Jun 2022 03:15:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id de7-20020a05620a370700b0069fc13ce235sm11270327qkb.102.2022.06.20.03.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 03:15:21 -0700 (PDT)
Message-ID: <54f723756f4b4da8827649b6c2f11187e93bf050.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v3 6/6] mptcp: fix race on unaccepted mptcp
 sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Mon, 20 Jun 2022 12:15:18 +0200
In-Reply-To: <cae3fd3-d3f9-c57-8fe8-12c6a215e9fa@linux.intel.com>
References: <cover.1655460262.git.pabeni@redhat.com>
	 <dd32766a57e98209da3257e9c68980a3b8727797.1655460262.git.pabeni@redhat.com>
	 <cae3fd3-d3f9-c57-8fe8-12c6a215e9fa@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

On Fri, 2022-06-17 at 17:51 -0700, Mat Martineau wrote:
> On Fri, 17 Jun 2022, Paolo Abeni wrote:
> 
> > When the listener socket owning the relevant request is closed,
> > it frees the unaccepted subflows and that causes later deletion
> > of the paired MPTCP sockets.
> > 
> > The mptcp socket's worker can run in the time interval between such delete
> > operations. When that happens, any access to msk->first will cause an UaF
> > access, as the subflow cleanup did not cleared such field in the mptcp
> > socket.
> 
> Did you run in to this UaF in a self test? 

IIRC, via packetdril

> Was it possible before this patch series?

Yes, AFAICS since the commit mentioned in the fixes tag. What really
change is the frequency. With this series it become almost
deterministic, while before this series was very hard to trigger.

> > 
> > Address the issue explictly traversing the listener socket accept
> > queue at close time and performing the needed cleanup on the pending
> > msk.
> > 
> > Note that the locking is a bit tricky, as we need to acquire the msk
> > socket lock, while still owning the subflow socket one.
> > 
> > Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c |  5 +++++
> > net/mptcp/protocol.h |  2 ++
> > net/mptcp/subflow.c  | 50 ++++++++++++++++++++++++++++++++++++++++++++
> > 3 files changed, 57 insertions(+)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 00ba9c44933a..6d2aa41390e7 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -2318,6 +2318,11 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > 		kfree_rcu(subflow, rcu);
> > 	} else {
> > 		/* otherwise tcp will dispose of the ssk and subflow ctx */
> > +		if (ssk->sk_state == TCP_LISTEN) {
> > +			tcp_set_state(ssk, TCP_CLOSE);
> > +			mptcp_subflow_queue_clean(ssk);
> > +			inet_csk_listen_stop(ssk);
> > +		}
> > 		__tcp_close(ssk, 0);
> > 
> > 		/* close acquired an extra ref */
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index ad9b02b1b3e6..95c9ace1437b 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -306,6 +306,7 @@ struct mptcp_sock {
> > 
> > 	u32 setsockopt_seq;
> > 	char		ca_name[TCP_CA_NAME_MAX];
> > +	struct mptcp_sock	*dl_next;
> > };
> > 
> > #define mptcp_data_lock(sk) spin_lock_bh(&(sk)->sk_lock.slock)
> > @@ -610,6 +611,7 @@ void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> > 		     struct mptcp_subflow_context *subflow);
> > void mptcp_subflow_send_ack(struct sock *ssk);
> > void mptcp_subflow_reset(struct sock *ssk);
> > +void mptcp_subflow_queue_clean(struct sock *ssk);
> > void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> > struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
> > 
> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index 1e182301e58b..db83db1b3c4c 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -1723,6 +1723,56 @@ static void subflow_state_change(struct sock *sk)
> > 	}
> > }
> > 
> > +void mptcp_subflow_queue_clean(struct sock *listener_ssk)
> > +{
> > +	struct request_sock_queue *queue = &inet_csk(listener_ssk)->icsk_accept_queue;
> > +	struct mptcp_sock *msk, *next, *head = NULL;
> > +	struct request_sock *req;
> > +
> > +	/* build a list of all unaccepted mptcp sockets */
> > +	spin_lock_bh(&queue->rskq_lock);
> > +	for (req = queue->rskq_accept_head; req; req = req->dl_next) {
> > +		struct mptcp_subflow_context *subflow;
> > +		struct sock *ssk = req->sk;
> > +		struct mptcp_sock *msk;
> > +
> > +		if (!sk_is_mptcp(ssk))
> > +			continue;
> > +
> > +		subflow = mptcp_subflow_ctx(ssk);
> > +		if (!subflow || !subflow->conn)
> > +			continue;
> > +
> > +		/* skip if already in list */
> > +		msk = mptcp_sk(subflow->conn);
> > +		if (msk->dl_next || msk == head)
> > +			continue;
> > +
> > +		msk->dl_next = head;
> 
> Why is it ok to read/modify msk->dl_next without the msk locked here, but 
> the msk lock is needed below?

the dl_next field is protected from the listener socket lock. Such lock
is held both here and below, see the caller of this function.
> 
> Are the only msks in this queue created by incoming MP_CAPABLE SYNs? 

The queue contains only the subflows, and specifically the MPC
subflows. MPJ subflows never land into the request queue - the helper
inserting the req_sk there is inet_csk_reqsk_queue_add(), invoked by
tcp_check_req() via inet_csk_complete_hashdance().

> Or 
> could MP_JOIN subflow request socks be involved too, which would have 
> msk->first pointers to completely different listener ssks?

msk->first does not point to the listener socket, it points to the mpc
subflow (ssk, in the above code).
> 
> 
> > +		head = msk;
> > +	}
> > +	spin_unlock_bh(&queue->rskq_lock);
> > +	if (!head)
> > +		return;
> > +
> > +	/* can't acquire the msk socket lock under the subflow one,
> > +	 * or will cause ABBA deadlock
> > +	 */
> > +	release_sock(listener_ssk);
> > +
> > +	for (msk = head; msk; msk = next) {
> > +		struct sock *sk = (struct sock *)msk;
> > +		bool slow;
> > +
> > +		slow = lock_sock_fast_nested(sk);
> > +		next = msk->dl_next;
> > +		msk->first = NULL;
> 
> Related to my question above, does it make sense to check that msk->first 
> == listener_ssk before setting to NULL?

should be msk->first == ssk, in the previous loop. Should be
rendundant, too. See subflow_syn_recv_sock().
> 
> 
> > +		msk->dl_next = NULL;
> > +		unlock_sock_fast(sk, slow);
> > +	}
> > +	lock_sock(listener_ssk);
> 
> The lock being re-acquired here was locked by the caller using:
> 
> lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> 
> Should that notation be used here too?

Indeed, that is needed. I'll send a v4.

Thanks!

Paolo

