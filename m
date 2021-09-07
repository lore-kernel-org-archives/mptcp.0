Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AEB72
	for <mptcp@lists.linux.dev>; Tue,  7 Sep 2021 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1631013384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPUTOXzmG56IIO1XPQ4krk+r/tGj5SZMukS8w1KeBqA=;
	b=NqpWju8T/3LDji15QR8oBQhOfduEcBQ31o1WsLSTRWnoC0XXn8ojh+vQ4nZ4auuqPvv9f1
	NFeWSijzldgQLi9QcvzUpE9kmPW/u/OkPN+xB93vrEFCwOhFutTGF4nAhy1QHfuSNUvSNg
	5Fz82kmC2craa7CGdNnvCHqSbfAxUkU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-6l5EyhlMOja53-sEZz1rhA-1; Tue, 07 Sep 2021 07:16:21 -0400
X-MC-Unique: 6l5EyhlMOja53-sEZz1rhA-1
Received: by mail-wm1-f70.google.com with SMTP id y24-20020a7bcd98000000b002eb50db2b62so979177wmj.5
        for <mptcp@lists.linux.dev>; Tue, 07 Sep 2021 04:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rPUTOXzmG56IIO1XPQ4krk+r/tGj5SZMukS8w1KeBqA=;
        b=Elg32jg9o3IlhUWvt6GxSWJrfl7Ww8CJVf36QjqYfRs02JT74v/XaFatApu+dHljyO
         KaT4bw+QpJO8xi+/n/W5X2t9hH/EniKARAf5UwCmz9KzZRlWDCVE5e5OgkHVIKX+Abht
         wziamRdlfmFe5sEFRW097H5WBrZQtULx58rxdPgTu/WjXQRMFp/16Jkq3dG5AzhIqwdx
         7XG/7hxiKNiM3NWGWeYCFnScWYw7SPTknne0l2nXC0e9V40vUJjRpv0mKv0844B9tDMl
         v98pWA9Wnn0PNpJDuqkuMa5Kct7Uk2aSXUJ9zX0lFWPFHSRBSdaFaQEBPfFBeHpnEhXC
         ihqw==
X-Gm-Message-State: AOAM531psvALidOvwVA8xs+X3nbn6vVAjeV0xhCzQikltcZn/l6G2bAS
	N4oDtzQP07bJsdzTWYBTPZ6psHHoD4jAoUei+6YF0i6AmAl9Q7paG9gl7kHQZ6MzOsyLpqP2m8/
	WDGjHOa6pAF3QIIc=
X-Received: by 2002:adf:eb4a:: with SMTP id u10mr18158501wrn.11.1631013380602;
        Tue, 07 Sep 2021 04:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRnb0LR8o8pU8bR8Z4kdk072n3Fm8kV9XFNsozvfMzcMhTbfqnGqtvbd7xGng8+Ngm/4ZELA==
X-Received: by 2002:adf:eb4a:: with SMTP id u10mr18158486wrn.11.1631013380405;
        Tue, 07 Sep 2021 04:16:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-2.dyn.eolo.it. [146.241.241.2])
        by smtp.gmail.com with ESMTPSA id h15sm10468933wrc.19.2021.09.07.04.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 04:16:20 -0700 (PDT)
Message-ID: <bf211816c921732874fcc66cade7a86c2eaecfa8.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp-next 3/4] mptcp: round-robin packet scheduler
 support
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev, Christoph
	Paasch <cpaasch@apple.com>
Cc: Geliang Tang <geliangtang@xiaomi.com>
Date: Tue, 07 Sep 2021 13:16:19 +0200
In-Reply-To: <95d450f9694cf9d95081a77db529db2181d0d3b3.1631011068.git.geliangtang@xiaomi.com>
References: <cover.1631011068.git.geliangtang@xiaomi.com>
	 <95d450f9694cf9d95081a77db529db2181d0d3b3.1631011068.git.geliangtang@xiaomi.com>
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

On Tue, 2021-09-07 at 18:41 +0800, Geliang Tang wrote:
> From: Geliang Tang <geliangtang@xiaomi.com>
> 
> Implement the round-robin packet scheduler like on the mptcp.org kernel.
> 
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
>  net/mptcp/Kconfig    |  7 +++++++
>  net/mptcp/protocol.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index 10c97e19a7da..0df36991566a 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -23,6 +23,13 @@ config MPTCP_IPV6
>  	depends on IPV6=y
>  	default y
>  
> +config MPTCP_ROUNDROBIN
> +	tristate "MPTCP Round-Robin"
> +	default n
> +	help
> +	  This is a very simple round-robin scheduler. Probably has bad performance
> +	  but might be interesting for researchers.
> +
>  config MPTCP_KUNIT_TEST
>  	tristate "This builds the MPTCP KUnit tests" if !KUNIT_ALL_TESTS
>  	depends on KUNIT
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ab72a3950f2b..b78c4eb4947f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1521,6 +1521,29 @@ static struct mptcp_sched_ops mptcp_sched_default = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +#if IS_ENABLED(CONFIG_MPTCP_ROUNDROBIN)
> +static struct sock *rr_get_subflow(struct mptcp_sock *msk)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *ssk;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		ssk = mptcp_subflow_tcp_sock(subflow);
> +		if (ssk != msk->last_snd) {
> +			pr_debug("msk=%p ssk=%p last_snd=%p", msk, ssk, msk->last_snd);
> +			msk->last_snd = ssk;
> +		}

This needs some more logic:
- it must take in account backup vs non backup
- it should consider if the given subflow has available write
space/snd_wnd
- it should move from the 'last_snd' subflow to the 'next' one, instead
of always selecting the fist subflow other then 'last_snd'. Otherwise
with 3 non backup subflow active we will never pick the last created
one.

There is an import side question, already asked by Christoph, why the
round robin? perhpas we should consider instead some different
scheduler, known to perform well. @Christoph: which is the 'best'
mptcp.org scheduler out there? blest?

Thanks!

Paolo

