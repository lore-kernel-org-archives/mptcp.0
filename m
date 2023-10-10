Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52131DFF2
	for <mptcp@lists.linux.dev>; Tue, 10 Oct 2023 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcEiKRBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F722C433CA;
	Tue, 10 Oct 2023 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696945710;
	bh=ZCaEFX/+HXep647fWVUHf/PAob22/jQqSp/Cd6f/B6Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NcEiKRBYw70w1S6WNjrMKjBRrMJWjBbxogqQlyAUIrpKVp/B3L0QmS9IgWkHZwDJd
	 Rj0URR0nQ1BZXnw/tAqbw60bsikFb/i3qyeqNTC90AaRHyS2fKkHqJD6Mz/aNONWFH
	 F9P+r3/36J/IZ4gZqpv0M0+eG4K8Tn012E9RFQqlFjH0jz3uW83A5cw9Iz9N+wnHnI
	 xkAkXrjjDFscKFDBFOO5xUQESwioKcf0biQs4FbGf4QmBdHPTbS1kEe4BfvSLWkgyV
	 OwQ0rmTNYDVv/Yqt7KaPTi5NIZ+zYXHHHT6He9GxfsnwroImmP2S8//UNNEwBX7eTF
	 WfvveTTRC4q6w==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 10 Oct 2023 15:48:11 +0200
Subject: [PATCH mptcp-net 1/2] selftests: mptcp: join: correctly check for
 no RST
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231010-mptcp-remove-id-0-rst-v1-1-5ce17026f748@kernel.org>
References: <20231010-mptcp-remove-id-0-rst-v1-0-5ce17026f748@kernel.org>
In-Reply-To: <20231010-mptcp-remove-id-0-rst-v1-0-5ce17026f748@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang.tang@suse.com>, 
 Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZCaEFX/+HXep647fWVUHf/PAob22/jQqSp/Cd6f/B6Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlJVYr39uyD4dDBxmewtm6m8b+FYi4YIO05cF0q
 6PVXx4MbjuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZSVWKwAKCRD2t4JPQmmg
 c1PIEADmyhuIY8UAmBAOlJZkgVwk5MDwst9UflNsXdK97sWjQsfJjTuujvjhhQY3Yxg/5YYDltg
 YfMgNRgtRTz4V/RgKR5hk+MtjeDqhHE0MpXe8eafLBr3oUmuw5sAdZW27Mg+mHltk8p89rUekSY
 uTolD8vQH9lEV73ahSJs8us2DZsqkTcUhUl6pytMOQ8D3D7oZB+NWFYB7ZD08V1UMikoe35n4zV
 tuwbvYeScbNSl0NdZ795f6EgEHDJG2aBNyl9+2rDmKjs/hPZLcoeXiwn+dtEgV59AcJYx/F/AZb
 slGwFLiTv14HJeQCaYhItITDufy8Ua/aXJ3M7POKUDpfyi+ldu3F6+XpSJQfx/junRlqBS2DkXo
 UdedybvSVX3QUzKpPFkmcjggPCt61HIFOp3KyekREL/J3tftXoCPdFeTuuqrXCi+9dj3BT95HEa
 kOa7HoV1sn9DanSoIkRNrXPAyA61ysRxwVlvBKPAHTou5XSE7Ag/r78DAUD3t9/WkyDSnVT0M3u
 51w/5BQIE3wSVpJpRX/gdsrINap4qnawQFoi8MYXGoEpSBUxhmMBoAG6XdNz2K4XnoqQkouOAJQ
 GBB+oK9LiCDT8CZx1ynFEZ8XXya/qUW6bNRQIqYTK1VphxDb0IoFv13ATr8JeYbPMOdcvM8gSPf
 5nyZv805qK6LUDg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The commit mentioned below was more tolerant with the number of RST seen
during a test because in some uncontrollable situations, multiple RST
can be generated.

But it was not taking into account the case where no RST are expected:
this validation was then no longer reporting issues for the 0 RST case
because it is not possible to have less than 0 RST in the counter. This
patch fixes the issue by adding a specific condition.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ae38b428e42e..01480663c102 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1432,7 +1432,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] TX expected $rst_tx"
 	else
 		print_ok
@@ -1442,7 +1444,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		print_skip
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		fail_test "got $count MP_RST[s] RX expected $rst_rx"
 	else
 		print_ok

-- 
2.40.1

