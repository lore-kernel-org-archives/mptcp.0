Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB96342C8B
	for <mptcp@lists.linux.dev>; Thu,  9 Apr 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775767942; cv=none; b=hv5w6yd+MqgEZCkE2TuhYvUhZ8LxidV3r8cT67sMD8IPGQ5JVemnJWH71BSz+HGMyu4vZ9PJ1/I93MiWzyI4C01fUX73dAeW+PPbsOllyzbTwS7+zshi+Rhd9nPuBR2uYmAMr/riV9eJWxyiCUYNPKKuvDsJSrvGMG7CIxpA49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775767942; c=relaxed/simple;
	bh=uY7l/8VcbTjpIuAX6tBgPiQtu2FmTTYndMyn6LRBHHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0M8K4cgzWcrmPrmS3nQ4es/lCTT8twx0Qsn+HOAjdxy/xq7cmHZ/4N3Mh/iskGMwLPc8mTy58g7tjtjXWvrpOrunyeKPvwSzhIfi5NqAbQAanmVhvIOu23NUHilOKGrD4iGXlZpDCDp98KLZgQuNsyOyXakPj3D/nZymsYIDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBMo2IdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBMo2IdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0312CC4CEF7;
	Thu,  9 Apr 2026 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775767942;
	bh=uY7l/8VcbTjpIuAX6tBgPiQtu2FmTTYndMyn6LRBHHg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hBMo2IdQdsUC1L4gzB0+LY+fxsi6RuUJKMXKyw17aUaB0oE6p3RC5dFb/w8t4Surx
	 TqLRfiOVOSgkVhDASWrB5zDy+jXAWlw3/FwNWNRTg0fzPuEurGv3uzNA2wWBIrXtkk
	 S9hT3iaecehJYy4N14O3Jpno8NEMZ7dAdhiZShurBoUk03d1w3holozZrLL6vhacqB
	 dejCJ60tavnMsp6h+GSR1xkiMeo0fzaxAYJpqR4JPEicGoADkSCKQefMWKMPTEPKd2
	 A6WYjezVvgb19SyNpd4QvFmNW1D5nvo3PJELEw9NYrQY1lPVE+yMHALgplK29Fxk3Q
	 wJKZhTZysG8dg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 09 Apr 2026 22:51:53 +0200
Subject: [PATCH mptcp-next 13/16] selftests: mptcp: join: validate 8x8
 subflows
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-mptcp-inc-limits-v1-13-0e45fa30d914@kernel.org>
References: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
In-Reply-To: <20260409-mptcp-inc-limits-v1-0-0e45fa30d914@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2161; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uY7l/8VcbTjpIuAX6tBgPiQtu2FmTTYndMyn6LRBHHg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJvCFb+/VGu13Cl5q+yAs9JgTff2VMvix97M8OpTXvh7
 3fzGFWMOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZSm8nIsO/+zCt+O6Y/fi5X
 +17lnO6SIy+5ur3/865LbpZ+kuf0cRMjw8mstF/7MydNf3fF9OAVG5eNCXPb3F3Lyw44ihu6Hzd
 5ywcA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The limits have been recently increased, it is required to validate that
having 64 subflows is allowed.

Here, both the client and the server have 8 network interfaces. The
server has 8 endpoints marked as 'signal' to announce all its v4
addresses. The client also has 8 endpoints, but marked as 'subflow' and
'fullmesh' in order to create 8 subflows to each address announced by
the server. This means 63 additional subflows will be created after the
initial one.

If it is not possible to increase the limits to 64, it means an older
kernel version is being used, and the test is skipped.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 28da9df797ae..8d6a9c031e0e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -513,6 +513,19 @@ reset_with_tcp_filter()
 	fi
 }
 
+# For kernel supporting limits above 8
+# $1: title ; $2,4: addrs limit ns1,2 ; $3,5: subflows limit ns1,2
+reset_with_high_limits()
+{
+	reset "${1}" || return 1
+
+	if ! pm_nl_set_limits "${ns1}" "${2}" "${3}" 2>/dev/null ||
+	   ! pm_nl_set_limits "${ns2}" "${4}" "${5}" 2>/dev/null; then
+		mark_as_skipped "unable to set the limits to ${*:2}"
+		return 1
+	fi
+}
+
 # $1: err msg
 fail_test()
 {
@@ -3670,6 +3683,21 @@ fullmesh_tests()
 		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
+
+	# fullmesh in 8x8 to create 63 additional subflows
+	if ifaces_nr=8 reset_with_high_limits "fullmesh 8x8" 64 64 64 64; then
+		# higher chance to loose ADD_ADDR: allow retransmissions
+		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
+		local i
+		for i in $(seq 1 8); do
+			pm_nl_add_endpoint $ns2 10.0.$i.2 flags subflow,fullmesh
+			pm_nl_add_endpoint $ns1 10.0.$i.1 flags signal
+		done
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 63 63 63
+	fi
+
 }
 
 fastclose_tests()

-- 
2.53.0

