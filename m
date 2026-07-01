Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B64426EAE
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902306; cv=none; b=Dqo9e0XoM24nh2EdZUrGmodvtzs5ILKyj9ArJ4Nnqv6wGyfpZGF6IF+f5fJuy3zV/RCNCGq/j9Uxzh+zL8HtbPa+YONIxDSPvJYgPHbUORmfs4O0FGHHNXrABFX1g6raOHwdqkcI+QhpuXYjUJNJIVZop9zjxo91iWyLHJwijWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902306; c=relaxed/simple;
	bh=/viK3Nd+7xZV4w6XcuB2tRZQ2EjZ5ngGTvToKYdql7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BsVA9w41pk8oeGKpaM8dpiDwAHVCCEPGYrDK1ZW9iEG3izXPrj47aITfrRl2uW8AtCulbICRPb9KJccmsKGAq+9flhcg7CenjhwQpEKO3gr0PdmXUtkufPlp6ejjIK5mHFWByqivpXyygRtzyoy3JNO33qciTC07abUqOZFkY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f67ed0aa753811f1aa26b74ffac11d73-20260701
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:77648119-f14a-49de-a12e-057d135df188,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:101142069bfd13c8603bea6829cfe43f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f67ed0aa753811f1aa26b74ffac11d73-20260701
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1628733620; Wed, 01 Jul 2026 18:38:13 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: geliang@kernel.org,
	martineau@kernel.org,
	matttbe@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] selftests: mptcp: mptcp_diag: fix stack buffer overflow in get_subflow_info()
Date: Wed,  1 Jul 2026 18:38:09 +0800
Message-Id: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 5e222ba977e4..02ac93f794fe 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -377,7 +377,7 @@ static void get_subflow_info(char *subflow_addrs)
 	int ret;
 	int fd;
 
-	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr, &sport, daddr, &dport);
+	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d", saddr, &sport, daddr, &dport);
 	if (ret != 4)
 		die_perror("IP PORT Pairs has style problems!");
 
-- 
2.25.1

