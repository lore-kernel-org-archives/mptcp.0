Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F536196E
	for <mptcp@lists.linux.dev>; Thu, 13 Aug 2026 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786616981; cv=none; b=JHzG/cgV0tx1oonTb8trWKEqB+050PoTDcB1IP1SVKnb4XQJ4zTRPCmPHnP08/MeLxJwtKFUH1iY0nC1cpO1RoO+THX3UMIWwVvJZKXK/uAuY2Ga9JjN7VU7DxU1qnc2PEqpYLrWAIRHT/Y2hVghIO8L8oL/2ssqN78u8rMny+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786616981; c=relaxed/simple;
	bh=YflyKlQeOB+yHzJvCzRrIZMYXV03AIQUygOhu5Ov1Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bvpj7dACO6nNq+I4dQSOEiqMtmL1AGQEA2xktvPkiWJwpFQYnc1tmHelBmqM2scYbfL5SHGrVcCHMlLFDWFHiPDaP/y4toCMWhDLEngmsXRPSkQgkw6qVJMIDssY99NzvYEgoWb6LGp2pTq+Me1E0kmWq7BI/p8Nyx2v2gQQ0B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGNkJUc+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGNkJUc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7391F00A3D;
	Thu, 13 Aug 2026 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786616980;
	bh=y04qYWuBJhf+Yn7ONjNH6AbMoZZrvqQsXPO4+Lf4SGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VGNkJUc+U5uTytOdPd9Cm8EOXvxWWhTBLaawxlhp5t3XPsDpp0By1aPCT8M4saLe+
	 MO4G5LZxmJ5aROlGzX9XJiawZYHxk+aLKnuiighJooDvcWgmz8F2hzVdCgTLdRvEcw
	 BVXVK5hXpY+K6HDi8q741j/gLgWAUvDizr5g4SwKAGRVR7fxtFOe3miS8WAfl8yQzC
	 ag0MrXnMbb8wu6KJgzp1y7gAkgQYvMYQYbq0q6yqekWN4Z9sEi88VjUriIGXzjUbkG
	 LQtg3xyk/F/YyLx3qrgjMw1xeJwgOzyRT7+SSb/UjXQS4NIdi7AyotJvFKtDg9A/Ek
	 KRm1ulK886Sbw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Aug 2026 12:29:32 +0200
Subject: [PATCH mptcp-net 1/2] selftests: mptcp: lib: dump nstat for the
 right test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-sft-mptcp-nstat-hist-v1-1-5bb96bae7ef6@kernel.org>
References: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
In-Reply-To: <20260813-sft-mptcp-nstat-hist-v1-0-5bb96bae7ef6@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1750; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YflyKlQeOB+yHzJvCzRrIZMYXV03AIQUygOhu5Ov1Hk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLJq50wQeL9vC6c6R0nSFpMJTzumT5OsYKwysrps6MGp5
 DV15ybGjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlc/snIcKN7F8PUP1Olg9Z2
 nzZI9AxOLi15UPnKSzEy53yDYvmeBIa/ooysRhdPbX3Sz3fR1ulkxgK2gztltn5aFe21UGu9ze8
 wXgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In case of errors, mptcp_lib_pr_nstat is called to dump the nstat
counters, but for some tests, it was dumping the counters for all
subtests, not just the current one.

That's an issue for tests that don't recreate the netns for each
subtest, e.g. mptcp_connect.sh. In this case, 'nstat -a' will look at
the absolute counters since the creation of the netns, making
debugging harder.

Instead, it should dump the counters for the current test, by using the
history recorded in /tmp/<ns>.nstat if available, and not using '-a'
which was dumping the absolute values instead of calculating increments.

While at it, rename the previous 'hist' variable to 'cache' as it was
used to look at the cache, not the nstat history.

Fixes: 658e53141780 ("selftests: mptcp: join: dump stats from history")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 5ef6033775c8..da1da414c30f 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -108,12 +108,14 @@ mptcp_lib_pr_info() {
 
 mptcp_lib_pr_nstat() {
 	local ns="${1}"
-	local hist="/tmp/${ns}.out"
+	local cache="/tmp/${ns}.out"
+	local hist="/tmp/${ns}.nstat"
 
-	if [ -f "${hist}" ]; then
-		awk '$2 != 0 { print "  "$0 }' "${hist}"
+	if [ -f "${cache}" ]; then
+		awk '$2 != 0 { print "  "$0 }' "${cache}"
 	else
-		ip netns exec "${ns}" nstat -as | grep Tcp
+		NSTAT_HISTORY="${hist}" ip netns exec "${ns}" nstat -s |
+			grep Tcp
 	fi
 }
 

-- 
2.53.0

