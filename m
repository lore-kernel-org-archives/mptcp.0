Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793082489;
	b=Sds6CqylYDhm7M7QILRjxMbNgsafcyaH/R9j3UtDpNVL2cwGlrWP2HjsW3KGFznfH8T6
	 32KRIhJ85bqH8qcE625EJOQ+70DqyJ/PWKfkd3Mb8PBlWVXOAq4sY6hiGByFmPV1Cv+Su
	 KDZqqptJiqnsWPIflBiBSTXujyJo/l2p9XHZBjNGYrB1bzAvmhQWvF5sWCEbMcBq3QVht
	 nCSf3A6SDrjiFASC+dGK81U6TIz/ulSFrAfnuCswNKm0cCypEjUpLNFU7mir5gjDt2fwS
	 FIg9n4Um5DluzFWEcqx7RfXXQSod3cuHZE1EGY9YotwUWjznHzQC6U2oXxgMeY/zsdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082489;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient;
	bh=gB1yuYaeMIHij6RVao4q4xxDZCCgJQrom3+PlOynyWw=;
	b=ppc4o0AmBZ1KJpindufrhBMEG9bripBC2TLApoemXxJ6ME3rpaAQDLNK9oUyvP0v3IBN
	 qtv+/1W3Y7EzPUtk6vvT543vFBrUpn9/52t16+lQPlqzJtN8EDF8MlhFufnIV+5tfv+DW
	 SvWFoW0/J1hzFA0h7AcgklojhH/fn1oH/whI60uuDAPu8toJGQS6kZbwP/6I4Y3BHaJp5
	 5ZhQpbgwJHy4kLEAqQNc5u4DYd6sJxL2OUoE0MeubX1wa3rxf+fB5Ce30T9UO85spFfnL
	 pPLEt7zG/fUE79hk5/rp8s14r3pMuuGcUhyadSliy2VTRlqhQ7jo+YoentUJZhvvCiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBC5606A31A
	for <mptcp@lists.linux.dev>; Tue, 27 Oct 2026 06:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FBC5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793082484; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=V2rZav/pXc2OBd3cDV8/MQJ9b+QkQzXM3E60ViTvWZMeNC8SXTFJ3ES+YXI/XIHZF/JFPSboNAB/f5ygRWZHPIJ/BbCvPkv4lVFI0mhUXT7Q74e18n/9BWGYT9Vlc6SDA1Be3hucI4R/BD7Ne89G79w2RbaiqQrdfE1+fBWCjQs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793082484; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gB1yuYaeMIHij6RVao4q4xxDZCCgJQrom3+PlOynyWw=; 
	b=B5RlFd1mXos2zbou4AQ0vkKdlMzJszHDtUC7Ao2KVksK7DHvJYH06cNxEMKBA/RMs7XXxbg6I/SjDM2llGgBC0ZfQhbu4Jg/fLMlURzmKwI1Axbmw8C/TeTy8ZEB8/GK0zzLmPh/3smBWpzq8oTQ+o+DAm+PMeEnNCySJBPO548=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793082484;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gB1yuYaeMIHij6RVao4q4xxDZCCgJQrom3+PlOynyWw=;
	b=m4hg64kf6rQxVqLnFOtQYlTK12tzJ4B5OVCXOZ4BIO2MY3Lzt4u5vomqjD95g4q5
	yGeFcNXZuD8HoTtWgb3KdkY45ELqXaXaQ37U+KEZmISSHrjbCEotEBL6tFF13OHu33p
	BP6zAuQQSg8KZhq7cptqCOzJaFh5mHBJ8h9wjkeI=
Received: by smtp.zohomail.com with SMTPS id 1793082482348898.921445953905;
	Mon, 26 Oct 2026 23:28:02 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	kalpanjani009@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [RFC net-next v10] mptcp: normalize seq numbers reported in mptcp_info
Date: Tue, 27 Oct 2026 11:57:50 +0530
Message-ID: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Normalize the MPTCP sequence fields relative to the initial data sequence
number baselines.

Keep the normalized values available to privileged diagnostic requests,
while zeroing them in INET_DIAG_INFO for callers without CAP_NET_ADMIN.

Normalize MPTCP_SUBFLOW_ATTR_MAP_SEQ against remote_idsn as well, so
subflow mapping sequence numbers use the same remote sequence space as
mptcpi_rcv_nxt.

Pass requester capability state to idiag_get_info callbacks. Other
protocol callbacks retain their existing behavior.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
Changes since v9:
- Keep normalized sequence values available to privileged diagnostic
  requests and zero the three sequence fields for unprivileged
  INET_DIAG_INFO callers.
- Pass requester capability state to idiag_get_info callbacks while
  preserving existing behavior for other protocol callbacks.
- Normalize MPTCP_SUBFLOW_ATTR_MAP_SEQ relative to remote_idsn so it
  uses the same remote sequence-number baseline as mptcpi_rcv_nxt.

