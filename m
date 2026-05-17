Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9C36AF6
	for <mptcp@lists.linux.dev>; Sun, 17 May 2026 06:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997976; cv=none; b=vEoGvzko5RSb5lcYNPmlwZO9sN+/QKBEYTCGnJGIUGFzdBgIZkkwUxOJr3QoAtNl5PQ/fFYd81O0KsdMmoQpVF8Y+UPfzuEyaHp6MUd0iWg+NKTevQQV+n0tcNtJfS3VAwFCUWwJ6BmqJHqEnn/5loVdEwy4fTb7zbq7a1C7qBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997976; c=relaxed/simple;
	bh=UMbv0kJDGb4DqzP57rJf1RO7F6wW9TMuOGWKszzTj/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wttfz6bdxHXCUAEJKNAR8KwC3RNqOnUOQJ5igOYHTM4aPY/VasWxkcfiipELt+W/sKcd4C+EffGdgsEDol2a9dMYE3xXYT6pAu7tfkRQ6EyA+kI7rDANG+wZI/frHOgF2gMQ9G2mBWOGppGPhE6BzdBAaix1s2PRZHLMJ8r/snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMJtl8mL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMJtl8mL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8523C2BCB0;
	Sun, 17 May 2026 06:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778997976;
	bh=UMbv0kJDGb4DqzP57rJf1RO7F6wW9TMuOGWKszzTj/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMJtl8mLv7l0O6+20+5RivbCxRAY9IIhukn0WmQnfQjseyVXW1hasnuhIGYr3N6Ro
	 TiXufoXeb9R5Z5VyLM8hR/PnTLmY+yCuCPjoa4n8Lf9vszlDNGJ/FFbIAt218I9J29
	 9OYd7JH5yJuaJGNosF+9G6W6RKXFQXSu9xkLZlm5GKWR5in9hyDznMtBWf+2vUIG72
	 HWMxCgWPdKKXfVxQMLVIzm0bhiGTIDBEfi3yxB1SEPX17GWkGc4sGsSMocckuxRteQ
	 er+pKdXe1451GDAevYbZxsUblZ8QAYKwx41sDXn2Pr82fsKHb9zZ5SaexKOPtu4PRL
	 FC7tw8u0Nsu3Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 01/10] nvmet-tcp: check return value of set_queue_sock
Date: Sun, 17 May 2026 14:05:05 +0800
Message-ID: <6fe186acd68e1083e32fda1037f710f42539e660.1778997507.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778997507.git.tanggeliang@kylinos.cn>
References: <cover.1778997507.git.tanggeliang@kylinos.cn>
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

