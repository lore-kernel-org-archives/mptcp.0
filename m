Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5798F4F
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558333; cv=none; b=MbTVEgEindjgd8xGZa8/oirjOusVNThth5tmDREB0IlTm9EcknB9YEXduqW1TeB2Ed8HKWKz57/De//r1pOlaAJBagkV2LS6C2Bd4sgsVLdFM+AFyHoCffLDGD7Xz7AvsAbo2pKIMhoHGirnp8QjvtQqR/KIRefV88j2ZnVnnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558333; c=relaxed/simple;
	bh=D2GzIVrh4Im2X+tPCjz233MT623AzRSIbh7TFww4deg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Q5wOEnF32PWSyel4hGwEIZbnDweEMX3eVqIDiUZmd/7aL06CzXeUUwfgfW24EYqdRBySEIY4F9ZXBQcreQkVUExlW/ykFZU89TVVc16GuWGym8LqIC2OWW77JtPmxB8aq5yxmJIXgX2uCQngAmDCijCdF2x8KgNoZaz2sROrR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilws5T0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilws5T0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F06C433B1;
	Thu, 18 Jan 2024 06:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558332;
	bh=D2GzIVrh4Im2X+tPCjz233MT623AzRSIbh7TFww4deg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ilws5T0sYJBqYHExZJDehOD4zMUu67Q9WSIdeoxJCFbXG4QhsHavBz0n3J0jWLGKo
	 RgC0oLYcrZKOH105DmwsoqWhEiI1W7W1qebh2epls8hvDiIErGnsoRadvhj+uz5iAd
	 5+Y4KyPek1sTi89r2BGIX7RpFFG7CUrtemLHCw/MQSPFUuIlIVNtf+nsZDXGfrR4jh
	 5mIzXskNdNzPhA7RE6KsuS47UUk5w82xbO7BWf+aATZilMOnXUYXmtwoYkiT2/icXf
	 BcNiiCA6aBET2AhQJJcuGznwEhOaj2wk/245QGLXHNijtozoCMlS60svCkisFbT2kE
	 7330uh5ZRZd4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 03/23] mptcp: add needs_id for netlink appending addr
Date: Thu, 18 Jan 2024 14:11:43 +0800
Message-Id: <be3463f397dc050c6a11cbdf6a281dccff9b0642.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just the same as userspace PM, a new parameter needs_id is added for
in-kernel PM mptcp_pm_nl_append_new_local_addr() too.

In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
needs_it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_netlink.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 287a60381eae..d158bfab1abc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -901,7 +901,8 @@ static void __mptcp_pm_release_addr_entry(struct mptcp_pm_addr_entry *entry)
 }
 
 static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
-					     struct mptcp_pm_addr_entry *entry)
+					     struct mptcp_pm_addr_entry *entry,
+					     bool needs_id)
 {
 	struct mptcp_pm_addr_entry *cur, *del_entry = NULL;
 	unsigned int addr_max;
@@ -949,7 +950,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id) {
+	if (!entry->addr.id && needs_id) {
 find_next:
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MPTCP_PM_MAX_ADDR_ID + 1,
@@ -960,7 +961,7 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		}
 	}
 
-	if (!entry->addr.id)
+	if (!entry->addr.id && needs_id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
@@ -1092,7 +1093,7 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct mptcp_addr_info *skc
 	entry->ifindex = 0;
 	entry->flags = MPTCP_PM_ADDR_FLAG_IMPLICIT;
 	entry->lsk = NULL;
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry, true);
 	if (ret < 0)
 		kfree(entry);
 
@@ -1326,7 +1327,8 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 			goto out_free;
 		}
 	}
-	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry);
+	ret = mptcp_pm_nl_append_new_local_addr(pernet, entry,
+						!mptcp_pm_has_addr_attr_id(attr, info));
 	if (ret < 0) {
 		GENL_SET_ERR_MSG_FMT(info, "too many addresses or duplicate one: %d", ret);
 		goto out_free;
-- 
2.40.1

