Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7886E
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 10:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616495838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbghCGCTJgOK5xHz8Nc6t10EP5+Wo/qN0QQ3/EZa9yw=;
	b=eZKG73IbVAPBzc2bsmjEvnnqNp41amUUuYJ646i6226AzBoENsuvR76+B01SfYOm4wl+ro
	52XLGj/OlJ5UHdUSU4+v6KgoJ99QvomKVecA6e0BoNXMcIxYWubexWIzMYFwD5Ve1qteUe
	t0V4PBweAHEDXeGl4qWJnYaPgQVG4JA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-MwVeuwfkNAe7hOTAHNr-qg-1; Tue, 23 Mar 2021 06:37:14 -0400
X-MC-Unique: MwVeuwfkNAe7hOTAHNr-qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B42801817;
	Tue, 23 Mar 2021 10:37:13 +0000 (UTC)
Received: from ovpn-114-241.ams2.redhat.com (ovpn-114-241.ams2.redhat.com [10.36.114.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68AD82A2CA;
	Tue, 23 Mar 2021 10:37:12 +0000 (UTC)
Message-ID: <f5c890f39e56c969f2b373ac057329b94b5758ac.camel@redhat.com>
Subject: Re: [MPTCP] [MPTCP][PATCH mptcp-next 5/6] mptcp: add the DSS
 checksum receiving
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Tue, 23 Mar 2021 11:37:11 +0100
In-Reply-To: <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com>
	 <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
	 <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
	 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
	 <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
	 <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
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

On Mon, 2021-03-22 at 19:37 +0800, Geliang Tang wrote:
> This patch added a new member csum in struct mptcp_options_received. In
> mptcp_parse_option, parse the checksum value from the receiving DSS, and
> save it in mp_opt->csum. In mptcp_incoming_options, pass it to
> mpext->csum.
> 
> In validate_mapping, use the new function validate_dss_csum to validata
> the DSS checksum.
> 
> In validate_dss_csum, if the data has been split in different packets,
> skip validating.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  net/mptcp/options.c  | 13 +++++++++++--
>  net/mptcp/protocol.h |  1 +
>  net/mptcp/subflow.c  | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 69eb15ef9385..ed89f6c2ed49 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -206,9 +206,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>  			mp_opt->data_len = get_unaligned_be16(ptr);
>  			ptr += 2;
>  
> -			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
> +			if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
> +				mp_opt->csum = get_unaligned_be16(ptr);
> +				ptr += 2;
> +			}
> +
> +			pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
>  				 mp_opt->data_seq, mp_opt->subflow_seq,
> -				 mp_opt->data_len);
> +				 mp_opt->data_len, mp_opt->csum);
>  		}
>  
>  		break;
> @@ -339,6 +344,7 @@ void mptcp_get_options(const struct sk_buff *skb,
>  	mp_opt->mp_prio = 0;
>  	mp_opt->reset = 0;
>  	mp_opt->csum_reqd = 0;
> +	mp_opt->csum = 0;
>  
>  	length = (th->doff * 4) - sizeof(struct tcphdr);
>  	ptr = (const unsigned char *)(th + 1);
> @@ -1124,6 +1130,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  		}
>  		mpext->data_len = mp_opt.data_len;
>  		mpext->use_map = 1;
> +
> +		if (READ_ONCE(msk->csum_reqd))
> +			mpext->csum = mp_opt.csum;
>  	}
>  }
>  
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f62cea8635f0..51ef3173a2e5 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -123,6 +123,7 @@ struct mptcp_options_received {
>  	u64	data_seq;
>  	u32	subflow_seq;
>  	u16	data_len;
> +	u16	csum;
>  	u16	mp_capable : 1,
>  		mp_join : 1,
>  		fastclose : 1,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 9fec1a273100..2eeea7d527f0 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -799,10 +799,45 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
>  					  mptcp_subflow_get_map_offset(subflow);
>  }
>  
> +static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
> +{
> +	struct csum_pseudo_header header;
> +	struct mptcp_ext *mpext;
> +	__wsum csum;
> +
> +	if (!skb)
> +		goto out;
> +
> +	mpext = mptcp_get_ext(skb);
> +	if (!mpext || !mpext->use_map || !mpext->csum ||
> +	    mpext->data_len != skb->len)
> +		goto out;
> +
> +	header.data_seq = mpext->data_seq;
> +	header.subflow_seq = mpext->subflow_seq;
> +	header.data_len = mpext->data_len;
> +	header.csum = mpext->csum;
> +
> +	csum = skb_checksum(skb, 0, skb->len, 0);
> +	csum = csum_partial(&header, sizeof(header), csum);
> +
> +	if (csum_fold(csum)) {
> +		pr_err("DSS checksum error! data_seq=%llu subflow_seq=%u data_len=%u csum=%u %u",
> +		       header.data_seq, header.subflow_seq, header.data_len,
> +		       header.csum, csum_fold(csum));

Here we likely need to increment a new mib counter, and avoid any
printk, otherwise an evil peer could easily DoS a server.

/P

