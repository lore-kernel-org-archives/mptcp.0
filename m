Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35D173
	for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639762912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0wx7YzBT0OJDoTK93IdI9jMXuXKgqm+gWN7iSOKNHg=;
	b=ZQci9arZ4GPgqh9gFtrxQXAvaP2Amub1MiA/jfxUVe+zM/8/279LyQNUQwE6I1R3az//YX
	J+S9oJGhd7SzfoB9oPuCsO5Mipdn31aPDcjA3SKaUZnb2jFoD3d3itd+gMyK0q/Yt0PZ1C
	jFWGkXY/z2YMuGMET6baVLWwr1iJiZU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-ceqI7UqCNvGZn6l3zTSJCw-1; Fri, 17 Dec 2021 12:41:51 -0500
X-MC-Unique: ceqI7UqCNvGZn6l3zTSJCw-1
Received: by mail-wr1-f71.google.com with SMTP id t30-20020adfa2de000000b001a24004e1fbso836818wra.10
        for <mptcp@lists.linux.dev>; Fri, 17 Dec 2021 09:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J0wx7YzBT0OJDoTK93IdI9jMXuXKgqm+gWN7iSOKNHg=;
        b=yhsk8/phJNCtXuO4thU5MokngcAfIErKmdHlrnhSlzvAVSUgWlF2LwhZfGzfvaYg2w
         xgyLr9v6Fl9yPQAAUR66GxgKnqPNlKvm11JPWpcxtNN8hdD20Pyx5+vXqn3qSAJs4wje
         KjQiIjbbsFn6WGtLBsWxbuDqla1AaJ0ETJuMFQOfiIjIBPD2l+WaV78ZDyo77VfNMqJK
         VHMqMNVHvGRCtmhb0IRIkgGp6i0GQaI2/gRsfsk0Z/Ejk9E2oddi3NT/9zYuLLdsBI4O
         gzVl2DxKkfKaADCoA05Qge+CVSxxbgov6X4dKqImEuK+dkCLdf1o0nljols9r4FRy6IS
         e3Gw==
X-Gm-Message-State: AOAM532NQHXzgQ3jeG/I3ls4QQGdrQ05hJdj1DaN68RThTZH5ZWJWA7g
	GUebLd24fN/dLAHf/mC+Vmdgq7IBND8P0BZF5C2tC1UKBjmOpj+gsZbnhaxrBMsVDIvzBA0UeZG
	xtaXL1nw6hlO+D70=
X-Received: by 2002:a5d:4489:: with SMTP id j9mr3417272wrq.544.1639762909361;
        Fri, 17 Dec 2021 09:41:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQNqcGWYqKnTqo2Vv7w7QpW/OVWECqAM6oh4qHU0dESEh4+bf3vCqc0UVAUgHzSlDjQm0OUQ==
X-Received: by 2002:a5d:4489:: with SMTP id j9mr3417261wrq.544.1639762909158;
        Fri, 17 Dec 2021 09:41:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-225-60.dyn.eolo.it. [146.241.225.60])
        by smtp.gmail.com with ESMTPSA id h18sm8417394wre.46.2021.12.17.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:41:48 -0800 (PST)
Message-ID: <3b6e24478094b08d72da468f9865af798266fffe.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 04/21] mptcp: establish subflows from either
 end of connection
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, mptcp@lists.linux.dev
Date: Fri, 17 Dec 2021 18:41:47 +0100
In-Reply-To: <20211216222314.1244708-5-kishen.maloor@intel.com>
References: <20211216222314.1244708-1-kishen.maloor@intel.com>
	 <20211216222314.1244708-5-kishen.maloor@intel.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

Hello,

On Thu, 2021-12-16 at 17:22 -0500, Kishen Maloor wrote:
> This change updates internal logic to permit subflows to be
> established from either the client or server ends of MPTCP
> connections. This symmetry and added flexibility may be
> harnessed by PM implementations running on either end in
> creating new subflows.
> 
> The essence of this change lies in not relying on the
> "server_side" flag (which continues to be available if needed).
> 
> Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> ---
>  net/mptcp/options.c  | 3 +--
>  net/mptcp/protocol.c | 5 +----
>  net/mptcp/protocol.h | 2 --
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index cceba8c7806d..ee13bb46dc38 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -920,8 +920,7 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  		 */
>  		if (TCP_SKB_CB(skb)->seq == subflow->ssn_offset + 1 &&
>  		    TCP_SKB_CB(skb)->end_seq == TCP_SKB_CB(skb)->seq &&
> -		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ) &&
> -		    READ_ONCE(msk->pm.server_side))
> +		    subflow->mp_join && (mp_opt->suboptions & OPTIONS_MPTCP_MPJ))
>  			tcp_send_ack(ssk);

This change looks dangerous to me ?!? Or at least would the client to
send an unneeded TCP pure ack as the 5th pkt in the MPJ handshake ?!?

I think we should still try to invoke tcp_send_ack() only if this peer
is passive side of the MPJ handshake. Possibly we need to use an
additional status bit in mptcp_subflow_context to track that.


Thanks!

Paolo

