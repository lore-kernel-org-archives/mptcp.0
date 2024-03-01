Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235E67E79
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275624; cv=none; b=WSIwLXKOS0dtCrHjb5yGfFs8f5M/Qq1e85FoP7XW3Yw0MaiAM10gaIqxeWUtkxy2+LreIh6UGJWMUXmRuUJnE91Ma4p+v60FeoDnD+kVwvbwLS0QPg4lIlgq3WZ6BY0aG90CphSmE2+U7K8ps2njZ54wKKuVtGP1kdIGL9HpqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275624; c=relaxed/simple;
	bh=CeysPUs859NGxTYkiD7yPGixmyXJEiqppZF4B17j2vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuaFSOblWFxUKZACTRXYOrGMrWqEiYGsFRkVdPQ2BNpIf3LSmpPY2xXeP7hcJ7iz2ZoLQebPmRof/hNHKRV4ZDWFQE84S/B4sSTRWJbWO3TLYsLJ5t9NyztelNthhniI5MqtRxn3PjABFNotilkrLGwNXiuOmvXU+PRD2OsAFZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNo49P9R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNo49P9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F35C43390;
	Fri,  1 Mar 2024 06:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709275623;
	bh=CeysPUs859NGxTYkiD7yPGixmyXJEiqppZF4B17j2vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNo49P9Rt7PFxX0NXze1RpkBH+HARx6w/cU2CqmPlRw+0SbiP/1nyLTWcr+ZoQEU1
	 lP+2EIgdz5mGcVF3GABbXR4fW4fUxMmc6ZuUMefhZubd9pdHOpwWSJ8HdI5l9838JL
	 37sIeuQJ+pf9WjJsfYlqaFndtZfpkUnA8RPUUS53Qemh/pitTwubNZdIwxaWFzrD5+
	 lvd7Nu8nSHmqL5IGMnn3o1A+oTxg1D2ej4swCdxeiae3Enmp4wXeLw1qAvsXlwiU1d
	 92kvuQhWaV539cXGMLfMXomTA9UnlCTmCySmuy6XRpb9fviPoeL/IUu08B/h3Hw8zH
	 aA/qMrSS6Ny2Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v9 1/6] selftests: mptcp: connect: add dedicated port counter
Date: Fri,  1 Mar 2024 14:46:31 +0800
Message-Id: <d5fb21d260eb93fafafe67dbb8886e74fd22aaf1.1709275290.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709275290.git.tanggeliang@kylinos.cn>
References: <cover.1709275290.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 0ca2960c9099..4f40221a86cb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

