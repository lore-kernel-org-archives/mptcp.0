Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151BC433E0
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 14:36:56 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FC564F18
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 14:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FC564F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A5515100F227A;
	Fri, 19 Mar 2021 07:36:55 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DAC77100F2251
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616164612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPa1VFuCqQJ90534PhdDZ8TObEPXxL+rJDN4SR98+y8=;
	b=LtU3pWA1Op6oTvuIxEbCBoR1jtRNS3bVLwfYYw0E3nX2oPvJ3KyOREKe5E2/TCpKV5xbOV
	hdZnHLhCJQYd08ZRg8XoMxpVJa02Qlkp3ZcR2ylB1ufDhlpQAH2jS5+iY0i8f6lmK3Fn7o
	lSzsIOAEdVPO2viH29rKRgazGbA2X4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-guGpenLQMPGQlc2Mw9oJkw-1; Fri, 19 Mar 2021 10:36:51 -0400
X-MC-Unique: guGpenLQMPGQlc2Mw9oJkw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E7C107ACCA;
	Fri, 19 Mar 2021 14:36:49 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3A166A83C;
	Fri, 19 Mar 2021 14:36:48 +0000 (UTC)
Message-ID: <288657858ef194d8ee469bf64fd38d4f5952a989.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Date: Fri, 19 Mar 2021 15:36:47 +0100
In-Reply-To: <20210319123433.GE22603@breakpoint.cc>
References: <20210317163828.27406-1-fw@strlen.de>
	 <20210317163828.27406-2-fw@strlen.de>
	 <d959555cddeb70f6771f58fd0b69f2b66e7b10cd.camel@redhat.com>
	 <20210319123433.GE22603@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: W3RRHQXGJK5SZTEAILAIT5UDRZQU4AGB
X-Message-ID-Hash: W3RRHQXGJK5SZTEAILAIT5UDRZQU4AGB
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: mptcp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 1/9] mptcp: add skeleton to sync msk socket options to subflows
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/W3RRHQXGJK5SZTEAILAIT5UDRZQU4AGB/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2021-03-19 at 13:34 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > There are a few __mptcp_flush_join_list() call-sites which are already
> > in process context, e.g.:
> > 
> > mptcp_stream_accept()
> > __mptcp_push_pending()
> > __mptcp_move_skbs()
> > mptcp_disconnect()
> > 
> > what renaming mptcp_work_flush_join_list() in mptcp_flush_join_list() -
> > or mptcp_work_flush_join_list_lock() or some better name - and use it
> > in the above places?
> 
> What would be the advanage?

Uhmm... the need for synchronization should be quite a rare event,
right? I guess we can affort calling the workqueue on such occasion,
but it's a bit strange to me schedule the workqueue to get process
context when alredy in process context.

BTW there a few scenarios which are not 110% clear to me:

1)
listen(s0)
s1 = accept() // main msk

setsockopt(s1, a)

[2nd subflow is accepted]
// s1->setsockopt_seq == 1, s1->setsockopt_seq _old == 0

mptcp_sockopt_sync_all()
// s1->setsockopt_seq _old == 1

[3rd subflow is accepted]
// s1->setsockopt_seq == 1, s1->setsockopt_seq _old == 1, no
synchronzation ?!?
// but the 3rd subflow will inherit it's sockopt from s0, so
// it should need that?

2)
listen(s0)
s1 = accept() // main msk

setsockopt(s0, a)

[2nd subflow is accepted, after the above sockopt]
// s1->setsockopt_seq == 0, s1->setsockopt_seq _old == 0, no
// synchronzation ?!?
// but the 2nd subflow have different options inherited by s0?!?

3)
subflow generated by port-based endpoint

I think we need some additional handling for the above ?!? e.g.
fetching setsockopt_seq_old from the listener sockets into the subflow
at syn_recv time and in _flush_join_list do/schedule the
synchronization if at least a subflow has setsockopt_seq != msk-
>setsockopt_seq.

please let me know if the above makes any sense ;)

/P
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
