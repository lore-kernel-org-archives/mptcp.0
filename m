Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935445CB5
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453760; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CZbisGLQBClTomdOl37s56gmZbkxyiZpFqwtbX+M4Fey0XMtcGBpVPcclK4vjw5En190EROafTGvAdIOmpXkjcJlcc2ADL5Vh55nE6RtnaOV0YsWM1ixVg3tN2tmEu/6D1Zx2aEVa182dbl3kBk4y/zc+3Ea3UzrICjyZmqtFrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453760; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
	bh=ppfFb8p/8O9dbAZabMWGp/OiVD2Ku9RlmzYx+I9f110=; 
	b=cB1swd5bisr0VwVkPHEpYuIWczSTv9EpPyWXSB1angyNSgPtnWSBVgPDuSNZs8ohh6xf/jAj0bz21RaQJmZDxqjmdxnI3pBAEo5ncA1VfgoX0xVk3YcZ1+QuJWXKPsyogdIFBtQ3Ku+xJq0jvCUeABRkjn84K9SzFvlB0xvOdtM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453760;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ppfFb8p/8O9dbAZabMWGp/OiVD2Ku9RlmzYx+I9f110=;
	b=XF9dbnuob+5MUtt2tRLp/x16KlHSgBgqQmT92Sxuclc+9DuqOr/bRqY3IivMxrWA
	OG0dA2pVJ7N5tJpoGZY0VRzNMPqU5G7mg2WMrn+8dtmZutN2A0VeTs5BhmwLlsqllLk
	WeO5oTvp4HGqlH8TKEn0TsMazOa6xhoyebDPbLB8=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453759426593.4557057376785; Sun, 18 Sep 2022 00:29:19 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-10-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 09/11] Listener: Add received skb to msk
Date: Sun, 18 Sep 2022 00:28:51 +0200
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220917222853.2406-1-dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

Add the received skb on the listener side to msk and set flag mptfo to 1
to treat some parts only in MPTFO case.
This function is called from the functions presented in the one of the
patch of this serie (mptcp_add_skb helpers).

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/fastopen.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
index 149a4b1d3dac..1b9caf56e02f 100644
--- a/net/mptcp/fastopen.c
+++ b/net/mptcp/fastopen.c
@@ -107,3 +107,62 @@ void mptcp_treat_hshake_ack_fastopen(struct mptcp_sock=
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
--=20
2.25.1


