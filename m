Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F113AD6
	for <mptcp@lists.linux.dev>; Sun, 22 Oct 2023 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6CgBlVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B25FC433C8;
	Sun, 22 Oct 2023 21:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698010327;
	bh=NA5/YHumGHKCqU5BuZ45lxbZ7ZzBQC931V1rT/fCK6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X6CgBlVttREMAq0O0GatjzFCzP+oCXY8jIezp7uRZzmNMIDvASQxIAvK0AxXKUgxT
	 tJjU3iy5RjVy2uNYiMqlP/WfzQYnMhLQsxJmfI2QfXkr/eGStjxKfERsmb4Gn6HtFK
	 CwL44hPBRyh/etYk6kZL/7ueAZtkwmcc9lHXJto6Eap32G7LhpPWpwYFX+03cpdZUV
	 +FRqcbugfFOi38G61rtxAAfyAfaiPuRbmnUS93VTKr8WzGw0ZUp3t1S3HMWooVDFPV
	 LUDUGvyhE+E/0Jt3nmOV/eF3FbyaDCS3ZvwJe+xqiZ6aQDPBFj5ZocdszI7B8UGnHI
	 JfUe+gsFW4HJA==
From: Matthieu Baerts <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: correctly check for no RST
Date: Sun, 22 Oct 2023 23:31:40 +0200
Message-Id: <20231022213140.3393546-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102035-citation-buddhist-8a5d@gregkh>
References: <2023102035-citation-buddhist-8a5d@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2522; i=matttbe@kernel.org; h=from:subject; bh=NA5/YHumGHKCqU5BuZ45lxbZ7ZzBQC931V1rT/fCK6g=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlNZS8nvSursU7wTYzL7bnnXmhm7UObs00wJIEV CPfqWJwjHKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZTWUvAAKCRD2t4JPQmmg c9HbD/4u5kECWntOM9S0kUwbrHfmirxzxsJPCOqFPAY1HwLTrWHdkbAh+DxbrlXR/cUMk7LFDED S3ngegCHRXFewDILs5yAx6SGAUyJZb+8cs+hTN+EbDqXSfGJlX14dp7fCEntc7/kZc6em2uJwI9 mDYYqap9mdpxXvU2AhcDN7zkHZmbcdV29fFVBs/0LrT/AvSB1t3pOKQUdxLSzIT159eKmCGU7LA tsxrvaaiaNDBaYlyVOXx9HsrKF2mwZzYbKCCsh/iTkLsldTKfof3MDMomlMhfWdqJ47e++t0We9 eOPY1fKTeNkRjKQBhfY8GzftRZLIPF+k722G7lPIWdC9niux84wlbTbSNZr1iBBF/H0S23yVych S9R/gLWzRkAzCTy1lhgMMJ1DtKLzigqFufM/thwvXhGGm85sDSNPbpBDImKY2mX0Tjkz1ygredJ QNC4jWmjDV/ZAHdABL7YQ7oUmDfT8/6iKv6yi7iY23iuf2P2XiDr3O4n0e8h/ifzwQIYZdyTZae Xxm220ownz9tJeiS9ZerQE8z+33DVDQpq+wyHrT6IbHTQRb6lpeWsmBqRvqKX+ZHMlSQcwWjMrU y38RPZk7QPsxsXSbYaTvuHNAzdi30/ChFPkhVevRx4/EMSjv5ntQvE/kx+KmumoMHwf0d53+7m4 7GQYjeFU/Vi+9NQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit b134a5805455d1886662a6516c965cdb9df9fbcc upstream.

The commit mentioned below was more tolerant with the number of RST seen
during a test because in some uncontrollable situations, multiple RST
can be generated.

But it was not taking into account the case where no RST are expected:
this validation was then no longer reporting issues for the 0 RST case
because it is not possible to have less than 0 RST in the counter. This
patch fixes the issue by adding a specific condition.

Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
Link: https://lore.kernel.org/r/20231018-send-net-20231018-v1-1-17ecb002e41d@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
Backport notes:
  - Two conflicts due to 03668c65d153 ("selftests: mptcp: join: rework
    detailed report") introduced in v6.6. In previous versions, the
    messages are directly printed with echo. Here we only need to modify
    the conditions for the 'elif'.
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7b20878a1af5..8dcfcdba58c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1413,7 +1413,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 		dump_stats=1
@@ -1425,7 +1427,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 		dump_stats=1
-- 
2.40.1

