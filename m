Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795254187;
	b=bGK3+OtrdWDTMJ8OLl3KZtNCqsP8iZGkyydFoFWEBH53Y8MElz7HoaKCj1Z2jDIOLez2
	 NIUoGGbX1uxiXUwAtPtVrw2Lgom8SxzfRzWvMv7UJg+ieb2nMYq+eCXpTcN3h5sht6SXo
	 gUy5JAeRvrDZxc8xC5WpbtWFitSSt3eQwA1j9YHlRABdKqObPg85z1sPK+jitLMqYryX7
	 6lgPMh0/C1TMOg6yQmdob4rqY7BhkGzrkiyUbmKS1iwqjhQAVnwtGZtncoTG/5+zQBFZv
	 psrn+xyCPUiSu7I9+OSEgI8Lr6BSt3HrUe/Rtv+PM563Oo6I/cPsBdAnSwHpJ8ge0rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795254187;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0A0xyfSATAln0Q+Deiz0cCQvaovCf99nMyyZVnsqkw8=;
	b=NJMAY8LN75lGBtTaPMMqx1IW9TaXMiDuLNo78xPV7QtJ7d9D/fDvmUK81t+xEfuaZTYd
	 wzDqTHTQWVgZrwrXk6YS7g0lfxN4UqkN1kFe/uYX4Pf4JNIW0tIX7PVs8f5BWoHhnX5o5
	 xdaIQ6Naf84O8jwTy3/pTbL2Fhqo1MPfhKie1wALNCna5GwpHjApRMb1uNglg59YLu4Yw
	 j81WL0KBKv3EKFu+VYTNr8CADiSn0kBNIVVOpmIVo7rVSJ9KTN7YrgOy6dB4euOARMRQp
	 jf0t5ouqwdEClRb1xjyDeOvYN06d1Zh0ZblhzaLwl7lSLMEnj3ROwQKL8MDG5QufeAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hE5f4v5W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8EE606A320
	for <mptcp@lists.linux.dev>; Sat, 21 Nov 2026 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hE5f4v5W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B891F000C0;
	Sat, 21 Nov 2026 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795254187;
	bh=0A0xyfSATAln0Q+Deiz0cCQvaovCf99nMyyZVnsqkw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hE5f4v5WN2DsTyCM5sxmjiC2t5xI/Q9qa6S2ECiSOgOrVsfYIDgZlOHcW60gQi9I+
	 G/z03zfSfbw8dlNV1hg7IJ+SMrjVMhMXkzrfkvVUQsgHzYT4qAaqsFDC2ckaD37bJ1
	 YSaWXzg9mW8AUkLKtjHvXkut0eoCAVwulAPMN1B5CniQ3FHbDFHzSG8Mgz3YLOFP+w
	 HW5+QRcu7cBly8l/7RVbxwF/fxnL8rakOb773LjQtuQhz6a90Pkm1yJLEgFMxvY3C3
	 4OHj14ec99PAhZCKb9bHm0mRJfI+vH8M1GZtWUa0LckEs1Suke2+Qt9D9GYctK7bur
	 sTWBOPdrmGCjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 21 Nov 2026 10:41:53 +0100
Subject: [PATCH mptcp-net v2 55/62] selftests: mptcp: join: infinite map:
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
Message-Id: <20261121-mptcp-cmason-fixes-v2-55-00327fd1de1f@kernel.org>
References: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
In-Reply-To: <20261121-mptcp-cmason-fixes-v2-0-00327fd1de1f@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3144; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=24pzTk9FT5cN/9FozCylpHkdx1ESVFmi0SmeT9jC2YU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLIZ04uu7PPZtpT7p82ZL4mqnTqB94t3P3DTny3UsFV3Y
 0b/PwXOjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIkICTIyTOuuV1YSsur42OD+
 7NTTrCfNjouV2lz+1JyrL3y+9+ftFEaG38J/ffy3e1/sKyvbH13T4p7GuWc329MbTvk/EjirJ31
 hAQA=
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

