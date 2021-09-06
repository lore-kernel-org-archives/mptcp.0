Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298093FC1
	for <mptcp@lists.linux.dev>; Mon,  6 Sep 2021 07:58:16 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id e16so5023695pfc.6
        for <mptcp@lists.linux.dev>; Mon, 06 Sep 2021 00:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DVBdfXA4zfpgg+g2/KHcZC8I3yZ20VtSUV6QaLJfwlo=;
        b=f2bdfcde6c1C4qqE2rDUh1LksAqCucgbvDWjxDh8z5RJ6rHYOPoFId2ejjB2VSlU36
         IWgw4ItwhWaPreDtHkfVP9NBF2u9OqVIYTpPUfenWPUHK+ACBokeBCTBsCD+olnNbpHJ
         VwRnK7LWrgW+jsC8vdeRwdn96fgERc9uzkZhzHtcDK82brqH907ZFV8VTCqVhh+PeXP/
         Tm9NgL1Bh7JwKUx6z1zI3BLaxHX6b2bEVpK9QaUFHin82Bzq/DWVK8z7lxI7HdoxgYxC
         e/Xf0bURXzTXtPDJOoUrZf+FQMzJsUtHPOJz+OlMpEAw/8DAKBa3uzkt25trUzroGvgU
         QCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DVBdfXA4zfpgg+g2/KHcZC8I3yZ20VtSUV6QaLJfwlo=;
        b=bNz7QOO3HjT/RMc9oZ5MlWQHO/WY9ruKtRaRDyuIPjDutlT6etAKz1LxsZDekkBfD+
         0ApLAwp356VYpgAr6YhlrmWFmoZQo+SiX6WR0FbVKB/uZDsz0yChHhiJ2FjuvpIR4dSB
         zQERLyi/fBZu/Z7gxtmNEDIIjts1G/Mh1Sf6zuoy3fwtHx6JNGrQ7Mi54Dvq0EfYz7KU
         Q5NMKFSUHyvuW8dlSMqy9uG66tr2QN6CFRQmAPXNRCKZSNlx/s1h2Fc4bpWs3bGclsiJ
         wgRNkrV5S/irqGdK0uIxNFulKwbjQsxjhefho4Sk7b84z75m/ZaZyZe6DpJ+cIvD5QYy
         7CKA==
X-Gm-Message-State: AOAM530ue1kZJ5xNPPhLLZPV2wI8CAOhB14gCuuLyjIRimG4vhfqgrJo
	mVmIIofizYqdBGpXiJQkuLv8W9TT4DY=
X-Google-Smtp-Source: ABdhPJyU76NEIT0KhB9klmVA0TN9ji15mMr0bOkmsOeCRR++r6tidXuQW/eL+MFMRr+H3A9vGYqGyA==
X-Received: by 2002:a05:6a00:2d4:b0:409:6830:f66d with SMTP id b20-20020a056a0002d400b004096830f66dmr10678878pft.54.1630915095587;
        Mon, 06 Sep 2021 00:58:15 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id c24sm6895702pfd.145.2021.09.06.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:58:15 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [PATCH mptcp-next 2/6] mptcp: infinite mapping sending
Date: Mon,  6 Sep 2021 15:58:03 +0800
Message-Id: <d2a098e248e92789c647d6e81f4cb9353edf8eba.1630914699.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1630914699.git.geliangtang@xiaomi.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

This patch added the infinite mapping sending logic.

Added a new flag snd_infinite_mapping_enable in mptcp_sock. Set it true
when a single contiguous subflow is in use in mptcp_pm_mp_fail_received.
In mptcp_sendmsg_frag, if this flag is true, call the new function
mptcp_update_infinite_mapping to set the infinite mapping.

Added a new flag infinite_mapping_snd in struct mptcp_subflow_context.
In mptcp_write_options, if the infinite mapping has been sent, set this
flag.

In subflow_check_data_avail, if the infinite_mapping_snd flag is
set, don't reset this subflow.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/options.c  |  8 ++++++++
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 15 +++++++++++++++
 net/mptcp/protocol.h |  2 ++
 net/mptcp/subflow.c  |  4 +++-
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 422f4acfb3e6..09768cacd2a8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1325,6 +1325,14 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
 		}
+
+		if (mpext->data_len == 0) {
+			const struct sock *ssk = (const struct sock *)tp;
+			struct mptcp_subflow_context *subflow;
+
+			subflow = mptcp_subflow_ctx(ssk);
+			subflow->infinite_mapping_snd = 1;
+		}
 	} else if (OPTIONS_MPTCP_MPC & opts->suboptions) {
 		u8 len, flag = MPTCP_CAP_HMAC_SHA256;
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..2830adf64f79 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,7 +251,13 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
 
 void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 {
+	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+
 	pr_debug("fail_seq=%llu", fail_seq);
+
+	if (!mptcp_has_another_subflow(sk) && !READ_ONCE(msk->noncontiguous))
+		WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 553082eb1206..3082eb367df2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1274,6 +1274,18 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->data_len = 0;
+	if (READ_ONCE(msk->csum_enabled))
+		mpext->csum = 0;
+
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1406,6 +1418,8 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(skb, copy);
+	if (READ_ONCE(msk->snd_infinite_mapping_enable))
+		mptcp_update_infinite_mapping(msk, mpext);
 	mptcp_subflow_ctx(ssk)->rel_write_seq += copy;
 	return copy;
 }
@@ -2877,6 +2891,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
 	WRITE_ONCE(msk->noncontiguous, false);
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 29322e09e7d6..a058af61cf7c 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,7 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	bool		noncontiguous;
+	bool		snd_infinite_mapping_enable;
 	spinlock_t	join_list_lock;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
@@ -433,6 +434,7 @@ struct mptcp_subflow_context {
 		backup : 1,
 		send_mp_prio : 1,
 		send_mp_fail : 1,
+		infinite_mapping_snd : 1,
 		rx_eof : 1,
 		can_ack : 1,        /* only after processing the remote a key */
 		disposable : 1,	    /* ctx can be free at ulp release time */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 951aafb6021e..87f42ba7c09c 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1179,7 +1179,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		return true;
 	}
 
-	if (subflow->mp_join || subflow->fully_established) {
+	if (subflow->mp_join ||
+	    (subflow->fully_established &&
+	     !subflow->infinite_mapping_snd)) {
 		/* fatal protocol error, close the socket.
 		 * subflow_error_report() will introduce the appropriate barriers
 		 */
-- 
2.31.1

