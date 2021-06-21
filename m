Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442A72
	for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 10:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1624272644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHnjpjHJg0uW4+T9cx3SnuJijay/uC2e//vg4nZOtyk=;
	b=EKsGytgBYFjGYaYPLXn94DTIPl6eoiUwXZvtRBPiXur2gqNhqWdzwfiduXcBNEcUh968BY
	erkQFKI8j9jfgGnPvtLSLrDAFS7b1kBxOt7LtJaooe36FmDKYZdcNvl1+FKd6npO7wfTAs
	GnBDYGmw5nVo094zn+AfESTObCYC6q4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-0CiK2iGVOLSJ42AFrfzZJg-1; Mon, 21 Jun 2021 06:50:42 -0400
X-MC-Unique: 0CiK2iGVOLSJ42AFrfzZJg-1
Received: by mail-wm1-f69.google.com with SMTP id j18-20020a05600c1c12b02901dce930b374so2054024wms.2
        for <mptcp@lists.linux.dev>; Mon, 21 Jun 2021 03:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MHnjpjHJg0uW4+T9cx3SnuJijay/uC2e//vg4nZOtyk=;
        b=ZUDuO8UpQKfr3jSvsTkSL7IZvLFCdlsePDnDfeKspaztj2rMhT+ii6MT2oKBtNYxxK
         HALe0AY/H6LJjeUOljeWO+dQAB5eYf04RVsQ65aTfmZ4fVXF5+2f/iP8U2Uve+EmbOTf
         vltcFFcteTS063chmOe6w9GxPhDsHl8uwcRnLsJ9C+SkOHmUczNxWDGtCSGOk7F9FMl4
         FwLVqcmzbnLy5TSEJDOP90/EF1kc1dN7iK2YnR9nScVscs1Om1YvwQfW8ueET+kuEQxb
         kccoGNejqro1OmT4dk4dAWWUS4yBb6QR4z9IAfApQIyGo9OFrzLzXaZAGnaa/zawPz4a
         q6aw==
X-Gm-Message-State: AOAM531YM1KdOA/TRook3+x8xloYn1ZLOJt6cwE6VD9gULY5Xb8cbang
	Sxivrr+T7PHCd+W4pI2a3ivabuCbQ0J1fh/W0R/PSWv49oTHP7lH+roLjfj0dgMhdv2KpYwuvC0
	mk3zBEA7Hgnr1hhtLLX/2q/nkFvf51q7G+3R0AIFr3OIj4NfYg3UI096bdxkpRpPj
X-Received: by 2002:adf:de0e:: with SMTP id b14mr27897238wrm.229.1624272641453;
        Mon, 21 Jun 2021 03:50:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT/LukIrNeTNldTwh97TcUSylyvvJWKqoMDY0RcInrbqlWfEQ2A22Nu6KwWK5I3ftvwUyTGw==
X-Received: by 2002:adf:de0e:: with SMTP id b14mr27897218wrm.229.1624272641266;
        Mon, 21 Jun 2021 03:50:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id t17sm15938013wmi.47.2021.06.21.03.50.40
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:50:41 -0700 (PDT)
Message-ID: <e6a3e96f88ef4af2f0daf2f1996d851364cb71b3.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next] mptcp: refine mptcp_cleanup_rbuf
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Mon, 21 Jun 2021 12:50:40 +0200
In-Reply-To: <8b2d45c7c35cefc5283651aa75dcc497d1f78b1f.camel@redhat.com>
References: <93432e2a93c4ae6124fb607346ecfac45d40b2b3.1623835767.git.pabeni@redhat.com>
	 <8b2d45c7c35cefc5283651aa75dcc497d1f78b1f.camel@redhat.com>
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

On Fri, 2021-06-18 at 19:35 +0200, Paolo Abeni wrote:
> On Wed, 2021-06-16 at 11:29 +0200, Paolo Abeni wrote:
> > The current cleanup rbuf tries a bit too hard to avoid acquiring
> > the subflow socket lock. We may end-up delaying the needed ack,
> > or skip acking a blocked subflow.
> > 
> > Address the above extending the conditions used to trigger the cleanup
> > to reflect more closely what TCP does and invoking tcp_cleanup_rbuf()
> > on all the active subflows.
> > 
> > Note that we can't replicate the exact tests implemented in
> > tcp_cleanup_rbuf(), as MPTCP lacks some of the required info - e.g.
> > ping-pong mode.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > v2 -> v3:
> >  - mptcp_subflow_cleanup_rbuf() returns void
> > v1 -> v2:
> >  - access ssk icsk/tp state instead of msk (Mat)
> 
> Darn me! it looks like this patch has some issues, that are almost
> hidden by mptcp-level retrans. Investigating. I'll try to provide a
> squash-to patch.
> 
> Meanwhile we should not send this one to netdev.

Well, it looks like the issue I observer predates this change. The
point is: if we disable mptcp-level retrans, mptcp_connect.sh self-test 
in a loop hang on some lossy test-case (which is unexpected).

I *think* the solution is still in a better mptcp_cleanup_rbuf() -
which is eluding me since several iteration :(

/P


