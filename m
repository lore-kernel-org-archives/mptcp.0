Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DE1C8621
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561943; cv=none; b=O6TJAbYPoSx3DG6cEaWzJ1lPm3QTWOiE3eYdv5KtxPHG/wIbsx/y/WrjEFdz/qBh0ZpcLUOOQ8OL5H8wKHvP855tfTrNIWUKIarOcu6nis35+uF2a1wyTYCpCjzkI1EQuMmihYfA+CbCkTKTio2qDCpZc8p3B9uifPs+IiVrBAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561943; c=relaxed/simple;
	bh=dcIIZeLfL3Bm0gIWl14bclFSd6pKMZwZBynJM7N/j08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4Y3cbETi4WWNf+V0c/aC6d06Hsq498W7LWobygPfjVd+BrbQOPRT9kCvw/O4dCER82MdvqiZO+FScu9MWDSM1kaikZNR5QNPwYuD+/UFoZ5RRQwPdmJige11oSIIyzqUkruvg4KXKe0birMcv5OL7kWaQNXBywzebKViO3sWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 28b4e258219d11f0a216b1d71e6e1362-20250425
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
X-CID-O-INFO: VERSION:1.1.45,REQID:bf107920-caba-479a-ae94-8d8fd63f907f,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:bf107920-caba-479a-ae94-8d8fd63f907f,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:0a933e3be1d613197deb099719695183,BulkI
	D:250425141854Z9M6O08U,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102|841,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 28b4e258219d11f0a216b1d71e6e1362-20250425
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1399719576; Fri, 25 Apr 2025 14:18:52 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 4/5] selftests: mptcp: add helpers to get subflow_info
Date: Fri, 25 Apr 2025 14:18:42 +0800
Message-Id: <30e3b8d461c1e7776d398897c9e891536fbc385b.1745395366.git.yangang@kylinos.cn>
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

This patch adds 'get_subflow_info' in 'mptcp_diag', which can check whether
a TCP connection is an MPTCP subflow based on the "INET_ULP_INFO_MPTCP"
with tcp_diag method.

The helper 'print_subflow_info' in 'mptcp_diag' can print the subflow_filed
of an MPTCP subflow for further checking the 'subflow_info' through
inet_diag method.

The example of the whole output should be:

'''
127.0.0.1:10000 -> 127.0.0.1:38984
It's a mptcp subflow, the subflow info:
 flags:Mec token:0000(id:0)/4278e77e(id:0) seq:9288466187236176036 \
 sfseq:1 ssnoff:2317083055 maplen:215
'''

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 159 +++++++++++++++++-
 1 file changed, 157 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index e19b21631641..13848a25938d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -8,6 +8,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <linux/tcp.h>
+#include <arpa/inet.h>
 
 #include <unistd.h>
 #include <stdlib.h>
@@ -19,8 +20,13 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+#define parse_rtattr_nested(tb, max, rta) \
+	(parse_rtattr_flags((tb), (max), RTA_DATA(rta), RTA_PAYLOAD(rta), \
+			    NLA_F_NESTED))
+
 struct params {
 	__u32 target_token;
+	char subflow_addrs[1024];
 };
 
 struct mptcp_info {
@@ -50,6 +56,37 @@ struct mptcp_info {
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
+
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
@@ -58,7 +95,9 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_diag -t\n");
+	fprintf(stderr, "Usage:\n"
+			"mptcp_diag -t <token>\n"
+			"mptcp_diag -s \"<saddr>:<sport> <daddr>:<dport>\"\n");
 	exit(r);
 }
 
@@ -159,6 +198,66 @@ static void print_info_msg(struct mptcp_info *info)
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
+	printf("\n");
+}
+
 static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
@@ -182,6 +281,22 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 		}
 		print_info_msg(info);
 	}
+	if (proto == IPPROTO_TCP && tb[INET_DIAG_ULP_INFO]) {
+		struct rtattr *ulpinfo[INET_ULP_INFO_MAX + 1] = { 0 };
+
+		parse_rtattr_nested(ulpinfo, INET_ULP_INFO_MAX,
+				    tb[INET_DIAG_ULP_INFO]);
+
+		if (ulpinfo[INET_ULP_INFO_MPTCP]) {
+			struct rtattr *sfinfo[MPTCP_SUBFLOW_ATTR_MAX + 1] = { 0 };
+
+			parse_rtattr_nested(sfinfo, MPTCP_SUBFLOW_ATTR_MAX,
+					    ulpinfo[INET_ULP_INFO_MPTCP]);
+			print_subflow_info(sfinfo);
+		} else {
+			printf("It's a normal TCP!\n");
+		}
+	}
 }
 
 static void recv_nlmsg(int fd, __u32 proto)
@@ -244,6 +359,39 @@ static void get_mptcpinfo(__u32 token)
 	close(fd);
 }
 
+static void get_subflow_info(char *subflow_addrs)
+{
+	struct inet_diag_req_v2 r = {
+		.sdiag_family           = AF_INET,
+		.sdiag_protocol         = IPPROTO_TCP,
+		.id.idiag_cookie[0]	= INET_DIAG_NOCOOKIE,
+		.id.idiag_cookie[1]	= INET_DIAG_NOCOOKIE,
+	};
+	char saddr[64], daddr[64];
+	int sport, dport;
+	int ret;
+	int fd;
+
+	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
+	if (ret != 4)
+		die_perror("IP PORT Pairs has style problems!");
+
+	printf("%s:%d -> %s:%d\n", saddr, sport, daddr, dport);
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
+	if (fd < 0)
+		die_perror("Netlink socket");
+
+	r.id.idiag_sport = htons(sport);
+	r.id.idiag_dport = htons(dport);
+
+	inet_pton(AF_INET, saddr, &r.id.idiag_src);
+	inet_pton(AF_INET, daddr, &r.id.idiag_dst);
+	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
+	send_query(fd, &r, IPPROTO_TCP);
+	recv_nlmsg(fd, IPPROTO_TCP);
+}
+
 static void parse_opts(int argc, char **argv, struct params *p)
 {
 	int c;
@@ -251,7 +399,7 @@ static void parse_opts(int argc, char **argv, struct params *p)
 	if (argc < 2)
 		die_usage(1);
 
-	while ((c = getopt(argc, argv, "ht:")) != -1) {
+	while ((c = getopt(argc, argv, "ht:s:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -259,6 +407,10 @@ static void parse_opts(int argc, char **argv, struct params *p)
 		case 't':
 			sscanf(optarg, "%x", &p->target_token);
 			break;
+		case 's':
+			snprintf(p->subflow_addrs, strlen(optarg) + 1,
+				 "%s", optarg);
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -275,6 +427,9 @@ int main(int argc, char *argv[])
 	if (p.target_token)
 		get_mptcpinfo(p.target_token);
 
+	if (strlen(p.subflow_addrs) != 0)
+		get_subflow_info(p.subflow_addrs);
+
 	return 0;
 }
 
-- 
2.43.0