v9: https://lore.kernel.org/all/20261015101303.144541-1-kalpan.jani@mpiricsoftware.com/
---
 include/linux/inet_diag.h |  2 +-
 net/ipv4/inet_diag.c      |  6 +++---
 net/ipv4/raw_diag.c       |  2 +-
 net/ipv4/tcp_diag.c       |  2 +-
 net/ipv4/udp_diag.c       |  2 +-
 net/mptcp/diag.c          |  8 +++++++-
 net/mptcp/mptcp_diag.c    |  9 ++++++++-
 net/mptcp/protocol.c      |  4 ++++
 net/mptcp/protocol.h      |  2 ++
 net/mptcp/sockopt.c       | 14 ++++++++++----
 net/mptcp/subflow.c       |  5 ++++-
 net/sctp/diag.c           |  6 +++---
 12 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 704fd415c2b49..85f6278d5db1d 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -18,7 +18,7 @@ struct inet_diag_handler {
 
 	void		(*idiag_get_info)(struct sock *sk,
 					  struct inet_diag_msg *r,
-					  void *info);
+					  void *info, bool net_admin);
 
 	int		(*idiag_get_aux)(struct sock *sk,
 					 bool net_admin,
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 34b77aa87d0a4..362161bf39fe3 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -276,7 +276,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 	}
 
 	if (!icsk) {
-		handler->idiag_get_info(sk, r, NULL);
+		handler->idiag_get_info(sk, r, NULL, net_admin);
 		goto out;
 	}
 
@@ -327,7 +327,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 			goto errout;
 	}
 
-	handler->idiag_get_info(sk, r, info);
+	handler->idiag_get_info(sk, r, info, net_admin);
 
 	if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
 		if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
@@ -1027,7 +1027,7 @@ int inet_diag_handler_get_info(struct sk_buff *skb, struct sock *sk)
 	if (attr)
 		info = nla_data(attr);
 
-	handler->idiag_get_info(sk, r, info);
+	handler->idiag_get_info(sk, r, info, false);
 	inet_diag_unlock_handler(handler);
 
 	nlmsg_end(skb, nlh);
diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
index 943e5998e0ad5..264912d0cb9fc 100644
--- a/net/ipv4/raw_diag.c
+++ b/net/ipv4/raw_diag.c
@@ -185,7 +185,7 @@ static void raw_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 }
 
 static void raw_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-			      void *info)
+			      void *info, bool net_admin)
 {
 	r->idiag_rqueue = sk_rmem_alloc_get(sk);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index ba1fdbe9807fd..cac32575282e3 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -19,7 +19,7 @@
 #include <net/tcp.h>
 
 static void tcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-			      void *_info)
+			      void *_info, bool net_admin)
 {
 	struct tcp_info *info = _info;
 
diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
index f4b24e628cf8d..5a1fa627cbee8 100644
--- a/net/ipv4/udp_diag.c
+++ b/net/ipv4/udp_diag.c
@@ -142,7 +142,7 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 }
 
 static void udp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-		void *info)
+		void *info, bool net_admin)
 {
 	r->idiag_rqueue = udp_rqueue_get(sk);
 	r->idiag_wqueue = sk_wmem_alloc_get(sk);
diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
index 70cf9ebce8338..590cdee419ef9 100644
--- a/net/mptcp/diag.c
+++ b/net/mptcp/diag.c
@@ -16,6 +16,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 {
 	struct mptcp_subflow_context *sf;
 	struct nlattr *start;
+	u64 map_seq;
 	u32 flags = 0;
 	bool slow;
 	int err;
@@ -35,6 +36,11 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 		goto nla_failure;
 	}
 
+	map_seq = 0;
+	if (sf->conn && sf->map_seq)
+		map_seq = sf->map_seq -
+			  READ_ONCE(mptcp_sk(sf->conn)->remote_idsn);
+
 	if (sf->mp_capable)
 		flags |= MPTCP_SUBFLOW_FLAG_MCAP_REM;
 	if (sf->request_mptcp)
@@ -67,7 +73,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 	if (net_admin &&
 	    (nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_RELWRITE_SEQ,
 			 sf->rel_write_seq) ||
-	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
+	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, map_seq,
 			       MPTCP_SUBFLOW_ATTR_PAD) ||
 	     nla_put_u32(skb, MPTCP_SUBFLOW_ATTR_MAP_SFSEQ,
 			 sf->map_subflow_seq) ||
diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0eeb..d526b1015da16 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -190,7 +190,7 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 }
 
 static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-				void *_info)
+				void *_info, bool net_admin)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_info *info = _info;
@@ -215,6 +215,13 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		return;
 
 	mptcp_diag_fill_info(msk, info);
