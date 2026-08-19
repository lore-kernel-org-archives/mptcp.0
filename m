Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB2388E46
	for <mptcp@lists.linux.dev>; Wed, 19 Aug 2026 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130286; cv=none; b=iu0SN61ITM2g1i2Nsjr5hKWiArE7wYRCoo1lzNq+21Qb5vtRtV70hZ3Dei0dB9xpuz+5+BGWoCr2TZ37F84d0MvzPpkqQhyQB4M3uSA754yQbeTgorJpnpXVqTJZ3ttZlr+upBbzm1cjlDsNcdxwQVSmFhUXRsq96gFokh1ACUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130286; c=relaxed/simple;
	bh=xMzR3tYNEN9Of3JXbeo8CUKYCIHFPiV3nvz1r7Hr+LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE20iqp+7xSiFer62+wn/R4yRFnJNlfjH73wCixrHFBr+toLhKVc+cfkb0WPvDRBw8NCZSAdft6CbK6lo/YxjRJwpnVEPnQ8AW61ZA8cjoPQP37l7XV5OwoGBg09HJOuGJ2fHEQtqR5MiWz+hdvBuSuQy6BzDiONbwN2nVuH9kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC4A468C7B; Wed, 19 Aug 2026 11:04:39 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:04:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Message-ID: <20260819090439.GB9267@lst.de>
References: <cover.1786947923.git.tanggeliang@kylinos.cn> <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 18, 2026 at 02:03:00PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch consolidates socket option settings in nvmet-tcp by utilizing
> the generic do_sock_setsockopt() helper for options including SO_LINGER,
> SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
> the need to export and use specialized helpers for each individual socket
> option.

Hmm.  I see that do_sock_setsockopt is exported, but it really should
not be.  It's really just an internal helper exposed for io_uring
and no modular code should be using it (never mind the non-GPL export).

> A key benefit of this refactoring is that it decouples the socket option
> configuration from the underlying transport protocol. This makes it
> easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
> the future, as do_sock_setsockopt() abstracts away protocol-specific
> differences without requiring per-option protocol-specific wrappers.

We really should have generic helpers in the networking code for this
and not duplicate them in driver using socket options.

