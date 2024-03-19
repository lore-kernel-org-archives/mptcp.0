Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27951026
	for <mptcp@lists.linux.dev>; Tue, 19 Mar 2024 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832589; cv=none; b=lTiomcMGSjpKkl5OQIE3ItXWyHv/R0sf6HWvBffPsL7gF9KfNMi0l0LzNdcgnDo0sO3X8ONXfjcZEqufwK32a+73dek3q3NlThPbm++wr5Pwqx9Y5eJB5EfEr+zxPDj87ePETLcCuDjCCpBIqES0tSfZx4CGbLXUw+nEXWyEI/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832589; c=relaxed/simple;
	bh=xvp4oEwJqmOZPm43wFaQjtZYT72uM/X9obUsMbkLVLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMINVzPHqj1gRo0ezhDLBsnJgc+6wBuPoDXhtMcZnQTzHf/gfcCMPohMGB5TecLF3DBBCYIQX0/5c7cr29mt50bsyskk2om9j+D39bUh8YXTW37jay69P+9RkgXOuZiCvO8uFxYgUUbTmTWVjlUwvKw/fOP/Hw5TPAQMQG2lsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAvr9h3r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAvr9h3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF97C43390;
	Tue, 19 Mar 2024 07:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710832589;
	bh=xvp4oEwJqmOZPm43wFaQjtZYT72uM/X9obUsMbkLVLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAvr9h3rpoIQNCEmVcEPwr8PNSEkC8tj6C+RaiadmF+LXfnw/bm4YNRK/Py9O2HR9
	 fA6cOdu4VwmVCl6xwOO1Th2F4ndHeCuay/CuEUR9CvTb2XEtyZOrb0POLvX/Hb/uvu
	 H/j997iQ51SC1a5B4XjCQnvPINS80yuuaragLybLnP8TPVEIEjMArGRWhvztLsClfn
	 GS2g44ZTbv6B0v4+7hSWvvqIizdvxoANj6pDppp03BtQextlShdZ1ftOBvfK7dTEeG
	 ZL6hLc5QjrH9RkHdRnsE85nAfXW5tVgTx/EsMPEWEFX/UG6CLhHFLYUnvE7PGRglad
	 jKhCqB6QEzNlg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 4/9] selftests: mptcp: add change_address helper
Date: Tue, 19 Mar 2024 15:16:10 +0800
Message-Id: <07d8d4f6ea1988bb56bca312c112deea1fd3e2c4.1710832493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710832493.git.tanggeliang@kylinos.cn>
References: <cover.1710832493.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The address that needs to change flags can only be identified by an address
ID in change_endpoint() helper. This patch adds another helper named
change_address(), its 2nd parameter is an IP address.

Usage:
	Address ID - change_endpoint $ns id $id $flags
	IP address - change_address $ns $addr $flags

Use this new helper in pm_netlink.sh to replace all 'pm_nl_ctl set'
commands.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ff4355db03cd..08b78007e8c1 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -74,6 +74,17 @@ get_endpoint() {
 	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
 }
 
+change_address() {
+	local addr=${1}
+	local flags=${2}
+
+	if mptcp_lib_is_ip_mptcp; then
+		ip -n "${ns1}" mptcp endpoint change "${addr}" "${flags}"
+	else
+		ip netns exec "${ns1}" ./pm_nl_ctl set "${addr}" flags "${flags}"
+	fi
+}
+
 check()
 {
 	local cmd="$1"
@@ -196,10 +207,10 @@ check "ip netns exec $ns1 ./pm_nl_ctl dump" \
 
 ip netns exec $ns1 ./pm_nl_ctl flush
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1 flags subflow
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags backup
+change_address 10.0.1.1 backup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow backup")" \
 	"set flags (backup)"
-ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
+change_address 10.0.1.1 nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "$(format_endpoints "1,10.0.1.1,subflow")" \
 	"          (nobackup)"
 
-- 
2.40.1

