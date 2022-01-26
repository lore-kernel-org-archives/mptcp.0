Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D998D168
	for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 16:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643214914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PzVCrLtb3SF3ih9iv7SFaOHQb4UhdKjMEBOt5gzfX9s=;
	b=Sm57bnWhdqfoOB65NnwPIcT6W1r6+wVPxVz/LPNl8/tL8HzkXJk1bxayeQ4U2J4l+1tCBU
	+AcKG1Y7VK68o/AiT0N13yC/1sou4OhaKZtllh8/j7SbRErmxGpoLv5SJ3BW4osHoO4EbM
	e2iZL7m8jbIn/CEIKl9XUBSYrEJwJq8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-RIo9fu5dMUW1cq0793bFpg-1; Wed, 26 Jan 2022 11:35:11 -0500
X-MC-Unique: RIo9fu5dMUW1cq0793bFpg-1
Received: by mail-qk1-f197.google.com with SMTP id n3-20020ae9c303000000b00477e4f3dfd2so17586444qkg.21
        for <mptcp@lists.linux.dev>; Wed, 26 Jan 2022 08:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PzVCrLtb3SF3ih9iv7SFaOHQb4UhdKjMEBOt5gzfX9s=;
        b=scUMdTPL3qkeq7nNf26KqyZBrueBzziveDaAnf+Lild9RP6PKe9dacgAmLah1g+wkM
         Tan8LMr4HxPD03EIdjdJYZZs/6YQdi/vFsKKrAB1NSUlClkiQT0gjsMUuj3rvR8+KlQu
         MQrZoL4CbOUIzdzbgTq5tgRAcA8+s0K8rB4qvyJPN9u0DCdIHnOieO+/DP8KKdOLs+mn
         URzz+T2Mlyy6g6pTobJCSWpeaTppggRyj6ORChBAdrlZ1aYAFZ99UICG8CgQHYGgkEF8
         L2qyB4vpWmrnuMkBU1FD5Bl/cQO9x2cYkCnM95j6ajm+pQAvXo+Rxbt+wAd/NMyK1ReR
         my9A==
X-Gm-Message-State: AOAM531MWlBgTwbGmftPYe9ff3Vyp9VF7E7Z6tx5O9rh5DuFymiA5WH7
	yn8gXXnXVfXDiJECFa7dB9Pd+0dZLXXtal28lixFQyv54PBEOokccTNSKsbSB3Y65/bHD2+SoBi
	9VWqCQA6/16Gk95U=
X-Received: by 2002:a05:620a:4589:: with SMTP id bp9mr19034146qkb.391.1643214910789;
        Wed, 26 Jan 2022 08:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzE7nhE8YiTHF3sC+6R/N3KVtWm40xzsjvudrolh/2dfOXM1vZOay6//T9Wca06uhLANgiIxQ==
X-Received: by 2002:a05:620a:4589:: with SMTP id bp9mr19034124qkb.391.1643214910559;
        Wed, 26 Jan 2022 08:35:10 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id bp37sm417539qkb.135.2022.01.26.08.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:35:09 -0800 (PST)
Message-ID: <3ecef3c4c1d158fc1c5812918e1710bce57c4812.camel@redhat.com>
Subject: Re: [PATCH net-next 6/6] ipv4/tcp: do not use per netns ctl sockets
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, "David S . Miller"
	 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev
	 <netdev@vger.kernel.org>, MPTCP Upstream <mptcp@lists.linux.dev>
Date: Wed, 26 Jan 2022 17:35:06 +0100
In-Reply-To: <CANn89iLCdpgh9vWd_A70mPqkRgLTk9aqNY=zV2ibtVus9YLxeA@mail.gmail.com>
References: <20220124202457.3450198-1-eric.dumazet@gmail.com>
	 <20220124202457.3450198-7-eric.dumazet@gmail.com>
	 <6cccaaa7854c98248d663f60404ab6163250107f.camel@redhat.com>
	 <CANn89iLCdpgh9vWd_A70mPqkRgLTk9aqNY=zV2ibtVus9YLxeA@mail.gmail.com>
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
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

On Wed, 2022-01-26 at 08:24 -0800, Eric Dumazet wrote:
> I was working a fix. syzbot found the issue yesterday before I went to bed ;)

I know that is not a nice way to get some rest :(

> (And this is not related to MPTCP)
> 
> My plan is to make struct inet_timewait_death_row not a sub-strutcure
> of struct netns_ipv4
> 
> (the atomic_t tw_count becomes a refcount_t as a bonus)

Sounds good. We can test the patch, if that helps (e.g. if syzbot lacks
a repro or the repro is not very reliable)

Thanks!

Paolo

