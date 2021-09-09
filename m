Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9A13FF0
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 16:16:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="220864223"
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="220864223"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 09:16:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,280,1624345200"; 
   d="scan'208";a="513839701"
Received: from jabusaid-mobl.amr.corp.intel.com ([10.255.231.212])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 09:16:38 -0700
Date: Thu, 9 Sep 2021 09:16:38 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] chtls: rename skb_entail() to
 chtls_skb_entail()
In-Reply-To: <ed8775ab838ec39895e14b191a338e0f529dfcc0.1631176902.git.pabeni@redhat.com>
Message-ID: <69c7acde-45b-fbb-df90-a89669f82a0@linux.intel.com>
References: <ed8775ab838ec39895e14b191a338e0f529dfcc0.1631176902.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 9 Sep 2021, Paolo Abeni wrote:

> The next patch will expose the core TCP helper with the same
> name. It looks like we can't trivially re-use it in chtls, so
> remame the driver specific's one to avoid name conflicts.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> notes:
> - this should land before "tcp: expose the tcp_mark_push() and skb_entail()
>  helpers"
> - just build tested, I lack the relevant H/W to do anything better
> - we need to CC the appropriate chelsio maintainer when submitting
> this patch upstream

Yes, noted.

Patch looks good for the export branch, thanks!

Acked-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> - I did not add the reported-by buildbot tag. as there will no issue
>  with the patch applied in order, but I guess it can be added, too
> ---
> .../net/ethernet/chelsio/inline_crypto/chtls/chtls.h   |  2 +-
> .../ethernet/chelsio/inline_crypto/chtls/chtls_cm.c    |  2 +-
> .../ethernet/chelsio/inline_crypto/chtls/chtls_io.c    | 10 +++++-----
> 3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
> index 9e2378013642..4b57e58845b0 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
> @@ -580,7 +580,7 @@ void chtls_set_tcb_field_rpl_skb(struct sock *sk, u16 word,
> 				 int through_l2t);
> int chtls_setkey(struct chtls_sock *csk, u32 keylen, u32 mode, int cipher_type);
> void chtls_set_quiesce_ctrl(struct sock *sk, int val);
> -void skb_entail(struct sock *sk, struct sk_buff *skb, int flags);
> +void chtls_skb_entail(struct sock *sk, struct sk_buff *skb, int flags);
> unsigned int keyid_to_addr(int start_addr, int keyid);
> void free_tls_keyid(struct sock *sk);
> #endif
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> index bcad69c48074..dfa2bfc9638e 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
> @@ -317,7 +317,7 @@ static void chtls_close_conn(struct sock *sk)
> 	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_CLOSE_CON_REQ, tid));
>
> 	tcp_uncork(sk);
> -	skb_entail(sk, skb, ULPCB_FLAG_NO_HDR | ULPCB_FLAG_NO_APPEND);
> +	chtls_skb_entail(sk, skb, ULPCB_FLAG_NO_HDR | ULPCB_FLAG_NO_APPEND);
> 	if (sk->sk_state != TCP_SYN_SENT)
> 		chtls_push_frames(csk, 1);
> }
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> index c320cc8ca68d..05cf45098462 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> @@ -119,8 +119,8 @@ static int send_flowc_wr(struct sock *sk, struct fw_flowc_wr *flowc,
> 		if (!skb)
> 			return -ENOMEM;
>
> -		skb_entail(sk, skb,
> -			   ULPCB_FLAG_NO_HDR | ULPCB_FLAG_NO_APPEND);
> +		chtls_skb_entail(sk, skb,
> +				 ULPCB_FLAG_NO_HDR | ULPCB_FLAG_NO_APPEND);
> 		return 0;
> 	}
>
> @@ -816,7 +816,7 @@ static int select_size(struct sock *sk, int io_len, int flags, int len)
> 	return io_len;
> }
>
> -void skb_entail(struct sock *sk, struct sk_buff *skb, int flags)
> +void chtls_skb_entail(struct sock *sk, struct sk_buff *skb, int flags)
> {
> 	struct chtls_sock *csk = rcu_dereference_sk_user_data(sk);
> 	struct tcp_sock *tp = tcp_sk(sk);
> @@ -840,7 +840,7 @@ static struct sk_buff *get_tx_skb(struct sock *sk, int size)
> 	skb = alloc_skb(size + TX_HEADER_LEN, sk->sk_allocation);
> 	if (likely(skb)) {
> 		skb_reserve(skb, TX_HEADER_LEN);
> -		skb_entail(sk, skb, ULPCB_FLAG_NEED_HDR);
> +		chtls_skb_entail(sk, skb, ULPCB_FLAG_NEED_HDR);
> 		skb_reset_transport_header(skb);
> 	}
> 	return skb;
> @@ -857,7 +857,7 @@ static struct sk_buff *get_record_skb(struct sock *sk, int size, bool zcopy)
> 	if (likely(skb)) {
> 		skb_reserve(skb, (TX_TLSHDR_LEN +
> 			    KEY_ON_MEM_SZ + max_ivs_size(sk, size)));
> -		skb_entail(sk, skb, ULPCB_FLAG_NEED_HDR);
> +		chtls_skb_entail(sk, skb, ULPCB_FLAG_NEED_HDR);
> 		skb_reset_transport_header(skb);
> 		ULP_SKB_CB(skb)->ulp.tls.ofld = 1;
> 		ULP_SKB_CB(skb)->ulp.tls.type = csk->tlshws.type;
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
