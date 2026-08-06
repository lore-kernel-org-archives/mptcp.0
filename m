Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912C341DE1C
	for <mptcp@lists.linux.dev>; Thu,  6 Aug 2026 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005995; cv=none; b=Q8AoFPHllonxZ7hdEBTenA7JjPAlQMVcDtDTK8Xw4KeOz/IZayLi/4iiGy7p5XC2+EjVB7BdIYP6idzvlTTpMQ3TOjtR60ILXkOrBP1VfDMqikJl4m6ZLLWu/5UqoBq6xn9ef1fpuvyYuH6KSZwl4MfHwkrV3KoMVM2vjZG8Ano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005995; c=relaxed/simple;
	bh=5o84nJAOa1lyB4CncDxjP8OMyy/YDj6ib88KoJcwD8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbAHs/qAwh+D1MsE2p6q4iuk1Ot7tj7PbAzGIzkECapY8v5Kr0U0EeSX6zXXMp3yVSWElDAae3XqCxoG2bwTc3Fs2IYBSVg2ybzYBZSWLau8jI0vQxUJqsKkJ1i4ZCpH37VZT5Q8r+MeUXr4+Y4Nqyo68O64W29I0AD6lzMyOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmsxFXKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmsxFXKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9BC1F000E9;
	Thu,  6 Aug 2026 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786005994;
	bh=5wihXWMrCzAKxCwX6jI7IhUlKiVuP/ls/W+qo3xvXWk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FmsxFXKfUw6k6S3vpWyQBjABcFRrwC5Qsanpeu85H2/iVmqCtbcu4iUcqvdDgNg3K
	 U/8uZCqqMRQtbVNLQj8th/+3VUO2kIQPTxFL2IRXUUW1JFtKu+ZmPmIuLlqSHzv7dO
	 Y13JRUTH6r4+yqBS9C7mhH9ksL2IndV7PhXL9CHRY7pXJi29ePNMzsZzPv5nS9SP3j
	 pBEC7nAbY2WdQzIcu0xEbK7VXRDBczGsjG7R0U9gUo/6PuGyV9A10ocNqQFev3Dt5X
	 dB7E3aW8/+5y9SqQ7iwsoBjIP28/58ndqcJyt1ENoKsVdPadw14hG8Ua3t+gr2YQH+
	 QYeM6GcqVfvrQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 06 Aug 2026 10:46:20 +0200
Subject: [PATCH mptcp-net v2 3/6] mptcp: pm: userspace: no ID0 exception
 for RM_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mptcp-pm-userspace-id0-case-v2-3-fea1808e1c57@kernel.org>
References: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
In-Reply-To: <20260806-mptcp-pm-userspace-id0-case-v2-0-fea1808e1c57@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1821; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5o84nJAOa1lyB4CncDxjP8OMyy/YDj6ib88KoJcwD8k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJKPB9tWBr2wUQv/7l4xOuLzr94yh29tkbOzlsVvX/74
 TNqAmtnd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEwkZjIjw7nnE0r/3ZwcYnyx
 TuPF7aUnveY2si1z3hxuKrGoU/DtkyOMDOvZl3b/XRfiu1Rv0eL3V//cfiYZdN9eUU0u6OPj4uO
 SLiwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After the first patch of this series, the initial ID0 address is present
in the local addr list when the connection has been created.

Then, no need to have an exception to delete ID0, this can be done like
with other IDs.

Fixes: 84c531f54ad9 ("mptcp: userspace pm send RM_ADDR for ID 0")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index eaeaf6fe3b58..359ad5acd836 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -260,37 +260,6 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int mptcp_userspace_pm_remove_id_zero_address(struct mptcp_sock *msk)
-{
-	struct mptcp_rm_list list = { .nr = 0 };
-	struct mptcp_subflow_context *subflow;
-	struct sock *sk = (struct sock *)msk;
-	bool has_id_0 = false;
-	int err = -EINVAL;
-
-	lock_sock(sk);
-	mptcp_for_each_subflow(msk, subflow) {
-		if (READ_ONCE(subflow->local_id) == 0) {
-			has_id_0 = true;
-			break;
-		}
-	}
-	if (!has_id_0)
-		goto remove_err;
-
-	list.ids[list.nr++] = 0;
-
-	spin_lock_bh(&msk->pm.lock);
-	mptcp_pm_remove_addr(msk, &list);
-	spin_unlock_bh(&msk->pm.lock);
-
-	err = 0;
-
-remove_err:
-	release_sock(sk);
-	return err;
-}
-
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry)
 {
@@ -332,11 +301,6 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	sk = (struct sock *)msk;
 
-	if (id_val == 0) {
-		err = mptcp_userspace_pm_remove_id_zero_address(msk);
-		goto out;
-	}
-
 	lock_sock(sk);
 
 	spin_lock_bh(&msk->pm.lock);

-- 
2.53.0

