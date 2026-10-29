Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268324;
	b=blEffJYt/vuoArL4EeM5Dz9QrH+DsDrQ+69F9KFmLvLzw0+2aS+00duAx268f7hum9dx
	 XB+qilELre5i6HxH2yUidPH3jgmhQX1/gxmpXr9b/4hx3LtwbXvgyCBhp9fSVwRC40yTl
	 18I0ugplw0vIUwZmont/c4l3ADvkIC5oZDkDDmgInzBwfYtbJrZYkSE+U87TLWLclbKis
	 DMgbh+xjaFsQvXw2yrDfo9PX9wYmUa9fa+qiIndGxuk7n5rr67aQr2BaPz3aEBj4UypDT
	 jNNSbBF2yigZLa4ZUn6qCWsAaMKTLevvJG2AoBqotDl0Ydoe8NSIsBb+N9ppboJuIvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268324;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=BH/H0o5al5ezBvc8+n0iVl/pPGmIOvEhWgA8GFzLy68=;
	b=DYIYF37b+oIZqu8fZn+tkT+5SzSw7BktoVroWXoDgrHakswXuFYIvjTkOqTxPH4Ikj0W
	 6FQ06ZSwDuztXWMkGBc77K9D+cT1Fyf9be9AUX6cXRgWT6sTQ1YGzLNvaAUByS4v82sYy
	 1tRNDtuXK/vraKIMC9h9Ew4qGHV3APvEPSi3ZU5Vs/rC+BScrQs8WWtjs9pPEg1r50N7E
	 O+MHxQ3KShp78Ofbs6p7/QHDSZ/yytxObA8B5NfFX+0umc9Y1nOEofAd1enWsf/V3Cxt1
	 GUHi6L5Kp5XdjUuXLFqkSHYMsfgeC9SEkwd1vWcXoYXzdhnqRS17CGnq6XqRRncXEbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F0606A31D
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 10:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 549F0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793268319; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LCScPU1I+nNqILwJC72MkjzKY2P6FR0sTNSSEVyFkFk3XBw8Vrkf4Kpok9QwyjEHlT+xMP/rBYTOngPG2F8JmkjGfkN78bHyftNd3YH+YF9FopdgWnxQUqK4sS/2AmAXkaJRQV9A7f0YW2ea/iBIArlCkaRq6UM7/FWyW+2bU20=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793268319; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BH/H0o5al5ezBvc8+n0iVl/pPGmIOvEhWgA8GFzLy68=; 
	b=kTEZc06LnvUhyyobYjHgj3V1bNAZS+5w+xcveAIfbTv+Qpx6CHrqvpnKXxE5ttD/Bh0zlktAZDYY21uaIhD4MFx2oSYVH0ERUG7PUbxElCZfna0PMrWnlsMQgnOrcer6tuUd3OUYqbwTf1exOJaZcOcOlwhHcVb2yWp998zNWRg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=aw/RsVoaTogRMgnOl6A/RSpC9Y794UYM4ZO7R+kerWzdg5edPgLxwwhYo22GRWbyCYGVnL6XDlVV8qpGW1vmrx41sMPQzq79SuaPRqpiN7qPese2TDMIIunqXuewC1njbQBfdIqGATX3PahrAEptcl6SZ9KtkrK8e7SZJJM73J4=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=BH/H0o5al5ezBvc8+n0iVl/pPGmIOvEhWgA8GFzLy68=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1793268316232593.6153361950591; Thu, 29 Oct 2026 03:05:16 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:35:16 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>,
	"Mpiric Private Limited" <janak@mpiric.us>,
	"Shardul B" <shardul.b@mpiricsoftware.com>,
	"Kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1871ef80b.413e22cb735353.2237627450065761496@mpiricsoftware.com>
In-Reply-To: <199b6eb5-0705-4c65-a6c2-402484e204c2@kernel.org>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com> <20261027095410.3675317-1-kalpan.jani@mpiricsoftware.com> <ad0f8a94-09b8-46d4-b807-94f1f52f1d1d@kernel.org> <1a17d565bd7.51ae4f93484769.4801857719496061627@mpiricsoftware.com> <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org> <495a89c5-40ca-4758-8366-6c4c28e28112@kernel.org> <1a18212dbaf.7594e0f1624805.5831653841901931656@mpiricsoftware.com> <199b6eb5-0705-4c65-a6c2-402484e204c2@kernel.org>
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in
 mptcp_info
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Matt,

Following up on the V11 patch, I've proceeded with the runtime validation of the submitted approach.

Could V11 be considered a candidate fix for this issue, subject to your review? If you think the current approach is suitable, I'd be happy to proceed with the next steps.

Thanks for your guidance.

Cheers,  
Kalpan Jani

From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "mptcp"<mptcp@lists.linux.dev>, "martineau"<martineau@kernel.org>, "pabeni"<pabeni@redhat.com>
Date: Wed, 28 Oct 2026 16:11:38 +0530
Subject: Re: [RFC net-next v10] mptcp: normalize seq numbers reported in mptcp_info

 > On 28/10/2026 11:33, Kalpan Jani wrote:> No, I haven't tried the
 > msk-address offset approach yet.
 > > 
 > > I sent RFC v11 with the alternative approach of hiding the sequence
 > > fields from users without CAP_NET_ADMIN, based on your previous
 > > message. I did not mean to imply that the pointer-offset approach had
 > > been tried and found not to work.
 > > 
 > > The two patches applied and built successfully against my local mptcp/
 > > net-next tree, and both passed checkpatch. However, I haven't done a
 > > runtime test of the access restriction or tested the pointer-offset
 > > approach.
 > 
 > Always better to have a runtime validation, especially here where you
 > Cc'ed netdev and the net maintainers ;)
 > (BTW, I think we can wait to settle on a working design before involving
 > them.)
 > 
 > > I'll look into the pointer-offset option before deciding whether
 > > another revision is needed. Since v11 has already been sent, I'll
 > > wait for your feedback before posting any further changes.
 > 
 > If this approach works, we could eventually consider that as a fix and
 > backport that.
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


