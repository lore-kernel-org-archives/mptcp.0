Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6B18D636
	for <mptcp@lists.linux.dev>; Tue, 14 Jul 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016270; cv=none; b=A9sTvcEFXq9hWhSR7IJZU+N1Ltfdc3gO16JF1wEO0/AM1AcR23UHBwrdMfXbEKLI2xwsoj3yt2Ta0fExhQL7grFF7gd0SmVPFGnDn7/PXJjmY4tCxbBF70Hq6cy1ZVmTUepiHnLyiEwYFird1hflXxEHuJn/ZkdtcmTN2whCqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016270; c=relaxed/simple;
	bh=Ak3oSZyOMV2D5pbG+7d9OwMOWUSuAVRak4PfawoGf/o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tkbrRNXwjyF6VS4o48TqKi1oaKgHbVjIokhK6ztUf/oz8vJdctSX3VVful78erlaqKVr/+T8TRi5N0cOa829tAYx3yeTLHFcwxD2u8Ufqv7e9b2QuzorIXFVwAy326ttMTt1nikjUTttzy/Eeu8fM7I1KohU5EIk28ECm1Qn0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fJaFqJ/P; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fJaFqJ/P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=QW
	F8DefYjbOsjfIh06Zw3He8FjN3h6ZlYYVGCpQA/fY=; b=fJaFqJ/Pmhzp8SaW5j
	UAH5LLERfq893ykuhDUVeMilE/MGfzLqXyK+U9goUhQTaK6Mvk5jNNhZfpZbQx3N
	3EYzfpKp3+HJc3uWW5WqHP25H6tnkZjswhTpM45iGrAas+NfWSmaaQAnvJrkJqZs
	X4TIM/RGZQvO1RTKFoGIdnOQE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDna5Ft7VVq6WzAJQ--.33654S2;
	Tue, 14 Jul 2026 16:03:59 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: mptcp@lists.linux.dev
Cc: pabeni@redhat.com,
	matttbe@kernel.org,
	davem@davemloft.net
Subject: [PATCH] mptcp: pm: Fix address ID overflow when all IDs are exhausted
Date: Tue, 14 Jul 2026 16:03:56 +0800
Message-Id: <20260714080356.805839-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDna5Ft7VVq6WzAJQ--.33654S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr4UKryxZF45Ww15Cw18uFg_yoW8tr1xpa
	13Jas3Wr18WryfKanavFs7KF1fuwnYkryxK39Ikwsa9F4agF1DA340gry3WFW7Kr47KFW5
	JrWDJ3y5Gw4xuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIPfLUUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+Q+GympV7W8B4QAA3n

From: luoqing <luoqing@kylinos.cn>

When all MPTCP address IDs (1-255) are exhausted, find_next_zero_bit()
returns MPTCP_PM_MAX_ADDR_ID + 1 (256). This value overflows when stored
in the u8 field e->addr.id, resulting in ID 0 being stored.

ID 0 has special meaning in MPTCP (it's reserved for the initial connection),
so this overflow can cause confusion and incorrect behavior, including
unintentional ID 0 reuse or address conflicts.

Signed-off-by: luoqing <luoqing@kylinos.cn>
---
 net/mptcp/pm_kernel.c    | 11 ++++++++---
 net/mptcp/pm_userspace.c | 15 +++++++++++----
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 424f1a7f9248..a0fc9cabd770 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -795,9 +795,14 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 
 	if (!entry->addr.id) {
 find_next:
-		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
-						    MPTCP_PM_MAX_ADDR_ID + 1,
-						    pernet->next_id);
+		unsigned int id = find_next_zero_bit(pernet->id_bitmap,
+						     MPTCP_PM_MAX_ADDR_ID + 1,
+						     pernet->next_id);
+		if (id > MPTCP_PM_MAX_ADDR_ID) {
+			ret = -ENOSPC;
+			goto out;
+		}
+		entry->addr.id = id;
 		if (!entry->addr.id && pernet->next_id != 1) {
 			pernet->next_id = 1;
 			goto find_next;
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d100867e9202..c48fd905f7a0 100644
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

