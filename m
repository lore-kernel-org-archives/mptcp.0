Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD837F741;
	Mon,  3 Aug 2026 16:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773831; cv=none; b=hBoI6CWy4R8KdiEh+WfcdD6gXlMRHJZVipXg+zE5Yj2Ma7sP3wSDDego6jxKtR80AhEeUjdHqCBkuXWMks3U6AUQXSRlVZx59F/jAo8IGShB9NH0Oc344xdxnJd8YARFmvuUmajqHiyhghtPCR3ZgBBsRpsqWkyrrpjr+yGGg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773831; c=relaxed/simple;
	bh=8+CGYSe3kZMMOTUEHKGE8EA7k+J0vsJn8cpqKxfGPQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlKmzxDcp1db5D2lhg4SrKCXPsIm6YO23B/gflwekA8LRE9NH6W0LoVC3CigtnVzoEQGkcGllwiprrXsIwXG/j2qCkHJzbrcB3AAWvQOsKhFgYRcLanEqgOGd39jnT2rI8TcMHPiSRbvK8TmpCl07YPdE9RHWnWjlTPCOA8NQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFIRdWce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFIRdWce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C619B1F00A3F;
	Mon,  3 Aug 2026 16:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785773825;
	bh=qQORwAh6+QnbGy2AgPHZq0cX+JfqXclVLoVueu+7rGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SFIRdWcea5ayXnPfl3fb3NaQr6Tz3wF0n23j20O5jsZD7QotKmjcGGthCYARaGU2G
	 /8woH1Rz/6BVbKoGSLxYE728+a/bwATtr6YfM+9P/UMLDMe/UjMN3/HSResTtDHybi
	 aXcbRGpAo946vcxnVOHvv+6mzURdrJR8TZNmKwEYs4/1aHgmnBbIEcV+HnsQLFYMst
	 mZtn74z6IDc3o9k9ngHjzBcVdnJ6PAmDw1i6/XIfLfXU2VRnQt07+OzcGWl4K2Y4lN
	 +BwVXAqivdK34eYYpcifQfB/GLTowrnbD1WASZpdvsrazad/4qcc8ZuvUfkLYT1MfT
	 jYY+W22Ef6Zjg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Aug 2026 18:16:35 +0200
Subject: [PATCH net v2 3/8] mptcp: remove MPC && MPJ check
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-3-b8f496d71664@kernel.org>
References: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
In-Reply-To: <20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8+CGYSe3kZMMOTUEHKGE8EA7k+J0vsJn8cpqKxfGPQk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIK9r2fWlA5oVu2b9OSGZG9T5dkno+JUui7HXewcenL0
 12GM4UsO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbSnsnIsC/Xx3SnWsex30cY
 +ry2+G5UXZ+g/ujozYZU8yt/jtTz8TIytBW77J79bW+V7r2pjGuy2TnCjZ90SjIotDS9tHsq/GU
 7PwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the parent commit ("mptcp: avoid combining some incoming
suboptions"), the parsing step no longer allow to have both the
MP_CAPABLE and MP_JOIN suboptions set together.

These chunks are now unreachable, these checks can then be removed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: New. Added here for consistency, and to reduce comments from AI
    reviews. This patch doesn't need to be backported, but it can if it
    helps backporting other patches. (Clashiko)
---
 net/mptcp/subflow.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8e386899ceb9..e1f20ff8fdb4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -174,8 +174,6 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (unlikely(listener->pm_listener))
 			return subflow_reset_req_endp(req, skb);
-		if (opt_mp_join)
-			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
 
@@ -277,9 +275,6 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTION_MPTCP_MPC_ACK);
 	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
-	if (opt_mp_capable && opt_mp_join)
-		return -EINVAL;
-
 	if (opt_mp_capable && listener->request_mptcp) {
 		if (mp_opt.sndr_key == 0)
 			return -EINVAL;

-- 
2.53.0

