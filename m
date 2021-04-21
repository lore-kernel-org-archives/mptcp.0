Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2062F9B
	for <mptcp@lists.linux.dev>; Wed, 21 Apr 2021 08:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618992214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwzP5bq0VU1RpdKenyiVlvI/+qhJIOIRJrd3ESjzOkA=;
	b=bQuZsfpthZFY4DuXLluS5mhHUHsjhgbmmuJNIxOkaYiB+6KR9x3abFB4HWKPtCMFipcitR
	6CSJKrjAJzF2p4teaSLaU6ZHH4qlqKMrse+5KXv20kqHHSnfi7IQVL90r5hFGI2CzOv67C
	dJzxNUMkSMKWSEn+wH9BWoGDxMqDAsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-TBLS7LUxPzallrAGyTAviQ-1; Wed, 21 Apr 2021 04:03:24 -0400
X-MC-Unique: TBLS7LUxPzallrAGyTAviQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75B159154C2;
	Wed, 21 Apr 2021 08:01:09 +0000 (UTC)
Received: from ovpn-113-128.ams2.redhat.com (ovpn-113-128.ams2.redhat.com [10.36.113.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ECDC72966F;
	Wed, 21 Apr 2021 08:01:06 +0000 (UTC)
Message-ID: <1cae9ed8392577adab3e20fd6904a1a0af7176ab.camel@redhat.com>
Subject: Re: [PATCH] mptcp: store remote token in mptcp sock
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, matthieu.baerts@tessares.net, Florian Westphal
	 <fw@strlen.de>
Date: Wed, 21 Apr 2021 10:01:05 +0200
In-Reply-To: <28677691-e7f6-4192-d6c1-41e3087c5509@163.com>
References: <4e1d608e-4bcd-a432-03b7-860cd3e007c2@163.com>
	 <4cf0e328-db13-9c37-e87f-f84910d01070@linux.intel.com>
	 <28677691-e7f6-4192-d6c1-41e3087c5509@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2021-04-21 at 09:43 +0800, Jianguo Wu wrote:
> On 2021/4/21 9:01, Mat Martineau wrote:
> > On Tue, 20 Apr 2021, Jianguo Wu wrote:
> > 
> > > From: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > 
> > > Now every time create a new subflow, it needs to generate remote
> > > token in __mptcp_subflow_connect(), the remote token is the same
> > > among all subflows in a mptcp connection, so we can store
> > > remote token in mptcp sock.
> > > 
> > > Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> > > ---
> > > net/mptcp/protocol.c | 5 +++--
> > > net/mptcp/protocol.h | 1 +
> > > net/mptcp/subflow.c  | 7 +++----
> > > 3 files changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > > index a8180a9..607fb30 100644
> > > --- a/net/mptcp/protocol.c
> > > +++ b/net/mptcp/protocol.c
> > > @@ -2736,7 +2736,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> > >     if (mp_opt->mp_capable) {
> > >         msk->can_ack = true;
> > >         msk->remote_key = mp_opt->sndr_key;
> > > -        mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
> > > +        mptcp_crypto_key_sha(msk->remote_key, &msk->remote_token, &ack_seq);
> > >         ack_seq++;
> > >         WRITE_ONCE(msk->ack_seq, ack_seq);
> > >         WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> > > @@ -2967,7 +2967,7 @@ void mptcp_finish_connect(struct sock *ssk)
> > > 
> > >     pr_debug("msk=%p, token=%u", sk, subflow->token);
> > > 
> > > -    mptcp_crypto_key_sha(subflow->remote_key, NULL, &ack_seq);
> > > +    mptcp_crypto_key_sha(subflow->remote_key, &subflow->remote_token, &ack_seq);
> > >     ack_seq++;
> > >     subflow->map_seq = ack_seq;
> > >     subflow->map_subflow_seq = 1;
> > > @@ -2976,6 +2976,7 @@ void mptcp_finish_connect(struct sock *ssk)
> > >      * accessing the field below
> > >      */
> > >     WRITE_ONCE(msk->remote_key, subflow->remote_key);
> > > +    WRITE_ONCE(msk->remote_token, subflow->remote_token);
> > >     WRITE_ONCE(msk->local_key, subflow->local_key);
> > >     WRITE_ONCE(msk->write_seq, subflow->idsn + 1);
> > >     WRITE_ONCE(msk->snd_nxt, msk->write_seq);
> > > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > > index edc0128..abd8e31 100644
> > > --- a/net/mptcp/protocol.h
> > > +++ b/net/mptcp/protocol.h
> > > @@ -226,6 +226,7 @@ struct mptcp_sock {
> > >     u64        wnd_end;
> > >     unsigned long    timer_ival;
> > >     u32        token;
> > > +    u32        remote_token;
> > >     int        rmem_released;
> > >     unsigned long    flags;
> > >     bool        can_ack;
> > > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > > index 82e91b0..ddd8c03 100644
> > > --- a/net/mptcp/subflow.c
> > > +++ b/net/mptcp/subflow.c
> > > @@ -1046,6 +1046,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> > >                 goto fatal;
> > >             }
> > >             WRITE_ONCE(msk->remote_key, subflow->remote_key);
> > > +            mptcp_crypto_key_sha(READ_ONCE(msk->remote_key), &msk->remote_token, NULL);
> > 
> > Hi Jianguo, thanks for your patch.
> > 
> > This adds a possible extra SHA calculation in this function, on the server side of a connection that may not ever use the token. This code path is only encountered in rare conditions, though: when an MP_CAPABLE+data packet is late, retransmitted, or out-of-order.
> > 
> > (also, if we move ahead with this patch, the token should be written to a local variable and then copied to msk->remote_token using WRITE_ONCE(). Would also be more efficient to pass subflow->remote_key as the first arg because there's no READ_ONCE() required to read from the subflow structure)
> > 
> > >             WRITE_ONCE(msk->ack_seq, subflow->map_seq);
> > >             WRITE_ONCE(msk->can_ack, true);
> > >         }
> > > @@ -1268,7 +1269,6 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> > >     int local_id = loc->id;
> > >     struct socket *sf;
> > >     struct sock *ssk;
> > > -    u32 remote_token;
> > >     int addrlen;
> > >     int err;
> > > 
> > > @@ -1308,10 +1308,9 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
> > >     if (err)
> > >         goto failed;
> > > 
> > > -    mptcp_crypto_key_sha(subflow->remote_key, &remote_token, NULL);
> > >     pr_debug("msk=%p remote_token=%u local_id=%d remote_id=%d", msk,
> > > -         remote_token, local_id, remote_id);
> > > -    subflow->remote_token = remote_token;
> > > +         msk->remote_token, local_id, remote_id);
> > > +    subflow->remote_token = msk->remote_token;
> > 
> > And here, I think, is the tradeoff: with this patch, there is no need to recalculate the SHA on every outgoing join. That's more common on the client side of a connection, where there will not be a large number of joins initiated so the cost is not very high.
> > 
> > Given the client/server tradeoff and the likely small number of joins on any given connection, do you think this is worth changing?
> 
> Hi Mat, thanks for your comments!
> 
> I think, with high CPS, it can reduce lots of recalculation, and in
> some scenarios, such as the middle mile, server side can also
> initiate join subflows,

Uhmm... In the connections/rate performance test I did, the crypto-
related overhead was quite low, almost un-noticeable. Do you have any
perf figures for the above scenario (e.g. perf report or flamegraph)?

Additionally, could you please describe the usage scenario with more
details? Is that a transparent TCP-MPTCP proxy? or what else?

> maybe we can generate the token on the first outgoing join and store
> in msk->remote_token, then the following outgoing joins can reuse
> msk->remote_token?

How many subflows do you expect for each MPTCP connections? the above
will provide no gain with the typical 2-subflows use-case.

Thanks!

Paolo

