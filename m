Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC770
	for <mptcp@lists.linux.dev>; Thu,  3 Jun 2021 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1622731296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCl0n3tdXkbGL+QNveo3Se6UoHi489YplEmRf4pfqRI=;
	b=dr3/4v7tykikBjjGD7R7hhGVTVFEWbSXdNCNMHMKIbmA8AZhuftJg1u7jtERVN42ez7UnK
	xsoxYxq77wfDMMzT9hYIX/BReexN36ZtSej1fYuF6lK0+cK+s3rRIa0td0ZwCASloshj7U
	1lqWRopZFMR3uKsyC0Sf+ouDKH8NEZ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-fdua6afENOKPXaRkUkI8zQ-1; Thu, 03 Jun 2021 10:41:32 -0400
X-MC-Unique: fdua6afENOKPXaRkUkI8zQ-1
Received: by mail-wr1-f71.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so2538104wrs.5
        for <mptcp@lists.linux.dev>; Thu, 03 Jun 2021 07:41:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HCl0n3tdXkbGL+QNveo3Se6UoHi489YplEmRf4pfqRI=;
        b=tw9b6OdA+9Lx9Cy6UnJO2MaZ9DKDOW4fqps2ePobUNEakKtTBy3BiurPAHDXFyMV5/
         hP1i6Z2sd0cMxeOZJe6GUk/gaVDRDhRef9dQrmN+EKz8u77Gnp0KpEeUzwYanmhb2tsH
         HsyaPoZi6zqFU/bV+9stej0YnTAC1532D4oBTXCR9bPEO5nE0UiMVhk+w2dKt3fynyJh
         /+bm/4geIi3Gzx7cqzWORRiVG7slxnSvW9B5PXdkQMoPaxeE2f9EwtzU0F7FQNF1LZ6X
         ROoHZ4AH650zogs5WK7a6wQFrv/uqzaqmR+o/khWxk7rbOSSw2jAW7cb4BYqh9MtIqQO
         3IUw==
X-Gm-Message-State: AOAM531wg68Q09aaSIZD/7Ou59pcejO+WjZBqXZuSVFv6HbPyna8VDUR
	qVRm3u+PDtQ0KwlqegEMQPB62APdZboSgaj4OkuYpr9HCbJYFkN8QK059SwhwZ48h0lZBpaQmoq
	P0sau4QPW8myi9H4=
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr350738wrm.114.1622731291602;
        Thu, 03 Jun 2021 07:41:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYpf6PwgJiuIBfGZEgbsCz/ci5gelcvYl91UQGYsMRH/zpN22GoY0+lV6u8+XUhQ6ubXjSUw==
X-Received: by 2002:adf:e4d2:: with SMTP id v18mr350723wrm.114.1622731291382;
        Thu, 03 Jun 2021 07:41:31 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-110-123.dyn.eolo.it. [146.241.110.123])
        by smtp.gmail.com with ESMTPSA id a77sm3955511wmd.14.2021.06.03.07.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:41:31 -0700 (PDT)
Message-ID: <190040c2dd1f25dd97ddd43ed124ea106f512e2e.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: add MIB counter for invalid mapping
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Galaganov <max@internet.ru>
Cc: mptcp@lists.linux.dev
Date: Thu, 03 Jun 2021 16:41:29 +0200
In-Reply-To: <ae6bfc3a-e6e2-f9aa-ed9f-e5aca04ed65b@internet.ru>
References: <89666f3fb8f14bbe545f2079794ab78ba24fbbc4.1622720045.git.pabeni@redhat.com>
	 <ae6bfc3a-e6e2-f9aa-ed9f-e5aca04ed65b@internet.ru>
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
Content-Transfer-Encoding: 8bit

On Thu, 2021-06-03 at 17:30 +0300, Maxim Galaganov wrote:
> 03.06.2021 16:25, Paolo Abeni пишет:
> > Account this exceptional events for better introspection.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >   net/mptcp/mib.h     | 1 +
> >   net/mptcp/subflow.c | 4 +++-
> >   2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> > index 92e56c0cfbdd..193466c9b549 100644
> > --- a/net/mptcp/mib.h
> > +++ b/net/mptcp/mib.h
> > @@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
> >   	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
> >   	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
> >   	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
> > +	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
> 
> Shouldn't there also be a related change to mptcp_snmp_list in mib.c ?

Indeed! thanks for double checking!

I'll send a v2

/P

