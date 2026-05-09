Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5929BDAA
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313338; cv=none; b=lHbjCLiDhLVK/DFIQmjca5KMHIgUsIDDQO05baeos9BTq23YENaSeIN25sKZxvGARz7+TyeUct+hbxD8PJGnQFwoZIf799BqihZzJKqmeTt68XK87EKrutsLWzz2kAfN5veB6GzglN27kjNwKArB4gqOBvkVL/sdJJ7Tn70Uqvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313338; c=relaxed/simple;
	bh=Ff0GSmO07S4x47wdfpdsaYkQrwtvZlI7gfhtbhZBeY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvthKAjIuLHbX2exQgefmm341meK0d/jDPDGgAVkH/cJhoDPs0nqu1jBQa+rHIA+EAZTB1QotebjCqKD5OcCyZrrnPddftPKildAUFY8ZwtRc8ZhoP35jx0kDg65ZxJXjCEy7ZcA5ymKXNdP2uO7aO0V9ZBQ6fdT15HaiN51DUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6d418fd44b7c11f1aa26b74ffac11d73-20260509
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:446972c5-ab53-4938-8efb-de763e19a095,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:446972c5-ab53-4938-8efb-de763e19a095,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:0d8e10b0e1fe83c94113110cbf0a44e0,BulkI
	D:260509155521ULR6ZYKG,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6d418fd44b7c11f1aa26b74ffac11d73-20260509
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 939938096; Sat, 09 May 2026 15:55:20 +0800
From: Tao Cui <cuitao@kylinos.cn>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mptcp@lists.linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] mptcp: pm: fix use-after-free in mptcp_userspace_pm_delete_local_addr
Date: Sat,  9 May 2026 15:54:49 +0800
Message-ID: <20260509075450.217766-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mptcp_userspace_pm_delete_local_addr() calls list_del_rcu() followed
immediately by sock_kfree_s(), which frees the entry synchronously
without waiting for an RCU grace period.  A concurrent RCU read-side
lookup (e.g. via mptcp_userspace_pm_get_local_id) could still be
accessing the freed entry.

Fix it by replacing sock_kfree_s() with kfree_rcu_mightsleep() and
adjusting sk_omem_alloc manually, matching the pattern already used
in mptcp_pm_nl_remove_doit() in the same file.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 8cbc1920afb4..586e19e9b913 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -109,7 +109,11 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	 * be used multiple times (e.g. fullmesh mode).
 	 */
 	list_del_rcu(&entry->list);
-	sock_kfree_s(sk, entry, sizeof(*entry));
+	kfree_rcu_mightsleep(entry);
+	/* Adjust sk_omem_alloc like sock_kfree_s() does, to match
+	 * with allocation of this memory by sock_kmemdup()
+	 */
+	atomic_sub(sizeof(*entry), &sk->sk_omem_alloc);
 	msk->pm.local_addr_used--;
 	return 0;
 }
-- 
2.43.0

