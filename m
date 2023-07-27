Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520C2712E
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690478360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4CQl/KqIX11L3TiHMHd5HwEW/uogwdH+taMU4z+h54=;
	b=aFZ2I50jYAesUIpCE0YnM6ysG0cqkfj3S+ZzPk5/ZX8ZcunUIO+X75FxllPeb3lKXNBoRl
	SPc3KwGoc1mC8LWVs1laDQRLOgOeRcSXu8NW2gNHyVyllZKGHYrey+Ar2MYYWpFSBhrFAG
	75ygaCvDflLYLoqy9+BhJuV7ZkV+Fpg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-H_WDuw-AP52LHjGPq6IiIg-1; Thu, 27 Jul 2023 13:19:18 -0400
X-MC-Unique: H_WDuw-AP52LHjGPq6IiIg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3172a94b274so621605f8f.0
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 10:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478357; x=1691083157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4CQl/KqIX11L3TiHMHd5HwEW/uogwdH+taMU4z+h54=;
        b=cKVVOlsLi4M9EqV7Osrbn3tKUAc1o1Az7P0bqoPqTMw5ruwuYtlj7I+UvaA+0T8eBZ
         DEOjdc3zEsxPZH5ejSd7IAHi2zAxC6x52xbUO5mcjy5N0JMIerYP97Kkgev3E+Q2kvHj
         ZtInFvZzSxuLcDDvDmSXfgF6boE2rjxV/W/nLNpx68AVzGJC5YsA89o2wXXZDsAk8dY3
         GtBhkJYktdXAUDdrakVlYrGPIsmpWt5lFhJxXDd85WzjyWKFOyHMAMuwLHnkPH73lrou
         UPnFaWO2FdiN2Or2LWlDqEJWOmq8wmy8rJyiPC6S3rr1hfr+GMXR4y2LdXWFAZSQVxQH
         2Gzg==
X-Gm-Message-State: ABy/qLarhMS7QJh5HtMAeKDr3GhRRerEY0IGbj1ZL6iXn7I9Wiv2wLIN
	ZS9nko7NowSLg0v5DmN7v8gl8xF5TcvoZ8FNuqJfAK0CS9DuY2YDWlikYbgbGJgeh2t/nadP7rj
	CyvW9LW/AeFGBd0ygLddkU8k=
X-Received: by 2002:a5d:4590:0:b0:317:70da:abdd with SMTP id p16-20020a5d4590000000b0031770daabddmr2072120wrq.59.1690478357019;
        Thu, 27 Jul 2023 10:19:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGoT7qAT9M9AzVe6gM4vGC9A61TQxa3KwU4qcp/0CErqppoElBpEQIYPaE43upX9qaD41HyDA==
X-Received: by 2002:a5d:4590:0:b0:317:70da:abdd with SMTP id p16-20020a5d4590000000b0031770daabddmr2072109wrq.59.1690478356710;
        Thu, 27 Jul 2023 10:19:16 -0700 (PDT)
Received: from localhost ([37.161.196.240])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4c83000000b002c70ce264bfsm2573206wrs.76.2023.07.27.10.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:19:16 -0700 (PDT)
Date: Thu, 27 Jul 2023 19:19:12 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: fix 'implicit
 EP' test
Message-ID: <ZMKnEBHS/h11+v2G@renaissance-vector>
References: <cover.1690454072.git.aclaudi@redhat.com>
 <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
 <2f4e7845-1817-e34f-80cb-fef9c57a7b72@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2f4e7845-1817-e34f-80cb-fef9c57a7b72@tessares.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2023 at 06:52:50PM +0200, Matthieu Baerts wrote:
> Hi Andrea,
> 
> On 27/07/2023 13:08, Andrea Claudi wrote:
> > mptcp_join 'implicit EP' test currently fails when using ip mptcp:
> > 
> > $ ./mptcp_join.sh -iI
> > <snip>
> > 001 implicit EP    creation[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
> > Error: too many addresses or duplicate one: -22.
> >                    ID change is prevented[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
> >                    modif is allowed[fail] expected '10.0.2.2 10.0.2.2 id 1 signal' found '10.0.2.2 id 1 signal '
> > 
> > This happens because of two reasons:
> > - iproute v6.3.0 does not support the implicit flag, fixed with
> >   iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
> >   flag")
> > - pm_nl_check_endpoint wrongly expects the ip address to be repeated two
> >   times in iproute output, and does not account for a final whitespace
> >   in it.
> > 
> > This fixes the issue trimming the whitespace in the output string and
> > removing the double address in the expected string.
> > 
> > Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
> 
> I guess it is not the right one to use, you might want to keep the one
> you had in v1:
> 
> Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
> 
> No?

Yes, the one in v1 is the correct one. I somehow mixed it up amending
the patch, sorry for that.

> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

