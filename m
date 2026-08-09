Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0671DF248;
	Sun,  9 Aug 2026 00:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786235481; cv=none; b=TP6LZ/RYMdzCWgRoNd01oYE6pwSgZjvZA6MpyCw9/EdfqCZcXEp5NjNiHZ40r0wONrHuhEX7R5F9aea0cSDE1tXqAZW/wshrysNN6dGW0764s6z6ckXal6yqPTj/XjrVkzll/w8or52iqIt2DFz+kqZqeP69UvBUE50diCAPOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786235481; c=relaxed/simple;
	bh=j9VO9pL2Wh87Sq/Iox2bltf8YkRzoI/6sv4U0BuBxno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Enwcq2DgMKhNeaFMTCBCLaa4MpEcuiMXGIxcAf+QBRu6WAFrlJkuIxf5dsnjzPrZyj+wyBgwB77w0hc+in4sDIcNuQMIC3EhGZJFWUj1DLAMFNgNHkV//pyz8tijveO8ujpJUbwkIAwfEr2kFEhjHUYRvBckMTOIOa0hUeO8DC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCX7kmXL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCX7kmXL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4DA1F000E9;
	Sun,  9 Aug 2026 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786235480;
	bh=9kOGCyCVawuLvRZ8C4laxzSUB0WsWqsicvOU4WoPl+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GCX7kmXLoQxkDQKSmgdykjXBkLEmQQMFNiZrRBbbMLY+cyBy9sVqqu7a9xT4w7bV3
	 Gdw2wJtPHTxaoAXSZr+ea9v4bqLjQaT5SbAzvJinUcTezodzfOcM9fwfrZv6CVCeXZ
	 LKlRY2Sug4/kEiLgLdibGs8WoifD/jgqcPxKfXRzmVj+kqS1OhRuQtXRiYQzKj72+E
	 ksWe3LdAkrZAhChgOXwT/7nv/2fJb+YBSNcKRBhYl9atwJHu5yN4UYC13VKLHM6tWe
	 +T1dy8yB3woMmqNmURRVmn6Fmpi38tKeDed2LfxAyIxpXCD2hrO+S5ZXqa/MDgrjze
	 6b8+mpwpgAJuA==
Message-ID: <33e7a2b83f7de3651a3ab77732c869d15408c00f.camel@kernel.org>
Subject: Re: [PATCH v2 1/3] ipv6: extract and export ip6_sock_set_tclass
 helpers
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>,  David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,  Hannes Reinecke	 <hare@suse.de>, Geliang Tang
 <tanggeliang@kylinos.cn>, 	linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
Date: Sun, 09 Aug 2026 08:31:12 +0800
In-Reply-To: <20260808125953.1e8488e3@kernel.org>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
		<d06402e4fa9e1c879296dfb8ca5a73e34d4b13d2.1786171863.git.tanggeliang@kylinos.cn>
	 <20260808125953.1e8488e3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jakub,

On Sat, 2026-08-08 at 12:59 -0700, Jakub Kicinski wrote:
> On Sat,  8 Aug 2026 14:54:59 +0800 Geliang Tang wrote:
> > IPV6_TCLASS handling in do_ipv6_setsockopt() inlines the same ECN
> > mask
> > logic and inet6_sk(sk)->tclass write that callers need when
> > propagating
> > a tclass value onto a newly created socket.
> > 
> > Pull this into small helpers
> > __ip6_sock_set_tclass()/ip6_sock_set_tclass()
> > exported via <net/ipv6.h>, so external modules can apply
> > IPV6_TCLASS
> > without duplicating the ECN handling.
> > 
> > __ip6_sock_set_tclass() will be used by MPTCP's sockopt
> > implementation
> > (similar to __ip_sock_set_tos),
> 
> not part of this series

Exactly. The export of __ip6_sock_set_tclass() is not part of this
series, it belongs to the MPTCP series that adds IPV6_TCLASS support. I
will move this export to that series instead.

> 
> > while ip6_sock_set_tclass() will be used
> > by nvme-tcp (similar to ip_sock_set_tos).
> 
> setsockopt already supports generic kernel callers, sth like:
> 
>    do_sock_setsockopt(sock, false, SOL_IPV6, IPV6_TCLASS,
>   		      KERNEL_SOCKPTR(&val), sizeof(val));
> 
> ? Please don't export helpers for every single sockopt.

That is exactly what I planned to do in a follow-up patch - please see
my reply to [1].

The goal is to make NVMe work with both TCP and MPTCP going forward. To
achieve that, all sockopt calls in NVMe need to be switched to use
do_sock_setsockopt() instead of calling individual sockopt helpers.
This approach abstracts away the protocol differences, so NVMe no
longer needs to care whether it is dealing with TCP or MPTCP.

Even when MPTCP is not involved, switching to do_sock_setsockopt()
provides a general improvement to the code. I will include this "switch
NVMe to do_sock_setsockopt" patch in v3 of this series.

Thanks,
-Geliang

[1]https://patchwork.kernel.org/project/linux-nvme/patch/a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn/



