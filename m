Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0D12574F
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 03:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520321; cv=none; b=eCuoUwubB8xvnxV2uO5jrrqnILB85DEs9oyuTJf0cp+zFMjv8SjYobdWV8XWBhulOYe06b1KtpVU4notzhs3WzMhjvWVvRJTkKsHMXpYe69SaSvbRvrXdnxxZNLZ71zs37Pd/OQAejIJ9+bFzpNOhXXt40OKSIiC3TRmEUK8hjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520321; c=relaxed/simple;
	bh=Vcgn2BAbTqilbdGhBI6353MWKisq1Q2p9sG7JojfT/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnFp881KR32Gno/2YU3DL7JbYvGHdfQUdGJ3XndgLnD4nSNmdoYvJ1U/dgYLZ9R00781Ful79OcFa5PvpJjSsuDrKh9On0Vr6NaoH7Uo6N4QRpm8nYbPTHgY5vDw8ap/nGYQFCG0Edvw/k0hrwIqq8f/O0/xQrSV9jWvIHAhLOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpD9Arwp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpD9Arwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1CCAC2BD10;
	Fri, 24 May 2024 03:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520321;
	bh=Vcgn2BAbTqilbdGhBI6353MWKisq1Q2p9sG7JojfT/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpD9ArwpL2umG+A5Vf7WXhj7OK0xUT3sA/8xHkPG8EB1Q+WS8ZtixFcevQV5l70Uf
	 m2pc7N6yIhxmuN9DxtjdBN3OTCZKLl90cDziYgqeiMm+J72pMpF0YZYGDGxYecHEoJ
	 jt8B/4ty1jNaH2ZjsUsE+Pw8GeaBN2qFKT8S3fkRkvrzdMkAqQ2eDpN6q6aVbzgV+/
	 P3L/c9IAXbabp2tafv2gt1zrOM8quW4lyJORfh+i7AVxQKnRLXA7sWVywAomGB0kkj
	 pLxd3H3CDl6P+dZMgzwoIcU3Ch8/yXrR7YSuxkzietBgSpx2t5312O6vS2YMSNnHfk
	 1ufx3+Fd3yvqw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 4/4] selftests: mptcp: use wait_local_port_listen helper
Date: Fri, 24 May 2024 11:11:49 +0800
Message-ID: <096673dbaaf23c75fbcbb93b602e4e7fc08646d7.1716519897.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716519897.git.tanggeliang@kylinos.cn>
References: <cover.1716519897.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch includes net_helper.sh into mptcp_lib.sh, uses the helper
wait_local_port_listen() defined in it to implement the similar mptcp
helper. This can drop some duplicate code.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 642a0ee255ef..5ccb302e3fd2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(dirname "${0}")/../lib.sh"
+. "$(dirname "${0}")/../net_helper.sh"
 
 readonly KSFT_PASS=0
 readonly KSFT_FAIL=1
@@ -337,20 +338,7 @@ mptcp_lib_check_transfer() {
 
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

