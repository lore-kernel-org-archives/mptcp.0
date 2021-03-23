Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFB5F
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616494977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBkKNlEtXB1FQJMdCF7u7zn/mzkIUG+Xfy8d59dfTdE=;
	b=TDbibOouwQjwZ9jPNnQtdOpHVc/tXU65UYGm4m6Uybt9xOtkmGs2GcaPNlJpuNiqxObqkb
	v2gWj3XRhx1QrHVUKW15E7p9xEaQMge3tjLdYYyYLQE8VaMqvtfthDSkJtpjov+KcW68PY
	BGlWoA8LoEJVe8kHYGQ+lV/fNNz7Z98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-qZ7oCpW-PYevW_71B0XrIw-1; Tue, 23 Mar 2021 06:22:53 -0400
X-MC-Unique: qZ7oCpW-PYevW_71B0XrIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E0C1180FCA0;
	Tue, 23 Mar 2021 10:22:52 +0000 (UTC)
Received: from ovpn-114-241.ams2.redhat.com (ovpn-114-241.ams2.redhat.com [10.36.114.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 514FE5D9C0;
	Tue, 23 Mar 2021 10:22:51 +0000 (UTC)
Message-ID: <4ca665eeba3d66ee4d213eba2eb5e91ef2ceed95.camel@redhat.com>
Subject: Re: [MPTCP] Re: [MPTCP][PATCH mptcp-next 4/6] mptcp: add the DSS
 checksum sending
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Geliang Tang
	 <geliangtang@gmail.com>
Cc: mptcp@lists.01.org, mptcp@lists.linux.dev
Date: Tue, 23 Mar 2021 11:22:50 +0100
In-Reply-To: <41604ba7-65b8-7675-3f12-bfb6c124c61d@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com>
	 <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>
	 <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
	 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>
	 <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>
	 <41604ba7-65b8-7675-3f12-bfb6c124c61d@linux.intel.com>
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

On Mon, 2021-03-22 at 16:10 -0700, Mat Martineau wrote:
> On Mon, 22 Mar 2021, Geliang Tang wrote:
> 
> > In mptcp_established_options_dss, use the new function
> > mptcp_generate_dss_csum to generate the DSS checksum value.
> > 
> > In mptcp_write_options, send out DSS with the checksum value.
> > 
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> > ---
> > include/net/mptcp.h  |  1 +
> > net/mptcp/options.c  | 41 ++++++++++++++++++++++++++++++++++++++---
> > net/mptcp/protocol.h |  7 +++++++
> > 3 files changed, 46 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> > index 36fb6907aa6f..869a6d98a72e 100644
> > --- a/include/net/mptcp.h
> > +++ b/include/net/mptcp.h
> > @@ -32,6 +32,7 @@ struct mptcp_ext {
> > 			frozen:1,
> > 			reset_transient:1;
> > 	u8		reset_reason:4;
> > +	u16		csum;
> > };
> > 
> > #define MPTCP_RM_IDS_MAX	8
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index bdced173edff..69eb15ef9385 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -521,6 +521,30 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
> > 	}
> > }
> > 
> > +static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
> > +{
> > +	struct csum_pseudo_header header;
> > +	struct mptcp_ext *mpext;
> > +	__wsum csum;
> > +
> > +	if (!skb)
> > +		return 0;
> > +
> > +	mpext = mptcp_get_ext(skb);
> > +	if (!mpext || !mpext->use_map)
> > +		return 0;
> > +
> > +	header.data_seq = mpext->data_seq;
> > +	header.subflow_seq = mpext->subflow_seq;
> > +	header.data_len = mpext->data_len;
> > +	header.csum = 0;
> > +
> > +	csum = skb_checksum(skb, 0, skb->len, 0);
> > +	csum = csum_partial(&header, sizeof(header), csum);
> > +
> > +	return csum_fold(csum);
> > +}
> > +
> > static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> > 					  bool snd_data_fin_enable,
> > 					  unsigned int *size,
> > @@ -544,8 +568,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> > 
> > 		remaining -= map_size;
> > 		dss_size = map_size;
> > -		if (mpext)
> > +		if (mpext) {
> > +			if (msk->csum_reqd)
> > +				mpext->csum = mptcp_generate_dss_csum(skb);
> > 			opts->ext_copy = *mpext;
> > +		}
> > 
> > 		if (skb && snd_data_fin_enable)
> > 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
> > @@ -1304,6 +1331,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
> > 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
> > 			if (mpext->data_fin)
> > 				flags |= MPTCP_DSS_DATA_FIN;
> > +
> > +			if (mpext->csum)
> 
> Instead of relying on a non-zero mpext->csum, what about using 
> opts->csum_enabled instead? (Would have to make sure that flag is set in 
> mptcp_out_options for data packets too)
> 
> This would be more compatible with hardware offload if that gets added 
> later.

Side note, not sure if already discussed in the last mtgs, xmit csum
offload looks doable, togethar with TSO !?! The nic have all the pieces
in place/available to compute it...

/P

