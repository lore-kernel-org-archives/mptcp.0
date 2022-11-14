Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82B7492
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 16:46:39 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id v17so18174984edc.8
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8b+5KrA1R/MgLD/C/AGDL4AFeC5kudabeE4Snh7zg4=;
        b=kYK/33zLMJiFEgwMCiOmylJQnMmmRPUUwyykI4Axwn7eBnrGiWtXVOnNTBX6pqYC3V
         31bWR19eW7GAu4wvTMDjHl/9vCdquK45fS8xdLJvhsOCAP+rhY9h+MRJdyxHeSLxCOXW
         mQ2swXFC++nYhOUaqXeqWtEPi1/LLlMzI58OHpoYRRsM4ueTN4EPbOeeRdBaeIFL2CxM
         u/5pGapM742jjQQaw9a92EZYXjV29icbY1CiLx5irLj9fjvFCNLDtSCrSy3lD5re6hAa
         3VMcm9S2YWVkPMsL+47CQtvjamu5BRYFOZEuEosC1tU2gK7L64m14OUdOOQi49UR6Piv
         wNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8b+5KrA1R/MgLD/C/AGDL4AFeC5kudabeE4Snh7zg4=;
        b=QUya3Hr87uleGNqy2RMxpHZqum5chWt2Mx/HVOgeA1U62io9+uhDgys5H8wHHW5UVB
         n3B0FLT4h6ccKgzQKxLUSUM35S4uOY7Nzh3bQiogbY+YCuBWJvIAo+nwngnzyWX618NQ
         UCS76y7GkubaQE5QqFkPPavkzsA0qhmfFSqZMGu2jj0cew5ajzG40CaGqOWyYsCg+PIe
         2QWO3LvrfzKE1H66g9qc3p1tRFy/XzBGi/S/CCeYT1Gz0wvR8thxEty62sZsfhrgMKXk
         rlF66umUascVCJ/ErtABpiFRR1M/lRwTVxk3K6YmgYJyk8nPyoGWSECeftPmdJGiZO1W
         +52g==
X-Gm-Message-State: ANoB5pnO0XTTHd5Sr/VgOMhD7SoJMlr/3RKDiubq5gpLMWPK7w/Tj8Og
	0hHmR1BYI++51IsyVzB+KLkZwb9fG+OX+A==
X-Google-Smtp-Source: AA0mqf6gSY6ZfCM2EMZUfT6MqQEUYDpDQtFv5sGl8NF9/CSlEeX1ba+h+j03mJ2VAlSJ0zfom5sepw==
X-Received: by 2002:a05:6402:2294:b0:464:fa1:9dc3 with SMTP id cw20-20020a056402229400b004640fa19dc3mr12256283edb.343.1668444397774;
        Mon, 14 Nov 2022 08:46:37 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id qq18-20020a17090720d200b00773f3ccd989sm4377877ejb.68.2022.11.14.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:46:37 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/5] Squash-to (part 1): "mptcp: add subflow_v(4,6)_send_synack()"
Date: Mon, 14 Nov 2022 17:45:58 +0100
Message-Id: <20221114164601.861295-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221114164601.861295-1-matthieu.baerts@tessares.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=n8kf2CYknGmeJTsXUbPls/AENlOulO/s0VViOitur7o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjcnAxSbuEs9I1rTqHlLthEH+xP8STMIPO8LLOmpFM
 sYSg18eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY3JwMQAKCRD2t4JPQmmgcykgEA
 DHuzMT6wwVUU2ql7FxDpoBBE/67KzT1xl6FSO/6Y6/r/UuHoPZszWuAfcPKJdQMjwRbfLUtvCRUlku
 pUMqzmZZ3ro87FsJM9SlCTuca1bO8PzOKNALx8UjmiYajskAJM0gOBkGEA7Jsiq6N2QUpDz7Xcy94b
 YbXrK0JwYykcVNJFjT9EDY1YF+1bX6giGj2FV6l5va35glffXmfh0WiSEw9e7W9kGlcpWVR2Tt7852
 gxsR7JR1s6bqQ9v0WFFEVkOavnI7+rfImAzezm0x0Wol9E265QK/CpyL6WtTUyj+xhWGZJNex9pCcm
 KlFZ6BG58IEIL9dOUXmcQMlHv/pMGmBwVz9E9F5vQIrzrv3Q1y7O2BKqdPqdBSf3DDwxRMm0ospPvR
 uAcKJkOCBkBlFR4vijysC/X1cSqzWvA7p4zZodu1wWqPO5ItEpOjHnTNCThGcccHCc2YYZFVtg95a/
 PDCiOVlLcz4jfmRESlzWfnuf6ele8S6TtYzcfx/ImhG/RxuWARvKUqQN1cI8K/tJbmQSvXim9tV9e4
 BIZy0OiQ5Ecs7RlCF5OSm7gDSDppzVp+fBEV3MOXMW6Y6Ad65hqw+0n/c2rd+i5evpkPY3mc1njQ+0
 CqubDAZaeZUIKpRC5MnNHxINkWpzc8BlbHqWWPLhLYLkRbFeYOKYL7qf0CSQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

mptcp: fastopen: uniform function names (part 2)

Functions are usually prefixed with mptcp_<filename>_(...), e.g.
mptcp_fastopen_(...). Do the same here with the new fastopen functions.

While at it, also remove the 'send' from the function name as we don't
send anything, we only prepare it for the send. Best to avoid
confusions.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/fastopen.c | 4 ++--
 net/mptcp/protocol.h | 4 ++--
 net/mptcp/subflow.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index d3f1ce7b45ac..4a85e1110328 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -6,8 +6,8 @@
 
 #include "protocol.h"
 
-void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
-					     struct request_sock *req)
+void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
+					      struct request_sock *req)
 {
 	struct sock *ssk = subflow->tcp_sock;
 	struct sock *sk = subflow->conn;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 96a3386c908a..ad204ef88bc3 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -851,8 +851,8 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 void mptcp_fastopen_gen_msk_ackseq(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
 				   const struct mptcp_options_received *mp_opt);
 void mptcp_set_owner_r(struct sk_buff *skb, struct sock *sk);
-void subflow_fastopen_send_synack_set_params(struct mptcp_subflow_context *subflow,
-					     struct request_sock *req);
+void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
+					      struct request_sock *req);
 
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b613046fea11..255023b78924 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -322,7 +322,7 @@ static int subflow_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 		ireq->tstamp_ok = 0;
 
 	if (synack_type == TCP_SYNACK_FASTOPEN)
-		subflow_fastopen_send_synack_set_params(subflow, req);
+		mptcp_fastopen_subflow_synack_set_params(subflow, req);
 
 	return tcp_request_sock_ipv4_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
 }
@@ -343,7 +343,7 @@ static int subflow_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 		ireq->tstamp_ok = 0;
 
 	if (synack_type == TCP_SYNACK_FASTOPEN)
-		subflow_fastopen_send_synack_set_params(subflow, req);
+		mptcp_fastopen_subflow_synack_set_params(subflow, req);
 
 	return tcp_request_sock_ipv6_ops.send_synack(sk, dst, fl, req, foc, synack_type, syn_skb);
 }
-- 
2.37.2

