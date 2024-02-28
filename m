Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B65D24B41
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106240; cv=none; b=Pr9G6pJDFwHRR2CbYYn5jbDTJw1Us31MvEezeEWnCKX/IAPlyhq5E7AWh2KxwMApJ9fKNh0GQt2PvIF8vPdsYTbkl/tMgjJENPagsIA4CKRzHt8SArHZGFYlHak6DW6nDLjKpubjwZ+ENbc9ChkdeKMHJEtM9y1Tcp2LI7BJveo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106240; c=relaxed/simple;
	bh=Z51yRIABGTfUkt1M9YB3gD+Uclr1/LOsXtWjkc6ddDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=osg4nStw23MR7ZjOIaPPxCSY5DO+QwGeaBHLmZsCMyemjf4dgTmxVO7RJ6AALEdvXn0SUt7E6P3hLnLBsqZvg2rp5B/XcDShYrIxCyQguKPyZWSwWl74dMmH1nIjUJz4BlJTZyr3KZDb68WzTyZR8iLj021/QfiNLfk9tuMdk8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgQvW13z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgQvW13z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CED7C433C7;
	Wed, 28 Feb 2024 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106240;
	bh=Z51yRIABGTfUkt1M9YB3gD+Uclr1/LOsXtWjkc6ddDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgQvW13zOzKKRNyx55lXSYHNKsCrj5b56u/A4X12OvBK0RQ7NgjQwXNyiCtr1w8bG
	 qYfy7oI89cg3n2LqjMLqjdcgyGv7m+VbaLYsQFv+N62qefXlWscwghR8Bmm6VLVCqT
	 JxbLOndWUQhTQ8+OLBrJgaaOFoRhZNJ/6C02Hu+jDEDdoWQgYvgK9eTU0L4m80TT96
	 eBwEP8KZYubilEoP+xX4Kl1ABhj2HQUOj3FJW/ZzAeLuxs5aKUNi9Nfr3xbt0qhpEB
	 6P5FJG+20YrokvY5eN++YeJq3vwciaRL1isPBf534CnMFk+NP/trMsFUGHT8ipKQsR
	 kXyWqbMxmokmQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 3/9] selftests: mptcp: connect: fix misaligned output
Date: Wed, 28 Feb 2024 15:43:41 +0800
Message-Id: <ff577139939e084179364bc5f963d6c98942e8ae.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The first [ OK ] and [FAIL] in the output of mptcp_connect.sh misalign
with the others:

New MPTCP socket can be blocked via sysctl		[ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.85% delay 16 ms reorder 95% 70% with delay 4ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration   184ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration    50ms) [ OK ]
ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration    55ms) [ OK ]

This patch aligns them by using the newly added print_title() helper.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---

Notes:
    add print_title helper

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ffc063a58149..7a53c8fb1783 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -247,11 +247,20 @@ else
 	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
 fi
 
+print_title()
+{
+	local msg="${1}"
+	local nr_blank="${2-50}"
+
+	printf "%-${nr_blank}s" "${msg}"
+}
+
 check_mptcp_disabled()
 {
 	local disabled_ns
 	mptcp_lib_ns_init disabled_ns
 
+	print_title "New MPTCP socket can be blocked via sysctl" 69
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		mptcp_lib_pr_fail "net.mptcp.enabled sysctl is not 1 by default"
@@ -273,7 +282,6 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -n -e "New MPTCP socket can be blocked via sysctl\t\t"
 	mptcp_lib_pr_ok
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
@@ -343,7 +351,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%s\t" "${result_msg}"
+	print_title "${result_msg}"
 
 	if $capture; then
 		local capuser
-- 
2.40.1

