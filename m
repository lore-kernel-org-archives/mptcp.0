Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7648670
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627469181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oytcwUKmG9o0OKKP8l0Lgz7NWizJdh9f4j/WK5WW2MA=;
	b=ds0/vXfqAf+BOGUfmK2Ewozn5ZQ6suiUaeXd3kDV5WVfpe3ApbGoY0umppkaRIHCpMd+8X
	IwZ34njg66Isoui2lEnzh0ksGL8uoJpaYVr/BbYONDAK5mRHYm2wWAdUyHkOaLdifUL2vW
	ZeYgMpO31Y5p0+9P36fftl+U0dRUfCQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-xvuE1zSKMF6ta6a_vQWvMg-1; Wed, 28 Jul 2021 06:46:18 -0400
X-MC-Unique: xvuE1zSKMF6ta6a_vQWvMg-1
Received: by mail-wm1-f71.google.com with SMTP id 25-20020a05600c0219b029024ebb12928cso789989wmi.3
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 03:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=oytcwUKmG9o0OKKP8l0Lgz7NWizJdh9f4j/WK5WW2MA=;
        b=jqUs6AiUg+4Z5KIa/pMBZ0u0p4h7iJt1Pgp45rytcZA13bTcOkKuxZJOjN1MvX8xrj
         Qu7p7XG4fbVh8/STPziVZRzjSnZPFi27FFYegHKKvkpLLZ/4RtxvIecbxsvNhwnOazDQ
         EH1WVHCtg2vyytrkrFPQPHejJsMN2OmgVItcAmwsN5+wZZIziqnyr2yMbzBA6m++UcVh
         NrT5AvEJ+flyf4N+Q/L3HxwrQpofVGKcEKitEFly5m3nw2bKSutXe8Yh0bRYOuNBIsP9
         SnbNhKjsKda06anBYSOIMqFmWjnoAgSpfgiK3u1zV4o0X90OAHgfElGi+dWNGgcr1uFQ
         /2ig==
X-Gm-Message-State: AOAM5324BzFZIZSR+AZQUH4d84ZYUfWxH7N2Tx+fg7xxEEMfB7rfDyhU
	t4gfcDnsh5SknuWDYRkPGsWNGl++guZ4CKrfOHPCyxf/qE7MD8LXWAxDxkeFwW/H5dSmGI2Uxp7
	/SCPhvF9HtJvj0xs=
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr15475478wro.207.1627469177494;
        Wed, 28 Jul 2021 03:46:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2UjJiA4o/Cs7el6dgwnuBQYKPLm6u+OK4QfEJxew5FkIswt72Pv0eQMQk1WEFUBrzADFfrg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr15475466wro.207.1627469177347;
        Wed, 28 Jul 2021 03:46:17 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id u11sm6262385wrr.44.2021.07.28.03.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 03:46:16 -0700 (PDT)
Message-ID: <e2dbd89b5a1c540b046bb5496a5a26e8efccf3e3.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 0/3] mptcp: minor out optimization
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 28 Jul 2021 12:46:16 +0200
In-Reply-To: <aca30f71-bc68-7e33-65c5-c5bcb79fd043@tessares.net>
References: <cover.1627296764.git.pabeni@redhat.com>
	 <aca30f71-bc68-7e33-65c5-c5bcb79fd043@tessares.net>
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

On Wed, 2021-07-28 at 10:09 +0200, Matthieu Baerts wrote:
> Hi Paolo, Geliang, Mat,
> 
> On 26/07/2021 12:55, Paolo Abeni wrote:
> > This series implements a few ideas discussed in the past mtg,
> > specifcally:
> > 
> > https://github.com/multipath-tcp/mptcp_net-next/issues/15
> > https://github.com/multipath-tcp/mptcp_net-next/issues/42
> 
> Should we close any of them? e.g. the issue #15?

I think we can close #15. I also think we can keep #42 open - not only
for hhgttg's sake - becuse looking at the MP_FAIL series it seams we
have a few more conditional we can get rid of in the input path.

Cheers,

Paolo

