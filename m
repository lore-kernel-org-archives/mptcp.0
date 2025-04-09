Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C31D8A0A
	for <mptcp@lists.linux.dev>; Wed,  9 Apr 2025 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744183414; cv=none; b=NF6Qy7ai9n3R801gLTa23Bri/C//Q+PNXageUeKUwi3twopNatxT9nVyW+oxGIPPJvcD2xObAYUU9VqG/bqBZ/bcgg3avFmVNATPlH1CB/QFREEeiqZna5MI63RqRzHDzeJr8zSAmVBzNoKF3hjU63jACtBNw69Fzx9C/yu09rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744183414; c=relaxed/simple;
	bh=rFMa7Q7kawTGme5Bn2yO+EiEoyqUUKpi5drv4UtLjy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=avMy0xSFOzz3MG6Hjlgn5/Q3Nw0ASmoNIVHzdWQdAQkjBLf60yS+Xm++Wkr+/3c9bEpPfSeQ5LbBStQVssTnWix5X7+TLylOd0KmiLgnrqQaRftuAzNb0Zh+EpHP+oVRflxLd7WEhZHCE+nGMh4i3JZKzUcJY+fe4w/MaSta+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cd94d0c2151211f0a216b1d71e6e1362-20250409
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI
	GTI_FG_IT, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_T2
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:49beea58-c876-482c-9fa1-953411eaba89,IP:10,
	URL:25,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:40
X-CID-INFO: VERSION:1.1.45,REQID:49beea58-c876-482c-9fa1-953411eaba89,IP:10,UR
	L:25,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:40
X-CID-META: VersionHash:6493067,CLOUDID:7a668808acb562abfb48cdadb17a9206,BulkI
	D:250409151816EX2XTOET,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: cd94d0c2151211f0a216b1d71e6e1362-20250409
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 777810858; Wed, 09 Apr 2025 15:18:15 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [Patch, v2, 2/2] BCC: python: add a useful tool for mptcp
Date: Wed,  9 Apr 2025 15:17:53 +0800
Message-Id: <cde026e8afeec48569765f7590ee0ca8fd14b57f.1744182834.git.yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744182834.git.yangang@kylinos.cn>
References: <cover.1744182834.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multipath TCP (MPTCP) is an extension of the standard TCP protocol
that allows a single transport connection to use multiple network
interfaces or paths. MPTCP is useful for applications like bandwidth
aggregation, failover, and more resilient connections.

Linux kernel starts to support MPTCP since v5.6, this patch provides
a method which can easily force applications use MPTCP socket without
modifing its code.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/mptcpify.py  | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 tools/mptcpify.txt | 22 +++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 tools/mptcpify.py
 create mode 100644 tools/mptcpify.txt

diff --git a/tools/mptcpify.py b/tools/mptcpify.py
new file mode 100644
index 00000000..efdbd910
--- /dev/null
+++ b/tools/mptcpify.py
@@ -0,0 +1,80 @@
+#!/usr/bin/env python
+#
+# mptcpify Make the applications to use MPTCP.
+#           For Linux, uses BCC, eBPF. Embedded C.
+#
+# USAGE: mptcpify -t
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
+         description="mptcpify try to force applications to use MPTCP instead of TCP")
+parser.add_argument("-t", "--targets", required=True, type=str,
+                    help="use ',' for multi targets, eg: 'iperf3,rsync'")
+
+args_str = parser.parse_args()
+args_list = [t.strip() for t in args_str.targets.split(',')]
+
+if (not BPF.support_fmod_ret()):
+    print("Your kernel version is too old,"
+          " fmod_ret method is only support kernel v5.7 and later.")
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
+        (!protocol || protocol == IPPROTO_TCP) &&
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
+print("MPTCP is been forced for ", args_list);
+signal.pause()
+
diff --git a/tools/mptcpify.txt b/tools/mptcpify.txt
new file mode 100644
index 00000000..adef70ea
--- /dev/null
+++ b/tools/mptcpify.txt
@@ -0,0 +1,22 @@
+Demonstrations of mptcpify, the Linux eBPF/bcc version.
+
+
+mptcpify forces the application to use to MPTCP instead of TCP.
+
+mptcpify has been verified with iperf3 and rsync[TCP module]. It can be used
+for incresing the speed of transferring data with rsync.
+
+The MPTCP configuration is decribed in
+https://www.mptcp.dev/pm.html
+
+USAGE message:
+
+usage: sudo python ./mptcpify.py [-h] -t TARGETS
+
+mptcpify try to force applications to use MPTCP instead of TCP
+
+options:
+  -h, --help            show this help message and exit
+  -t TARGETS, --targets TARGETS
+                        use ',' for multi targets, eg: 'iperf3,rsync'
+
-- 
2.25.1

