Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6C3C09E9
	for <mptcp@lists.linux.dev>; Wed, 13 May 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665076; cv=none; b=HwXEP2OTVrZaMFI3+akS0Tf62VyYzzBkjRSSIeWCNzDVD5L+dPxfvc2ofOIIlIuryu6wqF1yNYHWxOCvbe1sbYsWhHmBtc8SYjOJSti5m1uIctYRqpwn/EikF5cjTn/a8gOYgonOrVAmrfsX7gBma5+TodMrdZXmbk9fBiOwdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665076; c=relaxed/simple;
	bh=3ZE9OxERC0pyhWuHeI+A8r6DIJhoAQnYv0T9ivO+4HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oywmtWlSQmRyU52gV0sGShSOOCEOeNKpAPlc63Loy9wmCxXgFKIL2BD/lHc9oXukxmNajvRAxQFtHt+LKx94UT1TRVLwmEkodyclS5ZwSCynsCrK8ESk9hk0CciSfqvPLlNlcqgBhAOUK6ZUc+ioZgoi44QBct/JQsgyquSmrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIeX3R9l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIeX3R9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778665072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gG8d2uNiMKq5bQSD3rz62Oi2tshDrpyy2LvH23JNt0=;
	b=KIeX3R9lOQnEjqUp4+eb7fcxyLB5YAFRnGn7U6WD3gxmvM+nfxh3b/7N/ydQ0U/FQUpzmr
	IpbU7D99izo3m66c3Bh0m4Np4VAldSxNBEtnoZ4BPU9pKlgieJ+sRH2NKl9diy4wlgrchY
	J8Rb3aMoDocth7Nv5loy4WCzhBPtMzo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-PxuTGqTCOy6rmklLJVkU4g-1; Wed, 13 May 2026 05:37:51 -0400
X-MC-Unique: PxuTGqTCOy6rmklLJVkU4g-1
X-Mimecast-MFC-AGG-ID: PxuTGqTCOy6rmklLJVkU4g_1778665070
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d83e45febso5922827f8f.0
        for <mptcp@lists.linux.dev>; Wed, 13 May 2026 02:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665070; x=1779269870;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gG8d2uNiMKq5bQSD3rz62Oi2tshDrpyy2LvH23JNt0=;
        b=obwCly7SaT3rDmHSm2Yf794II6kJ7S8gIsSu2LX+GhF6npMUS2u9Syk02edzIDPb3g
         d2eRRzk4xeWk2n9N+oLuXoT2wQmT87FKx7VNiLm5awCQA0suc70ksEZn/Ua1sZO8zIYl
         kWC2NlrnE5/BE6pMconcR2XwadyAw8vFqRVwZB8m7bpM1o87CV5QGrrvRKZyr8/0GBgf
         QGwk3sri1JQK2LjxIi9SKSSZjDaxQ5XCPh0VIsTC9RFVP2g6R+J9Ie2O8GdiNzpxit/U
         a7Ii9dkv6qxF/mJ9rxwkfZPtQoivEW7UBkqhpm/v5mGS2vh5pdPH/cHthWpMATZ63jPB
         6c7A==
X-Forwarded-Encrypted: i=1; AFNElJ9CjJsw+OSVFw9E41Y5kWMTR3VtRaTq0+EPih2YLAv5k3g/xof8cuizTn/nBAhd6vNkE3xqWA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz4jyqIbMZO/DXs69yZ6VrXVnRzfJiAGrAvO/LvQDQg/kXxnzGj
	3AFqSCHSJgtQoP6gePQ6opIPGi/xrwvnc5kYhQSiys2BIuOiHVz0jqWpYPHWP4iBezi6MG0xY8h
	/l6p9kaejv2NyN3MSNNeQ9+ZLDdljPd0JIqLcn7PyGuvB/qGfjw7w/cgK
