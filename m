Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1D71840
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1649673626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uv2BSJlwNpSLP1os0v73gsDuNbUqAMg/sfTV5Q1HBdU=;
	b=PhSmnzqU/NVxwANQlShWgRvsWcs+pzVxY0izVMNyk4xfTPT5zA8/D5Og4CRu01w0wb8SE7
	MhDThAMEIIcdhWeEK7eQKIkYRoPUgU4UaExtfz/ahUaPudb/Dm5z4CJs7Y2Bt2fkRxzxVg
	20oWSuaQGbqUyCCDtLLGPIQDe9Es/KQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-a4Ubyb2APKWrBi3FvCS4Dg-1; Mon, 11 Apr 2022 06:40:25 -0400
X-MC-Unique: a4Ubyb2APKWrBi3FvCS4Dg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06B6686B8A3
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:25 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8425140E80E0
	for <mptcp@lists.linux.dev>; Mon, 11 Apr 2022 10:40:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [RFC PATCH 3/4] mptcp: never shrink offered window
Date: Mon, 11 Apr 2022 12:40:04 +0200
Message-Id: <ab1fd2897c57a50d7580950dbe6fb58006c04253.1649672265.git.pabeni@redhat.com>
In-Reply-To: <cover.1649672265.git.pabeni@redhat.com>
References: <cover.1649672265.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

As per RFC, the offered MPTCP-level window should never shrink.
While we currently track the right edge, we don't enforce the
above constraint on the wire.
Additionally, concurrent xmit on different subflows can end-up in
erroneous right edge update.
Address the above explicitly updating the announced window and
protecting the update with an additional atomic operation (sic)

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/mptcp.h   |  2 +-
 net/ipv4/tcp_output.c |  2 +-
 net/mptcp/options.c   | 57 +++++++++++++++++++++++++++++++++++++------
 3 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 877077b53200..5706d132713e 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -125,7 +125,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 			       struct mptcp_out_options *opts);
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
 
-void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
+void mptcp_write_options(__be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts);
 
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index c221f3bce975..edad33b9db11 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -444,7 +444,7 @@ struct tcp_out_options {
 	struct mptcp_out_options mptcp;
 };
 
-static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp,
+static void mptcp_options_write(__be32 *ptr, struct tcp_sock *tp,
 				struct tcp_out_options *opts)
 {
 #if IS_ENABLED(CONFIG_MPTCP)
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index e05d9458a025..ffc0292da041 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1224,20 +1224,61 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	return true;
 }
 
-static void mptcp_set_rwin(const struct tcp_sock *tp)
+static void mptcp_set_rwin(struct tcp_sock *tp, void *opt)
 {
 	const struct sock *ssk = (const struct sock *)tp;
-	const struct mptcp_subflow_context *subflow;
+	struct mptcp_subflow_context *subflow;
+	u64 ack_seq, rcv_wnd_old, rcv_wnd_new;
 	struct mptcp_sock *msk;
-	u64 ack_seq;
+	struct tcphdr *th;
+	u32 new_win;
+	u64 win;
 
 	subflow = mptcp_subflow_ctx(ssk);
 	msk = mptcp_sk(subflow->conn);
 
-	ack_seq = READ_ONCE(msk->ack_seq) + tp->rcv_wnd;
+	ack_seq = READ_ONCE(msk->ack_seq);
+	rcv_wnd_new = ack_seq + tp->rcv_wnd;
+
+	rcv_wnd_old = READ_ONCE(msk->rcv_wnd_sent);
+	if (after64(rcv_wnd_new, rcv_wnd_old)) {
+		u64 rcv_wnd;
 
-	if (after64(ack_seq, READ_ONCE(msk->rcv_wnd_sent)))
-		WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
+		for (;;) {
+			rcv_wnd = cmpxchg64(&msk->rcv_wnd_sent, rcv_wnd_old, rcv_wnd_new);
+
+			if (rcv_wnd == rcv_wnd_old)
+				break;
+			if (before64(rcv_wnd_new, rcv_wnd))
+				goto raise_win;
+			rcv_wnd_old = rcv_wnd;
+		};
+		return;
+	}
+
+	if (rcv_wnd_new != rcv_wnd_old) {
+
+raise_win:
+		th = opt - sizeof(struct tcphdr);
+		win = rcv_wnd_old - ack_seq;
+		tp->rcv_wnd = min_t(u64, win, U32_MAX);
+		new_win = tp->rcv_wnd;
+
+		/* Make sure we do not exceed the maximum possible
+		 * scaled window.
+		 */
+		if (unlikely(th->syn))
+			new_win = min(new_win, 65535U) << tp->rx_opt.rcv_wscale;
+		if (!tp->rx_opt.rcv_wscale &&
+		    sock_net(ssk)->ipv4.sysctl_tcp_workaround_signed_windows)
+			new_win = min(new_win, MAX_TCP_WINDOW);
+		else
+			new_win = min(new_win, (65535U << tp->rx_opt.rcv_wscale));
+
+		/* RFC1323 scaling applied */
+		new_win >>= tp->rx_opt.rcv_wscale;
+		th->window = htons(new_win);
+	}
 }
 
 u16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
@@ -1265,7 +1306,7 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 				 ~csum_unfold(mpext->csum));
 }
 
-void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
+void mptcp_write_options(__be32 *ptr, struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
 	const struct sock *ssk = (const struct sock *)tp;
@@ -1554,7 +1595,7 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 	}
 
 	if (tp)
-		mptcp_set_rwin(tp);
+		mptcp_set_rwin(tp, opts);
 }
 
 __be32 mptcp_get_reset_option(const struct sk_buff *skb)
-- 
2.35.1

