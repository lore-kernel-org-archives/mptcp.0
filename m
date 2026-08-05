Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47236402BB6
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923034; cv=pass; b=fP0cARJqrFL81EEArpVo7Q1XCyQubrFGWUONCJzJdczAfLLWiyPRes+f9uZ3fIOk/sDVjVSsQF8MMRi1KEz0fFB1xsrc6rVFD+fR3O1wdh1HusundbNV3xPLHeE+CcqnvBM/T60mpqMYwtRvb+qMu+xAWvwN2y6hlHQQ8lzCTyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923034; c=relaxed/simple;
	bh=STitv/tBcSaakrr88DRaiFaBUyIXtpXDE8vYMNbmk94=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dH5vHMt97rFasUTz0zC+dGOWgu0GPxFwkm+sUfm/vU/mntv64TYMPLjsYHZBFakUMcWzIb6H8ZPM6+AYUqL61KAIOlQwyoNqSaxb473frBj/k+RjDqIA+eo5S/rrQsDSgbdA9FIe4dCgj9wMjGwINC6AEDgOpaLP+UkUHfqVoUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=HvHezHPz reason="key not found in DNS"; arc=pass smtp.client-ip=165.173.180.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="HvHezHPz"
ARC-Seal: i=1; a=rsa-sha256; t=1785923027; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KxS/dVEbUwTzIOt3rYTpLNO9cYE2x+J9dxIe3PyKpJWn/AhPTdCXMivJDfmord4t48yDcSZ2KbETTQPrKTKcu0k5uWCOB7mL3dVRFQkXR2rPYL6nwvNSZWGsP1nLF8672NiAzEKwG/bz101xVrX3nOvsZa+NJZct8G9aCzmAhfE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785923027; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Lz+E8AYI8iTqdKMFmruKrOEl8SMmngleshesTDE8fNg=; 
	b=bmGY7xl8VdE+B/GZpi7bC6WLuCnnRiOQ9eSl27KOpk6zkSZ0sOjPYUh6zMyKQjelKwwA2+88pVPEiO79mnNzFWLMgUHIv8MIZ2e9TgjkSv02GAxYlFE1EsoZO+6SORWvAkKyOdMivDN+vLP6nGBXUQ0YaenfuqAgBkMQ6dj6uHw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785923027;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Lz+E8AYI8iTqdKMFmruKrOEl8SMmngleshesTDE8fNg=;
	b=HvHezHPzkuHTkq+aunDjvXaF3JNgvnzCY2UcbMDOqUr0f2vzTeEoA+j0z2mrXa6M
	Q2ZWb5oQnFoAO+S1aEW+a7e7JHH2SnTOQufdURDCfuVQcpehZnvUUycBIdoAgQGjsYD
	2PxpLE1cTxDoKM0q7KhzPNnv36XFudAMNhGu4ysM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17859230266481006.0471682558035; Wed, 5 Aug 2026 02:43:46 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785923024536131.07759130936756; Wed, 5 Aug 2026 02:43:44 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:13:44 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>,
	"Li Xiasong" <lixiasong1@huawei.com>
Message-ID: <19fd14eb687.3433ccaa333376.3594246141408850908@mpiricsoftware.com>
In-Reply-To: <178592200238.584022.14857128963976903477.b4-review@b4>
References: <20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com> <178592200238.584022.14857128963976903477.b4-review@b4>
Subject: Re: [PATCH mptcp-next v4] mptcp: honour configured min/max RTO in
 retransmit paths
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Thank you for the review!

> I guess we can remove these two lines because it was about fixes related
> to the route checks that are no longer used, and this might be confusing
> for others, right?

Yes, please drop both lines when applying.

> Also, usually there is no Reported-by tags when addressing review
> comments: (...)

Understood, I will make sure to follow this next time.

And thanks again to Li for the reviews on the earlier versions.

Cheers,
Kalpan Jani


From: Matthieu Baerts (NGI0) <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: <mptcp@lists.linux.dev>, <matttbe@kernel.org>, <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, "Li Xiasong"<lixiasong1@huawei.com>
Date: Wed, 05 Aug 2026 14:56:42 +0530
Subject: Re: [PATCH mptcp-next v4] mptcp: honour configured min/max RTO in retransmit paths

 > Hi Kalpan,
 > 
 > > The MPTCP-level retransmit timers (DATA_FIN retransmissions and the
 > > fallback timeout) used the hard-coded TCP_RTO_MIN / TCP_RTO_MAX
 > > constants, ignoring the tcp_rto_min_us and tcp_rto_max_ms sysctls.
 > >
 > > Make them follow the sysctls instead: seed icsk_rto_min / icsk_rto_max
 > > on the MPTCP socket from the per-netns sysctls in __mptcp_init_sock()
 > > -- the msk does not go through tcp_init_sock(), so these fields would
 > > otherwise stay zero -- and read them directly where the constants were
 > > used:
 > >
 > > - mptcp_set_datafin_timeout(): both the backoff cap computation and
 > >   the resulting timer_ival. The two sysctls are validated
 > >   independently, so rto_min > rto_max is a valid configuration; keep
 > >   a max_t() guard so ilog2() is never called with 0.
 > >
 > > - __mptcp_set_timeout(): the fallback when no subflow timeout is
 > >   available.
 > >
 > > The icsk fields are read directly instead of using the
 > > tcp_rto_min()/tcp_rto_max() helpers: the MPTCP socket does not perform
 > > routing lookups in these paths, so the rto_min route metric checked by
 > > tcp_rto_min() can never apply here. The TCP_RTO_MIN_US /
 > > TCP_RTO_MAX_MS socket options are not supported by MPTCP setsockopt()
 > > either; this can be revisited if they get supported on MPTCP sockets.
 > >
 > > The remaining uses of TCP_RTO_MAX in net/mptcp/ctrl.c (default
 > > add_addr_timeout) and net/mptcp/subflow.c (MP_FAIL timeout) are
 > > intentionally left unchanged: they use the constant as a default
 > > duration, not as an RTO bound on a retransmit timer.
 > >
 > > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/618
 > > Reported-by: Li Xiasong <lixiasong1@huawei.com>
 > > Closes: https://lore.kernel.org/all/95552642-7b60-410b-9953-70e0b31a90e1@huawei.com/
 > 
 > I guess we can remove these two lines because it was about fixes related
 > to the route checks that are no longer used, and this might be confusing
 > for others, right?
 > 
 > If yes, no need to send a new version, I can remove them when applying
 > the patch. The rest looks good to me:
 > 
 > Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 > 
 > Also, usually there is no Reported-by tags when addressing review
 > comments: you can either use 'Suggested-by' when the whole idea was
 > given by someone else, mention a person in the commit message if a part
 > of the idea is coming from someone else, or only in the changelog.
 > 
 > BTW, thank you, Li, for the previous review!
 > 
 > -- 
 > Matthieu Baerts (NGI0) <matttbe@kernel.org>
 > 


