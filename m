Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69351381C4;
	Sun, 16 Aug 2026 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786842035; cv=none; b=PAAOf/8/yAOUOp5f+y7OQeyVFmVjiG2e5u8tIKrJUP8HV+UAdtFZ0+CXLYyCKnyh4xBAu8ZExLTP13NXXW8G4Z21CMfiSPTgqsXa/K86lDXOMQz91AlcftaDYljW/hgsE2pLb+UyGD81QsJGauGHTa4zW1bJY2aHsdWqhtAF328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786842035; c=relaxed/simple;
	bh=ypzMXirwAb0w92J0pjQusLgCDNlv0D2tKTCujBQl9vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSO1oW6RWi0ESDGz3RQ7C+7hM6+jGxez7pP8777+sUdx+qjmSUc4QzUGBrTxDbdwY8Whs4YWwJwd5/gcx9aNC5M0ek7RqZbBZj9ekDW2k7+SeaRJ5g+nwJVEIgIuAnmlCtWiX/vXpPDcLR36SVY04ytAurin5bAE2YlF/szgu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8WKgyc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8WKgyc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD571F000E9;
	Sun, 16 Aug 2026 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786842034;
	bh=MY/sIL9Y1jnzsucHK8wlt+7uuZuywIJOs+Wptlau6mo=;
	h=From:To:Cc:Subject:Date;
	b=P8WKgyc+GhEdG+N8ebNW/5hE6ZmuJmANuT6mzKa/UMhd3y1jRSKc4K8v9+5Ivewxt
	 B9FqPl+MKYd4kTJtZwV31qir4dhd1UIWV4uokmYCRDFAzfE/u0u0xs09FdrJTbaOay
	 +Vwd99dERCSDve1O9rKUrhP5+8NbuCH/OypgBUp6958ac6VVOtit236Fu/XdmioYMc
	 pl3b8M9DSO7aCIjchdpv9Q/YcbyPalQ0E/u8+YbYGfbXYwi4Q+NmJUouDJC5EyXE4A
	 KEEdWGf/w4jBEs3KOtfyPpLRugHLqXRYxnNhKENYFXcMfJZFCrhE+1OMMgjV5RkN0Z
	 dgrYv2jv5kg0w==
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
Subject: [PATCH v3 0/4] nvme-tcp: add IPv6 traffic class support
Date: Sun, 16 Aug 2026 08:59:56 +0800
Message-ID: <cover.1786841319.git.tanggeliang@kylinos.cn>
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

v3:
 - add two patches to unify socket option configuration using
   do_sock_setsockopt on both host and target sides.
 - use do_sock_setsockopt for IPV6_TCLASS rather than exporting and
   calling ip6_sock_set_tclass, as suggested by Jakub.
 - reuse the existing NVMF_OPT_TOS for IPv6 sockets instead of adding
   a new NVMF_OPT_TCLASS option, as suggested by Stanislav.

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

 drivers/nvme/host/tcp.c   | 68 +++++++++++++++++++++++++++++++++------
 drivers/nvme/target/tcp.c | 68 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 119 insertions(+), 17 deletions(-)

-- 
2.53.0

