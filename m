Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50633F8BC
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767941; cv=none; b=riHpTZ0Omxwio+0hD7jfyT7x/BC2cxppoBLx1fKkvXFOLqFjiyatBldAxLKPBOtfxj5N4bUMf7JsK3FrczLHw84JBu1jR683nj3L+e81Lbl6wzcAK5d5mP+AJGMXGYMgd13wrGldBbUWuV3Hi6L6eMVFCWm2tli62BiEkuvclZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767941; c=relaxed/simple;
	bh=k+RpxqRdGerfGFAGy1z4N+ND2xXyRKGbPOpBhMvR2Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2q33c4nn7KGhLrFsGRk2lr63oWmpmJXbtEaN1CbSW/y9L28IcEtKi84d6emMJ4V6SotHTnAJ2sPJdsNixwjqMlqA6Zzbq1FcMrX2lFp0uG2XBhyEh8x+U8d+vgZiY5MU+LyBQkQfGUtQrGeT6L5/0dN/Dayc02bz307HUwstc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwoZRtPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwoZRtPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFC7C4CEF7;
	Thu,  9 Apr 2026 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767941;
	bh=k+RpxqRdGerfGFAGy1z4N+ND2xXyRKGbPOpBhMvR2Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZwoZRtPyTy7anpQQVRKXNGGvnxD+9nukRQoktv8GhKT3KZTKHZ37pEbEqJkKrAaLW
	 v7DI4c1oJLQTkKfMhKNtFAU1y/p+/lSNBcZBI319ic27FwkaZZS2XtzjBytwv8NRXc
	 1UQaTc9da5ze5LbBrK7Ncie/DzrH+kTSYDvpMCeMUugCjG6iKj9KqWUES43ApzqhmP
	 3O8x3Z9Vzrq9cSWwo4uDJwnFF28LFac4vnFUu9Kq0QvvvqW9bza/VMaWT6Ku1Vpkog
	 klB0nM7ESLlPO+DJr2VKYVumzPDJmeiuBjcbsj2ejSuP01a7dkY2rSL7JZ0sMRJZzs
	 uBnR0cUXmUpgA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:52 +0200
Subject: [PATCH mptcp-next 12/16] selftests: mptcp: join: allow changing
 ifaces nr per test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-12-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k+RpxqRdGerfGFAGy1z4N+ND2xXyRKGbPOpBhMvR2Mc=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGnYEXigLv6pWkrAsA8qCOvxOEaNUsA2SQdD1e5Q45hQDpwAo
 Ih1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmnYEXgACgkQfCLwwvNHCpd6IAEA08DV
 SH3DHP1wbJCBvNP3Qyjba1r6iLEHbeGQOz0rnOwA/jlVFQmqU4Yl3ZGlGYtRB1B7RmnbCyOQTZQ
 ka/tVbcMD
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By default, 4 network interfaces are created per subtest in a dedicated
net namespace. Each netns has a dedicated pair of v4 and v6 addresses.
Future tests will need more.

Simply always creating more network interfaces per test will increase
the execution time for all other tests, for no other benefits. So now it
is possible to change this number only when needed, by setting ifaces_nr
when calling 'reset', e.g.

  ifaces_nr=8 reset "Subtest title"

Note that it might also be interesting to decrease the default value to
2 to reduce the setup time, especially when a debug kernel config is
being used.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index beec41f6662a..28da9df797ae 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -63,6 +63,7 @@ unset fastclose
 unset fullmesh
 unset speed
 unset bind_addr
+unset ifaces_nr
 unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
@@ -146,7 +147,7 @@ init_partial()
 	# ns1eth4    ns2eth4
 
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
 		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
 		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
@@ -165,7 +166,7 @@ init_partial()
 init_shapers()
 {
 	local i
-	for i in $(seq 1 4); do
+	for i in $(seq 1 "${ifaces_nr:-4}"); do
 		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
 		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done

-- 
2.53.0

