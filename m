Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9977495
	for <mptcp@lists.linux.dev>; Wed, 20 Dec 2023 02:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a3vMMrOZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703038155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyGvSnMWYEUvSa6sdfPlSTGj3VxBxlfnXKokTfIugTI=;
	b=a3vMMrOZl5qVm9J4Kxt2RTJdHlHA11Jb2TzHZ9y/FzJ8+PiYqWMYcdLAzO32dhN32/PHlc
	iHlxHzsdM2AzKNApPT7dtaO9DMaK+YlgClL/nZ3VeoftGalG2te96JVMfpM9Uf4pglZukE
	BvbSlHKR7UMplVSPx6lXRxFOJmUFV+Q=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v3 2/2] selftests: mptcp: diag: check CURRESTAB counters
Date: Wed, 20 Dec 2023 10:08:17 +0800
Message-Id: <e2980e1677fc4cade97771b6218f1bea928408e5.1703036129.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1703036129.git.geliang.tang@linux.dev>
References: <cover.1703036129.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch adds a new helper chk_msk_cestab() to check the current
established connections counter MIB_CURRESTAB in diag.sh. Invoke it
to check the counter during the connection after every chk_msk_inuse().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..04fcb8a077c9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -56,7 +56,7 @@ __chk_nr()
 	local command="$1"
 	local expected=$2
 	local msg="$3"
-	local skip="${4:-SKIP}"
+	local skip="${4-SKIP}"
 	local nr
 
 	nr=$(eval $command)
@@ -182,6 +182,15 @@ chk_msk_inuse()
 	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
+# $1: cestab nr
+chk_msk_cestab()
+{
+	local cestab=$1
+
+	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
+		 "${cestab}" "....chk ${cestab} cestab" ""
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -219,9 +228,11 @@ chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2 "....chk 2 msk in use"
+chk_msk_cestab 2
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab 0
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -237,9 +248,11 @@ echo "b" | \
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1 "....chk 1 msk in use"
+chk_msk_cestab 1
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab 0
 
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
@@ -261,9 +274,11 @@ done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
+chk_msk_cestab $((NR_CLIENTS*2))
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab 0
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.35.3

