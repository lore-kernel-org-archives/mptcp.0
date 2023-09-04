Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6BAD5F
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 15:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693840839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JF5dYBNHCAEIZ0U8zKwwpIKuqpHQLQHgBv+yZbPtWLA=;
	b=a3SPd4TdF3BJxNiZtG8uE70dbHxjTBbt5KWHaUdERBrsO5qQBqSTaQaYyvMgW7wU8t3UfU
	/3LhX65DQ9GTnJKippYE++MdSLnughWXtMHB3vYekFSi1I8OQr2TlIoW3flSxJ6KtQD/xC
	85DZAjXkpNgTSnE9FcguZcXj4ohqz7o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ZDw4OvlTPtCAwg97Di1LlA-1; Mon, 04 Sep 2023 11:20:37 -0400
X-MC-Unique: ZDw4OvlTPtCAwg97Di1LlA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2bcda0aa7ffso16599171fa.1
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 08:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693840836; x=1694445636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF5dYBNHCAEIZ0U8zKwwpIKuqpHQLQHgBv+yZbPtWLA=;
        b=Q066YntfVZXDcGIBCPe8aKqbklV4Uf73dBCK67+FUU6bc7Ow6S/f7U3Vuz1WP4dzIK
         1ElUgOIYSpUzkfNoRhDMS5MIvp6BpDgzvoazxEEbAmGt/VFd2Wao4X2SRAxHdC8OXhyT
         lkw5RGnkzrz9tqeiDGi9zZmLK4kDRkWQTJ04Rj9mtohkj2u07uxoUJQkAUqLUl6tpCUm
         orV3ozK+io9EpKpJVZ4x/+yitN61zlR+COEcPJ0qdA+3MB484NSL8O3nVPuoQnSLhszg
         O3+0h7i1WAjJndmgRJqiwgSf6bA8x8upBRZFTXHNPWQdCjaD61Idqr+w03rjInXjLNJo
         831A==
X-Gm-Message-State: AOJu0YydFWMlgFgQjwodA1yZvmkTQzIfTcwrLHFQnY0JcRDVqsqVU9ql
	KmRqQ6vxLRgOtgkeXXxOxF3Qlws0iS1UBopWAQavhx/CCRCKh0CCdkLjltYDjoLrefm/FWjDxpq
	uerge7f1CSEupnlM=
X-Received: by 2002:a2e:8093:0:b0:2ba:8127:a2c3 with SMTP id i19-20020a2e8093000000b002ba8127a2c3mr7328968ljg.34.1693840836454;
        Mon, 04 Sep 2023 08:20:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf2XurCcnKBJpz4D1hGv3pe5qQX3GvGjw63aLIp+Fry+lAEG9pHq01DgmPvMkz7Y0MqAwmaw==
X-Received: by 2002:a2e:8093:0:b0:2ba:8127:a2c3 with SMTP id i19-20020a2e8093000000b002ba8127a2c3mr7328951ljg.34.1693840836082;
        Mon, 04 Sep 2023 08:20:36 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id w22-20020a170906131600b0099d9b50d786sm6308269ejb.199.2023.09.04.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 08:20:35 -0700 (PDT)
Date: Mon, 4 Sep 2023 17:20:34 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next v2 2/6] mptcp: convert netlink from small_ops
 to ops
Message-ID: <ZPX1wsXgq7FkIcz7@dcaratti.users.ipa.redhat.com>
References: <cover.1693591676.git.dcaratti@redhat.com>
 <9079cf99466869474845cf89b55de5dfa7e01326.1693591676.git.dcaratti@redhat.com>
 <70d408aed5fe8f7a307aa024f3614d1daae6a6ad.camel@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <70d408aed5fe8f7a307aa024f3614d1daae6a6ad.camel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hello Paolo, thanks for looking at this!

On Mon, Sep 04, 2023 at 11:13:15AM +0200, Paolo Abeni wrote:
> On Fri, 2023-09-01 at 20:10 +0200, Davide Caratti wrote:
> > in the current MPTCP control plane, all operations use a netlink
> > attribute of the same type "MPTCP_PM_ATTR". However, add/del/get/flush
> > operations only parse the first element in the message _ the one that
> > describes MPTCP endpoints (that was named MPTCP_PM_ATTR_ADDR and
> > mostly used in ADD_ADDR operations _ probably the similarity of "attr",
> > "addr" and "add" might cause some confusion to human readers).
> > Convert MPTCP from 'small_ops' to 'ops', thus allowing different attributes
> > for each single operation, hopefully makes all this clearer to human
> > readers.
> 
> Minor nit: I'm wondering if it would make sense factoring out only the
> bits replacing MPTCP_PM_ATTR_ADDR with MPTCP_PM_ENDPOINT_ADDR, to make
> it clearer what is happening here.

I think the addition of MPTCP_PM_ENDPOINT_ADDR and its use in add/del/get/flush
operation would have little/no sense with small_ops. It's there to avoid
selecting an element in 'endpoint' using the same label we use to
get the local address form 'attr'.
 
> Likely not a big deal either ways.

I'd like to keep one single patch that does the 'small_ops' ->
'ops' conversion (to avoid adding a hidden dependency to future patches
that will fix this patch. You know, there are those fancy tools that select
follow-ups commits ;) ).

>  
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 9661f3812682..3859a206c298 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -48,6 +48,53 @@ struct pm_nl_pernet {
> >  #define MPTCP_PM_ADDR_MAX	8
> >  #define ADD_ADDR_RETRANS_MAX	3
> >  
> > +const struct nla_policy mptcp_pm_address_nl_policy[MPTCP_PM_ADDR_ATTR_IF_IDX + 1] = {
> 
> The above is a little confusing...
> 
> > +	[MPTCP_PM_ADDR_ATTR_FAMILY] = { .type = NLA_U16, },
> > +	[MPTCP_PM_ADDR_ATTR_ADDR4] = { .type = NLA_U32, },
> > +	[MPTCP_PM_ADDR_ATTR_ADDR6] = { .len = 16, },
> > +	[MPTCP_PM_ADDR_ATTR_ID] = { .type = NLA_U8, },
> > +	[MPTCP_PM_ADDR_ATTR_PORT] = { .type = NLA_U16, },
> > +	[MPTCP_PM_ADDR_ATTR_IF_IDX] = { .type = NLA_S32, },
> > +	[MPTCP_PM_ADDR_ATTR_FLAGS] = { .type = NLA_U32, },
> > +};
> 
> ... given that MPTCP_PM_ADDR_ATTR_IF_IDX is not listed last here.

dood catch,
 
> I guess this layout has been chosen to match what the tool generates
> for the spec, right?

no no, it's just misplaced :) . Let me fix it and I'll post v3.

> 
> What if we reorder the 'attributes' in 'operations/list' in patch 3/6
> to respect the corresponding numeric order? would that lead to more
> natural order here, too?

in patch 3/6 they are actually respecting the numeric order: otherwise
the uAPI would be broken (e.g. a userspace program would see a value
change in one or more enum elements).

I see that we have some spots like:

 382       do: &sf_create
 383         request:
 384           attributes:
 385             - addr_remote
                     ^^^ this is out-of-order, but  the C code is generated correctly
 386             - token
                     ^^^ same here
 387             - addr


they can be fixed with in patch 3 v3, but that will have with no effect on the
generated C code. Did I get correctly the change request?

