Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8070
	for <mptcp@lists.linux.dev>; Mon, 28 Jun 2021 04:29:24 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id cs1-20020a17090af501b0290170856e1a8aso1463437pjb.3
        for <mptcp@lists.linux.dev>; Sun, 27 Jun 2021 21:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m54x0HVDmaxOauQrqPLoASp592a00Wh5lH4Bi/c8WqU=;
        b=XXHvmUAQXRtJGdOOUBaN8H7GdZP820htkF/Xq982svxm6jnsw5p0b3tAl1e2K8Bxhs
         +TSwMo7bOfmZgqB0sm9JxN00eoj6C+nv4xXm3tzNNexxzQ0yX7CxeFE4gGEkqmdCuTJf
         Q2yiFR9H4mFkgShLMQD8x1Rnfk6MFGCgexnT2OFpd/NZ+ezFzHrdgZMB09E0NZXfEVs7
         QU8eWM5QLqA5AwqIT4FEM3xqr85iDl9bTuSBYO/kReNiljSFVbCaaCpcazEl4Q0rY8W+
         kTSCAllfpyxG+rPVN/g/1b3q9IVyEWfjLD6sdyUioVtD/ZWAlqO1NFyufXpq4c8eTYNk
         8m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m54x0HVDmaxOauQrqPLoASp592a00Wh5lH4Bi/c8WqU=;
        b=TqgsJe2YK7zjSTIWbyJqd9ipwc8XzsdpGl58UaDSem1NieY12f5ffpRSpU08Rg6+8W
         ZzaYzEcJ6tW4dFmc0WXbXJMwK4SZMNSvoe37WrnXjOJGwTefIlgXt+coSzfUcmxMiDEQ
         AtyHormE+S9b1o0WWiBwueF9eojj0EyoKbJbnwwyTZkCb4KaSaVfmGjxzUWZWZ4brNki
         9MQIAoUdPKoyS+41IzKJBYwNTDNTCR5qYIxdW/I2KWwbnGMGrZRp2+Dyn3C3jZPY2fsg
         +nX1aKUZ/wVFpg9zXyfX60n414AsYzl/irLeEjHqA/WcI8QuYotq7hHKQXxZnbmp2TNy
         Opvw==
X-Gm-Message-State: AOAM532MPPw0Vs7ovzFO/10nTGYpPb/aQJAXBjtcTFwW8VGvuBCN5Gck
	jFRFnpDrtbe8fvvpVkUs3I+MdCWnkJsGeg==
X-Google-Smtp-Source: ABdhPJyuziw1NaW+NudS20j7zMaHDTDakQinUDO8aAMohiaO7B5VCgOTLLcOtmQSbB0rEhrKaiIQWg==
X-Received: by 2002:a17:902:aa92:b029:127:a70e:3197 with SMTP id d18-20020a170902aa92b0290127a70e3197mr16436873plr.30.1624854564423;
        Sun, 27 Jun 2021 21:29:24 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id g8sm12837391pgo.10.2021.06.27.21.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:29:24 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v3 mptcp-next 6/8] mptcp: infinite mapping sending
Date: Mon, 28 Jun 2021 12:29:02 +0800
Message-Id: <0e01e10358c89896ad265d9b57cfe4995965e445.1624854005.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com> <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com> <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the infinite mapping sending logic.

Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
when echoing the MP_FAIL in mptcp_pm_mp_fail_received.

In mptcp_established_options_dss, if this flag is true, call the new
function mptcp_write_infinite_mapping to set the infiniting mapping and
sent it out.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/options.c  | 23 +++++++++++++++++++++--
 net/mptcp/pm.c       |  1 +
 net/mptcp/protocol.c |  1 +
 net/mptcp/protocol.h |  6 ++++++
 4 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9c2e122f1a6e..1fce6fddb6ab 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -572,8 +572,21 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 	}
 }
 
+static void mptcp_write_infinite_mapping(struct mptcp_subflow_context *subflow,
+					 struct mptcp_ext *ext)
+{
+	pr_debug("fail_seq=%llu", subflow->fail_seq);
+
+	if (ext->use_map) {
+		ext->data_seq = subflow->fail_seq;
+		ext->data_len = 0;
+		WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
+	}
+}
+
 static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 					  bool snd_data_fin_enable,
+					  bool snd_infinite_mapping_enable,
 					  unsigned int *size,
 					  unsigned int remaining,
 					  struct mptcp_out_options *opts)
@@ -589,7 +602,8 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
-	if (!skb || (mpext && mpext->use_map) || snd_data_fin_enable) {
+	if (!skb || (mpext && mpext->use_map) ||
+	    snd_data_fin_enable || snd_infinite_mapping_enable) {
 		unsigned int map_size = TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
 
 		if (mpext) {
@@ -603,6 +617,8 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 		dss_size = map_size;
 		if (skb && snd_data_fin_enable)
 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
+		if (skb && snd_infinite_mapping_enable)
+			mptcp_write_infinite_mapping(subflow, &opts->ext_copy);
 		ret = true;
 	}
 
@@ -811,6 +827,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	unsigned int opt_size = 0;
+	bool snd_infinite_mapping;
 	bool snd_data_fin;
 	bool ret = false;
 
@@ -831,9 +848,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 	}
 
 	snd_data_fin = mptcp_data_fin_enabled(msk);
+	snd_infinite_mapping = mptcp_infinite_mapping_enabled(msk);
 	if (mptcp_established_options_mp(sk, skb, snd_data_fin, &opt_size, remaining, opts))
 		ret = true;
-	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, &opt_size, remaining, opts)) {
+	else if (mptcp_established_options_dss(sk, skb, snd_data_fin, snd_infinite_mapping,
+					       &opt_size, remaining, opts)) {
 		ret = true;
 		if (opts->ext_copy.use_ack) {
 			if (mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 539fc2892191..1b3b815f1eca 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -257,6 +257,7 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 
 	if (!msk->pm.subflows) {
 		if (!subflow->mp_fail_need_echo) {
+			WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
 			subflow->send_mp_fail = 1;
 			subflow->fail_seq = fail_seq;
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 199a36fe4f69..f1d057ee5887 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2727,6 +2727,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->csum_reqd)
 		WRITE_ONCE(msk->csum_enabled, true);
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 7a49454c77a6..fff2f5021619 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -244,6 +244,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		snd_infinite_mapping_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
@@ -656,6 +657,11 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 	       READ_ONCE(msk->write_seq) == READ_ONCE(msk->snd_nxt);
 }
 
+static inline bool mptcp_infinite_mapping_enabled(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->snd_infinite_mapping_enable);
+}
+
 static inline bool mptcp_propagate_sndbuf(struct sock *sk, struct sock *ssk)
 {
 	if ((sk->sk_userlocks & SOCK_SNDBUF_LOCK) || ssk->sk_sndbuf <= READ_ONCE(sk->sk_sndbuf))
-- 
2.31.1

