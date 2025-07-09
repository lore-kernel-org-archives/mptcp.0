Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F326B778
	for <mptcp@lists.linux.dev>; Wed,  9 Jul 2025 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045973; cv=none; b=lta3CYsRw8csX/L9BxHl7P5bFRLo2Tkl23i2rOkahtfipmKE+4b+WbQmOKsP5LGh6yBI7e+SW+cRVWQyDm8fxzzd0V3r1FFnkWxI3ts7pHaydysEuCuU4FHRnGnlLekcS1ePaTiBh6Z8N78nMsM0XxySBt5G3CxhT3VprEJzwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045973; c=relaxed/simple;
	bh=42XRcqhb6EAXpfbg2YbEHCA9C3OOusII/XO52cmvxfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8FPohslFojtdVvA0Fp5t1jIFrY+1nXS/IselgzGRIykr8DdkDuZdUcypsEo3QWPNm2rcjQbs8p9I7826oXRhZPhoWOSgtx70lahskclRxbhE6IoJ9ZsWnMirmK5fF2bPP7AmR3KRo/OoDn0grGE8Nfr6vG6PJXZigf/7lJnlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/UMPdKK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/UMPdKK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8BFC4CEF5;
	Wed,  9 Jul 2025 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752045973;
	bh=42XRcqhb6EAXpfbg2YbEHCA9C3OOusII/XO52cmvxfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S/UMPdKK0702gBzJu64NvR8d6hejmhn9AD8tZvFxE6wGbmRKp9DBePNhF5wFUISh0
	 TFEoUoN+3I2vgb4pVoFo2bIehMhElexF+HmpqHladAFrbie8EvK6Ot3I4wAEUxVKiG
	 wkiaQzxxI/kdUHCBJFVLACMo640y40/S0RlC21Mg/Y2xjdQNmnl6+aL8EGnIXxSxei
	 CgfEWwmFfh1F6nNJ+AI4Kq99Q5BbqHSsfJ/S6BbilAt1tEMZTxJG0DkpVt9BLw/7dt
	 p6cE13RRMY4LThUsV8tDrnO4WENvgMeA/HEFgsKzDHItOffkxgnPDwUKnt3Est18BQ
	 M/x7OqOfzyxFA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	matttbe@kernel.org,
	hare@kernel.org,
	pabeni@redhat.com
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v8 7/7] selftests: mptcp: connect: cover splice mode
Date: Wed,  9 Jul 2025 15:25:34 +0800
Message-ID: <8fc6503a7e16f1678a395dba9270117a8d37fef5.1752045499.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1752045499.git.tanggeliang@kylinos.cn>
References: <cover.1752045499.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The "splice" alternate mode for mptcp_connect.sh/.c is available now,
this patch adds mptcp_connect_splice.sh to test it in the MPTCP CI by
default.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/Makefile                | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index 4c7e51336ab2..83c1602fb6bd 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_splice.sh mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
new file mode 100755
index 000000000000..77fe240ecf8c
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.48.1

