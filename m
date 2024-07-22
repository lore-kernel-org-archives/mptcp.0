Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689E171090
	for <mptcp@lists.linux.dev>; Mon, 22 Jul 2024 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676963; cv=none; b=c9iAsivdakpbVrcoVv/Z1YZXswNaWPzEXQh/XQkuoGCpylc5txWHDQtHx3Ug5whujqGWsZqghn6wU0pfHWYEojkVVQxnVtsNsDsjLQahqvgSgEFUfo2pPbmd2wBXiVZrQXEGgS8XZyZyZI2WjxnElRX5t/ywn7PLX7T+JRURw5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676963; c=relaxed/simple;
	bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDZOC2gqt/RUPDZlQGmbKXqbDNHpkBkzTfObeujPgt/z9fjTQE68OqOAAioQfS8PBbDU9IdZGeHGIuV7nwZ03iKI4XGsFnSDK99eOcwCTzWlrnR8ul1DVzYKCAHRDO5QgbFxnDa9k2mLsuOcuCUmoPk33gkKBFrFwoZ6t60N2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvi9iRsu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvi9iRsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB3CC116B1;
	Mon, 22 Jul 2024 19:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721676962;
	bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvi9iRsugGg3NExhpAd7Y9D74JmevqS5rdV8wAylUnOpxX+vyiXJEA1AUx1XbsR7M
	 lZQpPWatSCaxVSMuX1Z6YQb4UZcokRlHWa2EAxN36nLn6Q8TyrJsPtAA7c881ZxqxM
	 ceHL1q5a1H0Nq367zEmCAoKvKTMSN5Cu7CDfk7RKfbxi1oAhzo8C8AHyWMRhS2HvNR
	 igFJdhmn0g8XL0Efwe50xim/pOKqEqOqr1WW3/N3mJVDNnsmyvvo4cKMpF+mwl/ESU
	 qVjJcy79PrnEXTx7l9LDbD+DymNreSk5sTjErlQQlElcwktGbEMcG3djp1zqS8S511
	 n/4La4GNtvzgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 22 Jul 2024 21:35:47 +0200
Subject: [PATCH mptcp-net v4 09/23] selftests: mptcp: join: check re-using
 ID of unused ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-mptcp-pm-avail-v4-9-15bfd73de384@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
In-Reply-To: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2591; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IZLmMEPKaTI0ecetyxX+ZJUmzHaA8vdoxLN3U+l3uKA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmnrSW/qVU9UZDJVsgMKbnetGmFxupq/61f/SYi
 8tAkP38rMCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZp60lgAKCRD2t4JPQmmg
 cwtVEADJ574dkS/kW1vqBuziRxs5gYCi17bE+l50JJTSnwoh2D2tqeYPmxCgMX1tZ9Mk2J/uUV+
 s/23yjINqVSLogooHA2HvSJ06/1wFWTfzNQSgHCVKjmGVeo/nhoiOGKMFqrBbdKCOniz0xVP+6T
 NcUy594bQ0PP933mDfctkLrjv+C1KFTTBMSNMed/WICg/HhpPV8JKx4Yr5/11FA8GWYJwVEA76l
 ftvY3/i9c2JOV+0q7yGtjLaCvVYTKkxXym6lKr/hxiahY08H2NomRtIcz6hkv5/ZdHoNerErAit
 f2Q8gQ90BD0SR/BdZ5rNQKMRtFCwjQ+v2eJb3Fugr7lPoT+UbuBYvAwkNTY3h+RoZylizx6mMah
 VOIbBdsovxXQGt776RBKAWRNvkfhLuuHJWTIfq6j7P+XTp/7XgtcttfuCOX4XEPNquyR7qjJ2Jr
 ghUYFbHLsFrUw5IpjjfXZ/qAdIwB+L79Hmh6+kdAAVilKXoRRfsQ2q9yvNz6JSCaKYbCwt8PYET
 zz0KyG4G96IVM+AqCB0suJjuahsOYq720CGasucAbFjuaqWpXgiHT2CTTIzabO+0778JQAu4BSq
 FhTAn2n8ytLxaAEDRUDEsirWh+BORzoXsqKBi+kseoIR4vsG04Breb4RKGiUgFoieORvWxupRKY
 Zxzepl7XJ6V/m0A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete re-add signal" to validate the previous
commit. An extra address is announced by the server, but this address
cannot be used by the client. The result is that no subflow will be
established to this address.

Later, the server will delete this extra endpoint, and set a new one,
with a valid address, but re-using the same ID. Before the previous
commit, the server would not have been able to announce this new
address.

While at it, extra checks have been added to validate the expected
numbers of MPJ, ADD_ADDR and RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d25ac561e050..b4dc5f2772dc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3557,9 +3557,11 @@ endpoint_tests()
 	# remove and re-add
 	if reset "delete re-add signal" &&
 	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
-		pm_nl_set_limits $ns1 1 1
-		pm_nl_set_limits $ns2 1 1
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
 		test_linkfail=4 speed=20 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
@@ -3571,15 +3573,21 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 
 		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		pm_nl_del_endpoint $ns1 2 224.0.0.1
 		sleep 0.5
 		chk_subflow_nr "after delete" 1
 		chk_mptcp_info subflows 0 subflows 0
 
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
 		wait_mpj $ns2
-		chk_subflow_nr "after re-add" 2
-		chk_mptcp_info subflows 1 subflows 1
+		chk_subflow_nr "after re-add" 3
+		chk_mptcp_info subflows 2 subflows 2
 		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 3 3 3
+		chk_add_nr 4 4
+		chk_rm_nr 2 1 invert
 	fi
 
 }

-- 
2.45.2

