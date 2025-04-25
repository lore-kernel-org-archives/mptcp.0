Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A607129A78
	for <mptcp@lists.linux.dev>; Fri, 25 Apr 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561937; cv=none; b=e0FWgKp0Nc3PhbzAEgWqdAI9/Phlrct1DpIH0ex6+37RPoMnobdm2XorQvKlc/pS2ntuOKeh+AhXEE+EvViEfgHL2F31OUk2okpLfPj0OARifxvLJxhxqV21MBWLKYh9Xa3JfZlulnvxUqSj1GX9KRUGF9wCueXzZ83ISYvvigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561937; c=relaxed/simple;
	bh=oBjSeZ32a1uFeKTqSmfl6nuuPZKQ8FGdoxYRIm950lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D5/Z6YX2w42wwAgslvBvvBoGirU/uuYK0GK+p1XlmE7y20Ek3lJukJe72WNrF5AxovMDo0J78Uv7Vf45B8EoTqJaWR7/NyghbJ1U0uta8wr6DpKBZrNCQ10Xdi0wCS/iQ3v6P1wAz7SR929+ASWnsmyYiJ5T0Tw0o18yLilOYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2730fb60219d11f0a216b1d71e6e1362-20250425
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
X-CID-O-INFO: VERSION:1.1.45,REQID:eae4fa78-f499-4c02-b9bd-8ff4c2c5079d,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:eae4fa78-f499-4c02-b9bd-8ff4c2c5079d,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:11488030d83c6ed76ca088ad7c58720f,BulkI
	D:250425141850A0OQS8PK,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil
	,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 2730fb60219d11f0a216b1d71e6e1362-20250425
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1815971606; Fri, 25 Apr 2025 14:18:49 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v3 1/5] selftests: mptcp: add struct params in mptcp_diag
Date: Fri, 25 Apr 2025 14:18:39 +0800
Message-Id: <c3e4c6c63d49085e0f35efc89585a1ac9adb70c5.1745395366.git.yangang@kylinos.cn>
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

This patch adds a struct named 'params' to save 'target_token' and other
future parameters. This structure facilitates future function expansions.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 37d5015ad08c..ea7cb1128044 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -19,6 +19,10 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+struct params {
+	__u32 target_token;
+};
+
 struct mptcp_info {
 	__u8	mptcpi_subflows;
 	__u8	mptcpi_add_addr_signal;
@@ -237,7 +241,7 @@ static void get_mptcpinfo(__u32 token)
 	close(fd);
 }
 
-static void parse_opts(int argc, char **argv, __u32 *target_token)
+static void parse_opts(int argc, char **argv, struct params *p)
 {
 	int c;
 
@@ -250,7 +254,7 @@ static void parse_opts(int argc, char **argv, __u32 *target_token)
 			die_usage(0);
 			break;
 		case 't':
-			sscanf(optarg, "%x", target_token);
+			sscanf(optarg, "%x", &p->target_token);
 			break;
 		default:
 			die_usage(1);
@@ -261,10 +265,12 @@ static void parse_opts(int argc, char **argv, __u32 *target_token)
 
 int main(int argc, char *argv[])
 {
-	__u32 target_token;
+	struct params p = { 0 };
+
+	parse_opts(argc, argv, &p);
 
-	parse_opts(argc, argv, &target_token);
-	get_mptcpinfo(target_token);
+	if (p.target_token)
+		get_mptcpinfo(p.target_token);
 
 	return 0;
 }
-- 
2.43.0

