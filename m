Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4D4B04AF;
	Sat,  8 Aug 2026 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219195; cv=none; b=kVRWpyg6kYEjSJ/sFT0hwtTYsCPJZcOFBf8Ck4euwoi1bnuDrCwYd2eKtfZVkFfWojAzTkoYUbp+jTZYordZ/4yaWuXi80NWWbFXfOYc9Q3ewVMw5QgIPt/TCsP1OQxb0tKPLrhyMadTQpCleLbeQBZc9GfM639uersy4t1VLxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219195; c=relaxed/simple;
	bh=VN6GR4nt/xmjbSHDBoyOksQGCij76qdvtoMRbYiX6+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UXSkM4n7RL5H6z2u/7UA8fMT9CCsIPacu9kNJ6boHFnByoyEGuuCNAunh4nmMq1sq4b4jORPUOhaMzybaKERqaRy64GubNJFcJYF9f2JYD6qZCXdO/CuzM2NBpsY1dPqujCigVpl7ivzvvPFk97l7RUBZHbtZvEHa/0vOYUa2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNMwnnOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNMwnnOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01EA1F000E9;
	Sat,  8 Aug 2026 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786219194;
	bh=XKrWoAPilpib+yPYfjFE3Q+TPQyDryTcB/pFUP55CH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fNMwnnOVntnbcKmmCD86srsQFJ3QdNN4X1E3kLqOVb6jg/k80C6+kFZ4qJTKeqdsZ
	 tl5Rbfi0+Synrl+WQrfY9uAkA8g7fnKPECSDSCfqRKfp1EtHs3UbWgWCHL2sg/Bbep
	 IthedKvCDn8q8vkoXKMQKPLn151mqNFNytEhXnxU0wbWiciSZ91C/zS/b/vBXP7F0t
	 fL3Ok34RHUGZFGges0qGrLJtVV7YjlrADsj5zofadRQ2hHoD1wDMgUQhWY+IrtHA4S
	 cKhpm4EO6DFXOxGq8XyM6JUl6HWDM32PF8nNnpLI2JxhLy7S3BUXnTgb3qOkdrr0dP
	 KCTk1q/QfCMYw==
Date: Sat, 8 Aug 2026 12:59:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, Geliang Tang
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/3] ipv6: extract and export ip6_sock_set_tclass
 helpers
Message-ID: <20260808125953.1e8488e3@kernel.org>
In-Reply-To: <d06402e4fa9e1c879296dfb8ca5a73e34d4b13d2.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
	<d06402e4fa9e1c879296dfb8ca5a73e34d4b13d2.1786171863.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Aug 2026 14:54:59 +0800 Geliang Tang wrote:
> IPV6_TCLASS handling in do_ipv6_setsockopt() inlines the same ECN mask
> logic and inet6_sk(sk)->tclass write that callers need when propagating
> a tclass value onto a newly created socket.
> 
> Pull this into small helpers __ip6_sock_set_tclass()/ip6_sock_set_tclass()
> exported via <net/ipv6.h>, so external modules can apply IPV6_TCLASS
> without duplicating the ECN handling.
> 
> __ip6_sock_set_tclass() will be used by MPTCP's sockopt implementation
> (similar to __ip_sock_set_tos),

not part of this series

> while ip6_sock_set_tclass() will be used
> by nvme-tcp (similar to ip_sock_set_tos).

setsockopt already supports generic kernel callers, sth like:

   do_sock_setsockopt(sock, false, SOL_IPV6, IPV6_TCLASS,
  		      KERNEL_SOCKPTR(&val), sizeof(val));

? Please don't export helpers for every single sockopt.
