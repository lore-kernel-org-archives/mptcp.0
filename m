Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6237017C203
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418143; cv=none; b=t9hp8pRCszn6tx7NHAoNHCDJvIzMaIL3QT5Bw7pcfjk+kWwEjHISXkSaiQcptRrZP3szSWQZ/gPjWg1elLZ4PeMWSbpDHX1wAvB2LUKAz5ZHQabktjsbkhjm0UZFcFtF0ghmMgd7u5aztFIkFv7CPOY1SuwmFe2ZxlYsTPYp0Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418143; c=relaxed/simple;
	bh=b6wRUNtsVjyjxSgItyRFQmM5Gw/S3U3tU5wTgvqCFfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/m0K8B+N6aKt5qbfLW2ASTXhmTXgta5Re4KRgEwDj2S8a7wwKYFW8oaAyMs4AF07HnJ5JFXXZKsafz/+UspgK41TVWFgKUcrRP00hAqB0l9E3goLobn64R3gH/V/ViIZ4Q4KTHZcS5+KRaJW17FqdPVCiXedYezE/lXzCnuTPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WKJW+Bpd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKJW+Bpd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5551F00A3D;
	Fri, 22 May 2026 02:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418142;
	bh=gsSUtvnpXHTwvXRxaN3efsNrFVO1DlOVqm5yitZqssM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WKJW+BpdekAMwO2ZS9vNIx+6olUnp06etmbsryEh9eURlFQjLgB5Y6sBSsJxZT2Eg
	 TYNxVoOYf7W8AqzpWKsZi9w+jM9O7FckleRkgK/FqTJ6xqvO3vFYblQ4ls9NqfynLj
	 LMkdBel+5MUd0A79ysvE7ZaN3bV+mhfTMWmm2qgUQrBR4JMOCpB2gYDWnErgHOMmPj
	 AoSZNJ+nz8kbbNmZMsYT1MqCo8cBptDZVlA7DopHNdQ8qulBxODNw/Az8eHrXKDSEv
	 n1s0Glhixaxgq/zdWLhtRvOVI0RB42NcNTXBUrP2vRQt/k67uh+VEogGi32EWQ5BsB
	 EYX+CRpelRnCw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 11/12] nvmet-tcp: fix page fragment cache leak in error path
Date: Fri, 22 May 2026 10:48:09 +0800
Message-ID: <c95c00af897b250fa67ce6acd1c161e1f6be7cfc.1779416980.git.tanggeliang@kylinos.cn>
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

In nvmet_tcp_alloc_queue(), when a connection is closed during the
allocation process (e.g., nvmet_tcp_set_queue_sock() returns -ENOTCONN),
the error handling jumps to out_free_queue without draining the page
fragment cache.

Although nvmet_tcp_free_cmd() is called in some error paths to release
individual page fragments, the underlying page cache reference held by
queue->pf_cache is never released. This results in a page leak each time
a connection fails during allocation, which could lead to memory
exhaustion over time if connections are repeatedly opened and closed.

Fix this by calling page_frag_cache_drain() before freeing the queue
structure in the out_free_queue label.

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 92f7df2b62a9..8dd8f740c8b6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2030,6 +2030,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 out_sock:
 	fput(queue->sock->file);
 out_free_queue:
+	page_frag_cache_drain(&queue->pf_cache);
 	kref_put(&queue->port->kref, nvmet_tcp_release_port);
 	kfree(queue);
 out_release:
-- 
2.53.0

