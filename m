Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CC364933;
	Fri, 16 Oct 2026 04:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126313; cv=none; b=p07T6EJY8/53qr75ZD9N0pKcA0xWBFzxBB/5DQMnQJpTE1uXDT1DJgjPku/swSHGsPTeWm6hqOYaQwwdK5Z2suoJ6SwItUDkcyIgqYi/nYbJCDdYX4PHMHHYlwRoNsSSZfQrT+B50JuamZzZhsHs5zW+ItruyeJyxRgA8YO4sn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126313; c=relaxed/simple;
	bh=YdxYgV0cyICXIRBGQmu2hwnZbzsJyfTCaAgkpvzARew=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L03xHD7gVaWmrcclDpAPc1+zLofYG3MrkunRXdmfm7DySsJzgDP3Zt9W8sHZoSxyxJy07kSmWui4OcOOABsMr7TAZyuzESWG4ydF9fdEcCgKS7z9YW9xQcl3WyTQDSCYMDjj2Q2Thf+9oOENysPlvWsd5wotrux3CDfJrL0n+3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOZSFC/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOZSFC/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D89D1F000C4;
	Fri, 16 Oct 2026 04:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792126312;
	bh=mGSLHm+5r2YjDZa9OvTpQNpwlOfK9c7WttCpRckwv6g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NOZSFC/Tf2CsanFYXB5WHiRVu4KtaVvuxq1LA07PMZNZhbBMcLMo2V83DUDjKzoOU
	 13NLxyI81DDgcubxJqN0CaLIxFPl5l86co7+w23gNyji/6KrByha/A7yRgC2675F61
	 NI5Vao9uw2I9L5reRMmtt2f7Nh9fA+QzLBjlKtvBrHanYr4BrSLPuJEKnc8t3hHNtr
	 qjdJJpzP5P45TNg6eV9vnSMc0FvarasA+bZASqnZ3bbiaAl6IkzC+tcmzzFQR6Ijx1
	 wtfmApVrQVslahtWyELu/+jMRXI715MI/TV56WJiZx8s7m2VA1y3eouhUtNCFsZFJY
	 9cjC6SF3SYZmQ==
Message-ID: <6732a24185668fe8b527f7f562dc8453b85ec138.camel@kernel.org>
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
From: Geliang Tang <geliang@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Breno Leitao <leitao@debian.org>, Sagi Grimberg
 <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Chaitanya
 Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>,  "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Geliang Tang	
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Date: Fri, 16 Oct 2026 12:51:43 +0800
In-Reply-To: <20260819090439.GB9267@lst.de>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
			 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
			 <20260819090439.GB9267@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10build1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Sorry for the late reply. In another patch "mptcp: sockopt: implement
IPV6_TCLASS" [1] on the MPTCP mailing list, I implemented the
__ip6_sock_set_tclass() helper and hoped it would be upstreamed first,
but it is still pending.

Thank you all very much for your review comments, but I was caught in a
dilemma after receiving different suggestions.

On Wed, 2026-08-19 at 11:04 +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2026 at 02:03:00PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch consolidates socket option settings in nvmet-tcp by
> > utilizing
> > the generic do_sock_setsockopt() helper for options including
> > SO_LINGER,
> > SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change
> > eliminates
> > the need to export and use specialized helpers for each individual
> > socket
> > option.
> 
> Hmm.  I see that do_sock_setsockopt is exported, but it really should
> not be.  It's really just an internal helper exposed for io_uring
> and no modular code should be using it (never mind the non-GPL
> export).

You are right, my current version has several problems:

1. do_sock_setsockopt() should be exported with EXPORT_SYMBOL_GPL(),
not EXPORT_SYMBOL().

2. The "compat" parameter of do_sock_setsockopt() should be "true"
instead of "false" to skip BPF cgroup setsockopt programs, matching the
behavior of the original nvme-tcp code.

3. The helpers should return "void" instead of "int", to preserve the
original behavior in nvme-tcp where these socket options are set on a
best-effort basis.

4. Error logging (pr_err) should be inside the helpers to minimize
changes to nvme-tcp code.

5. The helpers should not be duplicated between host and target, they
should be consolidated into a shared header, e.g., nvme/common/tcp-
sockopt.h.

I wonder if we can move forward with this approach once these issues
are fixed?

> 
> > A key benefit of this refactoring is that it decouples the socket
> > option
> > configuration from the underlying transport protocol. This makes it
> > easier to extend nvmet-tcp to support other protocols, such as
> > MPTCP, in
> > the future, as do_sock_setsockopt() abstracts away protocol-
> > specific
> > differences without requiring per-option protocol-specific
> > wrappers.
> 
> We really should have generic helpers in the networking code for this
> and not duplicate them in driver using socket options.

However, I still need to use do_sock_setsockopt() for a fundamental
reason: the upcoming NVMe MPTCP support series requires protocol-
independent socket option handling.

When NVMe creates MPTCP sockets instead of TCP sockets, calling
protocol-specific helpers like tcp_sock_set_nodelay() or
ip_sock_set_tos() directly will not work correctly on MPTCP sockets.
MPTCP needs to set options not only on the MPTCP socket itself but also
synchronize them to all subflow sockets.

In the previous NVMe MPTCP support implementation [2], I exported
protocol-specific sockopt helpers separately on the TCP side and MPTCP
side, then had NVMe switch between them based on the protocol. This is
not as clean as using do_sock_setsockopt() for protocol-independent
calls.

For MPTCP, we could use sock_common_setsockopt() which always
dispatches to the protocol's .setsockopt for all options. However, for
TCP, this doesn't work correctly for SOL_SOCKET level options
(SO_LINGER, SO_PRIORITY, SO_REUSEADDR, SO_BINDTODEVICE) which should be
handled by sock_setsockopt() directly. That's why do_sock_setsockopt()
is used here - it intelligently chooses between sock_setsockopt() for
SOL_SOCKET options and sock->ops->setsockopt() for protocol-specific
options, making it work correctly for both TCP and MPTCP without
requiring nvme-tcp to know which protocol it is dealing with. This is
the key to enabling NVMe MPTCP support without adding MPTCP-specific
exports or protocol dispatch logic in nvme-tcp. A more detailed
discussion can be found in [3].

I would appreciate any further suggestions you may have.

Thanks,
-Geliang

[1]
https://patchwork.kernel.org/project/mptcp/patch/c17925172fd53c98f0ec5c0095c86e6e28cbebf4.1786938892.git.tanggeliang@kylinos.cn/
[2]
https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779934709.git.tanggeliang@kylinos.cn/
[3]
https://patchwork.kernel.org/project/linux-nvme/patch/a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn/

