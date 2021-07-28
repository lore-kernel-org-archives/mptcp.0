Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8672
	for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 09:35:25 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id b6so4219687pji.4
        for <mptcp@lists.linux.dev>; Wed, 28 Jul 2021 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpvLXzUKAqdksn9FTjRMQk/to7BWTzvq5aueKkIBJxE=;
        b=YoQKG4Yk+1YqzJLCp5QNgPJzXKzVO5VMs2UXYGfRv/4dvhOrFe97A2eOYhC9m/Y66C
         STOW5f/DnEcITU/Uux3cWJdEzPE9uxKhkIImLygOgqNKTNpahvUJyE0RZluNa0tarRCW
         JIak+EV0BgrVsQmPxGLJdFGop8eWHkudH/M7e4OWbt//y85zNeZx2vaNkkV+HG+Jfj0K
         0tfju9w40qmg5A51WDBfyiwho8jIGBQJ4HXXz/16cDw3MkdfydRfapfI+FsCXjNuIIxm
         VXrq+To/WTqgmY5jwfMe4eb8jl9t4KRGHnnjTdAxSZ+sycGzMmKKh8PPWj6pvGeUgGuy
         d+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpvLXzUKAqdksn9FTjRMQk/to7BWTzvq5aueKkIBJxE=;
        b=j+9UeXyD9BuELTj8WgSSU6niA06cyd8qY22HbIJZeLBANgi8SCobxqtGZ5j8NTPm/R
         m9wjvPQ/3wBykQfvu2uDOrCzGFjUkbCV1Av2FWZrtrH3gQz7Wa5bv8G9k6cYpM6Jodon
         NhdUZRB6L24+q4/hO4H7fdMNg8sry5zD9AVHUXZkFKD0ipfQRaSOrbfseRFGY2OVvCRf
         IsvRl+hogTFs1UP8Y+gxPpz2EpwmyrIFPOr1cebda1i/6wFY9oP7EvEoex1pNSdE7drd
         fApSjCw2+WkZBdUGdTPBoGASLPg+EpkvYGi9ZgB8WjacdpErVicll6EksBCeKIic3ry3
         /XNw==
X-Gm-Message-State: AOAM531sUrZvbHtPnpyqloPPFe4hobwp+nUQakQ8WeeSwzuUxiBu7i6q
	wcnU1M0RZTU5QCKwCS4sWOJdFxp9JSs=
X-Google-Smtp-Source: ABdhPJw9KDexDxp9+4o284Qs4Y5brZAVdullNGOu0leUDGBwqXWHD7gOAOoghObzGnzt+e1mYx/hfw==
X-Received: by 2002:a62:79c2:0:b029:3a3:8e69:ca97 with SMTP id u185-20020a6279c20000b02903a38e69ca97mr4325194pfc.55.1627464925432;
        Wed, 28 Jul 2021 02:35:25 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id v10sm5312560pjd.29.2021.07.28.02.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 02:35:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v6 mptcp-next 3/5] mptcp: send out MP_FAIL when data checksum fails
Date: Wed, 28 Jul 2021 17:35:10 +0800
Message-Id: <19469d95c33169d6e4dd553394ab4466756ff001.1627464017.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
References: <cover.1627464017.git.geliangtang@xiaomi.com> <277ac1e6d1fde4c180eba3f1bb1846ea58679915.1627464017.git.geliangtang@xiaomi.com> <a39b8f2a49c2798d4ff80ed527cd8990e64f8def.1627464017.git.geliangtang@xiaomi.com>
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
index 6ab386ff3294..c2df5cc28ba1 100644
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
index 09d0e9406ea9..c46011318f65 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -434,6 +434,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		mp_fail_expect_echo : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
@@ -615,6 +616,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
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

