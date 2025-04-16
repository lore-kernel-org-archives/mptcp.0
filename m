Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABB2185BD
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788933; cv=none; b=RrexPqLJ5KpCPA4b+M0n5s2tFB1iZxku5xrNNuddx3LG/2sIyRxiwpeI2FIhAu5BL25ADrcQwvdBF5WvVLkAJouVZD/sGUR0Bn4Ht6+Ldg9EewDwKZjw3DfQdi55FpStwJKQkmRXlGGeOFiS552qHuOFkhfV2SdgfyFwWb7gIVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788933; c=relaxed/simple;
	bh=7Hvt2RlIgarhgbmejPVKxvIMrRJMr/baQN9rxySVxfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOysmuJ+bqXB9B1BNXfYaPaFPga4MQb4XfgdByhHlK6tGoKhGaese6MdgjxPdoTRKs9RFp6sjPaxlvaxQ2hpZW9XFclT+GQ7+BghQQh8KYF0qhM1BB8V+Te6imnYRCX5ZNk68I60vJRbkFP9YN4UQ6BVu6vmAYJwoFEjfDBos+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5bc1460a1a9511f0a216b1d71e6e1362-20250416
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
X-CID-O-INFO: VERSION:1.1.45,REQID:d840b464-3ac3-4537-87a9-6ec8fbac1f9b,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:d840b464-3ac3-4537-87a9-6ec8fbac1f9b,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:2a0088b8ae9530806dc6c4e90d8f5e5d,BulkI
	D:2504161535279HTSHQT2,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: 5bc1460a1a9511f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1118033047; Wed, 16 Apr 2025 15:35:24 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [mptcp-next 6/7] selftests: mptcp: add a helper to print subflow_info
Date: Wed, 16 Apr 2025 15:35:01 +0800
Message-Id: <47df0cf54a81cea8e6d1f0af8478c30dd16483d1.1744788247.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744788247.git.yangang@kylinos.cn>
References: <cover.1744788247.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds 'print_subflow_info' in 'mptcp_diag', which can print
the subflow_filed of an MPTCP subflow. This function is for further
checking the 'subflow_info' through inet_diag method.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 03c92940e461..25495c7e1c74 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -56,6 +56,36 @@ struct mptcp_info {
 	__u32	mptcpi_last_ack_recv;
 };
 
+enum {
+	MPTCP_SUBFLOW_ATTR_UNSPEC,
+	MPTCP_SUBFLOW_ATTR_TOKEN_REM,
+	MPTCP_SUBFLOW_ATTR_TOKEN_LOC,
+	MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SEQ,
+	MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
+	MPTCP_SUBFLOW_ATTR_SSN_OFFSET,
+	MPTCP_SUBFLOW_ATTR_MAP_DATALEN,
+	MPTCP_SUBFLOW_ATTR_FLAGS,
+	MPTCP_SUBFLOW_ATTR_ID_REM,
+	MPTCP_SUBFLOW_ATTR_ID_LOC,
+	MPTCP_SUBFLOW_ATTR_PAD,
+
+	__MPTCP_SUBFLOW_ATTR_MAX
+};
+#define MPTCP_SUBFLOW_ATTR_MAX (__MPTCP_SUBFLOW_ATTR_MAX - 1)
+
+#define MPTCP_SUBFLOW_FLAG_MCAP_REM		_BITUL(0)
+#define MPTCP_SUBFLOW_FLAG_MCAP_LOC		_BITUL(1)
+#define MPTCP_SUBFLOW_FLAG_JOIN_REM		_BITUL(2)
+#define MPTCP_SUBFLOW_FLAG_JOIN_LOC		_BITUL(3)
+#define MPTCP_SUBFLOW_FLAG_BKUP_REM		_BITUL(4)
+#define MPTCP_SUBFLOW_FLAG_BKUP_LOC		_BITUL(5)
+#define MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED	_BITUL(6)
+#define MPTCP_SUBFLOW_FLAG_CONNECTED		_BITUL(7)
+#define MPTCP_SUBFLOW_FLAG_MAPVALID		_BITUL(8)
+
+#define rta_getattr(type, value)		(*(type *)RTA_DATA(value))
+
 static void die_perror(const char *msg)
 {
 	perror(msg);
@@ -167,6 +197,65 @@ static void print_info_msg(struct mptcp_info *info)
 	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
 }
 
+/*
+ * 'print_subflow_info' is from 'mptcp_subflow_info'
+ * which is a function in 'misc/ss.c' of iproute2.
+ */
+static void print_subflow_info(struct rtattr *tb[])
+{
+	u_int32_t flags = 0;
+
+	printf("It's a mptcp subflow, the subflow info:\n");
+	if (tb[MPTCP_SUBFLOW_ATTR_FLAGS]) {
+		char caps[32 + 1] = { 0 }, *cap = &caps[0];
+
+		flags = rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_FLAGS]);
+
+		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_REM)
+			*cap++ = 'M';
+		if (flags & MPTCP_SUBFLOW_FLAG_MCAP_LOC)
+			*cap++ = 'm';
+		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_REM)
+			*cap++ = 'J';
+		if (flags & MPTCP_SUBFLOW_FLAG_JOIN_LOC)
+			*cap++ = 'j';
+		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_REM)
+			*cap++ = 'B';
+		if (flags & MPTCP_SUBFLOW_FLAG_BKUP_LOC)
+			*cap++ = 'b';
+		if (flags & MPTCP_SUBFLOW_FLAG_FULLY_ESTABLISHED)
+			*cap++ = 'e';
+		if (flags & MPTCP_SUBFLOW_FLAG_CONNECTED)
+			*cap++ = 'c';
+		if (flags & MPTCP_SUBFLOW_FLAG_MAPVALID)
+			*cap++ = 'v';
+
+		if (flags)
+			printf(" flags:%s", caps);
+	}
+	if (tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM] &&
+	    tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC] &&
+	    tb[MPTCP_SUBFLOW_ATTR_ID_REM] &&
+	    tb[MPTCP_SUBFLOW_ATTR_ID_LOC])
+		printf(" token:%04x(id:%u)/%04x(id:%u)",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_TOKEN_REM]),
+		       rta_getattr(__u8, tb[MPTCP_SUBFLOW_ATTR_ID_REM]),
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
+		       rta_getattr(__u8, tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ])
+		printf(" seq:%llu",
+		       rta_getattr(__u64, tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ])
+		printf(" sfseq:%u",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
+	if (tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET])
+		printf(" ssnoff:%u",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
+	if (tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN])
+		printf(" maplen:%u",
+		       rta_getattr(__u32, tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));
+}
+
 static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
@@ -201,6 +290,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 
 			parse_rtattr_nested(sfinfo, MPTCP_SUBFLOW_ATTR_MAX,
 					    ulpinfo[INET_ULP_INFO_MPTCP]);
+			print_subflow_info(sfinfo);
 		} else {
 			printf("It's a normal TCP!\n");
 		}
-- 
2.25.1

