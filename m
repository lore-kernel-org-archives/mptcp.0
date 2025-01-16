Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986B426AF6
	for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017741; cv=none; b=U2SGdEhRk0W1mhF4vL2cXRsR1K6yZY0ASU5XSX38CRqMrRTyvZ746n2PnOsRIrZdfCL2qjhOzNr8sGr8no8Dv+kTq2w/YtuvDqwja8lR0l4WIS/QBjzL0U6f/QhL5I2bap33UcqQQCDDfqhX7nOIUHxbBEh3RIHJDGJPQMVNhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017741; c=relaxed/simple;
	bh=bQrhzdPNxx1A4ULqJnUsDytgr/MXEBkGC4HymU441dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAPfVK+8pM6u8MhisXQX5bkcBO5asAcfBYqnUZG7rw3ZCmVFdKAhy4DySJ1I9/hfzbBKL7gaJp59GOBYQH9ssaiTBREBppOplt0jnY6Iy7sofwUX6ua/wfoXoe+acPoJO6qWt37IZKWknLTY6JbyarBGRzurE52pUpXSJlUCHuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a30be276d3e711efa216b1d71e6e1362-20250116
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_TXT
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:8029970c-4963-4824-b400-a06cb400d936,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-INFO: VERSION:1.1.45,REQID:8029970c-4963-4824-b400-a06cb400d936,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:a0f83af89324e2ecd3ec697aa8996161,BulkI
	D:250116165530WAAGE3A5,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|51,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: a30be276d3e711efa216b1d71e6e1362-20250116
X-User: liucong2@kylinos.cn
Received: from liucong.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 2071129329; Thu, 16 Jan 2025 16:55:29 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: matttbe@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	geliang@kernel.org,
	horms@kernel.org,
	kuba@kernel.org,
	liucong2@kylinos.cn,
	martineau@kernel.org,
	mptcp@lists.linux.dev,
	pabeni@redhat.com,
	shuah@kernel.org
Subject: [PATCH v2] selftests: mptcp: Fix incorrect file descriptor check in main_loop
Date: Thu, 16 Jan 2025 16:54:48 +0800
Message-ID: <20250116085459.31419-1-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5e2058ea-2292-4403-a7b9-ace4b21dc9c1@kernel.org>
References: <5e2058ea-2292-4403-a7b9-ace4b21dc9c1@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a bug where the code was checking the wrong file descriptor
when opening the input file. The code was checking 'fd' instead
of 'fd_in', which could lead to incorrect error handling.

Fixes: ca7ae8916043 ("selftests: mptcp: mptfo Initiator/Listener")
Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 4209b9569039..31f4c5618569 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1249,7 +1249,7 @@ int main_loop(void)
 
 	if (cfg_input && cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
@@ -1272,7 +1272,7 @@ int main_loop(void)
 
 	if (cfg_input && !cfg_sockopt_types.mptfo) {
 		fd_in = open(cfg_input, O_RDONLY);
-		if (fd < 0)
+		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
 	}
 
-- 
2.43.0


When I tried to solve the problem where fd_in was closed in the again
code block but not reopened in certain scenarios, I encountered some 
issues. Here's my code, but it causes the disconnect test to fail and I'm
not sure how to fix this. 

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 31f4c5618569..fbcb6bf6500c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1247,7 +1247,7 @@ int main_loop(void)
        struct addrinfo *peer;
        struct wstate winfo;
 
-       if (cfg_input && cfg_sockopt_types.mptfo) {
+       if (cfg_input) {
                fd_in = open(cfg_input, O_RDONLY);
                if (fd_in < 0)
                        xerror("can't open %s:%d", cfg_input, errno);
@@ -1270,12 +1270,6 @@ int main_loop(void)
        if (cfg_cmsg_types.cmsg_enabled)
                apply_cmsg_types(fd, &cfg_cmsg_types);
 
-       if (cfg_input && !cfg_sockopt_types.mptfo) {
-               fd_in = open(cfg_input, O_RDONLY);
-               if (fd_in < 0)
-                       xerror("can't open %s:%d", cfg_input, errno);
-       }
-
        ret = copyfd_io(fd_in, fd, 1, 0, &winfo);
        if (ret)
                return ret;
@@ -1291,8 +1285,6 @@ int main_loop(void)
                set_nonblock(fd, false);
                if (connect(fd, peer->ai_addr, peer->ai_addrlen))
                        xerror("can't reconnect: %d", errno);
-               if (cfg_input)
-                       close(fd_in);
                memset(&winfo, 0, sizeof(winfo));
                goto again;
        } else {




INFO: disconnect
63 ns1 MPTCP -> ns1 (10.0.1.1:20001      ) MPTCP     (duration   103ms) [FAIL] file received by server does not match (in, out):
-rw-r--r-- 1 root root 18548982  1月 16 16:18 /tmp/tmp.mBbh37L7rj.disconnect
Trailing bytes are: 
�ǫ��r�_���m:�!d��v��Pv��-rw------- 1 root root 6182994  1月 16 16:18 /tmp/tmp.mJRvCLPpUi
Trailing bytes are: 
�ǫ��r�_���m:�!d��v��Pv��64 ns1 MPTCP -> ns1 (dead:beef:1::1:20002) MPTCP     (duration   149ms) [FAIL] file received by server does not match (in, out):
-rw-r--r-- 1 root root 18548982  1月 16 16:18 /tmp/tmp.mBbh37L7rj.disconnect
Trailing bytes are: 
�ǫ��r�_���m:�!d��v��Pv��-rw------- 1 root root 6182994  1月 16 16:18 /tmp/tmp.mJRvCLPpUi
Trailing bytes are: 
�ǫ��r�_���m:�!d��v��Pv��[FAIL] Tests of the full disconnection have failed
Time: 49 seconds

TAP version 13
