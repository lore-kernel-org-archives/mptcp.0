Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0B225779
	for <mptcp@lists.linux.dev>; Sun, 13 Jul 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752399838; cv=none; b=VMR0TFQAJYSaboutimkuiCPG3O8UHIvsIYi1l3Y9b/s2bZ7UkLQzgDuKe3i2BWMdgQXom7eKqpkJsSzAeHh7pEQMkW9pkrb2iyan1rxKMzo8fZSkllrJvsU7rftOQieXXZNAoAFHGSvvA8BPx2/m0XwgVUSUsri+YkU8GFwUDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752399838; c=relaxed/simple;
	bh=AJvHHEUgPwIfbiffHalaneXA5BZELWoGjQehMawpHM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzxdfWF6JmBi11NBhYqhhz+IEZpz3KIujxD7egkqTLejmKoF5M8rKis8wo3RSjBy9e99geCdqxN/PmrjuHU7Ch0lbaxl27/Gd3etXOhh2E0Bls0b2gc5IZzC6qi20eG1LUrAJScAHf/UP77v1VRsPEh13GRlxz/FtUs2EBM4DRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtPbOfJ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtPbOfJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A334DC4CEF7;
	Sun, 13 Jul 2025 09:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752399838;
	bh=AJvHHEUgPwIfbiffHalaneXA5BZELWoGjQehMawpHM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dtPbOfJ8tRQ+lS2YPLV2pW4PT9r8dg90A/rRXNSkBC7AczlXlyPv4+sJ9ydAibfe4
	 0duiKkpeuTDPMVRqDmB99EGzqafJK+0sijbX1I43qPNHPLmidm/AtSMN2wZb1tfiNq
	 U18vt/FK8fgma0l1bF4M4P12GEWwGXBQCt74Yhpka65kh4V7PPHJe8bzcSillqXWNK
	 y86zeWuBZ4800cTuDxr/QISis6u24xGkxRCxB2T9uqYn7ZnURth3nr9wGwWEXPnjS/
	 pS0yv+TDlMUqWYuAuvhQcpR4zCwJnyuVuf4RcxLikoVUXLCFuE0AIWzXFjtmfF14w0
	 /UjiCdbfAupGw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 3/9] tcp: drop release and lock again in splice_read
Date: Sun, 13 Jul 2025 17:43:43 +0800
Message-ID: <36dba482a6f8669135ff23e8c3b2f614ab49a262.1752399660.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752399660.git.tanggeliang@kylinos.cn>
References: <cover.1752399660.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In the main loop of tcp_splice_read(), release_sock() is invoked to release
the socket lock, and then lock_sock() is immediately invoked to hold the
socket lock again.

It looks like these two calls are useless, so let's drop them.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/ipv4/tcp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5aafe569d4d0..c81866ec4333 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -866,8 +866,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 
 		if (!tss.len || !timeo)
 			break;
-		release_sock(sk);
-		lock_sock(sk);
 
 		if (sk->sk_err || sk->sk_state == TCP_CLOSE ||
 		    (sk->sk_shutdown & RCV_SHUTDOWN) ||
-- 
2.48.1

