Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3420271
	for <mptcp@lists.linux.dev>; Tue, 13 Apr 2021 09:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1618307911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fRN5WExxngrMOO61QuQk+2qvwH5/Dcaxl2cKESX8c4A=;
	b=aLMQ1EK7wF/1f3a4HFazfk8C54GI7NDRkCxgy2w0mTW2fDR95fDzvnx1fe1L1MCryZe734
	782vfcJFmX7G94ySEL1KH3CIOJCGymQrOr+uvJ3oRTGu/1JTljPkoOeTd3YsvHrwQSbmgE
	hXLPKj0QaFjl3RqsYDm3VbRRkhRHBBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-UmDaTzfVMzmkAJnolKUUJQ-1; Tue, 13 Apr 2021 05:58:29 -0400
X-MC-Unique: UmDaTzfVMzmkAJnolKUUJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CD931084431;
	Tue, 13 Apr 2021 09:58:28 +0000 (UTC)
Received: from ovpn-115-101.ams2.redhat.com (ovpn-115-101.ams2.redhat.com [10.36.115.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BCACB51DCC;
	Tue, 13 Apr 2021 09:58:27 +0000 (UTC)
Message-ID: <ab943483882219110f0bcb79efd1629b9512102b.camel@redhat.com>
Subject: Re: [PATCH mptcp 02/10] mptcp: tag sequence_seq with socket state
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.linux.dev
Date: Tue, 13 Apr 2021 11:58:26 +0200
In-Reply-To: <20210408184936.6245-3-fw@strlen.de>
References: <20210408184936.6245-1-fw@strlen.de>
	 <20210408184936.6245-3-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-04-08 at 20:49 +0200, Florian Westphal wrote:
> Paolo Abeni suggested to avoid re-syncing new subflows because
> they inherit options from listener. In case options were set on
> listener but are not set on mptcp-socket there is no need to
> do any synchronisation for new subflows.
> 
> This change sets sockopt_seq of new mptcp sockets to the seq of
> the mptcp listener sock.
> 
> Subflow sequence is set to the embedded tcp listener sk.
> Add a comment explaing why sk_state is involved in sockopt_seq
> generation.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/protocol.c | 16 ++++++++++-----
>  net/mptcp/protocol.h |  4 ++++
>  net/mptcp/sockopt.c  | 47 ++++++++++++++++++++++++++++++++++++++++++--
>  net/mptcp/subflow.c  |  4 ++++
>  4 files changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2233baf03c3a..26e3ffe8840e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -729,11 +729,14 @@ static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
>  	if (likely(list_empty(&msk->join_list)))
>  		return false;
>  
> -	ret = true;
>  	spin_lock_bh(&msk->join_list_lock);
> -	list_for_each_entry(subflow, &msk->join_list, node)
> -		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
> +	list_for_each_entry(subflow, &msk->join_list, node) {
> +		u32 sseq = READ_ONCE(subflow->setsockopt_seq);
>  
> +		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
> +		if (READ_ONCE(msk->setsockopt_seq) != sseq)
> +			ret = true;

I'm a bit lost WRT 'ret' scope. I don't see where it's initialized.
Does the compiler emit a warning here?

Perhaps moving the 'ret' variable definition to this patch will makes
the things clearer?!?

> +	}
>  	list_splice_tail_init(&msk->join_list, &msk->conn_list);
>  	spin_unlock_bh(&msk->join_list_lock);
>  
> @@ -745,7 +748,8 @@ void __mptcp_flush_join_list(struct mptcp_sock *msk)
>  	if (likely(!mptcp_do_flush_join_list(msk)))
>  		return;
>  
> -	if (!test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
> +	if (msk->setsockopt_seq &&
> +	    !test_and_set_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags))
>  		mptcp_schedule_work((struct sock *)msk);

It's not obvious to me why the 'msk->setsockopt_seq' check is needed
here (and in the below chunk) ???

Perhaps a comment would help?

Cheers,

Paolo


