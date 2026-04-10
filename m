Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF2A393DE9
	for <mptcp@lists.linux.dev>; Fri, 10 Apr 2026 14:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831537; cv=none; b=iNm2lhn0e5BnIVIQSCGnskuBtzRh2XcY9LVoiJxKiC5WF94VHhKLTDUb0qcdusMMjRDHFbDX7PzImyIPasxST8RRktm4kr0IAYLFVrqOnmpClYex9KUClO50aF6b/0zZ0L0NfJ6ZJofkZNNxM9UGu/W3PZKsdVITyYJpsSq8dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831537; c=relaxed/simple;
	bh=k+RpxqRdGerfGFAGy1z4N+ND2xXyRKGbPOpBhMvR2Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NxStkc0IudZy4kjMvPh8bagvuHyXflQ4YHk4uuCyvHUDxpQw6QOseCYwWr6JyFnFqbDeKVwmd9oIEAa+tGFsXi105TuCQfw3edEfBWO2UJDDhMuz7LAEiEGD6KgMD/T0Rz4BVgRRbtuQcBuLu6tgj2yJBVMWXvstyqA10yf1cU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYkqTF4M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYkqTF4M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7066AC2BC87;
	Fri, 10 Apr 2026 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775831536;
	bh=k+RpxqRdGerfGFAGy1z4N+ND2xXyRKGbPOpBhMvR2Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CYkqTF4ME3ivXRzhmDOAcdue/gyBvyv9jAIxegxFV96rlbRPxKD71sDlj/kOXClpH
	 +L9i7bI5JZgtVFfM3SDbml+uPGZHlM9be0o9Oy+FPucLEidQJrWs+cZW6CaI0B4qmL
	 OrrWaYVP93QCxvgi7hxk5fsTegoWFDZzHRdI2peiUy+J886D/hNmcUesKrx9xlNIZ/
	 EPeAaKJPPZINJNhOs1CUnxm89gJdS3KjcA8Qe2ngqfNEPG0vh8Duu21utxUBwU221D
	 YoKy0h2Bodsd+uaoZKtaul3CHjPLdWNOuIVd7Ntwab1GxwtTbowWDucTol1bnm3nq7
	 PMjTrkNPMfTVA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Apr 2026 16:31:51 +0200
Subject: [PATCH mptcp-next v2 13/17] selftests: mptcp: join: allow changing
 ifaces nr per test
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-mptcp-inc-limits-v2-13-5402209f05d3@kernel.org>
References: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
In-Reply-To: <20260410-mptcp-inc-limits-v2-0-5402209f05d3@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1877; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=k+RpxqRdGerfGFAGy1z4N+ND2xXyRKGbPOpBhMvR2Mc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvcj5WZ2SNMHeTUn0QtTL9FF/O39cLTesiHDe1hfJXF
 Ykbz37ZUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJF1hQx/5T6pPf6i/HlKy6F4
 tWNXZRvZzqqHTH+/+d+cqWEbBW8VrmH478zONfGdXeO8wEVHY97e5T9UlJhW+dhPz5Lb6r155s9
 2VgA=
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

