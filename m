Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ECE39B947
	for <mptcp@lists.linux.dev>; Fri, 24 Jul 2026 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876041; cv=none; b=qoadkHLAi4NsqYWciQenl3rcooENhdtRrCsbTqZufGTytwjgposYnNj1S8PhiBbd9LNYSZblUas4rNKRXt4gnXxVjCTZH03fJszezhCAO826AR6n1JuN7xiHAUA78zL/czdKpV+WV9hDd32i2/69QtwzBhZUVTdz0vTlfLrLWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876041; c=relaxed/simple;
	bh=I6rrJjgipQw18hs6s2WhOf70H7Gf9ApQyJ8NDsonPwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTA3zq9kGGbl3atzwwm9+0VvlvHn5q/NsRIngfu252TptaIrx7mdW0JBitRLbma+naDotS4id/WMjmHxHBd7FqF+wt/2bDq63RSU8C0IeNX0TutMO/Np8W00hrkvzu9G2hfLpHGU++uMbQ8SK+mz8bgpPLqawaNnUk/Xj1Vg9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W69gzrUR; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W69gzrUR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784876035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L+fy1Spn4iWVTIwc9G0X4PxZt69qquUd81r0UhizsJ4=;
	b=W69gzrURs7UT2PfD6h7cw/bgFVzwZDN1eAY37d2ONNNpTg6sEwpXx3RjUukQHusgShZVrM
	PeQ28C/A7EgzA6TW+Uf5ukYqTBPkml4JkCXT7hhYPTZZrMcoNSUl9KGTiXio1HG5iTA1Wv
	fEe25Tbj19K5QrJnWzf+vEMdPpEJdI4=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next 1/2] selftests: mptcp: run fail_test in main shell during join test
Date: Fri, 24 Jul 2026 14:52:28 +0800
Message-ID: <20260724065229.36736-2-gang.yan@linux.dev>
In-Reply-To: <20260724065229.36736-1-gang.yan@linux.dev>
References: <20260724065229.36736-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

check_transfer() compares the input and output files byte-by-byte using
`cmp -l "$in" "$out" | while read ...`. Because the while-loop body runs
in a subshell (the script sets neither lastpipe nor pipefail), the
fail_test call inside it -- which sets the global ret/last_test_failed --
and the `return 1` both act on the subshell, not on check_transfer().
check_transfer() thus always falls through to `return 0`, and any data
corruption affecting only the payload (leaving the subflow/PM counters
untouched) is silently reported as PASS.

Assisted-by: Codex: GLM-5.2
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 550a6b6117a9..2413c832af03 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -584,7 +584,7 @@ check_transfer()
 		mv "$tmpfile" "$out"
 		tmpfile=""
 	fi
-	cmp -l "$in" "$out" | while read -r i a b; do
+	while read -r i a b; do
 		local sum=$((0${a} + 0${b}))
 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
 			fail_test "$what does not match (in, out):"
@@ -595,7 +595,7 @@ check_transfer()
 		else
 			print_info "$what has inverted byte at ${i}"
 		fi
-	done
+	done < <(cmp -l "$in" "$out")
 
 	return 0
 }
-- 
2.43.0

