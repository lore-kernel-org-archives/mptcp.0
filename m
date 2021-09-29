Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17213FD3
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 07:35:15 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3577974pjc.3
        for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ec4XA5uZtuPVlcV402fMuaBeA5erYPIiD1DUsMvpDog=;
        b=BZgYNnlM9+1cj+PUb07BCBvYAXM37VyzUBAs03+fybAauwv57aYDRi1RoSfvIeFG1C
         lvqGG2gwIzkaYpUlu6V/fqJVl7o6pySWRvfpv2G914ON2eA1MPeB276jqjK0QlbOOyTz
         btfIPBUee5XZmeB0ZirRi4biSSEEHGs4fRP8ZUwiSsAC7TbOrQCTPrQeynmbPCAOzPlQ
         zIYi+YnZx3VFKZ4V/2kjC3rawlV1UinxtsHVbjj9T+6lqJGll+Kzkd84Kolp3tw4v6Mz
         0fXgYhg7u3gtj+4LFU3HUTxPKsyhKBLGTg8n6xshwmpOim405AYZc3DBGNM4RHvNksXT
         LDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ec4XA5uZtuPVlcV402fMuaBeA5erYPIiD1DUsMvpDog=;
        b=aq67RWySBF/zAVmVG80npx7tRfxIk5t8eso57aSQP7FDO9Ikg4hW0ajicoxaxx5n0a
         oERYPTLxwICh6y2RZtRVz/dZiCetZzw5JQ4HVvmfwsBoNCeswGl4FzZzsA+JjZeS8Tvd
         dsbf7v+VCQgltdIJJW9L3emH1dbmJ62GwWP7Hed1xnMxnLmLvqVmhzb7riB68oN9+EyP
         NRRndwcMII2GZ3y+UZNI5oO8UyeW/6Mq+dPF1PqUWD8B+nI7m4AsoEF//ZKIXpFWooZr
         HJMqHD8d2SJYs5ZIbfE489UkLbLag69JLoxc/y36R4Y6XOIvmS++Qu789GIwHl7qiSHR
         gwIQ==
X-Gm-Message-State: AOAM530li5cVOI8/PhHan7N9lsN2+hKvg673sKNli/mMxGtzMtl3r1Ff
	zJgeaUEbWFADoQd5IsK3wI8Enlhp3prpyQ==
X-Google-Smtp-Source: ABdhPJyfhyBRXpg0GHzgAFRLc1vrqYrxDheS1/trj5w2P9W+F6hlUAw+zaYTRj++QUlw0H4bAOBtBA==
X-Received: by 2002:a17:90a:2944:: with SMTP id x4mr4944365pjf.131.1632900915466;
        Wed, 29 Sep 2021 00:35:15 -0700 (PDT)
Received: from MiBook.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id gn11sm937853pjb.36.2021.09.29.00.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 00:35:15 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-next v6 2/9] mptcp: add the fallback check
Date: Wed, 29 Sep 2021 15:35:00 +0800
Message-Id: <795e3d996791cfb7a45f7d2dc2b4935f1d2b40c2.1632900306.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632900306.git.geliangtang@gmail.com>
References: <cover.1632900306.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the fallback check in subflow_check_data_avail. Only do
the fallback when the msk isn't fallen back yet.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 92b45a7c997e..87a9ffebcc42 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1164,35 +1164,38 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 
 fallback:
-	/* RFC 8684 section 3.7. */
-	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+	if (!__mptcp_check_fallback(msk)) {
+		/* RFC 8684 section 3.7. */
+		if (subflow->send_mp_fail) {
+			if (mptcp_has_another_subflow(ssk)) {
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
 
-	__mptcp_do_fallback(msk);
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
 	subflow->map_seq = READ_ONCE(msk->ack_seq);
-- 
2.31.1

