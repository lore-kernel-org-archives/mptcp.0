Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CAED1
	for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655886667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGlis0KPnITqmLVAAcYqbSceVUJKCZRC9yBG0j2+qxA=;
	b=iZJLs+W6IemyelesGHNIrcRjQfg7cK+kYpGg3Cu5e8Xj4KMV8E0mKfS6yliN61865XwI/c
	mdjmXUYQIDv1ed01RVpG306DJAOn23QKrtlZ7ctw3I4+RWQM4isp3GxM39uM438CcNjk9N
	0a2uHnOe5oTPrREsKHmMsSurXwLjVAQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665--ztmD20UMayP0m2SgENroA-1; Wed, 22 Jun 2022 04:31:06 -0400
X-MC-Unique: -ztmD20UMayP0m2SgENroA-1
Received: by mail-wm1-f70.google.com with SMTP id m23-20020a05600c3b1700b0039c6e3c169aso7497447wms.2
        for <mptcp@lists.linux.dev>; Wed, 22 Jun 2022 01:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rGlis0KPnITqmLVAAcYqbSceVUJKCZRC9yBG0j2+qxA=;
        b=BJsz24fwWQpwO6RsTcfopmrxWecOgXfC4MsAejoBlDEn/lkFFKY9Rp/Od7kCHQE/2e
         d8+FO0yOlJClWX04irx5bG9+HtQDWq6qyduBQ82J5buFJ+tL9hFYHQ9vX2pjfC0amfYv
         JUSTBwAFudTlZFoLZSx7ZoadbaozoJDU3Bisz1W1+AEeJ51d4WfMmvUmmoCqYkAK6+lD
         iD9f/QQZip/5pNmJXjU1/69pL751AD/l/2zSWV6Y3vYSiE2d2dbj9bSolcK8w8NodntS
         YJe7M7xIOTQa/unU2BlEzX1X6kAwNJpkfIr6maGp2LlgLXipyWSjHVInsTzEOqXC7p82
         OYBQ==
X-Gm-Message-State: AJIora9RRPKW0NW/P8L1ZNPi2unXMVlNBnALN5Wl2zGHSCjn/e7U1fj8
	UHCfHReFCOjCMxqWctpaUBmRg5t0knkqNd/+5j8V9DAthnf+CbezW6Cunb1KGuCjmaDlpOxQu+H
	uZp8GbEf4SrTib+U=
X-Received: by 2002:a5d:64c2:0:b0:20f:dc21:e658 with SMTP id f2-20020a5d64c2000000b0020fdc21e658mr2127679wri.508.1655886664743;
        Wed, 22 Jun 2022 01:31:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tY047eD6hqn9W26dzCZIPvJEQxI68L1LqEBswv6PUY8iMmyx71ajp+0xdP+cTHgHuKfZ9peA==
X-Received: by 2002:a5d:64c2:0:b0:20f:dc21:e658 with SMTP id f2-20020a5d64c2000000b0020fdc21e658mr2127647wri.508.1655886664356;
        Wed, 22 Jun 2022 01:31:04 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d6406000000b0021b9e360523sm1569674wru.8.2022.06.22.01.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 01:31:03 -0700 (PDT)
Message-ID: <ed346da060754c2a9191b863e5dc622b3981bd0e.camel@redhat.com>
Subject: Re: [PATCH v4 mptcp-next 1/4] mptcp: never fetch fwd memory from
 the subflow
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Wed, 22 Jun 2022 10:31:03 +0200
In-Reply-To: <372de32b-6ee8-c294-6b43-fde2dae1a46@linux.intel.com>
References: <630f7e13d7226f8c37a9cc0c66008a298c1e6b9e.1655828070.git.pabeni@redhat.com>
	 <f6421a9f-b294-862-2077-67a2e57eeb43@linux.intel.com>
	 <372de32b-6ee8-c294-6b43-fde2dae1a46@linux.intel.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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

On Tue, 2022-06-21 at 15:46 -0700, Mat Martineau wrote:
> On Tue, 21 Jun 2022, Mat Martineau wrote:
> 
> > On Tue, 21 Jun 2022, Paolo Abeni wrote:
> > 
> > > The memory accounting is broken in such exceptional code
> > > path, and after commit 4890b686f408 ("net: keep sk->sk_forward_alloc
> > > as small as possible") we can't find much help there.
> > > 
> > > Drop the broken code.
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > ---
> > 
> > Thanks Paolo, v4 looks good.
> > 
> 
> One more question Paolo: given the SCTP regression that was bisected to 
> the fwd alloc change:
> 
> https://lore.kernel.org/netdev/20220619150456.GB34471@xsang-OptiPlex-9020/
> 
> is there any need to wait before upstreaming this series for net-next? 

I'm guild-guessing 4890b686f408 could cause regressions (for TCP and as
as consequence for everything else using it) when cgroups are in use,
because after that patch the cgroup memory accounting hooks are called
~twice per packet (one to increase, one to decrease the cgroup
accounted memory), instead that almost never before that patch.

In any case we can't do much to counter such regression. 

I did some benchmarking on top of this patches, and I could not measure
relevant changes (but no cgroups enabled).

I'm not 110% sure that the regressions reported by LTP are relevant.
Once upon time I hit a quite large one, and it was actually due to test
instability.

I agree staging this changes for a bit will not hurt/will be for the
better.

Cheers,

Paolo



