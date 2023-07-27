Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3582712E
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690478429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cNz/jm7eKzjrDlub8Y0LUaj1/aNGBHdE2PqDh/n0GoE=;
	b=eybiL9drFeJ7pBK0fBH1PqIFKmq5i/gB5MqXcUmnUdjWH9pQdPTzUgSe0IWX8mjhOQULhG
	pYm+xuuvfWmMiAYuwd0CKlwQFccTryCc3hKBAzF7H0pZeaXFDqPfxcgKGTOMlbBihahu0f
	R1GbITOtHQO8/mv2OGetKSKDKQPesCU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-qDQgcOxmMPCQZYE-5s_jqA-1; Thu, 27 Jul 2023 13:20:27 -0400
X-MC-Unique: qDQgcOxmMPCQZYE-5s_jqA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3fd2dec82a6so7043815e9.3
        for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 10:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478426; x=1691083226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNz/jm7eKzjrDlub8Y0LUaj1/aNGBHdE2PqDh/n0GoE=;
        b=S1UOZhmfFk5wkTRNk0CQTjqyFBNHYN/mYUzOlmQqxnxc709phoZ9Gurii7FHnP7W0I
         IwSF5v5da3Q98u6BP7DCNeMr1pPmdEvxX9orW5rAaGDpmOkcBxJjUtEiCQbuXQx/yT/6
         wyefTDqMmVd/lcmj1sp+fJqz63GkgYF7iIvfEngp8Ga8QfPQa6BCdgE+2HFUoDL79Adz
         jpyz0Hb42U69uVZv78FXgv17v543FIRVgIfYSZJj/e0zQHAuIm4kMglP6xqCF8A7Zjei
         4TEI7mN2dPrR1Qp54YSVxmQsXwm1olaWpbQUdokC9sH57q0Olt9iLgrUL037cbgo54x/
         cnJA==
X-Gm-Message-State: ABy/qLZT3ju6s/iUQqf/0JugMe6qBqWeAicJVD3iyxIis2ezGTQJD/B5
	vnT2+/tD80CwRSOrXjpxPQw3107MehiOCyJs9ivMdwYHPyVtJgyjePtDYYao5dn6PC45e3Xp0qG
	k/S6h6LqWA+CgZZg=
X-Received: by 2002:a1c:e915:0:b0:3fc:92:73d6 with SMTP id q21-20020a1ce915000000b003fc009273d6mr2224378wmc.11.1690478426645;
        Thu, 27 Jul 2023 10:20:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEtTzXWGEe776YaBIxMOtZ4EAvIlrLhslyVD1naWwNtlzjh84jsSkRErjgghaquUnL03IsHiA==
X-Received: by 2002:a1c:e915:0:b0:3fc:92:73d6 with SMTP id q21-20020a1ce915000000b003fc009273d6mr2224367wmc.11.1690478426340;
        Thu, 27 Jul 2023 10:20:26 -0700 (PDT)
Received: from localhost ([37.161.196.240])
        by smtp.gmail.com with ESMTPSA id z10-20020a1c4c0a000000b003fa74bff02asm2282401wmf.26.2023.07.27.10.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:20:25 -0700 (PDT)
Date: Thu, 27 Jul 2023 19:20:21 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>
Subject: Re: [PATCH mptcp-next v2 0/2] selftests: fix mptcp_join test
Message-ID: <ZMKnVccCXwMtvFqD@renaissance-vector>
References: <cover.1690454072.git.aclaudi@redhat.com>
 <b5364451-9cd2-6409-c829-0c34a156e6f7@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <b5364451-9cd2-6409-c829-0c34a156e6f7@tessares.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 27, 2023 at 06:52:45PM +0200, Matthieu Baerts wrote:
> Hi Andrea,
> 
> On 27/07/2023 13:08, Andrea Claudi wrote:
> > This series fixes two mptcp_join testcases when using ip mptcp:
> > - 'implicit EP' fails because of:
> >   - missing iproute support for mptcp 'implicit' flag, fixed with
> >     iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
> >     flag")
> >   - pm_nl_check_endpoint expecting two ip addresses, while only one is
> >     present in the iproute output;
> > - 'delete and re-add' fails because the endpoint delete command
> >   provide both id and ip address, while address should be provided only
> >   if id is 0.
> > 
> > Changelog:
> > 
> > v1 -> v2
> > - Clearly state test fails only when using ip mptcp, i.e.
> >   ./mptcp_join.sh -i
> > - Remove test numbers from commit messages
> > - On endpoint delete, continue to provide $addr when id is 0.
> 
> Thank you for the v2, it looks good to me!
> 
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> 
> Just one detail for patch 2/2 for the Fixes tag but I can fix that when
> applying the patches if needed and if that's OK for you.

It's OK for me. Thanks for your review, Matthieu.

Regards,
Andrea

> 
> These patches can be applied in mptcp-net (export-net branch).
> 
> Cheers,
> Matt
> -- 
> Tessares | Belgium | Hybrid Access Solutions
> www.tessares.net
> 

