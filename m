Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B06AA5
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286187; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YIxnShrQYBJ+/qGtV8NQxYXRkMVqymdfe0D4EzLG25j5jUF3hxtREtQotmVtlg3s6vdsPsy3W5I18T6W1QyZXvWtQyXezl0M3WcnmzV/A7X0sAIJZf0yHztdY3qhV0QPFDEhpQSkdXHgtIdP/JC+1KojNpOxd4iIK2w0GT3yfJI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286187; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=2/14IFbo3tjcxNiL9UtorWiaWMb2qFnUucq3XpD0JG0=; 
	b=G+BZu6GZwgQsJ5XlMT5SpLJHG8F5Ce0rrrloqdYp0dwE4bbRPn07txNaMOZQKygUMQQRgVGba5lbhKAk14BZWFA6srY88XwQ75r5MWf7Y9Tl+UwhaTgD0seXBXS8CkJb97BfVc+RAq33nLEJH6dhVoqVp5hHOXH2+1+qQNpbmAE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286187;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2/14IFbo3tjcxNiL9UtorWiaWMb2qFnUucq3XpD0JG0=;
	b=T5C7d0CuhEP1n85ZlvFXUWvmHznzK7jOmcZlZ6dDnFsR+1jjwbEzwS2zhxYV3brS
	zxwuteYCmkD8Wc3beRqeub39roC3DoFMqMU1BgB8NaDD6ZB+xGIIKvqaIxK2tcaTzpt
	A89vPkj5IFnudLvyF6HfSRmsHFK43vNekKWQE1i4=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166328618544369.14989025115233; Fri, 16 Sep 2022 01:56:25 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-8-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 7/9] Listener: Add received skb to msk
Date: Fri, 16 Sep 2022 01:56:02 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915235604.26018-1-dmytro@shytyi.net>
References: <20220915235604.26018-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Add the received skb on the listener side to msk and set flag mptfo to 1=20
to treat some parts only in MPTFO case.=20
This function is called from the functions presented in the one of the=20
patch of this serie (mptcp_add_skb helpers).

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h | 43 +++++++++++++++++++++++++++++
 net/mptcp/subflow.c  |  2 +-
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 149a4b1d3dac..7070d2a966c9 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -107,3 +107,68 @@ void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock=
 *msk, struct mptcp_subflo
 =09=09atomic64_set(&msk->rcv_wnd_sent, ack_seq);
 =09}
 }
+
+void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb, struct r=
equest_sock *req)
+{
+=09struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
+=09struct tcp_request_sock *tcp_r_sock =3D tcp_rsk(req);
+=09struct sock *socket =3D mptcp_subflow_ctx(sk)->conn;
+=09struct mptcp_sock *msk =3D mptcp_sk(socket);
+=09struct tcp_sock *tp =3D tcp_sk(sk);
+
+=09if (TCP_SKB_CB(skb)->end_seq =3D=3D tp->rcv_nxt)
+=09=09return;
+
+=09skb =3D skb_clone(skb, GFP_ATOMIC);
+=09if (!skb)
+=09=09return;
+
+=09skb_dst_drop(skb);
+
+=09tp->segs_in =3D 0;
+=09tcp_segs_in(tp, skb);
+=09__skb_pull(skb, tcp_hdrlen(skb));
+=09sk_forced_mem_schedule(sk, skb->truesize);
+
+=09TCP_SKB_CB(skb)->seq++;
+=09TCP_SKB_CB(skb)->tcp_flags &=3D ~TCPHDR_SYN;
+
+=09tp->rcv_nxt =3D TCP_SKB_CB(skb)->end_seq;
+
+=09msk->is_mptfo =3D 1;
+
+=09//Solves: WARNING: at 704 _mptcp_move_skbs_from_subflow+0x5d0/0x651
+=09tp->copied_seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+
+=09TCP_SKB_CB(skb)->seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+=09TCP_SKB_CB(skb)->end_seq =3D TCP_SKB_CB(skb)->seq;
+
+=09TCP_SKB_CB(skb)->seq +=3D tp->rcv_nxt - tcp_r_sock->rcv_isn - 1;
+=09TCP_SKB_CB(skb)->end_seq =3D  TCP_SKB_CB(skb)->seq;
+
+=09subflow->map_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
+
+=09//Solves: BAD mapping: ssn=3D0 map_seq=3D1 map_data_len=3D3
+=09subflow->ssn_offset =3D tp->copied_seq - 1;
+
+=09skb_ext_reset(skb);
+
+=09//mptcp_set_owner_r begin
+=09skb_orphan(skb);
+=09skb->sk =3D socket;
+=09skb->destructor =3D mptcp_rfree;
+=09atomic_add(skb->truesize, &socket->sk_rmem_alloc);
+=09msk->rmem_fwd_alloc -=3D skb->truesize;
+=09//mptcp_set owner_r end
+
+=09__skb_queue_tail(&msk->receive_queue, skb);
+
+=09atomic64_set(&msk->rcv_wnd_sent, mptcp_subflow_get_mapped_dsn(subflow))=
;
+
+=09tp->syn_data_acked =3D 1;
+
+=09tp->bytes_received =3D skb->len;
+
+=09if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
+=09=09tcp_fin(sk);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c364616c2d56..815d1bc6c6f2 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -852,6 +852,49 @@ int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_soc=
k *msk, sockptr_t optval,
 =09=09=09=09      unsigned int optlen);
 void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock *msk, struct mptcp_=
