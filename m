Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D702D3EF6
	for <mptcp@lists.linux.dev>; Thu, 10 Jul 2025 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752141132; cv=none; b=bkCvGIVTquAck9CVMvv58GH3+/5ZoYWYe62PpIYZv6qUlF2jgnGA7TUprlc038J+iTq9PXjFnpI691fWPx9tRSqZRt60mu3aZE0yV6BjiVEkLIbqPIFYgMYhhan9jsd4U5J+5rt0cA//Lf6Y8kuN91vfzY2lCZkitirgT3WTxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752141132; c=relaxed/simple;
	bh=NvPnwgOpY2AzbN+RIB1GF7Ti6hN5w3vsygdFNd/aDOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HNmFJKd861AAck9J/PSef6w7njw0jbn3jjWheVNyulnHTw1smFzWpjpJfYMMliGOkd/3qdRbi+ble/vPvCQU2RosaOizA2ZYfdVBnocg60M63e/rTXIjL2xiSIrBajB+KwQ8nYzMMb38IIMF7OpzlSDxm8Tzl9L31QWTKOKNn80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIp6lBsO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIp6lBsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D18C4CEE3;
	Thu, 10 Jul 2025 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752141131;
	bh=NvPnwgOpY2AzbN+RIB1GF7Ti6hN5w3vsygdFNd/aDOM=;
	h=From:To:Cc:Subject:Date:From;
	b=rIp6lBsO2ZNgKhcZy3LETuwptm7oDs9qGyoqwCEDB6mFmpwgG7IBNAusNhHXI9qaz
	 JHr9M4lGzDX9HeF3rOheERWENYnJQi1LRvE+ElAJWUsAbqQ1mrg+BFMAzSKLOxMbyu
	 7RhWAWmzja7HI25SdrbDNTNKsP4OC083ckc8fGoJqGtnoBO5Gcj1EaQaTr5cg+rq7V
	 iUAuDZdiuIE67M36FJIOWtySyLZpR7AC4rSnUzDOBSNvFubwBqkjjgYgV4YHKA2IjN
	 LZ4fYdbLYTE0q6hoG2C4fbtcfWPChVvs/XasIIH0E1YOz9S+voS+ti2Dk/WTTWtRtQ
	 2F77APB6ji/Dw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] Squash to "implement mptcp read_sock" v8
Date: Thu, 10 Jul 2025 17:52:04 +0800
Message-ID: <cover.1752141057.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - rename mptcp_recv_should_stop to tcp_recv_should_stop and use it for
   TCP too.

v2:
 - use mptcp_recv_should_stop instead of
                if (sk->sk_err ||
                    sk->sk_state == TCP_CLOSE ||
                    (sk->sk_shutdown & RCV_SHUTDOWN) ||
                    !timeo ||
                    signal_pending(current))
  in mptcp_recvmsg.

 - use mptcp_recv_should_stop instead of
                if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
                    (sk->sk_shutdown & RCV_SHUTDOWN) ||
                    signal_pending(current))
   in mptcp_splice_read.

v1:
 Drop "shutdown" parameter of mptcp_recv_should_stop.

Based-on: <cover.1752045499.git.tanggeliang@kylinos.cn>

Geliang Tang (2):
  Squash to "mptcp: add recv_should_stop helper"
  Squash to "mptcp: implement .splice_read"

 include/net/tcp.h    | 23 ++++++++++++++
 net/ipv4/tcp.c       | 73 +++++++-----------------------------------
 net/mptcp/protocol.c | 75 ++++++++++++++++----------------------------
 3 files changed, 61 insertions(+), 110 deletions(-)

-- 
2.48.1

