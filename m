Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31082881E
	for <mptcp@lists.linux.dev>; Thu, 17 Jul 2025 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794135; cv=none; b=qGLKqvkx1AA53h3IMx59qdTwNDuS1g9KTHsdYryFze5Dm7DJ2G8qLlkVoB6A21Xt9F3rput4yJdK6w2VrcjpWx5McZkTJ6qhsY8VROYi9wvzwogltHBpz/g37p6VLElenOLhrB8NMB1Jba8mWvO/iSARZTwFd/bGudM6YPC5L4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794135; c=relaxed/simple;
	bh=BoMel4jkyIBF7CvhxYA2kXkr1dN59q9WaLnOQAVtL5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gEpXAyjnndazVqIFrH9uz0/MEW31YqFqgA0kCvmjLFtydT7ZaoiMJ/Pvpu0AUR26FUJ2mg+HhqlvVnILNqPXB/aSKEBYMNqd2jmeZx0SHU/wu5jUmUryOwYRkqFNbNBaV9R28/cV4e5LoqSTv2niQFNUITeg1gCOZwI3WFrHAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXFyzebz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXFyzebz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D97EC4CEE3;
	Thu, 17 Jul 2025 23:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794134;
	bh=BoMel4jkyIBF7CvhxYA2kXkr1dN59q9WaLnOQAVtL5c=;
	h=From:Date:Subject:To:Cc:From;
	b=LXFyzebzg/eU4CSYdyjVETl1QuBNRxvhVV4Y/Cu5RCN9LEUY2dxPy6dJ1KhXU+Vf0
	 fLZ3z2gljDzHYDsQOCl4/ooeB2P606IihjD9sfMs8ZilZK7V6qIkTw5l7n8+LPvjWt
	 /CzcDekjupgen60NcLeTtX7pYHo/lSLB2CArfMsHEUiMKIdKDBCe2g+FymmUHsaai1
	 AuWN9gAyiB69NPLnOYqG0bNChlGOsL5DBm2w+c0IKpzjQ9caF+3xNa7ons2vJiNg31
	 N2Qm8nJed9mWYpUmQVbqIMTxHcwhEx0MjJQ58TP3nrP7XNAG3u0V9mAXAlY32ZK0D9
	 ZmzoC7sLGvGew==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 18 Jul 2025 01:15:28 +0200
Subject: [PATCH mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
X-B4-Tracking: v=1; b=H4sIAA+EeWgC/yWMQQqAIBAAvxJ7TkijjL4SIaVr7SETtQiivyd1m
 MMcZm6IGAgj9MUNAU+KtLssvCxAr5NbkJHJDqISTSV5xzaftGeTMSoTVKIN9yMpzsTcSClabWt
 tIec+oKXrWw/wVw6vBOPzvCaaY6N2AAAA
X-Change-ID: 20250718-mptcp-add_addr_timeout_1-2b57726cf3cf
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4061; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BoMel4jkyIBF7CvhxYA2kXkr1dN59q9WaLnOQAVtL5c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIqW0RVyhiTxfTtvUWW3Xi18ZRK6JWPBTU/18Q/S5nRx
 Th11YYjHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOZ84WR4enZ28ezu/a6h79e
 UnHrzhZvTkWuj1fzjvhc5zOZvnzqqo8M/+x/nYmxFL3G122ZvvX6GlVh5v5f0+11ItrE57mxSu3
 /ywkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It doesn't really make sense to wait 2 minutes -- the previous default
value -- to retransmit the ADD_ADDR if the echo has not been received in
between: that's way too long to react.

Switching to 1 second by default, which seems like a good default value,
and can be increased for particular cases.

Later on, we could eventually use a timeout based on the sRTT, with an
exponential backoff, which would be more reactive [1].

Note: the documentation has been updated accordingly, and the selftests
are keeping the previous timeout when using a broadcast IP not to have
retransmissions in this case, which would cause troubles with the
different counters depending on how fast the test will run.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/576 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst       | 5 ++---
 net/mptcp/ctrl.c                                | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 5bfab01eff5a9db89e1484787953241c16e147cf..14059d2cac1b3467d6a8c9c4362f5a0b427b726d 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -12,10 +12,9 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
-	The default value matches TCP_RTO_MAX. This is a per-namespace
-	sysctl.
+	This is a per-namespace sysctl.
 
-	Default: 120
+	Default: 1
 
 allow_join_initial_addr_port - BOOLEAN
 	Allow peers to send join requests to the IP address and port number used
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index fed40dae5583a35914da2cb1c52f37830d72705e..92873457c47ea6b04137cece0200317a94b13e0d 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -97,7 +97,7 @@ const char *mptcp_get_scheduler(const struct net *net)
 static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 {
 	pernet->mptcp_enabled = 1;
-	pernet->add_addr_timeout = TCP_RTO_MAX;
+	pernet->add_addr_timeout = HZ;	/* 1 second */
 	pernet->blackhole_timeout = 3600;
 	pernet->syn_retrans_before_tcp_fallback = 2;
 	atomic_set(&pernet->active_disable_times, 0);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b8af65373b3ada96472347171924ad3a6cf14777..87a9d022d31160a8ff6185b3a117a73841512f9a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2429,6 +2429,7 @@ remove_tests()
 		pm_nl_set_limits $ns1 3 3
 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
+		ip netns exec ${ns1} sysctl -q net.mptcp.add_addr_timeout=120
 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_set_limits $ns2 2 2
@@ -3846,6 +3847,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 3 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
 		# broadcast IP: no packet for this address will be received on ns1
+		ip netns exec ${ns1} sysctl -q net.mptcp.add_addr_timeout=120
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
 		{ test_linkfail=4 speed=5 \
@@ -3919,6 +3921,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1
+		ip netns exec ${ns1} sysctl -q net.mptcp.add_addr_timeout=120
 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
 		{ test_linkfail=4 speed=20 \

---
base-commit: d196b09457190bc11ffca2867d5c12beb5a4759e
change-id: 20250718-mptcp-add_addr_timeout_1-2b57726cf3cf

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

