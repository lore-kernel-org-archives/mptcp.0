Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C681A08B5
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993464; cv=none; b=azwVigvetFR2T4351I0wvqnYuCRgtdPpkHkwRTGGBIbWMSv3hAbYXfvl7pujPIrlI2rymaxaiEe7MN5M11+5njU52/bJbl98dZ1FR/tuHFSNJaIUAcxg6J159YBuWMKtDB6PMLSZyBV6D+1qiI1mUxDlYfOwZFCfeACKHkhyEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993464; c=relaxed/simple;
	bh=dYYjTwJOfrG61YEz/Pk4l7r2Ed4D2BM63SKfWCDm9X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=orVoSeblNMVN0bv4eaktRTgynqxHMUeHehUW+oanRL+751LReexUW5gX5moiKImNhm2tq1uR4lyJXgwfH65oEEmT3GxA90PQtNpDXYuBoKI67wjHh8YvvF71fZZzw0i+ohxNBM4pOFIxF4N7b0IoAGqhDsJsR8NM9FOGKiDA4pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 43a356fa135911f0a216b1d71e6e1362-20250407
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_T2
	AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1af8d6c2-8897-41f6-98b7-df5879744024,IP:10,
	URL:25,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:15
X-CID-INFO: VERSION:1.1.45,REQID:1af8d6c2-8897-41f6-98b7-df5879744024,IP:10,UR
	L:25,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-META: VersionHash:6493067,CLOUDID:87b9937af3c398f87e2ca4856a528616,BulkI
	D:250407103737FTW03TZM,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS
	:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,A
	RC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 43a356fa135911f0a216b1d71e6e1362-20250407
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1614849711; Mon, 07 Apr 2025 10:37:35 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 2/2] BCC: python: add a useful tool for mptcp
Date: Mon,  7 Apr 2025 10:37:22 +0800
Message-Id: <df79879bf4e8c5c73ffcc557cdb6f517e29ccae7.1743988616.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1743988616.git.yangang@kylinos.cn>
References: <cover.1743988616.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multipath TCP (MPTCP) is an extension of the standard TCP protocol
that allows a single transport connection to use multiple network
interfaces. MPTCP is useful for applications like bandwidth
aggregation, failover, and more resilient connections.

Linux kernel starts to support MPTCP since v5.6, this patch provides
a method which can easily force applications use MPTCP socket without
modifing its code.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/mptcpboost.py  | 82 ++++++++++++++++++++++++++++++++++++++++++++
 tools/mptcpboost.txt | 22 ++++++++++++
 2 files changed, 104 insertions(+)
 create mode 100644 tools/mptcpboost.py
 create mode 100644 tools/mptcpboost.txt

diff --git a/tools/mptcpboost.py b/tools/mptcpboost.py
new file mode 100644
index 00000000..0ddd731a
--- /dev/null
+++ b/tools/mptcpboost.py
@@ -0,0 +1,82 @@
+#!/usr/bin/env python
+#
+# mptcpboost Make the applications to use MPTCP.
+#           For Linux, uses BCC, eBPF. Embedded C.
+#
+# USAGE: mptcpboost -t
+#
+# Copyright 2025 Kylin Software, Inc.
+# Licensed under the Apache License, Version 2.0 (the "License")
+#
+# 05-Apr-2025   Gang Yan   Created this.
+
+import ctypes as ct
+import argparse
+import signal
+import time
+
+from bcc import BPF
+
+#arguments
+parser = argparse.ArgumentParser(
+         description="mptcpboost try to force applications use MPTCP")
+parser.add_argument("-t", "--targets", required=True, type=str,
+                    help="use ',' for multi targets, eg: 'iperf3,rsync'")
+
+args_str = parser.parse_args()
+args_list = [t.strip() for t in args_str.targets.split(',')]
+
+if (not BPF.support_fmod_ret()):
+    print("Your kernel version is too old,"
+          " fmod_ret method is only support kernel v5.6 and later.")
+    exit()
+
+TASK_COMM_LEN = 18
+
+class app_name(ct.Structure):
+    _fields_ = [("str", ct.c_char * TASK_COMM_LEN)]
+
+# define BPF program
+prog = """
+#include <linux/net.h>
+#include <uapi/linux/in.h>
+#include <linux/string.h>
+
+struct app_name {
+    char name[TASK_COMM_LEN];
+};
+
+BPF_HASH(support_apps, struct app_name);
+
+KMOD_RET(update_socket_protocol, int family, int type, int protocol, int ret)
+{
+    struct app_name target = {};
+    bpf_get_current_comm(&target.name, TASK_COMM_LEN);
+
+    if ((family == AF_INET || family == AF_INET6) &&
+        type == SOCK_STREAM &&
+        (!protocol || protocol ==IPPROTO_TCP) &&
+        support_apps.lookup(&target))
+        return IPPROTO_MPTCP;
+
+    return protocol;
+
+}
+
+"""
+
+b = BPF(text=prog)
+b.attach_fmod_ret("update_socket_protocol")
+
+support_apps = b.get_table("support_apps")
+for i in args_list:
+    app = i.encode()
+    name = app_name()
+    name.str = app[:TASK_COMM_LEN-1].ljust(TASK_COMM_LEN, b'\0')
+    support_apps[name] = ct.c_uint32(1)
+
+print("MPTCP is been applied in ", args_list);
+signal.pause()
+#while(1):
+#   time.sleep(200)
+
diff --git a/tools/mptcpboost.txt b/tools/mptcpboost.txt
new file mode 100644
index 00000000..114a1c8b
--- /dev/null
+++ b/tools/mptcpboost.txt
@@ -0,0 +1,22 @@
+Demonstrations of mptcpboost, the Linux eBPF/bcc version.
+
+
+mptcpboost forces the application to use MPTCP instead of TCP.
+
+mptcpboost has been verified with iperf3 and rsync[TCP module]. It can be used
+for incresing the speed of transferring data with rsync.
+
+The MPTCP configuration is decribed in
+https://www.mptcp.dev/pm.html
+
+USAGE message:
+
+usage: test.py [-h] -t TARGETS
+
+mptcpboost try to force applications use MPTCP
+
+options:
+  -h, --help            show this help message and exit
+  -t TARGETS, --targets TARGETS
+                        use ',' for multi targets, eg: 'iperf3,rsync'
+
-- 
2.25.1

