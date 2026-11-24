Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557697;
	b=KV6PpTr6YxSWIj8G8Rdm/T8d/milkIc3DdawcBCaxDfiNzYn+W7J1dn3Hz+8tA2+5e/X
	 Tz0Vo2awpgD7XRM3gelD2PAJBWzzN34goYyu19F3HwEjClspeB8cPPJmd/aOM+E5zcrxB
	 8HFyr++1Pd/z6ZLI5KgqEABrvfWE0vmemA+cIjSFIaUEpz/IznA6UqBgC40S9MX3q/u9Z
	 YA5M63/XbwZNs9KuCZbFMf9/9zzF56rc+gRHsbQ8neQuzraMyP5qDS7OtLp3Pb099flGx
	 4yagdw0gJSVHjcp6qKHudmiGy2bWJQT4GYCwYG6CwxYF6BkYwYWHHEYUfqDnmESR2rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557697;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=wbAbnYLs2apZxN093TzfpkoYrML8/18qG1jS6EmpIZs=;
	b=LECRhGRTFfB8Ufg6tzeS1POCGG8z80YyPEpO3FvIc+JuA1k6iyK3UsrwPyT/P+qCF8a7
	 +4kHg2G2lQd6Dh2gizW8uv4Iqka5QX/ghLjlR7ctUgHVLhCy+a8TbGogG/e/bX4gpD8pB
	 QmHv88My1opeiuf5OZ7MROXPjZ9PpSQd5j+wx0Ywr8PjGcNxUoLHUHmqX95JWNIn+Rf5z
	 yTbsclVaPcwaWT1rYb56YNUVjNh44PADji2jbqYAvXB6Sk8kPVzBJRtqKuTqPQwHoDYQT
	 aEmDdECGIIZgdWn4ertgYrtPASHDDYnRrwTvBPtbCfhyxfq1NS9XpXUs/wM9aYlec+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxKtxGrs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00773606A321
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxKtxGrs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EB81F000D1;
	Tue, 24 Nov 2026 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557696;
	bh=wbAbnYLs2apZxN093TzfpkoYrML8/18qG1jS6EmpIZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YxKtxGrs7/DpqWBMi7zA+nZKQlBOI7pYoXf0Hx9xZBQXeUgkEeOX8kLonRoae/dg4
	 Whk5DFWDYYoT47MIJK6X/DToJ3IPziLQMCgjwya+mX1NW3E/OwVUPTIHri5efJOhj8
	 /JlyeTaLnzkZovuMkFUzd0+cImbpL87at+R4ZB7fhf12clpv7JOavdgKmXOKO03yoe
	 inqLpqajI4iATm15Txl1kmg8OSQ1HPG/x9WdFZr1rZpgNd6LIJVP+55Zqy5+v9qPZL
	 GT5/d8rC8JQmUsCmBhayf3taOMD5oGYr3dL5X1WITDt8ItL5i6dGZwauldEkOEjDGO
	 vrvvPt8ArHpnw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:48 +0100
Subject: [PATCH mptcp-net v3 31/50] selftests: mptcp: join: check re-adding
 signal+subflow ID 0 endp
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-mptcp-cmason-fixes-v3-31-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gTxHTW3EiHcEbebTLKtci6ohXctGsjdpDOtO1WTEqRo=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOLm+1c7sben4sVn+5F4lx4v93lXKd39bvtLX1Q5e1
 vig8uznjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlIpzD8D/StmveBN+f8uke8
 BwUnds108ZJds++22dLNyVoBi5NL8xgZzt6b80/HqIIjLvjOBAfBbZ92Hnw3UUvc7GzF3OVvJM9
 MYwQA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) had both the
signal and subflow flags, it was counted as used each time it was
re-added, while this counter is not decremented for this special
endpoint. Once the counter reached the number of subflow endpoints, no
more subflows were created.

From the second round, this endpoint is now re-added with the signal
flag too: without the previous commit, the subflow is not re-created at
the third round.

The ADD_ADDR sent at these two rounds are dropped, and not
retransmitted: if the server received them before the new subflow, it
would try to connect back to the address and port of the client, and
fail, which would change the counters. If they cannot be dropped, e.g.
with an older version of nft, the signal flag is not added, and the
subtest is marked as skipped.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 9366922adc6a ("mptcp: pm: fix ID 0 endp usage after multiple re-creations")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: skip the signal part if the nft rule cannot be added (Clashiko)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c3ccce96b45b..4c045532f137 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4387,17 +4387,26 @@ endpoint_tests()
 		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
 			ip saddr 10.0.1.2 meta l4proto tcp \
 			"${RM_ADDR_OFFSETS}" drop || nft=0
-		local i
+		# No ADD_ADDR to ns1: it could try to connect back to ns2's port
+		local i flags="subflow" signal="signal,subflow"
+		ip netns exec "${ns2}" sysctl -q net.mptcp.add_addr_timeout=0
+		if ! ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
+				meta l4proto tcp \
+				tcp option mptcp subtype add-addr drop; then
+			mark_as_skipped "unable to set the 'add addr' rule"
+			signal="subflow"
+		fi
 		for i in $(seq 3); do
 			pm_nl_del_endpoint $ns2 1 10.0.1.2
 			sleep 0.5
 			chk_subflow_nr "after delete id 0 ($i)" 2
 			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
-			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags "${flags}"
 			wait_mpj $((3 + i))
 			chk_subflow_nr "after re-add id 0 ($i)" 3
 			chk_mptcp_info subflows 3 subflows 3
+			flags="${signal}" # ID 0 not counted as used either
 		done
 		[ "${nft}" = 1 ] && ip netns exec "${ns2}" nft flush chain ip filter OUTPUT
 

-- 
2.55.0

