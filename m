Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D33FCB
	for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 14:29:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id k17so13341208pff.8
        for <mptcp@lists.linux.dev>; Sun, 26 Sep 2021 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mwTCIBh9gfY5OWOEnNNUvnEu48VjJVwgNMzq73ng5Y=;
        b=lrXYD+sSS/eyUF5R59fXTkTW6cj9FNJjvbf+5O9LVH5/gvtynWLxKurRbWcgWMVaJI
         3lbDCJwVXD1YXQwGdjAgiq+fsuxU1Yv7Z7Iw91CL8Sgm9CoCoQcqbdPUz+x8WwptSGXj
         2t0hM7bjA3tZi5OIL247YkWceN0vQVvh1eTxM0yapA5OREq8HL8S9vfmo9g8LyLmKz5T
         Sc9JMI+URbJ7hJubK81+4RohmyWmbNYxW1MaTLRX2VhF6G6qo+vyFAR/VwyrHwsALjwH
         5+Spb1xNOIKOyMITfbOLuA66U09hJMCNAk3ZT9nNP52Z5HFR4CkwpDd9FAR7CmcM4F4B
         qMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mwTCIBh9gfY5OWOEnNNUvnEu48VjJVwgNMzq73ng5Y=;
        b=qu7BGlnB47uzqZHxGwaLWY6qQE7zyd9lbBpP+h2m2BNa2Pz1JFzflwHvkGgIUCi9xD
         u2weYOWHnnFouAyzjMXOHR9zqRlFTKYfxQN7a1EYl6wLSVN/9A0T0LsjBTYy44WWy0+B
         cg0N5EI/t3gr0CwG2zgEmlqvY3D6G0feW7S8OAXTeE4MaX5MrJ8rhXgcxHGQssICOc0h
         ES0aQne/N0fkXNU+tPwodxADvQXkDLiFeDZFq0+SR9lflXm08jbHdIFC+pO6gSOG4/tk
         4Xwn/Z+bed02bIBX5z9p9j+F8T5sWirJUeJ0C1vIOH7IqGgrK0xkyO7BiI9CTcIaGesx
         pRlw==
X-Gm-Message-State: AOAM533kZMT95d5XcD3DM+QppYTH3sG2qRJ02/qAUe5nDv2+QkibaZOn
	laQFjoUotCEpVk/9g0HKoMahLlacLlE=
X-Google-Smtp-Source: ABdhPJwy9vACWZMx+Vvj241+svpCmx04XVXy4PXZHykD7tK50H+o/rOZ00xHPcneb2vH4iHn+i7XAw==
X-Received: by 2002:a63:ce52:: with SMTP id r18mr4860321pgi.350.1632666591738;
        Sun, 26 Sep 2021 07:29:51 -0700 (PDT)
Received: from MiBook.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id x9sm2421082pjr.44.2021.09.26.07.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 07:29:51 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v5 4/8] mptcp: add the fallback check
Date: Sun, 26 Sep 2021 22:29:34 +0800
Message-Id: <c2484dff1aa2ce5c10ff99524f0da71189a9f714.1632666254.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632666254.git.geliangtang@gmail.com>
References: <cover.1632666254.git.geliangtang@gmail.com>
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
index a8f46a48feb1..023fb95e1fa2 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1164,35 +1164,37 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 
 fallback:
-	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(ssk)) {
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (subflow->send_mp_fail) {
+			if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(ssk)) {
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

