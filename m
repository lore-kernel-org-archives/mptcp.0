Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109E17C203
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418141; cv=none; b=o56ug+KKj+5n7BrRbv3++ZnUj3mHzPQNKcAMfLK9gtDXG2UtITMbi0ds8baCawubWlbtXZQvYuardmEquj2SGBoCGsJcfpe9nJn60laHP2eUGmONgAbXrO3JprFEHR+b4hfi86ZeXd0mQtIUlrZylAoyyQlADT9O8XYNK8veohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418141; c=relaxed/simple;
	bh=4eJbTuLXs11DoeswH/+v2+GJJabFVJmPhVZaIk95L6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7bFeztWpN0T0Qsf9ybIyDohuJtV7X8bzBk6ZXwd8SCTvCudhtUTQzt+d2QS1r/7+ZzKdTFBVr+jofuGOgkvXfWiENltVghcAP0Bb1KkrkJT7+vZy+DSJc2J+VGdrMC3KtrUBvDRXa4moC3/a88/wXVhJHu3Bfiws4/E3p+ouo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWCd6sW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWCd6sW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729F21F000E9;
	Fri, 22 May 2026 02:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418140;
	bh=eLHthSbsjQoeDjBWux0GVxej5NwjPLq1lMcZS982e2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fWCd6sW0FoTQsMA6HB4liTiTvnpE5Ak5Hi1fLNWKpgy9rK4LTjTPvPvBCz1B9Y/zq
	 kw/qObuQ71+hnCwX6nTGOifFiBP6yoV10fEKC6PsXkOQ5KI+lkZQb+b3mNwbxyEf5j
	 wAhRDSO+B+H54tj3uvJ0HdD0wIqhYbzCA4yr6g1isF7ujMmYPuFo1xGHTRM+a+VsLe
	 rvergfrHZsF05xWjHgDJWydirYrdfhSLM3oTMbbbdlwp393zph8j/G68SZVZ8m3D7L
	 3xHcIn2/hLgfVd7ZCdSWBXQuilCTu0ZwGuOVNY29OnOQl5viClHfUsJNnlgr43fDpJ
	 b3lq1BwoQkkRw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 10/12] nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
Date: Fri, 22 May 2026 10:48:08 +0800
Message-ID: <6061adf7916f993e437e841aa3e56998c62742db.1779416980.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779416980.git.tanggeliang@kylinos.cn>
References: <cover.1779416980.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The return value of nvmet_tcp_set_queue_sock() is currently ignored in
nvmet_tcp_tls_handshake_done(). If it fails (e.g., due to the socket
not being in TCP_ESTABLISHED state), the socket callbacks will not be
properly set, leading to queue and socket leakage.

Fix this by capturing the return value and calling
nvmet_tcp_schedule_release_queue() on failure to ensure proper cleanup.

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7138f0885829..92f7df2b62a9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1865,10 +1865,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
 	if (!status)
 		status = nvmet_tcp_tls_key_lookup(queue, peerid);
 
+	if (!status)
+		status = nvmet_tcp_set_queue_sock(queue);
+
 	if (status)
 		nvmet_tcp_schedule_release_queue(queue);
-	else
-		nvmet_tcp_set_queue_sock(queue);
 	kref_put(&queue->kref, nvmet_tcp_release_queue);
 }
 
-- 
2.53.0

