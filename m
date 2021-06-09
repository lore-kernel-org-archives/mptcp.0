Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815AD70
	for <mptcp@lists.linux.dev>; Wed,  9 Jun 2021 14:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1623248330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DSmFlgdPfD57MHzZc3K1Kchn4BloNaKYKXP+LWwH1pQ=;
	b=bjb5zb6sNrdCZO5QKXHQOsQEIDEsQHg103hPQrF/oYtpWLVBkTzTeORw6FDIRr9RZxQ7lS
	6A+GPd7k/MwEL7BE1vBMrMdCTn4tELQx+1Gq3PihAu2Bjc0mvUDRNDEl4mZNb7x9ZdTWrY
	aTGCOUeyq2KoVakLjVftHjMTGo8JmTI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-vCoJZTMhNEeMgowHNbthKA-1; Wed, 09 Jun 2021 10:18:49 -0400
X-MC-Unique: vCoJZTMhNEeMgowHNbthKA-1
Received: by mail-wr1-f70.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so10863838wrs.5
        for <mptcp@lists.linux.dev>; Wed, 09 Jun 2021 07:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DSmFlgdPfD57MHzZc3K1Kchn4BloNaKYKXP+LWwH1pQ=;
        b=Qoat5py2qqTxVJOy0fOZEYZVFd4nhPkPH+nQeqaN/xUxu7fDOapxp/nTiGGVC/JJ8Z
         UcokYfZgZLUMuJ22VrzX6HVAp8DWFxJ4mFCGeM4HQcLvTsWUQVbrboqovNFgOWPJkYEJ
         uzFyMVoUU360yGMBTgTZAm68eyT6rZvAij9O0E4mB4+/pODGxdmQRSHn8q2KExjBQFid
         VUxanxlYPY2l87bQEIzgB4MFoTDHa0M+3DObRe8tOQVviKrr1AK8JeR0JX7QbXr+czwS
         fPEeqNpqGriN+j5xmHYrwm/WnO5UkehTEyUYZZfh3q2Af77k4mu6pFFNTv+RfOAHatkb
         B0pg==
X-Gm-Message-State: AOAM53035GjszrqBel8+0r0zlIyKC/pqngqF7DjstK0N7kJerDJmMuEa
	tNnU4KnJwPZks7LNg3VQydU8rZ2EKabT/evBvBNLy1VFYSqqa7Cl5ZaZXQUR6M/d5cP6+y3JwR7
	5HtO4jU9NQ5wNjKM=
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr46444wma.85.1623248328082;
        Wed, 09 Jun 2021 07:18:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfu2ABTA/Fj43pWArK/8+FMzF9h6iZv7tB2D+G/P6QEaop6QRWhp1MnFvb48RPp04OmI07GQ==
X-Received: by 2002:a1c:3c89:: with SMTP id j131mr46422wma.85.1623248327870;
        Wed, 09 Jun 2021 07:18:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-109-224.dyn.eolo.it. [146.241.109.224])
        by smtp.gmail.com with ESMTPSA id v18sm110035wrb.10.2021.06.09.07.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:18:47 -0700 (PDT)
Message-ID: <b0a8abf413fa78323f58be466015d665a1bc6f84.camel@redhat.com>
Subject: Re: [PATCH 3/3] mptcp: fix syncookie process if mptcp can
 not_accept new subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Jianguo Wu <wujianguo106@163.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
Date: Wed, 09 Jun 2021 16:18:46 +0200
In-Reply-To: <1034de3d-5528-ea65-6deb-8a67955f1042@163.com>
References: <1034de3d-5528-ea65-6deb-8a67955f1042@163.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

On Wed, 2021-06-09 at 18:39 +0800, Jianguo Wu wrote:
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side when doing stress testing.
> There are at least two cases may trigger this warning:
> 1. mptcp is in syncookie, and server recv MP_JOIN SYN request, in subflow_check_req(),
>    the mptcp_can_accept_new_subflow() return false, so subflow_init_req_cookie_join_save()
>    isn't called, i.e. not store the data present in the MP_JOIN syn request and the random
>    nonce in hash table - join_entries[], but still send synack. When recv 3rd-ack,
>    mptcp_token_join_cookie_init_state() will return false, and 3rd-ack is dropped, then if mptcp
>    conn is closed by client, client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN doesn't have
>    MP_CAPABLE or MP_JOIN, so mptcp_subflow_init_cookie_req() will return 0, and pass the cookie check,
>    MP_JOIN request is fallback to normal TCP. Server will send a TCP FIN if closed, in client side,
>    when process TCP FIN, it will do reset, the code path is:
>      tcp_data_queue()->mptcp_incoming_options()->check_fully_established()->mptcp_subflow_reset().
>    mptcp_subflow_reset() will set sock state to TCP_CLOSE, so tcp_fin will hit TCP_CLOSE, and print the warning.
> 2. mptcp is in syncookie, and server recv 3rd-ack, in mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
>    return false, and subflow_req->mp_join is not set to 1, so in subflow_syn_recv_sock() will not reset the MP_JOIN
>    subflow, but fallback to normal TCP, and then the same thing happens when server will send a TCP FIN if closed.

Minor nit: each line in the commit message should not be longer than 72
chars.

> For case1, subflow_check_req() return -EPERM, then tcp_conn_request() will drop MP_JOIN SYN.
> For case2, let subflow_syn_recv_sock() do mptcp_can_accept_new_subflow() check, and do fatal fallback, send reset.

Possibly worthy 2 separate patches.

pktdrill test cases would help.

I still have to wrap my mind on the above, still I have a relevant
comment, see below...

> And do sanity check in tcp_data_queue().
> 
> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
>  net/ipv4/tcp_input.c | 7 ++++++-
>  net/mptcp/subflow.c  | 6 +++---
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 7d5e59f..537f24a 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4941,8 +4941,13 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>  	bool fragstolen;
>  	int eaten;
> 
> -	if (sk_is_mptcp(sk))
> +	if (sk_is_mptcp(sk)) {
>  		mptcp_incoming_options(sk, skb);
> +		if (sk->sk_state == TCP_CLOSE) {
> +			__kfree_skb(skb);
> +			return;
> +		}
> +	}

_if_ I read correctly the commit message, this is needed to avoid
processing FIN packets on
when check_fully_established()/check_fully_established() causes a
subflow reset.

I think we can handle the above in the MPTCP code - in
check_fully_established() -  setting:

	TCP_SKB_CB(skb)->end_seq = TCP_SKB_CB(skb)->seq;

so that the following check will drop the pkt:

>  	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>  		__kfree_skb(skb);
> 

/P

