Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACAF48594E
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043024; cv=none; b=a8y70w4UbizCSgkdMqv6Vxkz+FZHX7h86Xlrq424iI3+rVAt/pV10diKPP4myUZuvB/yndkxGDkermL1DHT9/Z9lZwL9qxzj5voJQGNho3XydzQ8x9OFJAbDnJGMUfv7MUYz5YhJo0YCn4W1r4hW5hjB1GGFxUVKD4f9duosLoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043024; c=relaxed/simple;
	bh=CItdKaDD0ktuE1k02O1ylGOC8Quggq20kw6fEqMd9Ik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+lI2QCl9DZcnprImhCYec3hJ/6WM3dw7qzZ0PmKI76WkK78MmuHGOZNYY1t4kgTyabv9u6YXKvpQohbSuumoTbk86Doqcl/c1BMtpCGllpCmbaYR4zNO22fBZFM1rOzlgvR7Xv0PHILYqvHTnyXBxQWsydKnrnspTxWC5WjUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLL6TqoJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLL6TqoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E08BC2BCF5
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789043023;
	bh=CItdKaDD0ktuE1k02O1ylGOC8Quggq20kw6fEqMd9Ik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FLL6TqoJXRjhH8LwMT7wpXx85BCoRlqtTQuZWbEMYjbEz/ywhoNXIA6WJoCheEpF6
	 OHxw4RQNkCzV2d5OyEuTZmEV9A9ZQHpDKwHQm6k+eWBAwvmnXG9RQwuK2I7ksubsfE
	 bi6gNBxoYQipSYQm0ROtJdwlfGGgRMWJ2MP+CUFYJCMxvXWu7/x5NAOzXIw/vpvhiu
	 Yvi7wRO6QsH0Lq+TH7IKCP2EZhbdvTZorTFAwGWJIW2N36BlaqCi/uBGK+NNDNLZ9M
	 teK9YlL2vRsHZVtQ6W8Vh8kxMTR/AQIqZr9SRUd/HscqztjXNnBpthIn+3CidqFZp5
	 JI2Gl16d0rrGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F4C79F9F
	for <mptcp@lists.linux.dev>; Thu, 10 Sep 2026 12:23:43 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Thu, 10 Sep 2026 20:23:33 +0800
Subject: [PATCH mptcp-net 1/2] mptcp: reset msk state on early connect
 failure
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-mptcp-connect-undo-net-v1-1-446e4a4ae3e7@proton.me>
References: <20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me>
In-Reply-To: <20260910-mptcp-connect-undo-net-v1-0-446e4a4ae3e7@proton.me>
To: mptcp@lists.linux.dev
Cc: 
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789043021; l=2066;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=vjSZbBARSjNtpftevI+lTUhTZMMym6vvPVQ1xF8WwG0=;
 b=mAJthT8d2QlMsuYYE1D0kHdtVaNQnAGhiqReRtXoDvCEGljBB1ABTCSd8ydYUp6lw4VcSCD7Y
 zmfWp9CQu0OCg10Iy44VcqLpbGyS/4BegyGeI+o1N5EcDaTxe5YgHCI
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
 net/mptcp/protocol.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e1f08f71cdb1..ad476d29bf3d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4129,6 +4129,24 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 	return 0;
 }
 
+static void mptcp_connect_undo(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct sock *ssk = msk->first;
+
+	mptcp_token_destroy(msk);
+	mptcp_set_state(sk, TCP_CLOSE);
+
+	spin_lock_bh(&msk->fallback_lock);
+	msk->allow_subflows = true;
+	msk->allow_infinite_fallback = true;
+	clear_bit(MPTCP_FALLBACK_DONE, &msk->flags);
+	spin_unlock_bh(&msk->fallback_lock);
+
+	if (ssk)
+		mptcp_subflow_ctx_reset(mptcp_subflow_ctx(ssk));
+}
+
 static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 			 int addr_len)
 {
@@ -4197,9 +4215,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	 * subflow_finish_connect()
 	 */
 	if (unlikely(err)) {
-		/* avoid leaving a dangling token in an unconnected socket */
-		mptcp_token_destroy(msk);
-		mptcp_set_state(sk, TCP_CLOSE);
+		mptcp_connect_undo(sk);
 		return err;
 	}
 

-- 
2.55.0


