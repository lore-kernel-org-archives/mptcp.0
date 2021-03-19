Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB6AC433E0
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:43:33 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A38664EF2
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A38664EF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id CBCE8100EB34A;
	Fri, 19 Mar 2021 04:43:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B76E6100EB325
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616154209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SyuanvRpmJcMFakCyJoP9icskcKYJCFp15V2c+g0cqI=;
	b=cfJye2cMxiCvyCpeIEhn+uVIyX8TLisZ7LNumSxR/OksEIvrgqQCZrptfQb1QPpu3eIvr9
	rCWTdEjkVUPUtWl4ahDfOjQWHn2sywDZg8xp6g+qyZMzLoLepd0wmPEcXyuuf/uKGEWX6a
	EnMBWWVsbzPTJPZZseODAzfkInGOMjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-8qqD1A7FMQir5dHlXi4zYQ-1; Fri, 19 Mar 2021 07:43:27 -0400
X-MC-Unique: 8qqD1A7FMQir5dHlXi4zYQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4C75107B76D;
	Fri, 19 Mar 2021 11:43:26 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0C8055D6D5;
	Fri, 19 Mar 2021 11:43:25 +0000 (UTC)
Message-ID: <c4092e153876000c736bd5ba93a0f9edc240399d.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.01.org
Date: Fri, 19 Mar 2021 12:43:23 +0100
In-Reply-To: <20210317163828.27406-3-fw@strlen.de>
References: <20210317163828.27406-1-fw@strlen.de>
	 <20210317163828.27406-3-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: FPKL7XYAQEMLFIJE4QEH7EEJGA23B4UT
X-Message-ID-Hash: FPKL7XYAQEMLFIJE4QEH7EEJGA23B4UT
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 2/9] mptcp: setsockopt: handle SO_KEEPALIVE and SO_PRIORITY
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/FPKL7XYAQEMLFIJE4QEH7EEJGA23B4UT/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-17 at 17:38 +0100, Florian Westphal wrote:
> start with something simple: both take an integer value, both
> need to be mirrored to all subflows.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  net/mptcp/sockopt.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fa71216e11a3..33ca67e99f8f 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -24,6 +24,81 @@ static struct sock *__mptcp_tcp_fallback(struct mptcp_sock *msk)
>  	return msk->first;
>  }
>  
> +static int mptcp_get_int_option(struct mptcp_sock *msk, sockptr_t optval, unsigned int optlen, int *val)
> +{
> +	if (optlen < sizeof(int))
> +		return -EINVAL;
> +
> +	if (copy_from_sockptr(val, optval, sizeof(*val)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static void mptcp_so_keepalive(struct mptcp_sock *msk, int val)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	struct sock *sk = (struct sock *)msk;
> +
> +	lock_sock(sk);
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		bool slow = lock_sock_fast(ssk);

Can we reduce the code duplication moving this chunk - msk lock, loop
across the subflows - in mptcp_setsockopt_sol_socket_int() ? the main
switch will be inside the for each loop.

We will end-up acquiring the ssk sock lock more then once/more than
strictily required, but perhaps a bunch of line less ??? WDYT?

(I think this can apply also to a few next patches)

/P
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
