Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048043FC8
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 09:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632217462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uwO1h3ZWe5FYAWCwhAsoyVyAb4QN88Ri4FL3gorMqcM=;
	b=Ez/qPm22urO7MBOVU7UEPmMei86TCewvavhLz6/UoGR1X30tw6GzswfVAgYJW1YK52c8lR
	oJASOAI8hIuZ65zvXJXOcZ4hbxRPBIJkzYPFy66yw6AYuasbvzSOpyUwicq6MtD03Wapm6
	DxOPWcMJfeZro0TAx4ycNvJIYKj1T4I=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-a_RoAPcIMvekAirnuW17bg-1; Tue, 21 Sep 2021 05:44:20 -0400
X-MC-Unique: a_RoAPcIMvekAirnuW17bg-1
Received: by mail-wr1-f71.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so8334056wrt.9
        for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 02:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uwO1h3ZWe5FYAWCwhAsoyVyAb4QN88Ri4FL3gorMqcM=;
        b=PCPHiKplMXZWLD2byRlC0/bJqcZ99l2gKLzbQ5I7gg+0YMxB2FfX+uM1C8rAwlvw/p
         vuP+L5TZLifzr4l6IR0oGDWYK4Y57d66VIP6KXr3fPvFoQzWxPfJgTjDtyIgK6BWKVUC
         wAvdKIHTLzNfbnFncnmAHBgWTXFQSgdk1efL+AwR17pEjUwvcjt5yZPjq+1K5F5CyeBb
         7IZVGBUqYjhxvzOy2sM0diSK9jjv2GtLLqMtgjvJM+IlS1R9cXmMqOG8w7lz46P3m5Gq
         QSE4FQJXQeYUpdoB8QKCMO0+kk7yrPFDTIIIIeAr7LmsNMJ02Ed1xAOxzDH83/flexpP
         +edA==
X-Gm-Message-State: AOAM531BTMcflrzTJV5oid9zBQvZIDx4I6HQureJ05Kn/z6OOJzr4FIg
	35GVDnBUwp5Dje5hx2DEOugg8+g/qflMtYltKjqlSK1uftMTFULbz1n7mxkxU0A7sdwTKigdJJM
	IuJcbUResmXa/Z2s=
X-Received: by 2002:a1c:9d96:: with SMTP id g144mr3693472wme.12.1632217459592;
        Tue, 21 Sep 2021 02:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0kcMtCxdtBE7itqKg40lnMloftPzm9KIBCwyiKdHKseivLCB8pQbvlupr4+FkvB3KZFejuw==
X-Received: by 2002:a1c:9d96:: with SMTP id g144mr3693452wme.12.1632217459326;
        Tue, 21 Sep 2021 02:44:19 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id q11sm2301162wmc.41.2021.09.21.02.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 02:44:19 -0700 (PDT)
Message-ID: <7358252668b1e3d188571d8c85c991e58faea442.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 3/3] tcp: make tcp_build_frag() static
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Tue, 21 Sep 2021 11:44:17 +0200
In-Reply-To: <65edea-2573-d19f-8ab3-d0afe16b808a@linux.intel.com>
References: <cover.1632158356.git.pabeni@redhat.com>
	 <1949660e9af338adc8913b7cdf8c632401d6d6e0.1632158356.git.pabeni@redhat.com>
	 <65edea-2573-d19f-8ab3-d0afe16b808a@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2021-09-20 at 15:02 -0700, Mat Martineau wrote:
> On Mon, 20 Sep 2021, Paolo Abeni wrote:
> 
> > After the previous patch the mentioned helper is
> > used only inside its compilation unit: let's make
> > it static.
> > 
> > RFC -> v1:
> > - preserve the tcp_build_frag() helper (Eric)
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > Note:
> > this should _replace_:
> > """
> > Partially revert "tcp: factor out tcp_build_frag()"
> > """
> > 
> > I did not opted for a squash to patch, as it would
> > still require conflicts resolution after the previous
> > squash-to patch. @matttbe: please let me know if you
> > prefer otherwise.
> > ---
> > include/net/tcp.h | 2 --
> > net/ipv4/tcp.c    | 5 ++---
> > 2 files changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 4a96f6e0f6f8..673c3b01e287 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -330,8 +330,6 @@ int tcp_sendpage(struct sock *sk, struct page *page, int offset, size_t size,
> > 		 int flags);
> > int tcp_sendpage_locked(struct sock *sk, struct page *page, int offset,
> > 			size_t size, int flags);
> > -struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> > -			       struct page *page, int offset, size_t *size);
> > ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
> > 		 size_t size, int flags);
> > int tcp_send_mss(struct sock *sk, int *size_goal, int flags);
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index c592454625e1..4ae43222d71f 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -963,8 +963,8 @@ void tcp_remove_empty_skb(struct sock *sk, struct sk_buff *skb)
> > 	}
> > }
> > 
> > -struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> > -			       struct page *page, int offset, size_t *size)
> > +static struct sk_buff *tcp_build_frag(struct sock *sk, int size_goal, int flags,
> > +				      struct page *page, int offset, size_t *size)
> > {
> > 	struct sk_buff *skb = tcp_write_queue_tail(sk);
> > 	struct tcp_sock *tp = tcp_sk(sk);
> > @@ -1064,7 +1064,6 @@ ssize_t do_tcp_sendpages(struct sock *sk, struct page *page, int offset,
> > 		size_t copy = size;
> > 
> > 		skb = tcp_build_frag(sk, size_goal, flags, page, offset, &copy);
> > -		if (!skb)
> > 			goto wait_for_space;
> 
> This looks like an accidental deletion. Do you want to repost or have 
> Matthieu drop this hunk?

whoops, thanks for noticing! I'll repost.

Cheers,

Paolo

