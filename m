Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65007107BA
	for <mptcp@lists.linux.dev>; Mon, 18 Dec 2023 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3CzIGMP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702889322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JI/9I57H0eOWgiEBhYSFYEzjGXiHYZyh+DjWzvywok=;
	b=l3CzIGMP8diMyCyvRpHH1E/No1itEkJfjLsfsLz/6Ccv3Iqz9ghC2X08Wg7AIc5ApEhWFL
	hk5l53Uf22SYEGZvi2qWUn8/9TYAPcoJhmWxHH3rAtG1JhVtNAhts92oNg+3JZIk0wakyM
	OpqkMSdLy4P4sv5d45R+UkGpiUk3jv4=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next 5/5] selftests: mptcp: diag: check CURRESTAB counters
Date: Mon, 18 Dec 2023 16:47:17 +0800
Message-Id: <573a8f55b47fb4aa35dfdfc49f1984ab7d232781.1702889134.git.geliang.tang@linux.dev>
In-Reply-To: <cover.1702889134.git.geliang.tang@linux.dev>
References: <cover.1702889134.git.geliang.tang@linux.dev>
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

---
Note: chk_msk_cestab() and chk_cestab_nr() will be replaced by
mptcp_lib_chk_cestab_nr() in subsequent patches after the commit
"selftests: mptcp: diag: print colored output"
---

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..aa341f40363c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -182,6 +182,30 @@ chk_msk_inuse()
 	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
+# $1: ns, $2: cestab nr
+chk_msk_cestab()
+{
+	local ns=$1
+	local cestab=$2
+	local count
+	local msg="....chk $2 cestab"
+	test_cnt=$((test_cnt+1))
+
+	printf "%-50s" "$msg"
+
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
+	if [ -z "$count" ]; then
+		echo "[ skip ]"
+		mptcp_lib_result_skip "${msg}"
+	elif [ "$count" != "$cestab" ]; then
+		echo "[ fail ] got $count current establish[s] expected $cestab"
+		ret=${KSFT_FAIL}
+	else
+		echo "[  ok  ]"
+		mptcp_lib_result_pass "$msg"
+	fi
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -219,9 +243,11 @@ chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2 "....chk 2 msk in use"
+chk_msk_cestab $ns 2
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab $ns 0
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -237,9 +263,11 @@ echo "b" | \
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1 "....chk 1 msk in use"
+chk_msk_cestab $ns 1
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab $ns 0
 
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
@@ -261,9 +289,11 @@ done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
+chk_msk_cestab $ns 200
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab $ns 0
 
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.35.3

