Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B5C4160E
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 12:19:42 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7392F64F73
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 12:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7392F64F73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id ADCB9100EB343;
	Fri, 19 Mar 2021 05:19:39 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57882100EB831
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 05:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616156375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LujRk05nFKEATq3E2LItYn4Ye1bYt8jlVQzAnX19KQw=;
	b=Q0kh9uPhw409AWibCof794PedAsISjB2kp2y0LZzyLg78ELI76535TG0U5Z6dmXICPlpqr
	PnQe/R3F4tYB0/KpXJ6cllZ6bLaaLzvIfF7s4qtfX9EVmkSBZ4GrSTVff9VDX6Uw3+rt04
	RnrN2nhFRz9jsqrhADxNdjHTwzyMVFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Uj4uv9-tOnKJIFOd8_zQyQ-1; Fri, 19 Mar 2021 08:19:34 -0400
X-MC-Unique: Uj4uv9-tOnKJIFOd8_zQyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 072021009446;
	Fri, 19 Mar 2021 12:19:33 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3B55DAA5;
	Fri, 19 Mar 2021 12:19:32 +0000 (UTC)
Message-ID: <e5cc59fac14e9da9b3964dca233af2e334fbb691.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.01.org
Date: Fri, 19 Mar 2021 13:19:31 +0100
In-Reply-To: <20210317163828.27406-9-fw@strlen.de>
References: <20210317163828.27406-1-fw@strlen.de>
	 <20210317163828.27406-9-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: TFKJB6TYI4NDUXAEB7S2JSW4T7NCAQX6
X-Message-ID-Hash: TFKJB6TYI4NDUXAEB7S2JSW4T7NCAQX6
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 8/9] mptcp: sockopt: add TCP_CONGESTION
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/TFKJB6TYI4NDUXAEB7S2JSW4T7NCAQX6/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-17 at 17:38 +0100, Florian Westphal wrote:
> @@ -585,6 +625,47 @@ int mptcp_setsockopt(struct sock *sk, int level, int optname,
>  	if (level == SOL_IPV6)
>  		return mptcp_setsockopt_v6(msk, optname, optval, optlen);
>  
> +	if (level == SOL_TCP)
> +		return mptcp_setsockopt_sol_tcp(msk, optname, optval, optlen);
> +
> +	return -EOPNOTSUPP;
> +}

Side notes not really related to this patch, but to the code near
here;)

I think we could call  __mptcp_check_fallback() before acquiring the
lock, so that in the non fallback case we could avoid acquring the msk
lock.

I think we also need to sync also sk_reuseport/sk_reuse/sk_ipv6only ?!?

I don't see where msk->setsockopt_seq is incremented. I expected to
find that on successful mptcp_setsockopt() but I missed the relevant
code ?!?

/P
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
