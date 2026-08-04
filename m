Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C268937E308
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810261; cv=none; b=fuLbMn6KUqeFoJ6/lYz6rZSRNx0bx48Z6R3JssHizNSoULhPz4qCYqQo7Ls+EDGCNC0QhYs/TjCS1ZPWAIroVR5ssJYYbRfXDKPKkMm+h0A1+JslkZ+ddgGpFRQkI4M6fvu5JO3ljkkJ58xWIiIn2rqadHpSY2iaOsH/FDdlEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810261; c=relaxed/simple;
	bh=tod1SwJuksqb4VLr+zIUPLoo/yYLfzPGaLhzlXgD6dQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyG5JBnUSHPz8bkk/6744zEoGtPAE8avZ4sUfsnhGEL4DUg3Jb0BAI4sVMdoa+m4bWnABB6yV8iwYwSuPfRiXxFoMco0dS4Uqaay6v8uPLufh4U4/czYCBE5FknCS+vxH54oew5eGUgXI+r4zGxs3hSnEamsWnhJ3l9/Jf8rJoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SI+LsooO; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SI+LsooO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=wx
	foM5GYk7Ih+NtLYutHOoL3a+ZxNORc3YFDqQs3uDw=; b=SI+LsooONPQmqj7/ME
	qYopGt0griH/q+jE7EmYOuuBa0AkjcYZLXe/mV01Ak2sQ6BV0LlDvsSaa2BH0uUY
	D5IrJ7C4yV0LG8J/yR4YJXocbFZHgYeL4h4/nec90t6k+BOxphLQE+ND0LHP5K1R
	yYw2KS7+J2Ol6Q+OUMf6IF5+s=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHX6U2TXFqCeVfJA--.27903S2;
	Tue, 04 Aug 2026 10:23:52 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: l1138897701@163.com
Cc: davem@davemloft.net,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com
Subject: [PATCH v2 MPTCP-net] pm: userspace: fix address ID overflow when all IDs exhausted
Date: Tue,  4 Aug 2026 10:23:49 +0800
Message-Id: <20260804022350.181323-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260714080356.805839-1-l1138897701@163.com>
References: <20260714080356.805839-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCHX6U2TXFqCeVfJA--.27903S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry8Aw1rXF4kCrW7Ww1fXrb_yoW5GFW5pa
	yaywn3Gr4kWFy3Krs2vrs7Kr1S9wsYvryxGrZrKrsa9F4agFs8CryUCF1ayrW7Ka1IqFy5
	XrW7t3y5Ga17u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRLqXgUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3hhYnGpxTTirDQAA3K

From: Qing Luo <luoqing@kylinos.cn>

When all MPTCP address IDs (1-255) are exhausted in the userspace PM,
find_next_zero_bit() returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value
overflows when stored in the u8 field e->addr.id, resulting in ID 0
being stored and the entry being incorrectly added to the list.

ID 0 is reserved for the initial connection in MPTCP, so this overflow
can cause address conflicts.

Note: the in-kernel PM already has an 'endpoints == MPTCP_PM_MAX_ADDR_ID'
check in mptcp_pm_nl_append_new_local_addr() that returns -ERANGE before
reaching find_next_zero_bit(), preventing this overflow. So this fix only
addresses the userspace PM path.

Store the find_next_zero_bit() result in a temporary unsigned int, check
against MPTCP_PM_MAX_ADDR_ID, and return -ENOSPC if all IDs are truly
exhausted. Properly free the allocated entry with sock_kfree_s() on error.

Also modify the CSF (subflow create) handler to pass !entry.addr.id as
the needs_id parameter. When no local ID is provided by user-space
(entry.addr.id == 0), this triggers auto-allocation instead of silently
using the reserved ID 0.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Assisted-by: LLM # review
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 945aa5afc2dd..ada7d6cef625 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -74,10 +74,17 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			goto append_err;
 		}
 
-		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
-							MPTCP_PM_MAX_ADDR_ID + 1,
-							1);
+		if (!e->addr.id && needs_id) {
+			unsigned int id = find_next_zero_bit(id_bitmap,
+							     MPTCP_PM_MAX_ADDR_ID + 1,
+							     1);
+			if (id > MPTCP_PM_MAX_ADDR_ID) {
+				sock_kfree_s(sk, e, sizeof(*e));
+				ret = -ENOSPC;
+				goto append_err;
+			}
+			e->addr.id = id;
+		}
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
@@ -400,7 +407,8 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry, false);
+	err = mptcp_userspace_pm_append_new_local_addr(msk, &entry,
+						       !entry.addr.id);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr,
 				    "did not match address and id");
-- 
2.25.1

