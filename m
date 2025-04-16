Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B069233722
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794006; cv=none; b=UqNBK4/3C+Czl8lArVbBi6+Cwh3sQUqCqr/BvRp+5qHFyj1Vdby2D6TCmY+44/QNkTBBjJYa6UbL9CJmfWaZOGQ+N3TmidVr6xARpHrkgZ2hUQoWlaU8LH/dpVo0ezeiCqVkgJwrvjmYDZJ6NG1GkpuKor/MSQY9kQfcHjW2sdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794006; c=relaxed/simple;
	bh=HWFxL02gyAEjllc4b1cFVoH1UM1yfqTRaOIc+AZK8rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qpJXX7qbERQVvPABh8JoftL1FzU7vNC7aIDbyX7o6adDpdM+ss1q3ag7vs3//ZVaeCzPB7wzbPC6TZ5qffNgbweeyRB1d7iIi2ZoLrFZ9+5wrNHQUWUP8FqX45jTYvQ6/2EBiuQl8xTP1iUjCjqb8LZf56PPd9VkVcd8IHtvz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2b36ae421aa111f0a216b1d71e6e1362-20250416
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
X-CID-O-INFO: VERSION:1.1.45,REQID:56c38cc2-aa41-4562-bfbc-b0915c08998d,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:56c38cc2-aa41-4562-bfbc-b0915c08998d,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:f8a77b79a38125b40b03750e120b4c4f,BulkI
	D:250416153524DZ7LI12W,BulkQuantity:1,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:41,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2b36ae421aa111f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1972895071; Wed, 16 Apr 2025 16:59:56 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [mptcp-next v2 2/7] selftests: mptcp: refactor send_query parameters for code clarity
Date: Wed, 16 Apr 2025 16:59:44 +0800
Message-Id: <afbbf4fc074b0d26b4954db0a750cadea1b67a62.1744793332.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744793332.git.yangang@kylinos.cn>
References: <cover.1744793332.git.yangang@kylinos.cn>
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
index ea7cb1128044..8a5b7745c58c 100644
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
+		.id.idiag_cookie[0]     = token,
+	};
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
 	if (fd < 0)
 		die_perror("Netlink socket");
 
-	send_query(fd, token);
+	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
+	send_query(fd, &r);
 	recv_nlmsg(fd);
 
 	close(fd);
-- 
2.25.1

