Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6B172
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 13:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620306501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtR41JvJ/YissVRHlPPyFSqoxIa0WCduvp2C6ZaLVcE=;
	b=MGaU74tlbGTpDg8qNmaq6nWbk+fvFoCEmOfzhQc1r3ukGuAS4OpkPcO0kEBbOOp+fv8UEn
	UXLhJiawDQvAbRgvY3sA0u9sNAI99UOlMPbnL+TGw1fZ/Vp1i50KtaEMucD+VLeuO1Lx82
	CZreQdC2dTZwefamcdEviVT1/EbntvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-3ZCsYTRXNyCejgyD-u3xSg-1; Thu, 06 May 2021 09:08:19 -0400
X-MC-Unique: 3ZCsYTRXNyCejgyD-u3xSg-1
Received: by mail-wm1-f70.google.com with SMTP id j136-20020a1c238e0000b029014675462236so981908wmj.7
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 06:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZtR41JvJ/YissVRHlPPyFSqoxIa0WCduvp2C6ZaLVcE=;
        b=GQAyqUTbahBqMG38HkOToZbIi3eqXndNd+KN66jyxCddT/4Aj2Izte9u1QctEkskTD
         KgUZEzJqbtjrEzPM3hRhh1EuIECwaamAVGF2u27TkwebptQIo34N9sFl7kWSZCHytq2V
         ywMiv7zYRUkzbRPLvtuWR2ttltrFxfm1drCgE6RsGABNbslc5eM7ppCVHAn2NqLq3iFT
         EkeSy8bjUdX39Yom/SpW87OtubGeOkI2LQdNoTcdvsk6k8cunIZ1uxdMjRhTNXm0qYnv
         0JDx/NqBi3pM10GZnVTWvRWjxXFg95pT1hplAN18E9HfVsRL6eqGyUhSjlXdsY3dB+pV
         85qw==
X-Gm-Message-State: AOAM531/UHFPwTz8kc5iql80wqXGXQG1Gfb4jbXHix53roqHsv5sn4iP
	XgrV9olNtk9tFP5c5b9DMoFiuNBPtnNL/0EHYPz8LswfGy5VoM4rR5dVxTYyfCdSPwh7E6PaGcO
	37JIN0csCcgwirRQ=
X-Received: by 2002:a1c:228a:: with SMTP id i132mr3891305wmi.10.1620306498430;
        Thu, 06 May 2021 06:08:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOqERSV7DEYKQJcCpkLX9ylGKlmdCNTRlWMgSI6eY0OdkdATpjYt5ViC2BxEuyiHl1qiNxsg==
X-Received: by 2002:a1c:228a:: with SMTP id i132mr3891279wmi.10.1620306498134;
        Thu, 06 May 2021 06:08:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-108-140.dyn.eolo.it. [146.241.108.140])
        by smtp.gmail.com with ESMTPSA id s21sm3242577wmc.10.2021.05.06.06.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:08:17 -0700 (PDT)
Message-ID: <a91633ccde6eca3ff6a280d9663c548938bfdc7c.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next 4/5] mptcp: dump csum fields in
 mptcp_dump_mpext
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
Date: Thu, 06 May 2021 15:08:16 +0200
In-Reply-To: <af98fe46c5b1d2737f02868fddb6d08e84d220c3.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com>
	 <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com>
	 <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com>
	 <0e4f818d6894959b07da34e2d190ec2a7aaba51e.1620286893.git.geliangtang@gmail.com>
	 <af98fe46c5b1d2737f02868fddb6d08e84d220c3.1620286893.git.geliangtang@gmail.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
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

On Thu, 2021-05-06 at 15:48 +0800, Geliang Tang wrote:
> In mptcp_dump_mpext, dump the csum fields, csum and csum_reqd in struct
> mptcp_dump_mpext too.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  include/trace/events/mptcp.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
> index 775a46d0b0f0..c853849692af 100644
> --- a/include/trace/events/mptcp.h
> +++ b/include/trace/events/mptcp.h
> @@ -73,6 +73,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
>  		__field(u64, data_seq)
>  		__field(u32, subflow_seq)
>  		__field(u16, data_len)
> +		__field(u16, csum)
>  		__field(u8, use_map)
>  		__field(u8, dsn64)
>  		__field(u8, data_fin)
> @@ -82,6 +83,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
>  		__field(u8, frozen)
>  		__field(u8, reset_transient)
>  		__field(u8, reset_reason)
> +		__field(u8, csum_reqd)
>  	),
>  
>  	TP_fast_assign(
> @@ -89,6 +91,7 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
>  		__entry->data_seq = mpext->data_seq;
>  		__entry->subflow_seq = mpext->subflow_seq;
>  		__entry->data_len = mpext->data_len;
> +		__entry->csum = (__force u16)mpext->csum;
>  		__entry->use_map = mpext->use_map;
>  		__entry->dsn64 = mpext->dsn64;
>  		__entry->data_fin = mpext->data_fin;
> @@ -98,16 +101,18 @@ DECLARE_EVENT_CLASS(mptcp_dump_mpext,
>  		__entry->frozen = mpext->frozen;
>  		__entry->reset_transient = mpext->reset_transient;
>  		__entry->reset_reason = mpext->reset_reason;
> +		__entry->csum_reqd = mpext->csum_reqd;
>  	),
>  
> -	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u",
> +	TP_printk("data_ack=%llu data_seq=%llu subflow_seq=%u data_len=%u csum=%u use_map=%u dsn64=%u data_fin=%u use_ack=%u ack64=%u mpc_map=%u frozen=%u reset_transient=%u reset_reason=%u csum_reqd=%u",

Minor thing: I personally prefer %x for csum, but it's not a big deal.

/P

