Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7D322B
	for <mptcp@lists.linux.dev>; Thu,  8 Sep 2022 13:38:51 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id bq9so13217436wrb.4
        for <mptcp@lists.linux.dev>; Thu, 08 Sep 2022 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date;
        bh=6ykXe/0MxatednbYAUEMGbPSg8zIainLw6EfHjLUbL8=;
        b=vArLvU3u/IaXAJHoghlHJfyCqWYql2nt34EbVPuAKXEOCDQnrho4sp1zyesi/V4N0B
         L0TimMjERvT9gc+TFm1REbf2T8qjgdjn80HIjN9RUw/1maL4QodNcLhfHNTxgfB6LDsS
         qVEQNA2wBio21aPta1YzcK9CJsENGMxkBF+V6LMsBYeIoBP5X4xfdq9D9vcaZrrnuaqW
         cP11/rcM7cBiQlluvD2kXmLKHZbNhWxNIpnlh1RVK3fiC3xRxrw6zy3FQ+XxIPBXtepX
         cPj1XCgqGOvzMH4NJnJa7BiZm40S2S4iMCGn8sw142WWRqycD/p1YpiFZa0RZXKHLxbB
         VL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=6ykXe/0MxatednbYAUEMGbPSg8zIainLw6EfHjLUbL8=;
        b=lCiAbFcX8iWOzzcghwjkUjIp2zX0lYKLT2ERV8oK2ecowNHabEgmFTEPJFVG3M1Ghj
         RqEYgl5YZOqdYM6EyucURhQFBLOSlOoo2LG8/GTJtLBtAv9ixMTrgY5ReS7cuKeNZzr4
         Rpx5emRwXIeeVAulj+8XlfavHp2m57awk5LYwiMmk0Akzi5AJaRkNDZ/sxVFDNiyW5Yo
         UcnP7g31+qPXOBivrYvAipGpE1eaw/YD6cBGrpFNf1ZieU+etoDnPnyuCa/crDo3KGJ2
         2fK9YwRrHlcnRikcc2S6Pc0aXpMnZxwtARVSjk+2dOIBmzJVbbRzz1roXFmZcfKVukhY
         qHiA==
X-Gm-Message-State: ACgBeo3778WkSQLet0Ak5AwFOHsSGiELnUuJFUR2W0RHzWPLWV7JgkIk
	RwFAJQ7j4MlGCE1A7Xkl7CB7NmOOULHAe80F11hyLfP2prkIrhoDRbQBJ8TIa6WY6pElmI6AdXD
	qeRFhfpbMT1COJDrgNlHXkQ==
X-Google-Smtp-Source: AA6agR4fkTGGdT6pV1N9s7uYG6C4ojFK5SydcNFYjGTZx7Nd5Z1sjAt0yIo2CjhpfAzR0lg4d3KSMA==
X-Received: by 2002:a5d:588d:0:b0:225:9818:668d with SMTP id n13-20020a5d588d000000b002259818668dmr4937992wrf.100.1662644329517;
        Thu, 08 Sep 2022 06:38:49 -0700 (PDT)
Received: from vdi02.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id fc15-20020a05600c524f00b003a5260b8392sm3100822wmb.23.2022.09.08.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 06:38:49 -0700 (PDT)
From: Benjamin Hesmans <benjamin.hesmans@tessares.net>
To: mptcp@lists.linux.dev
Cc: Benjamin Hesmans <benjamin.hesmans@tessares.net>
Subject: [PATCH RFC mptcp-next 06/10] mptcp: allow delayed data_ack calculation
Date: Thu,  8 Sep 2022 15:38:25 +0200
Message-Id: <20220908133829.3410092-7-benjamin.hesmans@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
References: <20220908133829.3410092-1-benjamin.hesmans@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

/!\ Starting from this patch, this is early prototype.

On the listener side, this function is usually called upon third-ack
when the full socket is created, with TFO, the socket is already
created, but at this point with have the material to calculate the
data_ack

It may not be the right place to do that. Any guidance for this patch
would be appreciated =D

For the include, this is just to make it work, but i didn't want to go
too far, if it's not the correct way to things anyway.

Signed-off-by: Benjamin Hesmans <benjamin.hesmans@tessares.net>
---
 net/ipv4/tcp_minisocks.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index cb95d88497ae..b31b6a22d278 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -23,6 +23,10 @@
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
 
+/* temp: new MPTCP specific code should be defined in net/mptcp/fastopen.c
+ * and only one function should be called from there */
+#include "../../net/mptcp/protocol.h"
+
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
 	if (seq == s_win)
@@ -571,6 +575,13 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool paws_reject = false;
 	bool own_req;
 
+	struct mptcp_options_received mp_opt;
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk;
+	u64 ack_seq;
+
+	mp_opt.suboptions = 0;
+
 	tmp_opt.saw_tstamp = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
@@ -744,8 +755,24 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
-	if (fastopen)
+	if (fastopen) {
+		if (!subflow)
+			return sk;
+
+		msk = mptcp_sk(subflow->conn);
+		pr_debug("%s (%i): fastopen case, update the isn master based on the key\n", __func__, __LINE__);
+		mptcp_get_options(skb, &mp_opt);
+		if (mp_opt.suboptions & OPTIONS_MPTCP_MPC && mp_opt.mpc_ack) {
+			msk->can_ack = true;
+			msk->remote_key = mp_opt.sndr_key;
+			mptcp_crypto_key_sha(msk->remote_key, NULL, &ack_seq);
+			ack_seq++;
+			WRITE_ONCE(msk->ack_seq, ack_seq);
+			pr_debug("%s (%i) [%llu]\n", __func__, __LINE__, msk->ack_seq);
+			atomic64_set(&msk->rcv_wnd_sent, ack_seq);
+		}
 		return sk;
+	}
 
 	/* While TCP_DEFER_ACCEPT is active, drop bare ACK. */
 	if (req->num_timeout < inet_csk(sk)->icsk_accept_queue.rskq_defer_accept &&
-- 
2.25.1


-- 


Disclaimer: https://www.tessares.net/mail-disclaimer/ 
<https://www.tessares.net/mail-disclaimer/>


