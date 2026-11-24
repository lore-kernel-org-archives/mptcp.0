Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557709;
	b=GqdKdYxyZKLkI8aGmNiz+Nf8C78f3vRP/PbtDclga0W2gsleZyzk9aAFfkMLtlvKBRgg
	 nxtIP6mtWY5TpoUxCQEHiHjP1MUi1cXa/edJDqzGouGZneH3srXUVhI3Yo2gzzhxucUpF
	 Nr+75aThI5hdt7SSRfFRTuYaRd0zvtCvixhQllgBk/Gv2meLZzrjrxRUyNejiw/i2rOQ7
	 VkinTwNvuS6hEkyHphizi3mcWOeacdawyq8ljEC1uOcG2+E1LKJxJdls3YLJq+0+9TDbg
	 rbzel/1F9K2XPAMM+5WDs5kwc4RuVA6DjSTu6QGW2Il+DycozrYSsLauKmcM4R2YNcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557709;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0A0xyfSATAln0Q+Deiz0cCQvaovCf99nMyyZVnsqkw8=;
	b=2xqJnG2Xr95CvEA3nBYovm9Q9LX91Wld3PTvNwpk25kvD8jmHqOFsBkSK3uQZNyYs/fq
	 Axawf+V8vO9GSdDG3LvDKRFR2+LdGVOL3MKOaeGVtZZFLaO7bN9/euZSwXN69dBGjKde3
	 fQqtyLLItX/ww7ikcrhaeZ1545afLUw2W40cwI3d+8NX992Ab52IOp1xVH3nSWNSGp60g
	 Iq9c+ezkAC9O/6GltjidAzaald7r1go35dQgcJnU/e6SCDDrX9tO5Nl4KHp6vg2BcEUmu
	 A699HQujqgIdUOwi1Mc0sm/HMqynFanQ9lvV8YHXfBbcQPphgDruCRyDCOLrtGVkMLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFHlZ+DB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652CE606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eFHlZ+DB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D18D1F000C0;
	Tue, 24 Nov 2026 22:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557708;
	bh=0A0xyfSATAln0Q+Deiz0cCQvaovCf99nMyyZVnsqkw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eFHlZ+DB8hIuI24hGXOC9RksFUjc9LRVeeA+S/1Zu2tRZ5zuj/m2OR/BtBv7ezp+I
	 k6/0L5NhFI8EVxcMpu62WGi+uC8/znX5MEpdJobh+Hvab9y6iyW2IEVCAxAqf5FSLQ
	 frNq3S7txS3hXO16hztAu6/P0BrMmn6kNv8tbDytieMypEZ/6oDS8/DyeEyV2m9DXy
	 oy2+EJ1ofSJ+U7FP91wOxe5+3K4qmEqkFb0mkZSj4RjXei5sFjpkGG4a913QvYqED0
	 W0ZYMHTRIDjU33bFq43cLOB3SRyDLl783V2grDhf8aFXAexQ4cPALeBYh8ELsVfXA4
	 70UZqrBcWS5PA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 24 Nov 2026 22:59:58 +0100
Subject: [PATCH mptcp-net v3 41/50] selftests: mptcp: join: infinite map:
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
Message-Id: <20261124-mptcp-cmason-fixes-v3-41-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=24pzTk9FT5cN/9FozCylpHkdx1ESVFmi0SmeT9jC2YU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLZOAUKe35Z9xjMc1/y6arPZ8NWzR3n0t/Ifl2c7rrjx
 6J+uYOpHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABP59ZaR4Unp76x11xnSeDR/
 fu2MZo1Yar8+K9kqufZAPKvgT//n5xj+h+pccT+Z8ig8/dfpGts1mbHmoVwbp+zwCr7IdLesarI
 rDwA=
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

