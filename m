Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CB18B0A;
	Tue, 18 Aug 2026 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033012; cv=none; b=P59IKHTTPM4OjolWXgqWoAOvqhAn/NsQqDaBPHh0tISg9Po8X7BkJtvqzlsdoxnzbi+3j67H14jm94lRJWlSRqBeDaGEAYxcg+iaHKwaq/OLoXMhgfgmlVsVIE42oAJjdH4iHnYTbFncaaH2Zk1WAwtEi1vVC4Hv/20QCwUpIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033012; c=relaxed/simple;
	bh=LB/jGAZe7ZSRBfZTUAfFvAB2LBijl6HMsUcVJPhfG/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgiPX3ksGwQJmwFhgKcYavLql3J+DaLrurJr3jZvgh5tCcDAyls8sO7LrNxTwTcKmEEqz7+ELi8aAAC2d0yiY30iWvmb4VZkLUEhBFEQ+7DlH46RO9/EC6cLlIM1N9voiCc6bLNn23DCV0WGIgRJ0wfaoS5hvZhNfcvb3neLH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c65zJeqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c65zJeqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E591F000E9;
	Tue, 18 Aug 2026 06:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787033010;
	bh=V9Szkgv2uln62JPBOa1EuVKyOTJ9UGVh4SfukLg25ME=;
	h=From:To:Cc:Subject:Date;
	b=c65zJeqhLZzEwBgVwv4bwA7V93TKpjb35hfmmLWpuz84ipg0v1C1K4tqPdN4M7004
	 z78ca1fP+OslMgHGPWsb7bBM3dL4WOpi2fc+QKx7nnDCST1mcOFm6WwL8WWYUvCOLf
	 YLe3IvPB5EpPeUsqN5TuUwpIUu2nY3FdL9jq7fcG4DBslll3uLQf7XmnbpGJl93piw
	 w+HVvYUd/S28wR9R3mBEOtmLdCa3TQwnR371QBKi8LnFWHzh2nRduV3zKFWCMZ8Fui
	 reYd3xtHPuJHVYq7v4iKX5AnIzDxma9Ua9Q+QX+kzwgwEicXN6e8ZqqdLT9bvL+hhr
	 5R7XUYvxFw/VA==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v4 0/4] nvme-tcp: add IPv6 traffic class support
Date: Tue, 18 Aug 2026 14:02:59 +0800
Message-ID: <cover.1786947923.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds IPv6 traffic class (tclass) support to the NVMe/TCP
fabrics stack, mirroring the existing IPv4 TOS configuration.

The current code path only handles IPv4: nvme-fabrics exposes a 'tos'
option, the host (nvme-tcp) applies IP_TOS to each queue socket, and
the target (nvmet-tcp) reflects the value received on the wire. This
leaves no way to control or observe the IPv6 traffic class for NVMe/TCP
connections, which is a real gap for deployments running over IPv6 that
need a non-default tclass.

The series also refactors the socket option configuration on both host
and target sides to use the generic do_sock_setsockopt() helper. This
change eliminates the need for protocol-specific helpers and decouples
the configuration from the underlying transport protocol, laying the
groundwork for future protocol extensions such as MPTCP.

The series is split into two logical parts: the do_sock_setsockopt
refactoring (patches 1-2) and the IPv6 traffic class support (patches
3-4), following the natural host/target layering.

This was tested with the selftests mptcp_nvme.sh [1] to pass "--tos"
on the host side and validate that the value is reflected on the wire
by the target.

[1]
https://patchwork.kernel.org/project/linux-nvme/cover/cover.1779934709.git.tanggeliang@kylinos.cn/

v4:
 - check return values of do_sock_setsockopt, as suggested by Sashiko.
 - change "u8 tclass" to "int tclass" in nvmet_tcp_sock_set_tclass,
   as suggested by Sashiko.
 - change "u8 tos" to "int tos" in nvmet_tcp_sock_set_tos.

v3:
 - add two patches to unify socket option configuration using
   do_sock_setsockopt on both host and target sides.
 - use do_sock_setsockopt for IPV6_TCLASS rather than exporting and
   calling ip6_sock_set_tclass, as suggested by Jakub.
 - reuse the existing NVMF_OPT_TOS for IPv6 sockets instead of adding
   a new NVMF_OPT_TCLASS option, as suggested by Stanislav.
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1786841319.git.tanggeliang@kylinos.cn/

v2:
 - Export and use the ip6_sock_set_tclass() helper in both target and host
   paths, aligning with the existing ip_sock_set_tos() usage.
 - Add CONFIG_IPV6 and AF_INET6 guards to avoid build failures when IPv6
   is disabled.
 - Use rcv_flowinfo from the target socket instead of np->tclass.
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1786171863.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/linux-nvme/cover/cover.1785122120.git.tanggeliang@kylinos.cn/

Geliang Tang (4):
  nvmet-tcp: unify sockopt with do_sock_setsockopt
  nvme-tcp: unify sockopt with do_sock_setsockopt
  nvmet-tcp: support IPv6 traffic class
  nvme-tcp: support IPv6 traffic class

 drivers/nvme/host/tcp.c   | 111 ++++++++++++++++++++++++++++++++++----
 drivers/nvme/target/tcp.c | 102 +++++++++++++++++++++++++++++++----
 2 files changed, 193 insertions(+), 20 deletions(-)

-- 
2.53.0

