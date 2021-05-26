Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D032FB2
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:40 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id w12so2224091edx.1
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NWtoFOgkqhrjKC1PZ/5woHNifTuxnBnpaiOnfkbriws=;
        b=E4+Pt+yTCO0dcXaDqVqJ1PVcGaQVYELyuZaxGrh8g4rgkpznizdAtk1BC1GKUmXre3
         uLOHwXdFdmo0+dwoAOEnzDVLhKdDQ6l3Vww94FgaLQMPU7zrhc8ocBoZEBkS7xQgXe8U
         FOJuxiWBO4SqG46EJICpxFhnv9o5zM+cePtlbMdLSVedca0WHTLfzuZUWC0K7JjbnQZu
         hIWI+rs3NGrcjGf96btYcQBuFF8FyagjB6AxxXyYXNCWStTKZ+cSfAoilA7NypaPVbvn
         poAihJNVg8R76uoPKe15rxjmd/rOnu05SJLhfrSSFmc2pBhOCF1JhAfw4cmPblDinkBH
         rKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NWtoFOgkqhrjKC1PZ/5woHNifTuxnBnpaiOnfkbriws=;
        b=QuXrS/hMNfYY51+6wASZy1pOiPuGgR5Y1WGcRW7GJYTNUAJkzDfkY1FGls7IaEVIKh
         fCk0GndC5ZncRws9DvsP/APnGfnT8YvYLo4NDEy18T54RQX0o3Kj5lhARnramnHkZkby
         wMY3hPNimtWMOpJcmJ89yyd3x957EYO+npztxKlrRqtRlN+eBJYBKSomVszDUZYNF4f9
         +CU3iL1rCzmyH7BTQT89NbBkCJtfMkHxpyQZFbtWE/Hwd8iAYYflI9eqcfZ+GRlR0hIM
         pvhTliL/WAWPpBlUP9PJMZVcta4mK9+OSfw/Xa7FOD2Qtmo9elC6L8v/qAMnLr5BqUcx
         rdLg==
X-Gm-Message-State: AOAM530HOLccJ7VA96KT16fRnrhPKwc8h8g8RsdzIVdQn5cx3y3OqUa3
	y0HnjKBZyIuF0bPClyTxHXTw78CIkdVRGt9y
X-Google-Smtp-Source: ABdhPJzaSR9N11vg1emooWUvpnv55FK1HIsDdAr1mFlBRzQXJIXFQg3WeEsuMxc0PJES6h9o5zQd8g==
X-Received: by 2002:a05:6402:35c5:: with SMTP id z5mr39914410edc.210.1622045318625;
        Wed, 26 May 2021 09:08:38 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:38 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Subject: [RESEND] [MPTCP] [PATCH MPTCP 5/5] mptcp: send fastclose if userspace closes socket with unread data
Date: Wed, 26 May 2021 18:08:10 +0200
Message-ID: <20201105170126.5627-6-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160810.AQGZaK36PMDV5E686aHcYoQ1voldKfI3QvSTKQR_3rw@z>

From: Florian Westphal <fw@strlen.de>

Add building & sending of FASTCLOSE option.
RFC 8684 describes two methods:

A): Host sends an ACK containing the MP_FASTCLOSE
    option on one subflow [..] On all the other subflows,
    Host A sends a regular TCP RST to close these subflows and tears
    them down. [..]

R): Host A sends a RST containing the MP_FASTCLOSE option on all
    subflows [..].  Host A can tear down the subflows and the
    connection immediately.

This implements option R) only: All subflows are re-set with FASTCLOSE.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/mptcp/options.c  | 35 +++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c | 32 +++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h |  1 +
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 0a940687f738..08b60d527de0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -681,6 +681,31 @@ static bool mptcp_established_options_rm_addr(struct sock *sk,
 	return true;
 }
 
+static bool mptcp_fastclose(const struct mptcp_sock *msk)
+{
+	return READ_ONCE(msk->snd_fastclose);
+}
+
+static bool mptcp_established_options_fastclose(struct sock *sk,
+						unsigned int *size,
+						unsigned int remaining,
+						struct mptcp_out_options *opts)
+{
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
+
+	if (likely(!mptcp_fastclose(mptcp_sk(subflow->conn))))
+		return false;
+
+	if (remaining < TCPOLEN_MPTCP_FASTCLOSE)
+		return false;
+
+	*size = TCPOLEN_MPTCP_FASTCLOSE;
+	opts->suboptions |= OPTION_MPTCP_FASTCLOSE;
+	opts->rcvr_key = subflow->remote_key;
+
+	return true;
+}
+
 static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_buff *skb,
 						   unsigned int *size,
 						   unsigned int remaining,
@@ -691,6 +716,9 @@ static noinline void mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	if (remaining < TCPOLEN_MPTCP_RST)
 		return;
 
+	if (mptcp_established_options_fastclose(sk, size, remaining, opts))
+		return;
+
 	*size = TCPOLEN_MPTCP_RST;
 	opts->suboptions |= OPTION_MPTCP_RST;
 	opts->reset_transient = subflow->reset_transient;
@@ -1179,6 +1207,13 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 		ptr += 5;
 	}
 
+	if (OPTION_MPTCP_FASTCLOSE & opts->suboptions) {
+		*ptr++ = mptcp_option(MPTCPOPT_MP_FASTCLOSE,
+				      TCPOLEN_MPTCP_FASTCLOSE, 0, 0);
+		put_unaligned_be64(opts->rcvr_key, ptr);
+		ptr += 2;
+	}
+
 	if (OPTION_MPTCP_RST & opts->suboptions)
 		*ptr++ = mptcp_option(MPTCPOPT_RST,
 				      TCPOLEN_MPTCP_RST,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7e9705943813..6b6efa00cad5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2133,6 +2133,29 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 	}
 }
 
+static void __mptcp_send_fastclose(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow, *tmp;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	WRITE_ONCE(msk->snd_fastclose, true);
+
+	__mptcp_flush_join_list(msk);
+	__mptcp_clear_xmit(sk);
+
+	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
+
+	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
+		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
+
+		lock_sock(tcp_sk);
+		subflow->reset_transient = 0;
+		subflow->reset_reason = MPTCP_RST_EMPTCP;
+		mptcp_subflow_reset(tcp_sk);
+		release_sock(tcp_sk);
+	}
+}
+
 static void __mptcp_wr_shutdown(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2185,6 +2208,7 @@ static void mptcp_close(struct sock *sk, long timeout)
 {
 	struct mptcp_subflow_context *subflow;
 	bool do_cancel_work = false;
+	bool send_fin = false;
 
 	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
@@ -2197,7 +2221,13 @@ static void mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_close_state(sk))
+	send_fin = mptcp_close_state(sk);
+	if (!skb_queue_empty(&sk->sk_receive_queue)) {
+		__mptcp_send_fastclose(sk);
+		send_fin = false;
+	}
+
+	if (send_fin)
 		__mptcp_wr_shutdown(sk);
 
 	sk_stream_wait_close(sk, timeout);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d4c99e091cb9..93352044bff9 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -243,6 +243,7 @@ struct mptcp_sock {
 	bool		fully_established;
 	bool		rcv_data_fin;
 	bool		snd_data_fin_enable;
+	bool		snd_fastclose;
 	bool		rcv_fastclose;
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	spinlock_t	join_list_lock;
