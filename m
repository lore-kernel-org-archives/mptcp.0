Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3917993
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668479; cv=pass; b=WWgOsQQKXFZTcoOQZVNyvpO5/Itti/vCOOL6Bs++igQXDfnSnWGAhsHRSd6ONO95FcYg1qY4p9C3SFFi5UWcX8uJOkgaoIoKa3xoVmoxx8HNrg21dsqrl7SSU0YScLESU6FiUwzsmC3H5RNrbQjjRQCij1qWKXPdoTN+Rmnq2yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668479; c=relaxed/simple;
	bh=dxEIlY29lw1utvDZaMgK5VWGZ7g/WeMVG5aasjtu0RM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJLhULmFUwXaMTYwJ2AV3EmSTbZAX1MOk07cq9tICK3lL2o3PhUqvwdISs1Pk5VLliohhuusdA3UvcQH4T7jCHyktBymzanUcJ/pfqViCArxLxxKJq2pCn/zYv7lzs74TRsEtJi4+byUmBNfPSxocrkOdeE9C+mLe1QV0z9xx1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=bHZ4b0wE reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="bHZ4b0wE"
ARC-Seal: i=1; a=rsa-sha256; t=1779668473; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2vScGBFuJJ8DgDIq3IYUEez0agy5kLc4sktPpRkeAU0AavlGIpk1TbiT6UzCXN+3uHyjziYRa6U75+1vTUcrzQGTzHJqNiztwTttToMunyPF9L5aF3doLg8uSyjFxa+MHoZn/jZ7W4fuVs5RbxNI/uWQaPOKUUIVz5joC3F1qQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779668473; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zGAdiQ1KqiJtm2TNfT6QkGRomoWT58dZEWYLDlJX6c8=; 
	b=Wppw9H5RmHpMKYIP4ad0yEgn1G6vNzHxEynITHWMhXZcXtTMvU/51jdVDbH5LjYSmu6EwcMR8ekjWa5nGLP5vYxto10x48w6F7jS5AoxjpaU0hcKj4DaDFo2y1Dl1mfE6ZumM4elcO4HsAxguk6amQTl6hAoilPP6DwzWN5E+9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779668473;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=zGAdiQ1KqiJtm2TNfT6QkGRomoWT58dZEWYLDlJX6c8=;
	b=bHZ4b0wE56Ze7sJEWbKtiQY1PbqSzNGo2hRQ8CKT5yMyQCxUrCHNGu4ytxNVrN/h
	zPJKutQAFpp3vcUh6vbGbIdOoIGIB1jhIOM2W+xEFiekbBVJp0a7SUeMGme8ziiZOr0
	iMKjcxGWQCnDQfkoIgVqnjE1uou3j15fcClIMevs=
Received: by mx.zohomail.com with SMTPS id 1779668470823619.8925236589716;
	Sun, 24 May 2026 17:21:10 -0700 (PDT)
Message-ID: <172b053fa6c2194d1a7e16d23bda0c68d226782a.camel@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net] mptcp: fix divide-by-zero in
 __mptcp_push_pending close path
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 janak@mpiric.us,  kalpan.jani@mpiricsoftware.com, shardulsb08@gmail.com
Date: Mon, 25 May 2026 05:51:04 +0530
In-Reply-To: <bc2bcc9b-65fb-4246-b25d-c9160367508f@redhat.com>
References: <20260523211800.2952905-1-shardul.b@mpiricsoftware.com>
	 <bc2bcc9b-65fb-4246-b25d-c9160367508f@redhat.com>
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

Hi Paolo,

On Sun, 2026-05-24 at 10:56 +0200, Paolo Abeni wrote:
> On 5/23/26 11:18 PM, Shardul Bankar wrote:
>=20
>=20
> Please don't add duplicated non trivial check in fast path. In fact
> the race=20
> outlined above is so thin that syzkaller has not been able to hit it
> so far.
>=20

Fair point on the fast-path cost. Calling tcp_send_mss() at the entry
of __subflow_push_pending() pays a per-iteration cost in the hot send
path that only the rare close-path race needs.  Your alternative below
keeps the cost in the slow path where it belongs; I'll move to that
shape for v2.

> Do you have a working reproducer? if so, could you please test vs the
> following?
>=20

Sorry, no reproducer yet. I'll update once I have one and have tested
your diff.  Meanwhile I'll send v2.

Thanks for the careful review.

Cheers,
Shardul
