Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BF15481
	for <mptcp@lists.linux.dev>; Tue,  5 Dec 2023 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BROSMlFS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701759797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FR8SBMQPI17VNeTR9EbA1rLtJvK2Ww+TefxFyxLRQ6g=;
	b=BROSMlFSj6dasulyZYRHeM0PmtGLdpIAjBDYpHi2bugwm/F5n3KqIy+OiJB6Tn/wPa4TP9
	rVbNlWXT1hR1pfHqni8ABaS+vBbe5MDPNMw/58vK2loFQRGdoPkHRS031TNnRhp8Y6fvek
	gd8nMum65LX1Yr0r9pXjCsLghASAnXk=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 03/33] selftests: mptcp: userspace: print colored output
Date: Tue,  5 Dec 2023 15:00:50 +0800
Message-Id: <ad8f684d4a3183a8e2ac2ba8d861794cc728ebe5.1701759405.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1701759405.git.geliang.tang@linux.dev>
References: <cover.1701759405.git.geliang.tang@linux.dev>
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
index c9da970e5d24..108a7548a1ed 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -62,7 +62,7 @@ _printf() {
 
 print_title()
 {
-	_printf "INFO: %s\n" "${1}"
+	mptcp_lib_print_info "INFO: ${1}"
 }
 
 # $1: test name
@@ -73,27 +73,22 @@ print_test()
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

