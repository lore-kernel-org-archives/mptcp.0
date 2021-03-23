Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199A5F
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 10:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616494357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZOorljexBWNX8Je2eueoeLIpGuIhsRxtvbeLnQvwzI=;
	b=JtF0TFDbYv1Fwc3aDRnJUcmMf6SMxQLUOMdzYxyrgtUj7C8pe2rZVZE0tsVLKTFNOQD+Jv
	9qqakkyqzIhltnX/Y0iRTfX6Auhg8duSGYuRnxzzzYSyZ/i04LReMfovjYcRGa6aZfXTdb
	4kU+7qjZGbrzlC3dGxy1+UoLvv6mFsw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-n07Gk5JaMfK7nFnqzFL1Gg-1; Tue, 23 Mar 2021 06:12:34 -0400
X-MC-Unique: n07Gk5JaMfK7nFnqzFL1Gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8873980006E;
	Tue, 23 Mar 2021 10:12:33 +0000 (UTC)
Received: from ovpn-114-241.ams2.redhat.com (ovpn-114-241.ams2.redhat.com [10.36.114.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B5833805;
	Tue, 23 Mar 2021 10:12:32 +0000 (UTC)
Message-ID: <4e71ee0d3af1cac20d27c5b200bb615395630b51.camel@redhat.com>
Subject: Re: [MPTCP] [MPTCP][PATCH mptcp-next 3/6] mptcp: add the csum_reqd
 fields
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev, Florian Westphal <fwestpha@redhat.com>
Date: Tue, 23 Mar 2021 11:12:31 +0100
In-Reply-To: <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com>
	 <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
	 <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
	 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-03-22 at 19:37 +0800, Geliang Tang wrote:
> This patch added a new flag csum_reqd in struct mptcp_options_received, if
> the flag MPTCP_CAP_CHECKSUM_REQD is set in the receiving MP_CAPABLE
> suboption, set this csum_reqd flag.
> 
> It also added another new csum_reqd member in struct mptcp_sock too, if the
> csum_reqd flag in mptcp_options_received is set, set this member to true.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/options.c  | 8 +++++---
>  net/mptcp/protocol.c | 1 +
>  net/mptcp/protocol.h | 2 ++
>  net/mptcp/subflow.c  | 4 ++++
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index f45bebb923dc..bdced173edff 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -69,11 +69,9 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  		 * "If a checksum is not present when its use has been
>  		 * negotiated, the receiver MUST close the subflow with a RST as
>  		 * it is considered broken."
> -		 *
> -		 * We don't implement DSS checksum - fall back to TCP.
>  		 */
>  		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> -			break;
> +			mp_opt->csum_reqd = 1;
>  
>  		mp_opt->mp_capable = 1;
>  		if (opsize >= TCPOLEN_MPTCP_MPC_SYNACK) {
> @@ -340,6 +338,7 @@ void mptcp_get_options(const struct sk_buff *skb,
>  	mp_opt->dss = 0;
>  	mp_opt->mp_prio = 0;
>  	mp_opt->reset = 0;
> +	mp_opt->csum_reqd = 0;
>  
>  	length = (th->doff * 4) - sizeof(struct tcphdr);
>  	ptr = (const unsigned char *)(th + 1);
> @@ -1013,6 +1012,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		mptcp_schedule_work((struct sock *)msk);
>  	}
>  
> +	if (mp_opt.csum_reqd)
> +		WRITE_ONCE(msk->csum_reqd, true);
> +
>  	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
>  		if (!mp_opt.echo) {
>  			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d7e7e13fba8..94c3568c7a60 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2364,6 +2364,7 @@ static int __mptcp_init_sock(struct sock *sk)
>  	msk->ack_hint = NULL;
>  	msk->first = NULL;
>  	inet_csk(sk)->icsk_sync_mss = mptcp_sync_mss;
> +	WRITE_ONCE(msk->csum_reqd, mptcp_is_checksum_enabled(sock_net(sk)));
>  
>  	mptcp_pm_data_init(msk);
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 14f1e2fd3c08..4fc4871595ef 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -132,6 +132,7 @@ struct mptcp_options_received {
>  		rm_addr : 1,
>  		mp_prio : 1,
>  		echo : 1,
> +		csum_reqd : 1,
>  		backup : 1;
>  	u32	token;
>  	u32	nonce;
> @@ -233,6 +234,7 @@ struct mptcp_sock {
>  	bool		snd_data_fin_enable;
>  	bool		rcv_fastclose;
>  	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
> +	bool		csum_reqd;
>  	spinlock_t	join_list_lock;
>  	struct sock	*ack_hint;
>  	struct work_struct work;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e2e9cc34713d..9fec1a273100 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -403,6 +403,8 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
>  			goto fallback;
>  		}
>  
> +		if (mp_opt.csum_reqd)
> +			WRITE_ONCE(mptcp_sk(parent)->csum_reqd, true);
>  		subflow->mp_capable = 1;
>  		subflow->can_ack = 1;
>  		subflow->remote_key = mp_opt.sndr_key;
> @@ -643,6 +645,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>  		new_msk = mptcp_sk_clone(listener->conn, &mp_opt, req);
>  		if (!new_msk)
>  			fallback = true;
> +		else if (mp_opt.csum_reqd)
> +			WRITE_ONCE(mptcp_sk(new_msk)->csum_reqd, true);

I think this chunk would be better located inside mptcp_sk_clone(). 

@Mat, @Florian, slighly related: if we do the assignment there, the
WRITE_ONCE will not be required, right? - since that functions runs
under msk lock. We already have a few WRITE_ONCE there which are likely
not really needed...

/P

