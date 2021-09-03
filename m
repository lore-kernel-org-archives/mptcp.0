Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C862FAE
	for <mptcp@lists.linux.dev>; Fri,  3 Sep 2021 08:15:26 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id v123so3709018pfb.11
        for <mptcp@lists.linux.dev>; Fri, 03 Sep 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H52ZY+T5yNNgvSfOu6It6vN6CbQvCRfpMC6u2KrwYTM=;
        b=jL0aKNkLWmwgLpAQLMjEID7QC3TUZIntB//B6hdkG1S3Zo3l9K6HyrPebSseKMHJyq
         ASgH0mFCFbWtIY6Um5ptnXn4aWClTVMg1jou1F75Pf4F6s2b2ujrotIOpigZwZsBPeOl
         RGnoNT5qHyleLwX9JQ963Id8fIYy+IE6CTyj4V3PG00rWwgcrYV0WlWVp1zJuLTqvxoz
         gnC7twomBnEqDHo46ASjUtvCOsA+QGMUh7QrLV/eFIwvAOn+JzS9NofF4TuI79zRL9xG
         ZYXQ7aTq9TGfuD3hHqrQs30yRxpK1rrXaAZHWg13RXQWfatg3nD+o7f3UnqwDfQP+mdf
         dDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H52ZY+T5yNNgvSfOu6It6vN6CbQvCRfpMC6u2KrwYTM=;
        b=ps5GSg9o0gdQvKpN+Aj9apNWVjEaElNmXkgGcphOFl3VrsQixZxgJp8zEiBiQGhJX3
         T+2/rjiQYEuEabDCQyOBYnd1l6C+wDpeSUqByEnCFm3h66cNSyjskOJVyENXtRacAwKZ
         yW+cNvAt0FnKc/sKkwRHjFxHTMZ5mUH63PaaW9+Ip+vDwg9Elf70nh0JVpzqZS9K8jNo
         OwrGmrwVkKG76yiULA9nBIJrOBiXN0DhJgZ2ohvOQdUycX2XHYOHxc+MSuWeXby4PPjF
         xeOZcpCWg/unTqpcMfPlpiEBvuq8bcuUyd+XiNOOFV7+qvHrqHXbfwvbIkJ5kyhqM/Wa
         KrTA==
X-Gm-Message-State: AOAM530r5FI3Lx4k2/UYvVdbBvL2GJoKn/htwIaAcQ11Lr6IXukR74A5
	mfgt5wO7v4VMjEmSxoukk3LatqLi3J4=
X-Google-Smtp-Source: ABdhPJzU/l2xJfJzv9HvQ1DohZmiKL1XzXOBZ0cdh4lCakWY705ckU4pKUgUakAyeMmlssMSb9QW1w==
X-Received: by 2002:a05:6a00:26c8:b0:3f9:e5a9:92a8 with SMTP id p8-20020a056a0026c800b003f9e5a992a8mr2415248pfw.63.1630656925803;
        Fri, 03 Sep 2021 01:15:25 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id j6sm5254452pgq.0.2021.09.03.01.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 01:15:25 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH RFC 2/5] mptcp: infinite mapping sending
Date: Fri,  3 Sep 2021 16:15:10 +0800
Message-Id: <7d43c0b1c5f336641d9c8edef80cd0e37b93b668.1630656206.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com>
References: <cover.1630656206.git.geliangtang@xiaomi.com> <c9504a9a84a501016ddc53ebbf644f827233b7e0.1630656206.git.geliangtang@xiaomi.com>
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
when a single subflow is in use in mptcp_pm_mp_fail_received.

In mptcp_sendmsg_frag, if this flag is true, call the new function
mptcp_update_infinite_mapping to set the infinite mapping.

In mptcp_write_options, send out the infinite mapping and fallback to
a regular TCP.

Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 net/mptcp/options.c  | 13 +++++++++++++
 net/mptcp/pm.c       |  6 ++++++
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 4 files changed, 41 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 1ec6529c4326..e2df21246be7 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1326,6 +1326,19 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 				put_unaligned_be32(mpext->data_len << 16 |
 						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
 			}
+
+			if (mpext->data_len == 0) {
+				const struct sock *ssk = (const struct sock *)tp;
+				struct mptcp_subflow_context *subflow;
+				struct mptcp_sock *msk;
+
+				subflow = mptcp_subflow_ctx(ssk);
+				msk = mptcp_sk(subflow->conn);
+
+				pr_debug("write infinite mapping!");
+				pr_fallback(msk);
+				__mptcp_do_fallback(msk);
+			}
 		}
 	} else if ((OPTION_MPTCP_MPC_SYN | OPTION_MPTCP_MPC_SYNACK |
 		    OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6ab386ff3294..39f2dcda53bf 100644
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
+	if (!mptcp_has_another_subflow(sk))
+		WRITE_ONCE(msk->snd_infinite_mapping_enable, true);
 }
 
 /* path manager helpers */
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index faf6e7000d18..dd7738a6b7f5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1282,6 +1282,22 @@ static void mptcp_update_data_checksum(struct sk_buff *skb, int added)
 	mpext->csum = csum_fold(csum_block_add(csum, skb_checksum(skb, offset, added, 0), offset));
 }
 
+static void mptcp_update_infinite_mapping(struct mptcp_sock *msk, struct mptcp_ext *mpext)
+{
+	if (!mpext)
+		return;
+
+	mpext->data_seq = READ_ONCE(msk->ack_seq);
+	mpext->data_len = 0;
+	if (READ_ONCE(msk->csum_enabled))
+		mpext->csum = 0;
+
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
+
+	pr_debug("infinite mapping: data_seq=%llu subflow_seq=%u data_len=%u dsn64=%d",
+		 mpext->data_seq, mpext->subflow_seq, mpext->data_len, mpext->dsn64);
+}
+
 static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 			      struct mptcp_data_frag *dfrag,
 			      struct mptcp_sendmsg_info *info)
@@ -1390,6 +1406,10 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 out:
 	if (READ_ONCE(msk->csum_enabled))
 		mptcp_update_data_checksum(tail, ret);
+
+	if (READ_ONCE(msk->snd_infinite_mapping_enable))
+		mptcp_update_infinite_mapping(msk, mpext);
+
 	mptcp_subflow_ctx(ssk)->rel_write_seq += ret;
 	return ret;
 }
@@ -2858,6 +2878,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
 		WRITE_ONCE(msk->csum_enabled, true);
+	WRITE_ONCE(msk->snd_infinite_mapping_enable, false);
 
 	msk->write_seq = subflow_req->idsn + 1;
 	msk->snd_nxt = msk->write_seq;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 99a23fff7b03..33400fcdf1b1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -246,6 +246,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		snd_infinite_mapping_enable;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
-- 
2.31.1

