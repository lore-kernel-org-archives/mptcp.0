Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7A2DECA8
	for <mptcp@lists.linux.dev>; Tue,  1 Sep 2026 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788239960; cv=pass; b=Pbn3n6quD1HnBzSBHV97EDDwngfn23c2mlxNepIPG+l/XalNWMZF2X4bT/F+88I10U/WLbBvFPPMVY+sg+tQENt2aao0GAXOGT4wqqptAPo4xLmxmVb2c4o5Tk2AWxCIRTBnMfjyduPIF/WAbl94G524N/xshar5FjnNt9cQekQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788239960; c=relaxed/simple;
	bh=qHsmng0bq63vA/HIHj/h9HZxK47/EGcIkLBG8BcCzPM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PmHIeuGrQv+UJ1GJ3vti0N1vAFLmDA9rN2gi1EyV93f0iZb2NYoeM5zQd++wQVQaOruzp98Wsf+06MzHKodHvhzcYNQKcB6aWcH0X8AQush2FR6flfy+ZaZBQvjHcD80Vz/SAQ/ANrgeg+C0++kK54dBhUCImQz0kSf0kIFHQ98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=H3k/QrLj reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="H3k/QrLj"
ARC-Seal: i=1; a=rsa-sha256; t=1788239946; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OAJ+lQ2PvkM4Nmw2hXTSATUitFKqfu1JBjCvWTCFa3nWXDcPF/s1ST5FaBQf+wp0mSK0I/Y1USWp+M5ZGTVqA0dmm2z9mLn+ieR6JwyDpCRd+M0cqcAfqPtqevYgDvO95BZsuMd3yHUMfNh65WR5bToWzEKycYHpLcVgEG/Evg0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788239946; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lXVysRehXIJzEIQmRmW4/GF4WBGfdkUE4/u0oxUrPpw=; 
	b=l2CUUNDtMC/FNR4X8Ijuhd/Ll9TZOdUTs3W0jH8tn2XUreEdRpvHx2aED7nlUbU+zWywZxBTl42/4i5pnH3wkZjyxRrLzwbBOwJaVqERlaIdL6G+B8PUSiNzpACMuoAsslVHlwi4wBjzph9n6KdtWBkXGhwmn3pTmixM6Vj94sQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788239946;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=lXVysRehXIJzEIQmRmW4/GF4WBGfdkUE4/u0oxUrPpw=;
	b=H3k/QrLjj8DXNklUtLJ5gmQqwjNPF0s/Fnelsqmli62K9qYpT2CSbmzbEq8ltx1h
	QaOLBrvQx251f6V4WS7CI1RnoM/6N3Y/IDpKJycw6rutJm8eOXzmRcslOXxDBM5nmhr
	U26fVh6WsiQo4khPW2p/F453mEuCdakLwdUSaA1c=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1788239945762826.1615361053691; Mon, 31 Aug 2026 22:19:05 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1788239943639228.3237079795225; Mon, 31 Aug 2026 22:19:03 -0700 (PDT)
Date: Tue, 01 Sep 2026 10:49:03 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a05b681764.2d9af68b190464.2524660538561791488@mpiricsoftware.com>
In-Reply-To: <f0fabe59-0a2b-4df9-983d-446eab20104c@kernel.org>
References: <20260827041058.2833707-1-kalpan.jani@mpiricsoftware.com> <f0fabe59-0a2b-4df9-983d-446eab20104c@kernel.org>
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in
 mptcp_info
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

Hey Matt,

Thanks for the suggestion. I dug into msk->first before reworking it.

Turns out it's only ever set once (either connect side or accept side) and never reassigned to a different subflow after that, so at least we don't have to worry about picking up idsn from the wrong one later.

But it does go NULL independent of whether other subflows are still around, and it's not even a rare thing. I added a debug print in __mptcp_close_ssk() and ran mptcp_join.sh, and it happens constantly with other subflows still in the list. I couldn't find anywhere that write_seq/snd_una/ack_seq get reset in that case either, so reading idsn/iasn straight off msk->first in mptcp_diag_fill_info() would need a NULL check, otherwise it'd crash pretty often during normal multi-subflow use.

Happy to add that check and go with your approach for v3, just wanted to confirm first since it looked like a common path rather than an edge case.


Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <mptcp@lists.linux.dev>
Cc: <martineau@kernel.org>, <pabeni@redhat.com>, <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>
Date: Mon, 31 Aug 2026 15:59:46 +0530
Subject: Re: [PATCH net-next v2] mptcp: normalize seq numbers reported in mptcp_info

 > Hi Kalpan,
 > 
 > On 27/08/2026 06:10, Kalpan Jani wrote:
 > > mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt report the raw
 > > 64-bit data sequence numbers, seeded from the connection's IDSN/IASN.
 > > Since the IDSN/IASN come from mptcp_crypto_key_sha(), these fields
 > > carry an effectively random offset and are not useful to userspace as
 > > absolute values: a caller has to snapshot two getsockopt(MPTCP_INFO)
 > > calls and subtract to get anything meaningful, which is exactly what
 > > tools/testing/selftests/net/mptcp/mptcp_sockopt.c already does.
 > > 
 > > mptcp_info also reports mptcpi_bytes_sent, mptcpi_bytes_received and
 > > mptcpi_bytes_acked, which give the same information as a plain byte
 > > count starting at 0. The snapshot-and-diff workaround for the seq
 > > fields is redundant once those are available.
 > 
 > Thank you for looking at this!
 > 
 > > Cache the local and remote initial sequence numbers on the
 > > mptcp_sock the same way ->token already is, and subtract them in
 > > mptcp_diag_fill_info(), so mptcpi_write_seq, mptcpi_snd_una and
 > > mptcpi_rcv_nxt also start near 0 for a freshly established
 > > connection.
 > Not to increase msk's size for these fields only used in the diag side
 > (under the msk lock I think), couldn't you get the info from the first
 > subflow instead? It should always be available (except when being
 > disconnected, but the other fields should be 0 in this case, no?)
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


