Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4E26F
	for <mptcp@lists.linux.dev>; Thu, 25 Mar 2021 13:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1616678005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NA8AfvLzAQLA/RUTzXuHZ9iQzsF6M5H1TycpXaMvMv8=;
	b=GJu4D7AIRoV1Epn05Pr9sNGCZFnwFoU2b2NyYzmA0wNL5xoizkz7E8voPKpnR0ojRljVXB
	5AtGZcfImR0H5GYxnJT7/u2dMh5LeVCjoUSAqg29gqiHSC4oBf7KcmrUULa7IPoilLDY6v
	T45tu9rp29sKC82RkW1om/TvcwsPZHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7--MGYyN7qOUSC7q0OgWmTLw-1; Thu, 25 Mar 2021 09:13:21 -0400
X-MC-Unique: -MGYyN7qOUSC7q0OgWmTLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EAF1108BCAE;
	Thu, 25 Mar 2021 13:12:51 +0000 (UTC)
Received: from ovpn-113-211.ams2.redhat.com (ovpn-113-211.ams2.redhat.com [10.36.113.211])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4AF5919C71;
	Thu, 25 Mar 2021 13:12:50 +0000 (UTC)
Message-ID: <205a6dd33129312123ca863a8bab4aca23dad96b.camel@redhat.com>
Subject: Re: [MPTCP] [RFC PATCH mptcp-next v2 1/8] mptcp: add skeleton to
 sync msk socket options to subflows
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev, mptcp@lists.01.org
Date: Thu, 25 Mar 2021 14:12:49 +0100
In-Reply-To: <20210325124904.GB26567@breakpoint.cc>
References: <20210324131546.13730-1-fw@strlen.de>
	 <20210324131546.13730-2-fw@strlen.de>
	 <85febbb1c0b4dc7b73861fabdc846194f468f127.camel@redhat.com>
	 <20210324200148.GL22603@breakpoint.cc>
	 <2ee15b0397e7653f8d8cfd74d53398a6a5f0c19c.camel@redhat.com>
	 <20210325124904.GB26567@breakpoint.cc>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-03-25 at 13:49 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > > In the outgoing case, the subflow isn't linked to the conn_list yet.
> > 
> > My bad! I did not recall we use join_list even for outgoing subflows...
> > I'm wondering if we could move them directly in conn_list
> > inside __mptcp_subflow_connect()? I think it should not be problematic.
> 
> I thought conn_list was only allowed to contain full subflows, but I see
> that scheduler skips subflows with incomplete join.
> 
> But such change doesn't appear to be related to this one.

Yep.

> > > I'm not sure all options have this 'inherited from listener' behaviour.
> > 
> > Why not? the subflow socket is cloned from the listener TCP subflow. 
> > 
> > If tcp_create_openreq_child() does not propagate some socket option,
> > then the expected behaviour is probably not propagating it.
> 
> Ok, so you propose to init ssk->sockopt_seq to msk->sockopt_seq in
> mptcp_accept()?

in subflow_syn_recv_sock(), but only if we can avoid incrementing  msk-
>sockopt_seq on per setsockopt basis, otherwise things will be
crippled:

socket(s1)
setsockopt(s1)
listen(s1)

s2 = accept()

setsockopt(s2)
setsockopt(s1, <a different sockopt from the above>)

At this point, if we increment sockopt_seq after everu sockopt, s1-
>sockopt_seq and s2->sockopt_seq will be equal (and we will not sync
any mpj subflow accepted later if propagate sockopt_seq to ssk). 

Instead, if we set sockopt_seq to some socket status related value
after every setsockopt(), s2->sockopt_seq and s1->sockopt_seq will be
different and we will sync later MPJ subflows.

Perhaps we can keep the things as-is to and ev change/improve in a
second time?

Paolo

