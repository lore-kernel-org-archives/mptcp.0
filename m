Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB2208BA
	for <mptcp@lists.linux.dev>; Tue, 16 Jul 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163204; cv=none; b=By/vqZXW2OD+MHLKMYElncx4qknotgT97J3KAOm9QFy5P6M3+vQkz0yXc1KhBitN+VRac63ObfNnSk27VI/ThSokJ4xC/h7MpRCdja5YE1J3AXaVpTWbZ53xy6poUcNQ5Br2KqruicFPgi8N/IBfRT6F78BStW16HYL2CbE6yxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163204; c=relaxed/simple;
	bh=/8hfjipBRbGO/JeaUmL3swIPSyyfYZ6/wCbBD5jA8lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=prOvci+aN96XVYVWevKzFvInlh2cBqaMi8CKS/5cfdUn0jifLRlMfJycBk1EWteX6BOd2INcfUH9J7lN+D4O4hAH1g/PAFQLrhZxIyScDSbQouvkR8XpFLMcAGJXAFu2IbwTlBiH2TJo3jWsOz5wMsUtP5Y1bsTpmOcyt2Q0hk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QVltMj6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QVltMj6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EB3C116B1;
	Tue, 16 Jul 2024 20:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721163204;
	bh=/8hfjipBRbGO/JeaUmL3swIPSyyfYZ6/wCbBD5jA8lY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QVltMj6djoJXxPenhNquQvZ8SwshL3Prbid7ionC2tVDin7v0QRtx0PjtvJJGmCtv
	 iuxZ8gp6HpBUUUV1lnpChj21DCwbc1Ye5HqLKc2imUm9GyYahmznh4C73Q0/hGN/Wn
	 e3tmDrqlUtPHjZfNHqeIwXVp6LofInfunTyDLD4MS16XMDUDbUANbwqF9Gd+/1PAsU
	 XhzFAZgguCZvG9NAtOBxFI9LA+rTkCVuoTGBJFxflQWLlkTfcEWzaEtvtnXZQAMj/7
	 Qgwgn8ENyfAfAhVdbVHwpIttby84I/DLdMOSQ5IzFLc560S1q7X9tkRb06voG+tt4w
	 Zfd2PLWGlRQzw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 16 Jul 2024 22:53:13 +0200
Subject: [PATCH mptcp-net v2 1/9] mptcp: sched: check both directions for
 backup
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-mptcp-backup-mpj-v2-1-4d50247405fb@kernel.org>
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
In-Reply-To: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/8hfjipBRbGO/JeaUmL3swIPSyyfYZ6/wCbBD5jA8lY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmlt3BW2pbNdeaKaRkzn6+zWs++ygsrRqRwq7GU
 7THqeqs5WeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZpbdwQAKCRD2t4JPQmmg
 c9ryD/4vRX1NJvKuhkRY+YwQutSLkN8XB9AkdCDbYV3F16IUyPo1+HHGP9Z0ADStTCNmNHaAjIT
 BiBLAizU+yDFmjKFHeUfQdbLCyhYzjEwkkutVOzoZrBGfFGR6K3J4wBHG/ZPCQnd8jxMRQNLAJA
 OQ+ctcVQL8l8MkNXspj5XEXDGp0brCU33K1ezcj45CeU4RaU6z7rzmXrMfpngdklaV/C5dyGcNd
 wi0r/+nyYeIdS1mD5ia1ultLscEFUnlFhZC8KDkVxwWJEdZ147xPYHQApgg1gaHs9gHbHH0HBWi
 L+T5cweBajbWAYXG0bRZqdJRM2zTcZr5+dID0Q4uTwWJHZIMOwHZRSXAztC/Sfcluzr17skkHiQ
 ZY3IGOzNU2lQJWGVvOyFNlqs5dE/e/Yy5j5EWGri+wfZfVvmzJwHfw6J3076xYdBtoGW7JaaqsO
 aKye0yAw4NHJCWHL/s735eFkb5ZtYAMQ7zgYeK+yc62R6FTBDN3+mkZN44tlqANQjYENdisfHGq
 xYq+tNyfUeR0k0w+twWWkDljMvjWlSZHJJC1rNXF1H1Wu8HGgNuwkGULz3iZynHdnINX/YvHpw8
 ptes9EtsNYFnElCDGc9qm6WbQyMwKnvihmHbdhEtzBEc9i6XyPkfgI2NNSmf75o2MmbwY5Rkrpk
 lP0lJfkyl0AWdkg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

- 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 09e72215b9f9..085b749cdd97 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ac94225489f8..b3a48d97f009 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1422,13 +1422,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
@@ -1439,9 +1441,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);

-- 
2.45.2

