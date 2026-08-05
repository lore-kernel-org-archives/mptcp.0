Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A53AAF6F
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924317; cv=pass; b=FxZZGzDV1E9xzILULLg97Sck8wIszxHhgkySu749KgzUON8Y8FlvSB6tn2kwFKNEjG0KYvPtELcKhagf/c8gXwzxNLiIeuMgA5muMQ3hDAE1oK71HK4o4oMImVePPWmjMMtvOLNk1RM+6ZxPXlmpd23JnzNBcZJmv0tAEgz2sGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924317; c=relaxed/simple;
	bh=dEACHTqYfvbpwYwVctFqZmRXD41aMW7gOxrMy14WgY0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=LZwAErvPCv7SMP/srV4mR7c9qAg4/yQYlTAagc+QztyQd2Qze1J0/IYGQxAUFWXEnOU/Fxq/iGJduCmI8g5iZcyrux3mJom++uEml90M5q9Tem8H0Qa7vGP/hgZ/oY2ODTuhTSf1VFDLGGNrjFAfDdnPOsVsi7l1/N1dksPgqak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=Ba0CdD2P reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="Ba0CdD2P"
ARC-Seal: i=1; a=rsa-sha256; t=1785924313; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=clnuYYwlUHC9l53UU+mtxy096D8p2mHNkEwljc/bIKUqpEgjlBYaAfwSlUs3rWx+F7hXCpoPGHg4BmVBS2rG7q3FU9iHSiRTa7YvJxtnWk2FPKzff0jjVBSCaCsKoKAokBbgzkF2ddw0yilUa2Qx47zHki2Ed8iu8ywJ72HqF6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785924313; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=h1b0j2hc0RwFcc2A2oAH/LtZkq4FLleWrG36bCIL+m4=; 
	b=QV/rIhgnroBMcSVC2kPYfqadpxl5uaikKX+ReOnRf6Mx+EsvmGnjBeCSbmUu6dkZHYSieIZPmD/zGsp+bJMAmmHSDhVIZA/LRvYBhya8VUzxxIG/inSn8snW/5MVisNpWXfjVRma8Uqn9fugh7AlxZw10Vdl7RHMEWdBd2c5OyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785924313;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=h1b0j2hc0RwFcc2A2oAH/LtZkq4FLleWrG36bCIL+m4=;
	b=Ba0CdD2PKnQSf5q3V0WZ7CdJF5RY/Tgm5eSTZ4oB4uOWfD8JyPk9YUZOLgwmPr5J
	1JbmuaLv6E7Bn3FQU5qPBOJ+3DYNKZf9FXy4I0E6wukZtgA7dRaVqRq1dQ/VANl8zDI
	W0yG99NGEXs1F2J5oGcJ9sEP1n0fkQdhXi+3WSoI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785924312961353.2796514150533; Wed, 5 Aug 2026 03:05:12 -0700 (PDT)
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1785924311188397.20257732789685; Wed, 5 Aug 2026 03:05:11 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:35:11 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <19fd1625806.7d1c8700335338.3636267130596242233@mpiricsoftware.com>
In-Reply-To: <6c00d0c3-8c93-445f-9c6e-c55401dac93f@kernel.org>
References: <20260805064739.3087314-1-kalpan.jani@mpiricsoftware.com> <6c00d0c3-8c93-445f-9c6e-c55401dac93f@kernel.org>
Subject: Re: [PATCH packetdrill] mptcp: dss: validate tcp_rto_max_ms on
 DATA_FIN retransmissions
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

> Do you mind opening a PR instead, please?

Sure, here it is:

https://github.com/multipath-tcp/packetdrill/pull/204

Also noted for the cc list, I will only use the MPTCP ML next time.

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>, <mptcp@lists.linux.dev>
Cc: <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>
Date: Wed, 05 Aug 2026 15:00:19 +0530
Subject: Re: [PATCH packetdrill] mptcp: dss: validate tcp_rto_max_ms on DATA_FIN retransmissions

 > Hi Kalpan,
 > 
 > (Note: no need to add Mat, Paolo and myself in cc: only the MPTCP ML is
 > enough)
 > 
 > On 05/08/2026 08:47, Kalpan Jani wrote:
 > > The kernel patch "mptcp: honour configured min/max RTO in retransmit
 > > paths" makes the MPTCP-level DATA_FIN retransmission backoff follow
 > > the tcp_rto_min_us / tcp_rto_max_ms sysctls instead of the hard-coded
 > > TCP_RTO_MIN / TCP_RTO_MAX constants.
 > > 
 > > Validate it in dss_fin_retrans_established.pkt: set tcp_rto_max_ms to
 > > its minimum (1000ms). With the default 200ms rto_min, the backoff
 > > shift is then capped at ilog2(1000 / 200) = 2, so the retransmission
 > > intervals stop doubling at 200ms << 2 = 800ms. Add two more expected
 > > DATA_FIN retransmissions at that capped interval.
 > > 
 > > Without the kernel change, the backoff keeps doubling and the 5th
 > > retransmission arrives after ~1.6s instead of ~800ms, making the test
 > > fail.
 > > 
 > > Link: https://lore.kernel.org/all/20260805063956.3052563-1-kalpan.jani@mpiricsoftware.com/
 > > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > > ---
 > > Notes:
 > > - This depends on the kernel patch linked above: the test fails on
 > >   kernels without it (5th DATA_FIN retransmission at ~1.6s instead
 > >   of ~800ms).
 > > - Validated with the mptcp-upstream-virtme-docker environment:
 > >   passes on a patched kernel (ipv4/ipv6/ipv4-mapped-v6), fails
 > >   without the patch as described.
 > Thank you, it looks good to me!
 > 
 > Do you mind opening a PR instead, please?
 > 
 > https://github.com/multipath-tcp/packetdrill/
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


