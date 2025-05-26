Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229C72615
	for <mptcp@lists.linux.dev>; Mon, 26 May 2025 05:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748237628; cv=none; b=d+Z4wZ1OMln9dAFjdrx32sssnpCkZ6GR85x4aTcL1jkcVieMaoGxOYe15oeWEOWJzFfVjN4863iDLxLzupYGCc5nrNRA1uZYWhreiDVINu6YUPD8qGcSzsiLQUHKNLY3QF9C6fj+TIPwWrYUhkXYDYWj2EA/QEK/WqmvNqD6vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748237628; c=relaxed/simple;
	bh=6KjRGakdHLvTPtXjxEJatZfcW4FuqXdDm78T3RH7W1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1m6xkP01yWH0vFQylYtPmFa0cwSH2Mc61ZJx09TTyIAg9JM8J2PJVlU3mtfzM1Sr3kiqeYsMf6qIm0k/u2D36H2TCvSpSd1qNKGgd+qo1lfSNBOX2uFcRCzNa2U00voyx3lTO79E5TlOrvfi4/ImERvWHCH/9e/icuOZn0AXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C070F68D0D; Mon, 26 May 2025 07:33:43 +0200 (CEST)
Date: Mon, 26 May 2025 07:33:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create()
 calls with sock_create_kern().
Message-ID: <20250526053343.GF11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-7-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 23, 2025 at 11:21:12AM -0700, Kuniyuki Iwashima wrote:
> Except for only one user, sctp_do_peeloff(), all sockets created
> by drivers and fs are not tied to userspace processes nor exposed
> via file descriptors.
> 
> Let's use sock_create_kern() for such in-kernel use cases as CIFS
> client and NFS.

Same thing, one patch per subsystem please.
