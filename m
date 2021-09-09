Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB73FE0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631194761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/DjjDCmEEFW9WUt9RwU7ozgYsasj5R8ClzLf/5xBRxI=;
	b=HKDW226XJtR41d0UDGpD28Rb1GjhX6JMzbnMgaXc1Qdj9oTiBBIPW9He4i6exWTMY9Hsnv
	ObGOjwQsqr69oraQfxTbvo7Y1Hvcyz9q6Pkg5MuuoRVRcppJRlE01UB/D6vKznVS5hupXr
	It0K3ixdMrX0rZzCl+USkO0ZTA/uFUI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-XKI24YakPO6bx422KhxMug-1; Thu, 09 Sep 2021 09:39:21 -0400
X-MC-Unique: XKI24YakPO6bx422KhxMug-1
Received: by mail-wm1-f69.google.com with SMTP id c203-20020a1c9ad4000000b002f8cba155ccso884802wme.4
        for <mptcp@lists.linux.dev>; Thu, 09 Sep 2021 06:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/DjjDCmEEFW9WUt9RwU7ozgYsasj5R8ClzLf/5xBRxI=;
        b=Am97j2FgzYXd6XxyTv1+O7TIkzZnJUXyJ15Oq/WI+MCpxdXwZ2lwqz4BvPXqNSlHT8
         wAzsL1gbxrSBcsy/RnwIb0EN276NOIsdgrgsMX9GcCGLFJnIfuXjlupBzkdWfTM1Q9nx
         zq+NxDAm7/dvFbDrv7BxoY9b4TSOf6JGPdRKvzFUVWcYIKne12c2ZTYK5AikECuOSGIL
         Ly63Z6raGS199HHW8OQ4vyMb6hhccRCON6gEXKqQxo+1g/CQHE2BblDQx5uOJwUco/5K
         ms3oBBa2qzJKVZ8ixt1JApozIfCpNFRoY92epqIo/LT0boma0y9xXe23xzm92ZJTW4MV
         MmfQ==
X-Gm-Message-State: AOAM533VbC6UWSaEKHQenkTPydIdx0hdTs14cWORc+wr/koTnl3flU9z
	ZB1YJnTWj4QaOyRlgkN142MRE5Z+kJOOnZ7pX/7S4vHrukix1UYf3qTPY3O+vbH1+Tww/dVzwJ+
	slaejcIgp1ypxXNI=
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr3131929wmj.124.1631194759421;
        Thu, 09 Sep 2021 06:39:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5joIDP0BAZj08aQJhP5x11IxHykw789/dCkd0J66bYaDRPQkIKKaUMnUe2oAX3Wt2kHb3yQ==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr3131912wmj.124.1631194759232;
        Thu, 09 Sep 2021 06:39:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id o26sm1609713wmc.17.2021.09.09.06.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:39:18 -0700 (PDT)
Message-ID: <ba53a5abbb43645efa4038eda3abfb8bb386b09b.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/9] mptcp: add MAPPING_INFINITE mapping
 status
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Thu, 09 Sep 2021 15:39:18 +0200
In-Reply-To: <592427b5a91d5e64e4b96c4c8b8d06264197f1c4.1631188109.git.geliangtang@xiaomi.com>
References: <cover.1631188109.git.geliangtang@xiaomi.com>
	 <592427b5a91d5e64e4b96c4c8b8d06264197f1c4.1631188109.git.geliangtang@xiaomi.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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
Content-Transfer-Encoding: 7bit

On Thu, 2021-09-09 at 19:51 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> This patch added a new mapping status named MAPPING_INFINITE. If the
> MPTCP_INFINITE_DONE flag is set in get_mapping_status, return this new
> status. And in subflow_check_data_avail, if this status is set, goto the
> 'infinite' lable to fallback.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/subflow.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 951aafb6021e..ad8efe56eab6 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -798,6 +798,7 @@ enum mapping_status {
>  	MAPPING_INVALID,
>  	MAPPING_EMPTY,
>  	MAPPING_DATA_FIN,
> +	MAPPING_INFINITE,
>  	MAPPING_DUMMY
>  };
>  
> @@ -938,6 +939,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>  	if (!skb)
>  		return MAPPING_EMPTY;
>  
> +	if (mptcp_check_infinite(ssk))
> +		return MAPPING_INFINITE;
> +
>  	if (mptcp_check_fallback(ssk))
>  		return MAPPING_DUMMY;
>  
> @@ -1121,6 +1125,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  
>  		status = get_mapping_status(ssk, msk);
>  		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
> +		if (unlikely(status == MAPPING_INFINITE))
> +			goto infinite;
> +
>  		if (unlikely(status == MAPPING_INVALID))
>  			goto fallback;
>  
> @@ -1192,6 +1199,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  		return false;
>  	}
>  
> +infinite:
>  	__mptcp_do_fallback(msk);
>  	skb = skb_peek(&ssk->sk_receive_queue);
>  	subflow->map_valid = 1;


It looks like MAPPING_INFINITE has almost the same behavior
of MAPPING_DUMMY.

I think we can avoid the new conditional in get_mapping_status().
Eventually we could do all the error checking after the 'fallback:'
label only if the msk has not fallen back yet:

fallback:
	if (!__mptcp_check_fallback(msk)) {
		/* RFC 8684 section 3.7. */
	        if (subflow->send_mp_fail) {
			...
		if (subflow->mp_join || subflow->fully_established) {
			...
		__mptcp_do_fallback(msk);
	}

	skb = skb_peek(&ssk->sk_receive_queue);
	...
WDYT?


