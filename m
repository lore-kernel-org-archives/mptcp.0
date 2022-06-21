Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BD3A4E
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655829026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YhWUS7AofkgE8UVdF47Syj4tGzwYAkzAC4h0mPSrpWg=;
	b=e+O4cIj6UkY1jYgb/u1KLW08XX4qlK68M3KIGpha/x7zh21h7MdAxwmdV5fPhSuMb3clHm
	DPuNYVeeiw2BgFsbby+c160n4ig/P1aw5/L+rIPIUC435v0K6NfsOe0xy+Njonp8AkpP8h
	JHucc/QeY5gPMYprE8tykXctCHnjy8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-3oTl5pV9P-urpVisTvSA5Q-1; Tue, 21 Jun 2022 12:30:17 -0400
X-MC-Unique: 3oTl5pV9P-urpVisTvSA5Q-1
Received: by mail-wr1-f70.google.com with SMTP id n7-20020adfc607000000b0021a37d8f93aso3427369wrg.21
        for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 09:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=YhWUS7AofkgE8UVdF47Syj4tGzwYAkzAC4h0mPSrpWg=;
        b=b2D6DR7lY5vgNILowH6TSwH+PcnO23YgL+bmXtux6GGh6/L8GOdxdDlMVGGR/I5259
         JUUiLEjlVrdRfonrA4JvD3hX9LjM4M7cp6ESY2BzYtBpe0of/ln93/daBU5LpWIkz8Lo
         T9IiGBgH5aiSN4InMnVYNoSNbqXH7A33J5oVRzKOI32ShCEuYvwtHggsp3NiG2HLhvcO
         /BVf+VJsbq9m033CIkmN11LBABtGkMzyDp+suYyFe9IhN4RBLP1N9PwH4OhmJfjtFuMM
         lkXbmXvIsMEP11gLnwo+zh5S0xJY31XckfpRfSNgl6hCVHXGTZ1lLEOQU5rX87cuICuk
         xKpw==
X-Gm-Message-State: AJIora+NV6cD0y9N7mRUhfb2eXpjvHUEVrPcleuHU1770f3l3A4cTYx9
	9lVvFvN7T9RJIv1dv7QcNCDyArPDXP2EAGNdw+8tnaVYBwPibqKBE87WXL+jft9KFdh6yQKTk3t
	u3/ZlHGBWsc0kBKM=
X-Received: by 2002:adf:db48:0:b0:21b:9733:e134 with SMTP id f8-20020adfdb48000000b0021b9733e134mr4658025wrj.396.1655829016010;
        Tue, 21 Jun 2022 09:30:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v/1dd501S+sgFIGBSrTXjBGYov4hwfYglpCfmL4y+7RqEiVgGYGFypyTZVjyMQJTlTWQjnUw==
X-Received: by 2002:adf:db48:0:b0:21b:9733:e134 with SMTP id f8-20020adfdb48000000b0021b9733e134mr4657999wrj.396.1655829015696;
        Tue, 21 Jun 2022 09:30:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb0c000000b0021b9100b844sm5567617wrr.91.2022.06.21.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:30:15 -0700 (PDT)
Message-ID: <9550d01e22abd4500b617c16af14a447734a44a3.camel@redhat.com>
Subject: Re: [PATCH mptcp-net v4 6/6] mptcp: fix race on unaccepted mptcp
 sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 21 Jun 2022 18:30:14 +0200
In-Reply-To: <9f5b9672-edd5-2a5c-2db2-886a053d8b2@linux.intel.com>
References: <cover.1655723410.git.pabeni@redhat.com>
	 <6d0c040baa09ca582d78a0a6afc7bba2308fcd98.1655723410.git.pabeni@redhat.com>
	 <9f5b9672-edd5-2a5c-2db2-886a053d8b2@linux.intel.com>
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

On Mon, 2022-06-20 at 15:15 -0700, Mat Martineau wrote:
> On Mon, 20 Jun 2022, Paolo Abeni wrote:
> 
> > When the listener socket owning the relevant request is closed,
> > it frees the unaccepted subflows and that causes later deletion
> > of the paired MPTCP sockets.
> > 
> > The mptcp socket's worker can run in the time interval between such delete
> > operations. When that happens, any access to msk->first will cause an UaF
> > access, as the subflow cleanup did not cleared such field in the mptcp
> > socket.
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
> > v3 -> v4:
> > - use correct lockdep annotation when re-acquiring the listener sock lock
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
> > index 5c87a269af80..2c953703edf2 100644
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
> > +		msk->dl_next = NULL;
> > +		unlock_sock_fast(sk, slow);
> > +	}
> > +	lock_sock(listener_ssk);
> 
> Hi Paolo -
> 
> I think the nested locking fix didn't make it in to v4 as posted? 

I'm not sure what/how that happened. I would swear I edited and
reviewed such change... let's go for a v5, sorry.

Paolo

