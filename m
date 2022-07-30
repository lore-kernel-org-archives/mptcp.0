Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1123BB
	for <mptcp@lists.linux.dev>; Sat, 30 Jul 2022 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659162771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onmYEvHKz5UugOIjsa2laPypbVDou4vRY5s53enTdvE=;
	b=Izht1mVcA4bJEEmiBb6zSXSqfhdnHi7zIb/P/zxr/1WsmK187JbV8gm+wxBT5Uls8s5JEm
	fmZilm1l6UAWtLJxGYVM+bqspH+B7xE+gW41qeVF+hTR5aGVdE4CMREG6Xp3Nqu0i8vNH0
	+h/9vwXcIZmY8TiN7hJn69FGRfTQino=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-RjWqovhZP42tf2EODFMeQg-1; Sat, 30 Jul 2022 02:32:50 -0400
X-MC-Unique: RjWqovhZP42tf2EODFMeQg-1
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a056402270a00b0043c0fed89b9so4145538edd.15
        for <mptcp@lists.linux.dev>; Fri, 29 Jul 2022 23:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=onmYEvHKz5UugOIjsa2laPypbVDou4vRY5s53enTdvE=;
        b=qhGUArNe4i5D+HrL5NiIQHub4R0OAokOxA5lo76ts4Y+NdQ7ukayglxlNL9Z3qyDl6
         LeVWE6d8HNas82HLalbyDPpgzMJYKdv/rqiIyQ1sUfxhjdurDSA68yUYF6CtJdGoHrvp
         dE8g6myj6ka/jlzvUZ0HFLgqGtz1JosxBAmni1baFZcp/D1KiZEVjTrGwTVeYaYKGPJB
         i+C9XkpwCJKpQS1t/XGvjX3tjCpcDgUlJlzrDogL9QkyL+FkapGM/eYvUajF5GBb0GID
         6uRmU1lj39vOzBuIJfykYxcXxQF8b1xLd9q7DFMN17sANzIfbBRI2i8kkXKycodrdVbD
         Bj4g==
X-Gm-Message-State: AJIora+XlYMVjQuaxgLnIhNxcuZkEDdnjrbhcfx+4bBHwCkZ0BWz1sfx
	Gqay1zxgkt7mHRz3X7s7CGX2kvFK++ENURsEiMTdDxhMxQHjcGJY28BuJmVM16CgoUnkAke/6HB
	3RZyxr/11NNr2M2w=
X-Received: by 2002:a17:907:2887:b0:72b:68ce:2fff with SMTP id em7-20020a170907288700b0072b68ce2fffmr5298294ejc.423.1659162769295;
        Fri, 29 Jul 2022 23:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vF1MLFGWbm9HUA8RY18v15frJ06wyW2kp4wg5HrHH7FIhpBeePIuxq3RsS0esmHAJb4jutSA==
X-Received: by 2002:a17:907:2887:b0:72b:68ce:2fff with SMTP id em7-20020a170907288700b0072b68ce2fffmr5298289ejc.423.1659162769002;
        Fri, 29 Jul 2022 23:32:49 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-118-222.dyn.eolo.it. [146.241.118.222])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906775500b0072f9dc2c246sm2533134ejn.133.2022.07.29.23.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 23:32:48 -0700 (PDT)
Message-ID: <b7db532c870abf0dc4ec69dc1e7a812477c706b0.camel@redhat.com>
Subject: Re: [PATCH v2 mptcp-next 3/4] mptcp: move msk input path under full
 msk socket lock
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Sat, 30 Jul 2022 08:32:47 +0200
In-Reply-To: <f38c787-a76b-3236-814e-aa9493e4676f@linux.intel.com>
References: <cover.1659117128.git.pabeni@redhat.com>
	 <24af8221d74f9923858c926d4acb7d81e37dd4d2.1659117128.git.pabeni@redhat.com>
	 <f38c787-a76b-3236-814e-aa9493e4676f@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Fri, 2022-07-29 at 16:02 -0700, Mat Martineau wrote:
> On Fri, 29 Jul 2022, Paolo Abeni wrote:
> 
> > After commit c2e6048fa1cf ("mptcp: fix race in release_cb") it's
> > pretty straight forward move the whole MPTCP rx path under the socket
> > lock leveraging the release_cb.
> > 
> > We can drop a bunch of spin_lock pairs in the receive functions, use
> > a single receive queue and invoke __mptcp_move_skbs only when subflows
> > ask for it.
> > 
> > This will allow more cleanup in the next patch.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > net/mptcp/protocol.c | 78 +++++++++++++++++++-------------------------
> > net/mptcp/protocol.h |  2 +-
> > 2 files changed, 35 insertions(+), 45 deletions(-)
> > 
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 17e2dbe43639..b7982b578c86 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -795,7 +795,7 @@ static bool move_skbs_to_msk(struct mptcp_sock *msk, struct sock *ssk)
> > 	return moved > 0;
> > }
> > 
> > -void mptcp_data_ready(struct sock *sk, struct sock *ssk)
> > +void __mptcp_data_ready(struct sock *sk, struct sock *ssk)
> 
> While a normal build works fine, the CI is complaining about this line in 
> the "make W=1 C=1" build. The function is only used in this file, so 
> adding 'static' would make 'sparse' happy.

Thanks, I'll fix it in the next iteration.

Cheers,

Paolo

