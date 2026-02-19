Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3282FD1B5
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 19:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527685; cv=none; b=pOTQxdBckZe71H7a9bdmuM1NkUGlpDnI7vndZAqxAC7vy7htGynHE20kZBsEIFjSu+KMzefJNq17X0SfUD/P7qps32x8RY8Du2XRcEkrhR5DN8e7fIlyaVaREnfBmbloh5CPcKQYmEE5S9+5EsXpyrtN+ZcXFlQrU2BOidW47t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527685; c=relaxed/simple;
	bh=hXkpzOAsI8ahswmWVSOhZgo29h15Cs4ZnmIuuBhdf0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/Fgd9u+Eq+FWS8xKUFw7MLj0JsamNTC6UMSRD625fUvcWkwqblXTn/0VjS6iYbz6noZENQVZbb47EzjbMM7HnyITVk3BE6wZdBFfSluLPaMXugcRhQyt0VJ7C+6iH9g8HceneJ6oWVwXLpGAaygc9TPBlbu72I0yCPqY57BCuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0PfcPva; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0PfcPva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93895C116D0;
	Thu, 19 Feb 2026 19:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771527685;
	bh=hXkpzOAsI8ahswmWVSOhZgo29h15Cs4ZnmIuuBhdf0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q0PfcPvaU8T48KvGiIrwYu9DXxLW7iGg1cKC9ZCUvUoWmL3oEF7FGrLvuIeiLQvPY
	 SUE+Bdn/6ZPfNgrOZALXCvrZaW+FteiuAME28FD+R7CJjiD3WYeCLMp9PnFPjwUVjU
	 5hvjd9Z0bol8EXTgEe6yHaM24oCradxaPFIcPOzSB39msjsNaeA8aUNxUFVuAQBVI5
	 eLWCl3ZM6yW1mQuaS/xNbKKV5KrIFHKWc220Kpk0S2bwUEsLVXv/zuRSWuKe+HoTc9
	 /fnInaV6ely9+mBLSKfZovWP/mS7I3GGiFlzEDP5xT9dS2wDHwngBJ9mv3XngOOX2Y
	 ejby9O6OZC7lA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Feb 2026 20:01:15 +0100
Subject: [PATCH mptcp-net 1/2] mptcp: pm: avoid sending RM_ADDR over same
 subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-mptcp-issue-612-v1-1-839e20d96fe7@kernel.org>
References: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
In-Reply-To: <20260219-mptcp-issue-612-v1-0-839e20d96fe7@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3330; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hXkpzOAsI8ahswmWVSOhZgo29h15Cs4ZnmIuuBhdf0E=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKnxzHdCt7/YMcMqeVftXkkznrK6he1tp6+cFfx0XP71
 +0l/e0XO0pZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZy/BIjw0zn+dLX7k43Z3qU
 JLTg0bKpfg3NgvK9B0+tE86XzOTaqcfwP+7juskHN0ev2Lm12P6dmE/+Lub0CZJ+r2/oRWa1tGy
 JYAAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

RM_ADDR are sent over an active subflow, the first one in the subflows
list. There is then a high chance the initial subflow is picked. With
the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
linked subflows are closed. This is done for each active MPTCP
connection.

MPTCP endpoints are likely removed because the attached network is no
longer available or usable. In this case, it is better to avoid sending
this RM_ADDR over the subflow that is going to be removed, but prefer
sending it over another active and non stale subflow, if any.

This modification avoids situations where the other end is not notified
when a subflow is no longer usable: typically when the endpoint linked
to the initial subflow is removed, especially on the server side.

Fixes: 8dd5efb1f91b ("mptcp: send ack for rm_addr")
Reported-by: Frank Lorenz
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/612
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 52 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8206b0fd2377..ef76fbc40915 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -212,9 +212,24 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 }
 
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+static bool subflow_in_rlist(const struct mptcp_subflow_context *subflow,
+			     const struct mptcp_rm_list *rlist)
 {
-	struct mptcp_subflow_context *subflow, *alt = NULL;
+	u8 i, id = subflow_get_local_id(subflow);
+
+	for (i = 0; i < rlist->nr; i++) {
+		if (rlist->ids[i] == id)
+			return true;
+	}
+
+	return false;
+}
+
+static void
+mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
+				  const struct mptcp_rm_list *rlist)
+{
+	struct mptcp_subflow_context *subflow, *stale = NULL, *same_id = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -225,18 +240,33 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 
 	mptcp_for_each_subflow(msk, subflow) {
 		if (__mptcp_subflow_active(subflow)) {
-			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
+			if (unlikely(subflow->stale)) {
+				if (!stale)
+					stale = subflow;
+			} else if (unlikely(rlist &&
+					    subflow_in_rlist(subflow, rlist))) {
+				if (!same_id)
+					same_id = subflow;
+			} else {
+				goto send_ack;
 			}
-
-			if (!alt)
-				alt = subflow;
 		}
 	}
 
-	if (alt)
-		mptcp_pm_send_ack(msk, alt, false, false);
+	if (same_id)
+		subflow = same_id;
+	else if (stale)
+		subflow = stale;
+	else
+		return;
+
+send_ack:
+	mptcp_pm_send_ack(msk, subflow, false, false);
+}
+
+void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+{
+	mptcp_pm_addr_send_ack_avoid_list(msk, NULL);
 }
 
 int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
@@ -470,7 +500,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 

-- 
2.51.0

