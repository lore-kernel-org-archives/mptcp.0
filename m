Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A422F29
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668767666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TswRnaMalEakGBwhiY94DIuiJghUgVXKr0OD/nVk83o=;
	b=XtvQSvBJnU++DKi19NqplX9i2FK8DMm4bq/dwn9lsp7zWQxawxuYFLDFcW6l8hZaNL+1NZ
	7vRnCcKCkDRropmlFWNI7Cx2nQb2IjeyHpViVghY+1izParJyURfRpfJIeGWkrXH/gKQYB
	oxANcVLi370Yc89xkjEbtLkt7e8hDVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-lJa-k3xjM5Kz2KjFH9Fm7A-1; Fri, 18 Nov 2022 05:34:25 -0500
X-MC-Unique: lJa-k3xjM5Kz2KjFH9Fm7A-1
Received: by mail-wm1-f71.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so2065511wmb.7
        for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 02:34:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TswRnaMalEakGBwhiY94DIuiJghUgVXKr0OD/nVk83o=;
        b=AtLNN0xdhvWZ/+X9KJoKPD5xzQlPgtUeTm/3TXiBV7fP2Jz2WZo02fnJDfdf5P61Qv
         NZh4DtnFDBfhCUFCQ8EqabgIUlLGXnb+Gby4XlxBXyIfI9fd2HRTciI9r5J1f/eYQ/MT
         fnexZ823EOcgsF2u0qXJoEYjSFh/qgSMcoQG/A2ynREExF7W9DMvgHDXbCtzmbpZ/IPf
         9AJ0siBCaeS48LOFL015pkWO7Lq5KggDWppBwWaJYLmCkFIJ+n7cpibNQ0OVmT5QoRrC
         uCGBiOo9F1dz0NWVdC3icvZ2B9rBTlMClY0sRtRY+x4xbaMSnRJ0lBzxMSSJvzIDeHnd
         EKUg==
X-Gm-Message-State: ANoB5pmWdvk/gSswmtzHQYMJC8vJcbeLMUpIVWlPMV9gDyKqM8smAFlY
	zaN/7dbae0lLYfev8qLZAEA6oiaTAw7Crg2oIJG77YUSRULOK5MtxZg2kG8mHx8QcVH0Zc34yLl
	XFFZLV0fUEsA2qS0=
X-Received: by 2002:a05:600c:3507:b0:3cf:8e62:f907 with SMTP id h7-20020a05600c350700b003cf8e62f907mr4575445wmq.7.1668767664142;
        Fri, 18 Nov 2022 02:34:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5mOP8jrfUBuyAYkmvJ9OJFtzPmpNmz/hGX+7OfY3IjFLYtlT309EFy98ZS73Fhoe4mIv3dVA==
X-Received: by 2002:a05:600c:3507:b0:3cf:8e62:f907 with SMTP id h7-20020a05600c350700b003cf8e62f907mr4575436wmq.7.1668767663932;
        Fri, 18 Nov 2022 02:34:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id q3-20020adfcd83000000b0022eafed36ebsm3254149wrj.73.2022.11.18.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 02:34:23 -0800 (PST)
Message-ID: <7e47464d0af8c4c0d02cf332bcefafd8f06fb50e.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] mptcp: don't orphan ssk in mptcp_close()
From: Paolo Abeni <pabeni@redhat.com>
To: menglong8.dong@gmail.com, mathew.j.martineau@linux.intel.com, 
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev, Menglong Dong <imagedong@tencent.com>, Biao Jiang
	 <benbjiang@tencent.com>, Mengen Sun <mengensun@tencent.com>
Date: Fri, 18 Nov 2022 11:34:22 +0100
In-Reply-To: <20221118072030.3500578-1-imagedong@tencent.com>
References: <20221118072030.3500578-1-imagedong@tencent.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Fri, 2022-11-18 at 15:20 +0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> All of the subflows of a msk will be orphaned in mptcp_close(), which
> means the subflows are in DEAD state. After then, DATA_FIN will be sent,
> and the other side will response with a DATA_ACK for this DATA_FIN.
> 
> However, if the other side still has pending data, the data that received
> on these subflows will not be passed to the msk, as they are DEAD and
> subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
> these data can't be acked, and they will be retransmitted again and again,
> until timeout.
> 
> Fix this by not orphaning the subflows in mptcp_close(). I think that's
> ok, as they can still be orphaned in __mptcp_close_ssk(). Maybe we can
> also fix this in mptcp_incoming_options() by check the status of ssk and
> msk?

Thank you for clearly debugging this scenario!

As noted by the CI, this fix causes an UaF, as mptcp_close() frees the
msk->sk_socket struct, which is also referenced by ssk->sk_socket.

Without orphaning the subflows, later tcp code will use ssk->sk_socket,
causing the reported splat. Note that there is the same risk with ssk-
>sk_wq.

Since:
* all the network code carefully checks for not NULL value of ssk-
>sk_socket before accessing it
* access it directly in context where it can't be NULL
* uses the same policies to access 'sk_wq'
* it looks like the SOCK_DONE flag can be set independently from the
sock_orphan()

I think mptcp_close() could instead directly clearing ssk->sk_socket
and ssk->sk_wq - just ' = NULL', no sock_orphan() call - and
__mptcp_close_ssk() could be changed accordingly:

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8679eafeeca8..6b9f390966f7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2340,11 +2340,7 @@ static void __mptcp_close_ssk(struct sock *sk,
struct sock *ssk,
                goto out;
        }
 
-       /* if we are invoked by the msk cleanup code, the subflow is
-        * already orphaned
-        */
-       if (ssk->sk_socket)
-               sock_orphan(ssk);
+       sock_orphan(ssk);
 
        subflow->disposable = 1;

> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Reviewed-by: Mengen Sun <mengensun@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> ---
>  net/mptcp/protocol.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3796d1bfef6b..5ac1584baf61 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -815,7 +815,7 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  
>  	/* Wake-up the reader only for in-sequence data */
>  	mptcp_data_lock(sk);
> -	if (move_skbs_to_msk(msk, ssk))
> +	if (move_skbs_to_msk(msk, ssk) && !sock_flag(sk, SOCK_DEAD))
>  		sk->sk_data_ready(sk);

I think this is not need right? sk_data_ready == sock_def_readable,
will check carefully sk->sk_wq which should be NULL after close.

Thank!

Paolo

