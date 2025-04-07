Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617121957FC
	for <mptcp@lists.linux.dev>; Mon,  7 Apr 2025 02:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743993464; cv=none; b=GdNS/0r3b4q8Kh9vl6ad93E+3J0Tytq2I8TwBIopNu/nDsMNLdmB/Nt73u4CE/il+nCNGbiZTvLQcIsgiVDWOUnh38uiWnhjb+OnUivzQwlyuo1t+uWX9GP7ACLYgBtb1ijnGMjF3A032AOMOM4SWq+bMeAMAYVr7A+i9utC/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743993464; c=relaxed/simple;
	bh=vCKgWQYZ+oFRYYINl/Pyjbq+WzcmY2oA8CDuxj68cqo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+VrokbcuzpNkPMj7idwFDD/cPVgmgXG3y47/V1eigbhkQ0bh4qiGk92eOb//sy1f089KvxHGOO7C9eDe+sQ0Sl5Nkp4424xM+alI+onrqrkfucHnfuMMu1DbXsL2mRlEhX6BE9vaptV2HRoVwmdzXOZTNQb2+m1dkTNlAUjHoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 43212df6135911f0a216b1d71e6e1362-20250407
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b466e247-4903-456f-9984-354d0276482d,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:b466e247-4903-456f-9984-354d0276482d,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:b4f212daadfe24e1717756d1c30c8a0b,BulkI
	D:250405173411VOZTFZTV,BulkQuantity:4,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 43212df6135911f0a216b1d71e6e1362-20250407
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 298977056; Mon, 07 Apr 2025 10:37:34 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 1/2] BCC: Python: Support 'fmod_ret' method for eBPF
Date: Mon,  7 Apr 2025 10:37:21 +0800
Message-Id: <766ea5e9772f92d97100f8b52e70b2895c3de628.1743988616.git.yangang@kylinos.cn>
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

In kernel, there exists a lot of 'fmod_ret' functions, such as
'update_socket_protocol'. But it cannot be attached in BCC-python
directly, so this patch provides an interface for Python to use
'fmod_ret' attaching method.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 src/python/bcc/__init__.py | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/python/bcc/__init__.py b/src/python/bcc/__init__.py
index 8bc85516..96de3d40 100644
--- a/src/python/bcc/__init__.py
+++ b/src/python/bcc/__init__.py
@@ -461,6 +461,7 @@ class BPF(object):
         self.raw_tracepoint_fds = {}
         self.kfunc_entry_fds = {}
         self.kfunc_exit_fds = {}
+        self.fmod_ret_fds = {}
         self.lsm_fds = {}
         self.perf_buffers = {}
         self.open_perf_events = {}
@@ -1157,6 +1158,21 @@ class BPF(object):
             return True
         return False
 
+    @staticmethod
+    def support_fmod_ret():
+        if not BPF.support_kfunc():
+            return False
+
+        kernel_version = platform.release()
+        major, minor, _ = kernel_version.split(".")
+
+        if int(major) > 5:
+            return True
+        elif int(major) ==5 and int(minor) >= 6:
+            return True
+        else:
+            return False
+
     def detach_kfunc(self, fn_name=b""):
         fn_name = _assert_is_bytes(fn_name)
         fn_name = BPF.add_prefix(b"kfunc__", fn_name)
@@ -1166,6 +1182,15 @@ class BPF(object):
         os.close(self.kfunc_entry_fds[fn_name])
         del self.kfunc_entry_fds[fn_name]
 
+    def detach_fmod_ret(self, fn_name=b""):
+        fn_name = _assert_is_bytes(fn_name)
+        fn_name = BPF.add_prefix(b"kmod_ret__", fn_name)
+
+        if fn_name not in self.fmod_ret_fds:
+            raise Exception("Fmod_ret func %s is not attached" % fn_name)
+        os.close(self.fmod_ret_fds[fn_name])
+        del self.fmod_ret_fds[fn_name]
+
     def detach_kretfunc(self, fn_name=b""):
         fn_name = _assert_is_bytes(fn_name)
         fn_name = BPF.add_prefix(b"kretfunc__", fn_name)
@@ -1189,6 +1214,22 @@ class BPF(object):
         self.kfunc_entry_fds[fn_name] = fd
         return self
 
+    def attach_fmod_ret(self, fn_name=b""):
+        fn_name = _assert_is_bytes(fn_name)
+        fn_name = BPF.add_prefix(b"kmod_ret__", fn_name)
+
+        if fn_name in self.fmod_ret_fds:
+            raise Exception("Fmod_ret func %s has been attached" % fn_name)
+
+        fn = self.load_func(fn_name, BPF.TRACING)
+        fd = lib.bpf_attach_kfunc(fn.fd)
+
+        if fd < 0:
+            raise Exception("Failed to attach BPF to fmod_ret kernel func")
+        self.fmod_ret_fds[fn_name] = fd
+
+        return self
+
     def attach_kretfunc(self, fn_name=b""):
         fn_name = _assert_is_bytes(fn_name)
         fn_name = BPF.add_prefix(b"kretfunc__", fn_name)
@@ -1824,6 +1865,8 @@ class BPF(object):
             self.detach_kretfunc(k)
         for k, v in list(self.lsm_fds.items()):
             self.detach_lsm(k)
+        for k, v in list(self.fmod_ret_fds.items()):
+            self.detach_fmod_ret(k)
 
         # Clean up opened perf ring buffer and perf events
         table_keys = list(self.tables.keys())
-- 
2.25.1

