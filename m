Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF81EF19
	for <mptcp@lists.linux.dev>; Thu,  1 Feb 2024 05:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706764773; cv=none; b=TyKZq3W8HC8pPkcDBGTPyl34JxHsyN5i7rlxx/dDzaf0w2iNZt6l5kAqToHmqOc/VBgtRy7UpXsxKwJVE3ADRPS4VgRSw2GUs0yo3NqwaI8GKpGyQGclmI4j16Y3+raUWL98abEK+hLEO2/vxZ7udOr4PyAvqHBZANQXFrYxkgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706764773; c=relaxed/simple;
	bh=60ROJHfRntDedV6gOeO3zJcIjk31fGLtY5sWOApuFTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UAuM8x2GjIqMKuxjdGnOJ7gt/fb6LbEM701X5B5P1D9ZWorg5Da/RDLKkbIYcn8t5N2bWJ/RhNo0syydeEX43x9XtO59a/JWZOcsYz/NajZE7YA6beaqjxQzJi9un2mcpRNYfvNR2pVvok5XfAzfBXtk/7VBljHJOWb6dVqvIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brmCSPZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brmCSPZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F32C433F1;
	Thu,  1 Feb 2024 05:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706764772;
	bh=60ROJHfRntDedV6gOeO3zJcIjk31fGLtY5sWOApuFTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brmCSPZyc4O7TN1f0mbz9tf4BDBlXxxzNlZQrVZ2uZgMV2o3zVoQHQ8NpqDBf0txq
	 R0its2lo9gDqzPNfaIDgxXih2ARm8xvX6806hjMNlPVPYN2PTB3oETUOiDSBTw/lJp
	 HxjRvitUNvC0vXYZ+Px3EXfIaL08MWiDHnjMhS39NSVO9UHtmBFUoJHPxKP842ZcuI
	 GQtgDq/KRt8+tUWYrmiFAEq+G8NbZQx0caAh+D9Q5OSOtxz8RDap0ZdkaogRyepAOV
	 eoRe4GAIJkRIEGonGCdgfUvF2td4J6xPXKMpXO0NAXBW/hOu/qB8/Eg3zxFugqTLzK
	 cY0z8fZoqmy1g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v11 15/15] selftests: mptcp: userspace pm get addr tests
Date: Thu,  1 Feb 2024 13:19:05 +0800
Message-Id: <ae91947234017dd7e8c5c8c02864131bdc99c33f.1706764519.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706764519.git.tanggeliang@kylinos.cn>
References: <cover.1706764519.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_get_addr() in mptcp_join.sh.
In it, parse the token value from the output of 'pm_nl_ctl events', then
pass it to pm_nl_ctl get_addr command. Use this helper in userspace pm
dump tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4ed0796410b9..dcbc22bb2fd6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3366,6 +3366,18 @@ userspace_pm_dump()
 	ip netns exec $1 ./pm_nl_ctl dump token $tk
 }
 
+# $1: ns ; $2: id
+userspace_pm_get_addr()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl get $2 token $tk
+}
+
 check_output()
 {
 	local cmd="$1"
@@ -3603,6 +3615,8 @@ userspace_tests()
 		chk_subflows_total 2 2
 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
 		local dump="id 10 flags signal 10.0.2.1"
+		check_output "userspace_pm_get_addr $ns1 10" \
+			     "$dump" "      get id 10 addr"
 		check_output "userspace_pm_dump $ns1" \
 			     "$dump" "      dump addrs signal"
 		kill_events_pids
@@ -3625,6 +3639,8 @@ userspace_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
 		local dump="id 20 flags subflow 10.0.3.2"
+		check_output "userspace_pm_get_addr $ns2 20" \
+			     "$dump" "      get id 20 addr"
 		check_output "userspace_pm_dump $ns2" \
 			     "$dump" "      dump addrs subflow"
 		kill_events_pids
-- 
2.40.1

