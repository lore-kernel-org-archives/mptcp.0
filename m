Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21857427A1B
	for <mptcp@lists.linux.dev>; Thu, 11 Jun 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197707; cv=none; b=fZe6Zx7acG1KDM+uFaDzMBIy6S8IuoI2fI1SgTWVIwEezo6MdipTmlLDqMY1rlOp//2pe9grn3b21htaT77Cf9YU3ZJvEAYmBPAr83j4AoXi9VRHTaw8BcRE3mEfJ1WinqK7cji206Ri99huBSgDg+H6sCO43XYN+GrTTCwS3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197707; c=relaxed/simple;
	bh=xcd7xa6cXPpHRCYhvfMhnOrAhX8u9AvdeVaWgsCdLpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WD/6RawsjeNr8WSVGVkTPRB0pTUvGj9oFniqPnUJNPldjqsqhAqWsCCfIYQLzvj/vR76a8YuDLgmzfL5PYbfxcgp8vcMjIiosz7cxSDnpOSz5J/al7/1UPneaTDASl45ipmDzqVOmH92X7bc5QjXfB/itqJcRiuZvY0XNyqvYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QF4gDVe7; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QF4gDVe7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781197704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=We+Z0rOTXq18WOq+TZON9SR93h74LHv0Nktom4go488=;
	b=QF4gDVe7XKLbcyfQt6OTCQtyyc3cm5nas7qfUr6fn+XW2DdLzF0OaBm3ncG70KxnesYiI0
	veoOS3fqj6Oow3fju+YfxYj590lThj3PI/KD2yN5vemT/UTkmP4iB28ZH3lxzjiPRpOJsP
	A2f0j0Hdunq7PZsdYUD69hPpl9cAa2w=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH, mptcp-next 2/9] selftests: mptcp: mptcp_lib add runtime IPv6 availability detection helper
Date: Fri, 12 Jun 2026 01:07:52 +0800
Message-ID: <76fb016879fbcb5dd834efa4b3f1233016714ec4.1781196828.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781196828.git.yangang@kylinos.cn>
References: <cover.1781196828.git.yangang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch introduce a minimal, non-fatal detection helper that subsequent
patches will use to guard the v6 paths:

  - MPTCP_LIB_IPV6_AVAILABLE: cached flag, default 1 (optimistic).
  - mptcp_lib_check_ipv6(): looks for "mptcpv6_init" in /proc/kallsyms.
    That symbol is registered by subsys_initcall() in
    net/mptcp/ctrl.c only when both CONFIG_IPV6=y and
    CONFIG_MPTCP_IPV6=y, so it is a precise runtime proxy. The check
    is non-fatal: it only updates the cached flag and returns 0/1,
    letting callers pick the right degradation (skip a subtest, drop
    to v4-only, etc.) without forcing an exit.
  - mptcp_lib_is_v6_enabled(): cheap accessor wrapping the flag.

No existing caller is changed.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5ef6033775c8..3bb1c0ac8749 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -32,6 +32,7 @@ MPTCP_LIB_SUBTESTS_LAST_TS_NS=
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
+MPTCP_LIB_IPV6_AVAILABLE=1
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -178,6 +179,32 @@ mptcp_lib_check_kallsyms() {
 	fi
 }
 
+# Detect whether the MPTCP IPv6 subsystem is available in the running kernel.
+#
+# This is meant to be called once at script init time. It is non-fatal by
+# design: instead of exiting on a missing feature, it just sets the cached
+# MPTCP_LIB_IPV6_AVAILABLE flag and returns 0/1. Callers can then decide
+# whether to skip a single subtest, fall back to a v4-only mode, etc.
+#
+# The check looks for the "mptcpv6_init" symbol in /proc/kallsyms, which is
+# only present when both CONFIG_IPV6=y and CONFIG_MPTCP_IPV6=y. This single
+# symbol gives the most accurate runtime answer.
+mptcp_lib_check_ipv6() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		MPTCP_LIB_IPV6_AVAILABLE=0
+		return 1
+	fi
+
+	if ! grep -q " mptcpv6_init$" /proc/kallsyms; then
+		MPTCP_LIB_IPV6_AVAILABLE=0
+		mptcp_lib_pr_skip "MPTCP IPv6 support is not available"
+		return 1
+	fi
+
+	MPTCP_LIB_IPV6_AVAILABLE=1
+	return 0
+}
+
 # Internal: use mptcp_lib_kallsyms_has() instead
 __mptcp_lib_kallsyms_has() {
 	local sym="${1}"
@@ -398,6 +425,12 @@ mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
 
+# Returns 0 (true) if the kernel has MPTCP IPv6 support, 1 (false) otherwise.
+# Cached after the first call to mptcp_lib_check_ipv6().
+mptcp_lib_is_v6_enabled() {
+	[ "${MPTCP_LIB_IPV6_AVAILABLE}" = "1" ]
+}
+
 mptcp_lib_nstat_init() {
 	local ns="${1}"
 
-- 
2.43.0

