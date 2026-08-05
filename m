Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1944F3DC85B
	for <mptcp@lists.linux.dev>; Wed,  5 Aug 2026 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913779; cv=none; b=mVnfOoj7LlD/d8dm71PToV+s3Hze4aOxEwBvgHP9DnMqNMP3K3OMaosgOmn2kqd2NuwW9JLzlpwRiVvkAc41LQscpVXe3g1N4zO4BA3zNB1ftcNgOYgPig71X7Xpgs7sqI8ZDea08Ot+VsgRk0yKoeUwGJ3ZbjulefWH7ZmoWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913779; c=relaxed/simple;
	bh=B7gp+IvVWjd/OtK5O+nBoDXy1OaPLDNH85rBroiu8e8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RGumtllFrn6jMZosCsqm+sVK7mjDmvGdzKQvt3xLzxoLqfdYYKDgN19dSDaNG72mzq90q0n8IsMMg3NTqRutudSXObRG+OdcROcBWCtH84/pJjj1zCWYdHTPmYkbDcU4QDBIalxysf5GNObFfCBq11S6+OfC7I5/DDtbXilLNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kKVtB4ZS; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kKVtB4ZS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qe
	95k5nRHvFtyXl9T8JSocOULtF8aS+HfA06g998y9I=; b=kKVtB4ZSmwRXw/AlrS
	s0UMbxY4EZQZ9cPbYL6D2k/UoiJJMDCiduPx/42C0jB8Xd38z+0ppjC27HpfCN0a
	w2szXvc7wQPbr7EYRvnhsi/wZvkJpiTq7SMKgxp+120eY0rTgNuZmDE3kSYCR54c
	7bIxATq5nt+cm1xnKH35BRsIE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBH_7en4XJqnHY1MA--.48S2;
	Wed, 05 Aug 2026 15:09:30 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v3] mptcp: pm: fix userspace PM address ID overflow when all IDs are exhausted
Date: Wed,  5 Aug 2026 15:09:26 +0800
Message-Id: <20260805070926.716768-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH_7en4XJqnHY1MA--.48S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry8Aw1rXF4kCrW7Ww1fXrb_yoW5Wr4DpF
	4akwn3Cr48X3WfKws2vrsrKF1fWwsYvF1fWFy2yrsa9F45WF1DCry8CF1Y9Fy7tFs7GFyU
	XrW7t3y5Ga1UuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR4CJJUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC3QvZHmpy4atxdQAA3H

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

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Assisted-by: LLM
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 945aa5afc2dd..7d0e343c35ed 100644
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
-- 
2.25.1

v3: 
Hi Matthieu,

Thank you for your detailed review and for pointing out the issues with my patch. 

Based on your feedback, I will withdraw this patch submission. The core fix for the ID overflow is valid, but my patch became muddled with an unnecessary and potentially harmful behavioral change.

If you believe the core fix (checking find_next_zero_bit's return value against MPTCP_PM_MAX_ADDR_ID) is still worth submitting on its own, I can prepare a clean v3 that only contains that fix and removes the needs_id logic change. Otherwise, I am happy to let this go.

Please let me know your preference.

Best regards,
luoqing

v2: https://lore.kernel.org/all/63f14fa5-f2d3-46e4-bb3a-f02430701cc8@kernel.org/

v1: https://lore.kernel.org/all/20260714080356.805839-1-l1138897701@163.com/

