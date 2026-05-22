Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C617C203
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779418124; cv=none; b=SsXr3bbFyDOMiDjmcu16DShHHekT3LkYO35mC0PhSZZhvTq2xeokAw9HG/1BITTooWOj+8hWsAIBGjkpVyxV2ZuEQfxFVnFHJvtV3wkBeTwW/+fNBSpaZCUEd2LSdFgBKoNUOEvp61VD7hMqS7Ishar632giP4oeZmE33gayxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779418124; c=relaxed/simple;
	bh=j/+BQzwUUFaZmJh3OaTk0+LFpkd1c073HDiRvDr7j3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bxge0M+XvxIJj3y5i97e90KkCy0qAVtK/wcEoC3VIlkRp1wzgLVop+mUihqtmvowda8bYJLJ/2MKEPKXTNm55QSt6BDeCil5OxzmFzrt3z9gHA2abVgMGeo0gnDDELSup9fdwgMEPlvdmraGLaAM4GSfjYrKOwdDbxc1o3ulnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVec9qFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVec9qFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6681F000E9;
	Fri, 22 May 2026 02:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779418122;
	bh=FL76HMjukhh4LGWXyMIAWMW5g3XmuO0VUDwpI6vVwJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eVec9qFPSZzlKhFGRKmJEasvA2UqtqKcg8XQFmzOd0qPmXU9Mf191A8jbRDy3K/oN
	 0LlAjDzvM9YhboxysCsdhye5AO1nuTA0QfVgI0HzKFwAzJjdtQBoBqQj5XZqtm02Xp
	 rQDlhb9LZDHRJCNFm+zDLWGZE9JynTNxK3uqZ4XB/LMMMmnMFpScmFytgeGCpgsscE
	 AbifggGJFlM8o97IYKpsOdsnm123uwrxLNjRMkQPWFyfr9qv3Qj/b51lvlIOWlEb3y
	 OaFqaqTsvgJr4iJfUL6vVXAL19GQNFPKWJeHlNzWom+8LA8xfPzxkVGbkAm+AMo9Jk
	 bz7+eT28lKuVA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v16 02/12] nvmet-tcp: add kref to struct nvmet_tcp_port
Date: Fri, 22 May 2026 10:48:00 +0800
Message-ID: <b0dd3cb01ca71e51b17c97b7e8cbea9111edf58a.1779416980.git.tanggeliang@kylinos.cn>
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

A proto field is added to struct nvmet_tcp_port, introducing new code
paths that access queue->port (e.g., nvmet_tcp_done_recv_pdu uses
queue->port->proto->ops). This increases the number of port access points
and the risk of use-after-free when a port is removed while queues still
hold references to it.

Add kref reference counting to struct nvmet_tcp_port to prevent such
use-after-free scenarios. The port reference is taken when a queue is
allocated and released when the queue is freed.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 78043506f444..e585dd257fdd 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -213,6 +213,7 @@ struct nvmet_tcp_port {
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
 	struct sockaddr_storage addr;
+	struct kref		kref;
 	void (*data_ready)(struct sock *);
 	const struct nvmet_tcp_proto *proto;
 };
@@ -1609,6 +1610,14 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
+static void nvmet_tcp_release_port(struct kref *kref)
+{
+	struct nvmet_tcp_port *port =
+		container_of(kref, struct nvmet_tcp_port, kref);
+
+	kfree(port);
+}
+
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1635,6 +1644,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_free_cmds(queue);
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 	page_frag_cache_drain(&queue->pf_cache);
+	kref_put(&queue->port->kref, nvmet_tcp_release_port);
 	kfree(queue);
 }
 
@@ -1936,6 +1946,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	kref_init(&queue->kref);
 	queue->sock = newsock;
+	kref_get(&port->kref);
 	queue->port = port;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
@@ -2015,6 +2026,7 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 out_sock:
 	fput(queue->sock->file);
 out_free_queue:
+	kref_put(&queue->port->kref, nvmet_tcp_release_port);
 	kfree(queue);
 out_release:
 	pr_err("failed to allocate queue, error %d\n", ret);
@@ -2084,6 +2096,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	if (!port)
 		return -ENOMEM;
 
+	kref_init(&port->kref);
+
 	switch (nport->disc_addr.adrfam) {
 	case NVMF_ADDR_FAMILY_IP4:
 		af = AF_INET;
@@ -2186,7 +2200,7 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	nvmet_tcp_destroy_port_queues(port);
 
 	sock_release(port->sock);
-	kfree(port);
+	kref_put(&port->kref, nvmet_tcp_release_port);
 }
 
 static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.53.0

