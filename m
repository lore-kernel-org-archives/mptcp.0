Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC557EBE
	for <mptcp@lists.linux.dev>; Mon, 11 Mar 2024 01:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121741; cv=none; b=gi8ukJ66LOCGMWcssnfg/PyM5HI3PqYUX6aXLFNR8DIwXqugzHjjs2zdM7aKaWyW3c3GubGhkkcnR55vza3dH5WkuiXn3q2YAJOwjZg1UieD1H5DVz36eNfyRjZc7Lz3F0xjx/QbXTaep8FMSsatdHu6Wo3Tekb4HnqOze19VUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121741; c=relaxed/simple;
	bh=B+umWby8HAOuyjxAAo4mWEQTbr1BI0GYtA7bcCJU9ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ow8Z/MOPKpSQ7PwUSc+43MWVUP3TVfRQkYQdV6XMY93DBnb5e5UvTZmhHQQrJaCGcrZk3Qgt03cD9l+/dYchTsLYNYSNrsrM1+sV04hroQidkuA7ao5N1Vr6Zosh8Gn/6GZo1Stq53R00hEqFnJxJUPT/Y7M1cagx5QoJdmSl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+Joer78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+Joer78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E2C433C7;
	Mon, 11 Mar 2024 01:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710121740;
	bh=B+umWby8HAOuyjxAAo4mWEQTbr1BI0GYtA7bcCJU9ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+Joer78wIX4g5jlNblue+pv4zTBkI8+57oeAYSG7Obm/OQr5XzJyph+lzqlsacpS
	 HhZ4CgSJ6Qwb5sXSzF/8xT2b3fdi6P7pDlZjrboh3S5b3SqqpCVT+P8tZPsHsOQIxM
	 n1pgm8tfTteG/I6AJrZ0TwQdFbLs5PK0kAYSlSfn9lMoeMZJm/FqfATK4jAxumt3AC
	 y2Ok8sE0tuR2WXvn3RTLsC+TFY/ZodajGXM5UEhQ+VfTZauiP0YX6mDcqG9Kef+O7T
	 pnu+/TNqX8eChu1Xt+y+StZgN6WKkPbw1PymIEq4cOzDkJtskVddRc9UM1rPXUQacv
	 5NOtIclYPm81g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 04/10] selftests: mptcp: addr support for change_endpoint
Date: Mon, 11 Mar 2024 09:48:41 +0800
Message-Id: <4f69ef8b2a7d3a131548424ddf9f0ba96ee53f78.1710121590.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710121590.git.tanggeliang@kylinos.cn>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The address that needs to change flags can only be identified by an address
ID in pm_nl_change_endpoint(). This patch adds support for passing an IP
address directly to this helper.

        Address ID:
                pm_nl_change_endpoint $ns id $id $flags

        IP address:
                pm_nl_change_endpoint $ns $addr $flags

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  5 +++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e33a136aef8e..431233e25abc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -717,13 +717,17 @@ pm_nl_show_endpoints()
 pm_nl_change_endpoint()
 {
 	local ns=$1
-	local id=$2
+	local addr=$2
 	local flags=$3
 
+	if ! mptcp_lib_is_addr "$addr"; then
+		[ $addr -gt 0 ] && [ $addr -lt 256 ] && addr="id $addr"
+	fi
+
 	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
+		ip -n $ns mptcp endpoint change $addr ${flags//","/" "}
 	else
-		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
+		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags
 	fi
 }
 
@@ -3609,6 +3613,11 @@ endpoint_tests()
 		output="id 1 flags signal 10.0.2.1"
 		mptcp_lib_is_ip_mptcp && output="10.0.2.1 id 1 signal "
 		check_output "pm_nl_show_endpoints ${ns1} 1" "${output}"
+		pm_nl_change_endpoint ${ns1} 1 backup
+		print_check "change id 1 addr"
+		output="id 1 flags signal,backup 10.0.2.1"
+		mptcp_lib_is_ip_mptcp && output="10.0.2.1 id 1 signal backup "
+		check_output "pm_nl_show_endpoints ${ns1}" "${output}"
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d84f2f4986a7..c465f1d59419 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -284,6 +284,11 @@ mptcp_lib_is_v6() {
 	[ -z "${1##*:*}" ]
 }
 
+# $1: IP address
+mptcp_lib_is_addr() {
+	[ -z "${1##*.*}" ] || [ -z "${1##*:*}" ]
+}
+
 # $1: ns, $2: MIB counter
 mptcp_lib_get_counter() {
 	local ns="${1}"
-- 
2.40.1

