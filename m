Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB4C433DB
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:34:05 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD05364F68
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD05364F68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 24ADF100EB34A;
	Fri, 19 Mar 2021 04:34:04 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D8513100EB325
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616153640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e8Pnd2hIC7XUObQ9IeO97EBSdaqoz0fqByHEZrI1ujQ=;
	b=SyA969wBYCHN9lJCWO6/VXjLpODQxD7IVCyqSzhIlVoxJe7K63MpdW09B93ssP1to+wltw
	tZP6zPy4UQxuEDKxq/uKy6+SglGFhX2BKK3q0leJ1mhf6/HbiDUbo9IgCbazUZg5CZV9Rp
	5FNtIAQXh2pLJRs2LN93/4jBfv8me9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-eqS-vEN7N4evEttSprSvVw-1; Fri, 19 Mar 2021 07:33:58 -0400
X-MC-Unique: eqS-vEN7N4evEttSprSvVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26E7F101371C;
	Fri, 19 Mar 2021 11:33:57 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4968461F47;
	Fri, 19 Mar 2021 11:33:56 +0000 (UTC)
Message-ID: <d959555cddeb70f6771f58fd0b69f2b66e7b10cd.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.01.org
Date: Fri, 19 Mar 2021 12:33:55 +0100
In-Reply-To: <20210317163828.27406-2-fw@strlen.de>
References: <20210317163828.27406-1-fw@strlen.de>
	 <20210317163828.27406-2-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: RKCYCYPKOFWQLY2OX2MMJGNMBXFBONWD
X-Message-ID-Hash: RKCYCYPKOFWQLY2OX2MMJGNMBXFBONWD
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 1/9] mptcp: add skeleton to sync msk socket options to subflows
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/RKCYCYPKOFWQLY2OX2MMJGNMBXFBONWD/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

First thing first, thank you for this great effort!

On Wed, 2021-03-17 at 17:38 +0100, Florian Westphal wrote:
> Handle following cases:
> 1. setsockopt is called with multiple subflows.
>    Change might have to be mirrored to all of them.
> 2. Outgoing subflow is created after one or several setsockopt()
>    calls have been made.  Old setsockopt changes should be
>    synced to the new socket.
> 3. Like 2, but for incoming subflow.
>    This needs the work queue because socket lock (and in the future
>    possibly rtnl mutex) might be needed.
> 
> Add sequence numbers to subflow context and mptcp socket so
> synchronization functions know which subflow is already updated
> and which ones are not.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/protocol.c | 31 ++++++++++++++++++++++++++++---
>  net/mptcp/protocol.h | 12 ++++++++++++
>  net/mptcp/sockopt.c  | 27 +++++++++++++++++++++++++++
>  net/mptcp/subflow.c  |  1 +
>  4 files changed, 68 insertions(+), 3 deletions(-)
> 
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9d7e7e13fba8..0b9ef8ddff55 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -730,18 +730,42 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  		sk->sk_data_ready(sk);
>  }
>  
> -void __mptcp_flush_join_list(struct mptcp_sock *msk)
> +static bool mptcp_do_flush_join_list(struct mptcp_sock *msk)
>  {
>  	struct mptcp_subflow_context *subflow;
>  
>  	if (likely(list_empty(&msk->join_list)))
> -		return;
> +		return false;
>  
>  	spin_lock_bh(&msk->join_list_lock);
>  	list_for_each_entry(subflow, &msk->join_list, node)
>  		mptcp_propagate_sndbuf((struct sock *)msk, mptcp_subflow_tcp_sock(subflow));
>  	list_splice_tail_init(&msk->join_list, &msk->conn_list);
>  	spin_unlock_bh(&msk->join_list_lock);
> +
> +	return true;
> +}
> +
> +static void mptcp_work_flush_join_list(struct mptcp_sock *msk)
> +{
> +	bool sync_needed = test_and_clear_bit(MPTCP_WORK_SYNC_SETSOCKOPT, &msk->flags);
> +
> +	if (!mptcp_do_flush_join_list(msk) && !sync_needed)
> +		return;
> +
> +	mptcp_sockopt_sync_all(msk);
> +}
> +
> +void __mptcp_flush_join_list(struct mptcp_sock *msk)

There are a few __mptcp_flush_join_list() call-sites which are already
in process context, e.g.:

mptcp_stream_accept()
__mptcp_push_pending()
__mptcp_move_skbs()
mptcp_disconnect()

what renaming mptcp_work_flush_join_list() in mptcp_flush_join_list() -
or mptcp_work_flush_join_list_lock() or some better name - and use it
in the above places?

> @@ -2569,6 +2593,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
>  	xfrm_sk_free_policy(sk);
>  	sk_refcnt_debug_release(sk);
>  	mptcp_dispose_initial_subflow(msk);
> +

I guess the added empty line is not intentional? ;)

Thanks!

Paolo
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
