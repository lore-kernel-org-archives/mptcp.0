Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17183FBB5C
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106100; cv=none; b=eTxz3XyxVQHaNDM0GewhdonogY6ByEOhQrbS3eonDyjsdOWF1bL5/TBHIX5XMnyNNx2Csl4ZpDuDiuO9m0ZjshUEHHX711YbNUpn7VjlFYJF8ae7eaOdlTA2tlB6T/7TOsey3J6PT2OFmg/mkVeI2BVt/mQK09t0pfDOX57L/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106100; c=relaxed/simple;
	bh=l020gXrviNHIa4yYJ94R6HMYpNkDvMQMaq4DE7I5voc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chYHtYZgVmbYMQ7+6uNlSQ0fOnT960olnxqmh6bhynkOErEE8Pxnj1WGV8FhgUNJVm9gPlmGUdX43G9UjvfB0W8KSf0cW7NcX/Zeeje5TBWTQPFF273eWWch8K5IyGpISFscQspQdEgyY7NuOd6Jbg7ag499A3VSuy7mCOxmSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqqFBKB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqqFBKB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C46C2BCC6;
	Mon, 18 May 2026 12:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106098;
	bh=l020gXrviNHIa4yYJ94R6HMYpNkDvMQMaq4DE7I5voc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqqFBKB/wBoZXugFu1MJF9iCAZTHmEVAW/SgvaLl4GdTsk/mDbIU8Is3R2ww3ySxL
	 dnzYsl8LRBW66qLMCb4iyzuiwkjiwfnGpzr1/IG+aqUNodX8js11pfli+wSiVDx7pU
	 K+DCx7fzMCYb9AwMBsPSpXlBQGggYTVvipUosXr4HGE0AfC6JNHK03JGBkH3B3Iybq
	 80bxk6W6zVLjb4M27y//mUdCCcxj3Etysh26TYMSrMnsaPbYMGNRjq6JDGf6ZBoX+N
	 VWi/4QBoiMsULnYMJsrtYDy9oXTFLYm6GzbdaM0FS+aGxgFAUVzPYULMvLdVKaUE8L
	 GI2fwjbAuih2g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 10/12] nvmet-tcp: check return value of set_queue_sock
Date: Mon, 18 May 2026 20:07:35 +0800
Message-ID: <4033b3407043cae7ba46d2ecf346329dce88b7f3.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The return value of nvmet_tcp_set_queue_sock() is currently ignored in
nvmet_tcp_tls_handshake_done(). If it fails (e.g., due to concurrent port
removal), the socket callbacks will not be properly set, leading to queue
and socket leakage. Fix this by capturing the return value and calling
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
index 73afaf3562a6..ed1a7f1d5958 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1868,10 +1868,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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

