Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B401755C
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573266; cv=none; b=aMMsiD5qTivHMcfEkCYo8iU8yvdMOmauo/qqqKkA4I3oJqAqvq2rHKKocQI38d87xa3ZBgcf1WVkYaieXTKz0jiwZ0s8DaK4wRnoxhyMYgUBNTIFBU3tyO1zOCPT2/QAS/gRSsV/piT7knfkPcEgexJoWTYZHfUUQpIB2be568M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573266; c=relaxed/simple;
	bh=uqVTDGJRVjofl8ez+4tsIn2lArwdOMuIST5qC4YR+to=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SP2H9a9YGDovL1sUoDZpBdxxepMvH8gAmXXaLLOlfsRJkmY+453HOpR/EWY8ISYYv538vo2BZfislQ0YILSK/orc9gE7oQIp/sEzUsxWQgGt0Xsmyol0goJdIUbdHTTmRak7p4vA9gjoVHwSW8IjkBGJFnzH42pOks+P46jzw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBW6AZjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBW6AZjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B2AC433F1;
	Thu, 22 Feb 2024 03:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708573265;
	bh=uqVTDGJRVjofl8ez+4tsIn2lArwdOMuIST5qC4YR+to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBW6AZjbyc+4xlbINDjoAiD4KTUYfG5HQUXYjvztU/VIll6EgDK9EDd3a8OPsQ6C6
	 w4t4gUK5pZauxx8kGDuSbvGJedFCyR21H/SOavQJkwSxOmchnCjd0dqh4PC6F3Wlrl
	 Z6469PqW278VK0qaIh2lIRqt14OR1mGMezenBp0S2oc4l3qCAzRNT2PAsAlrt938bV
	 1HJUR4HuDG85gnJ5a1vHsDcuEAZUdBK0XlNWR0Df6lkoSLaDKte4bhtivjjurMjJbh
	 bRL9a9se3RjybCdvB7p6RRlpXzKkhY5bSPxZKsyY2flB43XPlXYfF8bfV1thVllyyH
	 fw25JiENYoJFw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 3/4] selftests: mptcp: more operations in ns_init/exit
Date: Thu, 22 Feb 2024 11:40:35 +0800
Message-Id: <9886ac0fe4205b00b05d51cd225b5c72da076359.1708572320.git.tanggeliang@kylinos.cn>
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

Set more the default sysctl values in mptcp_lib_ns_init(). It is fine to
do that everywhere, because they could be overridden latter if needed.

mptcp_lib_ns_exit() now also try to remove temp netns files used for the
stats even for selftests not using them. That's fine to do that because
these files have a unique name.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 4 ----
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 7 -------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 7 -------
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 1 -
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 4 ----
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 1 -
 7 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 92f6260ba9f3..b53ae64ec08c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -136,10 +136,6 @@ cleanup()
 	rm -f "$sin" "$sout"
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
-		rm -f /tmp/$netns.{nstat,out}
-	done
 	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 612470244c58..2d9cf6f3bbf3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -90,10 +90,7 @@ init_partial()
 
 	local netns
 	for netns in "$ns1" "$ns2"; do
-		ip netns exec $netns sysctl -q net.mptcp.enabled=1
 		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if $checksum; then
 			ip netns exec $netns sysctl -q net.mptcp.checksum_enabled=1
 		fi
@@ -138,10 +135,6 @@ cleanup_partial()
 {
 	rm -f "$capout"
 
-	local netns
-	for netns in "$ns1" "$ns2"; do
-		rm -f /tmp/$netns.{nstat,out}
-	done
 	mptcp_lib_ns_exit "${ns1}" "${ns2}"
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index fcb3afb4d51f..f65a31594829 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -386,6 +386,9 @@ mptcp_lib_ns_init() {
 
 		ip netns add "${!netns}" || exit ${KSFT_SKIP}
 		ip -net "${!netns}" link set lo up
+		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
+		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
+		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
 	done
 }
 
@@ -393,5 +396,6 @@ mptcp_lib_ns_exit() {
 	local netns
 	for netns in "${@}"; do
 		ip netns del "$netns"
+		rm -f /tmp/"$netns".{nstat,out}
 	done
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 5fa5fa8cab71..7dd0e5467d35 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -40,13 +40,6 @@ init()
 {
 	mptcp_lib_ns_init ns1 ns2 ns_sbox
 
-	local netns
-	for netns in "$ns1" "$ns2" "$ns_sbox";do
-		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
-	done
-
 	local i
 	for i in `seq 1 4`; do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 30ec0ec3d68f..c7c46152f6fd 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -39,7 +39,6 @@ mptcp_lib_check_tools ip
 trap cleanup EXIT
 
 mptcp_lib_ns_init ns1
-ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
 
 check()
 {
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index c5128d690c46..bc8f107357ac 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -61,10 +61,6 @@ setup()
 	trap cleanup EXIT
 
 	mptcp_lib_ns_init ns1 ns2 ns3
-	for i in "$ns1" "$ns2" "$ns3";do
-		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
-		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
-	done
 
 	ip link add ns1eth1 netns "$ns1" type veth peer name ns2eth1 netns "$ns2"
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns2eth2 netns "$ns2"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e3092696d2de..6d71bf36a1b9 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -128,7 +128,6 @@ trap cleanup EXIT
 # Create and configure network namespaces for testing
 mptcp_lib_ns_init ns1 ns2
 for i in "$ns1" "$ns2" ;do
-	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
 	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
 done
 
-- 
2.40.1

