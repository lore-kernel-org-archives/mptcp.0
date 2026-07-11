Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A38372EE9
	for <mptcp@lists.linux.dev>; Sat, 11 Jul 2026 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783775301; cv=none; b=P2sHprDu7JVbfTrNN+SxFyr7b90qLXB+dEOD4/+fG9aupQqzt/yF2sx5VlqwpZXkX01GJ2U2n1ADx0vquWzE6N8UBUVgIPF0ki1fGDbKUFPUpbnoN62MseDp/zC1UCuW1EvR3F0boygDBmHlFPlRsv2cLJo08Lwep5QSk57v99g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783775301; c=relaxed/simple;
	bh=Bh0awNi9i/Lg87z2kBDcEGmHvp18TCPQt51yujcvoNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCKjCksH0MYknc4onoanuVYfgKLXKnvWjqht2L7MzS0xhoz8gTlwuaSf2L+/JWHpQqjYPd+QdfZTLXMdG3DDGreW5mfV2Z1TrWtH6xkaCzFBqEePxOK5wOJZSwUC2iM2auUjzaTkiJ1FmaKq1K+NldJmkIsiUpdoUGMhW4ccAHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbEs6Foe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbEs6Foe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B14B1F000E9;
	Sat, 11 Jul 2026 13:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783775299;
	bh=SLbTuVcfOfnQw0EjR4C8pMmDCea+f5oJzRLOC0oH9p0=;
	h=From:To:Cc:Subject:Date;
	b=cbEs6FoeftFuKYs7Gp2k1liNf3jbZjWXHgZkoSeSuB5hrDuj6/Li1y2kOyRmEGkw8
	 iCMZOk6z9ZM2pf6FeY6LVBQdp4p/L46Kz3rf1qMP03yEvGDXydghRdUYQ7WYKeIKPW
	 RJLW6O5bVsYwYDWImrAlN81/FuMWJf2QwyFWI/ZoE/8/ysPdJR/UfREAtjYonhhmp1
	 5UZsbgI2r35mHO0XJ9sL7LH1wUhMKuFYf1NVitoU7S5x/PiNkGV/7/d6HXDO+BJAtb
	 vi0ArJFE1mXVsAFFLFFFc4jCENMeZsIzxsjVM4VHtlmKvyUdY6YbwbNJL97Df12IOy
	 6TB66y38vRn3g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 0/4] mptcp: add MSG_ZEROCOPY support
Date: Sat, 11 Jul 2026 21:07:48 +0800
Message-ID: <cover.1783774784.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds MSG_ZEROCOPY support for MPTCP sockets, allowing
userspace to transmit data without intermediate kernel copies, and
provides corresponding selftests to exercise the new path.

The first patch is a small cleanup that introduces a local 'tp'
variable in mptcp_sendmsg_frag() to avoid repeated tcp_sk()
dereferencing, preparing for the subsequent zero-copy changes.

The second patch implements the core MSG_ZEROCOPY support. The design
follows TCP's reference-counting model, with a single ubuf_info per
sendmsg tracked by three reference buckets: one held by sendmsg itself,
one per MPTCP dfrag in the retransmission queue, and one per subflow
skb. Completion is reported only after all bytes are acknowledged at
both MPTCP and subflow levels. The feature is silently downgraded to
regular copy in cases where zero-copy cannot be safely performed
(MSG_FASTOPEN, fallback mode, or memory pressure).

The third and fourth patches add a new 'zerocopy' I/O mode to the
mptcp_connect selftest, and a wrapper script to run it as part of the
regular test suite, ensuring the zero-copy path is exercised in CI.

Geliang Tang (4):
  mptcp: use local variable tp in sendmsg_frag
  mptcp: add msg zerocopy support
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode

 net/mptcp/protocol.c                          | 104 ++++++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  63 ++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 5 files changed, 163 insertions(+), 11 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

