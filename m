Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906E3FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:22 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id t20so8397407pju.5
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csQN/vjCVRsKVc7NZ9pw0ilc3TBSbnXc0pjZ0lHK+Uw=;
        b=GrfZEN+/VCFk3YHatEAGbXhqtEK9PAxLRT6N+Qz+BMd0gA1QTPB9p1MW2T8w/y/BVj
         VgZFTrPtt+JI8PF+SV3EAf3fK+231Qw6QZlxOe3pX3ZDcBloJxGnv+O0sksnze+7FRlZ
         5pKLWg4N5KBZD7A/gwnbejnQYWQnna6BuF9aV6molwuSINjn79Glli6+cS9E8/lsJypH
         aNfE7AjGue/x7VXLWobQHIt42hqz1rAkp1mv+Wc5nTpjnUqPPoulpVF97vUI+XdajAQG
         WXLlIsiGFx0abWqeKWfIXh2kpEvTmjSx/ECuG3E2mxnKNGZgFBr8y+/n+pLz9LNvjZlA
         Y4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csQN/vjCVRsKVc7NZ9pw0ilc3TBSbnXc0pjZ0lHK+Uw=;
        b=JD3xdp2tuNl9nT9xhsWWOUgdKg93b2K5Pqt8ZhExDJCa3448OHP9svGIAl10uonI1a
         viiBCTAmkjNJtHjd9hZWoRx2eYP5HCj/ZPrPDWmfaMrVAxXDxRGPIb8+zNIglq92APrx
         1tDP142KY6Wud13OtsZsZTLYxQvAXmg7GfvhjuE/41ih27Iun7m56rof5qWCbEA7fplZ
         jO+f80KQDcbXd1tTT3TqpNF17C4F2X07zmX+CeVFuYPaQp5T+StoRI4vUsA+bjRiOv4x
         QpI5FM6e9pCW7wM8LugauUSZAC+fRhuxVZvUYzjkdMWTim6qKJJ0NfWyQCN+PmG23pF2
         FITA==
X-Gm-Message-State: AOAM533Ubznx32LfSe6dMI2J9C4KUaOrcZN04xgxZBJt0ZzMvzj4ZyFz
	UhlPSVUH92OgNNGEt+3zC+HduGqSfzw=
X-Google-Smtp-Source: ABdhPJwFgbLw/vkBKFHHJCdTH6nmo6FybdFCO6k91+28grrFMS35hDH7DL/73inDhRL+aMje9kdqHg==
X-Received: by 2002:a17:90a:190:: with SMTP id 16mr948185pjc.31.1631611162103;
        Tue, 14 Sep 2021 02:19:22 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:21 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 4/8] mptcp: add the fallback check
Date: Tue, 14 Sep 2021 17:19:03 +0800
Message-Id: <06cf0c8e53f29afacdb690945873f3e721d04a0d.1631610729.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631610729.git.geliangtang@gmail.com>
References: <cover.1631610729.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the fallback check in subflow_check_data_avail. Only do
the fallback when the msk isn't fallen back yet.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index b07803ed3053..89173f70707e 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1164,35 +1164,37 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 
 fallback:
-	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (subflow->send_mp_fail) {
+			if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
+				ssk->sk_err = EBADMSG;
+				tcp_set_state(ssk, TCP_CLOSE);
+				subflow->reset_transient = 0;
+				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+				tcp_send_active_reset(ssk, GFP_ATOMIC);
+				while ((skb = skb_peek(&ssk->sk_receive_queue)))
+					sk_eat_skb(ssk, skb);
+			}
+			WRITE_ONCE(subflow->data_avail, 0);
+			return true;
+		}
+
+		if (subflow->mp_join || subflow->fully_established) {
+			/* fatal protocol error, close the socket.
+			 * subflow_error_report() will introduce the appropriate barriers
+			 */
 			ssk->sk_err = EBADMSG;
 			tcp_set_state(ssk, TCP_CLOSE);
 			subflow->reset_transient = 0;
-			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			subflow->reset_reason = MPTCP_RST_EMPTCP;
 			tcp_send_active_reset(ssk, GFP_ATOMIC);
-			while ((skb = skb_peek(&ssk->sk_receive_queue)))
-				sk_eat_skb(ssk, skb);
+			WRITE_ONCE(subflow->data_avail, 0);
+			return false;
 		}
-		WRITE_ONCE(subflow->data_avail, 0);
-		return true;
-	}
 
-	if (subflow->mp_join || subflow->fully_established) {
-		/* fatal protocol error, close the socket.
-		 * subflow_error_report() will introduce the appropriate barriers
-		 */
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMPTCP;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
-		WRITE_ONCE(subflow->data_avail, 0);
-		return false;
+		__mptcp_do_fallback(msk);
 	}
-
-	__mptcp_do_fallback(msk);
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
-- 
2.31.1

