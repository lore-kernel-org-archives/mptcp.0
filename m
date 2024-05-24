Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597FD2574F
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520320; cv=none; b=B+k5yUJIeBInS07hK/Q2YavRvdVBv0Tp/czo5iA//FaOS+cQ5PjQlZdhS9yEZE4uwM0csg46ziqh8EUlkA7corLt+F7Ckn544l1p/8/x+7bfVV/deewneFSG+S7qOTZSmWYSklk6j0ZD5vgdlIhdwPiR+8Y6ZVR/FmODC3mjAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520320; c=relaxed/simple;
	bh=G4KLd7hvM8wQ8n1ZPUkb6ONEZe3Uhg7XFWmWGo7OK/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG7OpQfRnfGlUFQcPR73m0i8ZA32L5+QYppuwPAcT3RCBhXF4jxdF2q52LQDk4ykJuSGnaWyls6hQQ5hn1xfdTHRDKzNqx2wy1D31AveL0PIs/qSmDa5me0RE99guV0tJ2vqckAE6OpKMzTNe29rx7Omhw7Y8gPuVcuk4A3nF9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWEvnSBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWEvnSBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB77C2BD10;
	Fri, 24 May 2024 03:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520320;
	bh=G4KLd7hvM8wQ8n1ZPUkb6ONEZe3Uhg7XFWmWGo7OK/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWEvnSByHxFRssaAVm/OIV+6oTikRaXefCvUqM7Vi7ohfpxTaUxBU340I82Km8FFt
	 6MmV/LEQSi7Mw9+aIm2OzNVXavnCMTq2Dmv5yQNp5jdvpl3BJNqdgLozTuxclNb0pV
	 gs1kEAvzYOb28RgSZ2uPFhrXX/cjZRjc4FyVeLiLDppOcxbpZ9U1Ic44UUG3wVzTAl
	 fiOClKG8987fz2hm3mi/Tf5EJlBvwvZpUirPKzqRHLobew4m1ADPKBThigToJLDu3g
	 +7neRQcy9UKi2iHOiUqfUwMv4MHlR319NLLjTxlcVRV513X/z8J3QdWKQGmNlfRsjn
	 OFm+/pdkGXUqg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 3/4] selftests: mptcp: use setup/cleanup_ns helpers
Date: Fri, 24 May 2024 11:11:48 +0800
Message-ID: <7587b0110e680acd1cd7a48dcbea9542c05090db.1716519897.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716519897.git.tanggeliang@kylinos.cn>
References: <cover.1716519897.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes lib.sh into mptcp_lib.sh, uses setup_ns helper
defined in lib.sh to set up namespaces in mptcp_lib_ns_init(), and
uses cleanup_ns to delete namespaces in mptcp_lib_ns_exit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 16aa080c8229..642a0ee255ef 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -1,6 +1,8 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/../lib.sh"
+
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
@@ -412,17 +414,10 @@ mptcp_lib_check_tools() {
 }
 
 mptcp_lib_ns_init() {
-	local sec rndh
-
-	sec=$(date +%s)
-	rndh=$(printf %x "${sec}")-$(mktemp -u XXXXXX)
+	setup_ns "${@}"
 
 	local netns
 	for netns in "${@}"; do
-		eval "${netns}=${netns}-${rndh}"
-
-		ip netns add "${!netns}" || exit ${KSFT_SKIP}
-		ip -net "${!netns}" link set lo up
 		ip netns exec "${!netns}" sysctl -q net.mptcp.enabled=1
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec "${!netns}" sysctl -q net.ipv4.conf.default.rp_filter=0
@@ -430,9 +425,10 @@ mptcp_lib_ns_init() {
 }
 
 mptcp_lib_ns_exit() {
+	cleanup_ns "${@}"
+
 	local netns
 	for netns in "${@}"; do
-		ip netns del "${netns}"
 		rm -f /tmp/"${netns}".{nstat,out}
 	done
 }
-- 
2.43.0

