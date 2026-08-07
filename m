Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532237E5C7
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088484; cv=none; b=LHQ57pD4rGwmGC4cdbTTJlZLD6irWS+jYPHEWBD8pNmDAAoJuYRdNoCiTHIM78cOEuz7Nj9g1RqkBCSEHjFm6dBlT8eNDcDjRMts4ruiqLNtFdXMjN2dNB+xQsneHneowL2fM1Ph4q+JNoH4cvZ+vMKC6TrO6f207Y+ionKr71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088484; c=relaxed/simple;
	bh=4OFJ18mrfpEBf9CFzr1RonaYblFax0Z89yPjBhJd1Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN6IfcBvJa2wY/5iPXINTJbzyzJ3TGgN6UdFehWfGHPd0X8Y1DX8TjaEuKfqtIf8yoR2U3a2dkC6GXacTkl1/uXLvllyzHsbfuZftUChfGNFfWyTBHeuWKeJ5OlukCCminPePukkqYn+uNzSeF5Op9CnY0GkaiSE+xJGswabgFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JsG6oWKf; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JsG6oWKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=OB8UyMOOARzn7S0vaH0ywUX+7E83omEOteGotLIZsec=;
	b=JsG6oWKf/qfgKKlFBHxxdngUfKel6jvExuZNcSlRt2Qcx0/vDvgGvG7FIfSBTK
	+4IU2tTican3kpvAbwR6fBglD3eDCKXCndfd8frSwggHD8OeOqolWcO7UmnFkYdW
	Jfzzc8WzwvRbgzGDVxHIZU3BadXITTUHTJYKB/VYy/WdM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAHuisWjHVqNYJjAQ--.8771S2;
	Fri, 07 Aug 2026 15:41:12 +0800 (CST)
From: luoqing <l1138897701@163.com>
To: l1138897701@163.com
Cc: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4] mptcp: pm: fix userspace PM address ID overflow when all IDs are exhausted
Date: Fri,  7 Aug 2026 15:41:10 +0800
Message-Id: <20260807074110.566170-1-l1138897701@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260805070926.716768-1-l1138897701@163.com>
References: <20260805070926.716768-1-l1138897701@163.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHuisWjHVqNYJjAQ--.8771S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZry8Aw1rXF4kAFWUZFWrKrg_yoW5urWDpF
	sxGwn3Cr4kGFy3Jrs2vanrGF1S9wn5Zry7GFy3tFsa9F43WF4DC340kF1Y9347Crs7GFy3
	XFWUt345G3WUuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUqii-UUUUU=
X-CM-SenderInfo: jorrjmiyzxliqr6rljoofrz/xtbC+hkhZWp1jBniXQAA3S

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

Check the find_next_zero_bit() result against MPTCP_PM_MAX_ADDR_ID and
return -ENOSPC if all IDs are truly exhausted. Move the ID allocation
check before the memory allocation so that the error path does not need
to free the allocated entry.

Fixes: 4638de5aefe5 ("mptcp: handle local addrs announced by userspace PMs")
Assisted-by: LLM
Signed-off-by: Qing Luo <luoqing@kylinos.cn>
---
v4: Move the ID allocation check before the memory allocation so that the error path 
    does not need to free the allocated entry

v3: Submit separately to only verify the return value of find_next_zero_bit

v2: https://lore.kernel.org/all/63f14fa5-f2d3-46e4-bb3a-f02430701cc8@kernel.org/

v1: https://lore.kernel.org/all/20260714080356.805839-1-l1138897701@163.com/
---
 net/mptcp/pm_userspace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 2203cc2d2748..57c13293a5f8 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -69,6 +69,19 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	}
 
 	if (!addr_match && !id_match) {
+		unsigned int id;
+
+		if (!entry->addr.id && needs_id) {
+			id = find_next_zero_bit(id_bitmap,
+						MPTCP_PM_MAX_ADDR_ID + 1, 1);
+			if (id > MPTCP_PM_MAX_ADDR_ID) {
+				ret = -ENOSPC;
+				goto append_err;
+			}
+		} else {
+			id = entry->addr.id;
+		}
+
 		/* Memory for the entry is allocated from the
 		 * sock option buffer.
 		 */
@@ -78,10 +91,7 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 			goto append_err;
 		}
 
-		if (!e->addr.id && needs_id)
-			e->addr.id = find_next_zero_bit(id_bitmap,
-							MPTCP_PM_MAX_ADDR_ID + 1,
-							1);
+		e->addr.id = id;
 		list_add_tail_rcu(&e->list, &msk->pm.userspace_pm_local_addr_list);
 		msk->pm.local_addr_used++;
 		ret = e->addr.id;
-- 
2.25.1

> Do you have issues to send replies to my previous emails? Because
> sending your replies here at the end of a patch is unusual, and these
> comments are stripped when replying to an existing email.
Hi,Matthieu

Thanks a lot for your detailed review and pointing out these problems.

I have to admit I was a bit confused about the correct mailing‑list workflow, especially whether I should start a brand‑new thread or simply reply when sending new patch versions.

I will spend more time studying the community patch submission workflow to avoid similar mistakes next time.
I plan to release the v4 version soon regarding the reply on this old thread. Thank you for your guidance.

Thanks,
luoqing

