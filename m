Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C84F60D
	for <mptcp@lists.linux.dev>; Thu, 21 Dec 2023 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UGA/2Osj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703158418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75njX+S5UPGBcGQVuYeWrJuW+RAc8TFBEBUzLmcoybM=;
	b=UGA/2OsjyL3wkaQLq7i8PKe0ummvavGPqOaRoskFqbSvED+RzgcOx6JYbEGvSrejAFIPD8
	DoEwUugvkQSYn1QmBH80c+1ofCxG/mmg2hXxSu616g+hP//2izlSbSfBCsGfSkFB4xAuQZ
	eCf/ngQLOpm4MiATW/lXG5pvHO26lI0=
From: Geliang Tang <geliang.tang@linux.dev>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@linux.dev>
Subject: [PATCH mptcp-next v6 14/15] selftests: mptcp: add mptcp_lib_cleanup helper
Date: Thu, 21 Dec 2023 19:31:17 +0800
Message-Id: <dfe60b0988d08fdda392cd303ff4cc969dbaaa86.1703158128.git.geliang.tang@linux.dev>
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

This patch adds a new helper mptcp_lib_cleanup() in mptcp_lib.sh, it's
a public cleanup interface, being invoked in every cleanup() in all
scripts.

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 1 +
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 +
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 1 +
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 6 ++++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 1 +
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 +
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 1 +
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 +
 8 files changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 1424769d292b..ba6604a74329 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -28,6 +28,7 @@ cleanup()
 	ip netns pids "${ns1}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
 
 	mptcp_lib_ns_exit
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_tools "ip" "ss"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c64f0038daef..cf9548e190b1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -133,6 +133,7 @@ cleanup()
 	rm -f "$capout"
 
 	mptcp_lib_ns_exit
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_tools "ip" "ss"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8b52ed5c15b2..5972f1c23246 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -156,6 +156,7 @@ cleanup()
 	rm -f "$tmpfile"
 	mptcp_lib_evts_remove
 	rm -f $check_output_err
+	mptcp_lib_cleanup
 	cleanup_partial
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 90e2864391cf..540c35012041 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -525,3 +525,9 @@ mptcp_lib_check_tools() {
 		fi
 	fi
 }
+
+mptcp_lib_cleanup() {
+	echo "cleanup"
+}
+
+echo -e "\n${KSFT_TEST}\n"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 3ab7eb695af3..2290b3290214 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -71,6 +71,7 @@ cleanup()
 	mptcp_lib_ns_exit
 	rm -f "$cin" "$cout"
 	rm -f "$sin" "$sout"
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_tools "ip" "ss" "iptables"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 684c532c2f35..59d891300df5 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -30,6 +30,7 @@ cleanup()
 {
 	rm -f $err
 	mptcp_lib_ns_exit
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_tools "ip"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index fb68fc79fd07..57180c2da605 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -26,6 +26,7 @@ cleanup()
 	rm -f "$capout"
 
 	mptcp_lib_ns_exit
+	mptcp_lib_cleanup
 }
 
 mptcp_lib_check_tools "ip"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index bae3377b6afe..50eda314ec2e 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -98,6 +98,7 @@ cleanup()
 	rm -rf $file
 	mptcp_lib_evts_remove
 
+	mptcp_lib_cleanup
 	_printf "Done\n"
 }
 
-- 
2.35.3

