Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4603246F9
	for <mptcp@lists.linux.dev>; Thu,  5 Feb 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770277205; cv=none; b=O5Q3qCQ7el8AxoyJAm4xJRH7MTSxN2ltJy0+JDTxKEU3wNRI1jrBE7o34Q8UmZMBm5oWaokM0TWt1eYRDlZZTkvRNpQ7DHCGmgIDpfzRONxfppHUgoblnfcXqgn4kDkiv5DEq05j9nH1cSvIbahh3A+JGNdUL80WZyW8rEU0U/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770277205; c=relaxed/simple;
	bh=g3C3VzbQg5gqcwKrVuykNju7GfOmlWIOSjMlcI0FlKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0DHWsqLZ50D3WSOHzE+2jMdlYfG/SzYHR/N561Y1kAZnuC+DBAB5pwOmFJ0kL/SGOqnMMJddUvSJAqdOHIBK0lHRZLeJNRCKX7D8kzs13YgR3IIPPjnYF7Cgzs9/51V3bUr+GkQS8ZJ1fP0iFk1I5ye8UHUEBwqdgZAGxzQJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvY4Oi7u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvY4Oi7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9541C4CEF7;
	Thu,  5 Feb 2026 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770277204;
	bh=g3C3VzbQg5gqcwKrVuykNju7GfOmlWIOSjMlcI0FlKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gvY4Oi7uQ3n/E9qQF3RikP5bAYL9ocMQkZm/L1E3v3ADqHP2UmtrtP17KTTIGQZOl
	 onddPi5YpI3RBZ7ZklNfmFUts8FkLvc9JrMjcR4wzDiEJ+SdvKOQUnJFN6FXv6mK2k
	 NbRIwaRrX7lfN4EySiqtUsFTvj562UaNvP7NaLZB3xorq49ZwE4C4C4UViI3czNg0C
	 1psbcxSg/fhXYOrcg9MPeIaTqeUeNQg93hSwXWNLbfmcwGj7REqn1uBLh89QYdCqNd
	 V0BUjee9b+gh7PA3P7lOeWHah4amXCHUVj61LX1R/fzLwyG6//kZhWa8kb27F9vwC2
	 leEoMme0y0NvQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next] Squash to "mptcp: allow overridden write_space to be invoked"
Date: Thu,  5 Feb 2026 15:39:54 +0800
Message-ID: <f044ee2401fe23dbb0d917765ca07c1d8f601758.1770277185.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The default value of sk->sk_write_space is sock_def_write_space,
which causes the original patch to change the behavior. For MPTCP
sockets, sk->sk_write_space should be set to sk_stream_write_space
here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c88882062c40..f58df4651b12 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3065,6 +3065,7 @@ static int mptcp_init_sock(struct sock *sk)
 	sk_sockets_allocated_inc(sk);
 	sk->sk_rcvbuf = READ_ONCE(net->ipv4.sysctl_tcp_rmem[1]);
 	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
+	sk->sk_write_space = sk_stream_write_space;
 
 	return 0;
 }
-- 
2.52.0

