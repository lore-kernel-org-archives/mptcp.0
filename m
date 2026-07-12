Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9A1A6800
	for <mptcp@lists.linux.dev>; Sun, 12 Jul 2026 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783822557; cv=none; b=p9lsVsTQuISvfh0fPau+THu+Wdu9XkfZmw7Z0b7WE2Huyxow0DHpn/60+C7fVHIkYo3HTP9X2tDpj72tydx/tQ21yognIXuviBQB+qyZc0X97bXbiH9AEBJj0+QSK5HqyWyvfn1BRCYzD9eXgWzrAFQvlmlptNJuXvJ1O66es/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783822557; c=relaxed/simple;
	bh=xy+8uazxKR9dGUNX7fWvjixAVPehe8/FlcL2/xuzNPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoQAv25EPNdddS+eh8Ryya6zySqsmeGPypuMmqzoJ8r/04wlBtU9zpIhSmXpFwabtnaXvfausZMiArQbvwnCCU8vKJk0xOHJ6lTkeOF3NkhTFCdqWg9RA9usQUVxJBmVM3L/PZDpPyi2Lb6lVnnty+2Fbi5BT3y6B8BZnvEs4Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl0JD4wA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl0JD4wA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7264E1F000E9;
	Sun, 12 Jul 2026 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783822556;
	bh=M6Ac+ktmMQRDdxl6K34HA6Bbs07E9uVE3WOl2vFYiQw=;
	h=From:To:Cc:Subject:Date;
	b=Gl0JD4wA9UyMS5anuf1KyFcFVztMx5VZ64SSYUTz6flh+W26VrbQqpmAy8TP8NEMQ
	 CR55atLesGMsPz3II2anOu4KUxRg0GtN3tGUIFIv18zc9fVuokd+M79A7VIiYMU+wr
	 n2osJoAr3hOEEbWiHnrZ8egmze58VUm7ktumqIZ21HRsiZcz0cC5Ll/SCfdI8DJ8ZY
	 DHHD3N+kZerKZcI78SHNePsP8tdhJA6hIpGwryQkijvD5c6i3JpLFmByq4tVk03A5c
	 v9d1zP1GW+X7bQnimexHKOlM9p03frkCKMEatdUL2pJsV7Zfcf4NF+rEFdrbuQfDEM
	 xowArZEWC+h9A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/5] mptcp: add MSG_ZEROCOPY support
Date: Sun, 12 Jul 2026 10:15:19 +0800
Message-ID: <cover.1783821830.git.tanggeliang@kylinos.cn>
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

The third patch handles SO_ZEROCOPY in setsockopt.

The last two patches add a new 'zerocopy' I/O mode to the mptcp_connect
selftest, and a wrapper script to run it as part of the regular test
suite, ensuring the zero-copy path is exercised in CI.

v2:
 - patch 2, never mix PURE_ZEROCOPY frags with kernel-copy frags in the
   same skb; handle fallback, return values.
 - patch 3, a new patch to handle SO_ZEROCOPY in setsockopt.
 - patch 4, set SO_ZEROCOPY, handle listen_mode, error queue.

v1:
 - https://patchwork.kernel.org/project/mptcp/cover/cover.1783774784.git.tanggeliang@kylinos.cn/

Geliang Tang (5):
  mptcp: use local variable tp in sendmsg_frag
  mptcp: add MSG_ZEROCOPY support
  mptcp: handle SO_ZEROCOPY in setsockopt
  selftests: mptcp: connect: add zerocopy io mode
  selftests: mptcp: connect: cover zerocopy mode

 net/mptcp/protocol.c                          | 117 ++++++++++++++++--
 net/mptcp/protocol.h                          |   1 +
 net/mptcp/sockopt.c                           |  15 ++-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 .../selftests/net/mptcp/mptcp_connect.c       |  96 +++++++++++++-
 .../net/mptcp/mptcp_connect_zerocopy.sh       |   5 +
 6 files changed, 223 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_zerocopy.sh

-- 
2.53.0

