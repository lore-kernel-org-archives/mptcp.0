Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2C72
	for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 07:09:36 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d1so6120260pll.1
        for <mptcp@lists.linux.dev>; Thu, 12 Aug 2021 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCFLwNzF2dQ1EIO14fMCmTGoXeTnfJSOvnSm5sxwz84=;
        b=Jin3MUZIWKNWVfnI/5utLiu2hFOQUlyPQpuovrq2iRPatcHIXKZACUCzcPNnrsIVU+
         sF10dfECaQ7qGqhJsuIr7cm4JKd2a9YecjFOG6jYt8aSBV7wfEvWswWGGjdZr6WF4PFl
         QyrDyFrX2/jIs0WqgMwgruK4P+0x42pPhrI7TLd/uf9pwOFf2ucikeo0TIXVZIlIbP0D
         ZCIrpzTTihwUHx/t8neDcs3/COA+lMjZrZJVpk6xL0La8e9sXbNLunfUgAfHKflfcYAu
         SoJR6/vopeJDK3MsQ0idGF9RsroreCjdmB5ZCmztu0R3aNyeQpEEKKIJDneQszOYwKf5
         t0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCFLwNzF2dQ1EIO14fMCmTGoXeTnfJSOvnSm5sxwz84=;
        b=ecqdR0r/Pi588kqXPLzc7YxqK8Ts7LenSRPXhGFHYtr0rWQQvMpbxMDTUYNS4ArHZa
         jMpfp4PdReNMnICwOHjJ+xc8aYGYvvk5RXU4e0rlcBcZRndQ6g2jHCXUn51SmZkhg7qO
         bR/+zq1o6Be32wkwAdi6901XdlvpEzhuoHuTHfg9U0ItdDa2+pfHyabrxulXsGpeNhzh
         gZ/guKi72ZuwsgA1lcIWsPw4diTrTMkE0Wdzzl9HVV53+Sj/Qake3G/ty+YWIOgtIfCA
         BjU3xLavDQhJLA0E7g19sVpMhCSKBqnryS5Ze3Pl2DUqSz/VX5H63O319eof7JurVX+v
         5Yow==
X-Gm-Message-State: AOAM532wMMUjulYNr22l4SVH0JZYESBDtrh8QjYk39L6dCzSzvxvX0PQ
	MDrlJkTFYWcpFY9REZNrjIUy21zjgRs=
X-Google-Smtp-Source: ABdhPJwL79DBuwwvAHfnzk1IdZPCoYDtu+V/AKG2kXep98q9YPB3W1cqoTLIdfSHRY1rI/LNbauVTg==
X-Received: by 2002:a63:65c5:: with SMTP id z188mr2651082pgb.35.1628752175734;
        Thu, 12 Aug 2021 00:09:35 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id r9sm1578084pfh.135.2021.08.12.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 00:09:35 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [MPTCP][PATCH mptcp-next] mptcp: use unlikely for non-DSS suboptions
Date: Thu, 12 Aug 2021 15:09:29 +0800
Message-Id: <e59a65d4bc669101b598c79e57ff425e4cf88d6e.1628752099.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

Usually we get a single MPTCP subopt per packet: a DSS. So we could
optimize the other suboptions code path with something alike:

        if (unlikely(any subopt other than dss is present))
                // go checking all of them individually

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/options.c | 75 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index eaee69df6635..7e8019ad8542 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1123,49 +1123,52 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
 		return sk->sk_state != TCP_CLOSE;
 
-	if (mp_opt.fastclose &&
-	    msk->local_key == mp_opt.rcvr_key) {
-		WRITE_ONCE(msk->rcv_fastclose, true);
-		mptcp_schedule_work((struct sock *)msk);
-	}
-
-	if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
-		if (!mp_opt.echo) {
-			mptcp_pm_add_addr_received(msk, &mp_opt.addr);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
-		} else {
-			mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-			mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+	if (unlikely(mp_opt.fastclose || mp_opt.add_addr || mp_opt.rm_addr ||
+		     mp_opt.mp_prio || mp_opt.mp_fail || mp_opt.reset)) {
+		if (mp_opt.fastclose &&
+		    msk->local_key == mp_opt.rcvr_key) {
+			WRITE_ONCE(msk->rcv_fastclose, true);
+			mptcp_schedule_work((struct sock *)msk);
 		}
 
-		if (mp_opt.addr.port)
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
+		if (mp_opt.add_addr && add_addr_hmac_valid(msk, &mp_opt)) {
+			if (!mp_opt.echo) {
+				mptcp_pm_add_addr_received(msk, &mp_opt.addr);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
+			} else {
+				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
+				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
+			}
 
-		mp_opt.add_addr = 0;
-	}
+			if (mp_opt.addr.port)
+				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_PORTADD);
 
-	if (mp_opt.rm_addr) {
-		mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
-		mp_opt.rm_addr = 0;
-	}
+			mp_opt.add_addr = 0;
+		}
 
-	if (mp_opt.mp_prio) {
-		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
-		mp_opt.mp_prio = 0;
-	}
+		if (mp_opt.rm_addr) {
+			mptcp_pm_rm_addr_received(msk, &mp_opt.rm_list);
+			mp_opt.rm_addr = 0;
+		}
 
-	if (mp_opt.mp_fail) {
-		mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
-		mp_opt.mp_fail = 0;
-	}
+		if (mp_opt.mp_prio) {
+			mptcp_pm_mp_prio_received(sk, mp_opt.backup);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
+			mp_opt.mp_prio = 0;
+		}
 
-	if (mp_opt.reset) {
-		subflow->reset_seen = 1;
-		subflow->reset_reason = mp_opt.reset_reason;
-		subflow->reset_transient = mp_opt.reset_transient;
+		if (mp_opt.mp_fail) {
+			mptcp_pm_mp_fail_received(sk, mp_opt.fail_seq);
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILRX);
+			mp_opt.mp_fail = 0;
+		}
+
+		if (mp_opt.reset) {
+			subflow->reset_seen = 1;
+			subflow->reset_reason = mp_opt.reset_reason;
+			subflow->reset_transient = mp_opt.reset_transient;
+		}
 	}
 
 	if (!mp_opt.dss)
-- 
2.31.1

