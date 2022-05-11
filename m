Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754515A6
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1652265100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yv6s9jUsaz/6tlvm92rWgwaQw1rq+UGvtINB8tC1dB4=;
	b=IFMPgEKpgZljAGZfKKWY6eRs+dup7gjjFDTPMpx5WCtiO+N5cWdGTdMgn9gHQmVClY0jgv
	MQ6vgIqtr73YQ/eBV0wn2SILeE7IPDtXTNAMCUKT3Z045fB464J/k9ZNIzorx0wpCv4jtx
	Zt6sMUF67vDfGk647Lh38/iy6k2ymqY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-bY-xX4MsMF2oUuKrCd5Uqg-1; Wed, 11 May 2022 06:31:39 -0400
X-MC-Unique: bY-xX4MsMF2oUuKrCd5Uqg-1
Received: by mail-qt1-f200.google.com with SMTP id x10-20020ac8700a000000b002c3ef8fc44cso1238622qtm.8
        for <mptcp@lists.linux.dev>; Wed, 11 May 2022 03:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Yv6s9jUsaz/6tlvm92rWgwaQw1rq+UGvtINB8tC1dB4=;
        b=P+KIfG0TvkAPnpKZ3qSwOL+F46kyj7xACt9UuRMRyMEOs4OldCQjLAR7YSLTDkQPEN
         pfYxHIc0TPi1V2FiQJfpgFPoNG32dKWKCOgT8s0znY8AEt2yLvBeYzY3GJJMxXMn2BZN
         IZw8X45bj8/XDYyG1LNU1uQiSM5aFdjUmedqCJe5VFkLxTksX73nYxN9Kug0FMEtSW5J
         HtJDQVCCfAPcBO5QW+V6qa6ZeE7q7MgrZkkUMZE7YjdHWrB5g+vZER8WYP7cjhwAYdaR
         NgA9gjtkK6bA/7D5a5oh27l1puMf9xM8phLxpXzasbnZdFESKTMJue08YNFvKYDlNh/a
         qlkQ==
X-Gm-Message-State: AOAM531V3LkEhxB2Ypl0fthM/szFAuVd1SnWAlaJwliVWrlalgnElu4H
	t7Fkyt/uZf1jmXgtPGWDTG67P4KOWOv09DVwUVOF1OedHS3gy41qotkcvohI/usJrQ7V1Vcg61o
	GN0B1r2JEEiS51tQ=
X-Received: by 2002:a05:620a:141a:b0:69f:97e5:77d5 with SMTP id d26-20020a05620a141a00b0069f97e577d5mr18816318qkj.708.1652265098280;
        Wed, 11 May 2022 03:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx9rLxeaCfIJPOEUg7iU6vPdsPIfqWuisi5/FGCgK/luoPNiUvLOhnmgY+1p46L5zCZAzVFUA==
X-Received: by 2002:a05:620a:141a:b0:69f:97e5:77d5 with SMTP id d26-20020a05620a141a00b0069f97e577d5mr18816305qkj.708.1652265097953;
        Wed, 11 May 2022 03:31:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id c1-20020ac853c1000000b002f39b99f69dsm851326qtq.55.2022.05.11.03.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 03:31:37 -0700 (PDT)
Message-ID: <7f458d7eaf9ed5180d9e3d0295949a717ba3c895.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: Do TCP fallback on early DSS checksum
 failure
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Date: Wed, 11 May 2022 12:31:34 +0200
In-Reply-To: <20220510000320.82652-1-mathew.j.martineau@linux.intel.com>
References: <20220510000320.82652-1-mathew.j.martineau@linux.intel.com>
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

On Mon, 2022-05-09 at 17:03 -0700, Mat Martineau wrote:
> RFC 8684 section 3.7 describes several opportunities for a MPTCP
> connection to "fall back" to regular TCP early in the connection
> process, before it has been confirmed that MPTCP options can be
> successfully propagated on all SYN, SYN/ACK, and data packets. If a peer
> acknowledges the first received data packet with a regular TCP header
> (no MPTCP options), fallback is allowed.
> 
> If the recipient of that first data packet finds a MPTCP DSS checksum
> error, this provides an opportunity to fail gracefully with a TCP
> fallback rather than resetting the connection (as might happen if a
> checksum failure were detected later).
> 
> This commit modifies the checksum failure code to attempt fallback on
> the initial subflow of a MPTCP connection, only if it's a failure in the
> first data mapping. In cases where the peer initiates the connection,
> requests checksums, is the first to send data, and the peer is sending
> incorrect checksums (see
> https://github.com/multipath-tcp/mptcp_net-next/issues/275), this allows
> the connection to proceed as TCP rather than reset.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
> 
> I tested this on the export-net branch along with Paolo's proposed
> checksum fix ("mptcp: fix checksum byte order"). Testing between the
> patched export-net kernel and 5.17.5-200.fc35.x86_64 (Fedora) showed the
> fallback succeeding if checksums are enabled on one side, export-net was
> the listener, and 5.17.5 initiated the connection and sent the first
> data. Without this patch, if one side has the fixed checksum byte order
> then all connections would reset after a checksum failure.
> 
> ---
>  net/mptcp/protocol.h |  3 ++-
>  net/mptcp/subflow.c  | 15 ++++++++++++---
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index f4ce28bb0fdc..6c7e78ec88e8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -443,7 +443,8 @@ struct mptcp_subflow_context {
>  		can_ack : 1,        /* only after processing the remote a key */
>  		disposable : 1,	    /* ctx can be free at ulp release time */
>  		stale : 1,	    /* unable to snd/rcv data, do not use for xmit */
> -		local_id_valid : 1; /* local_id is correctly initialized */
> +		local_id_valid : 1, /* local_id is correctly initialized */
> +		valid_csum_seen : 1;        /* at least one csum validated */
>  	enum mptcp_data_avail data_avail;
>  	u32	remote_nonce;
>  	u64	thmac;
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8c37087f0d84..3a7b02a92239 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -955,11 +955,14 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
>  				 subflow->map_data_csum);
>  	if (unlikely(csum)) {
>  		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
> -		subflow->send_mp_fail = 1;
> -		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
> +		if (subflow->mp_join || subflow->valid_csum_seen) {
> +			subflow->send_mp_fail = 1;
> +			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
> +		}
>  		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
>  	}
>  
> +	subflow->valid_csum_seen = 1;
>  	return MAPPING_OK;
>  }
>  
> @@ -1145,6 +1148,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  {
>  	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>  	enum mapping_status status;
> +	bool fallback_impossible;
>  	struct mptcp_sock *msk;
>  	struct sk_buff *skb;
>  
> @@ -1218,7 +1222,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  		return true;
>  	}
>  
> -	if (subflow->mp_join || subflow->fully_established) {
> +	if (READ_ONCE(msk->csum_enabled))
> +		fallback_impossible = subflow->valid_csum_seen;
> +	else
> +		fallback_impossible = subflow->fully_established;
> +
> +	if (subflow->mp_join || fallback_impossible) {
>  		/* fatal protocol error, close the socket.
>  		 * subflow_error_report() will introduce the appropriate barriers
>  		 */

LGTM, thanks! Perhaps the last chunk can be encapsulated in an helper:
 
subflow_is_fallback_possible(subflow, msk) 

embedding all the relevant test?

Either ways: 

Acked-by: Paolo Abeni <pabeni@redhat.com>

