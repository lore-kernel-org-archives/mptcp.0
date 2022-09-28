Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDABEA2
	for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664357287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qixeYqkmjynb03eTDGBj66k2dtWjmDZUYleEsGPuzU=;
	b=hRE87jTlX+LzDJgKHwAf2m+seESvxY+gBjBTQLRoGpr7l6G1S8pCR7hrZZbbace3smD64o
	cfHMtWui+VCHzwrkkn9zxzU2PW3tMEbKR75dtsp7RkTw+3IVNgjQ4N28HGD4YS7/3PYapA
	K6yoevhEdo32EZFG0xS3p/0kigOV7yI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-inLGE11WNVKx5OAzVwaJKA-1; Wed, 28 Sep 2022 05:28:05 -0400
X-MC-Unique: inLGE11WNVKx5OAzVwaJKA-1
Received: by mail-wm1-f69.google.com with SMTP id h187-20020a1c21c4000000b003b51369ff1bso886470wmh.3
        for <mptcp@lists.linux.dev>; Wed, 28 Sep 2022 02:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=8qixeYqkmjynb03eTDGBj66k2dtWjmDZUYleEsGPuzU=;
        b=eO4r8bOM9V26qECAdnIYRBppAy8eNuAPNTdafNkEnii/BhA/51dPe5c84a8ExDKx1X
         bVDbqFo02cBls2du4q+exXyOnMkT9wY6rNJLjfQsXdMbBIozz5Y9S8o1nomQLyH1F8bu
         tyDY9kaKPFb7qF9AFAXfjxKPpel9DyucGTGbFRobZA2GvzPDm8OUlLYAFgjPBVuU2jc9
         CZVEF6antGcIngUY2vkU3nqRXb+K0b1e5KCEh9nhgnZXiE+ZwlsCO0FNKRGX7yR4I/6N
         Rd0Rk/87eyFejnO1gmhsd+D2P+VhC5vLneOkpgS1YaGTyUHj/4i1GdXQa5VPnt2mMr4i
         bH3Q==
X-Gm-Message-State: ACrzQf2T73cWQLYM3Od8lD0Dpv0F+9VBithvZz7hApeYlK3DGURznWXu
	cKb9On7jYW/EOHsIvrlickbnqDoaEDeFHH4kWoQX5PJnoMDKyRXcGYc4bZECPwUGnfrKhZPO8n7
	c0lvoSNPnFrQv1YM=
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr5679809wmb.147.1664357284026;
        Wed, 28 Sep 2022 02:28:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5w49MimvtRI7iF3J69+EFDpDy4xNzFA9uJ5Zt8W+1Hg/sGDv0AknMbJNAauYvt8KyJCYYoew==
X-Received: by 2002:a05:600c:3d0c:b0:3b4:c481:c63b with SMTP id bh12-20020a05600c3d0c00b003b4c481c63bmr5679798wmb.147.1664357283803;
        Wed, 28 Sep 2022 02:28:03 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id u14-20020a05600c19ce00b003b2878b9e0dsm1255167wmq.20.2022.09.28.02.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 02:28:03 -0700 (PDT)
Message-ID: <5777f26811d8cb04da21512763907702a421bf5c.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v12 6/7] mptcp: add TCP_FASTOPEN option
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Wed, 28 Sep 2022 11:28:02 +0200
In-Reply-To: <20220927225341.14165-7-dmytro@shytyi.net>
References: <20220927225341.14165-1-dmytro@shytyi.net>
	 <20220927225341.14165-7-dmytro@shytyi.net>
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

On Tue, 2022-09-27 at 22:53 +0000, Dmytro Shytyi wrote:
> We add the TCP_FASTOPEN socket option in this patch that is going to
>  be set by the listener side.
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/sockopt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 1857281a0dd5..ab3ba8558efd 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -559,6 +559,7 @@ static bool mptcp_supported_sockopt(int level, int optname)
>  		case TCP_NOTSENT_LOWAT:
>  		case TCP_TX_DELAY:
>  		case TCP_INQ:
> +		case TCP_FASTOPEN:
>  		case TCP_FASTOPEN_CONNECT:
>  		case TCP_FASTOPEN_NO_COOKIE:
>  			return true;

You should additionally update the comment below that describe
TCP_FASTOPEN as not supported.

/P

