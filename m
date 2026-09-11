Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77A495038
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141334; cv=none; b=QT+qa9k1Vr1WhXXeRmr1Y05eh+CxXV4G6c5YTYIDmesa/Qc9JVD4mjdVU8P9KcC0JTEejaDeYkuiLyMz8l/m5B/i+xo8hY0WdmvGuo5vKwtmi5m0+rAuuAwDGljI6vFQbVnTPzFf6mK88UmvqEgB51SY41qvPT6SrTiZvcamZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141334; c=relaxed/simple;
	bh=fh9NokvorsBhx6QCgeFU/GgkO1N4tGQ4pTKXIttbTOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qu8Ut7xo7n8iw3tWh964lrRn70wYWqbYUwoHIwcjwkgnEmnUxG8LZmc7lOpA46LCoBFiQm3/OZUjWVa2eZaI5SJerYGOvNEPNFvphPI8XMx3kV9bS/ERElfDjC7m9DpBb8dKw21WLqDoX1cqz+C7A5RwveEeV/1teVuBCZgf+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQUc0VKQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQUc0VKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB46FC2BCF5
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789141333;
	bh=fh9NokvorsBhx6QCgeFU/GgkO1N4tGQ4pTKXIttbTOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tQUc0VKQxU+zxaQCX3kGDvz/w7sBjfda0lSh4Q0ZBgIO2X2anfavNZ8Fa8zJfrhT+
	 GzShG0feoWI/jw2in22lxspKlDWQNY9nXfvHt6WgSQSoCBy7ReVEefiLS4ZYn7amZP
	 rtK31Jf/VyuxGQo8napDPp/k4HdUZ63XwF0ptUgqfhY2/HwNNUHaYlyh4unJUZJunK
	 tfYGAQHr+XHhD/yzq7ASuaZH6R9w37qWN+hCECsn8geV0jwnENsaYYkYkcnBuy+FcF
	 jqrIpPF8NYWJDylGrp5y82TkK5aYJHCcDbnVLjG52+Q+w5lJhfawsx8QfSKJvPV09X
	 JQ63Dd2bmmhoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9089C88E45
	for <mptcp@lists.linux.dev>; Fri, 11 Sep 2026 15:42:13 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Fri, 11 Sep 2026 23:42:07 +0800
Subject: [PATCH mptcp-net v2 1/2] mptcp: reset msk state on early connect
 failure
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-mptcp-connect-undo-net-v2-1-54224cea2238@proton.me>
References: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
In-Reply-To: <20260911-mptcp-connect-undo-net-v2-0-54224cea2238@proton.me>
To: mptcp@lists.linux.dev
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141332; l=1608;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=Gb88AGXvEtF1PuBgJ2BG7vao+UDAMuDxJ22yWrqoiy4=;
 b=zeaCexkhDYeOzuZvUNipNnmSRiTtnq2sR3HltMgMaq1XoBpP/uDkO22WPbVHJ9NTktUtm6+03
 69BzlIMHj9ZDmFdgYRLX5ZP/Uw+YLIgfE2Nu66FKcD1lpwkTdQYNoRY
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

mptcp_connect() can fall back before the subflow SYN is sent, for
example when the netns is in an MPTCP blackhole, token allocation
fails, or MD5SIG is in use. If the subsequent subflow connect()
fails immediately (EAFNOSUPPORT, ENETUNREACH, ...),
__inet_stream_connect() returns while the socket is still
SS_UNCONNECTED and never calls ->disconnect().

The error path only dropped the token and moved the msk back to
TCP_CLOSE. MPTCP_FALLBACK_DONE, allow_subflows and
request_mptcp were left as after early fallback, so a later
connect() on the same fd stayed TCP-only.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/633
Fixes: 0235d075a592 ("mptcp: mark as fallback even early ones")
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
 net/mptcp/protocol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f08f71cdb1..10817ab03cbb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4197,9 +4197,16 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err)) {
-		/* avoid leaving a dangling token in an unconnected socket */
 		mptcp_token_destroy(msk);
 		mptcp_set_state(sk, TCP_CLOSE);
+
+		spin_lock_bh(&msk->fallback_lock);
+		msk->allow_subflows = true;
+		msk->allow_infinite_fallback = true;
+		clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+		spin_unlock_bh(&msk->fallback_lock);
+
+		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));
 		return err;
 	}
 

-- 
2.55.0