+
+	if (!net_admin) {
+		/* Hide data sequence numbers from unprivileged users. */
+		info->mptcpi_write_seq = 0;
+		info->mptcpi_snd_una = 0;
+		info->mptcpi_rcv_nxt = 0;
+	}
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index f22d64ab1c53b..e59209b6fc41c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3216,6 +3216,8 @@ static void __mptcp_init_sock(struct sock *sk)
 	INIT_WORK(&msk->work, mptcp_worker);
 	msk->out_of_order_queue = RB_ROOT;
 	msk->first_pending = NULL;
+	WRITE_ONCE(msk->local_idsn, 0);
+	WRITE_ONCE(msk->remote_idsn, 0);
 
 	/* msk does not go through tcp_init_sock(); seed RTO bounds. */
 	icsk->icsk_rto_min =
@@ -3763,6 +3765,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 
 	msk = mptcp_sk(nsk);
 	WRITE_ONCE(msk->local_key, subflow_req->local_key);
+	WRITE_ONCE(msk->local_idsn, subflow_req->idsn);
 	WRITE_ONCE(msk->token, subflow_req->token);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
@@ -4201,6 +4204,7 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 					     MPTCP_MIB_TOKENFALLBACKINIT);
 	}
 
+	WRITE_ONCE(msk->local_idsn, subflow->idsn);
 	WRITE_ONCE(msk->write_seq, subflow->idsn);
 	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 	WRITE_ONCE(msk->snd_una, subflow->idsn);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3d250e8204d52..fc6858863fa89 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -288,6 +288,8 @@ struct mptcp_sock {
 						 * lockless access read
 						 */
 	u64		remote_key;		/* same as above */
+	u64		local_idsn;
+	u64		remote_idsn;
 	u64		write_seq;
 	u64		bytes_sent;
 	u64		snd_nxt;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 922f6ae5c80cb..b20263b4cd55c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1047,6 +1047,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	struct sock *sk = (struct sock *)msk;
+	u64 local_idsn = 0, remote_idsn = 0;
 	u32 flags = 0;
 	bool slow;
 	u32 now;
@@ -1084,9 +1085,11 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_flags = flags;
 
 	slow = lock_sock_fast(sk);
+	local_idsn = READ_ONCE(msk->local_idsn);
+
 	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
-	info->mptcpi_write_seq = msk->write_seq;
+	info->mptcpi_write_seq = msk->write_seq - local_idsn;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 	info->mptcpi_bytes_sent = msk->bytes_sent;
 	info->mptcpi_bytes_received = msk->bytes_received;
@@ -1099,17 +1102,20 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	unlock_sock_fast(sk, slow);
 
 	mptcp_data_lock(sk);
+	if (READ_ONCE(msk->can_ack))
+		remote_idsn = READ_ONCE(msk->remote_idsn);
 	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
-	info->mptcpi_snd_una = msk->snd_una;
-	info->mptcpi_rcv_nxt = msk->ack_seq;
+	info->mptcpi_snd_una = msk->snd_una - local_idsn;
+	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 	info->mptcpi_bytes_acked = msk->bytes_acked;
 	mptcp_data_unlock(sk);
+
 }
 EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 
 static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, int __user *optlen)
 {
-	struct mptcp_info m_info;
+	struct mptcp_info m_info = {};
 	int len;
 
 	if (get_user(len, optlen))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 2d7ccb01d2342..39c7422afa779 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -482,7 +482,6 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	if (subflow->remote_key_valid)
 		return;
 
-	subflow->remote_key_valid = 1;
 	subflow->remote_key = mp_opt->sndr_key;
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
@@ -491,9 +490,13 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 	subflow->map_seq = subflow->iasn;
 
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
+	WRITE_ONCE(msk->remote_idsn, subflow->iasn - 1);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
 	atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
+
+	/* publish last, once iasn and the fields above are fully populated */
+	subflow->remote_key_valid = 1;
 }
 
 static void mptcp_propagate_state(struct sock *sk, struct sock *ssk,
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index c2a0de2adf6fd..ab6c560fde053 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -20,7 +20,7 @@
 #include <net/sctp/sctp.h>
 
 static void sctp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-			       void *info);
+			       void *info, bool net_admin);
 
 /* define some functions to make asoc/ep fill look clean */
 static void inet_diag_msg_sctpasoc_fill(struct inet_diag_msg *r,
@@ -200,7 +200,7 @@ static int inet_sctp_diag_fill(struct sock *sk, struct sctp_association *asoc,
 	}
 	infox.sctpinfo = (struct sctp_info *)info;
 	infox.asoc = asoc;
-	sctp_diag_get_info(sk, r, &infox);
+	sctp_diag_get_info(sk, r, &infox, net_admin);
 
 	addr_list = asoc ? &asoc->base.bind_addr.address_list
 			 : &ep->base.bind_addr.address_list;
@@ -412,7 +412,7 @@ static int sctp_ep_dump(struct sctp_endpoint *ep, void *p)
 
 /* define the functions for sctp_diag_handler*/
 static void sctp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
-			       void *info)
+			       void *info, bool net_admin)
 {
 	struct sctp_infox *infox = (struct sctp_infox *)info;
 
-- 
2.43.0

