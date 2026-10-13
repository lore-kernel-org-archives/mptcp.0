Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C7C3A0B24
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878584; cv=none; b=P3ikmhslm90JPqrSIVZr78DeiZP6pWwBP7uLDq+KldqksXOvV90SnU5wQGfEtmH53qYIfLtDiIWJmIK7aoFdHfw7eCTepa3oDUywJBKtPO8qh19JSQ3i43ZyBfnwvi3RGkwAIqTLYQc3itL8gsxgy7C9OoaHrWxWMZfprVrbY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878584; c=relaxed/simple;
	bh=f0ag56GGugKilGWBqiay2WZC8IxyhL6EEj8YckLyr9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QcK9tflZbi7l8OjEEkE7G7pbI7H0WmQmgJF7fuPZF56/i/VU7Lu2pUYFj6ufVaVrz+veeIJMVajonn3q6BQuswwL3v9fP2DuI/E0ToCxOm1NQU75N7cLaGVYr2iOAuR1acGq3QsN4H7UK+uArHXBI4w9GZFc15KV0Xokja0+EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7awclzU; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7awclzU"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33c2520ad38so6168606eec.1
        for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 01:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791878582; x=1792483382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fB7noY6EXVtZts0MSkVstMEc4bWeQJY/V1ki1IiAl7c=;
        b=Y7awclzUaicsYC/fiMkNOGewgS47vwoo529kRJ+L7AgOhmaqJ26ieou2PChjvu6kLp
         QL1J4/2nGHqV2Qu0GSclmfDOyzLrkFisH4NlTh5kvCtkjQ+Gh7IItgJkfsdmfjz7crMj
         fxMW1uXQBRYTb0VpD2u1BS8CdUCCmzyLKLmxJPmtTp5tGVjk8bx2PqbOMGtvgtsalyQV
         PuP8UCedWqGZNBVP0t+g/tGQnSNl6v0lZ0cvRUG3ZmcsNR2etco+bCtGZTLije4/MHWe
         l8NqmPKpPsjR4q6eVZyKaEzRbroIFZ6gZXIcJLN183CJe3XGe0Nr6kPDszjomrVCiIVp
         AawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791878582; x=1792483382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fB7noY6EXVtZts0MSkVstMEc4bWeQJY/V1ki1IiAl7c=;
        b=2ibBW+stH0B7Iv8pdQ7Pukh9m3gdW9xVoRywY44RzVntAEEE4sHaTbewhwCIrCZNjG
         NZxsaJbfij6oz/Jyz0nRnGe5HaRpiB4F75wKokp/va19eFIR/hCOp3JAlYdEb74cBs7H
         M+ra7gJhG525qkkUkMmTuVtBouxJVM5ZHoi03hcA0TfZq0EyoWB+Ltf45fe6NWxFLLrE
         4yWhnh9MdTJg0mVd+xyKSeXEzztR0pRi1pwQ8hPwswK8q1Rxvd/wUdGcfZymi1LeNqQe
         qXaZ4UIuhzik5/yjPyMAPi+lCPXjwkZK3lArwHK99/MPprXJRis53uD+s+OBauIEaIRJ
         atCA==
X-Gm-Message-State: AFq9FYL09PHPXHFSwVWEyv+Hmi412jMh08SNXt8qb3R0XbM4hN2MZaXv
	AiDuT8VEs/hz8wSs4WeAjVJOxQIa97Hn7IUJgxMJPnQM0D4+CmYYJJHdEdEPhmAVi48=
X-Gm-Gg: AYBFou0q8tVN0QhXFYUpOewA1JrlPU14UCf5oPEqljcJdIgbrGcrzeqRaOdlp91Rji6
	JyzgliqfA3VlaQN1U6D5kXBhf8fMSZf9zoCDyEXNGq+X2yDtIbt8gCQbB1Zdb/gvuSINDkO2i3U
	ljF6Lgt274Xxrm/Z7XC4rKsv1yY3uHShGzyjdGeV4VfCb8NDksebqr1fViGRVGnIf69xw2QRUWx
	qjwERUg5V9MmDDYcSSdzfF97Xg0a7ApUkLbAw8Uf2U5LyJlrINNFfI53LFr+atq104u4BiyASOF
	Bc6pVI9zD1UYxpP6EAIviWM0DMTuEAcFeI9YeZudi0Itd0zDxFV9HJA8ONiQLnJIPNC5ng65zWW
	vrit/0Qsy5svbTqLBY1cpX4FbnQsogrwNRyPqUuEscDc492Ne64I0nyvTELmHBjFr0m9I5Q8yA0
	pHwYSOrSeoX9657DHq5znHx/k4mvo9e0D+qc7xknCQufIPPbgsb00eruUId/5ORvgUmi0/hkYQf
	+DZx350
X-Received: by 2002:a05:7022:1608:b0:143:3da5:cada with SMTP id a92af1059eb24-16a610ca97amr13720826c88.37.1791878581410;
        Tue, 13 Oct 2026 01:03:01 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a2f17feasm47737315c88.9.2026.10.13.01.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 01:03:00 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	petar.sakic@ink.fish,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH mptcp-net v3] mptcp: push queued data on passive TFO subflows becoming established
Date: Tue, 13 Oct 2026 13:32:54 +0530
Message-Id: <20261013080254.83992-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED and is marked fully established in
check_fully_established(), but because the third ACK carries no
DSS data, the queued bytes remain stranded until the peer sends
more data.

Fix this in check_fully_established() by checking if the subflow
was doing passive TFO (subflow->is_mptfo). Under mptcp_data_lock(),
flush queued bytes via __mptcp_check_push().

Additionally, ensure subflow->is_mptfo is set in
mptcp_fastopen_subflow_synack_set_params() even if the cookie-bearing
SYN carries no data, so that server-first replies on zero-data TFO
connections are also pushed upon 3WHS completion.

Suggested-by: Petar Sakic <petar.sakic@ink.fish>
Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Tested-by: Petar Sakic <petar.sakic@ink.fish>
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
v3:
 - In mptcp_fastopen_subflow_synack_set_params(), set subflow->is_mptfo
   unconditionally before checking for SYN data in the receive queue,
   ensuring server-first replies on zero-data TFO connections are also
   pushed upon 3WHS completion (Petar Sakic).
 - Added Tested-by tag for Petar Sakic.
v2:
 - Reverted moving/clearing is_mptfo since check_fully_established() is
   only called once and is_mptfo is read-only at this stage (Matthieu Baerts).
 - Added Suggested-by tag for Petar Sakic.
 - Rebased cleanly on top of mptcp_net-next export branch.
---
 net/mptcp/fastopen.c | 4 ++--
 net/mptcp/options.c  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index f71775090..c4c525019 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -24,13 +24,13 @@ void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subf
 	sk = subflow->conn;
 	tp = tcp_sk(ssk);
 
+	subflow->is_mptfo = 1;
+
 	/* A valid TFO cookie does not guarantee SYN data. */
 	skb = skb_peek(&ssk->sk_receive_queue);
 	if (!skb)
 		return;
 
-	subflow->is_mptfo = 1;
-
 	/* dequeue the skb from sk receive queue */
 	__skb_unlink(skb, &ssk->sk_receive_queue);
 	skb_ext_reset(skb);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index adbf8e077..0e1dd57bf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1046,6 +1046,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	if (subflow->is_mptfo)
+		__mptcp_check_push((struct sock *)msk, ssk);
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
-- 
2.34.1

