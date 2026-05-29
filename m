Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D7369992
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780024932; cv=none; b=MKkGXqB9xbqRshnh5RHjrvhRvNWtytSfSr2OtSBtBdfybmpi29XVmgmEVvz9G14gH1EJEcFPzK0njzhpp9J8tPEGETShNzqEiEbm5+tK54MKiW3zAB0O/pbpZE25iqvNCZPc6vgtPbfc+hAQgRcOjQgDRZE7PDKHmJLM7piRkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780024932; c=relaxed/simple;
	bh=3nwANGrh2kWYU2kKS8sds1qac5JfcT5k+G8m3TnYOs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SX5qBI0rWy3QQN/hGQg2iGPczn7j3DPoe9QhhFmD1M/kyWV1RheBVYazEEwxCDHPm+fJbQgfxhFdp4irL8iuy1S+vL72j2r+VbDM4EYdocNYVmKUP6h95lCY+zNK4LPfTAK1OnbXW6UTwVW5xNoxD1wEz/pp+57mmiI6JGzofCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwDQ377k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwDQ377k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93B81F00A3E;
	Fri, 29 May 2026 03:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780024930;
	bh=49SfBerD6PAjf6FO2wL2dyRDxp+iVNh8r+rbjyWOW5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hwDQ377koZZ4f36ajiFRMJHeuBe8anl/Ew/Jg/jHajQeBf/uE1cn20cKtgfkiVoag
	 GKYoGveSmsaicsC+co1uv0K2NQ9BFPESqF8StCkIdHQJn2Mg9s85Uz0cQcVPX9gZco
	 Z1kJUVhqorVAE1io0V62b6mnusOsIAYRfyPA4vf2xVzQZxkF86Hdb8L+mAOUt6smcn
	 /DCIow6vWeIrrnB8rhqPLg+EC1kRDO4vR9P8V/aKhTBScjy1wgwfWm9akAef2J8LVb
	 ez2R6Tmbtdslsf0PrcMzgxfd4DFGYQhQ8pd76dKAKF/reHZmkVJ/VAucJkNXqlxGRn
	 jzRKNwanyYqlw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 May 2026 13:21:46 +1000
Subject: [PATCH mptcp-next v4 08/15] selftests: mptcp: validate ADD_ADDRv6
 + TS + port
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-mptcp-add-addr6-port-ts-v4-8-cea393fa33a2@kernel.org>
References: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
In-Reply-To: <20260529-mptcp-add-addr6-port-ts-v4-0-cea393fa33a2@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3nwANGrh2kWYU2kKS8sds1qac5JfcT5k+G8m3TnYOs4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqGQZWx2UA5/i3EYqxnyOt3UhHehBPZgKFAL225
 X4AWviFggKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCahkGVgAKCRD2t4JPQmmg
 cxwOEADF/bzoealLIFpER6Y6tMbvw4G2/6NAScOhFnb6EQtb1+LzvgO7fkw5i0ku2tSX+uOoYr4
 a0qHdja9pQjDeVCVSdsB+zBRMW/49rIJ16LWh6+FTR/XxSpgP48XSpQrhb2zs7TMDsCTJ+/5F4f
 3WvdKyHYwmSQfbHGTCGFSgpbXMEJV71zH3Kk/uBtsPqQctBCynmWNvgP4XoUzFMnxrHq29lwLz8
 OJG9Nx3K7USwJNrPh/uTCDP2Wl+tegAjZY/nuPo4ncCfktd1/G7NPXImYYC+O8PO5b39QegjknR
 yz50PvbUCd/X4uFH/VB5RExcPZP54r7Ygf4lQbuo/lw3X0lXzv9XScrw9TmVWPcmODKLydzGR+h
 Xk30/idpFgtqNiCMSMVaJo9Ncgb7rXO8yx2Drar6U1zjyl9adQXpgKMHacCHqveOplvoL1Xz5Tw
 I5ArHVYRmfzXQnb1B6s8Zz7RNvsju0GntEu3Xs0KgEKTM6/GsrkRAN85V0oz46WnsW6pNFchNno
 ERpl2pu6/me80DNVSIUTc3KHxazAoTUrKdW+u+fQPwnfJLKqUo6/X6g6Y0zxlFYQxpzPUeq/oRz
 1Vr/Led4wqRmyF4MejjlOLvM5Xl5JdeDHAf4BTOQKYNrCUixT95/WGTMGur8Ux1wWp3X9NRVJwT
 NHztqBR86tbuE6w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This validates the feature added by parent commit, where it is now
possible to send an ADD_ADDR with a v6 IP address and a port number,
while the connection is using TCP Timestamps.

This test is simply a copy of the previous one: "signal address with
port", but using IPv6 addresses. This test is only executed if the
add_addr_v6_port_drop_ts sysctl knob is available. If not, it means the
kernel doesn't support this feature.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: switch back to IPv6 for the main connection to use a v6 socket.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d894efe1fb02..30dbdcdf5e4a 100755
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
+		run_tests $ns1 $ns2 dead:beef:1::1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1 1
+	fi
+
 	# subflow and signal with port
 	if reset "subflow and signal with port"; then
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100

-- 
2.53.0

