Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AE4185B6A
	for <mptcp@lists.linux.dev>; Mon,  2 Sep 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268160; cv=none; b=s8o0lxCY+Qy82I2M0PjJCZfHITC6D3loMcBbSfgkJyObixkXk5Q3JKFrMWeKmmCoUp1aOYEFrsjFxCbTHFbFXp3S6HuldsGYPlPOuuive5PhZw/yP0Ser49ewGPtmA7qRbAqXk5lSRkP9kxlSe3PO/6n1iIQY2fUwYaYS04V1aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268160; c=relaxed/simple;
	bh=jdg4u2VORfaDlWnAsdaHvp7lNBz21LXVrp23fsRFvrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oi8mYD+hNWJawanya9TS6TY/Qr2+n7gdfLa5KzeU23GrIsAOqWqgSGTq+8oH9JZ1nV9mu3uN0jrXLAuX7utezozp54OTgoFASAHpPVwCl0AL/KjaNgTXr2tJAhcjGmL1LYQyRFu91J1KkjM3btRiDgIysQjuz9SHaYOFS1j8IaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNTYdnBS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNTYdnBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A385C4CEC2;
	Mon,  2 Sep 2024 09:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725268160;
	bh=jdg4u2VORfaDlWnAsdaHvp7lNBz21LXVrp23fsRFvrg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XNTYdnBSrjeI+gNv+a5GJE6i3BpsS1OVNd113lCrTNZAF9WvLtlP6GJoA7Q8H2NH8
	 yw1HpymGtVUFDOKJKSTL1oICq7kXuQuhsLr8mPNaxZPeNU0uTiD80HuN99hhOvWUFY
	 qYLYUkYSC/VhY20i6vgQb5Yu0zbjkkVFSJS6Axnuqtz4uqQ2jSPBDxlMU9P/zj47QY
	 cpoj1km0pFqrxh8PH4V16JV+rwXqFdPhnKUFAyVVvMw0NTrT8elIoQM4T4n33R8HPR
	 Qe7OAMzESkpx1akVwAaRFfuxMWIbZYaW9DCNk9w36Myi1uWWnO5z/nl1Vo9/+qzKt8
	 8Lh9+CIzoGUVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 11:09:08 +0200
Subject: [PATCH mptcp-next 1/3] mptcp: export
 mptcp_subflow_early_fallback()
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-mptcp-fallback-x-mpc-v1-1-86d9170ddff7@kernel.org>
References: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
In-Reply-To: <20240902-mptcp-fallback-x-mpc-v1-0-86d9170ddff7@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1568; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jdg4u2VORfaDlWnAsdaHvp7lNBz21LXVrp23fsRFvrg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1YC+hD3RBKs6KtnkvIzQFq9JKzN3uIAOHIC5I
 RpueEbejamJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWAvgAKCRD2t4JPQmmg
 c8vOEADW59Vvz1vst3YvMssrLYrp7aFXT4OFkZvhmyeVuf9F+vFrrv/Bwj5rcnepG3ouLDOKvPy
 GOOlIzWbZERhVpmRvU+8BtYxA1fP6dCO+dsUZLG/O316P5+eaBq7XJrtHtP2xZRDRBMmJSDjyKM
 /fy3OjD0G2Mzs+8iK/9qrEbDJNzigU4gLMYC1o0UbZfiZSqX7yTIr8fKLZCkgFmrVATZAGS4k2A
 B3CwGltz0H7zaAt3Y75e/Tuyc4fiKzCSVgBzmXhZtlxqr4BxIAWxs4XCGnNBnEge3ndzkVLewQV
 pcZ040Ek+FNyQflGIgSA9sT7cvnbxIodL0g2xbwibcY4DM167av3gMDrtEOSr736y/mqlgaeug5
 uUrISM3EfvL6ja1qzTvUGieqa8bVZRrOCqGfqA7K+VNMrJj0MVtYOkip6DT2P6jzVIzdNujSjG0
 MY9jVXZ06/xOLQjFkCNKWogzP11E509MoKx7XG4smyJ+jfndetMUThAJuVmWoWJrJljCOpaESyE
 S49LYguthT6nvCMdTHmFPUQ3oSNJwMtEq6VJQNIYpogQI1dX6L5UmrPlxon5vtIlSLmX9OtIT7W
 w0p1s/avDWWdgHt8wtf2HOwkNzH8RgZjid69jogKNpFMIWnFE1Y095ltXii+Wkco6DfEbx7Pay5
 Pwag8WhK++iaM0Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This helper will be used outside protocol.h in the following commit.

While at it, also add a 'pr_fallback()' debug print, to help identifying
fallbacks.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 7 -------
 net/mptcp/protocol.h | 8 ++++++++
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7ef59e17d03a..a32f79db235a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3717,13 +3717,6 @@ static int mptcp_ioctl(struct sock *sk, int cmd, int *karg)
 	return 0;
 }
 
-static void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
-					 struct mptcp_subflow_context *subflow)
-{
-	subflow->request_mptcp = 0;
-	__mptcp_do_fallback(msk);
-}
-
 static int mptcp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d25d2dac88a5..633a9bc7a0e7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1220,6 +1220,14 @@ static inline void mptcp_do_fallback(struct sock *ssk)
 
 #define pr_fallback(a) pr_debug("%s:fallback to TCP (msk=%p)\n", __func__, a)
 
+static inline void mptcp_subflow_early_fallback(struct mptcp_sock *msk,
+						struct mptcp_subflow_context *subflow)
+{
+	pr_fallback(msk);
+	subflow->request_mptcp = 0;
+	__mptcp_do_fallback(msk);
+}
+
 static inline bool mptcp_check_infinite_map(struct sk_buff *skb)
 {
 	struct mptcp_ext *mpext;

-- 
2.45.2

