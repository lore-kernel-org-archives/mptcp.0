Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9D2376FD
	for <mptcp@lists.linux.dev>; Tue, 18 Nov 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451720; cv=none; b=dUb5uQYXD7tj6ft2dqwIvsb7dIGYhN1fWcjoSP9ETD5d+xm6JES7NrJ8qt9UGjSFuItc2iCIVK37b/1tYvLJr2IAffgfrTSt7ZHUcka91CkaZrQi1eVBj+8Fi/m6hoSkADnQiNdmIaSXl6LxDHULKVOpnc0+6YFpR74tmZMLcUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451720; c=relaxed/simple;
	bh=XHaIt5Qguvb8xhAHtsY8Qsc+qRkpPvIrxqT78GYx0bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUECn8W0VjwCKsMOgVt7ZiQ4BJXTiUGi/7eOhsvQigBCYeRDhLbtOnvF3Gp+M6fFd3bP+SSB1s9QiPvNoK2YdZwRyFQS62kuoGGqM56x9bWw3JwqLRscEGaUGwCt8t6hUezOuQXH/rnJkoiVKVfRwBuJyOOUJxpor0Q1BQOEOkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sH3gzd+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sH3gzd+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B25C2BCB1;
	Tue, 18 Nov 2025 07:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763451719;
	bh=XHaIt5Qguvb8xhAHtsY8Qsc+qRkpPvIrxqT78GYx0bk=;
	h=From:To:Cc:Subject:Date:From;
	b=sH3gzd+V4c4hU91Qu0umWIizpqdqUrougd9n3FzYKcHizX7X+A1YkO33uzz6UFPAV
	 LgzLkDoZkK+uf2Sgr0se0Tpg+AZftF6vCWcSxjwaeS94AP7rxUUp7TI4X3M1iTwAoR
	 p1aFhNhgfgsOdQFVF6h2G7S8QrpiiNXJhhQGUV27amoNchMoMh9GfO8+g4X8uhMJ0c
	 qbHUfM7ebO+MbGygPgkhiKEXjNEK+0TQCGzc9zOtHPeCDXwnmmkGyVxdITKlA6KKi8
	 TTc4XRXqVZGkhg++mCE/KLR5ApYanfKuvs98vQahwDGbo7aW9x79VNAfuSQqlZhjnF
	 eEsUE9RfwmyVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2] Squash to "mptcp: implement .read_sock"
Date: Tue, 18 Nov 2025 15:41:53 +0800
Message-ID: <ae97ac245e5031422c18b3c2c2b37c3aad33cc23.1763451700.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Squash to "[v13,2/8] mptcp: implement .read_sock".

Add msk_owned_by_me().

v2:
 - use msk_owned_by_me instead of sock_owned_by_me.

Based-on: <cover.1761198660.git.geliang@kernel.org>

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c64494b15a40..13b858b47cf1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4304,6 +4304,8 @@ static int mptcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 	int copied = 0;
 	u32 offset;
 
+	msk_owned_by_me(msk);
+
 	if (sk->sk_state == TCP_LISTEN)
 		return -ENOTCONN;
 	while ((skb = mptcp_recv_skb(sk, &offset)) != NULL) {
-- 
2.51.0

