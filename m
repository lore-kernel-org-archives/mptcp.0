Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196F13B794
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807535; cv=none; b=Z5dVbVpb6XDV6kVgMccNFx5CSaAvSQT5lYKTj84VFa2l2IaOmuW0/UD2uu7k/ETZqoZVQOi6LBSCt9Pp5I/iyNE9xdzBxvVUlpHymxZxzUDpuhE68TcG0qTofzKyrGBh3/35OHTp898bq7cYzSystKEnISHA6Gb4/CKFQ2ij6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807535; c=relaxed/simple;
	bh=DtCExlmNCV5nIVF1XfgLqzZeQrnTvaIAbFhZvqoCSRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbh4qLH3Rsm+bHCUH0u+SYlodxYpzmgnkd1m84mmBn4/4ATbB2XxozJ9jzrnfhaTqgknHUNnmkfpL69qwLaFraFBzBYNZTWsdWcCcMqJh4cclFenKeN9RphkT7fCYVaRPymBfsD0ZHx5XZOymUBqV/GCqJTioEjaVqwVz1P6d58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv0do+xu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv0do+xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40544C32789;
	Mon, 27 May 2024 10:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807535;
	bh=DtCExlmNCV5nIVF1XfgLqzZeQrnTvaIAbFhZvqoCSRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nv0do+xuQVAAa1Gn3ykbJm5wD1LhyGZyZG2ULKukwnwnns82T4HT9cOU7stcyNfuZ
	 lRvWgSjPRHdgtUT9pI4y8kNu4IZhGdGHV5qdnFAEjWhjOlrZATKDUwlDAcgic8cgPX
	 0faRUy1RpMriUPaI73nmq3oh3W3AnTS0QWHLPYoxqeS913CR0nkSIlUpI/59+prYhf
	 YGqdVA8WIhjF3VPtoGSdX2MvhtBjHD+88Sf68ca7yuXrtRSLOkvY/9h1yoCd2SVMbq
	 rbjEZ+zKU/VIMu6qnpjBW7OH/UHp+0zT/7n71K8SEyA1REVtf7N0zn+A0tpMVHB5xh
	 UDC1na7V/fhjw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 May 2024 12:58:36 +0200
Subject: [PATCH mptcp-next v6 9/9] selftests: mptcp: lib: use
 wait_local_port_listen helper
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-selftests-net-lib-fixes-v6-9-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
In-Reply-To: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=M4yuN0/x24oDKmyONxrmmlEBz0wy8GcFXZxdRY1Nt+4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmVGdieWe9fBYV8mohka11Qf0+iHvIDQK19vjhN
 0Bk7BB44/KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZlRnYgAKCRD2t4JPQmmg
 c92gD/9TJ7+TsSllzQQ2bIvDFjA2VNbXh27BVDMYij4deYzjY76dZxqCJ2E0Z8pXS/BwNfIW7I5
 Ar/3hiiZg0KXc3nDTx3DUR5kn0bosnrbQLb33U77YudR1WGvX0sMRtJoDn2Tt6lG/BJqnuIPu4p
 jprkd4iuHTpGAYCTit+x3iNu8VvXHfqOF61uVLSjlSLy1Y2gNGoQ6GYDj6ajURoMNC3h4AtGKhJ
 RN9ODzZbgnRDf09wftlNfDhgBwht31yNA5QI1HGfrNvbepD2ATpIZxUdSsJ5qMV/XL01EaupZwZ
 9Aj+YrMMxm/cTWBpYK+kUi6BqYRWMnau1+Z0SlsnyuBWQlm4wL3/DEbV5NuYuBejrUA2Z9F7TaB
 4Ql4MPe8vk264k37UshzzMC5qzw84FpKLwTMfi16m3xbtfDL2gcLbii0EVvpzGu9zfroQ4oiQvk
 fjkczX0r8qbQwGUvaasrjigzNaR6QG/w0pOcAPzxPSVY3RPH6oqY6xSXWaI12GJeWtI5veSMVe7
 i8bbTxnoQ87z5Z+WLeD69gfhdoeR10N1cPtD7FROywaSCUg2rpgGpLarPnzzHGCbpqUvq77pn+/
 OeMpqtttt66hL9aFVNnEDPJP5bWfZ8bsNlOR6R+NBEqhofPjSffToxpHu6fjOxbixyAG0a+xzTY
 rVF704/A8XRJ99w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes net_helper.sh into mptcp_lib.sh, uses the helper
wait_local_port_listen() defined in it to implement the similar mptcp
helper. This can drop some duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d9e30516dc72..194c8fc2e55a 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
+. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -363,20 +364,7 @@ mptcp_lib_check_transfer() {
 
 # $1: ns, $2: port
 mptcp_lib_wait_local_port_listen() {
-	local listener_ns="${1}"
-	local port="${2}"
-
-	local port_hex
-	port_hex="$(printf "%04X" "${port}")"
-
-	local _
-	for _ in $(seq 10); do
-		ip netns exec "${listener_ns}" cat /proc/net/tcp* | \
-			awk "BEGIN {rc=1} {if (\$2 ~ /:${port_hex}\$/ && \$4 ~ /0A/) \
-			     {rc=0; exit}} END {exit rc}" &&
-			break
-		sleep 0.1
-	done
+	wait_local_port_listen "${@}" "tcp"
 }
 
 mptcp_lib_check_output() {

-- 
2.43.0

