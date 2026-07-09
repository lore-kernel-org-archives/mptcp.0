Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA313D47D3
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783580820; cv=none; b=LngaKpKIPjj4Rt/WG1MnuspOahIU426CK3/e3nKGjorKwM4MD6qz5TauSxJQ12cf5l3YgVAf7maGNYPmVTHUmq36MMmjHm/TFe6r3GE3LHO/R2KC+CJpCfKGNaJ67Qjg10YR3OGyllaBx2EnTUNs2isT+mJxXSF01WAzH4F2Rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783580820; c=relaxed/simple;
	bh=GNyNfxxEK9j808rxbRDFIflOv2xO9Txy1vAkqXOIjEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dYOmZy0EDOfMTQrpfV+3FHUsVW/hPfwiKSH+x7QDtk6TYCxwQ5wFancpAEu8K5otGzUOfTih3/Xtn4iWJ2avBUfvr9EX1pZT4tnIoPcf/3NxZV+gRV7o3NcLFVxDbjBV5tvRQmaZTTdUnS03x2dw/995RRa2K1ryTLCj+oZ+FHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko967IRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko967IRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6451F000E9;
	Thu,  9 Jul 2026 07:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783580816;
	bh=5zJR3TXDdxIU74fXcaM8+VqrAsc5n5JJsyCO5NaF66U=;
	h=From:To:Cc:Subject:Date;
	b=ko967IRRnReEqmHE7+Ec2cunlpCfjzAEAjgk7B6OXS1CAyi41TT9D+gHxwd52SORb
	 g0gKJ8l3lzyrSGTKuHlwBqthqpghM33c5rf17f+mievyTxL9UPB307lGqgnAQCCXuI
	 hEs2E6QDL5As+EbKc/mhy9+1AiFmPHAtbNasReqeqUBoHntrJmx3huvDnuvRaqnBCd
	 dHU7dkydvBDEkb7HO7PE/SD3MrwalshbKf7fdWESaKb8HSOB2jLN3H5yf512ZKmegW
	 T8K5jy8EzkInzzI0UXGbLs3M0dkkrYsmUPBZy4kKPCtNJTrBEeVfa+p2v0UIFSwFxk
	 k0vfZ1F8+FYPg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v5 00/12] selftests: consolidate TCP_INQ testing into sockopt
Date: Thu,  9 Jul 2026 15:06:09 +0800
Message-ID: <cover.1783579976.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - Continue using the approach from v3 and fix the instability issues.
   This version has undergone extensive loop testing.
 - The new two separate functions, server_huge_transfer() and
   client_huge_transfer(), improve code structure.

v4:
 - v3 changed the behavior of process_one_client and connect_one_server,
   causing intermittent failures during loop testing. Revert to using the
   v2 approach, along with some cleanups.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1757686538.git.tanggeliang@kylinos.cn/

v3:
 - No longer using process_one_client_inq() and connect_one_server_inq()
   for switching; instead, the inq-related code has been merged into
   process_one_client() and connect_one_server().
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1756200029.git.tanggeliang@kylinos.cn/

v2:
 - patch 4, a new patch, add do_setsockopt_inq helper.
 - cleanups.
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754664106.git.tanggeliang@kylinos.cn/

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1754620968.git.tanggeliang@kylinos.cn/

This series consolidates the TCP_INQ test functionality from mptcp_inq
into mptcp_sockopt, simplifying the test suite while maintaining full
test coverage.

Geliang Tang (12):
  selftests: mptcp: sockopt: add tx/rx protocol options
  selftests: mptcp: sockopt: add TCP_INQ test option
  selftests: mptcp: sockopt: set TCP_INQ on accepted sockets
  selftests: mptcp: sockopt: use unix socket instead of pipe
  selftests: mptcp: sockopt: pass echo length over unixfd
  selftests: mptcp: sockopt: set FIONREAD ioctl
  selftests: mptcp: sockopt: add huge data transfer tests
  selftests: mptcp: sockopt: add wait_for_ack helper
  selftests: mptcp: sockopt: add get_tcp_inq helper
  selftests: mptcp: sockopt: skip MPTCP opts for TCP tests
  selftests: mptcp: sockopt: replace mptcp_inq with sockopt
  selftests: mptcp: sockopt: remove obsolete mptcp_inq

 tools/testing/selftests/net/mptcp/.gitignore  |   1 -
 tools/testing/selftests/net/mptcp/Makefile    |   1 -
 tools/testing/selftests/net/mptcp/mptcp_inq.c | 614 ------------------
 .../selftests/net/mptcp/mptcp_sockopt.c       | 297 ++++++++-
 .../selftests/net/mptcp/mptcp_sockopt.sh      |   8 +-
 5 files changed, 274 insertions(+), 647 deletions(-)
 delete mode 100644 tools/testing/selftests/net/mptcp/mptcp_inq.c

-- 
2.53.0

