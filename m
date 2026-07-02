Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496552E0901
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 04:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782965498; cv=none; b=EMhBtxm/dkSo46h1rGxodl7WBlFQyzaJpiPejr9uGFXvUzwfkkeZD+ATG0omxfduK7TgtSiboOgY83+w7IpytzEcrUL6alaPUjlQXEv9pFyMFrXxLuCS90epo9JQpVESs8DkTA0s4q4lBVlJHYbZxLfaS/wTOAnRdGjipGA4AQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782965498; c=relaxed/simple;
	bh=yL4mgM2ve0Pu0dE5GiiOUHnXv2gPpeHlbZBXyCCI7y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TBgPLfTUUEC6SNzNSTGJAEvRUVU2alcMwJDHTHbyvCTvFRLMAhjv9pkzfBrtEWV+zCMN2Ln5qM4V06DuAAQXDylSGId/3ip3Q8HYPjxaNDMVdDWZvrEICQQtyeUyIwPi6mMTE4Pg65e5O2sv5SFhi3SVftwNDGXkmI2rMYIcMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 187e172275cc11f1aa26b74ffac11d73-20260702
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:00651456-f1d6-471a-880c-c9b7d96293ed,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:d32dc37e10a1e364cd500ada2266f24d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 187e172275cc11f1aa26b74ffac11d73-20260702
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 252452591; Thu, 02 Jul 2026 12:11:26 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	yijiangshan@kylinos.cn
Subject: [PATCH mptcp-next v2] selftests: mptcp: diag: fix stack buffer overflow in get_subflow_info()
Date: Thu,  2 Jul 2026 12:11:18 +0800
Message-Id: <20260702041118.2193877-1-yijiangshan@kylinos.cn>
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

Fixes: c7ac7452df70 ("selftests: mptcp: add helpers to get subflow_info")
Suggested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
v2:
 - add field width to sscanf() (fix >80 col warning, MPTCP CI)
 - fix subject prefix: mptcp_diag: -> diag: (Geliang Tang)

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

