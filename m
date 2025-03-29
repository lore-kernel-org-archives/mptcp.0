Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196763987D
	for <mptcp@lists.linux.dev>; Sat, 29 Mar 2025 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743265593; cv=none; b=b3hqalW9SK06nWeDVxASVAf2xWL952bhb2bACrORR5TA4D5HnoiJq1hXHPC9OzlnaLAArXrY+BUYj9KAGkqt3N3FuD7HEViOW9iHe+V1Fd+wuFlXtWhblE5yzlI20Ovb9cHFMucnJ4RDANm+9nzEMO+wBUC+BnVJZ4szQs+x9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743265593; c=relaxed/simple;
	bh=tEsxrMw9vWVwnA/jXpM4EOEjKZ9Nyga2j1J7QMj/caY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHHq4J+uZPB0LHCkIbSjlaUyAHTv68/tuSyP8t1L8Q0aTAi0h8nswWvrx2KfCZevXbmYk4qWLRJzLV1WnWcgi51BvAXYocqttBt//PYQE3SB8UJpK433uVu5bQxBcmndbjMKsyxgFx4aTnj2L6/ufCJ+Z7oCvpiohXNdx5yr0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE8iN0Bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE8iN0Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A9BC4CEE2;
	Sat, 29 Mar 2025 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743265592;
	bh=tEsxrMw9vWVwnA/jXpM4EOEjKZ9Nyga2j1J7QMj/caY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GE8iN0BbD7D8s/mQxOP08hfV7Pao9+CtlBQnWolbLggLxG6Qwp/YZ7KwBQUmfPPZk
	 r9aCJ/lAXWa8iHzg92FUfA47ITWaqD6hV9//zg5pQB0K+gTj7ifLOUjG2yOTx5ZlhQ
	 QyZq+ode/njUJWBDLYJCmYUjd5zhdp+cg9VSHcBX4CS6MDMps9SixL3lk/wGY/P/9U
	 nAaecCyaZQG4vRLXShxcFm28RneMsPritQZAlL1UZxgiV+8e5jUwC1dtNhxLNfvUo6
	 XvT/PvqhQYcsAFjWK/kBcI2P+PJ2kuO+nps66+9RGWQ9PaM27A4++z+8qByleV5W1V
	 BiitNp+w0n5Lw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 29 Mar 2025 17:26:17 +0100
Subject: [PATCH mptcp-next 4/5] mptcp: add MPJoinRejected MIB counter
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250329-mptcp-mpj-reject-v1-4-2396d5666e8f@kernel.org>
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
In-Reply-To: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3301; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tEsxrMw9vWVwnA/jXpM4EOEjKZ9Nyga2j1J7QMj/caY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn6B8zA7vddrpsqr40KQ98ODkA2wziim/r1Fr2F
 ikuG2/BMqiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ+gfMwAKCRD2t4JPQmmg
 c4EpD/4tX5d1nmvrVTiRFBjysRvABDyxZGEJ3B7EoLpjrT1v0CQt9PH4Lru48n+V3/yv+HzYEem
 +IkvNSmekDdaJ2XmbN2lGbAUZbmq+CRPxum9LWatfkbeuBrnDyxR26oVE0jE4ZBG4H2XZ6nnhxS
 qyGFD1c7pwuyqreHlUdq8M/YmwWjNxgHtYTVJ3/8NT6kwShdGwaxhQkE/6akmmg7YA1wmHc/BpG
 JygAU+ItnHy9OVn4jbs0hIHb1fq6XQl8+ux5oSxIim+wc9/EENX4NaUCCWsms2FGicejN4p1jTl
 K+zSq+4Evgf66A0nDAJCGnCoa9QfFE3rHXjJeSpcct1XFnvEQL//iiV9Ccn5XQr6UNiQoJFgh/k
 awVC5peVay2BQQaJfcyAHUr/40VpEJOk3Nkj26rbPvjjNT5FYpFKM+wtvwZ+JELEhf9guX15LdZ
 K/AuZVGCDPrtmabRvbDcx0x0Ch7GL+Wr/pznjluH56Ro/wYrTnSmENKmjAL00svwz/7ccHOXrc7
 yuPH4aSQi6FzhuA3sQU/dGnPdFC4ZdggVbOZSFaalXuuYD0lrJSvuCJOPn5RllbvpA8jdncDwbj
 N7PwGxuIZeq/ob/AXjG0hn4/phr8b82fiBK7uOfRCFS7SdEQ60L1RBJhGJt/l8aG68ompsPhnMa
 VEZXfxfTgj4Fq4w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This counter is useful to understand why some paths are rejected, and
not created as expected.

It is incremented when receiving a connection request, if the PM didn't
allow the creation of new subflows.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/mib.c      | 1 +
 net/mptcp/mib.h      | 1 +
 net/mptcp/protocol.c | 4 +++-
 net/mptcp/subflow.c  | 2 ++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 19eb9292bd6093a760b41f98c1774fd2490c48e3..0c24545f0e8df95b3475bfccc7a2f2ce440f7ad2 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -28,6 +28,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
+	SNMP_MIB_ITEM("MPJoinRejected", MPTCP_MIB_JOINREJECTED),
 	SNMP_MIB_ITEM("MPJoinSynTx", MPTCP_MIB_JOINSYNTX),
 	SNMP_MIB_ITEM("MPJoinSynTxCreatSkErr", MPTCP_MIB_JOINSYNTXCREATSKERR),
 	SNMP_MIB_ITEM("MPJoinSynTxBindErr", MPTCP_MIB_JOINSYNTXBINDERR),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 128282982843a07614a46f9b2c2f7c708306c769..250c6b77977e8f846b5741304f7841a922f51967 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -23,6 +23,7 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
+	MPTCP_MIB_JOINREJECTED,		/* The PM rejected the JOIN request */
 	MPTCP_MIB_JOINSYNTX,		/* Sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXCREATSKERR,	/* Not able to create a socket when sending a SYN + MP_JOIN */
 	MPTCP_MIB_JOINSYNTXBINDERR,	/* Not able to bind() the address when sending a SYN + MP_JOIN */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 9042a86e003036f8eb9680bc6c520fb57d92dbd0..8ba1a4f225bd2014ebdc973e752702028ee5f31a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3527,8 +3527,10 @@ bool mptcp_finish_join(struct sock *ssk)
 		return true;
 	}
 
-	if (!mptcp_pm_allow_new_subflow(msk))
+	if (!mptcp_pm_allow_new_subflow(msk)) {
+		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_JOINREJECTED);
 		goto err_prohibited;
+	}
 
 	/* If we can't acquire msk socket lock here, let the release callback
 	 * handle it
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e7951786a97c91190c7341d2c586a1f4acc05ed5..15613d691bfef6800268ae75b62508736865f44a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -247,6 +247,7 @@ static int subflow_check_req(struct request_sock *req,
 
 		if (unlikely(req->syncookie)) {
 			if (!mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINREJECTED);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
 			}
@@ -902,6 +903,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 			}
 
 			if (!mptcp_can_accept_new_subflow(owner)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINREJECTED);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				goto dispose_child;
 			}

-- 
2.48.1

