Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2770
	for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 08:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623832111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7HO6xSPlzpMqltjlaDW87NkjKpJyR1JuOm4gSFAQsuI=;
	b=PeA9CbetAsFLVV429s3ggtaTpLwVvhVKrejDXIDSpiVe/VuuHKGPE7Bm/gAQvlM6ujzqZg
	ZfhsOGIB7UMAq7rfAxiYRarheOcAEEFcBqwAla+Mns9+gR+iWdWv0+InVV7itYqDhcJny1
	/q07lxCP9LK/Us677xAO+PeUOlhjAlE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-UoQRVACtOAaWX7Vk3p-2Hg-1; Wed, 16 Jun 2021 04:28:29 -0400
X-MC-Unique: UoQRVACtOAaWX7Vk3p-2Hg-1
Received: by mail-wr1-f71.google.com with SMTP id n4-20020a5d42040000b0290119fef97609so752161wrq.18
        for <mptcp@lists.linux.dev>; Wed, 16 Jun 2021 01:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7HO6xSPlzpMqltjlaDW87NkjKpJyR1JuOm4gSFAQsuI=;
        b=k2mORPyqYQRfOIzy5mVihjw92e9MHFLHpmNsVDkZGWhZEHDEIy/sQxnlElBMSuuMar
         SsA6RVmITLnuZUxYY8ri74809//kkWT3+OOxRJvs1I7UL0x1fBE+Pt739cNGJ/lVWm/S
         yOnFaFK6Z5TPYyj9tUQgrf+vGiH01tQXbFkSnx667URwOVT47hyeL6sG1xU22XRRG0zr
         p8aK9PVaEu5Wk7I5sG96Ahn/mqQrTPnnFuJnn+jjKqWPx+f95sLH/nPYfNpTzt9f6OaJ
         JAEDB4alxdlXj7QWiP8R1w5nxUS3ubZA3nrf6cxOAPJn1ALyDnKt1ZCSH/vkvtezY8XJ
         6lvA==
X-Gm-Message-State: AOAM5303ZusE75OYygjq+fwKwlTbOD15/rVMqYCY7yF+e+SbSoGkGMIb
	mOaeUHtGVEYHr/1vmlg3+53PQjrBhU/62dBRH//b2CtUHiqhH4cUzLMMriEJAA9z0Akmsf1ksFy
	KzOkfiZvjwXQqA2k=
X-Received: by 2002:a05:600c:4f10:: with SMTP id l16mr3978191wmq.5.1623832108800;
        Wed, 16 Jun 2021 01:28:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFNblw73XPnRSpTuupzqddE4W0MByoBzeCXg3/XjIhufhEslLZe0eVuO24HONGi8/pD7q8xA==
X-Received: by 2002:a05:600c:4f10:: with SMTP id l16mr3978171wmq.5.1623832108565;
        Wed, 16 Jun 2021 01:28:28 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id p12sm4104741wme.43.2021.06.16.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 01:28:28 -0700 (PDT)
Message-ID: <7995482e34d40e6b4b427dd965781498c252d688.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 16 Jun 2021 10:28:27 +0200
In-Reply-To: <e9bfd7b4-4a9-5a6-1f7b-e25db9d19a@linux.intel.com>
References: <10bbc75802301770d24a9d74b7800f491e7b67f9.1623420606.git.pabeni@redhat.com>
	 <e9bfd7b4-4a9-5a6-1f7b-e25db9d19a@linux.intel.com>
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

