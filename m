Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373C347C3
	for <mptcp@lists.linux.dev>; Mon,  3 Nov 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197595; cv=none; b=W9VN6VBDADnJk1A6ex8homxQvIp2NbZy/d8dZh/xYcUayhhYREt3xGG2A7WAbe2iV+X3WUQBYWN8ygFSOo/bsnumZ1txP0pf0cVRZpcOxa1/WL0g8x7WHn1fkbbX5Sd7bm4mtlgYPQ9AVbyrcT79BViDM5tO4DdVwSGTg34h4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197595; c=relaxed/simple;
	bh=cduwUTy0dA19w2e1JXRwS8/lqpsyvjnafgcUjwDdTCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwjRdlCx+dPUvaCZz9vJvHvofCLBqxfOquMiHiuSzZRpyPPl+pWtgHiEy6ZSxUlnGt7hCz/aIJYl5ngY58CQdP8BnA4FSU0h7s9FGdDPGjOIF/kAXG3BHy8EDoeuC7QnhFW4X233MAb9C6R5DVYMpAPtkjdkJB+0OuaX/siSR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX8I5KJO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX8I5KJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF26C113D0;
	Mon,  3 Nov 2025 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762197594;
	bh=cduwUTy0dA19w2e1JXRwS8/lqpsyvjnafgcUjwDdTCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SX8I5KJOIdK8zCcIZk8nqj9UvnHCMVz6B+Onz+DtUkkiGckeoJynI1sF0TGALwzOD
	 4BBBu73/UNT5RBiy8p/Fwq535cPVLYddkLsz8G4HrGAdETs5ZaBuXiB8LMC7hyEKV4
	 a0oIsW5Xbkf6toFvj1Kb04FSBCXB5RJIHrp9Bq6Tt7txSuVPGqXUcoUnH1Jc/I4gd0
	 125zffiTGHLfo4o+jpspSHj32McAYyWp6gGERb01DWFa+n7RZEfYwunfG2RgR4DNXs
	 j2iWDa2mfzV+LTmMH/WTFG5zFweVUiUQ1Qec3e+rqVrOwt5JUkLo2KhwvvWhkcGJW9
	 A7fHawxVw3WIg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 03 Nov 2025 20:19:34 +0100
Subject: [PATCH mptcp-next 4/5] selftests: mptcp: join: dump stats from
 history
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-slft-nstat-cache-v1-4-56025c09e56a@kernel.org>
References: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
In-Reply-To: <20251103-slft-nstat-cache-v1-0-56025c09e56a@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cduwUTy0dA19w2e1JXRwS8/lqpsyvjnafgcUjwDdTCU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI5GUIT0pmmPjurnVfceH3Sj/KfVjzF+afXMvWHXqgM4
 3CY/m5JRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETu/mZkOFl142u1u/Hn7erl
 09l/fYy8dXdJ38a0T79S3iadeaSofonhr/BF5Tf8L7ymL3x6mLvz8PYbHd0r3Bd9LG09+stShUv
 9GhcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, dump the stats from history instead of using nstat.

There are multiple advantages to that:

- The same filters from pr_err_stats are used, e.g. the unused 'rate'
  column is not displayed.

- The counters are closer to the ones from when the test stopped.

- While at it, the errors can be better presented: error colours, a
  small indentation to distinguish the different parts, extra new lines.

Even if it should only happen in rare cases -- internal errors, or netns
issues -- if no history is available, 'nstat' is used like before, just
in case.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 ++++++++++++----
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  |  6 +++++-
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ad0981e0b377..6afcf6ad2788 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1163,12 +1163,20 @@ run_tests()
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
 }
 
+_dump_stats()
+{
+	local ns="${1}"
+	local side="${2}"
+
+	mptcp_lib_print_err "${side} ns stats (${ns2})"
+	mptcp_lib_pr_nstat "${ns}"
+	echo
+}
+
 dump_stats()
 {
-	echo Server ns stats
-	ip netns exec $ns1 nstat -as | grep Tcp
-	echo Client ns stats
-	ip netns exec $ns2 nstat -as | grep Tcp
+	_dump_stats "${ns1}" "Server"
+	_dump_stats "${ns2}" "Client"
 }
 
 chk_csum_nr()
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index f59268b25707..603f33885f8e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -110,7 +110,11 @@ mptcp_lib_pr_nstat() {
 	local ns="${1}"
 	local hist="/tmp/${ns}.out"
 
-	cat "${hist}"
+	if [ -f "${hist}" ]; then
+		awk '{ print "  "$0 }' "${hist}"
+	else
+		ip netns exec "${ns}" nstat -as | grep Tcp
+	fi
 }
 
 # $1-2: listener/connector ns ; $3 port

-- 
2.51.0

