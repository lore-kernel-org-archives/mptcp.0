Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393A2FB2
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:37 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id y7so2217191eda.2
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSPS0ohv8sOjUp3/NyaEgOWpJMbP/S/t+Db7N77pFA8=;
        b=TCBKqMtctoEIvd49PmezUFaOiCY9ZzDq2DKZbosEfWVZAOlHuWfrrmF664jfWMWGH1
         hL7yX18wd7insjimsys1HhQcevsDO90ZqUVmvULA9hT5n4AhoitKu753PPbx0iM5UNPC
         ebfZ2HRsNnl5liJHgtfvubE2o8DNSy4fuR5sDF8BoeAydpeuKrU/9g2m6ITN3lMfzEoD
         MQqIBAkwfbU3JuCdrDEdck3ewJhf+wq4ZyuzihZD+8IfcT8Mcb3gTMr6yV9MbYtUlLjq
         VG8kIUZQEHC+RrU92gCbLxmd/nEZ5xxmns9QIXMNGL4aCzwLlA92YpLMthw48UYjyADw
         ubwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSPS0ohv8sOjUp3/NyaEgOWpJMbP/S/t+Db7N77pFA8=;
        b=JyW/Sc/8SGbSgG7YC7imz7l0LJW/jwmbmQeQdInGpMkVQdCYgnfCinJl/MtqbXbXft
         1Trp9CMODsuCopSq35dgM0szF66or9LUHQoDP3KlM2n6fJ1H/lWKFl7V8+VEU1MZwKQw
         w8SYyphIc7n2s0Ul0ESfaQpJmKwaNs9f0MGdeAKn72QYPXNPOwTd6EmssHrinKEuyVty
         Ni71b2lqO1MMVAgkpp5kDPon9xNunMyTmhbA/LeA11jwXVaYvRCL+x7Rv+FhmV+MVpwr
         4wbAKX4PfzcQFqUPKmWOoQK0VGOMGAcr97iOtCgWKJ2IjYiufXiRgCJDsdZwqzu5Yqo5
         QmWw==
X-Gm-Message-State: AOAM5308n8petX/SWK5oxd7wDWmQVnvhwgE4Ekx3VWkUsTu6LtfuAYiU
	dhf6tSiHLTTZBHB4krAcFvWoEAuYwJ8BZCiV
X-Google-Smtp-Source: ABdhPJy8hML72twf3wm+qKWeqGabL2q6USJ9zUayWQlKzmb1wH7OkMZM5Xl5zyJ/nbBqsmBScUr0EQ==
X-Received: by 2002:a50:ff13:: with SMTP id a19mr38440609edu.300.1622045316345;
        Wed, 26 May 2021 09:08:36 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:35 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [RESEND] [MPTCP] [RFC PATCH 4/4] tcp: parse tcp options contained in reset packets
Date: Wed, 26 May 2021 18:08:07 +0200
Message-ID: <20200924143505.27641-5-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160807.kCpMSHmEQCUHAoDHJDTXW8lypLNz1_VEAhH2XfMfPio@z>

From: Florian Westphal <fw@strlen.de>

This will be used to handle MPTCP_TCPRST suboption.

It allows an MPTCP receiver to learn more information when a subflow is
re-set.  The MPTCP_TCPRST option gives an error code (protocol error,
path too slow, middlebox interference detected, and so on).

This allows an MPTCP receiver to make a decision to reopen the subflow
at a later time, or even completely disable the path.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/tcp.h        |  2 +-
 net/ipv4/tcp_input.c     | 13 ++++++++-----
 net/ipv4/tcp_minisocks.c |  2 +-
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a981b5d60112..92eee154e2a3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -609,7 +609,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
-void tcp_reset(struct sock *sk);
+void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8afa4af30fdc..0a10ba1df1a0 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4206,10 +4206,13 @@ static inline bool tcp_sequence(const struct tcp_sock *tp, u32 seq, u32 end_seq)
 }
 
 /* When we get a reset we do this. */
-void tcp_reset(struct sock *sk)
+void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
 	trace_tcp_receive_reset(sk);
 
+	if (sk_is_mptcp(sk))
+		mptcp_incoming_options(sk, skb);
+
 	/* We want the right error as BSD sees it (and indeed as we do). */
 	switch (sk->sk_state) {
 	case TCP_SYN_SENT:
@@ -5590,7 +5593,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 						  &tp->last_oow_ack_time))
 				tcp_send_dupack(sk, skb);
 		} else if (tcp_reset_check(sk, skb)) {
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 		}
 		goto discard;
 	}
@@ -5626,7 +5629,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		}
 
 		if (rst_seq_match)
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 		else {
 			/* Disable TFO if RST is out-of-order
 			 * and no data has been received
@@ -6059,7 +6062,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (th->rst) {
-			tcp_reset(sk);
+			tcp_reset(sk, skb);
 			goto discard;
 		}
 
@@ -6501,7 +6504,7 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 			if (TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq &&
 			    after(TCP_SKB_CB(skb)->end_seq - th->fin, tp->rcv_nxt)) {
 				NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONDATA);
-				tcp_reset(sk);
+				tcp_reset(sk, skb);
 				return 1;
 			}
 		}
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 56c306e3cd2f..12f2495f98df 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -802,7 +802,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 		req->rsk_ops->send_reset(sk, skb);
 	} else if (fastopen) { /* received a valid RST pkt */
 		reqsk_fastopen_remove(sk, req, true);
-		tcp_reset(sk);
+		tcp_reset(sk, skb);
 	}
 	if (!fastopen) {
 		inet_csk_reqsk_queue_drop(sk, req);