X-Gm-Gg: Acq92OE2kFF8rJw6sX+g26tVxoUktBBhnJyC8hJf4+1E9IwEdPFgT+M/oic6kLcjzxd
	4vqNvFvqODaTIq8YwMA2lnGylIees5FnjkmYpQu7ZGrPgU3mRWKOlqtcDVjEcjww78nDs0QX0Uf
	skHDSnAu1tDfp0wSIMe+/Xa6ivh3EJ5tCDLYb8zjJHLM3dVbhGPkgxnEqYlCEByEaN4hnxrirBu
	qsb40SkYzbIkU68hostNvCLcdg5c32XK2kNa0R8DlKwCquWhdt7g59fkRh7c3R+9adUuFEfFY6t
	CaboejTtzZDL2GIINKpEiOZogQupc99fe3cY0TozGy6bUxyWbbsgJ8xZintoZCn/WMsZBr+aJGC
	Aqs6moGL+p1LSkzfnZVPiNaUUPLEtHG2p+iAtATjqyiIpb7l/xxaF0i4=
X-Received: by 2002:a05:600c:45cd:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48fc971f0ecmr35736195e9.2.1778665069827;
        Wed, 13 May 2026 02:37:49 -0700 (PDT)
X-Received: by 2002:a05:600c:45cd:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48fc971f0ecmr35735635e9.2.1778665069244;
        Wed, 13 May 2026 02:37:49 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f4247fasm52677825e9.9.2026.05.13.02.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 02:37:48 -0700 (PDT)
Message-ID: <be1b6f66-207a-4ed6-8188-72ec11f222a4@redhat.com>
Date: Wed, 13 May 2026 11:37:46 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] mptcp: fix request ownership when cloning
 reqsk
To: Ren Wei <n05ec@lzu.edu.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, daniel@iogearbox.net, kafai@fb.com,
 yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 bird@lzu.edu.cn, caoruide123@gmail.com, enjou1224z@gmail.com
References: <40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <40fd38e7a368e5b7bc9bc83364a32241f977d53f.1778404619.git.caoruide123@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 27OX74YWlYFJj3jpcTL-vPtVyz2CyNZ4uZEHnU1AqZI_1778665070
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 4:14 PM, Ren Wei wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> TCP request migration clones pending request sockets with
> inet_reqsk_clone(). For MPTCP MP_JOIN requests this raw-copies
> subflow_req->msk, but the cloned request does not take a new reference.
> 
> Both the original and the cloned request can later drop the same msk in
> subflow_req_destructor(), and a migrated request may keep a dangling msk
> pointer after the original owner has already been released.
> 
> MP_CAPABLE requests have a similar ownership issue for token_node. The
> original request is hashed in the token table, and inet_reqsk_clone()
> raw-copies the hlist pointers into the clone. The clone must not inherit
> that hashed state on migration failure, and the token ownership must move
> only after the new req has actually replaced the old one in the ehash.
> 
> Fix both cases while keeping the change local to MPTCP and the TCP
> migration path: grab a reference for cloned subflow requests that carry an
> msk, clear any raw-copied token hash state from the clone, and move the
> hashed token request ownership only after migration succeeds.
> 
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> changes in v2:
>   - drop the generic request_sock clone callback
>   - call MPTCP directly from inet_reqsk_clone() under the TCP protocol check
>   - keep cloned MP_JOIN requests holding an msk reference
>   - clear raw-copied MP_CAPABLE token hash state in the clone
>   - move MP_CAPABLE token ownership only after successful req migration
>   - avoid exposing token internals to inet_connection_sock.c
>   - update the commit message accordingly
>   - v1 link: https://lore.kernel.org/all/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123@gmail.com/
> 
>  include/net/mptcp.h             | 14 ++++++++++++++
>  net/ipv4/inet_connection_sock.c | 12 ++++++++++--
>  net/mptcp/protocol.h            |  2 ++
>  net/mptcp/subflow.c             | 20 ++++++++++++++++++++
>  net/mptcp/token.c               | 25 +++++++++++++++++++++++++
>  5 files changed, 71 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index f7263fe2a2e4..4bb24963afef 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -219,6 +219,10 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
>  struct request_sock *mptcp_subflow_reqsk_alloc(const struct request_sock_ops *ops,
>  					       struct sock *sk_listener,
>  					       bool attach_listener);
> +void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +			       struct request_sock *new_req);
> +void mptcp_subflow_reqsk_migrated(struct request_sock *req,
> +				  struct request_sock *new_req);
>  
>  __be32 mptcp_get_reset_option(const struct sk_buff *skb);
>  
> @@ -314,6 +318,16 @@ static inline struct request_sock *mptcp_subflow_reqsk_alloc(const struct reques
>  	return NULL;
>  }
>  
> +static inline void mptcp_subflow_reqsk_clone(struct request_sock *req,
> +					     struct request_sock *new_req)
> +{
> +}
> +
> +static inline void mptcp_subflow_reqsk_migrated(struct request_sock *req,
> +						struct request_sock *new_req)
> +{
> +}
> +
>  static inline __be32 mptcp_reset_option(const struct sk_buff *skb)  { return htonl(0u); }
>  
>  static inline void mptcp_active_detect_blackhole(struct sock *sk, bool expired) { }
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index e961936b6be7..578471bb8a2b 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -17,6 +17,7 @@
>  #include <net/inet_timewait_sock.h>
>  #include <net/ip.h>
>  #include <net/route.h>
> +#include <net/mptcp.h>
>  #include <net/tcp_states.h>
>  #include <net/xfrm.h>
>  #include <net/tcp.h>
> @@ -951,8 +952,13 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>  	/* We need not acquire fastopenq->lock
>  	 * because the child socket is locked in inet_csk_listen_stop().
>  	 */
> -	if (sk->sk_protocol == IPPROTO_TCP && tcp_rsk(nreq)->tfo_listener)
> -		rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
> +	if (sk->sk_protocol == IPPROTO_TCP) {
> +		if (tcp_rsk(nreq)->tfo_listener)
> +			rcu_assign_pointer(tcp_sk(nreq->sk)->fastopen_rsk, nreq);
> +
> +		if (rsk_is_mptcp(req))
> +			mptcp_subflow_reqsk_clone(req, nreq);
> +	}
>  
>  	return nreq;
>  }
> @@ -1115,6 +1121,8 @@ static void reqsk_timer_handler(struct timer_list *t)
>  			goto no_ownership;
>  		}
>  
> +		if (rsk_is_mptcp(oreq))
> +			mptcp_subflow_reqsk_migrated(oreq, nreq);

