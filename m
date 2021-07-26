Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BE70
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 06:45:27 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id d17so10374545plh.10
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WwD12pMoRNH4sYL2gKFke2Mm8ZkHcNXA8ANa39JdyLY=;
        b=YReVrg0hOfA5DiMdc/pQjYtBtHXDIEL3EvezRj6d+BJbtwfKc8/azbahoQlztjhSgD
         DZ7IfUXlUx4GjQn1M+UZa9LIp428k+3lH5O5Y6rqQlarTDU7rYPg6IByO7msgyG0QYT2
         vlu03PAfC8zBpwhTPG40ezOyqT1p1fibe0SopsXhmluq/ndnSzHu5g6hGlqs8A46t8rZ
         QisW5zP2mJ8N/z1drB+uGBVuB43+qZpMm9/CFZYF6IPlppG5JKl/rN+YCMKpoyb7qBrF
         X+JkF2TwF6wDTnayTvzMRqm6XfzSQ9KAMulSmDICxGHe3+oPF4jcFCjvNTsclyRVLBfB
         m4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WwD12pMoRNH4sYL2gKFke2Mm8ZkHcNXA8ANa39JdyLY=;
        b=GbcWJgUsuUUCfZXRxl5MmjsnSfx+ezdCGuM/8P3oHzITYcz/SrduWchAJ5LsSWuWL8
         Lqvbn7E5h9iH/ea9/gdofYOPbymAN0PrK2ZsRTEljAentwGuhF3yVY/btW/JizEN8gDH
         En9JeH1TzgwilQAuBq3q/8FEohhaNxek24TyZ51GSfstlwCxVgMlzrDi6qsZyb79gWWC
         nyuFHf0r1JbyRGGtkiE8ttPwh3tGNhNeJdxvHoXMRRpr842Nhz/p0oMRnCAzcpVz4QL2
         Rync8+94SJQ8KT+h1PmF5xKRzwUDqpfihvAAa7fLPoGtF8grwkyud9oIqFeHNCYncEKV
         rAVw==
X-Gm-Message-State: AOAM532vVGtZbhFocd7XOXGA9mNVaSy28IAerl7BrXflByrsUYHz+kln
	Lp+cyiFniiRcCL1nLyBVQyT0hYMI03DtbQ==
X-Google-Smtp-Source: ABdhPJy/aAZFPS0v6OGLZbOhrpIKkFYHMutYWplhnI43kxIIFP/yj+iwK6Ath2fcv7Ws2l93akPvig==
X-Received: by 2002:a17:902:a513:b029:11a:9be6:f1b9 with SMTP id s19-20020a170902a513b029011a9be6f1b9mr13026459plq.55.1627281927214;
        Sun, 25 Jul 2021 23:45:27 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id k11sm10634697pgc.30.2021.07.25.23.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:45:27 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 3/5] mptcp: send out MP_FAIL when data checksum fails
Date: Mon, 26 Jul 2021 14:45:13 +0800
Message-Id: <8bfbc479bd4513a51a96542b5174b6f75d33c656.1627281326.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <bcdbfa514af7e5dc3741c16bb692c070ed50f3df.1627281326.git.geliangtang@xiaomi.com>
References: <cover.1627281326.git.geliangtang@xiaomi.com> <fce3d982e418e791fc38dd2e9f116de84e429d21.1627281326.git.geliangtang@xiaomi.com> <bcdbfa514af7e5dc3741c16bb692c070ed50f3df.1627281326.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

When a bad checksum is detected, set the send_mp_fail flag to send out
the MP_FAIL option.

Add a new function mptcp_has_another_subflow() to check whether there's
only a single subflow.

When multiple subflows are in use, close the affected subflow with a RST
that includes an MP_FAIL option and discard the data with the bad
checksum.

Set the sk_state of the subsocket to TCP_CLOSE, then the flag
MPTCP_WORK_CLOSE_SUBFLOW will be set in subflow_sched_work_if_closed,
and the subflow will be closed.

When a single subfow is in use, send back an MP_FAIL option on the
subflow-level ACK. And the receiver of this MP_FAIL respond with an
MP_FAIL in the reverse direction.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/pm.c       | 14 ++++++++++++++
 net/mptcp/protocol.h | 14 ++++++++++++++
 net/mptcp/subflow.c  | 17 +++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f37a014b4875..4a5cf1261ee0 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,21 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk)) {
+		if (!subflow->mp_fail_expect_echo) {
+			subflow->send_mp_fail = 1;
+		} else {
+			subflow->mp_fail_expect_echo = 0;
+			/* TODO the single-subflow case is temporarily
+			 * handled by reset.
+			 */
+			mptcp_subflow_reset(sk);
+		}
+	}
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 19533e5778a6..1622d6434785 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -433,6 +433,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		mp_fail_expect_echo : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -614,6 +615,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
 	inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
 }
 
+static inline bool mptcp_has_another_subflow(struct sock *ssk)
+{
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
+	mptcp_for_each_subflow(msk, tmp) {
+		if (tmp != subflow)
+			return true;
+	}
+
+	return false;
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1151926d335b..a69839520472 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -910,6 +910,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
+		subflow->send_mp_fail = 1;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
@@ -1157,6 +1158,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
 fallback:
 	/* RFC 8684 section 3.7. */
+	if (subflow->send_mp_fail) {
+		if (mptcp_has_another_subflow(ssk)) {
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
+			while ((skb = skb_peek(&ssk->sk_receive_queue)))
+				sk_eat_skb(ssk, skb);
+		} else {
+			subflow->mp_fail_expect_echo = 1;
+		}
+		WRITE_ONCE(subflow->data_avail, 0);
+		return true;
+	}
+
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
-- 
2.31.1

