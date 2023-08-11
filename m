Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB9E329BA
	for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 15:58:56 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-31751d7d96eso1829128f8f.1
        for <mptcp@lists.linux.dev>; Fri, 11 Aug 2023 08:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769535; x=1692374335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLaLRYF1JduC+QzJ6GmQvAFgWnOUNDuN5FR0KZ2xx0A=;
        b=noy0cHvA5nSTmWrJUz91yjHuTF/IaG5qP+BedmmnjvAivrJ7RDhS85BDCiPUg3NRFE
         XeVT+4W66rrFujkgK3Lyqjh77PF2/8XxVznsW/tvioTNi/g3DlaFBsxEHcyN/9awDzLc
         p1dfFs3XqBkbW6ETfcwakXFGLYb1nMthGv2b3/MiKQ3AYhG1PNbYfdNAkU3zmtO2z+uk
         +tMNEn9LJiAgyKyTJiWyB775hg29tXJ9Y1oN8OQTL2CeXRqF6po4G0Yar2tLTXb60o2H
         fWWd7inV6p7Tngvoc/hLcSWbeFGE0zgKeW9lT9gEuN2QC6SvRK/l7b7/YjjoXELTcY+W
         G0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769535; x=1692374335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLaLRYF1JduC+QzJ6GmQvAFgWnOUNDuN5FR0KZ2xx0A=;
        b=Vv7EbwNARV6qAESIw0KCAg0yNmgQxhRw+ONtNkJ+mPAFrdlbHbKmgRfCO/zJbkK/DX
         YGQRmdDeFObKMxlZXbdYrE4yPE2zw4ba51I0/oDNQg5BPx2uaz/xM9GjLylVG+4TOXXx
         UBPOU+ZZfbKoZy88T9EUNdSM1Zq/GtgKl5PKeetFN0gYBvaC0BmIeWswTsEi+IWRFTxX
         Nt25z5PmSAwVfPjOm1/7rNzdy1yTH39p/MKBtiIcdnj7cIBDbE/Njfhdz0YrRNmML0pX
         RBQn/3hqpjU7aoydjgsZnzwoMCVpGlS2kJiq9fnkSgjzDKzGonZmrN9hHfSmQlFGynx3
         /UHw==
X-Gm-Message-State: AOJu0Yx4bYgKKrbO3vQ/IXtfmFpKkqSWeInTABPHXkdZVT/9CbXI67B0
	DsBaIINEFJQO4sxYbsvgabFflg==
X-Google-Smtp-Source: AGHT+IGOmd1+l7kOKJnbNq4g2j2InKaMpB7aiJxx5b1DAIVklrLR/bZOa2fdd2lhCnC+46zkWB11gQ==
X-Received: by 2002:a05:6000:1086:b0:317:594a:dbde with SMTP id y6-20020a056000108600b00317594adbdemr1777929wrw.20.1691769534752;
        Fri, 11 Aug 2023 08:58:54 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:54 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:26 +0200
Subject: [PATCH net-next 13/14] mptcp: get rid of msk->subflow
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-13-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5387;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JOoJwlBZFYBUmiOmWbe7z+i/oWAb6YdcTuPbi7SJfsk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqv+QeEPuMBcjYRKmzxcRYgSkRQXDk9iGBun
 vM2a5KezHSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 cyamD/wLack7Ml/PVH4WCAUD77D7IUrXDx2QwvmPDDPIrBy8extCVuY65SVGbf4MLGWc5VLR4Fh
 /+pyJCyslnWNGjIhYp5fzJMNKBO0XVCTaaa8g+TV1umSei3ZcF92+m08Jf1PgANT7J/70WzSQKM
 iJj0NboA+2HnINHXUrb460QdHWDd0VGtp8Qp2ttCHOq8mKBg4LrhLPQW7D/DU1eSTfll+2u1atP
 KwV5wWXWbSuKGJxOAiGKMJmBQ0EHjNOHxCYf5/AKJesmv5i2L75pOqRhvYGWB0uaQqj3OZh6BFF
 34Q1AxWzJzcBLQRljg1MYlb6isWqZrRefJZ2prthzJKk+OQ9ujOfGSp3li06eJBQyVgrvL+x2qc
 5dzwRrHSGl1z16xFqiUzfW8oR8CZ7n5aBrU4l+a35VSVmP060bBiBp/0R+dkzJndam3XT4eEBsF
 A2Pcmog4QLppbn4fwvFmgESMqtauV0CEYzYcML3xvVz0m3Aa8IIdZzFrDkXvY5N5m/C2xxBnwBX
 SXPwgxC4dzyrJH4J1bGTCzAWtY6YtH10XLApj0TwuWwKqEt5h31iPq0V+N0vSl734jfVZ3wAT5X
 xMUhV5OMqjBDl2D7YjyMHXWUNA5zPgkMsOo1IyJ0wVRCq2GP2kEt0xBwyDwBYmvZzIGZjUsCjtW
 mBvQOALx7hmZd0Q==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Such field is now unused just as a flag to control the first subflow
