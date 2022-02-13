Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32A364
	for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 09:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644743204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYhGyNw9rf2i+6scpic9z2egz2gJxvAxZ6PvaT3f3Ds=;
	b=M1dNbiSafRlz+NDVtHJxNjdyQp4Ql/i3jVr5NRbahOcZ2CZE5P8S1316xLm8ytTjvy2UqC
	ZHNEBzEO4FVqmrrWUQ2GWkAZXnXoy/sAhS5LX9vad1Col9jAJTKiUNE5TVvapB+GlJ88be
	ZDhDkp1qb3K9rfcEIcIO7jamGXnyulc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-nBhZZeknMzKXgqEyN1hh4Q-1; Sun, 13 Feb 2022 04:06:43 -0500
X-MC-Unique: nBhZZeknMzKXgqEyN1hh4Q-1
Received: by mail-wr1-f72.google.com with SMTP id g11-20020adfa48b000000b001e57dfb3c38so1829781wrb.2
        for <mptcp@lists.linux.dev>; Sun, 13 Feb 2022 01:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HYhGyNw9rf2i+6scpic9z2egz2gJxvAxZ6PvaT3f3Ds=;
        b=lympUgmdsykwewheicjpi1Sq5gWv+9FPw4qaB0Z9tmwgQwAEyYHBvznRY3xo/JhZ3g
         dXnmaa3H4H1CgUxvoD6hVOioeZLtBp8T3pmo5K0AUkggCgKcdpBEI/SPw4YPnKM8D7ln
         6p/RYMt8WrBKq6CUDLfF+ERzx0TTKI/BJSHRf2l8EaF0eoX4FLD7m3IsbSiwmiXWjHMT
         A7vhhY+E6WrUppomB3wGfMnSZ5GyixOrwrqjtcSvHrIrw1VQ3no4WoquYdej4TKl1Zff
         buwSl54UxqqYC8rnrs7LkMTL9Bpg6LhRL15M3ob0vVIfr2HGiRmQNa7Vj7UxJYpgoa4m
         Zjdg==
X-Gm-Message-State: AOAM5326A/WRzjm1Sni5svmSbvSZbD7sB5GeNtDUFquGJ+zH0RmIZzWY
	f7QOzXW8OTC5ZsFmc29O51Gmxv8iDHFExJr5bVqjD/szJbQy1ofkKFxxQY4+yS0AKFQA0emxncb
	rMJ0w3qjiKIMgWa4=
X-Received: by 2002:a5d:6452:: with SMTP id d18mr7176415wrw.493.1644743201711;
        Sun, 13 Feb 2022 01:06:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx71GWElWq0sA0RvK8AA+u3LOVvhyOm3lgD0A9b04YsRiV3aLI8/cQ8eUqZ7/v1ZQSqO/Q9Kw==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr7176405wrw.493.1644743201507;
        Sun, 13 Feb 2022 01:06:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id n11sm8794459wms.13.2022.02.13.01.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 01:06:41 -0800 (PST)
Message-ID: <7220b597803c6d8a95e73b197a314688070d6c0d.camel@redhat.com>
Subject: Re: [PATCH v3 mptcp-next 2/3] mptcp: more careful RM_ADDR generation
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Sun, 13 Feb 2022 10:06:40 +0100
In-Reply-To: <b8278b6c-95b7-3c24-73e4-59a093c47f8b@linux.intel.com>
References: <cover.1644518737.git.pabeni@redhat.com>
	 <baade0ed606c745a8acd5bcb075269550cd80544.1644518737.git.pabeni@redhat.com>
	 <b8278b6c-95b7-3c24-73e4-59a093c47f8b@linux.intel.com>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Fri, 2022-02-11 at 15:10 -0800, Mat Martineau wrote:
> On Thu, 10 Feb 2022, Paolo Abeni wrote:
> 
> > In some edge scenarios, an MPTCP subflows can use a local address
> > mapped by a "dummy" endpoint created by the in kernel path manager.
> > 
> > When such endpoint is deleted, the in kernel PM sends a RM_ADDR MPTCP
> > suboption. That is somewhat unexpected, as an MPTCP listener will keep
> > accepting incoming subflows targeting such address and the unexpected
> > options can confuse some self-tests.
> > 
> > Be more conservative about RM_ADDR generation: do it only if the
> > relevant endpoint has either the SIGNAL or SUBFLOW flag - it's not a
> > dummy one.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > include/uapi/linux/mptcp.h |  1 +
> > net/mptcp/pm_netlink.c     | 25 +++++++++++++++++--------
> > 2 files changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index f106a3941cdf..34ca8c04f64e 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -81,6 +81,7 @@ enum {
> > #define MPTCP_PM_ADDR_FLAG_SUBFLOW			(1 << 1)
> > #define MPTCP_PM_ADDR_FLAG_BACKUP			(1 << 2)
> > #define MPTCP_PM_ADDR_FLAG_FULLMESH			(1 << 3)
> > +#define MPTCP_PM_ADDR_FLAG_DUMMY			(1 << 4)
> 
> Since this is a public API, "DUMMY" might be a confusing / ambiguous name. 
> MPTCP_PM_ADDR_FLAG_IMPLICIT_ENDPOINT or MPTCP_PM_ADDR_FLAG_UNADVERTISED 
> maybe? (open to other ideas of course)

I think "IMPLICIT" is the better option, as it's both unadvertised, not
used for subflow.
> 
> It looks like these dummy/implicit records stay around until a flush 
> happens. What if there's a request to advertise an address that has had a 
> dummy created already? mptcp_pm_nl_append_new_local_addr() would consider 
> that a duplicate and reject it, but replacing the dummy record with a real 
> one would be better.

Agreed. I'll do that in the next iteration.

/P

