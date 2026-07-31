Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1742DFF5;
	Fri, 31 Jul 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507888; cv=none; b=aiDr3jN5rMBvcPGX9kWClVBRppiPzIZIzlw7EcAw2m5esLTdCIVOb47teOEih0zNYdhCpFNBVdtviIcxzP+if17VnfseMNsTjSHeo6nZ/E1n6IPK6R6bSkA/C5bWuxQtU849xWBLB5V0dBlYafxXcQqvBkM910sLO75ROP0QiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507888; c=relaxed/simple;
	bh=++AX/TdTvWwgODLnwbzLSGJMOH0kealvdqqMPU1BGdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eiQRQsGOxDWOirYSOsHQz2/RtbyuIetEIjn+27ybQRdXf5lLiVYGm1B2LwO8uAIKd/cGSEQc3Pfb0uki9YmCzCTQYyrj+z+z8WLBS9doehVnFFsYvEiY8Vv7Odj4xRpdBiaGzgvxb6Feh6A1VGg5a57eRHkHXZ3BiZCQNFy69LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd6Obkvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd6Obkvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080681F00A3D;
	Fri, 31 Jul 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507887;
	bh=xB/FsxzRoiYwJDzNNomLKMj1scIXpQggJ8ZrpM9x+Gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zd6ObkvjqwR7iNosNxMCeMXkRw2qzeXfgGxKyd1U5XAN3o7Ty+UBEw+k3khc3SzUl
	 0vzqq2R/fNlwoY7pyd4LiYK1rmrxjpQXPclLebPieuMe1GT5d04mlDnF9iK4T3/syp
	 tF3VvjiDM8N/t0QZxR5jNE8nmD1bIHJyrNJUzuYWAFri1E55rL8Dfi/ZZ6FxUc0ZQI
	 +Y/1iuPr3eQyBXUg2C8iw92pXLrBs21inpbrDRdgTkk1zRjcoRMAL0RZyT3J0neAPC
	 vZt+lOWrJKSg6At3Y0pAu8C2rdSDcRT4EzaVhZos7iPZ5VrLjArE2SuShJTPtqNIoL
	 3KKvoCDFAfX3A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 31 Jul 2026 16:24:17 +0200
Subject: [PATCH net-next v2 1/5] mptcp: move the retrans loop to a separate
 helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-net-next-mptcp-oooq-pruning-v2-1-24838164fa21@kernel.org>
References: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
In-Reply-To: <20260731-net-next-mptcp-oooq-pruning-v2-0-24838164fa21@kernel.org>
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
 b=kA0DAAoWfCLwwvNHCpcByyZiAGpssCWgKNYOcIcDXYN0na3GKZb0dvBKW0b7LCNTi4Fxgfm9Z
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmpssCUACgkQfCLwwvNHCpcdNAD/Y+uL
 57sS01MmVuLomjx7LP4T5ZJMS8ZYYUN7DLeD0iABAJiVsoy6Qfzs8nInLXkAHY80sqZgSS38ZEU
 DYcXxIrwD
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

