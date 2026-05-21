Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA631ED81;
	Thu, 21 May 2026 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779333020; cv=none; b=V7QIeOiuefQV24LwFnxV7IuySfDk65Mczpu56WsU2mhviF7mjlk0KDpo/tgB1IG7bbINgAr3AEgfTJBDmC+agUx+3iDjhzVE01UGzi3PIx6GTRv2VJVmwSt5478I74jpLo9okWv/TZPF/ZNSL4GC8Ckn4Hi5tQcRI7UY+0a1fTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779333020; c=relaxed/simple;
	bh=XQAPDYO5/AsUuyg2SukJ7VthQYl88z3+JlOxCIDeG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3ayW6Bl5GEbLfTLQTRBR2JACoZl9PwWtGJ3DLZ5NhBmMdxpK78ltrZIa1TGTt2MO65BP33GLqwZn3r5K2FU3n8BLedt2h8GDKRVE+zAW+0FAitf7jNj2DLHaSPCavQfLQMxqK+4OgWbd4tjJBGO+WSw2wMJcJ/HGIvT8NZPI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqQJ3m4A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqQJ3m4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946B21F00A3B;
	Thu, 21 May 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779333018;
	bh=vNmm7ElPbevXVkPylSvaaWly5F7+iaJ+V2VAjLyoAAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZqQJ3m4Al+cr8Jb9Hy6VBwkNTzio+8SXSmycLEO7MNSYn3fCstKwWZ3asQXrHTso8
	 Z6CbBpkUwNo99L0PV1Xjp3knAteL/5vtKKcxoaplwR+Oavutq3bptlh/4Uj8LDEKTi
	 g5RNnreDqQjPNE0PIq9ojy8czVvdTugl8S8fa4ESLI7jBE1vi/JbnErG50ROQG6S6I
	 4RM5T+x5U/duAtY/OROqKH9o9XmlrIrMIfsfObY+W6auM4Kzly4Li8Q0FzKhUWnPP1
	 hoSeDLSIc+EPaSEaO+dRcNP4LG9rUSHFt7n2ntN1Aa0Iya1ENITESPXrlxlUiDhMdH
	 bBsQOLOnrf7EA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 3/4] mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
Date: Thu, 21 May 2026 05:08:49 +0200
Message-ID: <20260521030845.723267-9-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521030845.723267-6-matttbe@kernel.org>
References: <20260521030845.723267-6-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=matttbe@kernel.org; h=from:subject; bh=XQAPDYO5/AsUuyg2SukJ7VthQYl88z3+JlOxCIDeG0c=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4ytNYJdO9JZ7oTzvktEuoxmhBsgzDblM2pshNLJZHO Ff61d7tKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMgnAYZ/xuuUH1XEf+Zgk2FK 3/KZ4wa3nMFqv50C9V05xwyLMpgKGP47ZVXXz/VIrH7V13Nbb0et5QmHlu1ZlyYfPzbZxU1f4xM LAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 9634cb35af17019baec21ca648516ce376fa10e6 upstream.

When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer().
It should then be released in all cases at the end.

Some (unlikely) checks were returning directly instead of calling
sock_put() to decrease the refcount. Jump to a new 'exit' label to call
__sock_put() (which will become sock_put() in the next commit) to fix
this potential leak.

While at it, drop the '!msk' check which cannot happen because it is
never reset, and explicitly mark the remaining one as "unlikely".

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-4-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied to net/mptcp/pm_netlink.c instead of upstream's pm_kernel.c ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 857e8db670a7..be531df02c37 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -298,11 +298,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	pr_debug("msk=%p\n", msk);
 
-	if (!msk)
-		return;
-
-	if (inet_sk_state_load(sk) == TCP_CLOSE)
-		return;
+	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
+		goto exit;
 
 	bh_lock_sock(sk);
 	if (sock_owned_by_user(sk)) {
@@ -340,6 +337,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 out:
 	bh_unlock_sock(sk);
+exit:
 	__sock_put(sk);
 }
 
-- 
2.53.0

