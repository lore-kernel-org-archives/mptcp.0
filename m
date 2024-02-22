Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CC1799E
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573267; cv=none; b=KDlqI2BOCktX3QK9WyEnY5cR9bfOaxlWTBouGdapWB7Nz2Rzl2MovB9XOcfeTNLfQXNsZgfqARVrrg0Ngcmd+3ptN7vwkkBV7GcI6XgUO9i8xVNAWjnaDMXQg0LbCT4chBhPQDX2pQ6aedOEUzJFasqUuzdozixNy0blJGMrrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573267; c=relaxed/simple;
	bh=DES3Ueuh+5AM6YDRu68i++P2y0+tRMpJeNRreeTIY0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tv9nRKdS72EF3oTaBSZvIIcKcAu7GG+jAczteGeNoURG8/gYrQCedOztDzB3d6A3iKI0ilhyLVFrhFSNu8Tp8YxmO/KXkHk3ZpBycLRy7GdIp5W7e6E3wGv23vjfd+h1bJBa52RZ8A2ws2wUoVsRQQ5SMsRSG2Ds335W+pvgqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWLAe0F9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWLAe0F9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8D1C43390;
	Thu, 22 Feb 2024 03:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708573266;
	bh=DES3Ueuh+5AM6YDRu68i++P2y0+tRMpJeNRreeTIY0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mWLAe0F9aeAabilVPz4W2q/cah92CTxfCVGcUx+O9iadcmaelKU9eKX/81LlGgKTo
	 j2HV/OLSTUbb1M6/FSVtqCneQfozKDoR4hLX303EDny0/Ysmy7Xay3ipUGhsN5gkE9
	 YFXyiFZPsLtxZacr7KPkkqiCKO96MXXm4klIl+jOH/MICCGLfAHyPnB+f5fn755uUI
	 xORPwA4cVCv6xm69y/2eHtO9WTxnhlc1M/MH1QhvasDRVn8Msl35JKEhOg5hK5MixA
	 NmCo9OwqG6sMkbFlzJrcQ1wEXDhXEeplMFjTXns0UHQWF5HZ/EijGfySayeK1Fvcg5
	 1c3RktwxbAzbQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/4] selftests: mptcp: add mptcp_lib_events helper
Date: Thu, 22 Feb 2024 11:40:36 +0800
Message-Id: <a306733bbc030878afda1ba501a94b40b92ec264.1708572320.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708572320.git.tanggeliang@kylinos.cn>
References: <cover.1708572320.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To avoid duplicated code in different MPTCP selftests, we can add and
use helpers defined in mptcp_lib.sh.

This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
and mptcp_join.sh into a helper mptcp_lib_events(). Define it in
mptcp_lib.sh and use it in both scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   |  8 ++------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 14 ++++++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 14 ++------------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2d9cf6f3bbf3..292fccb1f7f4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -430,12 +430,8 @@ reset_with_events()
 {
 	reset "${1}" || return 1
 
-	:> "$evts_ns1"
-	:> "$evts_ns2"
-	ip netns exec $ns1 ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
-	evts_ns1_pid=$!
-	ip netns exec $ns2 ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
-	evts_ns2_pid=$!
+	mptcp_lib_events "${ns1}" "${evts_ns1}" evts_ns1_pid
+	mptcp_lib_events "${ns2}" "${evts_ns2}" evts_ns2_pid
 }
 
 reset_with_tcp_filter()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f65a31594829..5b5ad9947c21 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -399,3 +399,17 @@ mptcp_lib_ns_exit() {
 		rm -f /tmp/"$netns".{nstat,out}
 	done
 }
+
+mptcp_lib_events() {
+	local ns="${1}"
+	local evts="${2}"
+	declare -n pid="${3}"
+
+	:>"${evts}"
+
+	if [ ${pid} -ne 0 ]; then
+		mptcp_lib_kill_wait "${pid}"
+	fi
+	ip netns exec "${ns}" ./pm_nl_ctl events >> "${evts}" 2>&1 &
+	pid=$!
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6d71bf36a1b9..3200d0b96d53 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -178,21 +178,11 @@ make_connection()
 	if [ -z "$client_evts" ]; then
 		client_evts=$(mktemp)
 	fi
-	:>"$client_evts"
-	if [ $client_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $client_evts_pid
-	fi
-	ip netns exec "$ns2" ./pm_nl_ctl events >> "$client_evts" 2>&1 &
-	client_evts_pid=$!
+	mptcp_lib_events "${ns2}" "${client_evts}" client_evts_pid
 	if [ -z "$server_evts" ]; then
 		server_evts=$(mktemp)
 	fi
-	:>"$server_evts"
-	if [ $server_evts_pid -ne 0 ]; then
-		mptcp_lib_kill_wait $server_evts_pid
-	fi
-	ip netns exec "$ns1" ./pm_nl_ctl events >> "$server_evts" 2>&1 &
-	server_evts_pid=$!
+	mptcp_lib_events "${ns1}" "${server_evts}" server_evts_pid
 	sleep 0.5
 
 	# Run the server
-- 
2.40.1

