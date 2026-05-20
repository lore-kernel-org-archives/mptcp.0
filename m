Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371E83438B6
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 04:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779250709; cv=none; b=MouSowXfe4VJSqUaetFj4CfTIf7gpVoUKb1i56LPoWEuYNLh9OTKjHMxnxqqiBvgedbRe3Snos5F/iwiNRVu8IPuunmjR45YPZMNJhpVvfSjoN/6+NpJT9Df/KklLNg42w9/syiRJF57i1oh7QvIo/cJMJfxEeSCuSC+ASBZeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779250709; c=relaxed/simple;
	bh=Ro7Zd/XSRvkWHql+Gx/BpRTAGXburV8uDs3LtYe+C2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4xJngvJBmrhYkkIEQBtOOWOwrQAYiwlDWjrKxLBGT7AagoWm4XGcHsYhpzmrgzR2hBtYWR6IVJzy4T3bQweq+sJyp+DQ+otCAM8bGt5x+XQ/fmrUZuNyP8N3CkxDCsG5Z5kWUygBHfuwJtKv99zX17WQU8KsNqVTa6720i/v18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmWttZVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmWttZVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6721F00893;
	Wed, 20 May 2026 04:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779250707;
	bh=vOFkhbG1t6YLC/deQbgnvtvPuSwKG/8aXWMfD2N3T/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DmWttZVXwJomjtEDAD6fswJveV8iLlhU/cF83DRR5g61ImeIhNTFbGUmeWdUIC5fs
	 ic/y7K2MzmoIAK0Dgs7iHAE7fWrDh7i3wTuic1e7oRF0vQ1iqqv7kezszxr8nMGMVy
	 E/TDpLafVQo4DKByETFLwaZ7I+pJeG72PTnCjq665hwHv4sVvEVdKn4xhfclqkGvGG
	 NGzdBy8RNKG3NSjNmWWTVzGxLx1pfpzB81XnXyQ7dYzBpCAE3mEbyt4D/QXf0VXKbS
	 hjNS5Tht5AJsCygoDhb/rFKpMcjCcROJuxmiVc1pmGmDnw8XuPUX7oUYNGHcu82CoK
	 RnbvW0+9hOEjw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 09/10] nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
Date: Wed, 20 May 2026 12:17:42 +0800
Message-ID: <050d6890e1883662202b6039e5bc582f313929e3.1779249906.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779249906.git.tanggeliang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
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

Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index db9e126ccbae..73aada304db2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1873,10 +1873,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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

