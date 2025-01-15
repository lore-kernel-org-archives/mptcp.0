Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A30622F853
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924515; cv=none; b=a4e1j7M4NOpy3D4RFb842P3jIezhKRnzMFX6/MySl5Ko6UBaghdU0alVbdS78TQR9H9KCPiy6cvvyWBzNmp7zSo1r8SREBxR1ZN6ayLF32WCgx6zb21Rzx1HOwzZxO+ptj78PWTQnAi/5MYufaOGvSnjM8DN3njDsbC3a+FiCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924515; c=relaxed/simple;
	bh=Xw3wlccCqpdwPt88Y4SCvZLPmSfjOGk3ELg4WNOmO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDEGemgQY5I/w+cfTaWKe79B4+G9Eau2XsnfTOr87IZ0axFMfoBtQCUIhBtVp0DegqyI5UUUWCJ14A/ZqcWBFhY5D7LBMrE/P6i+dO4iuwKMgGA9jE4OakR5Wa9IXVSR7jpRHrfqE2w6LCoZgSC3Oh7q/B1CHqkMIYQSUuFWi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at6sKBNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at6sKBNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99207C4CEE3;
	Wed, 15 Jan 2025 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736924514;
	bh=Xw3wlccCqpdwPt88Y4SCvZLPmSfjOGk3ELg4WNOmO6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=at6sKBNlq/LO6Zx8m1rffyiVp6LEkCde1kWtEmSlJPCHVgNRgyjoF68jRZW8vGA1i
	 DcmwCToEWMNzGGwj0eDnwuwOibiNSy1Qc81k/nAs8hTvavheAGNQbctGWcpNgad9bB
	 6zvEtGFgYvGJt76PA4TNdQQtoha7qmfWyHU93vHFtR0cCq8CVbW9EcwG3SpJgDOTy0
	 fX5+VNRoJlmPVtGb9tfMwmvwZW980PNBcut0wGxPWaUTsKh84qrAo840VDocb3lYWO
	 Fk+6ihM5i5hw3bDsF4efHxs79v642KG11AiBB6XciCWV8gtnA5qI52HLDD6/eDDOmC
	 +t6nIHSflBrSw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/7] mptcp: drop match in userspace_pm_append_new_local_addr
Date: Wed, 15 Jan 2025 15:01:37 +0800
Message-ID: <7cef5a603af13cace6b8acd466320a10f9cf6349.1736924314.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736924314.git.tanggeliang@kylinos.cn>
References: <cover.1736924314.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The variable 'match' in mptcp_userspace_pm_append_new_local_addr() is a
redundant one, and this patch drops it.

No need to define 'match' as 'struct mptcp_pm_addr_entry *' type. In this
function, it's only used to check whether it's NULL. It can be defined as
a Boolean one.

Also other variables 'addr_match' and 'id_match' make 'match' a redundant
one, which can be replaced by directly checking 'addr_match && id_match'.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index de17b18b78fe..7075c7f7229f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -48,7 +48,6 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 						    bool needs_id)
 {
 	struct mptcp_pm_addr_id_bitmap id_bitmap;
-	struct mptcp_pm_addr_entry *match = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
@@ -63,16 +62,12 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		if (addr_match && entry->addr.id == 0 && needs_id)
 			entry->addr.id = e->addr.id;
 		id_match = (e->addr.id == entry->addr.id);
-		if (addr_match && id_match) {
-			match = e;
+		if (addr_match || id_match)
 			break;
-		} else if (addr_match || id_match) {
-			break;
-		}
 		__set_bit(e->addr.id, id_bitmap.map);
 	}
 
-	if (!match && !addr_match && !id_match) {
+	if (!addr_match && !id_match) {
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -90,7 +85,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-	} else if (match) {
+	} else if (addr_match && id_match) {
 		ret = entry->addr.id;
 	}
 
-- 
2.43.0

