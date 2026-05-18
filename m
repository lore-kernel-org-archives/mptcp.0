Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AD3F0760
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109161; cv=none; b=PYC4yUAycH1Yz2q/RNNFySvEe3UyYa4TrbxtEJY8Sni4WpO639lZqgyP+t8/KXkhpXIwz/ZuQeBYJWpvojimRK8lHIhQVoEKhXslXrWkidQsMb8qU0cGq7k1BbHf6Pz3OhutF2qHCkQuy4jsnJtSueXEaOwQrTxmKCWJwK2Fb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109161; c=relaxed/simple;
	bh=cd2vGpSdvYgyrNCioFJKlOdef+91KQPdQOOlhLnsGZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hi5ZnT5oHaDllgDBF1JG/3sluG1iFe83aIdfm+EUpkHlEFzd1N1Ad+W6S7BE/sXYZsKQuT/ia3gTl+mf4ZJad9KwrzaYnPZKS7ml1/h4Fg7h14m4gmbrPkI0NIP1MttnVU4D+ZtDR2LaUoUUNd0p33vYo3sEq6F7b71dvlm8my0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2fukxO5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2fukxO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28772C2BCB7;
	Mon, 18 May 2026 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109160;
	bh=cd2vGpSdvYgyrNCioFJKlOdef+91KQPdQOOlhLnsGZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M2fukxO51SHmhr6jTjxcZGfQks7f5VvDESZd9TJNFSyRojmNgttao/dZ6ngdnv0ur
	 OHzSnSx9o6uU1lcBQ7pwE1bnpdqQidgexbw13pCo+Wz0qg8wyVXV94wkpoPao6sjH8
	 DuzN71LI+mh4pCfBBFPKYXtsIUbihmXZR8Dzs9foxGlpCjMYQPE9SNexfZPHv3g1oO
	 IxFP40W3SGUXueJ6o8qxeg5F7ikwhUutDBUwm1kMOmix3E2MtWVTGUyIFjkbNXYth7
	 7m46UZVl4pDADp7bniUf0CoCovULXs3cv2ltEMgS0kto3EU92BWcme0Ho+7XSzwnmN
	 3PF3XdrOsmTDA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 18 May 2026 22:59:08 +1000
Subject: [PATCH mptcp-next 04/12] selftests: mptcp: validate ADD_ADDRv6 +
 TS + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-mptcp-add-addr6-port-ts-v1-4-f1ca26977fcd@kernel.org>
References: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
In-Reply-To: <20260518-mptcp-add-addr6-port-ts-v1-0-f1ca26977fcd@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1489; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cd2vGpSdvYgyrNCioFJKlOdef+91KQPdQOOlhLnsGZc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqCw0hzfdWXouQy+LhFfH4F2sD0cFPVjhMwMThH
 XUwetO/i/2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagsNIQAKCRD2t4JPQmmg
 c+xyEACGf+trk2gFLLWKqfa3D/ifTYD2jbZQxz41T5wF+5j4rHJkeZ0pY4uD7rU5LPnVONdTgSI
 GPJqUMYXRHX0d0PNtqgQXMocN+GxwX9jT6aUWEzrG8uskge7uIYIWjNN9SgcOXJ8aISO4DPyj+2
 z4QxW9PBgzBGYBWWVzUqGBre9h+mchcKoQaa/RIhlVSZR91H8v+ho+gxzd/w9sa/0/8BtrvqPy6
 zpCdUf/SWA8W+NKkJ3JcA+r+Ypk0//ZbBDhKOd5MnyiWSzV8tTEnnkwCBQ+BNfOS644pUPYpyS5
 ivkgm7zMS+t5RohpLYBAkIs7MRkb/Ink02I9ikA167aq7ArmETVItqzsn+oVL0T/pY/jab0uT7+
 hjltmhnHiMm1eoAgMcO8cq9pBx5rgPou8t/ixHi+sImsJaaD0l6ZTMfXSNy3Jf4EvGyifZme0xt
 XMzxHyTt5O8GbHWJygxG7NupB+WtIJtS5KNpwtlTtGWQUV7ZDSfeE8vKQC1IIPdNwVOTyYDd3ZD
 VhN/Poy2tNSHSMqQjPcvDiKW/0ZNuYu9XHK3d1UACQa9c0lqEB+BCRb5QLnFNQFO35NwPhRJTrQ
 23psnTxJfPUzgy+MTWkpTPbQDqxlm7RDY3HaTYl5+lYxbnsoEs8pcgB5GScBM0xwBB0sSyJr+0W
 QN8z/r3ICQm0qtQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the feature added by parent commit, where it is now
possible to send an ADD_ADDR with a v6 IP address and a port number,
while the connection is using TCP Timestamps.

This test is simply a copy of the previous one: "signal address with
port", but using an IPv6 endpoints. This test is only executed if the
add_addr_v6_port_drop_ts sysctl knob is available. If not, it means the
kernel doesn't support this feature.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 634d82595f72..fa5be164b705 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3214,6 +3214,17 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 	fi
 
+	# signal address v6 with port
+	if reset "signal address v6 with port" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/add_addr_v6_port_drop_ts'; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal port 10100
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 1
+	fi
+
 	# subflow and signal with port
 	if reset "subflow and signal with port"; then
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100

-- 
2.53.0

