Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF19173
	for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 10:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1642413836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgReck8balHp8bfceYpPQ0rXgMTqbrGcYDqYxTspV7o=;
	b=NtvM0YYW9vrLtEO8IJJJnT5qPG8ixIHOSaW+JEmRTLiSgT9UZSRTsERmbzmc5yclFJc6hL
	Wga8r6sIl3f5DnXDxuHkpbg7nwvnSJh0yspeAkED1GB8fT4mkpjc77PR1PwYuFEvJrSPw7
	zxB+wFD/JE95XacbHUmQchFHCQclZGE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-XD4EIsmdODO2C3ZAzKT-uw-1; Mon, 17 Jan 2022 05:03:50 -0500
X-MC-Unique: XD4EIsmdODO2C3ZAzKT-uw-1
Received: by mail-qt1-f197.google.com with SMTP id f21-20020ac840d5000000b002c93f29abbcso7342601qtm.14
        for <mptcp@lists.linux.dev>; Mon, 17 Jan 2022 02:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=jgReck8balHp8bfceYpPQ0rXgMTqbrGcYDqYxTspV7o=;
        b=UFKhy6hPAwNLbkvuzsX2ImOUyYfENxcdfAgSFPBBRUkTZNIvX4QAPFNhyGn45ZP+D0
         4Mkqqs3zmQWU3vkn+6gKla3wuhKona/9VAWhyhnXbZuf9o+082AYx9QbyWCUeOI/w/lz
         TCNKIbyPJrCXTeuUQtdjVB+4Ik9aLrA9WWAWrq7bbASepue89FRBcDBGU/RgBt+vQnyt
         tEcrpRzaFVGCvjcdewUmiauTpUB9NCD6p7ATwB8d0BaQ6i6+p0Go38GDiiVTG30HqwSx
         5BC2wUdZ/KNBhyn4FboZopSx51tpEBY4ztFm+YxQP6hnQ1nl3WRdUKeNcxZUdhsgAl2g
         22GQ==
X-Gm-Message-State: AOAM533So31+kYSAmqbGzeMBvVGelY2xFlOCQ3gdueKJqlmx0uBupkqL
	8D7a+gLkf2IYoxqoGfw9CkgvnSvi23FxNuRHqeyX6TgCTEY4Zu5FpjqHQOyePTFRu1jZcq196Cs
	D1XRE3i38qwYVbPw=
X-Received: by 2002:a05:620a:450e:: with SMTP id t14mr14018775qkp.748.1642413829805;
        Mon, 17 Jan 2022 02:03:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyzk0NExi80KoPKWN8m9OAXB5u88rA1wczJxgrRjW0SIwlq3X4AaV+FnvDa1bCHxuoY1zAnhw==
X-Received: by 2002:a05:620a:450e:: with SMTP id t14mr14018765qkp.748.1642413829595;
        Mon, 17 Jan 2022 02:03:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id q7sm8695120qkl.72.2022.01.17.02.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 02:03:49 -0800 (PST)
Message-ID: <9f700f12472bddc0d9d899773d2a211bfe8517f6.camel@redhat.com>
Subject: Re: [PATCH net-next v2] net: mptcp, Fast Open Mechanism
From: Paolo Abeni <pabeni@redhat.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>, mptcp@lists.linux.dev
Date: Mon, 17 Jan 2022 11:03:46 +0100
In-Reply-To: <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
References: <20220116001259.203319-1-dmytro@shytyi.net>
	 <449d3338d759e9f72f33e7c37e1b9956bdda77f4.camel@redhat.com>
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

On Mon, 2022-01-17 at 10:58 +0100, Paolo Abeni wrote:
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index 48d8a363319e..d7092234d442 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -54,7 +54,14 @@ static inline unsigned int tcp_optlen(const struct sk_buff *skb)
> >  /* TCP Fast Open */
> >  #define TCP_FASTOPEN_COOKIE_MIN	4	/* Min Fast Open Cookie size in bytes */
> >  #define TCP_FASTOPEN_COOKIE_MAX	16	/* Max Fast Open Cookie size in bytes */
> > +
> > +#if IS_ENABLED(CONFIG_MPTCP)
> > +#define TCP_FASTOPEN_COOKIE_SIZE 4	/* the size employed by MPTCP impl. */
> > +#else
> >  #define TCP_FASTOPEN_COOKIE_SIZE 8	/* the size employed by this impl. */
> > +#endif
> 
> You really need to document this kind of changes in the code, possibly
> referring to the RFC bits requiring it. 

Note that MPC + syn currently uses 24 bytes of TCP option spaces, and
MPC + syn + ack is using 32 bytes, to there is enough room for 8 bytes
cookies.

/P

