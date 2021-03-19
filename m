Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F82C433E0
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:44:48 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DC764EBB
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DC764EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EE438100EB34A;
	Fri, 19 Mar 2021 04:44:47 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 324E0100EB325
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 04:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616154284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJbondoRHlRnljlTJprhLlRc+5T7s/n9xdwZy3290bM=;
	b=WkkJsLrbbmrbpMFGSXgJdrSk6u5hHjC1O0XFS3hAztv/orJV+/wLPU0gBCqyXoNKTb039I
	lZx+vYzrPaM+KQ+JbWRb63ASEdBnPNmfJfxGPRplEeGs/Y95ds1BwwC/bhk9h2a8Va+zVM
	AAK8ix2QqDiW0B05cPmekq8Tx6ug55M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-GvtXlFnAPwW3qn_KuIHdxg-1; Fri, 19 Mar 2021 07:44:42 -0400
X-MC-Unique: GvtXlFnAPwW3qn_KuIHdxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D2D1007476;
	Fri, 19 Mar 2021 11:44:41 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BEED81992D;
	Fri, 19 Mar 2021 11:44:40 +0000 (UTC)
Message-ID: <cb98a92cc776c730c89c992182441bcf38561ae8.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.01.org
Date: Fri, 19 Mar 2021 12:44:39 +0100
In-Reply-To: <20210317163828.27406-4-fw@strlen.de>
References: <20210317163828.27406-1-fw@strlen.de>
	 <20210317163828.27406-4-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: MVUPSJYGIH7MVWUSDRJ6I5HQFCMH3EON
X-Message-ID-Hash: MVUPSJYGIH7MVWUSDRJ6I5HQFCMH3EON
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 3/9] mptcp: setsockopt: handle receive/send buffer and device bind
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/MVUPSJYGIH7MVWUSDRJ6I5HQFCMH3EON/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-17 at 17:38 +0100, Florian Westphal wrote:
> Similar to previous patch: needs to be mirrored to all subflows.
> 
> Device bind is simpler: it is only done on the initial (listener) sk.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/sockopt.c | 51 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 33ca67e99f8f..9a87c50e21a4 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -79,6 +79,38 @@ static int mptcp_so_priority(struct mptcp_sock *msk, int val)
>  	return 0;
>  }
>  
> +static int mptcp_so_sndrcvbuf(struct mptcp_sock *msk, int optname, int val)
> +{
> +	sockptr_t optval = KERNEL_SOCKPTR(&val);
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +	int ret;
> +
> +	ret = sock_setsockopt(sk->sk_socket, SOL_SOCKET, optname,
> +			      optval, sizeof(val));
> +	if (ret)
> +		return ret;
> +
> +	lock_sock(sk);
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow = lock_sock_fast(ssk);
> +		unsigned int ulock;
> +
> +		ulock = sk->sk_userlocks;
> +		ulock &= SOCK_SNDBUF_LOCK | SOCK_RCVBUF_LOCK;
> +
> +		ssk->sk_priority = val;
> +		ssk->sk_userlocks |= ulock;
> +		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
> +		WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);

I guess we should overwrite the snd/rcv buf size only if the
corrensponding LOCK is set ?!? The same below in the synchronization
part.

Cheers,

Paolo
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
