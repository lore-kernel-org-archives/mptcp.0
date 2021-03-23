Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68B6E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 10:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616496106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xoz4ay3XAYEMC+DL96b1yE6b1aWFqfnSPCNUXJ4MfX4=;
	b=A1o8cLGDSllhahHov38nirhQMlay/QW59l45nXDaJrDKAKK1wsp/5Q3yYLau1sHeRySYiF
	RpWi1iaJE/uUnPPPcfOobvAf0vwDnulM3COwHTimSkDEsdGxDzC9/X8g3GxWJOp1cxwwaP
	58DNHZ6gybIKv69P/LYlDkFZDq8cDEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-RU-5QdbsNZm4_GrZ24Gn9Q-1; Tue, 23 Mar 2021 06:41:43 -0400
X-MC-Unique: RU-5QdbsNZm4_GrZ24Gn9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F135100747A;
	Tue, 23 Mar 2021 10:41:41 +0000 (UTC)
Received: from ovpn-114-241.ams2.redhat.com (ovpn-114-241.ams2.redhat.com [10.36.114.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A441B1A353;
	Tue, 23 Mar 2021 10:41:40 +0000 (UTC)
Message-ID: <a23e7bf806872217bc0097c95d427de7a056422e.camel@redhat.com>
Subject: Re: [MPTCP] [MPTCP][PATCH mptcp-next 2/6] mptcp: add csum_enabled
 in mptcp_out_options
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Tue, 23 Mar 2021 11:41:39 +0100
In-Reply-To: <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com>
	 <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
	 <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-03-22 at 19:37 +0800, Geliang Tang wrote:
> This patch add a new member csum_enabled in struct mptcp_out_options.
> In mptcp_write_options, if this csum_enabled field is enabled, send out
> the MP_CAPABLE suboption with the MPTCP_CAP_CHECKSUM_REQD flag.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/net/mptcp.h  |  3 ++-
>  net/mptcp/options.c  | 10 ++++++++--
>  net/mptcp/protocol.h |  3 ++-
>  net/mptcp/subflow.c  |  1 +
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 83f23774b908..36fb6907aa6f 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -64,7 +64,8 @@ struct mptcp_out_options {
>  	u8 join_id;
>  	u8 backup;
>  	u8 reset_reason:4;
> -	u8 reset_transient:1;
> +	u8 reset_transient:1,
> +	   csum_enabled:1;
>  	u32 nonce;
>  	u64 thmac;
>  	u32 token;
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index e3fcd2b0ffd7..f45bebb923dc 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -379,6 +379,7 @@ bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>  	subflow->snd_isn = TCP_SKB_CB(skb)->end_seq;
>  	if (subflow->request_mptcp) {
>  		opts->suboptions = OPTION_MPTCP_MPC_SYN;
> +		opts->csum_enabled = mptcp_is_checksum_enabled(sock_net(sk));
>  		*size = TCPOLEN_MPTCP_MPC_SYN;
>  		return true;
>  	} else if (subflow->request_join) {
> @@ -464,6 +465,7 @@ static bool mptcp_established_options_mp(struct sock *sk, struct sk_buff *skb,
>  		opts->suboptions = OPTION_MPTCP_MPC_ACK;
>  		opts->sndr_key = subflow->local_key;
>  		opts->rcvr_key = subflow->remote_key;
> +		opts->csum_enabled = mptcp_is_checksum_enabled(sock_net(sk));

Note that 'mptcp_is_checksum_enabled(sock_net(sk))' can change its
value between SYN and 3rd ack, depending on user-space actions.

I think it would be better 'cache' the
mptcp_is_checksum_enabled(sock_net(sk)) value inside some new msk field
at msk creation time (for outgoing socket), so that this will always be
consistent and we could expose the 'csum requested' info to user-space
via diag in a reliable way.

For incoming socket, I think we could copy the 'subflow_req-
>csum_enabled' into the msk.

Cheers,

Paolo

