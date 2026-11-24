Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557677;
	b=Et/QqPHNLb2LPEfmsBCUZGFSKsLgRKGRuhzwxqjPo92nROUt0Gg6XlGpFOK8KnzpJXIB
	 4Z+5Is6/OdSbKuKB3qa6lfkse9TWe2zNNjahNSpdYxfwGv+qTPDqtSg8ebNHIfjpI9RAj
	 uWRTnDV0YXROBtswnlbBU2s1+lgmIc7b72jbZgMhrke8jvsvLRaTXD5x72Lh4/Cc6BrnQ
	 Xl9Y/Sfpi9tGEragj+3FeBXT82qC4WiEXRNk2IneLAUPV2hPZrs4tVKWEnfyrIAQf6vm3
	 vQ0wfxqnu+CsVtBG0kXQ9WBLXSQtKcbyPm3Lq+iHiYSCkbmP38CsTo+hgl0mDNDVFFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557677;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iThpyjHhC9bRvx/ExA9uRJM2Xp0zww57/Y1d7HPCC+4=;
	b=xveydBdVaiQYzkWBECS67+f38r1MAbqmWT4SNAFIL4LDZkLUViu+HS9XgYuCemWHF3Cp
	 AdHaTU2fhzH8gWCt55GYphb6a50GVEgUA/74SfZBvyQEdGdeM/phRdsKRv42PWwCAe2HK
	 82h5hDSVeovPBqKq46uzKtR6NfXanpLvOSNQb3L5QYLtaB3fLfgaov1sJ2EPoynE48nhl
	 h37ayoEGmAzygymEjXDt1nsP1YiFHbP831OHgFSd876/UETNj9GyizJt1yalwd3FZxFU9
	 xokIuUm9yPfH4CH5cOWJEj6E4imP3tTx2JmLAwS4LzBwFQJ5thYv+iR7J98G3WG7jbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxKCYJmd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CA606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FxKCYJmd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B8F1F000D0;
	Tue, 24 Nov 2026 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557676;
	bh=iThpyjHhC9bRvx/ExA9uRJM2Xp0zww57/Y1d7HPCC+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FxKCYJmdYSslldGdu2FCYjj3dE/j64FD3Y+gMKFIejYwA4kIgBc8NyySAMfu1W60a
	 rxBxN++anRkHBENn4+3DEkv5V1bSNKIrDf2EBoNpfJvD2rrSZfBbU0vhU9+lyNM9vk
	 KWtOKASAzo/NcrYPAVd+YgOeXXHIM9b5lW3u1f4ub1XHwWVytPjDxXgnbPvjqetRjD
	 ZmX9b2W35UinjKMa1aEZTBC0F3rzZ7UY4XV7Xq5jdZoSRhUxNxVqPHp+zSHEBGtapw
	 eRxlFjtbqYKjj2V+iTX5OHnST7erpnjfyFpiydEFIBSgEM0crEwT1zx7CmtvJ4rFSD
	 Zs4jwjBzvlvUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:32 +0100
Subject: [PATCH mptcp-net v3 15/50] mptcp: clear sk_err on connect(), as
 TCP does
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-15-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7CFFHnE2xbqFIqvskUo2gO4jn36RtJRg6RBmro2spLQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOBl2rM0++Tsl65vU+3WxSfHRPTZLK2V/B9/dyPNOy
 nPyEu5jHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABMR/MrIsL9lnqFYZSWrudVd
 ifrHm1QOC1V0fjrN9cf24HqlW3+Pf2FkOP7v376dC1K+1nKrXd3pxsx5r/jNviLHTRraB49MmuL
 xjBcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After a disconnect with connect(AF_UNSPEC), an error from the previous
connection, e.g. a reset not reported yet to the application, was still
reported for the next connection, by poll(), SO_ERROR, and the first
send() or recv(). TCP clears it in tcp_connect_init(): do the same,
once the subflow connect() succeeded, so an early failure keeps it.

This issue has been found by an AI code review agent, while reviewing
other fixes, and confirmed with a reproducer: the peer resets the
connection, the error is not read, then the socket is disconnected and
connected again. SO_ERROR then reported ECONNRESET each time, while TCP
reported no error, as MPTCP now does.

Fixes: 3d1d6d66e156 ("mptcp: implement support for user-space disconnect")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for an issue found by a review agent
---
 net/mptcp/protocol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff1dcf306723..6328815ad273 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4452,6 +4452,8 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	if (err < 0)
 		goto out;
 
+	/* as tcp_connect_init(): drop an error from a previous connection */
+	WRITE_ONCE(sk->sk_err, 0);
 	inet_assign_bit(DEFER_CONNECT, sk, inet_test_bit(DEFER_CONNECT, ssk));
 
 out:

-- 
2.55.0

