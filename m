Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793187414;
	b=spAQea7EmzsvDU1qThAMh9CEGAX29aycNWtSE1pNu94lCalb3m/P+InjEZmwpE6owvRb
	 a0wVGeHfy4zYktCN9g/v+gWJrC3oItpBwA8/I0xDONdPUGZO22AhZzzTNJv4vzV7SpO3d
	 aRPeGSz0TaaSqbSH/S5sYakwBfDS9Ub8l/DjOtLgYS6OfFqVGy/RTtUSaAU+H2gR/BlNV
	 3RpDBY7boydNDgDLKgD66YKZe6REgZm9pKi2OCEPp/UKQjFXIRAPbyh1QLQhqqeXPXgrV
	 HEMkWp9VnqvB5ZDuhuL2CS1jkwu1l/+dgboKunDfxn38VsI6MtvbuY+irAkMs+M1Htg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793187414;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=PEn3mXfOBdTWvNy3x5kjgFqQqkfV3SgQ6N2uJyxGL+4=;
	b=MCiSUtdDmMbaD1NN9IyrcYlNqD0kPzY2Bjn8uKQ8o5UbqcSS578NJM6PfWLXk9Q/Mds6
	 tf4HonM0gOIaId5eqRsNNmyH8+E4oC2iRtZsabtAIjRQ0G6URDVwHqmDSAz0aONcDO5g0
	 8j1XFBYAC1xkIQ5AeHuFKgyKwejYyHspOF1C6d7fghFnodo2ixwRqGyzkrXK7q/yGGQ3u
	 26zNtH0holaBC2reXbhqnXhEqHkBEW4hxN/Lw1z16DdZrQYlVTVanXFkEujW8FaSPyEBE
	 /uPEAx8AyQHIYB0ApirvcDg1QQl3df3V/wQKSJXktoobH4lCQxUgu3RiuWbuL5NJR9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0B606A320
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 11:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F0B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793187410; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fzsIXqPGvAzIr4CdYyAqe5ZIBz4Rx2m6KC0sYPn4ZcfpYC3O7f4kbcoTYjYW60af1a4VVF1RtfpzDWtwiTR2w0Iiha4uz9RzAVadPbGh/zXR5IhOYoalfXqvZ5apBTuy3fqC5/iYcNEoavE3dtR2p1XdzV8rmYP6t1AnP+PV18o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793187410; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PEn3mXfOBdTWvNy3x5kjgFqQqkfV3SgQ6N2uJyxGL+4=; 
	b=Te7utkrRCIyvMbd2wvtFqcgXThFjkRwjU6OLxN6thwt8i5U2jmgM2/VXR/uGaqYrm0eZh9kBUXOAnRnurtoc3KYI7fQFLkrnN32l+gt/zmbd42Ag0x47JHxH0otcPIsDekGs/7tkKD8eaXiPjbNuneBF4klKuTAz9Vpa5+1gBvw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793187410;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PEn3mXfOBdTWvNy3x5kjgFqQqkfV3SgQ6N2uJyxGL+4=;
	b=jmGx72J7yjpeAyh1vT+aRRFlKWZQto9iinQkRsxb3EYQkpr7N+Pt6CndKLqp1l0Z
	N9LLL7IU6DVIiA8nuQVP07AP4x983CfUCERf6ReEsu29uxQmd8tis9GgyrvKPNyhDj6
	boRPYUnONSJdWjxHV4RYSmWjkzy0GY5CC3nxx0A8=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1793187407966830.357886102752; Wed, 28 Oct 2026 04:36:47 -0700 (PDT)
Date: Wed, 28 Oct 2026 17:06:47 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "mptcp" <mptcp@lists.linux.dev>, "martineau" <martineau@kernel.org>,
	"pabeni" <pabeni@redhat.com>
Message-ID: <1a1824c684e.5162c190631040.22982735015436316@mpiricsoftware.com>
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

Thanks, Matt.

Understood. I'll validate the `msk`-address offset approach first, including runtime testing, before deciding on another revision.

I've applied the approach in an isolated worktree, and the modified `mptcp_diag.o` builds successfully with `W=1`. Runtime validation is still pending.

If the results confirm that the approach works correctly and avoids exposing absolute sequence numbers, I'll share the findings so we can discuss whether it is suitable as a fix and for backporting.

I'll hold off on sending another patch series until the design has been validated.

Thanks for the guidance.

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


