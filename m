Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9E233EAED
	for <mptcp@lists.linux.dev>; Fri, 30 Jan 2026 10:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769713; cv=none; b=Mr1tjlN8tXJN9YD06dWdXAF2GVlitfflqf0vmDrTzR20QXR9R+6BLjBM/e3Y+caz40zzADgoQMJcz++QOtmiYsLNlS1SY0h8qjh8efSRWY+Z1pszK0/m7Kcd/ppMUiY+PWGXk0ylk24dLiG/itOc5z2YKwpYRG5YdjnbMC8EcBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769713; c=relaxed/simple;
	bh=9p2s3JWOU8kdTRJh7N52ImRA8XEN1D0aFZM43ORgHwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fofklkUTYJycJseb/EnDoQ3xrBdnDIy+/01nFy7xaRv8uTloVdVyDNzvWCdNfty+sn0hqM58tsvAfulHREdZd6+1Ap9asiSUr0bdceDooFJlbmU09Q/SR3i6SbDrpf4xOf5mtrNQ2qJG2QLHuDdrqLj4rlCZvavx6K5kP3WR4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roN7WR8k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roN7WR8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850F8C4CEF7;
	Fri, 30 Jan 2026 10:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769769713;
	bh=9p2s3JWOU8kdTRJh7N52ImRA8XEN1D0aFZM43ORgHwQ=;
	h=From:Date:Subject:To:Cc:From;
	b=roN7WR8kN0px2oS6JsbzLNPhNyL1V7UXx/SIyqQryWLWfmhGje1E2FsZcDGHwYoxA
	 RrmOkpm4EBto6tNvWFh9B6J9VyG2ibeAI2j2qe2K42XkKcd3lxlbgvfg0pm2kOQTPd
	 sk4maZqxHM81oCExfLLY4qPzA4ySc9FLq1FsMEf1olUq2tFa2FVtMeiu04TK5uqAgc
	 Tm0pEgod78tvkLN6tCgVvuZk760qQJCKuUi2G/5sCOE9Igzw2h31Ydjc5e8FLpghNp
	 OD+ax1qamR7ggHsKJ91d1UdWXfH65Lm6IgauDVgd11IFdYtjLA5BvCj1bOzDijx0YW
	 vIyEy3VFARHqg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 30 Jan 2026 11:41:43 +0100
Subject: [PATCH mptcp-next] selftests: mptcp: diag: sort all #include
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260130-mptcp-sft-sort-includes-v1-1-ab022fad9741@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOaKfGkC/yXMQQqDMBBA0avIrB1INEjtVYqLNJm0AzWGTCyCe
 HeDLv/i/R2EMpPAs9kh05+Fl1hDtw24r40fQva1oVPdoHSvcE7FJZRQUJZckKP7rZ4EH8Eba8z
 b6mGEqlOmwNt1fsGNIm0FpuM4AfZBGBN1AAAA
X-Change-ID: 20260130-mptcp-sft-sort-includes-8fd4a44ba169
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Gang Yan <yangang@kylinos.cn>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1903; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9p2s3JWOU8kdTRJh7N52ImRA8XEN1D0aFZM43ORgHwQ=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGl8ivCiGcM3C+KfSba3r3sSZCozHSU/Ti4NG1EHQTFtGDQxZ
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAml8ivAACgkQfCLwwvNHCpdWDAEA4TcE
 msrRlMJxfvpMRyR919hN9ZnH+/sMJixF37JCh/gBALqqedEQGoK4Tx+7Ew8RIygfe96u2FwFJLB
 2aNMqiAcD
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This file is the only one from this directory not to have all these
header inclusions sorted by type and alphabetical order.

Adapt them, to ease the reading, prevent conflicts during potential
future backport modifying these lines, and also to avoid having UAPI
header inclusions before libc ones, see [1].

Link: https://lore.kernel.org/20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_diag.c | 29 ++++++++++++++------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
index 8e0b1b8d84b6..5e222ba977e4 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
@@ -1,21 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2025, Kylin Software */
 
-#include <linux/sock_diag.h>
-#include <linux/rtnetlink.h>
-#include <linux/inet_diag.h>
-#include <linux/netlink.h>
-#include <linux/compiler.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <linux/tcp.h>
-#include <arpa/inet.h>
-
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
 #include <errno.h>
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <sys/socket.h>
+
+#include <arpa/inet.h>
+
+#include <netinet/in.h>
+
+#include <linux/compiler.h>
+#include <linux/inet_diag.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/sock_diag.h>
+#include <linux/tcp.h>
 
 #ifndef IPPROTO_MPTCP
 #define IPPROTO_MPTCP 262

---
base-commit: 50e7f60d4f2aecec1adf329735dd16a88d7d494a
change-id: 20260130-mptcp-sft-sort-includes-8fd4a44ba169

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

