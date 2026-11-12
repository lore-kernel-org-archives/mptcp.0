Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794459480;
	b=vP3xgdIlvvQ66slXcrTNg7Lpo4fktGmqd5bUaGZ8VZiWUMm/fIufFZtXOQTKS+xbNUwQ
	 9TuQkNOWokiygbpRZWtYBNWANCUv32xoGM/xoEoIe9wGRrVsI1rF2vtxdy0lF7Ro4IeJf
	 XyQlcVDTmMZz10x44Cauipytz+NB1ffaYNVxcvcKS/QvA46uGtn7MsjXe+3xnwZ/5FP50
	 TTWhYhZW+UW2EURME2p49d27UcgWORaGzOwOtx9Yqb2tM8E8P9p8gKOvHoxMp3QJUW6BL
	 zBAQ2AKeSznUR9mW4Dj10hcJb+2MpUuxyFbTDOmXEAWuD6VdJhlM+6iIYtBIsDUSDWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459480;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=C43iSGBVj5lx0GZMJMba3u/3PIWSMfDSU/az+dk8aio=;
	b=KxWzE1scZVC6wgJ1sTdHjO7d92YtfFebmisKLbzqS/vnnTIFb4cpITKzdIGImcIayNwT
	 FWGb4RBkSlKx1LL5kqw4mxmqF0swF5Cx8qtS/Kf1IBaYWH9Vr6R/B+u8+WSORmWNLJyix
	 g0Gn+wyFZq9rrtiv3UQUFZJD3FwZ7U4Sylr+cYVfyHgnp3PpxwyLjRktctBkq9EwYnRkK
	 2LiJtNQO0ElAK0uRpib86Hbs26DDkzzDh/acdpF9NOQ2vyHeA4zSJZRHOow4AwtzMAdwE
	 h6CFBNyN+ibg1/325XzLXi7mpUn1/3pXd8PFJsoqBaP/X4yD1ai088xfzGdRL0jz0HA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=fail smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09187606A324
	for <mptcp@lists.linux.dev>; Thu, 12 Nov 2026 04:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09187606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794459476; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S7plvZMTa/Uv5zC6xLEz5aLw4RghMNnLl0olsUrGBdaJrTTpQmb34jknWT6pdra8uGXf0KnoeAKA5LXrCVP1vNaxPxac2B2IrRn7iNak+JAmmPJH41cAzLcrVYgV4gV7DIBPiOU9KRPJRQdQXbdzhFEf34i9J2yAsDVRCPeGDY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794459476; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C43iSGBVj5lx0GZMJMba3u/3PIWSMfDSU/az+dk8aio=; 
	b=L3urEtKCDOZQP/js0kdg/0u5PjiCPbRF90dNtsAAE+p36QNUjTLhwXO5XkG5Bo24iQN/Smk6pfOUOOesgbXkxExlnLzHUqZKqwy7SACV9YnSnKLb4A37R8p84OaFs7NP6U+QZKbjsgCEPdVqkGCltdV1lu8nWcS1DwOJw38akbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=J9ET1Q+s9NgXH+TA7FSLJ+WtvnGzMjzOe9Hnk9R0BY7ucKhqOJHjqVRu/ZG5bmSuK6NkBnsI5L6EhTmDZUq5uKBRblGZGI+ISoyf0wWdEvdqtGZ0PWdcwIO0yBzdSy6uw75F6Kz+B8vbfH2TNetTomwjJoqV+28cLL2mePWRF24=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=C43iSGBVj5lx0GZMJMba3u/3PIWSMfDSU/az+dk8aio=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1794459474716406.07039992750674; Wed, 11 Nov 2026 20:57:54 -0800 (PST)
Date: Thu, 12 Nov 2026 10:27:54 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "mptcp" <mptcp@lists.linux.dev>
Cc: "shardul.b" <shardul.b@mpiricsoftware.com>,
	"matttbe" <matttbe@kernel.org>,
	"Kalpan Jani" <kalpan.jani@mpiricsoftware.com>,
	"janak" <janak@mpiric.us>, "kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1ce1e9b07.f015539104390.2600884748737974966@mpiricsoftware.com>
In-Reply-To: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com>
References: <20261106111645.786225-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [RFC net-next v12] mptcp: normalize sequence numbers using
 socket address
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi All,

I investigated the patch application failure locally.

The patch applies successfully to the intended base commit 27c69362083ec117ddb553c031e7f1e0e5d2105d.

I also tested both git apply --check and git apply --3way --check in a fresh detached worktree. Both tests passed, and all 12 files applied cleanly.
Could you please check whether the CI environment has the expected base commit and the required Git blob objects available?

The reported sha1 information is lacking or useless error may be related to the CI checkout or missing Git objects.

I have not changed the patch since submission.

