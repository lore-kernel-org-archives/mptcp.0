Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AC345CAB
	for <mptcp@lists.linux.dev>; Sat,  9 May 2026 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778313409; cv=none; b=lGm3/u3JQNpecRHBq3dms9Vv3Sm5Htm+1Dicez8YCo3e/9fRP1qaQXA1fyGIym49NwZFR/OJw6JlHtehx3QZkjrEJfU6WIav1RD+/AAIL7y7WBrbr3Y/jgy+QcCywGTzzNHzPrO2/ovRWpi1OIu+hhcGKnO0FIt3Zvbh5DL+CEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778313409; c=relaxed/simple;
	bh=Ff0GSmO07S4x47wdfpdsaYkQrwtvZlI7gfhtbhZBeY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emcweSGQN3rXFPfz3Sx4WHJinJ3FlDZ2ZnU3dvvekuObygSDjAipSYkK/aL7u8jj2ad4LQmUQui8O27mGQAz/fBN8ajtM9tO0Ym3g9eP2zie7o+Xsx2f2PGbyf4OgxJlUjS9glljjsoAHSWeztUlbIikAMfO9x7kyQo/JQni8K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9dbb34764b7c11f1aa26b74ffac11d73-20260509
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
X-CID-O-INFO: VERSION:1.3.12,REQID:284c3a33-95c7-4d1b-8ab2-859381daf1de,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:284c3a33-95c7-4d1b-8ab2-859381daf1de,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:332bcd29a2e3a4b1deeae1fa72c02949,BulkI
	D:260509155521ULR6ZYKG,BulkQuantity:1,Recheck:0,SF:17|19|38|66|78|102|127|
	898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:n
	il,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
	:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9dbb34764b7c11f1aa26b74ffac11d73-20260509
X-User: cuitao@kylinos.cn
Received: from ctao-book.. [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1766674770; Sat, 09 May 2026 15:56:41 +0800
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
Date: Sat,  9 May 2026 15:56:28 +0800
Message-ID: <20260509075629.217791-1-cuitao@kylinos.cn>
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

