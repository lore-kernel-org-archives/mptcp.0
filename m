Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F422405C55
	for <mptcp@lists.linux.dev>; Tue, 19 May 2026 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779161134; cv=none; b=oyhEDhawYl/of9Nsc/03f4e1mFb/YBQUlkeais7Fdi43CgQP+t/rD0/cHL4LCFQkrlaOwV+Ww228rePGJATz1/yqsCY5icgOqkREsSw802ts3kG64bR1A9pLbNNv61BPgG8ve0pt+Etx4noABPF77OFkC1aqtxwryE1of/08SCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779161134; c=relaxed/simple;
	bh=x5mWLAHiw7KU2rvjaWbQHE/RPnZl6En/fNrrsyGQmig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxpzPJ+gEPA/5vrvmH3rFPN/XTwMDUKpF+WDyakP1Fc1o4FT6chgVxfFkIgpFKnqkBCiH16grKRNICe/ryqU+1GL9xTEitgrzlN1UPjI04OM+cs1minRinRPGnxu6XxAR5MdKdHkrcCJNYhGuXOnnvfZDnoSAkP1W7JqSylIldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SptOFDyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SptOFDyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD085C2BCB3;
	Tue, 19 May 2026 03:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779161133;
	bh=x5mWLAHiw7KU2rvjaWbQHE/RPnZl6En/fNrrsyGQmig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SptOFDyP5wpxDly4ONO3G+XbEeovJ3aFHglw4rhC4OWviW7KRIievisC75oajHJ6e
	 g8gCpaqOOMbh4N8ktpy0zz0Ui5l5gUZJLGhzSE2QANqr9ZMsMi3xCOBjJz+NVAH/k2
	 GuJDnKnKNTPg32OgbLDGWB87CC60MOuMATOneeH9AvdMzY1uwVtJeVi0REy4rv09ew
	 l7ltyrd9YAD3XSlnPBc4ANiTXlYiYfyTIr025BV37i/VfzysUk4ENT78UewK5BAOMp
	 DnKAz9Hxza0glieAcoVMdC3cRn6ETw655bcEj9MPAnyQKDaUcdnD/BDi0ZezTqzB/6
	 d4L3ZhYSQ2uSA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v14 09/10] nvmet-tcp: check return value of set_queue_sock
Date: Tue, 19 May 2026 11:25:00 +0800
Message-ID: <194988ce45ff5a5a2fe134d2dc9484ff9e7e45fa.1779159524.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779159524.git.tanggeliang@kylinos.cn>
References: <cover.1779159524.git.tanggeliang@kylinos.cn>
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

