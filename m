Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D84F60D
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P00Nxpkc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEFKtMa8a93TS0r2aaArgIFQUKVTDw5HiCOwNf1EBnI=;
	b=P00NxpkcFaS9XUuVB7WnNCCDU18prfbFvl0kXtajE9QjGS8cObJITfV2a/Gta26guFJ/NV
	gDCaQ/rWAJMr0jXavxtDAe2F9MvnjPMAqKvZZWl73ku2O8/w/RU/vpPW6Xo+vfJCDFIzeX
	uQRbpfNddPYWQLXP2KLD0728Cm5uyc8=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v6 03/15] selftests: mptcp: userspace: print colored output
Date: Thu, 21 Dec 2023 19:31:06 +0800
Message-Id: <dd32885d3a7970c7947b46c646d0af4a8ada134a.1703158128.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>
References: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The helper mptcp_lib_verify_listener_events() will be added latter in
mptcp_lib.sh, and be used by mptcp_join.sh and userspace_pm.sh. The
former prints colored output while the latter is not. It makes sense
to unify them.

Use mptcp_lib_print_ok(), _warn() and _err() to instead print_results()
in test_pass(), _skip() and _fail(), and use mptcp_lib_print_info() to
instead _printf() in print_title() to print test results with colors
in userspace_pm.sh.

Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index b0a7c69f5da0..d248ff3eff98 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -63,7 +63,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -74,27 +74,22 @@ print_test()
 	_printf "%-63s" "${TEST_NAME}"
 }
 
-print_results()
-{
-	_printf "[%s]\n" "${1}"
-}
-
 test_pass()
 {
-	print_results " OK "
+	mptcp_lib_print_ok "[ OK ]${1:+ ${*}}"
 	mptcp_lib_result_pass "${TEST_NAME}"
 }
 
 test_skip()
 {
-	print_results "SKIP"
+	mptcp_lib_print_warn "[ SKIP ]${1:+ ${*}}"
 	mptcp_lib_result_skip "${TEST_NAME}"
 }
 
 # $1: msg
 test_fail()
 {
-	print_results "FAIL"
+	mptcp_lib_print_err "[ FAIL ]${1:+ ${*}}"
 	ret=1
 
 	if [ -n "${1}" ]; then
-- 
2.35.3

