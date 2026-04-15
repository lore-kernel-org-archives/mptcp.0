Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD40217704
	for <mptcp@lists.linux.dev>; Wed, 15 Apr 2026 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247103; cv=none; b=B8/Zy5/S+wwdzMiFhcJ+tP+CGk039e49T+SA32cpSGMMKOLPeS+5UJML/ei4zHzoyKB0sa+d+POGpFUre57gKIc7RsEJ2G4MnaRZAfrRtBLA3nxSF4UJndZBvixe09OnsT5QHInGLjv3U8K94MnYZ5+qL59njkyvFlt35R2+RIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247103; c=relaxed/simple;
	bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1flsBaNTLxPnFpSldkpp6LqgL6OCxhPrS3Zq0oDf0YrdirdAzzmAM6FIXhMmB/kdIWVJstbTMfjd4n2igZy30rrh2hAi95WRCOKu6zLm766cDcz+U2cMm8mzgv00FmEkJ+RwLn32TY9lFLDbkH4Pgbk8NIhBczQnraGX1C03N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDz88Rbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDz88Rbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B3CC2BCB5;
	Wed, 15 Apr 2026 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776247102;
	bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tDz88Rbx3phUBTAQBAwMjSxSyXs58XTmid2+VXROWYYKrBDLL3P3r6J/v6JNqqZ8N
	 2kvyZaQa6DR02yOseuTDdirk4kkrEFBXer2ESD30aHwH1TS+1LMxs0xhduzLF7GA5y
	 KiZKNYAZTaoQsE/YyXwCMyYEB4Kf/CFPvgcfF38OsaSTgq+oJHN7VuZU0ziLAsYUs2
	 SZu1b6jGKQyZILW7C0nj6fPDp1Fl1kSe+XxdEftBKVQOhB+fcEaPpGx4Y2m8mNjQf7
	 o+Zbbft04TAuGj8AK87TYEz+/pm0K5X279eG37hPUZ7Ak0+5BUrFQSF0QJ3T4RsiIv
	 rr9BQ3NPtIBVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 15 Apr 2026 11:57:04 +0200
Subject: [PATCH mptcp-net v5 16/20] selftests: mptcp: join: allow changing
 ifaces nr per test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-mptcp-inc-limits-v5-16-e54c3bf80e4e@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
In-Reply-To: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1924; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WPXlOnsY4b8ca/bPVxQbeZN3bFUC8KRS1pNiKQk+mGY=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLvJ+oxey8sOpp/K11e7ZY/s4hBtoO5Vu8dU5uzerN2C
 V2//+9VRykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETUUhj+x53+uixbZKv7idzb
 GkfeBbfLdmn1Ciqs0tsQPPmUddacFEaGhxvOrz9jvqvsUOLbTmnbovUTjz3/PO/zmp6eN7E7Npt
 J8wIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

By default, 4 network interfaces are created per subtest in a dedicated
net namespace. Each netns has a dedicated pair of v4 and v6 addresses.
Future tests will need more.

Simply always creating more network interfaces per test will increase
the execution time for all other tests, for no other benefits. So now it
is possible to change this number only when needed, by setting ifaces_nr
when calling 'reset' and 'init_shapers', e.g.

  ifaces_nr=8 reset "Subtest title"
  ifaces_nr=8 init_shapers

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

