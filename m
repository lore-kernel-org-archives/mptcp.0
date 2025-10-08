Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C428A1F1
	for <mptcp@lists.linux.dev>; Wed,  8 Oct 2025 14:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932019; cv=none; b=fwEQKWAvCcrkp7Gdt/5yubLMrIWa00k1P9t4Y4cfVK2aEFPKuuYXmQU3NqfCibPB3nQksNxqQvwbafP2lRejrYyrazoE9zCFZrf7EuFozAqPMFWivl+aXZ+tXpnfvxanuGQCJHJ5ZPPhdzTJUK+kYmHaL9wCvMPSXkvpytQ/OKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932019; c=relaxed/simple;
	bh=y4WjxnScvHlWoZP1vF6ucAz1MRe5ZvhlTCcDQHvnOmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiF9+Q3u+hluxxko0hw+T4QaGAlrjclabGfJR7rHgav4ZHdtnn+G/ucbTWVV6cqOrT/5NSnRzTQCld9WSFoaHFlw93UUPDuQ3BMZnpF5EZfcLSXfH6pk078kXyEwTqoHVaal3SbK6P5PJ9jPtyDXoq57YyBsJt0Ht8+iKyW7NCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maQnxvMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maQnxvMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EFFBC4CEE7;
	Wed,  8 Oct 2025 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932019;
	bh=y4WjxnScvHlWoZP1vF6ucAz1MRe5ZvhlTCcDQHvnOmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=maQnxvMZomoeQbznnRixluH/yjMTuhZ/aYNUWNMcoFI5FGA5hKDVbnvbFzbL8eW1G
	 wk3ikNclC9kUGMpCczhLtDUNKvBPJpvVmZIeTkLa9bqBaUCkC3hPza0ZGiMnF9TmU+
	 vC0McVdik7n43azRgh6uVNBn1wWyh4K7H41DuxSxFkP4AR0UqdZlhRk92vDNrgiH3G
	 BQt+sLSizdh6ZvaV0sT17GHFj/YfkgX+3Khn8ACotAjCT6jmePQoNoovIyOBT8gAVH
	 XliLNahszy3RrCPdLbNaie2xeuRPqlmQZFOddDmPAaNthBjwpE4mT4oRJEb7Dc9UkG
	 rKpmdau+c6lsA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Oct 2025 15:59:58 +0200
Subject: [PATCH mptcp-net 4/7] selftests: mptcp: join: mark implicit tests
 as skipped if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-c-flag-add-addr-delay-v1-4-c624eb3bf10d@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
In-Reply-To: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y4WjxnScvHlWoZP1vF6ucAz1MRe5ZvhlTCcDQHvnOmQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKe5WU9zZDyk86IsngkYXLfssjm5+20K3ISrL4ZExTCt
 vDH6pV1lLIwiHExyIopski3RebPfF7FW+LlZwEzh5UJZAgDF6cATOQSN8NfQYPGw5/fP2ozXrLU
 dPnlwhwzFo2oORcjyrmLmZqrH5vXMTL8i1218WhvjIRQwtL5u6VFBEuYEje0KU+Z/7ht2rY77/e
 yAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: 36c4127ae8dd ("selftests: mptcp: join: skip implicit tests if not supported")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 59983aed2591..b2a8c51a3969 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3939,7 +3939,7 @@ endpoint_tests()
 	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
 	if reset "implicit EP" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3964,7 +3964,7 @@ endpoint_tests()
 	fi
 
 	if reset_with_tcp_filter "delete and re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		start_events
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 0 3

-- 
2.51.0

