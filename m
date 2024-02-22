Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055F17C69
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708588606; cv=none; b=uTeHVMYYtuzcLBfBRQHU2EkfnOLn33gvEODettfGu/GI4HG4IM24MgFHGLUA4veRv3lrGui1EvACnn1V9c8RGRMNL3tDywZ6M1Tr0O2ELPah8oT8PtQMYiqmQdhBBTfSJUpwqZAAnJeIUMY+vxms9XJ49wGCPflOIMURVuDouZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708588606; c=relaxed/simple;
	bh=SP4D8At+mGWP2RhfY+f+FEZZ9ecWNYPtDb7LaFg3pi8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oska7lcb7rQ2LQf2gUJcKzVYrFeFI6oZZUkj/0qM6TLovmhOxxaaaufbhzvpFQ5NBCtTWJ5+C4XBY7SJ53SieMmUd9lKFWVCmJiMwg4UeduFiwoWDY6kVatYRaU74c7EpMPt+9lgqy2RoLHcYpreuKbes9sxKucCEpnjPj45bZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzAw1xXm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzAw1xXm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CA1C433C7;
	Thu, 22 Feb 2024 07:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708588606;
	bh=SP4D8At+mGWP2RhfY+f+FEZZ9ecWNYPtDb7LaFg3pi8=;
	h=From:To:Cc:Subject:Date:From;
	b=OzAw1xXm9iInCPa4+MxZEzLg9eHjdfEzaXR3PoC5l1jfArKQqlnUC3vat0gdKB+2u
	 jLZ18HtpOgtBGlqWHeZNtxVlOFoVThgVlotUsPduAnZkLhguKb3cGqOwhLasbuygwU
	 FUTCSFfB0NXyierDX0JprbcuUgW5ma8dvCdyvNOFkVCXo/+OM4C2gjKljviuynTjIi
	 yFDuZhM8ACor0I1XcSYMlegc+i7eA7SSCGiSNvhUjGDh8rrzNI59n7jLNA6Ab4tXeJ
	 fFCByGxmXfB4B4nX3o4pDYsxYJssd6mA4TCjUJRb6hgxud4rUBR6QACUr5/Xxv5el+
	 B2yCHxxpS4B3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] selftests: mptcp: don't exit when a symbol not found
Date: Thu, 22 Feb 2024 15:56:40 +0800
Message-Id: <37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_lib_kallsyms_has() will always exit when a symbol has not found, it
breaks the test itself. Unexpected errors occur:

 007 userspace pm add & remove address
       syn                                 [ OK ]
       synack                              [ OK ]
       ack                                 [ OK ]
       add                                 [ OK ]
       echo                                [ OK ]
       mptcp_info subflows=2:2             [ OK ]
       mptcp_info subflows_total=3:3       [ OK ]
       mptcp_info add_addr_signal=2:2      [ OK ]
       mptcp_info last_data_sent=191:18    [ OK ]
       mptcp_info last_data_recv=40:68     [ OK ]
       mptcp_info last_ack_recv=93:74      [ OK ]
       dump addrs signal                   ERROR: missing feature: \
			mptcp_userspace_pm_dump_addr$ symbol not found
 Cannot open network namespace "ns1-65d6fb5a-5FviVK": \
			No such file or directory
 Cannot open network namespace "ns2-65d6fb5a-5FviVK": \
			No such file or directory
 cmp: /tmp/tmp.a7osJs7Nj0: No such file or directory
 cmp: /tmp/tmp.f02z6brCQu: No such file or directory
 cat: /tmp/tmp.27TzxD2efV: No such file or directory
not ok 1 test: selftest_mptcp_join # FAIL

To fix this, this patch adds a new argument 'continue' for the helper
mptcp_lib_fail_if_expected_feature() to control whether exit or not.

Always set this argument to 1 in mptcp_lib_kallsyms_has().

Fixes: 83013bdf90a ("selftests: mptcp: connect: skip if MPTCP is not supported")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 556a7d9784d7..e23fd85902d8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -55,11 +55,13 @@ mptcp_lib_expect_all_features() {
 	[ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
 }
 
-# $1: msg
+# $1: msg $2: continue or not
 mptcp_lib_fail_if_expected_feature() {
+	local continue="${2:-0}"
+
 	if mptcp_lib_expect_all_features; then
-		echo "ERROR: missing feature: ${*}"
-		exit ${KSFT_FAIL}
+		echo "ERROR: missing feature: ${1}"
+		[ "${continue}" -eq 0 ] && exit ${KSFT_FAIL}
 	fi
 
 	return 1
@@ -107,7 +109,7 @@ mptcp_lib_kallsyms_has() {
 		return 0
 	fi
 
-	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found" 1
 }
 
 # $1: part of a symbol to look at, add '$' at the end for full name
-- 
2.40.1

