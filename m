Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685E71
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624037718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hG4ctMLNGVMRMs6VeETlLLnO98NpUYNixpBErzNwHk=;
	b=Dt1CCwXobropFlmtvdhzaAoQEjLPZiG56SRF+iOofTOuUiN3HCtZc1WY0XclhK9uxOzFnE
	j/6lEMxEOlUx1Ewl5eYRBLYZjITi7kCaI3F+ARa5UjW/yk5wtviLlFL52Gg9WySwfLwxRp
	pawhWqP4Up5TOioqtM/RM39m2NgtHIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-nI0UGk-CMW2OCU37AJ967Q-1; Fri, 18 Jun 2021 13:35:16 -0400
X-MC-Unique: nI0UGk-CMW2OCU37AJ967Q-1
Received: by mail-wm1-f72.google.com with SMTP id z25-20020a1c4c190000b029019f15b0657dso4018041wmf.8
        for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 10:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5hG4ctMLNGVMRMs6VeETlLLnO98NpUYNixpBErzNwHk=;
        b=JAUD456VeOE9IMnQ5NOf/nR4hGWWBwVlWuh3Abp79UEOok6Z9FpPhZuKldGyYTG9nd
         nCv864RduggGgkPqIHrJ0//5mm9URYGTlRquG3RKSR75i1uDWua2DprtkOAPPBsXTgyt
         2udoXCs+sU/L4U2ys1LWMFoK0gTu5eX/N93kc0IWcaMdF3zU0X/cjs8vngA0wkoFF9L5
         PxS/Kk439fyFm4I9+O6WdkzObaQbRH1keNfwebHjUlAHvmhNTxWIriJqnOepvAyTj9yA
         DogGx6m2aV3VA6344jW1NFumTvPLFmPJONA0Aye+Km9hXVRuXKANSziBUqWQ1HxZf+QW
         6TSg==
X-Gm-Message-State: AOAM533Ks+lzmJcYoe+nH+iPiRs9U8EoZB6Ju0AoTB1+Ooga2DEuPrl8
	6PLezVw+hvGpP/4KGGPrOaActtIOHTibnTYbzCbOrFHEgbZrNPUigaxJtixkJ4Ob3fCXw1lyZDB
	nTKtOUGarCT9fbVpavGuQakD0gt53a37Sj5FNjuXRC6z9IJmXMmtkutORsnXaTpxc
X-Received: by 2002:a1c:f206:: with SMTP id s6mr12632467wmc.102.1624037715392;
        Fri, 18 Jun 2021 10:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPctxMVTUSa2Dgv/VuF9DwvZx7ZDO8kY0tMLu4aN05mxs2bF09gWLJ6zAkGxQlkJlqOal48A==
X-Received: by 2002:a1c:f206:: with SMTP id s6mr12632446wmc.102.1624037715212;
        Fri, 18 Jun 2021 10:35:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id q20sm11544748wrf.45.2021.06.18.10.35.14
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:35:14 -0700 (PDT)
Message-ID: <8b2d45c7c35cefc5283651aa75dcc497d1f78b1f.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 18 Jun 2021 19:35:14 +0200
In-Reply-To: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
References: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
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

On Wed, 2021-06-16 at 11:29 +0200, Paolo Abeni wrote:
> The current cleanup rbuf tries a bit too hard to avoid acquiring
> the subflow socket lock. We may end-up delaying the needed ack,
> or skip acking a blocked subflow.
> 
> Address the above extending the conditions used to trigger the cleanup
> to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
> on all the active subflows.
> 
> Note that we can't replicate the exact tests implemented in
> tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
> ping-pong mode.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v2 -> v3:
>  - mptcp_subflow_cleanup_rbuf() returns void
> v1 -> v2:
>  - access ssk icsk/tp state instead of msk (Mat)

Darn me! it looks like this patch has some issues, that are almost
hidden by mptcp-level retrans. Investigating. I'll try to provide a
squash-to patch.

Meanwhile we should not send this one to netdev.

Thanks!

Paolo

