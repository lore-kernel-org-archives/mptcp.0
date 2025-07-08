Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AE14A60D
	for <mptcp@lists.linux.dev>; Tue,  8 Jul 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996308; cv=none; b=VYbYAwRJ/prVvuqTe8T0i8K7tVbKKVPBl+RPYo5DT34FAWemjRJEi3eVik9BpZ19AvgABqO22u33uTjyZ7LlJkjLmp2CUtQRtfDVLwvQfFc2r9YOJaPCRAX5pB+g7gp4d7U3kHRc/GCS2XsXuRX+F02nun8i3HKD3urOtilzSRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996308; c=relaxed/simple;
	bh=S404SSDy/WrS6OFGfOpE1Xtb5KvT9yyfcojrz0fUEF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fu5C6Us1pz/ZEVizfD8Dk3a4Wk1toYg53KERLznmbb37plhnJyt9lL7J8o/TqdI/97Zx9M+8ADxrELAfYTHcbxcMnnSiDiWkv3d+avac00vK0NIlioggtZu29BEROxw5wl2fmXsqG23w7kzMlOYH1/SuKNzkQ09kCcAbSvBpv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7lLdHT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7lLdHT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF1C4CEF5;
	Tue,  8 Jul 2025 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751996307;
	bh=S404SSDy/WrS6OFGfOpE1Xtb5KvT9yyfcojrz0fUEF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P7lLdHT8B82hn881FNc2PosciXbpZJji5L+KRsqTPs5HjGRejpH6ai6/+eBWzu41Z
	 THDjhajoeNDxAlFxGjQ0fC17AESpw8/XDuPD+Dbxht1uv5/6IQTgH3GvaqO7EsjIc3
	 JDfYNd7vAstr/6uvhXcyTfI7dXP/S8ICYaj5gxpZ/eYsfDaEGSxR4SsV7bmCyO20LV
	 Hk6KG73C+JbB1HN5R9FpwSBZFWvHFxYUyuhvkL1JEULVOC6voCOVoJRz3sLja1Wi0J
	 gjpkT/1QMRI6UpkkzP9F19mNpywwNJZhaJD32o77ltcHkDxaS37NCrF/EEVNeAWLav
	 Fh+oBeVYlsEYw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 08 Jul 2025 19:37:59 +0200
Subject: [PATCH mptcp-net 1/2] selftests: mptcp: connect: also cover alt
 modes
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-selftests-mptcp-connect-modes-v1-1-f8e6f9828fd8@kernel.org>
References: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
In-Reply-To: <20250708-selftests-mptcp-connect-modes-v1-0-f8e6f9828fd8@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2655; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=S404SSDy/WrS6OFGfOpE1Xtb5KvT9yyfcojrz0fUEF4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJywydkeoUfO5jqnsuzSeBuasSx1Pf+qe2nw1gPrzKeu
 p5t7yuvjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkY9DIy9L2c07Mv4haLrWT4
 jFnHRH3nK53g3/D4w/IlAbMvebdyLGL4Z9Uzr7z2yZec36xvwyutbjZM/DjzeN9SadEL5WuWLn7
 DxgoA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "mmap" and "sendfile" alternate modes for mptcp_connect.sh/.c are
available from the beginning, but only tested when mptcp_connect.sh is
manually launched with "-m mmap" or "-m sendfile", not via the
kselftests helpers.

The MPTCP CI was manually running "mptcp_connect.sh -m mmap", but not
"-m sendfile". Plus other CIs, especially the ones validating the stable
releases, were not validating these alternate modes.

To make sure these modes are validated by these CIs, add two new test
programs executing mptcp_connect.sh with the alternate modes.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index e47788bfa671313f21d5ba95821121cdc3e5d2c7..c6b030babba8cf888101d6af44f3e56fe5ab831b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -4,7 +4,8 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
new file mode 100755
index 0000000000000000000000000000000000000000..09bde1303bf79198fe9f7890cbe89901859d78e8
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
new file mode 100755
index 0000000000000000000000000000000000000000..c50d08481581f0f8997c6f4f2174d606150bfa6a
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"

-- 
2.48.1

