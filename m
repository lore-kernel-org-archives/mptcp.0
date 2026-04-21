Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C729430
	for <mptcp@lists.linux.dev>; Tue, 21 Apr 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767092; cv=pass; b=ZEJKLwGF1rcpVI+dtslaFAW3y5xmXLe2MbCAnv4tzaFPsjJqlPUtaJPiaC1qjBTrbnRlj2sVyLg5AF4KhUMGc2yTbdNZ5TYcFbfGNxzVZkJJxU5ECGBquzlW99MwqcJ+c7zEL4s3arrc0omq36xYpUsx1IAhxMT0/S/Qkc9D6S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767092; c=relaxed/simple;
	bh=KaGTlPZXiPTlJ0f3MdwaHLZAa92QuIJ1/2j5TTnV4do=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JC7zEY3wQXYF1xSsEaUNuy7bq14LfgoLugynAVKl+etsu2GgeXI/uvOvzQqaeqefLvfFyYABZKgEJL7D4R71kvADwo1A6dUBwokKiSP+3mIXPRwQ04N6r8L1yBaFRb/u4qsSMugjb4bV5PxuWP7ue46RMQ3psyaALGxhcyhVwbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=gwz+hbh7; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="gwz+hbh7"
ARC-Seal: i=1; a=rsa-sha256; t=1776767064; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TGIOuWJv/Ckvq6riNOhm3BDnSx268RiJIdLq8jNZgAO8lx4aPWWHSRNJqFby/AD8j0WTZD2jqkq14itu9GmX7iNqXkiBHAev1gMXbZw/5YnVVds7JauQdjo4DKpIc4RjoejVhqLbLT4H4FfgcHCTa1Wsc1NCg54sxS1L3I7atxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776767064; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KaGTlPZXiPTlJ0f3MdwaHLZAa92QuIJ1/2j5TTnV4do=; 
	b=YxUPvPSdFLqeY0IvdD/ARrr//eB2nuvuRe/q3JWPtP//6/BPf7wzQM/aLrh9WFPPa5AhpBhsY26fXY+rR5L94gl0siAuRdZ7VwGdEsJnK4cf0k9JI4QQzHX4VoeYoAfLos9qYVj23VW1CCpbapMBukSxPpWUQeyfjXE4z4QdvB4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776767064;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=KaGTlPZXiPTlJ0f3MdwaHLZAa92QuIJ1/2j5TTnV4do=;
	b=gwz+hbh7cL0SvKKTF2fxffes6u1HTNbtInTdKYtidXXrjxUowxIGaqzkK94+YLkz
	OQq8YfvTS1pYklOGu7vqfLK7fBs+vVMFkdHjOhKMQjGltFTaxS+042LQL+WEPR8BLk4
	Vh5Nc8FTDA0clwygoP7k+YN6hxSwo0DM9GJjJZbA=
Received: by mx.zohomail.com with SMTPS id 1776767061654640.3401165179158;
	Tue, 21 Apr 2026 03:24:21 -0700 (PDT)
Message-ID: <4d2d7d0e9fcaf6a3039555e4870ee23d59dd3b3d.camel@mpiricsoftware.com>
Subject: Re: [PATCH] mptcp: add per-reason MIB counters for MPTCP_RST_EMPTCP
 resets
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Matthieu Baerts <matttbe@kernel.org>, martineau@kernel.org
Cc: geliang@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, janak@mpiric.us,
 kalpan.jani@mpiricsoftware.com
Date: Tue, 21 Apr 2026 15:54:14 +0530
In-Reply-To: <3dbda2d2-c7e5-4a12-90c0-d1f98e3d89ee@kernel.org>
References: <20260421095646.3741956-1-shardul.b@mpiricsoftware.com>
	 <3dbda2d2-c7e5-4a12-90c0-d1f98e3d89ee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2026-04-21 at 12:14 +0200, Matthieu Baerts wrote:
> Hi Shardul,
>=20
>=20
> Even if the patch looks globally good, net-next is currently closed,
> and
> only bug fixes are accepted, see:
>=20
> https://docs.kernel.org/process/maintainer-netdev.html
>=20
> pw-bot: defer
>=20
> Instead, I suggest switching the discussions only on the MPTCP ML: I
> will try to review this patch and only send a reply to you and the
> MPTCP
> list, if that's OK.
>=20
> Cheers,
> Matt

Hi Matt,

Thanks for looking at this. Happy to continue on the MPTCP list.

Thanks,
Shardul
