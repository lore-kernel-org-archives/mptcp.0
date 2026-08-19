Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFAE3A5421;
	Wed, 19 Aug 2026 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145823; cv=none; b=Si5ONclojtLnzxKauiCGTjqTQVuFXMC8k5yzin8faUj9X7m6/hmG/Sbg5We8aTUmKsHvsI1ikYdopOb4bAfoJzlD3fV/DTzFR5kWw1fMtPLqPIolULihjWew/UYAty5NviJ7M4qIcBWf5sEj1fGj7IpIqmCpMfxQB7s6qlTDsmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145823; c=relaxed/simple;
	bh=kZOXD71JU1KpdX15Nz9lGEsxLj/lhEZU2Yl2XPqq/vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsIKAeoq+x8E6E8AyNChOjzA6PUtfzl9BJfhDgVplJDQ9MwYoWMiGOqM0527QIMu//JaO78Ypn2u6foIJS7FJo//is7yc7PR3kEylFxRD4PymsuuOOd8mafNFJIpp91Db7ReYPrOwfZPp/JokkeF5q0N/pYtxYa57NpyICz7X6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=agYkyq0P; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="agYkyq0P"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kZOXD71JU1KpdX15Nz9lGEsxLj/lhEZU2Yl2XPqq/vA=; b=agYkyq0PvFJCAgahTzBwPHNLhy
	0IzBIxp5UDnOjGI6cuETCOGbMzrgX6HsM693ZWtpUBex81i6xZv91UX1GH0oeXkc365+yZBQdYKOA
	daUDB/r1U3Qvj1NSTjboICdZHaIBBQScaevJUzv5hsQ+ftV6eFGEf9MNjGmuxND/7APLm8BOhR6Wi
	VmoIrGVYOwtdk/ipZwMwz+Q5MRvcdhNDW8eC9pi5Q4UCkiYl5OzRCWfN1FGb94Eoa/wGWpa5xHPYS
	hhUYnOT+++PrzGfUcSw2duLzMB4+I4RkJZkyqc0SQf/sYpeFLN0QbhRvDWXqh5XgAEUlJYewXJdlY
	2GaaQnag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwgG4-009oy5-0p;
	Wed, 19 Aug 2026 13:23:08 +0000
Date: Wed, 19 Aug 2026 06:23:02 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Stanislav Fomichev <sdf@fomichev.me>, Geliang Tang <tanggeliang@kylinos.cn>, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Message-ID: <aoWuJGOJicyABPK_@gmail.com>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
 <20260819090439.GB9267@lst.de>
 <aoWNmG2X0aylHDFd@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoWNmG2X0aylHDFd@gmail.com>
X-Debian-User: leitao

On Wed, Aug 19, 2026 at 04:04:51AM -0700, Breno Leitao wrote:
> On Wed, Aug 19, 2026 at 11:04:39AM +0200, Christoph Hellwig wrote:
>
> Agreed. I am happy to remove the export, given it was introduced by my
> change in commit 1406245c2945 ("net/socket: Break down
> __sys_setsockopt")

Patch sent to net:

https://lore.kernel.org/all/20260819-hch_not_export-v1-1-af4b0de70e13@debian.org/
