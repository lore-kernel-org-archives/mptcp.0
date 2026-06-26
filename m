Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9843DCDAB
	for <mptcp@lists.linux.dev>; Fri, 26 Jun 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782457460; cv=none; b=Fiy+wIOw6WFmZRuyNx5XdnyAA+/yw9p30ptq86r+spWSFTQSfTxVTtrtRfGzHHw9G//RA2UrNPRjq9Guz1Wy/G8R3DHIQka5OBEOdDP44d2Efd7+VLRRaLGL8v9RO0E5gvl8cil/2erBvF3ab19mBXqQ9L4JUhBgwbXA5VrUc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782457460; c=relaxed/simple;
	bh=RP7h4GVrHU3lSQ7Yl04CRkkE9pxZ9wNUUrHVUYfkRxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vng+TG3m4giVzojC8maWWzGzYfjQdslqi8kJYlcopZT7DUWZwMkPSYlKUjLodrZa/VjujSGiWJqEe8UVEzkS1nsY1YF2gZk+DgNSZRo4ZtaNsGSNIsqbVwe/PqcdX55n8kH1nGcQ2LGHBqiRdthL7B40QfO4fG6qmttob9nNMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN9YXL3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gN9YXL3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB631F000E9;
	Fri, 26 Jun 2026 07:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782457458;
	bh=rrIXr5n5BZ4I+iuqBn4MHqgEDVYxtNJbSoVCHIYluv8=;
	h=From:To:Cc:Subject:Date;
	b=gN9YXL3MEHyJ0gGV0IQGlsZrIZFoCZR2yU3hVlguPooqpU1zVo8dlLaO9Qe/wJeF/
	 cphMn89xNnU6eeFSmJ4DLpQ8cMLsbUKBhSvhNMegbv3VKYaKB8iNAbC4IvgqZpHKbD
	 5X/RXWRppnpTF0lSAxar0nK0lX5FjFd5uha3IhR9/eD/3kpQtxyA+aYtxVtlOk6eAw
	 b9pAHPr1AEKQsPrVeGO4lLVdmSI7Yt3jklXwMW0Q6z9K5r9aZHheaJwxzgK+/rA3EH
	 hdIJgfsjJHLrdIMzaYqG8teKTCEPdgt1kiPo+QU3Ui70esp9qlHOgBM1AMvmjoaE3g
	 Qv/N7HvDM0IaQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-net] selftests: mptcp: userspace_pm: fix undefined variable port
Date: Fri, 26 Jun 2026 15:04:12 +0800
Message-ID: <24cb3786d7ce0e7bb1397ef14c98c78fd4a9ecb1.1782457344.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In make_connection(), the variable "port" is used but never defined.
This leads to an empty argument being passed to wait_local_port_listen(),
causing "printf: : invalid number" errors:

 # INFO: Init
 # 01 Created network namespaces ns1, ns2                          [ OK ]
 # INFO: Make connections
 # ./../lib.sh: line 651: printf: : invalid number
 # 02 Established IPv4 MPTCP Connection ns2 => ns1                 [ OK ]
 # INFO: Connection info: 10.0.1.2:59516 -> 10.0.1.1:50002
 # ./../lib.sh: line 651: printf: : invalid number
 # 03 Established IPv6 MPTCP Connection ns2 => ns1                 [ OK ]

Fix it by using the correctly defined variable "app_port", which holds the
appropriate port number for the connection.

Fixes: 39348f5f2f13 ("selftests: mptcp: wait for port instead of sleep")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9ae1806ab07..30a809752d1b 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -212,7 +212,7 @@ make_connection()
 	   ./mptcp_connect -s MPTCP -w 300 -p $app_port -l $listen_addr > /dev/null 2>&1 &
 	local server_pid=$!
 
-	mptcp_lib_wait_local_port_listen "${ns1}" "${port}"
+	mptcp_lib_wait_local_port_listen "${ns1}" "${app_port}"
 
 	# Run the client, transfer $file and stay connected to the server
 	# to conduct tests
-- 
2.53.0

