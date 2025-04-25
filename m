Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A222A7F9
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561942; cv=none; b=MvXO0S/DcfGkPVUqcJBwuuYo7M/OVl85KFHWuGGn0tTA8Xno2HLZZemj5eVjRTtm2d9K5M4PY46F5J54BaKFg5IaQUa+8enjaJQQ6cwc1YSUc2hG56rd2p0r+CjfCX9gSJRdXZLXxdhj8bW+3+K0lRo8fKecQYtuUDiDp3h7xhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561942; c=relaxed/simple;
	bh=HrBZistDvYrYcUUrfZC4KfpwgJ985k1eEXXTRNa2Y6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkSZ64hyQOrPVymySy5EHh8bQBJBLosSPa7OCq/UbiT1RwUznhQpULq9s7F2fYh4OOpDPT6ulKPXLTA/7cMc8X1iPbL/PTq9akLw2aSocSe0iTGsU0Q9G/I7rXdvwap2gcdHnlbOqBfADwexSlVaTsJjz9Hf0ChIuzRDOE+FBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 284f83c2219d11f0a216b1d71e6e1362-20250425
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
X-CID-O-INFO: VERSION:1.1.45,REQID:99fa3060-75a7-4250-9f51-a7632226967d,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:99fa3060-75a7-4250-9f51-a7632226967d,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:e3556494477ee74245a491949442c56c,BulkI
	D:2504251418530UWPYWXU,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 284f83c2219d11f0a216b1d71e6e1362-20250425
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1111112540; Fri, 25 Apr 2025 14:18:51 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 3/5] selftests: mptcp: refactor NLMSG handling with 'proto'
Date: Fri, 25 Apr 2025 14:18:41 +0800
Message-Id: <cf19bffa9087e367c3845f29bec13ded1b75daf7.1745395366.git.yangang@kylinos.cn>
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

This patch introduces the '__u32 proto' variable to the 'send_query' and
'recv_nlmsg' functions for further extending function.

In the 'send_query' function, the inclusion of this variable makes the
structure clearer and more readable.

In the 'recv_nlmsg' function, the '__u32 proto' variable ensures that
the 'diag_info' field remains unmodified when processing IPPROTO_TCP data,
thereby preventing unintended transformation into 'mptcp_info' format.

While at it, increment iovlen directly when an item is added to simplify
this portion of the code and improve its readaility.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index c9533883149b..e19b21631641 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -62,7 +62,7 @@ static void die_usage(int r)
 	exit(r);
 }
 
-static void send_query(int fd, struct inet_diag_req_v2 *r)
+static void send_query(int fd, struct inet_diag_req_v2 *r, __u32 proto)
 {
 	struct sockaddr_nl nladdr = {
 		.nl_family = AF_NETLINK
@@ -80,21 +80,22 @@ static void send_query(int fd, struct inet_diag_req_v2 *r)
 	};
 	struct rtattr rta_proto;
 	struct iovec iov[6];
-	int iovlen = 1;
-	__u32 proto;
+	int iovlen = 0;
 
-	proto = IPPROTO_MPTCP;
-	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
-	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
-
-	iov[0] = (struct iovec) {
+	iov[iovlen++] = (struct iovec) {
 		.iov_base = &req,
 		.iov_len = sizeof(req)
 	};
-	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
-	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
-	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
-	iovlen += 2;
+
+	if (proto == IPPROTO_MPTCP) {
+		rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
+		rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
+
+		iov[iovlen++] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
+		iov[iovlen++] = (struct iovec){ &proto, sizeof(proto)};
+		req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
+	}
+
 	struct msghdr msg = {
 		.msg_name = &nladdr,
 		.msg_namelen = sizeof(nladdr),
@@ -158,7 +159,7 @@ static void print_info_msg(struct mptcp_info *info)
 	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
 }
 
-static void parse_nlmsg(struct nlmsghdr *nlh)
+static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	struct rtattr *tb[INET_DIAG_MAX + 1];
@@ -167,7 +168,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
 			   NLA_F_NESTED);
 
-	if (tb[INET_DIAG_INFO]) {
+	if (proto == IPPROTO_MPTCP && tb[INET_DIAG_INFO]) {
 		int len = RTA_PAYLOAD(tb[INET_DIAG_INFO]);
 		struct mptcp_info *info;
 
@@ -183,7 +184,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 	}
 }
 
-static void recv_nlmsg(int fd)
+static void recv_nlmsg(int fd, __u32 proto)
 {
 	char rcv_buff[8192];
 	struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buff;
@@ -216,7 +217,7 @@ static void recv_nlmsg(int fd)
 			       -(err->error), strerror(-(err->error)));
 			break;
 		}
-		parse_nlmsg(nlh);
+		parse_nlmsg(nlh, proto);
 		nlh = NLMSG_NEXT(nlh, len);
 	}
 }
@@ -230,14 +231,15 @@ static void get_mptcpinfo(__u32 token)
 		.idiag_ext = 1 << (INET_DIAG_INFO - 1),
 		.id.idiag_cookie[0]     = token,
 	};
+	__u32 proto = IPPROTO_MPTCP;
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
 	if (fd < 0)
 		die_perror("Netlink socket");
 
-	send_query(fd, &r);
-	recv_nlmsg(fd);
+	send_query(fd, &r, proto);
+	recv_nlmsg(fd, proto);
 
 	close(fd);
 }
-- 
2.43.0

