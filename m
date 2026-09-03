Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5DB18DB01;
	Thu,  3 Sep 2026 02:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788401266; cv=none; b=dvpU5eDit7RnXtZZVH/Bonayf4PIfUE4AJUUsOnzjlNXK2J+Gq9eQ6UYN9eZmcNNIfTqG+RgW4AkD7cwnYxBRZTFUb+w0RC6vrOb7SoqkX5XEvrPyTFgCWcn5RKx5/MfM8YNMZafplCWQuejLhKtJOhpQz6gmnrHxrhPPXbQwgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788401266; c=relaxed/simple;
	bh=gdjaIf47rw5kxmOng5KovpJ2kIOkPw9uGdTlDpKQXF4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTuftJX27Iz2sHpg5YzvO+BXjdJF1zgsedgPk77CAYvZ1mIXB9LTni+qR5RzSkmWePn9JF5lVoyHneFVeBECxxJXrrZk4BXZaameFUoVSjbtGH/m0KPICVdTCQ1dO9glzBlkPsuab2d8ubtLfufWlOHVDrzho/IxBBKnxBaeJok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybwmrn+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybwmrn+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E6B1F000E9;
	Thu,  3 Sep 2026 02:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788401264;
	bh=EwJnHwNJkVMlq6hkmGrrWHKVSZIuu399gluAH4yA71E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ybwmrn+srzrbzLmauSpU2tYzlMqbsMvZdLqZvxKiLa8ZZb2y+c497jej4QmJ/M5vc
	 h9S26fawjdhcwDAgagOoFn39/GtAFgNMJPhnkiKjaKrz7lwSF8ZaWljzsJRZrfOg3x
	 fOQr7LqvYyENMouA8jIEcZaWuhWXp1HHeAtaGz9LwwwUQua01FFFXBevkuXGRr2eCj
	 M7qqLx3RMKlf6eZ2ZE89zRbjZA/Sg0/7jTDhK/cLgGRlakR6rI46bFV3lo6nXw8ZIN
	 313uegMeTaxTMXEc7YuMSJ+XJyquKVjasNzDwbeZS2UwvsKuuN7HuP318H2jZLmSss
	 zpM/r7+Q7t4rw==
Message-ID: <99e76bbc2679c6c288f5ddf63d25dda03ce97379.camel@kernel.org>
Subject: Re: [PATCH net v5 1/2] mptcp: hold MP_JOIN msk ref when cloning
 reqsk
From: Geliang Tang <geliang@kernel.org>
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net,
 kafai@fb.com, 	kylebot@openai.com, david.lee@trailofbits.com,
 vega@nebusec.ai, 	caoruide123@gmail.com, sashiko-bot@kernel.org
Date: Thu, 03 Sep 2026 10:07:27 +0800
In-Reply-To: <12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8.1788202924.git.caoruide123@gmail.com>
References: <cover.1788202924.git.caoruide123@gmail.com>
	 <12d0c7f938729d16fcdd5b46a6a0e912fb1cd2f8.1788202924.git.caoruide123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ren,

