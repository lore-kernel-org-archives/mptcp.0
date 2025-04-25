Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54F22B8C6
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 06:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561943; cv=none; b=WSYJWjd1154hhRGq/xVU/IEjkFExE8+jxsHP6wusHef1dMhk3rOHvqX9rQXNLf/P7BOZdHaHv6cPw8bM71qq3b/hGvviGlAnIgi/G4RWaSgU8C/roJk/W+r3OMut7la8btR8mmBAhUNM9FSQVxv8owXVl34m+zwC5Ecjij0hr08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561943; c=relaxed/simple;
	bh=6RXly9vswo17z5yLFfESeRMRNKDs9mZ677BCL6MbTpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1k59KVvs5IMfxANrWeLvmQQ74dHcaZqtYYYDSQ7hZ7J0vBA/XSNw75NRDFc5JHGgingNy4Y9yIxCEgxHSEp9caoGu117ISrdr1e16v8WDwQhHE1FMveEheo61CeTY+HqW/qvN8GPYn7kICn1lgO8piSBpMEKtOncXHpgINg5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2795b302219d11f0a216b1d71e6e1362-20250425
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:41a7f15a-0efe-4a12-960f-c6b1fe2d7a0c,IP:10,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-10
X-CID-INFO: VERSION:1.1.45,REQID:41a7f15a-0efe-4a12-960f-c6b1fe2d7a0c,IP:10,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-10
X-CID-META: VersionHash:6493067,CLOUDID:7a0ce78cb51a161ebbc40814a25b76e4,BulkI
	D:250425141853PMR3001Y,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 2795b302219d11f0a216b1d71e6e1362-20250425
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2126295563; Fri, 25 Apr 2025 14:18:50 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 2/5] selftests: mptcp: refactor send_query parameters for code clarity
Date: Fri, 25 Apr 2025 14:18:40 +0800
Message-Id: <d96128e4ea99b661656cb2546b217ecdb8695ffc.1745395366.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745395366.git.yangang@kylinos.cn>
References: <cover.1745395366.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch use 'inet_diag_req_v2' instead of 'token' as parameters of
send_query, and construct the req in 'get_mptcpinfo'. This modification
can enhance the enhancing clarity of the code, and prepare for the
dump_subflow_info.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index ea7cb1128044..c9533883149b 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -62,7 +62,7 @@ static void die_usage(int r)
 	exit(r);
 }
 
-static void send_query(int fd, __u32 token)
+static void send_query(int fd, struct inet_diag_req_v2 *r)
 {
 	struct sockaddr_nl nladdr = {
 		.nl_family = AF_NETLINK
@@ -76,19 +76,13 @@ static void send_query(int fd, __u32 token)
 			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
 			.nlmsg_flags = NLM_F_REQUEST
 		},
-		.r = {
-			.sdiag_family = AF_INET,
-			/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
-			.sdiag_protocol = IPPROTO_TCP,
-			.id.idiag_cookie[0] = token,
-		}
+		.r = *r
 	};
 	struct rtattr rta_proto;
 	struct iovec iov[6];
 	int iovlen = 1;
 	__u32 proto;
 
-	req.r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
 	proto = IPPROTO_MPTCP;
 	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
 	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
@@ -229,13 +223,20 @@ static void recv_nlmsg(int fd)
 
 static void get_mptcpinfo(__u32 token)
 {
+	struct inet_diag_req_v2 r = {
+		.sdiag_family           = AF_INET,
+		/* Real proto is set via INET_DIAG_REQ_PROTOCOL */
+		.sdiag_protocol         = IPPROTO_TCP,
+		.idiag_ext = 1 << (INET_DIAG_INFO - 1),
+		.id.idiag_cookie[0]     = token,
+	};
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
 	if (fd < 0)
 		die_perror("Netlink socket");
 
-	send_query(fd, token);
+	send_query(fd, &r);
 	recv_nlmsg(fd);
 
 	close(fd);
-- 
2.43.0