Cheers,
Kalpan Jani


From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: <mptcp@lists.linux.dev>
Cc: <shardul.b@mpiricsoftware.com>, <janak@mpiric.us>, <kalpanjani009@gmail.com>, "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Date: Fri, 06 Nov 2026 16:46:45 +0530
Subject: [RFC net-next v12] mptcp: normalize sequence numbers using socket address

 > Use the MPTCP socket address as an offset when reporting write_seq,
 > snd_una, ack_seq and map_seq. This removes the need to maintain
 > separate local_idsn and remote_idsn fields for sequence number
 > normalization.
 > 
 > With normalized sequence numbers available in MPTCP diagnostics,
 > remove the masking of MPTCP-level sequence fields for unprivileged
 > users while retaining the existing net_admin checks for sensitive
 > subflow diagnostic attributes.
 > 
 > Update the inet_diag get_info callback signature accordingly across
 > the affected protocol implementations.
 > 
 > Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445
 > Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
 > ---
 > Changes since v11:
 > - Replace CAP_NET_ADMIN-based sequence counter masking with
 >   sequence-number normalization using the MPTCP socket address.
 > - Remove the net_admin argument from idiag_get_info callbacks,
 >   as MPTCP-level sequence counters are now normalized.
 > - Remove local_idsn and remote_idsn fields and their assignments.
 > - Normalize MPTCP subflow map_seq using the MPTCP socket address
 >   instead of remote_idsn.
 > - Consolidate the previous two-patch approach into a single
 >   sequence-number normalization patch.
 > 
 > v11: https://lore.kernel.org/all/20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com/
 > ---
 >  include/linux/inet_diag.h |    2 +-
 >  net/ipv4/inet_diag.c      |    6 +++---
 >  net/ipv4/raw_diag.c       |    2 +-
 >  net/ipv4/tcp_diag.c       |    2 +-
 >  net/ipv4/udp_diag.c       |    2 +-
 >  net/mptcp/diag.c          |    5 ++---
 >  net/mptcp/mptcp_diag.c    |    9 +--------
 >  net/mptcp/protocol.c      |    4 ----
 >  net/mptcp/protocol.h      |    2 --
 >  net/mptcp/sockopt.c       |   13 ++++---------
 >  net/mptcp/subflow.c       |    1 -
 >  net/sctp/diag.c           |    6 +++---
 >  12 files changed, 17 insertions(+), 37 deletions(-)
 > 
 > diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
 > index 85f6278d5db1d..704fd415c2b49 100644
 > --- a/include/linux/inet_diag.h
 > +++ b/include/linux/inet_diag.h
 > @@ -18,7 +18,7 @@ struct inet_diag_handler {
 >  
 >      void        (*idiag_get_info)(struct sock *sk,
 >                        struct inet_diag_msg *r,
 > -                      void *info, bool net_admin);
 > +                      void *info);
 >  
 >      int        (*idiag_get_aux)(struct sock *sk,
 >                       bool net_admin,
 > diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
 > index 362161bf39fe3..34b77aa87d0a4 100644
 > --- a/net/ipv4/inet_diag.c
 > +++ b/net/ipv4/inet_diag.c
 > @@ -276,7 +276,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 >      }
 >  
 >      if (!icsk) {
 > -        handler->idiag_get_info(sk, r, NULL, net_admin);
 > +        handler->idiag_get_info(sk, r, NULL);
 >          goto out;
 >      }
 >  
 > @@ -327,7 +327,7 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 >              goto errout;
 >      }
 >  
 > -    handler->idiag_get_info(sk, r, info, net_admin);
 > +    handler->idiag_get_info(sk, r, info);
 >  
 >      if (ext & (1 << (INET_DIAG_INFO - 1)) && handler->idiag_get_aux)
 >          if (handler->idiag_get_aux(sk, net_admin, skb) < 0)
 > @@ -1027,7 +1027,7 @@ int inet_diag_handler_get_info(struct sk_buff *skb, struct sock *sk)
 >      if (attr)
 >          info = nla_data(attr);
 >  
 > -    handler->idiag_get_info(sk, r, info, false);
 > +    handler->idiag_get_info(sk, r, info);
 >      inet_diag_unlock_handler(handler);
 >  
 >      nlmsg_end(skb, nlh);
 > diff --git a/net/ipv4/raw_diag.c b/net/ipv4/raw_diag.c
 > index 264912d0cb9fc..943e5998e0ad5 100644
 > --- a/net/ipv4/raw_diag.c
 > +++ b/net/ipv4/raw_diag.c
 > @@ -185,7 +185,7 @@ static void raw_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 >  }
 >  
 >  static void raw_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 > -                  void *info, bool net_admin)
 > +                  void *info)
 >  {
 >      r->idiag_rqueue = sk_rmem_alloc_get(sk);
 >      r->idiag_wqueue = sk_wmem_alloc_get(sk);
 > diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
 > index cac32575282e3..ba1fdbe9807fd 100644
 > --- a/net/ipv4/tcp_diag.c
 > +++ b/net/ipv4/tcp_diag.c
 > @@ -19,7 +19,7 @@
 >  #include <net/tcp.h>
 >  
 >  static void tcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 > -                  void *_info, bool net_admin)
 > +                  void *_info)
 >  {
 >      struct tcp_info *info = _info;
 >  
 > diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
 > index 5a1fa627cbee8..f4b24e628cf8d 100644
 > --- a/net/ipv4/udp_diag.c
 > +++ b/net/ipv4/udp_diag.c
 > @@ -142,7 +142,7 @@ static void udp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 >  }
 >  
 >  static void udp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 > -        void *info, bool net_admin)
 > +        void *info)
 >  {
 >      r->idiag_rqueue = udp_rqueue_get(sk);
 >      r->idiag_wqueue = sk_wmem_alloc_get(sk);
 > diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
 > index 590cdee419ef9..66695d17a63cc 100644
 > --- a/net/mptcp/diag.c
 > +++ b/net/mptcp/diag.c
 > @@ -16,7 +16,7 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 >  {
 >      struct mptcp_subflow_context *sf;
 >      struct nlattr *start;
 > -    u64 map_seq;
 > +    u64 map_seq = 0;
 >      u32 flags = 0;
 >      bool slow;
 >      int err;
 > @@ -36,10 +36,9 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
 >          goto nla_failure;
 >      }
 >  
 > -    map_seq = 0;
 >      if (sf->conn && sf->map_seq)
 >          map_seq = sf->map_seq -
 > -              READ_ONCE(mptcp_sk(sf->conn)->remote_idsn);
 > +              (unsigned long)mptcp_sk(sf->conn);
 >  
 >      if (sf->mp_capable)
 >          flags |= MPTCP_SUBFLOW_FLAG_MCAP_REM;
 > diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
 > index d526b1015da16..136c2d05c0eeb 100644
 > --- a/net/mptcp/mptcp_diag.c
 > +++ b/net/mptcp/mptcp_diag.c
 > @@ -190,7 +190,7 @@ static void mptcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 >  }
 >  
 >  static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 > -                void *_info, bool net_admin)
 > +                void *_info)
 >  {
 >      struct mptcp_sock *msk = mptcp_sk(sk);
 >      struct mptcp_info *info = _info;
 > @@ -215,13 +215,6 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 >          return;
 >  
 >      mptcp_diag_fill_info(msk, info);
 > -
 > -    if (!net_admin) {
 > -        /* Hide data sequence numbers from unprivileged users. */
 > -        info->mptcpi_write_seq = 0;
 > -        info->mptcpi_snd_una = 0;
 > -        info->mptcpi_rcv_nxt = 0;
 > -    }
 >  }
 >  
 >  static const struct inet_diag_handler mptcp_diag_handler = {
 > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
 > index e59209b6fc41c..f22d64ab1c53b 100644
 > --- a/net/mptcp/protocol.c
 > +++ b/net/mptcp/protocol.c
 > @@ -3216,8 +3216,6 @@ static void __mptcp_init_sock(struct sock *sk)
 >      INIT_WORK(&msk->work, mptcp_worker);
 >      msk->out_of_order_queue = RB_ROOT;
 >      msk->first_pending = NULL;
 > -    WRITE_ONCE(msk->local_idsn, 0);
 > -    WRITE_ONCE(msk->remote_idsn, 0);
 >  
 >      /* msk does not go through tcp_init_sock(); seed RTO bounds. */
 >      icsk->icsk_rto_min =
 > @@ -3765,7 +3763,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 >  
 >      msk = mptcp_sk(nsk);
 >      WRITE_ONCE(msk->local_key, subflow_req->local_key);
 > -    WRITE_ONCE(msk->local_idsn, subflow_req->idsn);
 >      WRITE_ONCE(msk->token, subflow_req->token);
 >      msk->in_accept_queue = 1;
 >      WRITE_ONCE(msk->fully_established, false);
 > @@ -4204,7 +4201,6 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 >                           MPTCP_MIB_TOKENFALLBACKINIT);
 >      }
 >  
 > -    WRITE_ONCE(msk->local_idsn, subflow->idsn);
 >      WRITE_ONCE(msk->write_seq, subflow->idsn);
 >      WRITE_ONCE(msk->snd_nxt, subflow->idsn);
 >      WRITE_ONCE(msk->snd_una, subflow->idsn);
 > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
 > index fc6858863fa89..3d250e8204d52 100644
 > --- a/net/mptcp/protocol.h
 > +++ b/net/mptcp/protocol.h
 > @@ -288,8 +288,6 @@ struct mptcp_sock {
 >                           * lockless access read
 >                           */
 >      u64        remote_key;        /* same as above */
 > -    u64        local_idsn;
 > -    u64        remote_idsn;
 >      u64        write_seq;
 >      u64        bytes_sent;
 >      u64        snd_nxt;
 > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
 > index b20263b4cd55c..6ee9dcfea5c79 100644
 > --- a/net/mptcp/sockopt.c
 > +++ b/net/mptcp/sockopt.c
 > @@ -1047,7 +1047,7 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 >  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 >  {
 >      struct sock *sk = (struct sock *)msk;
 > -    u64 local_idsn = 0, remote_idsn = 0;
 > +    u64 offset = (unsigned long)msk;
 >      u32 flags = 0;
 >      bool slow;
 >      u32 now;
 > @@ -1085,11 +1085,9 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 >      info->mptcpi_flags = flags;
 >  
 >      slow = lock_sock_fast(sk);
 > -    local_idsn = READ_ONCE(msk->local_idsn);
 > -
 >      info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 >      info->mptcpi_token = msk->token;
 > -    info->mptcpi_write_seq = msk->write_seq - local_idsn;
 > +    info->mptcpi_write_seq = msk->write_seq - offset;
 >      info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
 >      info->mptcpi_bytes_sent = msk->bytes_sent;
 >      info->mptcpi_bytes_received = msk->bytes_received;
 > @@ -1102,20 +1100,17 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 >      unlock_sock_fast(sk, slow);
 >  
 >      mptcp_data_lock(sk);
 > -    if (READ_ONCE(msk->can_ack))
 > -        remote_idsn = READ_ONCE(msk->remote_idsn);
 >      info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
 > -    info->mptcpi_snd_una = msk->snd_una - local_idsn;
 > -    info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;
 > +    info->mptcpi_snd_una = msk->snd_una - offset;
 > +    info->mptcpi_rcv_nxt = msk->ack_seq - offset;
 >      info->mptcpi_bytes_acked = msk->bytes_acked;
 >      mptcp_data_unlock(sk);
 > -
 >  }
 >  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
 >  
 >  static int mptcp_getsockopt_info(struct mptcp_sock *msk, char __user *optval, int __user *optlen)
 >  {
 >      struct mptcp_info m_info = {};
 >      int len;
 >  
 >      if (get_user(len, optlen))
 > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
 > index 39c7422afa779..55de605226ad0 100644
 > --- a/net/mptcp/subflow.c
 > +++ b/net/mptcp/subflow.c
 > @@ -490,12 +490,11 @@ static void subflow_set_remote_key(struct mptcp_sock *msk,
 >      subflow->map_seq = subflow->iasn;
 >  
 >      WRITE_ONCE(msk->remote_key, subflow->remote_key);
 > -    WRITE_ONCE(msk->remote_idsn, subflow->iasn - 1);
 >      WRITE_ONCE(msk->ack_seq, subflow->iasn);
 >      WRITE_ONCE(msk->can_ack, true);
 >      atomic64_set(&msk->rcv_wnd_sent, subflow->iasn);
 >  
 >      /* publish last, once iasn and the fields above are fully populated */
 >      subflow->remote_key_valid = 1;
 >  }
 >  
 > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
 > index ab6c560fde053..c2a0de2adf6fd 100644
 > --- a/net/sctp/diag.c
 > +++ b/net/sctp/diag.c
 > @@ -20,7 +20,7 @@
 >  #include <net/sctp/sctp.h>
 >  
 >  static void sctp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 > -                   void *info, bool net_admin);
 > +                   void *info);
 >  
 >  /* define some functions to make asoc/ep fill look clean */
 >  static void inet_diag_msg_sctpasoc_fill(struct inet_diag_msg *r,
 > @@ -200,7 +200,7 @@ static int inet_sctp_diag_fill(struct sock *sk, struct sctp_association *asoc,
 >      }
 >      infox.sctpinfo = (struct sctp_info *)info;
 >      infox.asoc = asoc;
 > -    sctp_diag_get_info(sk, r, &infox, net_admin);
 > +    sctp_diag_get_info(sk, r, &infox);
 >  
 >      addr_list = asoc ? &asoc->base.bind_addr.address_list
 >               : &ep->base.bind_addr.address_list;
 > @@ -412,7 +412,7 @@ static int sctp_ep_dump(struct sctp_endpoint *ep, void *p)
 >  
 >  /* define the functions for sctp_diag_handler*/
 >  static void sctp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 > -                   void *info, bool net_admin)
 > +                   void *info)
 >  {
 >      struct sctp_infox *infox = (struct sctp_infox *)info;
 >  
 > -- 
 > 2.43.0
 > 


