Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F13812E4;
	Thu, 20 Aug 2026 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247072; cv=none; b=Akgigc4lwh0G7XtuG7Mw2RtyAXLfEZqZB9KoQSMRRxYzX9WFKuTRTOCYQ6WMyRU7JHNii1RlafXBpgc7XlZoiwOH7I5yHPzaS4FnrKXSqu1nBzd0IQswOXKGdIGX4Cv12j5TcrXGjxVXx2pOYtRNDGT9FVm1cw+8Ml21ckdbV28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247072; c=relaxed/simple;
	bh=JqpzM9cjt83U+e0RN0TzUdzzeD+GrNLohFv5+1um19A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGUdzYboA2LX76YJ/au4WE3s96DPhV6D64Jstrb365s7LfvQhRFPWHmpxf7McQV0YwtjblS2ToRNBEhWaGUssN9DhPxdZJ9Xu8f9iJ4BlQ6HZlekP8yNEH5cqhgYTMOngjFuUZ7bYA/5owptcQ+i+GOtMDsfgK3cC/VEGHKD9fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACWaXR6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACWaXR6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2C11F00A3A;
	Thu, 20 Aug 2026 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247070;
	bh=VawSvgDX6fqaQP0qKQ8B6xmDg9CDCy/Pi7o+RV+1o7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ACWaXR6jAwHB7tv/c8Usip59at2gaF7rL8oSFt7sxp8wtbFVs2stRYjA1zJqy2p9z
	 LRNFKCOk0ZNwKI14iNCaXQIH6gK4/LqNv86PBNtdxK6UFTZiNz1EcVROWnlF4jtj6k
	 HVCiGId+moL/SN3sk7ugERolcUg5sxWGVQpxjdc3TidV65dFNAsvLWdwf/jshHQluR
	 h1TT+MQh2Xy4qp33v2xctAsqnqQNhcby0KMYhLduhtpCJdVFT/kQtJaLY3kGsX99o3
	 cvqvrQTjWMAN62bcxTrzQHc57fNPE9mrk6uNuWl/RbPdETNIhCoo9G4SirW32Z9pZk
	 08/tjNmQssbvg==
Date: Thu, 20 Aug 2026 10:31:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, Stanislav Fomichev
 <sdf@fomichev.me>, Geliang Tang <tanggeliang@kylinos.cn>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Message-ID: <20260820103109.4d8ed110@kernel.org>
In-Reply-To: <20260819090439.GB9267@lst.de>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
	<010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
	<20260819090439.GB9267@lst.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 11:04:39 +0200 Christoph Hellwig wrote:
> > A key benefit of this refactoring is that it decouples the socket option
> > configuration from the underlying transport protocol. This makes it
> > easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
> > the future, as do_sock_setsockopt() abstracts away protocol-specific
> > differences without requiring per-option protocol-specific wrappers.  
> 
> We really should have generic helpers in the networking code for this
> and not duplicate them in driver using socket options.

What do you mean by "for this" ?
