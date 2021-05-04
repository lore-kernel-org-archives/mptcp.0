Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAD670
	for <mptcp@lists.linux.dev>; Tue,  4 May 2021 21:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620164525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RZb2yoSrFdJlRy7Xz5Jz/AW+eBHCok4Eg55lys45sEc=;
	b=GIcY3P2AXDFQiHvUwYOB2Wja7DcZZw3UqKlKv+jZFTok4waIf0Lm/vWdFxMHZoL4pwSAEd
	dGybjQu3z8w4tXIs/agLKhANzIQOQQGM/WkxDK0/+8eFkuc43D53PxMWDa9g7oJwQC1gkr
	TnpI9JnuovtPFeoeiRgJWOMttKaSzQ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-QFOuc_kqPnGerKfHC25J_w-1; Tue, 04 May 2021 17:42:04 -0400
X-MC-Unique: QFOuc_kqPnGerKfHC25J_w-1
Received: by mail-wm1-f69.google.com with SMTP id d9-20020a1cb4090000b02901494f55f719so145121wmf.9
        for <mptcp@lists.linux.dev>; Tue, 04 May 2021 14:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZb2yoSrFdJlRy7Xz5Jz/AW+eBHCok4Eg55lys45sEc=;
        b=JoD9wZDgQtU0hWVPz0JqVb5LdH5ztafzCHAhilJOh104q440YH3/2ubKm2Gd5CH7mJ
         db80c2Vot14Hhxk2jYw+uuc1UWPGT+LNCY+qIx8jBTo96RuBR7xCMD/6GnT3pD6kANli
         vunDeQVtlDmF4L7BP38OM3bw/P1VsgH+WcWs/zkshX2vyceEm6nBrrueiLRlHYL4Kyt3
         +HzARU93PKn5MfNVJ36hDCAOpmcF589f/w8yaqlLSnEe3J0LazIlEL7CKH3JkqgyP78J
         ACFucvnYyoCDJHRMBwCM+0gkfjdAMxbPMu8C3AwatiswyCf3ObtupAXVfCuDBbWRvWap
         ukug==
X-Gm-Message-State: AOAM532cOVGr2A2/0htcSyBf5KcNgw1/yG6cG1QMU6t58aT+SWXwoTAZ
	B5dnHQxGWRnj58bXGnP10m5gTLYgEx2mfmIx8ptK3otGDDxj3Pbh7pxu/YwrhSpXCU1+Mrbjibe
	U+cYPNYsorMX6sjICZLvIQJlR61IOVd0=
X-Received: by 2002:a7b:c093:: with SMTP id r19mr13483080wmh.35.1620164522970;
        Tue, 04 May 2021 14:42:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTYUx7WrBTt4TGr4dGBccmA5jauFceaebUCWHWx7G898pWY8AG5yMKrX+0mdkpUwq1k0kAqFqMOFxh4FEfqhM=
X-Received: by 2002:a7b:c093:: with SMTP id r19mr13483069wmh.35.1620164522774;
 Tue, 04 May 2021 14:42:02 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1620162984.git.pabeni@redhat.com>
In-Reply-To: <cover.1620162984.git.pabeni@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 4 May 2021 23:41:51 +0200
Message-ID: <CAF6piCLEpoOfvTNBBptq1UdJS=OzqOQobdHeAah4eVtapQpTgg@mail.gmail.com>
Subject: Re: [PATCH v5 mptcp-next 00/21] mptcp: data checksum support
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue, May 4, 2021 at 11:39 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> Changed from v4:
>  - cope with odd-aligned csum blocks
>  - avoid re-adding multiple times the same skb bits on tx
>  - fix pseudo header generation (must be in NBO)

I'm ultra dumb && low on coffee. I unintentionally omitted the first
patch. Will send another iteration in moments. I already archived this
one. Sorry for the (lot of) noise.

/P

