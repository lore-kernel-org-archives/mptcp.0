Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419D72
	for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 10:42:05 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso1441474pjp.2
        for <mptcp@lists.linux.dev>; Wed, 14 Jul 2021 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6JTaMoYaGbWh/w3jVVeH8Q60snFIChPGtsVQyH/21rE=;
        b=CFQYqaGOFP2OPqynQMdsySAqKM8qEAiPMVHfdKE1Eq28zM+5j4nFEiI0OckXxIbUoo
         LWSNfxzn3KuyUfZYg00dfR2KQi8EO2/MkSpbn+F/sr6U1L2LyZqGSOgroq/bCcQHUUnp
         tO+JNrQRUaWyoyh5HVG9+Qhil8M4/myI0rEAJcFQhocFX0WAu/6+BdP0HINnt2WmIl0n
         CXAj36Ta8hRvfc+Un3M6kuNVx5areNQY4SAO/hcHIp5OM9bQsQn3r2j8tafmxWqRDpDx
         noMabQFtt0jn+dXQioFpaBM/IduSgOsUpQ9mLydjfpRvia99FeFI/2lKMoBz/y0hrohO
         CtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6JTaMoYaGbWh/w3jVVeH8Q60snFIChPGtsVQyH/21rE=;
        b=NwaoeLmu8wl4KCiXQocBAA42CeoBS5+6WbzxJch+7eFBtK0HG59361PqWwEl0MyCSp
         Nkoy/7gagjIR7xhWKWLN47hrGM17FB0uLjKeF+5LyFDLM8I1160g1idWNeHQUl4ltSzN
         Aj+eikjVjzlJiIbq1Rc9XN7UFmV8nKfOkxp3/D06zwCkLgEPzsF+18dA96EoXpsVXP0B
         CqPSVSJlzoxCp0g46JQWEK20q+oUkJmGLyFWhH5/bX8AKLO3HOT6D/V2SNNzDwL7IavJ
         LIMwwpGsx5XKHxy5cYHMGXLF/xptD5tIefCEDnHW0Ck4vb9b/JqFHyYyn3r+glfz36K/
         ejKg==
X-Gm-Message-State: AOAM533VTnsoRKxDvcmApF2iqZa0wwmTEzh39cu3lRWoqOiZNJpxgaT9
	lkAPlL9XYG0cwX0cHBW7Jp+rqapG8MUFoA==
X-Google-Smtp-Source: ABdhPJxQI8Gv8KCqcIkQ88UYnFnLzLNjgw7NsjopsdF3lFPIJGBRtSDobobbfFyI7Z1OO4tuq35nvg==
X-Received: by 2002:a17:90b:3a89:: with SMTP id om9mr6822471pjb.91.1626259325380;
        Wed, 14 Jul 2021 03:42:05 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id x18sm2122904pfh.48.2021.07.14.03.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 03:42:05 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v4 mptcp-next 3/5] mptcp: send out MP_FAIL when data checksum fail
Date: Wed, 14 Jul 2021 18:41:55 +0800
Message-Id: <779edc1afc2f4622d9cffbdf3f8ccccfcdfd33cb.1626258797.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <c9b00f7ce8d17ea4fb6e60c09433f36cc144a2f7.1626258797.git.geliangtang@gmail.com>
References: <cover.1626258797.git.geliangtang@gmail.com> <d719e2be68d4f75b1cb392f67516261a59e94c5b.1626258797.git.geliangtang@gmail.com> <c9b00f7ce8d17ea4fb6e60c09433f36cc144a2f7.1626258797.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/protocol.h | 13 +++++++++++++
 net/mptcp/subflow.c  | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 20f8faf0543b..260920d26935 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -601,6 +601,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
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
index 966f777d35ce..11a719fad718 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -908,6 +908,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
+		subflow->send_mp_fail = 1;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
@@ -1155,6 +1156,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
 
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
+			WRITE_ONCE(subflow->data_avail, 0);
+			return true;
+		}
+	}
+
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
-- 
2.31.1

