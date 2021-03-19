Return-Path: <SRS0=nStN=IR=lists.01.org=mptcp-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE1DC433DB
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 12:37:14 +0000 (UTC)
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3CE64EE7
	for <mptcp@archiver.kernel.org>; Fri, 19 Mar 2021 12:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3CE64EE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mptcp-bounces@lists.01.org
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 57BBB100EB34A;
	Fri, 19 Mar 2021 05:37:14 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:51c0:0:12e:520::1; helo=chamillionaire.breakpoint.cc; envelope-from=fw@strlen.de; receiver=<UNKNOWN> 
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0E4D5100EB325
	for <mptcp@lists.01.org>; Fri, 19 Mar 2021 05:37:12 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1lNENK-0006rc-K9; Fri, 19 Mar 2021 13:37:10 +0100
Date: Fri, 19 Mar 2021 13:37:10 +0100
From: Florian Westphal <fw@strlen.de>
To: Paolo Abeni <pabeni@redhat.com>
Message-ID: <20210319123710.GG22603@breakpoint.cc>
References: <20210317163828.27406-1-fw@strlen.de>
 <20210317163828.27406-4-fw@strlen.de>
 <cb98a92cc776c730c89c992182441bcf38561ae8.camel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cb98a92cc776c730c89c992182441bcf38561ae8.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: JBPWOPBIWIABFBOA6DK2ZZI6NCBCOXBU
X-Message-ID-Hash: JBPWOPBIWIABFBOA6DK2ZZI6NCBCOXBU
X-MailFrom: fw@strlen.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: mptcp@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
Subject: [MPTCP] Re: [PATCH mptcp-next 3/9] mptcp: setsockopt: handle receive/send buffer and device bind
List-Id: Discussions regarding MPTCP upstreaming <mptcp.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/JBPWOPBIWIABFBOA6DK2ZZI6NCBCOXBU/>
List-Archive: <https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/>
List-Help: <mailto:mptcp-request@lists.01.org?subject=help>
List-Post: <mailto:mptcp@lists.01.org>
List-Subscribe: <mailto:mptcp-join@lists.01.org>
List-Unsubscribe: <mailto:mptcp-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Paolo Abeni <pabeni@redhat.com> wrote:
> > +	lock_sock(sk);
> > +	mptcp_for_each_subflow(msk, subflow) {
> > +		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> > +		bool slow = lock_sock_fast(ssk);
> > +		unsigned int ulock;
> > +
> > +		ulock = sk->sk_userlocks;
> > +		ulock &= SOCK_SNDBUF_LOCK | SOCK_RCVBUF_LOCK;
> > +
> > +		ssk->sk_priority = val;
> > +		ssk->sk_userlocks |= ulock;
> > +		WRITE_ONCE(ssk->sk_sndbuf, sk->sk_sndbuf);
> > +		WRITE_ONCE(ssk->sk_rcvbuf, sk->sk_rcvbuf);
> 
> I guess we should overwrite the snd/rcv buf size only if the
> corrensponding LOCK is set ?!? The same below in the synchronization
> part.

Right, user might lock RCVBUF but not SNDBUF, I'll add a test.
_______________________________________________
mptcp mailing list -- mptcp@lists.01.org
To unsubscribe send an email to mptcp-leave@lists.01.org
