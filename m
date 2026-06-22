Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B06836403B;
	Mon, 22 Jun 2026 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782125048; cv=none; b=GwckQjso8/leSXy2/qh4cL2w74lZGTM5OJJ3PCQXPu79SuTZfZlZuH+pSU+WxOsTXRdjn/nbWuDPOoQu9HlYxtTyZh/2SbrLT8bVUMobhC2QLuUVyENgVPajUIIGOrpdWTg0nJS3R+P6KSFjeRjEyTIHMcPfgoIK40aRoBKo2EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782125048; c=relaxed/simple;
	bh=D+oPlhaonDDGa2OtwNcSqSyAo4xU/3sqTVC3tM/HdkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgJ49MM7BxVgwNxseyIpWPPeXCSchSjGIMcTH7wfB/0HM387BOf8wno+4H6OF8/AK5xMKg+Y5nQt3mpSVLAEvHUF8Og5gy6tcAx0PCePIMk/RulgRermc5QmP0YzdAIKvAA98tWq+PXru94MKbapUJ6gjiC+TgshDrKdZdOeTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqdg7RZ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqdg7RZ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693821F000E9;
	Mon, 22 Jun 2026 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782125046;
	bh=Mc02sjeW+tycazUE5wlRYU7G9Ob+nsURSGdXlsuswho=;
	h=From:To:Cc:Subject:Date;
	b=jqdg7RZ4Yz6OnzRh3GUg02pJP5Y97tyiJaxaeP1KTeOUfxOJXoavxWJyseQ0uF0bi
	 FDbRHuSJY+KU0mi9QccBSTR2emsfyrCyVH+ebpoddkd/SiZ5Dtwkdpp3428NLxChxq
	 C8M2ZtZgq6foukxbt4g3BpZ7RHzNeVbiKFRcJT5uYt2oHTEHm5nqyL3u27mlLhGEoU
	 rzBa/+IB+lQANnzQpchGnPoEuHbeGpzWKPbpLkW8qxcFhzO/N6RpMOdprOuFwJFHba
	 vAwxDZjnWzXDVQQLvzpmG6tMX7nxIPeGiJDP2Tp8VVhCmPU7+HTZlmcFR9nZuiWAE7
	 XRjpMUoP+7CPA==
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	Zqiang <qiang.zhang@linux.dev>
Subject: [RFC net-next 00/17] MPTCP KTLS support
Date: Mon, 22 Jun 2026 18:43:20 +0800
Message-ID: <cover.1782123118.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Prior to this work, MPTCP did not support TLS. The two protocols
conflicted because both MPTCP and TLS use the ULP (Upper Layer
Protocol) infrastructure in the Linux kernel. ULP settings, including
TLS configuration, were disabled in MPTCP. If an application attempted
to set TLS for an MPTCP socket, the system would return an error code
indicating EOPNOTSUPP (Operation not supported).

This series adds KTLS support for MPTCP. Since no ULP is currently
attached to the MPTCP socket (msk), KTLS can be configured directly on
the msk rather than on individual subflows. This does not affect its
existing communication, and leverages HMAC-based authentication to
ensure subflow security.

RFC versions of this series have gone through many iterations on MPTCP
mailing list, mainly to address Sashiko's review comments. It is now mostly
stable.

A follow-up series will add MPTCP support to the TLS selftests
(tools/testing/selftests/net/tls.c). All existing TCP test cases have
already been verified to pass over MPTCP as well.

The primary validation use case for this work is NVMe over MPTCP with KTLS.
NVMe over TCP is a storage protocol that transports NVMe commands over TCP.
By combining it with MPTCP, multipath capabilities for storage traffic are 
gained. By adding KTLS, the storage traffic is secured with encryption.
Although NVMe over MPTCP is still under active development, I have already
verified that KTLS operates correctly on top of it.

All feedback is welcome.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/480

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

Gang Yan (1):
  mptcp: update mptcp_check_readable helper

Geliang Tang (16):
  tls: make tls_ctx_create and update_sk_prot static
  tls: factor out __tls_build_proto for mptcp support
  tls: add protocol dimension to tls operation cache
  mptcp: add sendmsg_locked to proto_ops
  tls: use sendmsg_locked from the underlying socket
  mptcp: implement peek_len for proto_ops
  tls: replace tcp_inq with socket peek_len
  tls: store original read_sock for non-tcp sockets
  tls: introduce tls protocol ops structure
  tls: use protocol ops via tls_context
  mptcp: implement mptcp-specific tls protocol ops
  tls: add mptcp support for sk_poll
  tls: disable device offload for mptcp sockets
  mptcp: implement ulp getsockopt for tls support
  mptcp: implement ulp setsockopt for tls support
  selftests: mptcp: connect: use espintcp for ulp test

 include/net/mptcp.h                           |  11 +
 include/net/tcp.h                             |   1 +
 include/net/tls.h                             |  19 ++
 net/ipv4/tcp.c                                |   9 +-
 net/mptcp/protocol.c                          | 180 +++++++++++++-
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  68 +++++-
 net/tls/tls.h                                 |   2 -
 net/tls/tls_device.c                          |  10 +-
 net/tls/tls_main.c                            | 227 +++++++++++++++---
 net/tls/tls_strp.c                            |  35 ++-
 net/tls/tls_sw.c                              |  10 +-
 tools/testing/selftests/net/mptcp/config      |   4 +
 .../selftests/net/mptcp/mptcp_connect.c       |   4 +-
 14 files changed, 516 insertions(+), 65 deletions(-)

-- 
2.53.0

