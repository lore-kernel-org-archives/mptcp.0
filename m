Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2D199EAD
	for <mptcp@lists.linux.dev>; Thu,  7 Aug 2025 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589656; cv=none; b=MScxIYIYaiY2CSACGEg0m1Nq2pwTZtA6O3cW4r60/byb0l839XUGF+qeVhVe5zHGBKD4f15SNWiScka58SvpYnkN2n7HpztJWACQdETqZQuh2V0TC1UcZLTo0r7CRyLOX6o1cpUDF144c4SoOaTmk7WnN7/QZOSXumPRnNU07n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589656; c=relaxed/simple;
	bh=qq8/7k5VNb8u6FI2ZGGprys4sRi/CPgeVm9GiMjefxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hO2ssqfQn/qIVTY252xb5rGfjWQ6lKyr3Ia+62LKcmauV5qYsyVPRbtjuf9XzYQ+jwRz2XItvvpzQVg31ZLiQump/cy577hnIUZmN1dbJAz8yjj6JS45u9k/tcqBkiCyGB15CvR93jzx5jjU7FAf/eeP+zqTyqIwUpMYVLZRl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJo0aG6/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJo0aG6/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E0EAC4CEEB;
	Thu,  7 Aug 2025 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754589656;
	bh=qq8/7k5VNb8u6FI2ZGGprys4sRi/CPgeVm9GiMjefxA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=nJo0aG6/7VpW1gWAkg4LxJwNTJqPOX79jv4u5SmyBBJ3fmlemqpMeg5QQmUuDsov+
	 dPXm/4Q4y7CoQ3W4juSwVJfp6Vb4C41bjW4o3DWTGFgVv7bDbBmVVjM6o/3UfnEZql
	 EwRGPFkg6+5Z867bUxMKz7XwYixbT0J1cWUfYbM1zdhVuch2tTW+HzIySNdPczaY8M
	 Upsj9x1AQA0GwUwN1lTUwDGpBeLWnia4WLUiVmGuGx846892vCYjuExr0gibYTG8Y9
	 840Vkwm2p2ezr+tmlvuP9zjeaN9eXUF1qi86tjm75ni1Epp0nYkPNApU54AqaZFV3M
	 T0c5pXoKR2j5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF5DC87FD2;
	Thu,  7 Aug 2025 18:00:56 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Date: Thu, 07 Aug 2025 11:00:43 -0700
Subject: [PATCH mptcp-net] mptcp: drop skb if MPTCP skb extension
 allocation fails
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-mptcp_fixes-v1-1-adfd79a88b5e@openai.com>
X-B4-Tracking: v=1; b=H4sIAMrplGgC/x2LQQqAIBAAvyJ7TjBLkr4SEaFr7SETjQjEvyceh
 5nJkDASJphZhogvJbp9hb5jYM7dH8jJVgYppBJaKH6Fx4TN0YeJWzuhGJXUbpBQjxCxiTos0EL
 u8YG1lB/ElEvRaAAAAA==
X-Change-ID: 20250805-mptcp_fixes-dd7e04528f32
To: MPTCP Upstream <mptcp@lists.linux.dev>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
Cc: Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754589655; l=2141;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=cDu7fm+K+qrA4QGkMHR4UGKNLCJ4l1vGPJHGz1BXj7Q=;
 b=3IVigu2/vvnoS3I1uCE6On7M7tERMd7/bqlrx5kIQ0TNLhuAGZSONyadaxBt+kZIF8qwD3vtT
 B18jy5Mr60cCNomt+Mr3i12HPPZ49mPxkZCdba9KpeJ9BK72bfDqaAc
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

From: Christoph Paasch <cpaasch@openai.com>

When skb_ext_add(skb, SKB_EXT_MPTCP) fails in mptcp_incoming_options(),
we used to return true, letting the segment proceed through the TCP
receive path without a DSS mapping. Such segments can leave inconsistent
mapping state and trigger a mid-stream fallback to TCP, which in testing
collapsed (by artificially forcing failures in skb_ext_add) throughput
to zero.

Return false instead so the TCP input path drops the skb (see
tcp_data_queue() and step-7 processing). This is the safer choice
under memory pressure: it preserves MPTCP correctness and provides
backpressure to the sender.

Control packets remain unaffected: ACK updates and DATA_FIN handling
happen before attempting the extension allocation, and tcp_reset()
continues to ignore the return value.

With this change, MPTCP continues to work at high throughput if we
artificially inject failures into skb_ext_add.

Fixes: 6787b7e350d3 ("mptcp: avoid processing packet if a subflow reset")
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3c08beffbfea13597f14df17b1636b154e471398..d47b8a9bc2df2f14645b1b3d3e10fea1b38567b1 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1119,7 +1119,9 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false if a subflow has been reset, else return true */
+/* Return false in case of error (or subflow has been reset),
+ * else return true.
+ */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -1223,7 +1225,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
-		return true;
+		return false;
 
 	memset(mpext, 0, sizeof(*mpext));
 

---
base-commit: dc818e7d153ed5ff81b9fcec7baa3b4b78725f89
change-id: 20250805-mptcp_fixes-dd7e04528f32

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>


