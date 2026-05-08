Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A1233D50F
	for <mptcp@lists.linux.dev>; Fri,  8 May 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262909; cv=none; b=mQve2QB0t1+XASO3KcKj6fycto4Ea0JBRzMaDzoXtdt88a5/ReXAvpK8hi/iEygx8gosFBn/SuL9sRtQ67qKR7sYSSeH4dEGs4d8sAFKpWIQnlbHGxDal7tvKwxrVbWfQp/DDm++jBnatuW7Ie355MhA3TGolmx9VAQR8Tt5KUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262909; c=relaxed/simple;
	bh=5LsO6nzr6i9ZCq1Bm/Fo+sXSEE8VPfF2TAbe3+66kac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oq2IgeWgiPuUX/rpYlIKazHiW8QCE2R/+uIXl+IAziESrkoYUi3nb3DTeSTMMhHxrkEUjR0jrNQ3WCeOe1r5wgwpQ9r8FmMIJeCRHmqjqs7oEEtcWo61KYmxUUUyCnFyC1Jp3QjPgBLWZmDOQp7yiiu+ArVQERUZ5zFet6gRPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbD12dTB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbD12dTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A3CC2BCC9;
	Fri,  8 May 2026 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778262909;
	bh=5LsO6nzr6i9ZCq1Bm/Fo+sXSEE8VPfF2TAbe3+66kac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jbD12dTBZ5RL4l2d+YSJvcpz6i/QGquBfc3pRo337bK/scUhaatgM8KnAXyqMEYJk
	 lb8KkmVhtjw8PFD96xdyFzWbTUFH/Y/vjwRRc2e4xNFB+gUq3L2lemXSLzBKGCrJpm
	 aRYQ1pZbZWSNGIXgE9eW4WwG63CEi/ajvbj47Feb6kMB1tYUIQ2RJ2yaTYFGCCNsjC
	 +rYPCqeKIeipRQSXv9JYk2Eq8XnHQvC8IY1j3PaOqqL2Ag4NQ6AenZpTbHm0+UOZSm
	 +IUU5IJX6fqWjRGTeiOHOse1RPVy/Q6tk93S8ByQJBFxoFhFgW0i0MNaS+cuzXAVdH
	 j/OOe9mNNOuSQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 May 2026 19:54:55 +0200
Subject: [PATCH mptcp-net 1/3] selftests: mptcp: simult_flows: disable GSO
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mptcp-sft-sflows-bufferbloat-v1-1-e9b0d25d9789@kernel.org>
References: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
In-Reply-To: <20260508-mptcp-sft-sflows-bufferbloat-v1-0-e9b0d25d9789@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=5LsO6nzr6i9ZCq1Bm/Fo+sXSEE8VPfF2TAbe3+66kac=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL/KVddat/hsuGG5SOFebPqHjsdca2c9T/Td0dM51Qu3
 2+7Cv/97ShlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIlRRGhpbfVrvaqoNymc+/
 eCQ0//+TRWKLJ0/XXK2offLEjpJw6aWMDNs4GbbIzWc/U7pI3mrKyQc6/86lPt0mJjhxVtF+of6
 pgmwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Netem is used to apply a rate limit, and its 'limit' option is per
packet.

Disable GSO on both sides to work with packets of a specific size. That
increases the number of packets, but stabilise the throughput. As a
consequence, limits are more adapted, and the bufferbloat is reduced.

Fixes: 8c09412e584d ("selftests: mptcp: more stable simult_flows tests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index d11a8b949aab..345cf200c653 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -76,13 +76,13 @@ setup()
 
 	ip -net "$ns1" addr add 10.0.1.1/24 dev ns1eth1
 	ip -net "$ns1" addr add dead:beef:1::1/64 dev ns1eth1 nodad
-	ip -net "$ns1" link set ns1eth1 up mtu 1500
+	ip -net "$ns1" link set ns1eth1 up mtu 1500 gso_max_segs 0
 	ip -net "$ns1" route add default via 10.0.1.2
 	ip -net "$ns1" route add default via dead:beef:1::2
 
 	ip -net "$ns1" addr add 10.0.2.1/24 dev ns1eth2
 	ip -net "$ns1" addr add dead:beef:2::1/64 dev ns1eth2 nodad
-	ip -net "$ns1" link set ns1eth2 up mtu 1500
+	ip -net "$ns1" link set ns1eth2 up mtu 1500 gso_max_segs 0
 	ip -net "$ns1" route add default via 10.0.2.2 metric 101
 	ip -net "$ns1" route add default via dead:beef:2::2 metric 101
 
@@ -91,21 +91,21 @@ setup()
 
 	ip -net "$ns2" addr add 10.0.1.2/24 dev ns2eth1
 	ip -net "$ns2" addr add dead:beef:1::2/64 dev ns2eth1 nodad
-	ip -net "$ns2" link set ns2eth1 up mtu 1500
+	ip -net "$ns2" link set ns2eth1 up mtu 1500 gso_max_segs 0
 
 	ip -net "$ns2" addr add 10.0.2.2/24 dev ns2eth2
 	ip -net "$ns2" addr add dead:beef:2::2/64 dev ns2eth2 nodad
-	ip -net "$ns2" link set ns2eth2 up mtu 1500
+	ip -net "$ns2" link set ns2eth2 up mtu 1500 gso_max_segs 0
 
 	ip -net "$ns2" addr add 10.0.3.2/24 dev ns2eth3
 	ip -net "$ns2" addr add dead:beef:3::2/64 dev ns2eth3 nodad
-	ip -net "$ns2" link set ns2eth3 up mtu 1500
+	ip -net "$ns2" link set ns2eth3 up mtu 1500 gso_max_segs 0
 	ip netns exec "$ns2" sysctl -q net.ipv4.ip_forward=1
 	ip netns exec "$ns2" sysctl -q net.ipv6.conf.all.forwarding=1
 
 	ip -net "$ns3" addr add 10.0.3.3/24 dev ns3eth1
 	ip -net "$ns3" addr add dead:beef:3::3/64 dev ns3eth1 nodad
-	ip -net "$ns3" link set ns3eth1 up mtu 1500
+	ip -net "$ns3" link set ns3eth1 up mtu 1500 gso_max_segs 0
 	ip -net "$ns3" route add default via 10.0.3.2
 	ip -net "$ns3" route add default via dead:beef:3::2
 

-- 
2.53.0

