Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0A6F
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616519260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhcUc6qfpVQ6TQjFc37CjLDeJSVcb7n3u9RVl/WNhyI=;
	b=eG57FQhYT0bsBhbhtlUoAWevZJYmDo5YXlCfBbBLSq/dXPYRzlc/yJlNEScMSFEpKV/JtF
	LtF5rje7dPh5JtVLc3C4+PAZDgtq91uyTabew1A0eJSa0/4j5S3y7pgBppvIsV1cDulyds
	NhFUhqSjWu3ZphfFPUFK3rAlDW6qMBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-la2nlaURMF62pKYYjBiP3g-1; Tue, 23 Mar 2021 13:07:38 -0400
X-MC-Unique: la2nlaURMF62pKYYjBiP3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 729E1809AC5;
	Tue, 23 Mar 2021 17:07:37 +0000 (UTC)
Received: from ovpn-114-241.ams2.redhat.com (ovpn-114-241.ams2.redhat.com [10.36.114.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 40D6A19C45;
	Tue, 23 Mar 2021 17:07:36 +0000 (UTC)
Message-ID: <c79c5c22d0d4bfe316e6c7c2231c4f001a2b9ff9.camel@redhat.com>
Subject: Re: [MPTCP] [MPTCP][PATCH mptcp-next 4/6] mptcp: add the DSS
 checksum sending
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
	mptcp@lists.linux.dev
Date: Tue, 23 Mar 2021 18:07:35 +0100
In-Reply-To: <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
References: <cover.1616412490.git.geliangtang@gmail.com>
	 <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
	 <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
	 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
	 <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
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
> In mptcp_established_options_dss, use the new function
> mptcp_generate_dss_csum to generate the DSS checksum value.
> 
> In mptcp_write_options, send out DSS with the checksum value.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/net/mptcp.h  |  1 +
>  net/mptcp/options.c  | 41 ++++++++++++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h |  7 +++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 36fb6907aa6f..869a6d98a72e 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -32,6 +32,7 @@ struct mptcp_ext {
>  			frozen:1,
>  			reset_transient:1;
>  	u8		reset_reason:4;
> +	u16		csum;
>  };
>  
>  #define MPTCP_RM_IDS_MAX	8
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bdced173edff..69eb15ef9385 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -521,6 +521,30 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
>  	}
>  }
>  
> +static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
> +{
> +	struct csum_pseudo_header header;
> +	struct mptcp_ext *mpext;
> +	__wsum csum;
> +
> +	if (!skb)
> +		return 0;
> +
> +	mpext = mptcp_get_ext(skb);
> +	if (!mpext || !mpext->use_map)
> +		return 0;
> +
> +	header.data_seq = mpext->data_seq;
> +	header.subflow_seq = mpext->subflow_seq;
> +	header.data_len = mpext->data_len;
> +	header.csum = 0;
> +
> +	csum = skb_checksum(skb, 0, skb->len, 0);
> +	csum = csum_partial(&header, sizeof(header), csum);
> +
> +	return csum_fold(csum);
> +}
> +
>  static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  					  bool snd_data_fin_enable,
>  					  unsigned int *size,
> @@ -544,8 +568,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>  
>  		remaining -= map_size;
>  		dss_size = map_size;
> -		if (mpext)
> +		if (mpext) {
> +			if (msk->csum_reqd)
> +				mpext->csum = mptcp_generate_dss_csum(skb);
>  			opts->ext_copy = *mpext;
> +		}
>  
>  		if (skb && snd_data_fin_enable)
>  			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
> @@ -1304,6 +1331,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>  			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
>  			if (mpext->data_fin)
>  				flags |= MPTCP_DSS_DATA_FIN;
> +
> +			if (mpext->csum)
> +				len += TCPOLEN_MPTCP_DSS_CHECKSUM;
>  		}
>  
>  		*ptr++ = mptcp_option(MPTCPOPT_DSS, len, 0, flags);

If csum is enabled, we additionally need to insert the csum even in the
MPC+data packets.

In a similar way, we need to extract the csum value from MPC+data
packets in the input path, when csum is enabled (in the next patch)

/P

