Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF923FCB
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632410037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VqdjaNmOy3AFkCrcLAGhcrhZbFXF1wKvJPiKrQRv8Nc=;
	b=AYb91eWUCdKQiWU3z0qpNoUv81R2fE1f6LsUgdGFtnZcAyIWdlattp1mIxxG3EFC6pAmoT
	5UjsEwmiTs/yLfMAWFDEyP0uXNbrM6PqgmIladOEfuDnoLHVUA42y4AjomMhuP9fy+X9Us
	2DryJvyRVYvR4HI6RsQ1W1t9ZVs9wvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-UUdvMUXfNqiD-h8MaTiIkA-1; Thu, 23 Sep 2021 11:13:56 -0400
X-MC-Unique: UUdvMUXfNqiD-h8MaTiIkA-1
Received: by mail-wr1-f72.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so5479210wrh.0
        for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 08:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VqdjaNmOy3AFkCrcLAGhcrhZbFXF1wKvJPiKrQRv8Nc=;
        b=0+MMd6W4z7IHcMuSmGLQJQrs7bq+EdQducfkNw4oXWiaf+X1h6uYfBjCOa1dneYJPV
         +p/QI81GEvCyrluqWPbzeb/1cK/0JQBIGRRijLt6Qt06ZrLVy0ZfSTs7OO4KtG1oBhGu
         jt9X5bhW4m7eIx6cjeGQ+05cytA16vLqCuisE90T9mLmSc5Q03h743rF7rNOWmj0APhd
         kPuoPPK27IklvRRx6WLgpRgqf8l8SZxtzN3qtgDWP0011GI1f8Zo8lJmWvKz6/CPw06A
         guzEwuz/Ol5EssNmSHt6FyvW2TiQETGJyw8sT7De8JxCy9r3IO6vnA1pE9RHnrp6hKV3
         yZdQ==
X-Gm-Message-State: AOAM532UbJSAWyjLx/bpl8u/oO/htMv1zXLfOPm0RCf9asSXzvbhGByG
	A0hrxMcAqfRmvAhbFrar/NCb285YS0jcAujqRwOaywq5ExIb8RBkSJgq4obmNgiajmq8oNWV5z+
	QFOV6FMxpASLTnTc=
X-Received: by 2002:a5d:544c:: with SMTP id w12mr5948221wrv.398.1632410034873;
        Thu, 23 Sep 2021 08:13:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMQ1N3NmSdkCf4DeLiX4l4Vc0+xtlPiJy43V6hnH1kMLkDvekZuUvBWSzE7fU9HjrzFPaYNg==
X-Received: by 2002:a5d:544c:: with SMTP id w12mr5948190wrv.398.1632410034662;
        Thu, 23 Sep 2021 08:13:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id u25sm6278000wmm.5.2021.09.23.08.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:13:54 -0700 (PDT)
Message-ID: <286faa2529e01e6091666f97ad0cc703e5e80c7c.camel@redhat.com>
Subject: Re: [syzbot] WARNING in mptcp_sendmsg_frag
From: Paolo Abeni <pabeni@redhat.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: syzbot <syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com>, 
 davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
 mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Date: Thu, 23 Sep 2021 17:13:53 +0200
In-Reply-To: <20210923143728.GD2083@kadam>
References: <00000000000015991c05cc43a736@google.com>
	 <7de92627f85522bf5640defe16eee6c8825f5c55.camel@redhat.com>
	 <20210923141942.GD2048@kadam> <20210923143728.GD2083@kadam>
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

Hello,

On Thu, 2021-09-23 at 17:37 +0300, Dan Carpenter wrote:
> On Thu, Sep 23, 2021 at 05:19:42PM +0300, Dan Carpenter wrote:
> > On Wed, Sep 22, 2021 at 12:32:56PM +0200, Paolo Abeni wrote:
> > > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > 
> > > The debug code helped a bit. It looks like we have singed/unsigned
> > > comparisons issue
> > 
> > There should be a static checker warning for these.  I have created one
> > in response to your email.  It turns out there are a couple other
> > instances of this bug in the same file.

Thank you!

I was quite suprised the plain compiler did not emit a warn, even with
W=1.

> > net/mptcp/protocol.c:479 mptcp_subflow_could_cleanup() warn: unsigned subtraction: '(null)' use '!='
> 
> I should have checked my output a bit more carefully.  I don't want this
> one to generate a warning.
> 
> > net/mptcp/protocol.c:909 mptcp_frag_can_collapse_to() warn: unsigned subtraction: 'pfrag->size - pfrag->offset' use '!='
> 
> Likely "pfrag->offset" can't be larger than "pfrag->size".  Smatch has
> some code to try track this information but it's not clever enough.

Yes, this looks safe, offset can't be larger than size.

Even the last reported warning looks safe to me: 'info->size_goal -
skb->len', we just check for size_goal being greater then skb->len.

Cheers,

Paolo

