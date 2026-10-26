Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010937;
	b=NgIFaQeJ0ERDECIhR+WJNtS8qo1jAz9H4ELAOWMQcVfj/XPpNd/gWawER4K+BGtBwzg1
	 VBKHQYHn7SstcJbTbgCzkqaPYZ/GqL7vfllh9QsXf4TRnKmOw0TL+voMqX6nzUC3at/Ww
	 x/N7j4T9DI3B+sATSRyk5Jrosclssf3/7C6kJBT7P8is4Fu8FlGApntiKjp7pXma+9Ylc
	 UW4/QzlSia27v2H8wTCKzfMA2kJRQXW8KUfzmR+zU8tDij9fsWIgpW3hN/dvFvV81rFjz
	 xxdQVEX34S41Nm4cWytLPet+e2pdHC5mANl46h+r9hC04MESLr9o7t+AWD3SZZOKZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WHEXm+mk8Zm19SelAfDW0n57RcZ1SItX9hnpco0JY9c=;
	b=RadhM1ydf1hzbkEJGwx47VLqPdzJ+SqFU9nsA6ljBwCfgg5q8mN33ke6PZiwk9QBkXDV
	 /u4HIUpA1Xbo5vYU+i2sZbrp5YP9S5dj3Y8jsP7KqrjoQJv74tozzLtfklD+pgiRVqaer
	 rQ34aWyTxAsP0lExP1f++7uiv7Jp4mgw9yfrkcGjzmHmZgF1EC//Q925cPgMDDhDrl+Yf
	 PrGAjBVnfRqJV4rNfDfKdrc2l60jcJznYoaVpGcpF3fE3KGzdefN9/dgTgrYcxGXLs6+K
	 qXvbORwcrmHpO6DcTea9Xi/6aRgwjhpuKi+F1y4d7uZp0ER3FPMDilXTCkfko9Md3qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGdyEOQb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736B3606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZGdyEOQb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF6C1F01825;
	Mon, 26 Oct 2026 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793010937;
	bh=WHEXm+mk8Zm19SelAfDW0n57RcZ1SItX9hnpco0JY9c=;
	h=From:To:Cc:Subject:Date;
	b=ZGdyEOQbPYQghPv6hDwAyLojxgtCIiAtemEGU15oPVJFa6uASF46ca/aNrtTSQSBO
	 b4jXNCREuybxJLH4Lof3eGCB0N2JpZ+ProJu/Oc7YvJeHozfC/V73PUbMdpEhc4W2f
	 Ba4rf1v3a8hmsEd/UJFQAXiyjrtmEKV5ndcGG+XU4MU6Vyh7K3Yy5H04jRe2kvLLJB
	 rux6GeIHqMIF3h11oR2eu1oTJSiBaXCSLuQz1bzzSmt7APFyJdDH5cRVfL3ltDSKmE
	 WNEqe3muJ2W67qTjAg+a721jhU7Wh6Qrq7Qvistb72cHIWm3+JxOU/wAqQgLwLTsk6
	 uAEZlxsuJUksw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 0/4] Add MPTCP support for NBD
Date: Mon, 26 Oct 2026 18:35:24 +0800
Message-ID: <cover.1793010744.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This series adds MPTCP (Multipath TCP) support to NBD (Network Block
Device) and includes comprehensive tests.

MPTCP can aggregate bandwidth from multiple network interfaces, providing
significant performance improvements in multi-NIC scenarios. Our tests
with 4 virtual NICs (each limited to 1000 Mbit/s / 125 MB/s) show ~4x
bandwidth improvement: TCP achieves ~110 MiB/s while MPTCP achieves
~400 MiB/s for both read and write operations.

Patch 1 gives MPTCP sockets a distinct lockdep class to prevent
false positive lockdep warnings when MPTCP master sockets and their
subflow sockets are used together in the same lock chain.

Patch 2 adds a set_memalloc protocol callback to struct proto that
allows protocols to propagate SOCK_MEMALLOC flag and allocation
settings to their sub-sockets automatically. MPTCP implements this
callback to sync memalloc settings to all subflow sockets.

Patch 3 adds MPTCP socket support to the kernel NBD driver by
allowing MPTCP sockets in nbd_get_socket().

Patch 4 adds a comprehensive test script (mptcp_nbd.sh) that
validates NBD over both TCP and MPTCP.

v2:
- Add lockdep class distinction for MPTCP sockets (patch 1)
- Add set_memalloc protocol callback for automatic subflow sync (patch 2)
- update selfetsts.

v1:
- https://patchwork.kernel.org/project/mptcp/cover/cover.1792746800.git.tanggeliang@kylinos.cn/

Geliang Tang (4):
  mptcp: give MPTCP sockets a distinct lockdep class
  sock: add set_memalloc protocol callback
  nbd: allow MPTCP sockets
  selftests: mptcp: add mptcp nbd tests

 drivers/block/nbd.c                           |   5 +-
 include/net/sock.h                            |   1 +
 net/core/sock.c                               |   8 +
 net/mptcp/pm_kernel.c                         |  16 -
 net/mptcp/protocol.c                          |  58 ++-
 tools/testing/selftests/net/mptcp/Makefile    |   1 +
 tools/testing/selftests/net/mptcp/config      |   1 +
 .../testing/selftests/net/mptcp/mptcp_lib.sh  |  13 +
 .../testing/selftests/net/mptcp/mptcp_nbd.sh  | 373 ++++++++++++++++++
 9 files changed, 458 insertions(+), 18 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_nbd.sh

-- 
2.55.0