On Tue, 2021-06-15 at 14:26 -0700, Mat Martineau wrote:
> On Fri, 11 Jun 2021, Paolo Abeni wrote:
> 
> > The current cleanup rbuf tries a bit too hard to avoid acquiring
> > the subflow socket lock. We may end-up delaying the needed ack,
> > or skip acking a blocked subflow.
> > 
> > Address the above extending the conditions used to trigger the cleanup
> > to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
> > on all the active subflows.
> > 
> > Note that we can't replicate the exact tests implemented in
> > tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
> > ping-pong mode.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v1 -> v2:
> > - access ssk icsk/tp state instead of msk (Mat)
> > ---
> > net/mptcp/protocol.c | 49 +++++++++++++++++++-------------------------
> > net/mptcp/protocol.h |  1 -
> > 2 files changed, 21 insertions(+), 29 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 0a220862f62d..1dc3a0cb653d 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -455,36 +455,36 @@ static bool mptcp_subflow_cleanup_rbuf(struct sock *ssk)
> > 	return ret;
> > }
> > 
> > +static bool mptcp_subflow_could_cleanup(const struct sock *ssk, bool rx_empty)
> > +{
> > +	const struct inet_connection_sock *icsk = inet_csk(ssk);
> > +	bool ack_pending = READ_ONCE(icsk->icsk_ack.pending);
> > +	const struct tcp_sock *tp = tcp_sk(ssk);
> > +
> > +	return (ack_pending & ICSK_ACK_SCHED) &&
> > +		((READ_ONCE(tp->rcv_nxt) - READ_ONCE(tp->rcv_wup) >
> > +		  READ_ONCE(icsk->icsk_ack.rcv_mss)) ||
> > +		 (rx_empty && ack_pending &
> > +			      (ICSK_ACK_PUSHED2 | ICSK_ACK_PUSHED)));
> > +}
> > +
> > static void mptcp_cleanup_rbuf(struct mptcp_sock *msk)
> > {
> > -	struct sock *ack_hint = READ_ONCE(msk->ack_hint);
> > 	int old_space = READ_ONCE(msk->old_wspace);
> > 	struct mptcp_subflow_context *subflow;
> > 	struct sock *sk = (struct sock *)msk;
> > -	bool cleanup;
> > +	int space =  __mptcp_space(sk);
> > +	bool cleanup, rx_empty;
> > 
> > -	/* this is a simple superset of what tcp_cleanup_rbuf() implements
> > -	 * so that we don't have to acquire the ssk socket lock most of the time
> > -	 * to do actually nothing
> > -	 */
> > -	cleanup = __mptcp_space(sk) - old_space >= max(0, old_space);
> > -	if (!cleanup)
> > -		return;
> > +	cleanup = (space > 0) && (space >= (old_space << 1));
> > +	rx_empty = !atomic_read(&sk->sk_rmem_alloc);
> > 
> > -	/* if the hinted ssk is still active, try to use it */
> > -	if (likely(ack_hint)) {
> > -		mptcp_for_each_subflow(msk, subflow) {
> > -			struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > 
> > -			if (ack_hint == ssk && mptcp_subflow_cleanup_rbuf(ssk))
> > -				return;
> > -		}
> > +		if (cleanup || mptcp_subflow_could_cleanup(ssk, rx_empty))
> > +			mptcp_subflow_cleanup_rbuf(ssk);
> 
> The return value of mptcp_subflow_cleanup_rbuf() is ignored now, so that 
> function can be changed to remove the 'ret' variable and return void.

ok

> > 	}
> > -
> > -	/* otherwise pick the first active subflow */
> > -	mptcp_for_each_subflow(msk, subflow)
> > -		if (mptcp_subflow_cleanup_rbuf(mptcp_subflow_tcp_sock(subflow)))
> > -			return;
> > }
> > 
> > static bool mptcp_check_data_fin(struct sock *sk)
> > @@ -629,7 +629,6 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> > 			break;
> > 		}
> > 	} while (more_data_avail);
> > -	WRITE_ONCE(msk->ack_hint, ssk);
> > 
> > 	*bytes += moved;
> > 	return done;
> > @@ -1910,7 +1909,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> > 		__mptcp_update_rmem(sk);
> > 		done = __mptcp_move_skbs_from_subflow(msk, ssk, &moved);
> > 		mptcp_data_unlock(sk);
> > -		tcp_cleanup_rbuf(ssk, moved);
> > 
> > 		if (unlikely(ssk->sk_err))
> > 			__mptcp_error_report(sk);
> > @@ -1926,7 +1924,6 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
> > 		ret |= __mptcp_ofo_queue(msk);
> > 		__mptcp_splice_receive_queue(sk);
> > 		mptcp_data_unlock(sk);
> > -		mptcp_cleanup_rbuf(msk);
> 
> Removing this call and the tcp_cleanup_rbuf() in the hunk above does mean 
> there are fewer opportunites to cleanup/ack, but it looks like those were 
> "extra" calls most of the time. With the location of the one call to 
> mptcp_cleanup_rbuf() in mptcp_recvmsg() it shouldn't make much difference 
> unless __mptcp_recvmsg_mskq() returns an error. Would it make sense to 
> move the call to mptcp_cleanup_rbuf() to immediately follow 
> __mptcp_recvmsg_mskq(), before checking for errors?

AFAICS, tcp_cleanup_rbuf() can take action only after that the user-
space removed some data out of the receive queue.

I added the above *tcp_cleanup_rbuf() - IIRC - because back then I
misunderstood moving data out of the subflow receive queue would be
relevant. It's not, as each subflow tcp_cleanup_rbuf() will look inside
the msk receive usage to take action.

If __mptcp_recvmsg_mskq() returns an error, it moved no data out of the
msk receive queue, so should not need any additional
mptcp_cleanup_rbuf() call.

WDYT?

Thanks!

/P

