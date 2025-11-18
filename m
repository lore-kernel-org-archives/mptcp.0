Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A111FBC8E
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 04:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763438511; cv=none; b=g3nAUWZCUbYAUED5yfLJH1z+OoxCalruS9l+na4XTYgzWKr9SHGhoTn7lfkvNJ9FteXeOLFKPOfAOR0ncQvwA3I3r8IqtqBG/6MXRsZQZrRY+mZC9Hk+eKPNmwIUvP+nog7Tyj3XGkZYakJBMn2nDA+iDrNxyk1OBdPHnU37LxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763438511; c=relaxed/simple;
	bh=bw5LhJERFoqF5lT5iHUddpREUO0sQYx6j8XoLR9lDGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YgfhmEJ+oo1vuhy39UgbLLGHftOdLuReD9022oOB98R9ZNSsG9tvJoJF04zC+Sk/h9E5rrYVzmPgs+YVSWKDI9eW9WJLaS+GW3r3uQlUcAzQ6aRB+qTChuiQ/Mpq85QohvnZpjv+JCliG0v2oW42SvfJoWSOKHiawUvfHtNrSuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7fAijIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7fAijIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C409BC116B1;
	Tue, 18 Nov 2025 04:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763438509;
	bh=bw5LhJERFoqF5lT5iHUddpREUO0sQYx6j8XoLR9lDGE=;
	h=From:To:Cc:Subject:Date:From;
	b=X7fAijIOaliq9EuebPTnbk23EKElZj0409TzVoHVPQLKlf1GSHuC+gP0JOJVUI5N/
	 bqjTWupUPujKDhHWA/l62CF4wr5MTCbwvNnoXdj6Bx7VSHnqziP17/qiBFqOM+iNWf
	 R3WP06TBZrp1SQRqiI4/Ib/y0KRONSjxG7rThJx88EIW6M+oNMKzYf29lMNyc6lkZ2
	 mnzlsk18Weu+xeKvENKy+OreJZhqVNS81daPfs6CUI3VaQsq1cJnKGdrMq/fwWyIgU
	 CS69VFJys/h3ylXFe0rYx2vOTw8wESHYtAUjr6QeVAA2ryltyoFl7u1FKfhbxVWkQh
	 mCmuJtgv11Eew==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next 00/10] MPTCP KTLS support
Date: Tue, 18 Nov 2025 12:01:21 +0800
Message-ID: <cover.1763438045.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds KTLS support for MPTCP. Since the ULP of msk is not being
used, ULP KTLS can be directly configured onto msk without affecting its
communication.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/480

Depends on: implement mptcp read_sock, v13
Based-on: <cover.1761198660.git.geliang@kernel.org>

Geliang Tang (10):
  selftests: mptcp: sockopt: add protocol arguments
  selftests: mptcp: sockopt: skip mptcp getsockopt for tcp tests
  selftests: mptcp: sockopt: add TLS argument support
  selftests: mptcp: sockopt: implement TCP TLS tests
  tls: add MPTCP protocol support
  mptcp: enable TLS socket options
  selftests: mptcp: connect: enhance TCP ULP testing
  selftests: mptcp: connect: skip TLS in disconnect tests
  selftests: mptcp: connect: fix uninitialized variable warning
  selftests: mptcp: sockopt: add MPTCP TLS test cases

 include/net/mptcp.h                           |  34 ++++++
 net/mptcp/protocol.c                          |  61 ++++++++--
 net/mptcp/sockopt.c                           |  18 ++-
 net/tls/tls_main.c                            |   7 +-
 net/tls/tls_strp.c                            |  20 ++-
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  42 ++++---
 .../selftests/net/mptcp/mptcp_sockopt.c       | 114 +++++++++++++++---
 .../selftests/net/mptcp/mptcp_sockopt.sh      |  47 ++++++++
 9 files changed, 297 insertions(+), 47 deletions(-)

-- 
2.51.0

