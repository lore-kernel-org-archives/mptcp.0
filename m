Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5F1DFDB8
	for <mptcp@lists.linux.dev>; Fri, 26 Dec 2025 06:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731244; cv=none; b=oiRJwZaQdZ6VOo7iv9cEH+bqfRgf0UvIpViA3uQrvuUgZhvUaybMaveU1k3nhr/KYGzekiVy58x5TBvVteTScCTuPXAC/Ghz1piHd9NYM1+TppLRkManW5eQENl7s5CNZttnlEg2B97JW31LUVnrKbmFoYer40BlNSNfJmS+vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731244; c=relaxed/simple;
	bh=EPM3VrvMtnC/n2lqAnWoJw0H0//DaGS52xi+CA6xgyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbgFAg8ZK/6Qc14KRtzDB2PkUZMZrK0CqN19gKUMuB8x3zOtYFsHu8MzArIPoQXTvC0Mxb3dRItHCS63vxvJgTat0B6Bb7BcrHlrt9scSL80wJtFD0KVpUIirJhEXrunL/oBITZRtkkbwFvyUUl7g+r0SkQDde2fVO4gU0rAVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrsNkEvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrsNkEvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D63C113D0;
	Fri, 26 Dec 2025 06:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766731244;
	bh=EPM3VrvMtnC/n2lqAnWoJw0H0//DaGS52xi+CA6xgyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qrsNkEvJVavYdQmEc3VhDU8E///9CvhYkn7DuSWY7k7Jz8qPfaQCuoamYvS43T5zO
	 fDNziEPd7ivGkJXubyMtb0CigSWZUT0K1bM2RkPSY0IgWbXmcqa1u8KpEgZ10xk/nE
	 A2bWfIqjf80ujHOCa0Gtpi8QhC+WhZ8U4YxHcetI6L9Y9d0karZIA5dZbadU5WMavD
	 CG9FG5CTcoNevX9QAtLhdag+kNkg9FjMdZbaidUHIFHUMbBc0TwmQPY3vER8G31xEz
	 NC9InGtFfj9/qXqtIFb8CsgT1+wXKkmepYiiDUQ8SOvtl5CFaWkyD2Fc6n8I/rLtGZ
	 IlG0+vFUfEAbg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 26 Dec 2025 07:40:23 +0100
Subject: [PATCH mptcp-next 09/11] selftests: mptcp: join: avoid declaring i
 if not used
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251226-mptcp-issue-603-v1-9-bb30e331b839@kernel.org>
References: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
In-Reply-To: <20251226-mptcp-issue-603-v1-0-bb30e331b839@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EPM3VrvMtnC/n2lqAnWoJw0H0//DaGS52xi+CA6xgyQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL9dB8pVb8sirzKL/FR/8nxw1NsZulvqdrc+vp/gPELQ
 XPjM7tndZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEyk05Xhv+8CweXH3+yecqTX
 //ri8KOp1s8X6Z7q5xDSKQl+plg+YSUjw87/Jw4dio8P9f3we4nrHudW4aYtP+yF526UzNWu//s
 omRUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few loops were declaring 'i', but this variable was not used.

To avoid confusions, use '_' instead: it is more explicit to mark that
this variable is not needed.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 80e03168b419..4ca4bdfea246 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -603,8 +603,7 @@ wait_rm_addr()
 	local old_cnt="${2}"
 	local cnt
 
-	local i
-	for i in $(seq 10); do
+	for _ in $(seq 10); do
 		cnt=$(rm_addr_count ${ns})
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
@@ -623,8 +622,7 @@ wait_rm_sf()
 	local old_cnt="${2}"
 	local cnt
 
-	local i
-	for i in $(seq 10); do
+	for _ in $(seq 10); do
 		cnt=$(rm_sf_count ${ns})
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
@@ -648,8 +646,7 @@ wait_ll_ready()
 {
 	local ns="${1}"
 
-	local i
-	for i in $(seq 50); do
+	for _ in $(seq 50); do
 		ip -n "${ns}" -6 addr show scope link | grep "inet6 fe80" |
 			grep -qw "tentative" || break
 		sleep 0.1

-- 
2.51.0

