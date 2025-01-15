Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0291DB14D
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935189; cv=none; b=d+hOxT+cof4wOerRrzC+PXq7M5iEvZYJ8tbfE3v07KXGitDhfOTLYb3a7hO36gXE4iik6XOphspvB+k2FCkzh9XX/0s+z8qFje+zcpnV72q1XzIWUllo5CtyTcWzZ9R0YptzwBGkREMvaEwpTu1DaKrhpNYevIPB2AslClrV/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935189; c=relaxed/simple;
	bh=Xw3wlccCqpdwPt88Y4SCvZLPmSfjOGk3ELg4WNOmO6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aE22VurDPIh2WoFQl5anpSKXs26U1pgVCCs3eJzOKbEvIHDuGtkkdh5z0zkIzqgjCUpW0945jI+sAfoCejPpADTgyHkh07wO/4XgaVvdvnFB6IEP0xeIys7VtWV2W/SYJzFBZM1l05uxyxFDr9tB80zgKBEGtAbAVLS4s87HsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H38y3MaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H38y3MaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0676C4CEDF;
	Wed, 15 Jan 2025 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736935188;
	bh=Xw3wlccCqpdwPt88Y4SCvZLPmSfjOGk3ELg4WNOmO6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H38y3MaE/4wI2A5STwdupVKZV3tLVENWxb20PKFd+ycM3atU6KoFiAAmOuobfOs3i
	 8xFL0nkCmi9XqqizdECqoo/SZ9qxBB05tehdhR1CvL10YFiJRvUsN+1LU+dKRy1lVw
	 mFm/YrKgJj7I9/L/5KT3fK74YawpH09pRy9kQswjTEQhmb5Pzwe1ALsmpLf1sMB1P5
	 xL3ucpXTNbBYHV7P+5y6BX5+L2eCPAbQx/6bSS6uMGLzy9pDN7LlxHIUOjfiUkw0bb
	 KB9XIcC25jQgDR5ejWBoCnZfqrilCPkYARaBh+Y4xV7ZGlnbrApEOCFOKmqOU5DpRP
	 f+jfjea305UVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/6] mptcp: drop match in userspace_pm_append_new_local_addr
Date: Wed, 15 Jan 2025 17:59:30 +0800
Message-ID: <d328b55d2d081880820cf65be5bc5edd4aaeb2d1.1736935086.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736935086.git.tanggeliang@kylinos.cn>
References: <cover.1736935086.git.tanggeliang@kylinos.cn>
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

