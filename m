Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198E7FE
	for <mptcp@lists.linux.dev>; Mon, 21 Nov 2022 03:42:55 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id jn7so7588523plb.13
        for <mptcp@lists.linux.dev>; Sun, 20 Nov 2022 19:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0jwjMDiFKjCnaG28rI6dwTD8MAZqrDPeozzgLvCJZj4=;
        b=CNSfiiXqTvReCgNTRU6om1gTTaVMsItxxioTiLs4fLF9n5AcnH4SbpDaXbhKqC+Das
         G9Z9gw3BQDGQBIfd+DzW8G4QxqtNW7g7W1BzCHfg6h1oi6SHSCx/KMlY71J6HkmAeA1r
         g57JXQ9nnl70fg2fO2ysHxA/5lr2iVLobaSXMCOf/Ssj0bIh4YyJ/uiCwfqL2LnDmYR5
         jfajyx0ZiCgdOrxM8KH0bzTwKR2ufv6XL0UnsoojVZ3QEuW+M+e/LR2W5F/lOIr28sGj
         TN3D0BJDLFh88K6q8swHv0Pa+cVhCyfXV5ln2mdhMYtVCmQtS0GYMM4mT/m4LWT+t+na
         O8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0jwjMDiFKjCnaG28rI6dwTD8MAZqrDPeozzgLvCJZj4=;
        b=QpW07Mnm14lmU5ezADYHVrkutbNLz6s+kL5tMSM4vIwOKQ7mS7XFVRtVRksWN7i2BY
         7JZfPaRzcusbEoDxmIUK1w7Q5Y1pr6R0DxG6FlAK9iu/gjAGooYKokGrOqPdjy8XAbDU
         /4hywdBkfWDjIf47c00obD4WHrycJmIlUv4SxbqO3mRJoTh2sDhnL3qq6Acvw2PXmGcX
         WYePJ9tpx/fCOf4DRHKrfUAt6MGi10miQtxIMriP51BJW7r0ajKykFKvFiJlcNCHvKGY
         XiUlIAR+tLK9mnXQhkP+jiLRY53jTNeiG/YlhdBMFdso9Ztpwkbaywo/7URExuUscht9
         w7yw==
X-Gm-Message-State: ANoB5pnqojLTQr/I6AuoggKOlLXP92RF4DtijQtE66i2kjWX8pJfFlY1
	F0KoSeJ3dpDisfLptb964wk=
X-Google-Smtp-Source: AA0mqf4579bkFWvWban3elXkTxTV7D0tpW/iu0DxoxopRoJrRJm5jvKGJ/9XTo9jBkQ7WR7HIcyatQ==
X-Received: by 2002:a17:902:f643:b0:188:9ae7:bb81 with SMTP id m3-20020a170902f64300b001889ae7bb81mr10030306plg.66.1669002175464;
        Sun, 20 Nov 2022 19:42:55 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.87])
        by smtp.gmail.com with ESMTPSA id c65-20020a621c44000000b0056bcd7e1e04sm7409616pfc.124.2022.11.20.19.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 19:42:54 -0800 (PST)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: pabeni@redhat.com,
	mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>,
	Biao Jiang <benbjiang@tencent.com>,
	Mengen Sun <mengensun@tencent.com>
Subject: [PATCH mptcp-net v2] mptcp: don't orphan ssk in mptcp_close()
Date: Mon, 21 Nov 2022 11:41:40 +0800
Message-Id: <20221121034140.548112-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

All of the subflows of a msk will be orphaned in mptcp_close(), which
means the subflows are in DEAD state. After then, DATA_FIN will be sent,
and the other side will response with a DATA_ACK for this DATA_FIN.

However, if the other side still has pending data, the data that received
on these subflows will not be passed to the msk, as they are DEAD and
subflow_data_ready() will not be called in tcp_data_ready(). Therefore,
these data can't be acked, and they will be retransmitted again and again,
until timeout.

Fix this by setting ssk->sk_socket and ssk->sk_wq to 'NULL', instead of
orphaning the subflows in __mptcp_close(), as Paolo suggested.

Reviewed-by: Biao Jiang <benbjiang@tencent.com>
Reviewed-by: Mengen Sun <mengensun@tencent.com>
Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
v2:
- setting ssk->sk_socket and ssk->sk_wq to 'NULL' in __mptcp_close(),
  as Paolo suggested.
- remove the unnecessary 'SOCK_DEAD' check in mptcp_data_ready()
---
 net/mptcp/protocol.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3796d1bfef6b..a4fd971a7aa4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2352,12 +2352,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out;
 	}
 
-	/* if we are invoked by the msk cleanup code, the subflow is
-	 * already orphaned
-	 */
-	if (ssk->sk_socket)
-		sock_orphan(ssk);
-
+	sock_orphan(ssk);
 	subflow->disposable = 1;
 
 	/* if ssk hit tcp_done(), tcp_cleanup_ulp() cleared the related ops
@@ -2940,7 +2935,11 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		if (ssk == msk->first)
 			subflow->fail_tout = 0;
 
-		sock_orphan(ssk);
+		/* detach from the parent socket, but allow data_ready to
+		 * push incoming date into the mptcp stack, to properly ack it
+		 */
+		ssk->sk_socket = NULL;
+		ssk->sk_wq = NULL;
 		unlock_sock_fast(ssk, slow);
 	}
 	sock_orphan(sk);
-- 
2.37.2

