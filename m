Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E23FC5
	for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 09:19:17 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so1650459pjr.1
        for <mptcp@lists.linux.dev>; Tue, 14 Sep 2021 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k/0zxrnKMI6u5AkUOalDui/GVJQaqxUSXoi4ldLgSC0=;
        b=jYs2x7JgyievlOKdzl/8o8KjMEUsi9oNmTZtd4c245KlEajBnRkU2yHlFFrlgxGYYe
         gE1gY/RIdIJXkYgSj6v6oIlkzXo+x42dW1QbBerwjM8BrRdb41O+Kny++w/c1/WlWfTF
         77ytgHZj7+nbQjASUKAAQynoEjHjC+v5LEPiXBsCqXrVhH/KltXNij7HER0u//CE7znd
         EFAOHYaIyJfwNkLDZWn2saJsocvJN8WloW3EtRtZ5uinCv3ugzOcdQS80D/WN2IWoGCU
         +JHfK6qVHyhpzNooXBXxTIIdhvnRwEx+q+8l0zCZytzvymCqJ6bmLJw2D1ba/R1NBjqU
         R+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k/0zxrnKMI6u5AkUOalDui/GVJQaqxUSXoi4ldLgSC0=;
        b=DBnIoTAO74Zw8GcAJ2wAxeFZtm/IdBZuMmoHCRnUZR0ZMHx8q8b4xI+qZERZK2KuJj
         62kTVfbGvRmLTt0R7eGSqWvidHWxpMDeAunQWUy88JDqCFm8uPjzguDVNMxXO3MZKm6v
         PrS4JbTc8Rh5EsDV+63oPPNS7xwv9U3Bh74Z16TderrdhfkDzWcGk0zCixVj3RKimgzF
         9OVo9tKYmpgIQDrCNRcO7XGL2n3r66tGi0eBxsNQ9bNvW5JgonriNGtHJEAZM244DeOs
         z0xuYH+2fwczSvlaNcBh7HDb5vySsvTKOkVePjizkJQUYWCLAMUMpeN9EcLOKiWgSf/B
         oKfg==
X-Gm-Message-State: AOAM533KcKMWDaEqf137AG48oMuxuyENxq3qp8GoQ5HqXWzWXtwWHyui
	qtO7wcu8NgtbMraDLmvUgRQlCc08FGE=
X-Google-Smtp-Source: ABdhPJws0pgzkzXvwodMD2uTkrlpoBwo3EuKrKFpl3PMIQkgiNhuQvV8GN7cS6GxeMuwT+G7jmCYKQ==
X-Received: by 2002:a17:90a:a386:: with SMTP id x6mr999462pjp.56.1631611156726;
        Tue, 14 Sep 2021 02:19:16 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id i21sm10851317pgn.93.2021.09.14.02.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 02:19:16 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH mptcp-next v3 1/8] mptcp: add mptcp_is_data_contiguous helper
Date: Tue, 14 Sep 2021 17:19:00 +0800
Message-Id: <3610b34039bb8e73cd2eecdbc43d5a0cfbc5d2da.1631610729.git.geliangtang@gmail.com>
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

This patch added a new member last_retrans_seq in the msk to track the
last retransmitting sequence number.

Add a new helper named mptcp_is_data_contiguous() to check whether the
data is contiguous on a subflow.

When a bad checksum is detected and a single contiguous subflow is in
use, don't send RST + MP_FAIL, send data_ack + MP_FAIL instead.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.c |  3 +++
 net/mptcp/protocol.h |  6 ++++++
 net/mptcp/subflow.c  | 12 ++++++------
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ff574d62073f..71a5427609a9 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2464,6 +2464,7 @@ static void __mptcp_retrans(struct sock *sk)
 		dfrag->already_sent = max(dfrag->already_sent, info.sent);
 		tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
 			 info.size_goal);
+		msk->last_retrans_seq = dfrag->data_seq;
 	}
 
 	release_sock(ssk);
@@ -2889,6 +2890,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	msk->snd_una = msk->write_seq;
 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
+	msk->last_retrans_seq = subflow_req->idsn - 1;
 
 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
 		msk->can_ack = true;
@@ -3145,6 +3147,7 @@ void mptcp_finish_connect(struct sock *ssk)
 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
 	WRITE_ONCE(msk->can_ack, 1);
 	WRITE_ONCE(msk->snd_una, msk->write_seq);
+	WRITE_ONCE(msk->last_retrans_seq, subflow->idsn - 1);
 
 	mptcp_pm_new_connection(msk, ssk, 0);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d516fb6578cc..eb3473d128d4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -227,6 +227,7 @@ struct mptcp_sock {
 	u64		ack_seq;
 	u64		rcv_wnd_sent;
 	u64		rcv_data_fin_seq;
+	u64		last_retrans_seq;
 	int		wmem_reserved;
 	struct sock	*last_snd;
 	int		snd_burst;
@@ -625,6 +626,11 @@ static inline bool mptcp_has_another_subflow(struct sock *ssk)
 	return false;
 }
 
+static inline bool mptcp_is_data_contiguous(struct mptcp_sock *msk)
+{
+	return before64(msk->last_retrans_seq, msk->snd_una);
+}
+
 void __init mptcp_proto_init(void);
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 int __init mptcp_proto_v6_init(void);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1de7ce883c37..b07803ed3053 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1166,15 +1166,15 @@ static bool subflow_check_data_avail(struct sock *ssk)
 fallback:
 	/* RFC 8684 section 3.7. */
 	if (subflow->send_mp_fail) {
-		if (mptcp_has_another_subflow(ssk)) {
+		if (mptcp_has_another_subflow(ssk) || !mptcp_is_data_contiguous(msk)) {
+			ssk->sk_err = EBADMSG;
+			tcp_set_state(ssk, TCP_CLOSE);
+			subflow->reset_transient = 0;
+			subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+			tcp_send_active_reset(ssk, GFP_ATOMIC);
 			while ((skb = skb_peek(&ssk->sk_receive_queue)))
 				sk_eat_skb(ssk, skb);
 		}
-		ssk->sk_err = EBADMSG;
-		tcp_set_state(ssk, TCP_CLOSE);
-		subflow->reset_transient = 0;
-		subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
-		tcp_send_active_reset(ssk, GFP_ATOMIC);
 		WRITE_ONCE(subflow->data_avail, 0);
 		return true;
 	}
-- 
2.31.1

