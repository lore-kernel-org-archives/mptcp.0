Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB961EF19
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764767; cv=none; b=dIhQo/Dz+STr57NfZvg8sNU+jsPMWamumLlNSGz74oNF+TjgwcDqDhxdKjrMSsn+2L+Kr/3xSbDFO1Khxa7/nRPbfpk+dwiIc7hlCNlhyOQdBHl/Z0hJNNAzqf1OjMx0m0QC9WF6m1QkPVgyYQ18GvxVYQ4gUpQf2vSDUEIoRRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764767; c=relaxed/simple;
	bh=qhnsgTotynodog63UQDsox5gGlqOKP33buOWIsDreHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJiBx4EyIb/j0w/Q7X2AoWOxjxUvTgkvqUgSAbkaMH1Ret/MipH2dLCUCuJGTecN3oYd2dFaIsFH5wnDnXcg6SVK2MnQmKC+LerEPsJUoJA6nnvOmNM8mFnoEYGOU1iq4eICkbRGz3jYn/6xTPvmOdS2IirE0XBRS3XPBVDHSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzGqU7Fh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzGqU7Fh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8D4C433F1;
	Thu,  1 Feb 2024 05:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764767;
	bh=qhnsgTotynodog63UQDsox5gGlqOKP33buOWIsDreHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jzGqU7FhR2A8q4RKCzMQp91ktAGKEmLP0PkrEPlTzDIaPR60ruzCLBspNHz7vgt7M
	 EX62g2zmylyGuLV4rWT+Lz5rmwTQlsJ8X2/T4pUbwcKNk9XWuiFp2YS/4qxGdFXTpM
	 OHJowyYCfdsu9e4NKlXhWqFNe+MtHGOryR1z70gg52mmta5lGrtUEFH6DeuY1DQU3R
	 OW5tp7vrW7Um034L9dpgaJ/7U/+dsMAbjJT4vSQKwvUG6tRk9i0VlYaNxocyW34EYE
	 rfyH36uTd2dnDejGSLMXA1VrnEYrBhP9zzPHmRTw+lXoPYK/5fP6mk/cPfrihC+Q0B
	 QLwZ7ePaK7qtg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 11/15] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Thu,  1 Feb 2024 13:19:01 +0800
Message-Id: <1e4bf8b514351aefabe722f29a392f72245589e5.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 53fa19755b1e..ca3bf83674b6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -106,19 +106,26 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -261,7 +268,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -298,13 +305,7 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.40.1

