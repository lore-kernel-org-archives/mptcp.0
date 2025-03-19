Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227820F077
	for <mptcp@lists.linux.dev>; Wed, 19 Mar 2025 02:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351273; cv=none; b=Hx/gwW/yGTmypnD/D302urFbA7fWGPY9Qs4491+wK1Qxh0OtlFC3BH0gLO9w3UzJ7yRXcIc4WahPL9BfblWT12aK5D5O8kPgsyHO0qw9eJm2f1u4EM71lZjnUlg9QLf10zpdmNBR5sGwDI4lhU2Hp282hGYy3Gav5VYijB9UYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351273; c=relaxed/simple;
	bh=MizZxavH2Rc77QNRilCjFCBcjvZNnjNg2c1xCBG44Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JzfZwliSVIAR7owlvVAjDuCJwT89RvPTGqPcayOsHLd7YpcYgO0nufXYyGtgNBVnWL2Qju4AD4TGSzuc6QAC76eBOuXuW1t+A2QgNmE3wXB4xMSXKNiwvzClsZF1htqfZ/z4Xt9iUGAyt+yzI9UOzL447AwUr8+vkopY+lOTjis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: bbc2b044046911f0a216b1d71e6e1362-20250319
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:811dd1c8-41a4-42f5-a796-85d2c12ad32c,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:1
X-CID-INFO: VERSION:1.1.45,REQID:811dd1c8-41a4-42f5-a796-85d2c12ad32c,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:1
X-CID-META: VersionHash:6493067,CLOUDID:1a2fc1c736b946e5abd5b6b2575ecc78,BulkI
	D:250319102744XELT8LCM,BulkQuantity:0,Recheck:0,SF:17|19|24|43|66|74|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: bbc2b044046911f0a216b1d71e6e1362-20250319
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1969635499; Wed, 19 Mar 2025 10:27:41 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [mptcp-net, v2] mptcp: fix a NULL pointer result in panic
Date: Wed, 19 Mar 2025 10:27:33 +0800
Message-Id: <20250319022733.51444-1-yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When test valkey in mptcp, the kernel will panic due to the function
'mptcp_can_accept_new_subflow' when the subflow_req->msk is NULL.

This problem shows in kernel 6.11.0-rc3 and 6.14.0-rc4. The message
attached is valkey_test in 6.14.0-rc4:

Call trace:
mptcp_can_accept_new_subflow (./net/mptcp/subflow.c:63 (discriminator 4)) (P)
subflow_syn_recv_sock (./net/mptcp/subflow.c:854)
tcp_check_req (./net/ipv4/tcp_minisocks.c:863)
tcp_v4_rcv (./net/ipv4/tcp_ipv4.c:2268)
ip_protocol_deliver_rcu (./net/ipv4/ip_input.c:207)
ip_local_deliver_finish (./net/ipv4/ip_input.c:234)
ip_local_deliver (./net/ipv4/ip_input.c:254)
ip_rcv_finish (./net/ipv4/ip_input.c:449)
...

According to the debug log, the same req received two SYN-ACK in a very
short time. (When the client retransmits the syn ack dueto multiple reasons.
Even if the packets are transmitted with a relevant time interval, they can be
processed by the server on different CPUs concurrently). The 'subflow_req->msk'
ownership is transferred to subflow in the first, and there will be a risk of a
null pointer dereference here.

This patch can fix this issue by moving the 'subflow_req->msk' under the
`own_req == true` conditional.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Gang Yan <yangang@kylinos.cn>

---
Notes:
- v2:
  - The MPTCP and the TCP code protect vs such race using the
    `own_req` boolean. So moving the subflow_req->msk under
    the 'own_req'.
---
 net/mptcp/subflow.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index efe8d86496db..409bd415ef1d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -754,8 +754,6 @@ static bool subflow_hmac_valid(const struct request_sock *req,
 
 	subflow_req = mptcp_subflow_rsk(req);
 	msk = subflow_req->msk;
-	if (!msk)
-		return false;
 
 	subflow_generate_hmac(READ_ONCE(msk->remote_key),
 			      READ_ONCE(msk->local_key),
@@ -850,12 +848,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 
 	} else if (subflow_req->mp_join) {
 		mptcp_get_options(skb, &mp_opt);
-		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
-		    !subflow_hmac_valid(req, &mp_opt) ||
-		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
-			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK))
 			fallback = true;
-		}
 	}
 
 create_child:
@@ -905,6 +899,13 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				goto dispose_child;
 			}
 
+			if (!subflow_hmac_valid(req, &mp_opt) ||
+			    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
+				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
+				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
+				goto dispose_child;
+			}
+
 			/* move the msk reference ownership to the subflow */
 			subflow_req->msk = NULL;
 			ctx->conn = (struct sock *)owner;
-- 
2.25.1

