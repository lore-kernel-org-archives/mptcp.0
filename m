Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442BA27A462
	for <mptcp@lists.linux.dev>; Thu, 19 Feb 2026 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771495841; cv=none; b=TcuIjwUV6bvTF+kKs8+agmHM30jC/SU1ghMKYI66x1MxqiAdpUJh7HavCQjuFHI5dBiL7tTPojtapwAuIx7ElyVd4o3GxBAySX12t5RXFDs3nxwpFyCtFajPgngYhDtD8H0lMnmg1oAWnYLabdCjgYnVprHw6jAmF8vnkSw9uaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771495841; c=relaxed/simple;
	bh=2scDoVYd3rL6y6QBu85SJZD47MW0HP0I49Px2yJo2xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AmBkmO2LqPvsEBJre3DygOc0AidNLemX3VxrHcT3Eku/+VglySwd/YAAVXYVVesBsf8ljrctDqvQAa1Ui/dVuV7P936u0XEWVc46cxqj7QtSkDuoQwazhL1a9DYzUAJM3giFdfnjgiaqs3RnWoShSc/7Dm4r1gkXHf/wK7HCiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoKhyd5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoKhyd5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D2AC4CEF7;
	Thu, 19 Feb 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771495840;
	bh=2scDoVYd3rL6y6QBu85SJZD47MW0HP0I49Px2yJo2xI=;
	h=From:To:Cc:Subject:Date:From;
	b=FoKhyd5xP8oig5QkdgJ+X4C+1lWztN3+sGtkymOovugrUkYJulQtGD/MuOpnF/VSB
	 jEKi1hUmkShAIdMt40aszEiEntt+wo4HzrzJOsheZncJ1mitojJQMC9O+V8AFrDAVc
	 z5Dc5C4e779pa+ictgLJB0Rt94lZ/psovXqESY40XFSst2d5S8lIYioKbHK78w8q2W
	 uzO72muxEhCn3CSowzAHj7AosOrOX93ygoSR1bPIyqvbYAVImphZJGuDF4JwGbekL2
	 FqdihG7zZtkPD9bwVnFzsOingpfz95lHL8yKMLrRqgiFOn/Kw6+Vta0Jt3S1Jewjnh
	 oJmmmJ75H1+9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-net] selftests: mptcp: join: check removing signal+subflow endp
Date: Thu, 19 Feb 2026 11:10:34 +0100
Message-ID: <20260219101033.716403-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2045; i=matttbe@kernel.org; h=from:subject; bh=2scDoVYd3rL6y6QBu85SJZD47MW0HP0I49Px2yJo2xI=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKnPZz1WTCsW8NTf4IV8yzl+KUT7zLcCT4178Lzy/uOf c1Mr1+c2lHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRrM8M/+PnZXsyd5/d0MnQ HnxXZfu7xX9jY6eneF0Xv1fw9Zsisx7DH/46yYj3X5pFHwaftPebGJGkaL2E5f6CFzsF5HeZHtq uywsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This validates the previous commit: endpoints with both the signal and
subflow flags should always be marked as used even if it was not
possible to create new subflows due to the MPTCP PM limits.

For this test, an extra endpoint is created with both the signal and the
subflow flags, and limits are set not to create extra subflows. In this
case, an ADD_ADDR is sent, but no subflows are created. Still, the local
endpoint is marked as used, and no warning is fired when removing the
endpoint, after having sent a RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Linked to "mptcp: pm: in-kernel: always mark signal+subflow endp as
used" sent earlier.

Based-on: <20260218-mptcp-issue-613-v1-1-f8e9adb12010@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index dc1f200aaa81..afb6fd3daced 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2608,6 +2608,19 @@ remove_tests()
 		chk_rst_nr 0 0
 	fi
 
+	# signal+subflow with limits, remove
+	if reset "remove signal+subflow with limits"; then
+		pm_nl_set_limits $ns1 0 0
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,subflow
+		pm_nl_set_limits $ns2 0 0
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 0 0 0
+		chk_add_nr 1 1
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0
+	fi
+
 	# addresses remove
 	if reset "remove addresses"; then
 		pm_nl_set_limits $ns1 3 3
-- 
2.51.0

