Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E59179BD
	for <mptcp@lists.linux.dev>; Tue, 21 May 2024 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276459; cv=none; b=agNMXNR2yWnR6WWwme2NLH9B9EJlq80TfRMhowPVnhXpVYGbO+91GCgDL5nNgPuXJkGHAfanG21INZPlqrQIBl0xjhWs5u4KyFcCyuTd3v1gHZykhgd61+ZMoj9JV5BnTx6geJQlI89omiVKJP/CnFoyuZN6uBqk1ogNuJj79XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276459; c=relaxed/simple;
	bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSm9I4Hu4ODdniOjpk/IeSaVtrDfj1aB8SyvHmSvhxoBhP8Vu0sii7Sam0dRLCgajH2B+hbM7A7hKG0660qcIoIonhXO25IgD8N+WzTWAFN1H4axBzGnNUaWUDiwVQdTtO8n7cpIt1CmQRBZMKEGs81RgtQ3HA13/MHqMDQExbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/ZL6xEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/ZL6xEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2078FC2BD11;
	Tue, 21 May 2024 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716276459;
	bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A/ZL6xEf/8oIrmJP8c9M51PSJFUnwpOF4fcKne5p5wBqquaigzwkL3tmka3SFGxHV
	 5VvUdOyzyLsXGk2geGhaPYOcfCA1MhY1B5ME7+vIc/M/FfJ2m/jKS+J4tHlKEkBQg+
	 Dp4aPA5LpNeBu2q0h8Qseud8vdimXo6W9GRv/5jfUGsV6JAZdwIMKI1nmsgkHf3N/Q
	 8+7rz2U3d1dnvarOOCBUiqbCu6IreRKAb1nX8tNelMb/m/SWtH8sNhuu+fT2X/XYFN
	 iHWfn4/Fh4hqHgNJKlCOKtBRt9xYp1YLLOr13ntfTOWZTBer66HV38qdeBTYys7Ovi
	 zY36gr8YJQz4g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 21 May 2024 09:27:33 +0200
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: join: mark 'fail'
 tests as flaky
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-selftests-mptcp-disable-flaky-v2-4-eba143bcbad0@kernel.org>
References: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
In-Reply-To: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8MBb3YGLk1JPv2fvJpk6cJVJlQcDE2+JIiyeeg0Lk68=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmTEzm3sMndFw37tWMbQ5Fyy31QoOPHAZUj6lxG
 fW54Med5UCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZkxM5gAKCRD2t4JPQmmg
 c049EADX8p8dsvtHpUo9c7JN+QKs7onSVTTEzmlFYsH583ukuuh7XSMAiuUf5OOgXrn9q7f0VJP
 /S/K6DdNbLpY9/Xj6WpCMT7df46g5deP0FWZEyWVveKKclSJBKwQVorRL99+Y5p1ZHREY0BSRRf
 0JhzQ/vyw8RB2IsElRPmUFivcuSeYqO3C2mLIn2WBrCCI8srTDGYLKWzO7hs1+5n0yNMRJn8Ety
 VqmdIxiV//6FcnDoiSuC58CZVyy981DLlPTlgATTwFwLA/8Qkk602pa9KQkAfBAx+gpusRqtm98
 hDs9HWfVh56J9tQ/hITJBzsKjSOIzUOLuB735gEQ5feHoMy40X0Wcf9KIeZWdlMih+Df5h0IUto
 kpSNjthuaTjaQ0y4YCOD7fj1duXLzVPFcu0MpfS487MbLQR+NlYBWNvnXg4cOeTBV6XFicU2YwX
 cnb0mUUfDCGTeim0mfIUMvoHK5mCoMAA6lW+v13NqJfnLhaEUKD+t87rsPmTUIbuwCqZR3S3n1F
 HkIV2ca+D1Kq4GMocltVYe/dKgTKQr6LvUZKHQKlmWHEonT6qoTPt6xF/s3Vy14K5OxMZs6axSw
 5CWfcAm7wg6iYNzZB4F9iibMrlt2kjauFID0sK8m/7gYJ+Xxl3OHDCKlFPL36IvVIuDam5FV6k3
 gRIpZT0XvkTD7GQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These tests are rarely unstable. It depends on the CI running the tests,
especially if it is also busy doing other tasks in parallel, and if a
debug kernel config is being used.

It looks like this issue is sometimes present with the NetDev CI. While
this is being investigated, the tests are marked as flaky not to create
noises on such CIs.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/491
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b869b46823d7..2b66c5fa71eb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3101,6 +3101,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
@@ -3109,6 +3110,7 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1

-- 
2.43.0

