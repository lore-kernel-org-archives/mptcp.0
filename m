Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF813CABA
	for <mptcp@lists.linux.dev>; Thu, 23 May 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451754; cv=none; b=QdrRrO2EqPMiTOWaq8Pm9Y3tPAs8g1GUmm6vMKRfUQW/cw7k5E4KJxpR3QXjm6BPv3pddeM7gMAq2VIQhFYCaHWi+U0hxbA+rjlqmnHrLw8+y736rFEkCObQPJk92Xt0+T+rD079zMiHumoRThctf6v8gaozMrU7t/BWm/I1Y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451754; c=relaxed/simple;
	bh=JPUe0s/BaXQMHT5TsI3mpMGtaAAUDqhya8omlAik5LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzLjHdoOfur7uZZxbHN7+fYDIkU7JhaFh16XAdmxEumoz5Ht0ZFccJEinf26VDZWN4xcc9uQ6dwq6i2h9Y3wXAwIcp2XmjoJZxR0xIjgBdQq4NOvCf8FDdkjjoJAT7vHv/nsb4K6WP/93irXJen5G95JrYqTLZycB2KTGF9hQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1WnFmAd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1WnFmAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8844C3277B;
	Thu, 23 May 2024 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716451753;
	bh=JPUe0s/BaXQMHT5TsI3mpMGtaAAUDqhya8omlAik5LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a1WnFmAdOZJ7KPxzjeyuo/ETW7jE1G+7Ha8/JtpeWiOAQYe0XbCFmywxOvgLh4aro
	 9o1Id1t4FqUtt0kRwhVQGytnyMsnr5SNFYPU6p9Ev+YFsYbUWjNzDbqShy6KJQYEnp
	 iLbilOOtXjTMblCD/WHSo4FNwJ4taFMYhQCQHvSKivBMv5+xv7HvgJVq8G93nhiimr
	 EDU4IVBUQ3XQLk9G9tm//Z4os8GDG5zYWtUj5jZBWhXItBMmvN6bNXoUCw7KN3yuhl
	 RV6yOR21ymPOuKbmDUK97rHVytH+2wEDgYPZiRCMqOv8teBWKdZc0vFnjlSmlAkmSy
	 sqCRq3dw1mxIQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/4] selftests: mptcp: use wait_local_port_listen helper
Date: Thu, 23 May 2024 16:09:00 +0800
Message-ID: <97fa6e63c052859546163fad4ff96a78ce95415a.1716451525.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716451525.git.tanggeliang@kylinos.cn>
References: <cover.1716451525.git.tanggeliang@kylinos.cn>
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
index bd7d78e4aa83..e039c88a64ed 100644
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