subflow_context *subflow,
 =09=09=09=09     struct mptcp_options_received mp_opt);
+void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subf=
low_context *subflow,
+=09=09=09=09 struct mptcp_options_received mp_opt);
+void mptcp_treat_3d_ack_fastopen(struct mptcp_sock *msk, struct mptcp_subf=
low_context *subflow,
+=09=09=09=09 struct mptcp_options_received mp_opt);
+void mptcp_fastopen_add_skb(struct sock *sk, struct sk_buff *skb,
+=09=09=09    struct request_sock *req);
+void mptcp_reqsk_record_syn(const struct sock *sk,
+=09=09=09    struct request_sock *req,
+=09=09=09    const struct sk_buff *skb);
+void mptcp_ecn_create_request(struct request_sock *req,
+=09=09=09      const struct sk_buff *skb,
+=09=09=09      const struct sock *listen_sk,
+=09=09=09      const struct dst_entry *dst);
+void mptcp_openreq_init(struct request_sock *req,
+=09=09=09const struct tcp_options_received *rx_opt,
+=09=09=09struct sk_buff *skb, const struct sock *sk);
+struct sock *mptcp_fastopen_create_child(struct sock *sk,
+=09=09=09=09=09 struct sk_buff *skb,
+=09=09=09=09=09 struct request_sock *req);
+bool mptcp_fastopen_queue_check(struct sock *sk);
+bool mptcp_fastopen_cookie_gen_cipher(struct request_sock *req,
+=09=09=09=09      struct sk_buff *syn,
+=09=09=09=09      const siphash_key_t *key,
+=09=09=09=09      struct tcp_fastopen_cookie *foc);
+void mptcp_fastopen_cookie_gen(struct sock *sk,
+=09=09=09       struct request_sock *req,
+=09=09=09       struct sk_buff *syn,
+=09=09=09       struct tcp_fastopen_cookie *foc);
+int mptcp_fastopen_cookie_gen_check(struct sock *sk,
+=09=09=09=09    struct request_sock *req,
+=09=09=09=09    struct sk_buff *syn,
+=09=09=09=09    struct tcp_fastopen_cookie *orig,
+=09=09=09=09    struct tcp_fastopen_cookie *valid_foc);
+bool mptcp_fastopen_no_cookie(const struct sock *sk,
+=09=09=09      const struct dst_entry *dst,
+=09=09=09      int flag);
+struct sock *mptcp_try_fastopen(struct sock *sk, struct sk_buff *skb,
+=09=09=09=09struct request_sock *req,
+=09=09=09=09struct tcp_fastopen_cookie *foc,
+=09=09=09=09const struct dst_entry *dst);
+int mptcp_conn_request(struct request_sock_ops *rsk_ops,
+=09=09       const struct tcp_request_sock_ops *af_ops,
+=09=09       struct sock *sk, struct sk_buff *skb);
 // Fast Open Mechanism functions end
=20
 static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 075c61d1d37f..ff5fe4ff3d21 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -542,7 +542,7 @@ static int subflow_v4_conn_request(struct sock *sk, str=
uct sk_buff *skb)
 =09if (skb_rtable(skb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
 =09=09goto drop;
=20
-=09return tcp_conn_request(&mptcp_subflow_request_sock_ops,
+=09return mptcp_conn_request(&mptcp_subflow_request_sock_ops,
 =09=09=09=09&subflow_request_sock_ipv4_ops,
 =09=09=09=09sk, skb);
 drop:
--=20
2.25.1


