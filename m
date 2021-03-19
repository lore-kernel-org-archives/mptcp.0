Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89AAC433DB
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:54:16 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397FF64F65
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 11:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397FF64F65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B8D70100EB34A;
	Fri, 19 Mar 2021 04:54:15 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A79C5100EB325
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 04:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616154852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gb2SF38frtmI+PjSTLv7muySP/agjMcBdqFdcPfNQ+M=;
	b=CpkDM8zD3VUmr47oHqDmqA1FDoXYbU9R4kKsin3fcAsYe8f11sJuKx2Nf5WSz2aQIi/BJd
	rKeFzYcGQnO9jLRSLsqlCfqKKZ44gIn3+RxSF3lZG8Rj5zNQfE3p6SNgrFs3r30jl6VW3V
	P+YPGACYeUyNfsRUHzcRv0p1KfyWUCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-BKKDpG-FOS-14Ak3leQ0GA-1; Fri, 19 Mar 2021 07:54:10 -0400
X-MC-Unique: BKKDpG-FOS-14Ak3leQ0GA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2505A81431D;
	Fri, 19 Mar 2021 11:54:09 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5955B60871;
	Fri, 19 Mar 2021 11:54:08 +0000 (UTC)
Message-ID: <078ccd575691ff1b6527367f86181cb95c421db8.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, mptcp@lists.01.org
Date: Fri, 19 Mar 2021 12:54:07 +0100
In-Reply-To: <20210317163828.27406-9-fw@strlen.de>
References: <20210317163828.27406-1-fw@strlen.de>
	 <20210317163828.27406-9-fw@strlen.de>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: 3OA5YHLJOAPNR5YGZUUJKM7JULFXZJD3
X-Message-ID-Hash: 3OA5YHLJOAPNR5YGZUUJKM7JULFXZJD3
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 8/9] mptcp: sockopt: add TCP_CONGESTION
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/3OA5YHLJOAPNR5YGZUUJKM7JULFXZJD3/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, 2021-03-17 at 17:38 +0100, Florian Westphal wrote:
> Make this interact with the initial subflow only, as that is the one
> exposed to userspace (connect, bind).

I'm wondering if we should instead propagate the CG algo to all
subflows ??! I see this is possibly subject to personal taste - and
mine is notoriously not good ;) Do you have strong preference here?

Thanks!

Paolo


_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