On Tue, 2026-09-01 at 18:33 +0800, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> TCP request migration clones pending request sockets with
> inet_reqsk_clone().  For MPTCP MP_JOIN requests this byte-copies
> subflow_req->msk, but the clone does not own a reference.
> 
> The original and cloned requests can consequently drop the same msk
> reference, leaving one request with a dangling pointer.  This
> manifests
> as a KASAN slab-use-after-free in subflow_req_destructor().
> 
> A non-NULL subflow_req->msk means that the request owns one
> reference.
> The third ACK can concurrently transfer the original request
> reference
> to the child and release it, so taking an unconditional hold on the
> copied pointer is unsafe.
> 
> MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all current
> inet_reqsk_clone() callers run in an RCU read-side critical section.
> Read the pointer from the original request, acquire a reference only
> if
> it is still live, then re-read the original request to verify that it
> still owns the same msk.  If either check fails, clear the clone
> pointer;
> otherwise its normal destructor balances the new reference.  Mark the
> ownership-transfer store with WRITE_ONCE() to match the lockless
> reads.
> 
> Patch 2/2 completes the clone fixup for MP_CAPABLE token ownership. 
> Both
> patches carry the same Fixes tag and are required for stable
> backports.
> 
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at
> retransmitting SYN+ACKs.")
> Cc: stable@vger.kernel.org
> Reported-by: Kyle Zeng <kylebot@openai.com>
> Reported-by: David Lee <david.lee@trailofbits.com>
> Closes:
> https://lore.kernel.org/all/20260804095051.715355-1-david.lee@trailofbits.com/
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  include/net/mptcp.h             |  7 +++++++
>  net/ipv4/inet_connection_sock.c |  4 ++++
>  net/mptcp/subflow.c             | 33
> ++++++++++++++++++++++++++++++++-
>  3 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 71b9fc5a5796..0a02ac1ed22d 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -223,6 +223,8 @@ int mptcp_subflow_init_cookie_req(struct
> request_sock *req,
>  struct request_sock *mptcp_subflow_reqsk_alloc(const struct
> request_sock_ops *ops,
>  					       struct sock
> *sk_listener,
>  					       bool
> attach_listener);
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req);
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
>  
> @@ -309,6 +311,11 @@ static inline struct request_sock
> *mptcp_subflow_reqsk_alloc(const struct reques
>  	return NULL;
>  }
>  
> +static inline void mptcp_subflow_reqsk_clone(struct request_sock
> *req,
> +					     struct request_sock
> *new_req)
> +{
> +}
> +
>  static inline __be32 mptcp_reset_option(const struct sk_buff *skb) 
> { return htonl(0u); }
>  
>  static inline void mptcp_active_detect_blackhole(struct sock *sk,
> bool expired) { }
> diff --git a/net/ipv4/inet_connection_sock.c
> b/net/ipv4/inet_connection_sock.c
> index 6257459bcee2..896f472dcba2 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -21,6 +21,7 @@
>  #include <net/xfrm.h>
>  #include <net/tcp.h>
>  #include <net/tcp_ecn.h>
> +#include <net/mptcp.h>
>  #include <net/sock_reuseport.h>
>  #include <net/addrconf.h>
>  
> @@ -961,6 +962,9 @@ static struct request_sock
> *inet_reqsk_clone(struct request_sock *req,
>  		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk,
> nreq);
>  	}
>  
> +	if (rsk_is_mptcp(req))
> +		mptcp_subflow_reqsk_clone(req, nreq);
> +
>  	return nreq;
>  }
>  
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8e386899ceb9..e08d1036ad78 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -47,6 +47,37 @@ static void subflow_req_destructor(struct
> request_sock *req)
>  	mptcp_token_destroy_request(req);
>  }
>  
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req)
> +{
> +	struct mptcp_subflow_request_sock *subflow_req =
> mptcp_subflow_rsk(req);
> +	struct mptcp_subflow_request_sock *new_subflow_req;
> +	struct mptcp_sock *msk;
> +
> +	new_subflow_req = mptcp_subflow_rsk(new_req);
> +
> +	/* A non-NULL ->msk means the request owns one reference. 
> The clone
> +	 * copied only the pointer, while the original request can
> concurrently
> +	 * transfer its reference to the child.  Acquire a reference
> for the
> +	 * clone, then verify that the original request still owns
> the same msk.
> +	 * MPTCP sockets use SLAB_TYPESAFE_BY_RCU and all clone
> callers run in
> +	 * an RCU read-side critical section, keeping the memory
> stable here.
> +	 */
> +	msk = READ_ONCE(subflow_req->msk);
> +	if (msk) {
> +		struct sock *msk_sk = (struct sock *)msk;

Here we usually name this variable "sk", and correspondingly, the
socket for the subflow is generally named "ssk".

Thanks,
-Geliang

> +
> +		if (!refcount_inc_not_zero(&msk_sk->sk_refcnt)) {
> +			msk = NULL;
> +		} else if (READ_ONCE(subflow_req->msk) != msk) {
> +			sock_put(msk_sk);
> +			msk = NULL;
> +		}
> +	}
> +
> +	new_subflow_req->msk = msk;
> +}
> +
>  static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1,
> u32 nonce2,
>  				  void *hmac)
>  {
> @@ -919,7 +950,7 @@ static struct sock *subflow_syn_recv_sock(const
> struct sock *sk,
>  			}
>  
>  			/* move the msk reference ownership to the
> subflow */
> -			subflow_req->msk = NULL;
> +			WRITE_ONCE(subflow_req->msk, NULL);
>  			ctx->conn = (struct sock *)owner;
>  
>  			if (subflow_use_different_sport(owner, sk))
> {
