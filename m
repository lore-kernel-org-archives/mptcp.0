Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE5223321
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788931; cv=none; b=flfHygNkOX0P7bM53yJCV/0y/BtMkBhHwcotolMW2apD/gM9pwTR8cYRSBIJypRhKUNm7Br0I01IPbg9GETiaTwtHqbLzUXQoZhsn71qx7+U5O5U2/NqpUmrq/OgxCgcY7z9ff5xzYGGyrQ6Gg4rjdUVryOm5sMOexQaKmPzVOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788931; c=relaxed/simple;
	bh=szdCIUhh36euvta9ld5fXdLJU53+1uLSY44TeKLyhpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qxplAaeqZApTP5lZ+j5rwFlCxpafQuPqcna2yVopmqvG8u0CkinJ281QdD5SEX4r2hQmw71urgjlk+5T4JoEmRBg2DYv/IXMhGsepnTN4DYyd39mqqg/+c91h5JPw7o5OfL+g9NrRCA+StWUhALi9PVENP1h7jIPXzaPFLsZy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5af2eeae1a9511f0a216b1d71e6e1362-20250416
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
X-CID-O-INFO: VERSION:1.1.45,REQID:66f53f72-1d02-4547-a380-01b53e43ba3d,IP:10,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:66f53f72-1d02-4547-a380-01b53e43ba3d,IP:10,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:e00b5d22f7555ca02cd1addc44314817,BulkI
	D:250416153524UFUMVPOK,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 5af2eeae1a9511f0a216b1d71e6e1362-20250416
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2120939587; Wed, 16 Apr 2025 15:35:22 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [mptcp-next 4/7] selftests: mptcp: refactor NLMSG handling with 'proto'
Date: Wed, 16 Apr 2025 15:34:59 +0800
Message-Id: <ad68913aee5195e61915629f1d912b9a28244302.1744788247.git.yangang@kylinos.cn>
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

This patch introduces the '__u32 proto' variable to the 'send_query' and
'recv_nlmsg' functions for further extending function.

In the 'send_query' function, the inclusion of this variable makes the
structure clearer and more readable.

In the 'recv_nlmsg' function, the '__u32 proto' variable ensures that
the 'diag_info' field remains unmodified when processing IPPROTO_TCP data,
thereby preventing unintended transformation into 'mptcp_info' format.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_diag.c  | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 2bf13bce59a5..2116b40bc927 100644
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
@@ -81,19 +81,21 @@ static void send_query(int fd, struct inet_diag_req_v2 *r)
 	struct rtattr rta_proto;
 	struct iovec iov[6];
 	int iovlen = 1;
-	__u32 proto;
-
-	proto = IPPROTO_MPTCP;
-	rta_proto.rta_type = INET_DIAG_REQ_PROTOCOL;
-	rta_proto.rta_len = RTA_LENGTH(sizeof(proto));
 
 	iov[0] = (struct iovec) {
 		.iov_base = &req,
 		.iov_len = sizeof(req)
 	};
-	iov[iovlen++] = (struct iovec){ &rta_proto, sizeof(rta_proto)};
-	iov[iovlen++] = (struct iovec){ &proto, sizeof(proto)};
-	req.nlh.nlmsg_len += RTA_LENGTH(sizeof(proto));
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
@@ -157,7 +159,7 @@ static void print_info_msg(struct mptcp_info *info)
 	printf("bytes_acked:      %llu\n", info->mptcpi_bytes_acked);
 }
 
-static void parse_nlmsg(struct nlmsghdr *nlh)
+static void parse_nlmsg(struct nlmsghdr *nlh, __u32 proto)
 {
 	struct inet_diag_msg *r = NLMSG_DATA(nlh);
 	struct rtattr *tb[INET_DIAG_MAX + 1];
@@ -166,7 +168,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 			   nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)),
 			   NLA_F_NESTED);
 
-	if (tb[INET_DIAG_INFO]) {
+	if (proto == IPPROTO_MPTCP && tb[INET_DIAG_INFO]) {
 		int len = RTA_PAYLOAD(tb[INET_DIAG_INFO]);
 		struct mptcp_info *info;
 
@@ -182,7 +184,7 @@ static void parse_nlmsg(struct nlmsghdr *nlh)
 	}
 }
 
-static void recv_nlmsg(int fd)
+static void recv_nlmsg(int fd, __u32 proto)
 {
 	char rcv_buff[8192];
 	struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buff;
@@ -215,7 +217,7 @@ static void recv_nlmsg(int fd)
 			       -(err->error), strerror(-(err->error)));
 			break;
 		}
-		parse_nlmsg(nlh);
+		parse_nlmsg(nlh, proto);
 		nlh = NLMSG_NEXT(nlh, len);
 	}
 }
@@ -228,6 +230,7 @@ static void get_mptcpinfo(__u32 token)
 		.sdiag_protocol         = IPPROTO_TCP,
 		.id.idiag_cookie[0]     = token,
 	};
+	__u32 proto = IPPROTO_MPTCP;
 	int fd;
 
 	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
@@ -235,8 +238,8 @@ static void get_mptcpinfo(__u32 token)
 		die_perror("Netlink socket");
 
 	r.idiag_ext |= (1 << (INET_DIAG_INFO - 1));
-	send_query(fd, &r);
-	recv_nlmsg(fd);
+	send_query(fd, &r, proto);
+	recv_nlmsg(fd, proto);
 
 	close(fd);
 }
-- 
2.25.1

