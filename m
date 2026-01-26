Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB3280CFC
	for <mptcp@lists.linux.dev>; Mon, 26 Jan 2026 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455496; cv=none; b=ibTyDRqSLZTBzgpcbBEwFYUOrHvWrMAV0x6jAr0qanQcWNLlyXOdHX71dNLnB+B5SMzezPUHxmfm9gSw/iuffz6t0VPt7on7KCVaEZKOwAZRSUxGcXG2GovKAvtq5geZB0P5a1gxcCKoew7oAdfU0RYgndqHPMz2DGMc974GtbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455496; c=relaxed/simple;
	bh=Z8cK/JNiqVPUBBg4tXXQ1Y0y30lvNWBmJ1Pbnubo00c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R2ZL5CQZszaI6VL0WNccJw8/PnhaYgBfiCXfFrcV72aXHGvWO6TGQShvbULOgoFukcDdF2uDvU63cwb6oKa0lHG/i9P9ZitCyidZvnAQK/aowL4zYSy/wUwvUlmX+N8qHRoRTOi3/5DFIyzgQPDXLrEMKV0+vlHiy2/Evgdezzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghaxxZvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghaxxZvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E0DC19425;
	Mon, 26 Jan 2026 19:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455496;
	bh=Z8cK/JNiqVPUBBg4tXXQ1Y0y30lvNWBmJ1Pbnubo00c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ghaxxZvh/sCSV+CtjKbYMkqMa1/RstAKp7VpRrJuW70COqdpmiZF8URIUWIYLM/u2
	 yuImPYZ4Sh4ioKmCI4/SBrl0fajnIdvZSvNe3DeXTKDRqFbVRQI4dYaXlDET1fT23t
	 tyq1p+Yni+y/8LpOBDc57TT0vIhMsWNP24QmAP63JTwoQnYgYQeqvQuOXlsOwlsz4y
	 Y0jyy69WHB36+u2aeVoY0FW+N9NjNeoVCTOgjjB7tyzt5N4Px7Nw+8rG6HdDr57JMO
	 +aZHeBeBKPYlwW6PxIEiKkFRcwsieQlVOgRqI6kFptU4PfhA5qXTmx779vYCc0aWTm
	 TUqOw9QZfeCPg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Jan 2026 20:18:46 +0100
Subject: [PATCH mptcp-net v2 09/11] selftests: mptcp: join: avoid declaring
 i if not used
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-mptcp-issue-603-v2-9-8393e7840b9e@kernel.org>
References: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
In-Reply-To: <20260126-mptcp-issue-603-v2-0-8393e7840b9e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Z8cK/JNiqVPUBBg4tXXQ1Y0y30lvNWBmJ1Pbnubo00c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLL99cdLXV/33Xxe+exbdGHDuje+XyfUfhHUU/KmRRFx
 Q0JXsFqHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNxFmb477xE0ZjjRHPQk4W7
 9rxOi+i32KSR1L6g98/dyfcU9pUtU2f4Z22X0/esmI9v3p7/d1ZOE2AzbDC0Lpm7Sz3nzMsyZYb
 /fAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few loops were declaring 'i', but this variable was not used.

To avoid confusions, use '_' instead: it is more explicit to mark that
this variable is not needed.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a8b9782a85df..0f9253d607c3 100755
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

