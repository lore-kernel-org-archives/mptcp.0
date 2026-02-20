Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEACD32FA1B
	for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 11:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771586763; cv=none; b=JONQH5jBv03MHntgqwldXCEtsuZAJRIbrM4Z0s8HvwbMjlCC1iIoQAKeHSSlaWR4QIQXAhNDBiXsXCerTYGKpvBDQNP9bETVunmGSbyGp9BS4RHca2bGJfkkgXqfzsn9uTTuDiOG7REuHtxaeK2M61Ptc2gaHiwH0vm7p/s8ZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771586763; c=relaxed/simple;
	bh=1s2cb4OZKRQpmugLeWzPD2pp5/O6/J+IgRSyDn4fk54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJlfQcEAIhWcFrKPHcc0KHFeJjcVkCFA6HFReHzokx8w92hVjEHTcAFJqI3cS/iPtzWOKFg4qtm8G77avH9hHEmSk/zuYhtgo1IG9eBauE6y9Nc85ngv9ENpuLfubyP7ArvQ6SnIRFu8ooYI0WSTIr5pVLAwluFRy0YGVeulkTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+wM7s3P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+wM7s3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DE5C19425;
	Fri, 20 Feb 2026 11:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771586763;
	bh=1s2cb4OZKRQpmugLeWzPD2pp5/O6/J+IgRSyDn4fk54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F+wM7s3PbTMKGawIWZ7yJqbnj/4gs7XyFZ9MY0Ll41XYuZI263vKgzb8L3gT8zitN
	 KgnWuG9uXgwUpHNmLmogpM8dd+QeCnitQye1xZ2UnooMObiVZB7xlbCyDMrb2n7myk
	 zBB8QvGW8YbN+lbeo28TDBaSbdUzNnGTyHJzg5WpiA8t40fnM8Jruk58A5y21JzT0q
	 HYG2Og7tZdHdPQTzsfOzvot1+xKZwGFXx4dUFqAEto+MCPnL9KYxBPMkoPRZzyaW62
	 cCGHxfP1y+ibUxPX7IpLHmAh8fUL4J9QXdaC/vA8foGew85Qec1Xdb5IxdqIifk1ky
	 5dy71uBQvHdlg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 20 Feb 2026 12:25:51 +0100
Subject: [PATCH mptcp-net v2 1/2] mptcp: pm: avoid sending RM_ADDR over
 same subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-mptcp-issue-612-v2-1-089684a6edcb@kernel.org>
References: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
In-Reply-To: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3761; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1s2cb4OZKRQpmugLeWzPD2pp5/O6/J+IgRSyDn4fk54=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJnuJy4qn14Fb8046S8/1Z5kVpGgRpRTG/ulj0tdvc5k
 7Xgp/S2jlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIk0fGFk2HCzKPCH/qvUqCVh
 L+reiUqy+X1OjTphM9M3fMpp78uLIhkZDnjUJ8ZWzZSfsrylLSb4rfq3ZX33znkyrClrLZfZbKH
 HAQA=
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
Note: in my initial version, I only used one alternative for both
"stale" and "same id" subflows. I guess it is better to send over the
same subflow than a stale one, hence the priority, but there are then a
few more lines of code (but still readable, I think). To be discussed.

v2:
 - reduce one indentation level and s/rlist/rm_list/g
---
 net/mptcp/pm.c | 55 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8206b0fd2377..daef91e597ae 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -212,9 +212,24 @@ void mptcp_pm_send_ack(struct mptcp_sock *msk,
 	spin_lock_bh(&msk->pm.lock);
 }
 
-void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
+static bool subflow_in_rm_list(const struct mptcp_subflow_context *subflow,
+			       const struct mptcp_rm_list *rm_list)
 {
-	struct mptcp_subflow_context *subflow, *alt = NULL;
+	u8 i, id = subflow_get_local_id(subflow);
+
+	for (i = 0; i < rm_list->nr; i++) {
+		if (rm_list->ids[i] == id)
+			return true;
+	}
+
+	return false;
+}
+
+static void
+mptcp_pm_addr_send_ack_avoid_list(struct mptcp_sock *msk,
+				  const struct mptcp_rm_list *rm_list)
+{
+	struct mptcp_subflow_context *subflow, *stale = NULL, *same_id = NULL;
 
 	msk_owned_by_me(msk);
 	lockdep_assert_held(&msk->pm.lock);
@@ -224,19 +239,35 @@ void mptcp_pm_addr_send_ack(struct mptcp_sock *msk)
 		return;
 
 	mptcp_for_each_subflow(msk, subflow) {
-		if (__mptcp_subflow_active(subflow)) {
-			if (!subflow->stale) {
-				mptcp_pm_send_ack(msk, subflow, false, false);
-				return;
-			}
+		if (!__mptcp_subflow_active(subflow))
+			continue;
 
-			if (!alt)
-				alt = subflow;
+		if (unlikely(subflow->stale)) {
+			if (!stale)
+				stale = subflow;
+		} else if (unlikely(rm_list &&
+				    subflow_in_rm_list(subflow, rm_list))) {
+			if (!same_id)
+				same_id = subflow;
+		} else {
+			goto send_ack;
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
@@ -470,7 +501,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 	msk->pm.rm_list_tx = *rm_list;
 	rm_addr |= BIT(MPTCP_RM_ADDR_SIGNAL);
 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
-	mptcp_pm_addr_send_ack(msk);
+	mptcp_pm_addr_send_ack_avoid_list(msk, rm_list);
 	return 0;
 }
 

-- 
2.51.0

