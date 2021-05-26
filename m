Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5322FAE
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622026232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tw/+CTVNhGdGLLEORvuhYB9AfeBDLWdYkoO9jzUyQY=;
	b=cH4UpqdTcV+IZDkASB1d7VpEbhuXj+SGAjOcehNm1UXfgDUFoXtFIVQIIoY7YlkcPmYNmS
	dcoU24uXm6VDR/NGcrykiM8OSkih5zthDeiWcuhLPS+XljxqnYemO8MtV783++ft5IjqxW
	WtwqXRSRGI8YVNTisMJMYLzRN9QSZJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-WZut0i9tP_2gWybUJSRtlA-1; Wed, 26 May 2021 06:50:30 -0400
X-MC-Unique: WZut0i9tP_2gWybUJSRtlA-1
Received: by mail-wm1-f71.google.com with SMTP id b67-20020a1ce4460000b029017517d833b9so260913wmh.0
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 03:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2tw/+CTVNhGdGLLEORvuhYB9AfeBDLWdYkoO9jzUyQY=;
        b=FHTfhiBtNt8ieLs8mdoU1Z+H0g5t82nHNNbCHeME6LJrQGSQxQOwiSB9RIq/1QzluT
         Rm2yGa2s6cWZ1Cww4jo375a7/oo0IV0Y9x8ofpUYCF7MwgQ4KeGy2J0J8tm+HSmrflSa
         M1FNhYrsTaZYvdDz2SxD3Zczkj0eis9BW+0OUm2QWaibqoLaApyPieeG4to/RICBqrjj
         oo6OwobFSgx640XrLdrt2Y0je0JOzkzU6FykPmh8dm+QMVPr/bIEUYvIp1Xa80tYp5um
         uURPIl0Hkv7wQYi67a0nK1rRn2gy3mJ2dnQUs6v9VuZD+NqN8NXFGcCwvz76IZGvZojZ
         NX/A==
X-Gm-Message-State: AOAM532Kym671iIVdOiIqAVT8qcvoTnnJToUjtukd8UkC/m5LS5exarm
	q5q3XFRsnXHKrjYgGJcAEDCL0W+qzQ3jqix1Z/2Hio/TRFzmopGnrPHq/w6SmSG9IpzRBVxCBMn
	nQLQv+XEm4r2WXzI=
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2850853wmg.146.1622026229592;
        Wed, 26 May 2021 03:50:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysDMqycsDAYVVD9fSUBinVFf3lBxvCWAogwlgp6CxwlE9gvxm2D7+YxxDt2fwz+8mZ/U9qag==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2850838wmg.146.1622026229415;
        Wed, 26 May 2021 03:50:29 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id h15sm14031889wmq.1.2021.05.26.03.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 03:50:29 -0700 (PDT)
Message-ID: <eaf90206af6e2dce2629dc34a02d7ccd8b9cea2e.camel@redhat.com>
Subject: Re: [RFC PATCH 3/4] mptcp: move the whole rx path under msk socket
 lock protection
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, fwestpha@redhat.com
Date: Wed, 26 May 2021 12:50:28 +0200
In-Reply-To: <1ca3ad58-99de-5e3b-7a9c-e62f1413b@linux.intel.com>
References: <cover.1621963632.git.pabeni@redhat.com>
	 <3fa2a7102e0ca7e89dac2e14e60469ac414bcef4.1621963632.git.pabeni@redhat.com>
	 <1ca3ad58-99de-5e3b-7a9c-e62f1413b@linux.intel.com>
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

On Tue, 2021-05-25 at 17:06 -0700, Mat Martineau wrote:
> On Tue, 25 May 2021, Paolo Abeni wrote:
> 
> > After commit c2e6048fa1cf ("mptcp: fix race in release_cb") it's
> > pretty straight forward move the whole MPTCP rx path under the socket
> > lock leveraging the release_cb.
> > 
> > We can drop a bunch of spin_lock pairs in the receive functions, use
> > a single receive queue and invoke __mptcp_move_skbs only when subflows
> > ask for it.
> > 
> > This will allow more cleanup in the next patch
> > 
> 
> Like you said in the cover letter, the perf data will really help with 
> understanding the performance tradeoff.
> 
> I'm a little paranoid about the locking changes, since the 
> mptcp_data_lock() is used to protect several things. What do you think 
> about a debug patch (maybe temporarily in the export branch, but not 
> upstreamed) that used spin_is_locked() or assert_spin_locked() to double 
> check that there's still lock coverage where we expect it?

I thought about that. The "problem" is that the relevant  lockdep
assertion is 'lockdep_sock_is_held()' which is both quite simple to
verify with code inspection only and not very accurate:
lockdep_sock_is_held() can be true and the caller can be without the
appropriate lock e.g. if lockdep_is_held(&sk->sk_lock.slock) and sk-
>sk_lock.owned by someonelse.

TL;DR: lock assertion can be added, but very likely with little value.
Please let me know if I should add it in the next iteration.

On the flip/positive side, I keep this thing running for the whole WE
without any issue ;)

Thanks!

Paolo


