Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D23A1E3DFE
	for <mptcp@lists.linux.dev>; Thu, 20 Feb 2025 07:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035540; cv=none; b=owmW5jez3ZytL2n28qzVGdgBy7txq0cGa16uSiVtmc+kXDr0hm0EPg176KXS/htfqMdDbNBlXqO5HQ0pp3mPAfzGvhwAym8LN4kmLbaCVHDxNXCbmhxhPK0Rc1pKHiv9Ut2Iu1jV3lmAkJIhLw26ehzn6DOuVZbrf6ME+dOgQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035540; c=relaxed/simple;
	bh=OjHNsyqtUOFL7sYBd7+C73H6yxM6ufTJYcROAkyJSgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pY0QiiYxyv/Zw8zLVeriHAZ7mLzettVxaq8wmb8cUvM+iWpRSW9Ij2noDJfaXiESdDnuM1m/cwmwf24NS72SDnxJXd+dQy5vtTCMySVgktMXeEHTDsAfeZlsQpa5WvCB2XVLfBVgQdzHIBgDVpLH5o0q5GkCcmb0fUFGQyJeRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fb7a8e48ef5911efa216b1d71e6e1362-20250220
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2b54dc75-280d-40b6-b717-935b23c830c5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:2b54dc75-280d-40b6-b717-935b23c830c5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:97ca54fe47ad279740319fbee0f22090,BulkI
	D:250220151203B5TALKAH,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: fb7a8e48ef5911efa216b1d71e6e1362-20250220
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1850780000; Thu, 20 Feb 2025 15:12:02 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-next v2 1/2] selftests: mptcp: Add a tool to get specific msk_info
Date: Thu, 20 Feb 2025 15:11:24 +0800
Message-Id: <3b120e58e14cc6884bc53545ea1c80bca3fb43f7.1740035000.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1740035000.git.yangang@kylinos.cn>
References: <cover.1740035000.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables the retrieval of the mptcp_info structure corresponding
to a specified MPTCP socket (msk). When multiple MPTCP connections are
present, specific information can be obtained for a given connection
through the 'mptcp_diag_dump_one' by using the 'token' associated with
the msk.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile    |   2 +-
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 235 ++++++++++++++++++
 2 files changed, 236 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/mptcp/mptcp_diag.c

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index c76525fe2b84..340e1a777e16 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -7,7 +7,7 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
-TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq
+TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
 
 TEST_FILES := mptcp_lib.sh settings
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
new file mode 100644
index 000000000000..3e0be9e58912
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025, Kylin Software*/
+
+#include <linux/sock_diag.h>
+#include <linux/rtnetlink.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <linux/tcp.h>
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdio.h>
+
+#ifndef IPPROTO_MPTCP
+#define IPPROTO_MPTCP 262
+#endif
+
+#ifndef MPTCP_INFO
+struct mptcp_info {
+	__u8    mptcpi_subflows;
+	__u8    mptcpi_add_addr_signal;
+	__u8    mptcpi_add_addr_accepted;
+	__u8    mptcpi_subflows_max;
+	__u8    mptcpi_add_addr_signal_max;
+	__u8    mptcpi_add_addr_accepted_max;
+	__u32   mptcpi_flags;
+	__u32   mptcpi_token;
+	__u64   mptcpi_write_seq;
+	__u64   mptcpi_snd_una;
+	__u64   mptcpi_rcv_nxt;
+	__u8    mptcpi_local_addr_used;
+	__u8    mptcpi_local_addr_max;
+	__u8    mptcpi_csum_enabled;
+	__u32   mptcpi_retransmits;
+	__u64   mptcpi_bytes_retrans;
+	__u64   mptcpi_bytes_sent;
+	__u64   mptcpi_bytes_received;
+	__u64   mptcpi_bytes_acked;
+};
+
+#define MPTCP_INFO              1
+#endif
+
+static void die_perror(const char *msg)
+{
+	perror(msg);
+	exit(1);
+}
+
+static void die_usage(int r)
+{
+	fprintf(stderr, "Usage: mptcp_diag -t\n");
+	exit(r);
+}
+
+static void send_query(int fd, __u32 token)
+{
+	struct sockaddr_nl nladdr = {
+		.nl_family = AF_NETLINK
+	};
+	struct {
+		struct nlmsghdr nlh;
+		struct inet_diag_req_v2 r;
+	} req = {
+		.nlh = {
+			.nlmsg_len = sizeof(req),
+			.nlmsg_type = SOCK_DIAG_BY_FAMILY,
+			.nlmsg_flags = NLM_F_REQUEST
+		},
+		.r = {
+			.sdiag_family = AF_INET,
+			.sdiag_protocol = IPPROTO_MPTCP,
+			.id.idiag_cookie[0] = token,
+		}
+	};
+	struct rtattr rta_proto;
+	struct iovec iov[6];
+	int iovlen = 1;
+	__u32 proto;
+
+	req.r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
+	proto = IPPROTO_MPTCP;
+	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
+	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
+
+	iov[0] = (struct iovec) {
+		.iov_base = &req,
+		.iov_len = sizeof(req)
+	};
+	iov[iovlen] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
+	iov[iovlen + 1] = (struct iovec){ &proto, sizeof(proto)};
+	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
+	iovlen += 2;
+	struct msghdr msg = {
+		.msg_name = &nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = iov,
+		.msg_iovlen = iovlen
+	};
+
+	for (;;) {
+		if (sendmsg(fd, &msg, 0) < 0) {
+			if (errno == EINTR)
+				continue;
+			die_perror("sendmsg");
+		}
+		break;
+	}
+}
+
+static void parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta,
+		       int len, unsigned short flags)
+{
+	unsigned short type;
+
+	memset(tb, 0, sizeof(struct rtattr *) * (max + 1));
+	while (RTA_OK(rta, len)) {
+		type = rta->rta_type & ~flags;
+		if ((type <= max) && (!tb[type]))
+			tb[type] = rta;
+		rta = RTA_NEXT(rta, len);
+	}
+}
+
+static struct mptcp_info *parse_nlmsg(struct nlmsghdr *nlh)
+{
+	struct inet_diag_msg *r = NLMSG_DATA(nlh);
+	struct rtattr *tb[INET_DIAG_MAX+1];
+	struct mptcp_info *info;
+
+	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
+			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
+			   NLA_F_NESTED);
+
+	if (tb[INET_DIAG_INFO]) {
+		info = RTA_DATA(tb[INET_DIAG_INFO]);
+		return info;
+	}
+
+	die_perror("Has no INET_DIAG_INFO");
+	return info;
+}
+
+static struct mptcp_info *recv_nlmsg(int fd, struct nlmsghdr *nlh)
+{
+	char rcv_buff[8192];
+	struct sockaddr_nl rcv_nladdr = {
+		.nl_family = AF_NETLINK
+	};
+	struct iovec rcv_iov = {
+		.iov_base = rcv_buff,
+		.iov_len = sizeof(rcv_buff)
+	};
+	struct msghdr rcv_msg = {
+		.msg_name = &rcv_nladdr,
+		.msg_namelen = sizeof(rcv_nladdr),
+		.msg_iov = &rcv_iov,
+		.msg_iovlen = 1
+	};
+	struct mptcp_info *info = NULL;
+	int len;
+
+	len = recvmsg(fd, &rcv_msg, 0);
+	nlh = (struct nlmsghdr *)rcv_buff;
+
+	while (NLMSG_OK(nlh, len)) {
+		if (nlh->nlmsg_type == NLMSG_DONE) {
+			printf("NLMSG_DONE\n");
+			break;
+		} else if (nlh->nlmsg_type == NLMSG_ERROR) {
+			struct nlmsgerr *err;
+
+			err = (struct nlmsgerr *)NLMSG_DATA(nlh);
+			printf("Error %d:%s\n", -(err->error), strerror(-(err->error)));
+			break;
+		}
+		info = parse_nlmsg(nlh);
+		nlh = NLMSG_NEXT(nlh, len);
+	}
+	close(fd);
+	return info;
+}
+
+static struct mptcp_info *get_mptcpinfo(__u32 token)
+{
+	struct nlmsghdr *nlh = NULL;
+	int fd;
+
+	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
+	if (fd < 0)
+		die_perror("Netlink socket");
+
+	send_query(fd, token);
+	return recv_nlmsg(fd, nlh);
+}
+
+static void parse_opts(int argc, char **argv, __u32 *target_token)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "ht:")) != -1) {
+		switch (c) {
+		case 'h':
+			die_usage(1);
+			break;
+		case 't':
+			sscanf(optarg, "%x", target_token);
+			break;
+		default:
+			die_usage(1);
+			break;
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct mptcp_info *info = NULL;
+	__u32 target_token;
+
+	parse_opts(argc, argv, &target_token);
+	info = get_mptcpinfo(target_token);
+
+	if (info)
+		printf("token:%x\n", info->mptcpi_token);
+	else
+		perror("No Such msk using this token!\n");
+
+	return 0;
+}
+
-- 
2.43.0

