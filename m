Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C7372
	for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 07:22:37 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id t1so11924561pgv.3
        for <mptcp@lists.linux.dev>; Sat, 18 Sep 2021 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csQN/vjCVRsKVc7NZ9pw0ilc3TBSbnXc0pjZ0lHK+Uw=;
        b=SgZQxWh2/5fSpUTVKyZZ5rK+IMoTVJo9PLQ6dG3T1PKTfD24rwJ7z3cwA8dahbumaO
         z+dnLDX0IrERP+Zd0hRkWQ1zVR+cbn0ffIblur9hwci+4G7jWri1cW6Z9pi5Hl77vGnB
         sLf8Iv1YFw8kVSf82hlOHz5AWGlOq4SaV7WePIKkvoCoTvpzG00oZndWiwFMh3l08Y7w
         aU0JJm+QH/nHzF/UIlOGUrPVKECwVn98pGVRNkhO3TYRcb2ps/0G5HHwoblQR/jh6Yhr
         fc8LrIqbsdsbbOS2iz4PG1cQg4TTTIcZ4CtXF4dKerO+ix+1N/SOWXItfE00dEDz8TPz
         aNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csQN/vjCVRsKVc7NZ9pw0ilc3TBSbnXc0pjZ0lHK+Uw=;
        b=mnuTbD/XHoy1ZMw56//1DVjtYXbEnMrzEn6b65luZjK9adc2k9fKCq1aZvtOWbeY4H
         OZ5D+aa9jHL6IwoZ6GIwYZU7KMlzKRaq6uEDgBH9vXxi2fZXGzenNWs+GhfQO9XzRr4Y
         2eE9tc89Pqs0QCF1udlPHpXFllWnFPP4HpW38cNA5r7j4zUZr7dz+cOhk9Hofnz/zaWR
         tp7hlA8KwNhMzWHc/z0NcvJlt21XEz8iQJdoZX+zDDFx75+IcCI/GVZdM3+WaI4jRojz
         sOwZBQJEyuXna8Zfb+gxhcU/+S9A9ZDRHp9sXLkPWvlsIF3WjMlHCaT+Y7dvbs6pgj0m
         KhbQ==
X-Gm-Message-State: AOAM533dgQV8rkjoDT4QptuzLHpYHpy07o4JZ5UIHkiaInLz1BjEzeH4
	d+3OYK5X+o8vgT3ig8nb4HA+vny4JIY=
X-Google-Smtp-Source: ABdhPJzEDaW0o6sGzNUPzzF2n6bp5JzpXSjteV7ZNNA90OcfVPBDJ7HEw5+DgEWRsPngFTbEbjLqMA==
X-Received: by 2002:a63:590e:: with SMTP id n14mr13460684pgb.434.1631949757316;
        Sat, 18 Sep 2021 00:22:37 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 77sm8040214pfu.219.2021.09.18.00.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:22:37 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v4 4/8] mptcp: add the fallback check
Date: Sat, 18 Sep 2021 15:22:19 +0800
Message-Id: <e45465d567a31961db99560b256cbea6ad8cdb23.1631949480.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631949480.git.geliangtang@gmail.com>
References: <cover.1631949480.git.geliangtang@gmail.com>
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

