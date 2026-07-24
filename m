Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66B439351;
	Fri, 24 Jul 2026 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901760; cv=none; b=Wid44g6LaZS6GP7sTwwVlUOhftHGcJiRWc4nBGCTHqIGLsTtKW73DTkPGGa4C7D6LW/bqxvPAY+vi61PlGLNGRxTWIQBbODk+oUSUYEKfuOzUBinQV7o8y2X2bqXzlk9iBFeo+DzabrAHmdg+XHRd/rSZshgIsk3ymxUXYRrIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901760; c=relaxed/simple;
	bh=++AX/TdTvWwgODLnwbzLSGJMOH0kealvdqqMPU1BGdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTJKha3cICHqjEOIUXSDKz1v1kNa/kV0JIK50NP0U9AZHsyhW+w0lU+H2ZzwZSmGc0OU7tfmjvhJrV1ZgF3PYDVmU3aEIdegZy1LqB6r9XOHbv+Nhtd0iCsJqgmyBbVsNfNN7+/AxtOaQs/MoGKsHn6YyUkA0Mj98sbvV6N339k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8rAVKSH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8rAVKSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748651F00A3D;
	Fri, 24 Jul 2026 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784901758;
	bh=xB/FsxzRoiYwJDzNNomLKMj1scIXpQggJ8ZrpM9x+Gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b8rAVKSHocqGnURnCL2skSbgnMfBVfXso+rh+xSghJfgMPkI8qedD69sg1KoiiwwV
	 NcFEbdmDhBamdeh48KBMsCg0Dlkx30b0tRaAOa9ztZXivA9/ZMK+dsXXIyJaVW7Qe4
	 uLyRtvS86vBv67UgxMbg8FZswFSaUfT+4ywxX0OzwIPuSWHpRCBJxxhyldrrJHaoTE
	 /Ji+0/PjgWuP++2c4urWNSQ3X0jeqDDZlsFnZtsiJ0FtI4a1HOKDvNgFoVb1HkbcII
	 uHOQwCp0thtAPlRAUTV76JqM4HICIH/UakEGqg+LvJlx592BPdGW9+1cp4YpY/v2mz
	 L4ZnPD0lQbKxA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 24 Jul 2026 16:02:13 +0200
Subject: [PATCH net-next 1/5] mptcp: move the retrans loop to a separate
 helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-net-next-mptcp-oooq-pruning-v1-1-5dd4dec63a54@kernel.org>
References: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
In-Reply-To: <20260724-net-next-mptcp-oooq-pruning-v1-0-5dd4dec63a54@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=roDpodaahk2BWLOIYD/W304v8cqk1FmemTEUD9iezUs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLKSC8quFP348ct6me+M875Hvd3mf9reUrsqq5Kz+dyHs
 4m/Y/91dpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkggYjw6WvSqZKr3dvs2Ge
 l35ndmXwrqwJcu4nOHe6LEo+Wb9NO5Phf2jPfu3LR+ISbzZVx9m8W3T25nole4O5KXu8/ac0mhW
 e5gAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

This is a cleanup in order to make the next patch simpler.

No functional change intended.

Tested-by: Gang Yan <yangang@kylinos.cn>
Tested-by: Geliang Tang <geliang@kernel.org>
Acked-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 74 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..290d14e2fa5b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2785,41 +2785,14 @@ static void mptcp_check_fastclose(struct mptcp_sock *msk)
 	sk_error_report(sk);
 }
 
-static void __mptcp_retrans(struct sock *sk)
+/* Retransmit the specified data fragment on all the selected subflows. */
+static int __mptcp_push_retrans(struct sock *sk, struct mptcp_data_frag *dfrag)
 {
 	struct mptcp_sendmsg_info info = { .data_lock_held = true, };
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_data_frag *dfrag;
 	struct sock *ssk;
-	int ret, err;
-	u16 len = 0;
-
-	mptcp_clean_una_wakeup(sk);
-
-	/* first check ssk: need to kick "stale" logic */
-	err = mptcp_sched_get_retrans(msk);
-	dfrag = mptcp_rtx_head(sk);
-	if (!dfrag) {
-		if (mptcp_data_fin_enabled(msk)) {
-			struct inet_connection_sock *icsk = inet_csk(sk);
-
-			WRITE_ONCE(icsk->icsk_retransmits,
-				   icsk->icsk_retransmits + 1);
-			mptcp_set_datafin_timeout(sk);
-			mptcp_send_ack(msk);
-
-			goto reset_timer;
-		}
-
-		if (!mptcp_send_head(sk))
-			goto clear_scheduled;
-
-		goto reset_timer;
-	}
-
-	if (err)
-		goto reset_timer;
+	int ret, len = 0;
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (READ_ONCE(subflow->scheduled)) {
@@ -2847,7 +2820,7 @@ static void __mptcp_retrans(struct sock *sk)
 			    !msk->allow_subflows) {
 				spin_unlock_bh(&msk->fallback_lock);
 				release_sock(ssk);
-				goto clear_scheduled;
+				return -1;
 			}
 
 			while (info.sent < info.limit) {
@@ -2870,6 +2843,45 @@ static void __mptcp_retrans(struct sock *sk)
 			release_sock(ssk);
 		}
 	}
+	return len;
+}
+
+static void __mptcp_retrans(struct sock *sk)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_data_frag *dfrag;
+	int err, len;
+
+	mptcp_clean_una_wakeup(sk);
+
+	/* first check ssk: need to kick "stale" logic */
+	err = mptcp_sched_get_retrans(msk);
+	dfrag = mptcp_rtx_head(sk);
+	if (!dfrag) {
+		if (mptcp_data_fin_enabled(msk)) {
+			struct inet_connection_sock *icsk = inet_csk(sk);
+
+			WRITE_ONCE(icsk->icsk_retransmits,
+				   icsk->icsk_retransmits + 1);
+			mptcp_set_datafin_timeout(sk);
+			mptcp_send_ack(msk);
+
+			goto reset_timer;
+		}
+
+		if (!mptcp_send_head(sk))
+			goto clear_scheduled;
+
+		goto reset_timer;
+	}
+
+	if (err)
+		goto reset_timer;
+
+	len = __mptcp_push_retrans(sk, dfrag);
+	if (len < 0)
+		goto clear_scheduled;
 
 	msk->bytes_retrans += len;
 	dfrag->already_sent = max(dfrag->already_sent, len);

-- 
2.53.0

