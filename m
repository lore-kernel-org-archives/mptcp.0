Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3C4A1F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663586845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KdcfOpFxnYboI8lTD0m4qH44fKVIxH2D0AmEgA8zYg=;
	b=CPMWL93PudmDKD5TLP13/+2dv0M7j0luhUYmUBdljriJORnkZkKhjoaUWokchwPtVOdB+8
	ETazBfnoFAzU4WMqzpjeNvZPCfTarse2vdjh5UN+mQuU2kic6lQ0HMBzn2Vlc85RUlQZlU
	5O61VydWUsn/DX9ZpyNuTAdQ8LWdR4A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-RKdvTH0tOPa6XcAcFya6_g-1; Mon, 19 Sep 2022 07:27:23 -0400
X-MC-Unique: RKdvTH0tOPa6XcAcFya6_g-1
Received: by mail-wm1-f71.google.com with SMTP id t14-20020a1c770e000000b003b4856a6ecaso2475880wmi.2
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 04:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date;
        bh=5KdcfOpFxnYboI8lTD0m4qH44fKVIxH2D0AmEgA8zYg=;
        b=mCJR2ziiNsez8snEDI+HP21hhxEdTf22zIbzjf+KzODya3votBrg6YSIjuAvWrdz9K
         ycNmaxY/cZDnGDDKE3V3o7OqHwhlGLT67C/LGFpGP2nH8dUYv7QajvtfDVq9Ajs2Rw1E
         UJcvihMOvUWf88T4AJ65mJ1d3DB6G9LGzo7GsisKp8pvov+oPGYZXPKHmOfOlzblQS3l
         bBPUd0PHGr/FTv6gshA+24JJ0POdsFD5/xbNuIvnjjRk6fiOxon6kRjg2J+36MDsBdZ8
         bgoOH8ZKHgI3gmEZwXgLzINp/+ftIfqf3W1psRkLpYNxGrLrRGOTigWHfjWpOiOb0/tC
         QrMg==
X-Gm-Message-State: ACrzQf3LOkdEjB59hftSjdQcN0kRHNJrmkpo+0hNxAUu4vFbjiUJ64pA
	gZoFRfPej0CcAWhHiazVEh7C7G7ivmf+UA3ukgYtatGxO0lBXA6ZgaUNEIoCIJeS+XEf8kV+nXl
	wKoAoHNWFCSOz2V4=
X-Received: by 2002:a05:6000:2cb:b0:22b:774:5b2c with SMTP id o11-20020a05600002cb00b0022b07745b2cmr1329231wry.51.1663586842673;
        Mon, 19 Sep 2022 04:27:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4XJD5HCfXRdU82kLydGFvMQJky88y91DdsjBJYdrNEx3trw6fzvSIRA3P0uO0bnWycCRdznA==
X-Received: by 2002:a05:6000:2cb:b0:22b:774:5b2c with SMTP id o11-20020a05600002cb00b0022b07745b2cmr1329219wry.51.1663586842489;
        Mon, 19 Sep 2022 04:27:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-114-90.dyn.eolo.it. [146.241.114.90])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003b332a7bf15sm14042783wmq.7.2022.09.19.04.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:27:22 -0700 (PDT)
Message-ID: <b83883829f7a8730207223178841f330617a72e4.camel@redhat.com>
Subject: Re: [RFC PATCH mptcp-next v7 08/11] Fix unxpctd val of
 subflow->map_seq(dscrd packet)
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 19 Sep 2022 13:27:21 +0200
In-Reply-To: <20220917222853.2406-9-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
	 <20220917222853.2406-9-dmytro@shytyi.net>
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

On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
> Fix unexpected value of subflow->map_seq (discarded and after
> retransmitted 2nd packet)
> 
> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
> ---
>  net/mptcp/subflow.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c7d49fb6e7bd..075c61d1d37f 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1077,8 +1077,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>  		/* will validate the next map after consuming the current one */
>  		goto validate_csum;
>  	}
> -
> -	subflow->map_seq = map_seq;
> +	if (msk->is_mptfo)
> +		subflow->map_seq = READ_ONCE(msk->ack_seq);
> +	else
> +		subflow->map_seq = map_seq;
>  	subflow->map_subflow_seq = mpext->subflow_seq;
>  	subflow->map_data_len = data_len;
>  	subflow->map_valid = 1;


This is likely not needed, if you build a special dss mapping at
incoming option processing time.

Cheers,

Paolo