deletion at close() time. Introduce a new bit flag for that and finally
drop the mentioned field.

As an intended side effect, now the first subflow sock is not freed
before close() even for passive sockets. The msk has no open/active
subflows if the first one is closed and the subflow list is singular,
update accordingly the state check in mptcp_stream_accept().

Among other benefits, the subflow removal, reduces the amount of memory
used on the client side for each mptcp connection, allows passive sockets
to go through successful accept()/disconnect()/connect() and makes return
error code consistent for failing both passive and active sockets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/290
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 25 ++++++-------------------
 net/mptcp/protocol.h | 13 ++++++-------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fafa83ee4a72..e715771ded7c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -92,7 +92,6 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 
 	msk->scaling_ratio = tcp_sk(ssock->sk)->scaling_ratio;
 	WRITE_ONCE(msk->first, ssock->sk);
-	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssock->sk);
@@ -102,6 +101,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	/* This is the first subflow, always with id 0 */
 	subflow->local_id_valid = 1;
 	mptcp_sock_graft(msk->first, sk->sk_socket);
+	iput(SOCK_INODE(ssock));
 
 	return 0;
 }
@@ -2238,14 +2238,6 @@ static struct sock *mptcp_subflow_get_retrans(struct mptcp_sock *msk)
 	return min_stale_count > 1 ? backup : NULL;
 }
 
-static void mptcp_dispose_initial_subflow(struct mptcp_sock *msk)
-{
-	if (msk->subflow) {
-		iput(SOCK_INODE(msk->subflow));
-		WRITE_ONCE(msk->subflow, NULL);
-	}
-}
-
 bool __mptcp_retransmit_pending_data(struct sock *sk)
 {
 	struct mptcp_data_frag *cur, *rtx_head;
@@ -2324,7 +2316,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		goto out_release;
 	}
 
-	dispose_it = !msk->subflow || ssk != msk->subflow->sk;
+	dispose_it = msk->free_first || ssk != msk->first;
 	if (dispose_it)
 		list_del(&subflow->node);
 
@@ -2345,7 +2337,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		 * disconnect should never fail
 		 */
 		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
-		msk->subflow->state = SS_UNCONNECTED;
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
 
@@ -3106,7 +3097,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	msk = mptcp_sk(nsk);
 	msk->local_key = subflow_req->local_key;
 	msk->token = subflow_req->token;
-	WRITE_ONCE(msk->subflow, NULL);
 	msk->in_accept_queue = 1;
 	WRITE_ONCE(msk->fully_established, false);
 	if (mp_opt->suboptions & OPTION_MPTCP_CSUMREQD)
@@ -3240,10 +3230,8 @@ static void mptcp_destroy(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	/* clears msk->subflow, allowing the following to close
-	 * even the initial subflow
-	 */
-	mptcp_dispose_initial_subflow(msk);
+	/* allow the following to close even the initial subflow */
+	msk->free_first = 1;
 	mptcp_destroy_common(msk, 0);
 	sk_sockets_allocated_dec(sk);
 }
@@ -3782,11 +3770,10 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
 		 */
-		if (msk->first &&
-		    unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
+		if (unlikely(inet_sk_state_load(msk->first) == TCP_CLOSE)) {
 			__mptcp_close_ssk(newsk, msk->first,
 					  mptcp_subflow_ctx(msk->first), 0);
-			if (unlikely(list_empty(&msk->conn_list)))
+			if (unlikely(list_is_singular(&msk->conn_list)))
 				inet_sk_state_store(newsk, TCP_CLOSE);
 		}
 	}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index dccc96dc2d6b..38c7ea013361 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -299,7 +299,8 @@ struct mptcp_sock {
 			cork:1,
 			nodelay:1,
 			fastopening:1,
-			in_accept_queue:1;
+			in_accept_queue:1,
+			free_first:1;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
@@ -308,12 +309,10 @@ struct mptcp_sock {
 	struct list_head rtx_queue;
 	struct mptcp_data_frag *first_pending;
 	struct list_head join_list;
-	struct socket	*subflow; /* outgoing connect/listener/!mp_capable
-				   * The mptcp ops can safely dereference, using suitable
-				   * ONCE annotation, the subflow outside the socket
-				   * lock as such sock is freed after close().
-				   */
-	struct sock	*first;
+	struct sock	*first; /* The mptcp ops can safely dereference, using suitable
+				 * ONCE annotation, the subflow outside the socket
+				 * lock as such sock is freed after close().
+				 */
 	struct mptcp_pm_data	pm;
 	struct {
 		u32	space;	/* bytes copied in last measurement window */

-- 
2.40.1

