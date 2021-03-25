Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [63.128.21.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6D5F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616682825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lisi1n3ERwTw6kI/Zn+B17CXS8IvyrJiLo+RNT5ImvM=;
	b=HAA6exke7Cqo+QtPTuR3tJH9RKGsnhkjFAh3ayxBC/XByQnlW4GNQ+pRuNi1LCtmzvK7lG
	iTNFR9FpJveglk/CbaOrzJtQDRpU5GS553sof+C+1ILTvp2bxwH9Dc5en0lu8U+2ETa33Y
	7Oe7D2K5TWAvqQf8CbR9yg6SU770v8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-IM3DBgVGOcGBAFfOfhngnw-1; Thu, 25 Mar 2021 10:33:43 -0400
X-MC-Unique: IM3DBgVGOcGBAFfOfhngnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5140190A7A0;
	Thu, 25 Mar 2021 14:33:42 +0000 (UTC)
Received: from ovpn-113-211.ams2.redhat.com (ovpn-113-211.ams2.redhat.com [10.36.113.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5DB025D736;
	Thu, 25 Mar 2021 14:33:41 +0000 (UTC)
Message-ID: <027b859a6f5dd1f03ad6d1c56376dc19d5d2af5b.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, mptcp@lists.01.org
Date: Thu, 25 Mar 2021 15:33:40 +0100
In-Reply-To: <20210325140603.GA8998@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
	 <20210324131546.13730-2-fw@strlen.de>
	 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
	 <20210324200148.GL22603@breakpoint.cc>
	 <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
	 <20210325124904.GB26567@breakpoint.cc>
	 <205a6dd33129312123ca863a8bab4aca23dad96b.camel@redhat.com>
	 <20210325140603.GA8998@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-03-25 at 15:06 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > > Ok, so you propose to init ssk->sockopt_seq to msk->sockopt_seq in
> > > mptcp_accept()?
> > 
> > in subflow_syn_recv_sock(), but only if we can avoid incrementing  msk-
> > > sockopt_seq on per setsockopt basis, otherwise things will be
> > crippled:
> > 
> > socket(s1)
> > setsockopt(s1)   // s1->seq 1
> > listen(s1)
> > 
> > s2 = accept() s2->seq == s1->seq == ssk->seq
> > 
> > setsockopt(s2)   s2->seq = 2
> > setsockopt(s1, <a different sockopt from the above>) s1->seq = 2
> > 
> > At this point, if we increment sockopt_seq after everu sockopt, s1-
> > > sockopt_seq and s2->sockopt_seq will be equal (and we will not sync
> > any mpj subflow accepted later if propagate sockopt_seq to ssk). 
> 
> Sorry, I am not following.
> 
> The ssk (s2 msk->first) has ssk->seq 1, s2 msk has 2, so this would be
> synced again on completion.
> 
> I don't understand how s1 and s2 are related.
> This is too complicated for me :(

s1 is an msk listener socket. It will get 2 setsockopt() syscall, so
s1->sockopt_seq == 2.

Even s2->sockopt_seq == 2, as you noted.

If we copy msk->sockopt_seq into ssk->sockopt_seq, any additional MPJ
subflow joining s2 created after the above syscalls sequence, will
get sockopt_seq == 2, (inherited by s1->sockopt_seq), so will not be
synched, even if synchronization will be needed.

Not sure if the above is less confusing ?!?

> > Instead, if we set sockopt_seq to some socket status related value
> > after every setsockopt(), s2->sockopt_seq and s1->sockopt_seq will be
> > different and we will sync later MPJ subflows.
> 
> What is a 'socket status related value'?

I mean something that changes when 'sk->sk_state' changes. Even plain
'sk->sk_state'.

> > Perhaps we can keep the things as-is to and ev change/improve in a
> > second time?
> 
> I am confused, you mean leave it as-is, i.e. scratch this patch set
> and retry (new per-subflow sockopt api for instance)?
> 
> Or leave this RFC v2 as-is and see if we can improve the sync strategy
> later?

the latter, of course! I mean, keep this v2 as is.

Sorry for the lack of clarity,

/P



