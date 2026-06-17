Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5929638E10F
	for <mptcp@lists.linux.dev>; Wed, 17 Jun 2026 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707597; cv=none; b=fDsu1zQoocve5qlUC+ombBkHsNdBufi/qH43BOdNJCREj2vOyM0wEpRUvzmUapwaFAZ464PRRVMwg2YtmwBc4cmxnPYlFWGXTE5iu+7tm+1yoXJ/1wIeW4auIMtPlvIRBgWSQ/bQEWvAK6MxWGom5hEQHWKtqLsDSxiOsgjCdrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707597; c=relaxed/simple;
	bh=d8vrMG/9funhGJf2xJfcD2NEQIn7d/JG/6l9OLAGtNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCDoKPgk2N+LnDSESPF78swartJt/t3nLQFjbEplnIMzHWl/ce8YvafJdwqM5rlzxu7it30ArZrgkKXoDQSwE/rabpTPnOfGDLTn0odpetzQPGH/oU1IqrVyV470mYsorvttqcTqFXjnSSsPHIxH1HIha7EVbqV5Yzxqu0TJYmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fm2v+Y59; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fm2v+Y59"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781707593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNGJrkvhnxwHDa0tp1Hfkla/TXDCh9TiofXC800+WtE=;
	b=fm2v+Y59cZzSbGVV8GaaqgKO5pB62vxWvzdY84vtIey64jNMKPIoHrRSv02DSZFZWpUdi+
	jA9tAuH/lwPkyh6/sKbLfaTmkPf4psbnO4aAkBJhVsaxH0xSCfKi6ze75VBuyqgO7NPDWO
	eKIHVpmhAcNsZfCi8Tek6Wl0Ck4jXso=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/9] selftests: mptcp: mptcp_lib add runtime IPv6 availability detection helper
Date: Wed, 17 Jun 2026 22:46:09 +0800
Message-ID: <f0ced9adedcaaf2660f8b796561261dac8ccbd15.1781707101.git.yangang@kylinos.cn>
In-Reply-To: <cover.1781707101.git.yangang@kylinos.cn>
References: <cover.1781707101.git.yangang@kylinos.cn>
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
  - mptcp_lib_check_ipv6(): looks for "mptcpv6_init(\.|$)" in
    /proc/kallsyms. That symbol is registered by subsys_initcall() in
    net/mptcp/ctrl.c only when both CONFIG_IPV6=y and
    CONFIG_MPTCP_IPV6=y, so it is a precise runtime proxy.
  - mptcp_lib_is_v6_enabled(): cheap accessor wrapping the flag.

No existing caller is changed.

Assisted-by: GLM:5.1 Z.ai
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5ef6033775c8..67545cd70cc5 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -32,6 +32,7 @@ MPTCP_LIB_SUBTESTS_LAST_TS_NS=
 MPTCP_LIB_TEST_COUNTER=0
 MPTCP_LIB_TEST_FORMAT="%02u %-50s"
 MPTCP_LIB_IP_MPTCP=0
+MPTCP_LIB_IPV6_AVAILABLE=1
 
 # only if supported (or forced) and not disabled, see no-color.org
 if { [ -t 1 ] || [ "${SELFTESTS_MPTCP_LIB_COLOR_FORCE:-}" = "1" ]; } &&
@@ -178,6 +179,23 @@ mptcp_lib_check_kallsyms() {
 	fi
 }
 
+# Detect whether the MPTCP IPv6 subsystem is available in the running kernel.
+mptcp_lib_check_ipv6() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		MPTCP_LIB_IPV6_AVAILABLE=0
+		return 1
+	fi
+
+	if ! grep -qE " mptcpv6_init(\.|$)" /proc/kallsyms; then
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
@@ -398,6 +416,11 @@ mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
 
+# Returns 0 (true) if the kernel has MPTCP IPv6 support, 1 (false) otherwise.
+mptcp_lib_is_v6_enabled() {
+	[ "${MPTCP_LIB_IPV6_AVAILABLE}" = "1" ]
+}
+
 mptcp_lib_nstat_init() {
 	local ns="${1}"
 
-- 
2.43.0

