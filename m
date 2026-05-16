Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F1363C7A
	for <mptcp@lists.linux.dev>; Sat, 16 May 2026 08:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920128; cv=none; b=GzGZXMZTCUKbpJdoPpGoerH20mixFrgMcdNq4U7sak35jTHAlGgf8STMBeUuuFlzIOaGH1xAcQYfLiUXXqSKWZlYNk0zQm97/x/6p10rOF19yaK5LetwP7pe6lCrp07BLEY22wREoAs0nkcduFBkprH1Ca2DuokhZYU42ObPUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920128; c=relaxed/simple;
	bh=UMbv0kJDGb4DqzP57rJf1RO7F6wW9TMuOGWKszzTj/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBOQqMsl1We3ySEEom3nH3u6ZzY4TS2UJKqJ1CRqElGtbQ34dgn7PX2tHp2WdSfVpzCYt0z4ML7VOg2ZBxM/e0nmhS2jJ64uktUd1ooS6JuXetW9pkejIoCXt2GPIKb+2LIoKilwWULTjkGEiyPPx/IWb6bjRksbIgBTlLuBsV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBHLq+o0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBHLq+o0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CCFC2BCB7;
	Sat, 16 May 2026 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778920128;
	bh=UMbv0kJDGb4DqzP57rJf1RO7F6wW9TMuOGWKszzTj/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBHLq+o0AUkvuh3EWngjMJCh22qXmnGjFJgVBAyTEuKXswwye6ChO9EXJGJyb6d5c
	 uUcqMLpocqW61jiitDrbHClZhaJeo2aCL8vekNO8g+Jz6GNkK6/wg6fsipe8Lhq0II
	 vTuXCYPolOCGSEEpiR4D59U7NJWO+CbMNnM5ssBcvnYL3v1lICXs5Iym06q50JEfKS
	 OVW1xRl+MkPM0X3/h3aas48ixwHTbDeP9BLu1cCHiTksXk8zkMwukAF5//IAhYKRUi
	 Lo4HeWCG/NZb4q0/+GvXOiN7n+7SOP3UPnpP6z+uQmCis/VN1EKNofsp/tf+hdUoAs
	 6z1YUSojYlH6w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v10 1/9] nvmet-tcp: check return value of set_queue_sock
Date: Sat, 16 May 2026 16:27:49 +0800
Message-ID: <6fe186acd68e1083e32fda1037f710f42539e660.1778919284.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778919284.git.tanggeliang@kylinos.cn>
References: <cover.1778919284.git.tanggeliang@kylinos.cn>
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
index 164a564ba3b4..8a243d22a511 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1842,10 +1842,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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

