Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270038757C
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973777; cv=none; b=BX0U5mXHunUGqLfKSEt6Wru5Cg2XqYavsU2aN7lfBr/w9F4L/cOf5sTWF1CE7YXUfyB4eEvl/dXv7yaRdAc9lqlNZdyX++rE++ZzQdR8BlWiK/6PLi6EbcQvb6IYaWaphqMHYIEwignk48D9+7xmuJiKVjs197WYl20AZgAkQXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973777; c=relaxed/simple;
	bh=rTujbHuGrjuFT+r/WmDsrXTLxMSKR/9oK18VpERj3Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WThKx417vmNvJsyIy8vYGdWAEqZG/1tcD1ffKfHNvD2zbAPcb66qsah+h8uroO7nIGWebrD9dls/CGimSdX+31AnIx5TGQJRM3suGo1b0+KYshvH6jJ+xIdhW/LB4xVOXT2xsNz7R1yS++j3ZDPG4gawg5qWrsNjqLQ+Tc7AQm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6090a26a75df11f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:73651228-c5d8-4bc0-87c0-819cf03ca1c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:4e1ca82c8d27e055e0a9a2812ac9ff8b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6090a26a75df11f1aa26b74ffac11d73-20260702
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 580479447; Thu, 02 Jul 2026 14:29:28 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	yijiangshan@kylinos.cn
Subject: [PATCH mptcp-next v3] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info()
Date: Thu,  2 Jul 2026 14:29:09 +0800
Message-Id: <20260702062909.4147641-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f66bcc626255440b7fc7ef8c2a9b9dde0675f30e.camel@kernel.org>
References: <f66bcc626255440b7fc7ef8c2a9b9dde0675f30e.camel@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_subflow_info() parses the subflow address string with:

	char saddr[64], daddr[64];

	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
		     saddr, &sport, daddr, &dport);

The subflow_addrs buffer holds up to 1024 bytes and is taken directly
from the command line ("-c" argument). The "%[^:]" conversions have no
maximum field width, so if the address substring before the ':' exceeds
63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr stack
buffers. This overflows the stack, corrupting adjacent stack data such
as the saved return address, and can crash the tool or lead to
out-of-bounds writes controlled by user-supplied input.

Bound both string conversions to the destination buffer size by adding
an explicit maximum field width of 63 (leaving room for the terminating
NUL), so at most 63 bytes are written into each 64-byte buffer:

	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
		     saddr, &sport, daddr, &dport);

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
v3:
 - drop the Fixes tag: this is a cleanup/hardening, not a fix (Geliang)
 - drop the Suggested-by tag, keep Geliang's Reviewed-by (Geliang)
v2:
 - add field width to sscanf() (fix >80 col warning, MPTCP CI)
 - fix subject prefix: mptcp_diag: -> diag: (Geliang)
v1: 
 - initial submission

 tools/testing/selftests/net/mptcp/mptcp_diag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 5e222ba977e4..3b8d2c8a6216 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -377,7 +377,8 @@ static void get_subflow_info(char *subflow_addrs)
 	int ret;
 	int fd;
 
-	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
+	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
+		     saddr, &sport, daddr, &dport);
 	if (ret != 4)
 		die_perror("IP PORT Pairs has style problems!");
 
-- 
2.25.1

