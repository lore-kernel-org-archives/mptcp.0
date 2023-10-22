Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875E8831
	for <mptcp@lists.linux.dev>; Sun, 22 Oct 2023 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHPvdWMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C029C433C7;
	Sun, 22 Oct 2023 17:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697994369;
	bh=Ke0HpsxxQ/bi9eepYBBPUXX05YID8cjRifxwEGNWSqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHPvdWMeIqCk89Uj9e/68+R2PcUlh6+prvSAy5b3u0kkETHdLFJAhdZ4KLMCVNgvP
	 2YeIGL1iaJEz66NOhCdIN828//BMAwndWA2xNFv1FBzx2LmzHzpDX/6Eqo6C8ZzrRA
	 R9gQSWguNyHFkyu+0FD1KUAMXvunUobidQzwYjcric5GoH8AniBGfOPuhwJ2feLvoz
	 M53jE72ryrrxYv2OlsZdr/9E0iWNWHBeF9Pw+cTqSuxOcXOD1vLiEYYNIy7Ng2XgyW
	 tvoMeiDxvP4pffLQkVjGznixSUEmPGUj8SUzsVSw1Wa55Psb7Miz2UQ1nYsVx5Qicr
	 a6CnhFb4jEhmw==
From: Matthieu Baerts <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.5.y] selftests: mptcp: join: correctly check for no RST
Date: Sun, 22 Oct 2023 19:05:46 +0200
Message-Id: <20231022170546.2809827-1-matttbe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023102034-patience-flaring-b32f@gregkh>
References: <2023102034-patience-flaring-b32f@gregkh>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2504; i=matttbe@kernel.org; h=from:subject; bh=Ke0HpsxxQ/bi9eepYBBPUXX05YID8cjRifxwEGNWSqQ=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlNVZq2w242HC4dsMcljkCZni5dkfefOeoLTs1s hvea28jmDuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZTVWagAKCRD2t4JPQmmg c+utEADif7LAHKayMQSryVqrUlbwiWwvUrNUSiiiT1o5phIaaoXKmlWPBWtM35asSGB4lrum8/0 7ot1X3EM2Oa0OMeM4GEQG2koKFRg+23wyiwUbL3JiCHbBAnZE1ZChDQ5qA7RLvUaQMsg+0DxtfY shVRt5XrKlVNrQyxrMM8Zybwvde9MjhAxyM1UheYSM3/oRQ7WIVg84vaGWsXXX7m1Hqa7sC/kjF ZU+8eCLT8woOlxzZoYTeLo/i2eE2DS6u7tbDjtHThPfbL/LdZ2aWxR8GewzIRxp4iyPRGM7ZkpP 0J3L/xdQ4n8Zatqnk41X3AwkVtM0UVCMT4IDSCcPR4mxKqQDA3D3PQpj9AvstlWYCjVL0Mh+ZiP N2HIWvPiBWDIVhe05iPLofvU81sh7RFJjNXDccbG6eHh9h6UTA+jQfTiExM4dX9F+nswp2lFI7Q vDGIm5BRkz3MAiNR0LDzEor1t5piBtLTTb4L0b1U11yNa0cl7hwe1jSupoteZJUxnYLRKvT37In DKcFxdyQOR3Mxh9oz1MBg8hsIPXG/4jQqHVLE7zZsSOqvJgfhVg2wAPvSzyYWtVbKk33lsXEjSo xngQmW8kX/ec/O4pK4Fb7HSuAL1qzEPvBY5jYyU2qxRrpQQZBJ1kds/4INaqP4T6UVkzKapgi62 5ygEzIbxfc4dkuw==
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
index 5e55af3e9d5f..621b1964ea6f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1383,7 +1383,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
-	elif [ $count -lt $rst_tx ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_tx -ne 0 ] && [ $count -lt $rst_tx ]; } ||
+	     { [ $rst_tx -eq 0 ] && [ $count -ne 0 ]; }; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 	else
@@ -1394,7 +1396,9 @@ chk_rst_nr()
 	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
 	if [ -z "$count" ]; then
 		echo -n "[skip]"
-	elif [ "$count" -lt "$rst_rx" ]; then
+	# accept more rst than expected except if we don't expect any
+	elif { [ $rst_rx -ne 0 ] && [ $count -lt $rst_rx ]; } ||
+	     { [ $rst_rx -eq 0 ] && [ $count -ne 0 ]; }; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 	else
-- 
2.40.1

