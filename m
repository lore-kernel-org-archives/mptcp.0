Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795809729;
	b=2n74igHfH/zeeQzWHy7S2bGUcnAj/ROYTeR2XH7wTXdkrKHylWApaj+N0OeVSnZqVrJj
	 P98smaMGAyirZqbzoQXYj34sXMnjobT24eU7cdz8HDAUS8A1ywpKq6PJqVUlDQkHw4iq8
	 c/hi6nhEtzWQd6SGumspy7fUCK6xSf62jNLf7Y1sN0Hasb4AFCojqpm1lGj04RNftbzCD
	 eirKTPer0qayuYb12Sw+PC2BbZsSxdlid+U3a00dY3tw8GToir0hwhKk2h4RTZSouxdow
	 8wWIsAxnPb3LrCr9Yvl66pPmBFY0nMHoMHHAyv/yiqM8h6OpqG8Dzr+BAyimn2rBrOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795809729;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0A0xyfSATAln0Q+Deiz0cCQvaovCf99nMyyZVnsqkw8=;
	b=byLuVUoH15EDpOMtmtzOuOwJ2LvzG7pe1JPGsQH65FiSH2ZfBCeoTmy6O+eyubCCLdeN
	 4HkN86zeFeAxxkx7M8Sd6J0zMFGywm8ZaPRSHujPNkOQTp6O6K4CFsx2mnNdxXFhy++n+
	 Q7CQGvrlbaqkcvUs3YNMxjV1gDF79A63/6q7SrraGVcL2aKqgVUVYTv6AJS0oouZnTBVq
	 R+XFil4qOG/asd42/5uU4Eh5yThPXAk+c74YTe9gxVzq1t5CyOXVWASqiblNIfAOgADkB
	 eKBsLdbdeAOGzQbdOKgJg6RpQ/Z2qhLlClCzo5DCSW0/hhI7ZTXFYe8LpXBOTTFe3yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT3euCGX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578A606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MT3euCGX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7171F00893;
	Fri, 27 Nov 2026 20:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795809728;
	bh=0A0xyfSATAln0Q+Deiz0cCQvaovCf99nMyyZVnsqkw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MT3euCGX44tSKOPSGKMceedum8GzaLf2X2EJc5TLta6HT3w4ikGBMSR27MqjqQKCL
	 p0wcJMui2IP+AEko+H7/bpgJwAfxmjceA2VZtDAmKUcLmfsBFrU/wpUK2gz5JVfJVr
	 pTY1tAFALZST0OBXPmAOqQ+Nh2BtRJ5rDKbJ1/7Pyowxqhm0sRoqOxoOvibd5JE4ee
	 jVcMnb21an96iYMqyF7WChlYxdVfqiH+p0l0+IT3+z8lhGfQg7kVWz7UyP7ppwDrCI
	 +4DtdYj1Jv5NeH9flhHqbBlW0S4oOFBTuV0NlfnKR1ZD4cybB4U9mNQYeQl0aojRww
	 w1MNosYnQ9wNQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 27 Nov 2026 21:01:30 +0100
Subject: [PATCH mptcp-net v4 06/20] selftests: mptcp: join: infinite map:
 no spurious rtx
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
Message-Id: <20261127-mptcp-cmason-fixes-v4-6-3f393ea8c48d@kernel.org>
References: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
In-Reply-To: <20261127-mptcp-cmason-fixes-v4-0-3f393ea8c48d@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=24pzTk9FT5cN/9FozCylpHkdx1ESVFmi0SmeT9jC2YU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLI5H66+eTZHqzC7VTk0TiR5Qn/UcgN1p8Av05d2p8yo1
 XiX/25ORykLgxgXg6yYIot0W2T+zOdVvCVefhYwc1iZQIYwcHEKwETkuRj+Wa58f0iiKVapzuh7
 aPqHXQaelftanhgune3fIXAsKJn7B8Nv9nDB9DVf2ndc6Vu+YtHS/bdUZu/+7hpSdUysyM7zr7w
 /PwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "Infinite map" subtest sometimes failed with a reset instead of a
fallback to TCP, and the transfer was then stuck:

  [FAIL] client exit code 2, server 2
  (...)
    MPTcpExtMPTCPRetrans            1
  (...)
    MPTcpExtDuplicateData           1
  (...)
        reset tx server      [FAIL] got 1 MP_RST[s] TX expected 0
        infi tx client       [FAIL] got 0 infinite map[s] TX expected 1

Once some data has been retransmitted at the MPTCP level, a fallback
with an infinite mapping is no longer allowed: a checksum failure then
leads to a reset. Here, the retransmission is spurious: in the 'fast'
mode used by this subtest, each side writes 100 bytes, then waits
200ms. The 100 bytes from the server can be received while the client
socket is owned, e.g. when it is writing its own data: the TCP ACK is
then sent with the previous DATA_ACK, and the next one is only sent with
the next data, 200ms later. Meanwhile, the MPTCP retransmission timer
of the server, armed with the minimum RTO of its MPTCP socket, 200ms by
default, can expire.

This has been confirmed by setting tcp_rto_min_us to 20ms in both
netns, with a capture showing the stale DATA_ACK, then the
retransmission of the same data 20ms later, with a new subflow sequence
number:

  S>C [P.], seq 1:101, ack 1, [mptcp 24 dss ack 3936022471 seq 1159191301011008422 subseq 1 len 100 (...)], length 100
  C>S [.], ack 101, [mptcp 12 dss ack 1159191301011008422], length 0
  (...)
  S>C [P.], seq 101:201, ack 101, [mptcp 28 dss ack (...) seq 1159191301011008422 subseq 101 len 100 (...)], length 100

These MPTCP retransmissions are expected here. To avoid them, increase
the minimum RTO to 1 second in this subtest: the corrupted packet is
the next one sent by the client, after its 200ms pause. The MPTCP socket
only uses this sysctl since commit ea4eb2adb0d3 ("mptcp: honour
configured min/max RTO in retransmit paths"), in v7.3: before, this
change only increases the minimum RTO of the subflows. Errors are
ignored on kernels without this sysctl.

Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: new, for a flaky selftest
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4c045532f137..3d48b02ee8c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3828,6 +3828,12 @@ fail_tests()
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
 		MPTCP_LIB_SUBTEST_FLAKY=1
+		# MPTCP retransmissions prevent the fallback: avoid spurious
+		# ones during the 200ms pause of the 'fast' mode
+		ip netns exec $ns1 sysctl -q net.ipv4.tcp_rto_min_us=1000000 \
+			2>/dev/null || true
+		ip netns exec $ns2 sysctl -q net.ipv4.tcp_rto_min_us=1000000 \
+			2>/dev/null || true
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
 		join_csum_ns1=+1 join_csum_ns2=+0 \

-- 
2.55.0

