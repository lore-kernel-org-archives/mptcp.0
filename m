Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F145DF47;
	Wed, 19 Aug 2026 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137530; cv=none; b=gsIgRDaIxT69p+7xUb2XAkBi0SDrrL9TvlMps8seWWjE2MlLvRrDKrVzGO3vVPOCtcdLwTlr0IGDjogGD2NazgYIppc58+ls/u3Pt0szvYKOIz0fwFm4/xhvMbwseXQQyMXIefY/MDFvPMoY3Uh+czy56Md7dm4gvWzr0Ad8fS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137530; c=relaxed/simple;
	bh=Ra4r9/Sw7plykzbCErUdiwdxtSPs35M+718+8RzV4Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7R+XJfxImCNN9AaXQUN9T9QI2J+KvXVP8DQwkpCtShVt+6CdHcne+uQaiX/iPXo8BuTksqp2GRcpT08Qd5fAX9OnaNzaqD06A7RUzIk91BQmvLY/zIEXBlx5ajR4mWEqS1TZT2U6+7w/dVkpvujJOvjmpDOrg6Zac6INWCa5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=PEQf05DS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="PEQf05DS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/lYfeP9WUbHszkMtgoDUYiluPRe4QGeEextrg7r7ra8=; b=PEQf05DSRjDo4BBdNUv0Rp6rve
	rD4sIBMLADaFrm/XAn+y8Ib+WIF7vy8SN8Qjv7MxMnO0KZa+s/ty/kxIosVZ/+Z9EJcdZrUnB6hEo
	ztQYhJQviOzks61njhVECfKSw70h7RGlWbnW08RqJhaVrcr+F/yE62napF+HbUvmk6LI3bMeK6mAu
	ynk/IzA7CXDpWOD6d3yTlV7h6eZ7QENc+tDi8l7zsoqjyE2TJJPCw+2tf/Rt3Mf70rsOaraNfkdGj
	qoBn4pML0Ce8C+caRtDp7F8eC2aeS9iZC8r1YCzneNtJn1aQRKqnBngULEUxkMMrVxoA1pWw6js4a
	srMgX6XA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwe6K-009kMp-1B;
	Wed, 19 Aug 2026 11:04:56 +0000
Date: Wed, 19 Aug 2026 04:04:51 -0700
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
Message-ID: <aoWNmG2X0aylHDFd@gmail.com>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
 <20260819090439.GB9267@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819090439.GB9267@lst.de>
X-Debian-User: leitao

On Wed, Aug 19, 2026 at 11:04:39AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2026 at 02:03:00PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch consolidates socket option settings in nvmet-tcp by utilizing
> > the generic do_sock_setsockopt() helper for options including SO_LINGER,
> > SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
> > the need to export and use specialized helpers for each individual socket
> > option.
> 
> Hmm.  I see that do_sock_setsockopt is exported, but it really should
> not be.  It's really just an internal helper exposed for io_uring
> and no modular code should be using it (never mind the non-GPL export).

Agreed. I am happy to remove the export, given it was introduced by my
change in commit 1406245c2945 ("net/socket: Break down
__sys_setsockopt")
