Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36037161310
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788931; cv=none; b=gr1EQFgy+XIcB9g5EjCuTNcaT6aDesGOtaLvaIPNFziV6WGE/P/QRiksh0Aa5J6Khq+ylwxPUf6Qha8RO35Q7QroV2Uau11+WaHx6mdWlrvWlUXiOTSYdvyKkU9lGi/QtAuIlsu1mk4/uXr9/AGqunT4VMKG93lAM94p1UvRL8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788931; c=relaxed/simple;
	bh=FTPDU2WjmnHKfWmgRWmpcMI2cB1K03US9BQl12M6GRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxeI01aA8e2bs6aY7fQhZVuzGdsRSnWoKEBTBS8A0DqOyO73sg2xO+L2DKNg/Ah+1mFGbnZBJqxW4812CipEWQq5/UKj6nKNpXWMYWyVmDmxCSJit2CRH5Tfj+gbqj8paB2eE7s9fzl7EJ3X9Q0be7WSw6FpWOnFvLFnz3Key4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b694e5a1a9511f0a216b1d71e6e1362-20250416
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
X-CID-O-INFO: VERSION:1.1.45,REQID:d223c18a-4d13-49db-9247-03f1b51baf13,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:d223c18a-4d13-49db-9247-03f1b51baf13,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:e42b566278685d825a3fd508fb64c3bd,BulkI
	D:250416153524Q2NAITM6,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5b694e5a1a9511f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1391373566; Wed, 16 Apr 2025 15:35:23 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [mptcp-next 5/7] selftests: mptcp: add a helper to get subflow_info
Date: Wed, 16 Apr 2025 15:35:00 +0800
Message-Id: <4147cca0b271a635059089415cf51a6072389c1c.1744788247.git.yangang@kylinos.cn>
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

This patch adds 'get_subflow_info' in 'mptcp_diag', which can check whether
a TCP connection is an MPTCP subflow based on the "INET_ULP_INFO_MPTCP"
with tcp_diag method.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 68 ++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 2116b40bc927..03c92940e461 100644
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
+	char subflow_addr[1024];
 };
 
 struct mptcp_info {
@@ -58,7 +64,9 @@ static void die_perror(const char *msg)
 
 static void die_usage(int r)
 {
-	fprintf(stderr, "Usage: mptcp_diag -t\n");
+	fprintf(stderr, "Usage:\n"
+			"mptcp_diag -t <token>\n"
+			"mptcp_diag -s \"<saddr> <sport> <daddr> <dport>\"\n");
 	exit(r);
 }
 
@@ -182,6 +190,21 @@ static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
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
+		} else {
+			printf("It's a normal TCP!\n");
+		}
+	}
 }
 
 static void recv_nlmsg(int fd, __u32 proto)
@@ -244,6 +267,41 @@ static void get_mptcpinfo(__u32 token)
 	close(fd);
 }
 
+static void get_subflow_info(char *subflow_addr)
+{
+	struct inet_diag_req_v2 r = {
+		.sdiag_family           = AF_INET,
+		.sdiag_protocol         = IPPROTO_TCP,
+	};
+	int sport, dport;
+	char saddr[64];	// Take ipv6 into consideration
+	char daddr[64];
+	int ret;
+	int fd;
+
+	ret = sscanf(subflow_addr, "%s %d %s %d", saddr, &sport, daddr, &dport);
+	if (ret != 4)
+		die_perror("IP PORT Pairs has style problems!");
+
+	printf("%s:%d -> %s:%d\n", saddr, sport, daddr, dport);
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
+	if (fd < 0)
+		die_perror("Netlink socket");
+
+	r.id.idiag_cookie[0] = INET_DIAG_NOCOOKIE;
+	r.id.idiag_cookie[1] = INET_DIAG_NOCOOKIE;
+	r.id.idiag_sport = htons(sport);
+	r.id.idiag_dport = htons(dport);
+	r.id.idiag_if = 0;
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
@@ -251,7 +309,7 @@ static void parse_opts(int argc, char **argv, struct params *p)
 	if (argc < 2)
 		die_usage(1);
 
-	while ((c = getopt(argc, argv, "ht:")) != -1) {
+	while ((c = getopt(argc, argv, "ht:s:")) != -1) {
 		switch (c) {
 		case 'h':
 			die_usage(0);
@@ -259,6 +317,9 @@ static void parse_opts(int argc, char **argv, struct params *p)
 		case 't':
 			sscanf(optarg, "%x", &p->target_token);
 			break;
+		case 's':
+			snprintf(p->subflow_addr, strlen(optarg) + 1, "%s", optarg);
+			break;
 		default:
 			die_usage(1);
 			break;
@@ -275,6 +336,9 @@ int main(int argc, char *argv[])
 	if (p.target_token)
 		get_mptcpinfo(p.target_token);
 
+	if (strlen(p.subflow_addr) != 0)
+		get_subflow_info(p.subflow_addr);
+
 	return 0;
 }
 
-- 
2.25.1

