Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440B2C80
	for <mptcp@lists.linux.dev>; Tue,  7 Dec 2021 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638873048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1z1/s1S2rkMVQdU31GT+z6dabUmEymAHyMcVcsYpejE=;
	b=iB9whAQp57RkHNzsI9fc1q9PszJ0DXAxJgdhcpraDz5ZlI5rRZeV7LUGKr3atiziM5eQQH
	wc/OCH0QQEsXZdd3RvBVgNpb23XcCaUVTOaby7V7I9ymzhO709t+/DB5pejZuDZcfFmnwP
	tDyTEPC7OIG3asd69GKbAAs+VoPFH2c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-F6eB9Od1NOSXSrgFVhgVQA-1; Tue, 07 Dec 2021 05:30:47 -0500
X-MC-Unique: F6eB9Od1NOSXSrgFVhgVQA-1
Received: by mail-qv1-f70.google.com with SMTP id fw10-20020a056214238a00b003c05d328ad2so16764312qvb.2
        for <mptcp@lists.linux.dev>; Tue, 07 Dec 2021 02:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1z1/s1S2rkMVQdU31GT+z6dabUmEymAHyMcVcsYpejE=;
        b=3CjJ9WSg0bNZSOUzkCRKzDZlfu9JQEqQQUVfMdyC1I1d73GgV1fVGMtmJUvJAezuf+
         jX/kpN2875ttpo92zrCNKaZH/XyJYdAEyNqau7tJS2w+YU0+xGLpOLRaaQFSU1qtVh3C
         gBMOb/j2aGAQGP/STKd9jtxcS6c1bciiVBUp1hSC3K69kD2xsrfVNcYOdKvwkq/Qc4D4
         jrmuOZTTEaI52E1wSoHl2Ny82Z500RXAB8N435ssbWJZr2axxaCobi0+zADghwbP0HUB
         EUzIfNUKjXJSssUyCFT9hwWcPbbBlL4uSxQUhYVfMyyYOQ6F8nHW8ccPaWmi8JUh3sZa
         O6Kg==
X-Gm-Message-State: AOAM5329a4BH0rLdexUewE+61P61UUxi0RjpjDcMV901XK24p+mwGTIp
	uN5N2Qr2YUZUBs0rYrYyKCqxYLhbBm5xJjDdxNAfBLu3RkgAwdoECCy2ZjTTuP0syyZ+UxzGn8j
	iGL/ydGq/sv/Hc7c=
X-Received: by 2002:a05:620a:2949:: with SMTP id n9mr38787249qkp.39.1638873046698;
        Tue, 07 Dec 2021 02:30:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweZ2kvC/4SRcW1oBF7R77m7KCqJz3I1u7tzvbxT+CkE4M0FkYO6CKgsEAUGn4KbraaxTHPpQ==
X-Received: by 2002:a05:620a:2949:: with SMTP id n9mr38787223qkp.39.1638873046459;
        Tue, 07 Dec 2021 02:30:46 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id w19sm7559752qkw.49.2021.12.07.02.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 02:30:46 -0800 (PST)
Message-ID: <fac880302f38aa66a5e593c03dc3e06b329c33e9.camel@redhat.com>
Subject: Re: [PATCH net-next 03/10] mptcp: add SIOCINQ, OUTQ and OUTQNSD
 ioctls
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
	davem@davemloft.net, matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Date: Tue, 07 Dec 2021 11:30:42 +0100
In-Reply-To: <20211206171648.4608911f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211203223541.69364-1-mathew.j.martineau@linux.intel.com>
	 <20211203223541.69364-4-mathew.j.martineau@linux.intel.com>
	 <20211206171648.4608911f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

Hello,

On Mon, 2021-12-06 at 17:16 -0800, Jakub Kicinski wrote:
> On Fri,  3 Dec 2021 14:35:34 -0800 Mat Martineau wrote:
> > +		if (sk->sk_state == TCP_LISTEN)
> > +			return -EINVAL;
> > +
> > +		lock_sock(sk);
> > +		__mptcp_move_skbs(msk);
> > +		answ = mptcp_inq_hint(sk);
> > +		release_sock(sk);
> 
> The raciness is not harmful here?

Thank you for the careful review!

AFAICS the race between the socket state test and the receive queue
lenght estimate is not harmful: if a socket is concurrently
disconnected and moved to a listen status, mptcp_inq_hint() will return
0, as plain TCP would do in the same scenario - all the fields accessed
by __mptcp_move_skbs() and mptcp_inq_hint() will be in a consistant
status (modulo unknown bugs).

Cheers,

Paolo

