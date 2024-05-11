Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040C1C01
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715416661; cv=none; b=VOWwJtYqmeNVINDf+L/JIoD5uMvL9353PJpGIb+TccYxb8UxtlurX9Ab+Q979rsIJ7edkjNws7iAZO1lCNXq4NqcWdDyrj1pgsFhAE8LboWy8kGsIlGKtTfT6DT+Cqds4n8MIBiDuI6SHqS/x3EjzEnASVJgoCCFxi9kV2FvNUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715416661; c=relaxed/simple;
	bh=/73YsU/NL5hTSoxAhsKBGJGJnXcRu23ZSpjwoRy2CnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPNCSJjIVeYF183EiXvJZBuhvvQqDE+xUvNOweQ83/aNltTGi3+NeCzq9NgoMFqvbOijuWwlWcK3AsMzohQqNgb8pEoxs3ubppeqIBfMcGl09MRaKQRq0H9yEZ8Llj99x5gqJZZX/PzZZG7xKCkwxn4qMckzYZieOcvknqsoXAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZfC8elJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZfC8elJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914DEC2BBFC;
	Sat, 11 May 2024 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715416660;
	bh=/73YsU/NL5hTSoxAhsKBGJGJnXcRu23ZSpjwoRy2CnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZfC8elJRKXVpOL8cDKpsBuvaIXbPRMOU+LqDEIuml5lA2BNGI9FuU2rg06Sb5LV2
	 C4HIfgMq6UP8Lj4kvA003bN/B/cspKDiCy6c3w46J9ifMyod8mmat7peU8RD+PZz4Q
	 AHuyHkdyPI2fYHtEiDVM+7owPAx3vggBXixQ4fLjQ4iJ5l5RRt4a97CN7Vtay/SOZp
	 JJnUCH09htotvtoM9nowm0b/8JKnro2ZR9rRJWXAHJMckFPegdQjEHltMWUh148z30
	 C9Pg+jZbzNDKO0ay2tFyYFwLumaITiytQaiXI0wR15FkgYWCSFcqKUZ02kG8fLNeE8
	 pVq87VFXnPOVQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: use mptcp_win_from_space helper
Date: Sat, 11 May 2024 16:37:30 +0800
Message-ID: <fc78b2ba54c834d31eea7d099f9e5db9418d53e8.1715416511.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1715416511.git.tanggeliang@kylinos.cn>
References: <cover.1715416511.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The MPTCP dedicated win_from_space helper mptcp_win_from_space() is defined
in protocol.h, use it in mptcp_rcv_space_adjust() instead of using the TCP
one. Here scaling_ratio is the same as msk->scaling_ratio.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 579031c60937..04dda32ccbef 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2046,7 +2046,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		if (rcvbuf > sk->sk_rcvbuf) {
 			u32 window_clamp;
 
-			window_clamp = __tcp_win_from_space(scaling_ratio, rcvbuf);
+			window_clamp = mptcp_win_from_space(sk, rcvbuf);
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
 			/* Make subflows follow along.  If we do not do this, we
-- 
2.43.0