Sashiko says:

---
Can this sequence trigger a race condition with network RX processing?
In reqsk_timer_handler(), nreq is inserted into the global ehash table
via inet_ehash_insert() right before this block. The ehash lock is
immediately dropped, making nreq globally visible to concurrent network
RX softirq processing.
However, the MPTCP token state is not migrated to nreq until the call to
mptcp_subflow_reqsk_migrated(oreq, nreq).
If a concurrent RX thread processes an incoming ACK for the connection
in this narrow window, it could find nreq in the ehash table,
successfully process it, and invoke mptcp_token_accept(nreq).
Inside mptcp_token_accept(), __token_lookup_req() searches the token
bucket and finds oreq, because the timer thread hasn't moved the token yet.
The code then asserts ownership:
mptcp_token_accept()
	pos = __token_lookup_req(bucket, req->token);
	if (!WARN_ON_ONCE(pos != req))
		hlist_nulls_del_init_rcu(&req->token_node);
Since pos is oreq and req is nreq, would this fail the assertion and
trigger a kernel warning?
If the calls were reordered so that mptcp_subflow_reqsk_migrated()
happens before inet_ehash_insert(), could that merely shift the race? If
a concurrent ACK is already processing oreq, it might call
mptcp_token_accept(oreq) after the token was moved to nreq, triggering
the same warning, since the ehash table and the token bucket are
protected by different locks and the updates are non-atomic.
Could a remote attacker time ACKs to hit this window during a listener
migration, potentially leading to a denial of service on systems
configured to panic on warnings?
---

I _think_ the above race could/should be solved squashing
mptcp_subflow_reqsk_migrated() into mptcp_subflow_reqsk_clone() and
adjusting  mptcp_token_destroy_request() and mptcp_token_accept() to
deal with already removed token, checking (again) for unhased token_node
under the bucket lock.

The latter will require a little more work, returning a success status
to the caller - mptcp_sk_clone_init() - and make the latter fail on
mptcp_token_accept() failures.

The above would also make the fix more encapsulated into the mptcp code.

/P

