Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0062ED84A
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087727; cv=none; b=aQEvTYgO8N/S7k63iTebEkdIOIZ4ZvqEQMddq6OFjMW2Jhu5ppgQJYeObUWFJ75ubhPjgIK7siu9QF1kWr1FYToyrsw0WTpx1ijmnLNhAZOSgzoptvK6YI9GthtTp4nCR4y6ITcNtJHOLGePIlZ0g/EdplcPHVC2h/bY7iHEZ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087727; c=relaxed/simple;
	bh=A+QUifIVHjK0upOv1x/JIEROItV+orxcwY30N8gxpUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOdVeQHvwotor095yhAte5atWbvNM/mkv5GxAobu2xhFDL7GjB+C3DuW323IdIO/ePtDdNyavd+uCTmcSqTr6pn8h1eSjuByTBLH0ByQqtgf3SSFNptTVRe+gvBGqRv+3+VCEGsDzf+UEy1wUJyHa15m/N97Epu8aKEAXfSGN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSy4GWIt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSy4GWIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A001CC2BCC6;
	Mon, 18 May 2026 07:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087727;
	bh=A+QUifIVHjK0upOv1x/JIEROItV+orxcwY30N8gxpUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSy4GWItPzRx9ECij4GyXU0urwDY50HNZecKSpsCH6TWZaDT3obINlWpge2hin1jI
	 3hPtYlMS6q2/aMAdR2YfLDU8AXGAuhaGpdm6eMZY5mIx85wAHBkSDngkFCD8BUAcnF
	 emPGPsp+RNE7Fn3HkK03WUTYhRkk2gmZZEjTepHqjH4PIlQbeIjV/O36tbSVgE0Ufn
	 bvwTAddCbIvV1MTzY0krWgHc2iihlsj/fQc+a9KE8EdPKFDMCRAPCccDN46sSY+Zy+
	 lO2SujHb/Y2aAz2ugnbKinHFxmVhUA57ojA0LR0U+LWvMU7QpkBfone9VUPqiUMuF5
	 nWZDs2GSlPnJw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 10/11] nvmet-tcp: check return value of set_queue_sock
Date: Mon, 18 May 2026 15:01:29 +0800
Message-ID: <94eb75bda87e1dc12b38022fb3314781b105fa09.1779087443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
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
index a987e0613485..943e866506cc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1852,10 +1852,11 @@ static void nvmet_tcp_tls_handshake_done(void *data, int status,
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

