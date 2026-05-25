Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D5B3E63B3
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701649; cv=none; b=FDvXpLz66/2ebOdJvv3M/XDQ6gG5RcCwNdw5uZIGDasVCKcnsJsaV9A+/AjISmNNPQnmdH2JCvpMDJZXvyPnXGx/hE1AG+HV7EubSzm79MWgUGSDbncxGe76YERa1o7VPEHoJ7TqGZv0yWjzyw1VTvLei1mdzejgvxuNI7MwUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701649; c=relaxed/simple;
	bh=EtPqnx9xDbeYrG2da+/fXaOoIo5aL5hwuH9pFNnPEhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuhOs5eLoOnx6xKSJLExt8tmP3zZm0ymu2wIbVfxoFfyw71SRsnnx/dPqpIun+00/VKiGv3hMRj+b3UgONqE3trPtERTfSFnO6Xbgs0mQqkO6xa6mr9f9AIuw/jAcWOTwK3tKprNb1xXjMGOD804dXMJA3PoRFrelsVwh5NLFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRjeG6eV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRjeG6eV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FC21F000E9;
	Mon, 25 May 2026 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701647;
	bh=rsHMAHkJ4NGX23mCCuPPA0NOe0OeSYKZDS3Wd72PLcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRjeG6eVb1Q7iWLuWVxjl+fzoPIdvMuIq+lprk3vLK7LZAqgizQaG7nn0TzOzmtdU
	 p6psfQkIMTiidUgrBDuSJDET1SC7LiqlzL1zbLS1AW6m0ECrlD4azguKI5Nk6LCbNO
	 usa2znNByDh4iuA/haOqvXtdh66KDTbN8Ruqe1S/2iRsM3fRGsv07faBc5pU47yEDy
	 pHeM1uyMfIxaa3S15l+eWvGicnCF7BkiAfE/qino0A+Pww1FqVs9SE/Z3CFXh0KSjw
	 mtE9laRWnyI5gBCr4QBjDnmkdnilEm6qPtM0ZVppsFJJrzdq3+eOaD+OjXkPfg9Pzh
	 IcUNTgOKCcIuQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 12/14] nvmet-tcp: check return value of nvmet_tcp_set_queue_sock
Date: Mon, 25 May 2026 17:33:07 +0800
Message-ID: <236a9ed0a2ad14b534681e12970fc1139d19f7fa.1779701391.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
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
index 8c2dc4bcbcd3..1cf0ee464a22 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1854,10 +1854,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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

