Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1083E5A38
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701652; cv=none; b=DB7UvVUW/nEp/D0qbeEE9j8lwNF3Pc+ESEtyCKdIU2oJuaP0dnX8IlYVjKaNu3gPyUsY4BDCoRItOSQY7ARyiD5p0USS3WMD7Oi+bfig2BdxnA6PzGYApSc5Ufni12fZHpGAjLn5DHIbB+uSmOBPZV2Ims7TIpIEYxqbTTOWSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701652; c=relaxed/simple;
	bh=TaW2gJ+Xg5i3BerQbGr+5vKutvhz5JFjl2EuwCQnDL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GSuv96zRTfQt23RnXPTuEVXSujFvv0ltYt8iTwwIqlLZfz+ihMvjCX/uAMWBwuXwZna2keRH1riBMX/6BrEkjIB5iwcCJNTxTf+47qTU+LnOl48cjC13+gZQVa7KFDbRy30JfTidH+nih0EgDgaeijaVimIyiQpkHfyvUIBPVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5NtaK1O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5NtaK1O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF961F00A3A;
	Mon, 25 May 2026 09:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701650;
	bh=CPo8LVR5xUphb9eW21gS7U0P7l2x/dnnILCfYkOUsOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H5NtaK1OptAe7VXP8Mo0QN/xJhuP5XtkHJLTPJrPk+7+YFjnffH1Ol/P1FnKUpAw2
	 Yw6Pdq6Pk8qRkin3WXqnj05tJ9pubf22yLHzZtJYCQmNEHMZuHaM/B2gi8HUbk94wx
	 4IFIzJNp+PuR/LQ+3MuCNmvoQcfN/khGNu2NBKuPuZ8hO8jv/2hQjRo3HXwkYZKaoJ
	 3H+QE9Ye38Ban6V5ZGPT/id56cE5qJbTGd7ciWxrAqYib05+VXc/mTIXNHI3ctA/PK
	 G6pmzg+gTsgDxFtH+t7IFillSw4WPj5mJjFOGHKE/3oQV2cotD+XOMspmDw5BlzzjN
	 H+GOM+ENHytSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 13/14] nvmet-tcp: fix page fragment cache leak in error path
Date: Mon, 25 May 2026 17:33:08 +0800
Message-ID: <f1c10a800fb0367d0fbbc86fbf4a6ae3fd31ebc0.1779701391.git.tanggeliang@kylinos.cn>
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
index 1cf0ee464a22..500793b56983 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2047,6 +2047,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 out_sock:
 	fput(queue->sock->file);
 out_free_queue:
+	page_frag_cache_drain(&queue->pf_cache);
 	kfree(queue);
 out_release:
 	pr_err("failed to allocate queue, error %d\n", ret);
-- 
2.53.0

