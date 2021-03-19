Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8F2C433DB
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 10:59:31 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB0864F1C
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 10:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB0864F1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9A929100EB34A;
	Fri, 19 Mar 2021 03:59:30 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=63.128.21.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 06619100EB325
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 03:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616151567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yOPir/QKgNJwHb3QJy5wkVXk7fDoe8P0OnX+Ii6Qq6g=;
	b=RUBeaRP3miOZJ8ozwCR78OZsPYLMXVsrRSJuMPQSdAi4h92D4IeuppI9F4K09n0UFMHOM5
	agwqTa2lDgoA7EuCN+Do9QUBYJ8ITbOxIOa1VZkdKGIE05yVMudZdtWSeNl2Lk22dKa8r9
	4KPJd/stv2G2EjVxNaY6UYnUUP+qQyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-ndr4G73DNX2BiX7-_0XROg-1; Fri, 19 Mar 2021 06:59:14 -0400
X-MC-Unique: ndr4G73DNX2BiX7-_0XROg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB568107ACCD;
	Fri, 19 Mar 2021 10:59:13 +0000 (UTC)
Received: from ovpn-112-226.ams2.redhat.com (ovpn-112-226.ams2.redhat.com [10.36.112.226])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0018B1992D;
	Fri, 19 Mar 2021 10:59:12 +0000 (UTC)
Message-ID: <fe87c0aa901db6734f43c0bfac8e931ca55b048c.camel@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, MPTCP Upstream
	 <mptcp@lists.01.org>
Date: Fri, 19 Mar 2021 11:59:11 +0100
In-Reply-To: <3781fd70-ab60-529b-a877-adc0b41c87fb@tessares.net>
References: <3781fd70-ab60-529b-a877-adc0b41c87fb@tessares.net>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: TMBG7BHFMHBDH7HY2KOZKUDOPDWQRDEA
X-Message-ID-Hash: TMBG7BHFMHBDH7HY2KOZKUDOPDWQRDEA
X-MailFrom: pabeni@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [Weekly meetings] MoM - 18th of March 2021
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/TMBG7BHFMHBDH7HY2KOZKUDOPDWQRDEA/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

I'm sorry for skipping this mtg.
On Thu, 2021-03-18 at 18:22 +0100, Matthieu Baerts wrote:
> Patches to send to netdev:
>      - net:
>          - nothing to send
> 
>      - net-next:
>          - Maybe sockopt allowance list by Paolo?:
>              - Or do we want to wait to have syzkaller exercising them more?
>              - Or better to expose it to netdev ASAP?
>              - *@Paolo* : what do you think? :)

I would wait a bit for the additional sockopt patches from Florian.

> sockopt allowance list:
>      - What to do for -net and maybe stable branches?
>      - Should we send the 3 patches to -net to have something close to 
> net-next and ease future backports/maintenance?
>      - Or only blacklist the MCast sockopts?
>      - *@Paolo* : what do you think? :)

I would opt for the blacklist, more -net like.
> Netdev:
>      - 0x15 next summer (July): 
> https://netdevconf.info/0x15/submit-proposal.html
>      - Might be a remote conf only

I hate remote conf :(

Cheers,

Paolo
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
