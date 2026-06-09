Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26254071DF;
	Tue,  9 Jun 2026 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780974176; cv=none; b=CVjKklFNx+2OR3hoVHQViRrlKx36pHsmwuKUt71Ke0/e056bA3P67X9gKK3YPsyOjm1xUK/fNcpAoI8CowMmU1pAc7qhDIqTirr5jN2dgsd73zPVY0CVLidnQjLDTo3hdPAQdLnfdqYH0SvIzJAHBNkpQT5d+czakrSONPWl9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780974176; c=relaxed/simple;
	bh=orb8iDW7a1XiL+KpKn+9g0fV1JjcByt9QNkC7Ah6yPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ID8zy0qnguuJIQKFpWtGIk1VSwO577fB+noMT+Uq35axGdlFII43TrwiYw7QzhuGHsRkE7b8v1hkgS5tujw5uKCoMkbAEe24a1DYbld07Z/JXTTOYGizq2N/iE5xMczhuIWZV38Z2C7Gafs3jIbTd932p9I2xPygEtBWyus1h/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQtfToXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQtfToXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EC61F00893;
	Tue,  9 Jun 2026 03:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780974175;
	bh=vwdje7W5sCHtZF0KIqX9/9VQxJ5gDxlcEEv39SkOOe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mQtfToXxfBHPyCz66lq/Kyar2tJxM+U5y2ZjIfaer+YaBZ4KCGaOyiKK68EEue4LA
	 3eiR8PS+Mz8qCCEnxh4kf1aiYXzEN1N7yKQjlNIVvzrHXdCOiOayad/cV9uXxNh6l6
	 UyIQVQ84neMmbZJ7hyUey873JnZTVo5fiQCx/2u1iCAQ1rYZGJmNQ/6msmT4Zbolhe
	 oz69P2zOiD4CIbS1RPpZyjjvRCvLCdp5T0tZJt9i72FvdjcMe9w/dCkEATJ1EAv8b3
	 Uf8lNAR+ic2/xKlHSPpLBsAuThmK8Lxb9uG//9K6EyFl3z9sf2/LV3tizOLx6dC9FU
	 LwwPrsHsWUFKg==
Date: Mon, 8 Jun 2026 20:02:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Atul Gupta <atul.gupta@chelsio.com>, Geliang
 Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Gang Yan <yangang@kylinos.cn>
Subject: Re: [PATCH net] tls: restore sk_prot before calling original
 destructor
Message-ID: <20260608200254.3be56aa7@kernel.org>
In-Reply-To: <aiZ9PZxNyp9jik2v@krikkit>
References: <158c0562b4969c61574633e5d22c962d50e5bc31.1780663476.git.tanggeliang@kylinos.cn>
	<aiZ9PZxNyp9jik2v@krikkit>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 10:28:45 +0200 Sabrina Dubroca wrote:
> 2026-06-05, 20:57:07 +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > When a TLS socket is offloaded to a TOE device, tls_toe_bypass() replaces  
> 
> Or maybe it's time to simply drop tls_toe? There's only one driver
> that uses it (chelsio/chtls), and it hasn't been touched by someone at
> chelsio since 2021 (2355a6773a2c [1]). Since then, there have been a
> few fixes by people who I doubt are actually using this (Eric, Dan
> Carpenter), everything else is treewide/refactoring patches.

Yup, tls_toe is unsalvageable. Sabrina, could you float a net-next
patch to nuke it?
