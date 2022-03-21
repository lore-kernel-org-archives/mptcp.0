Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CC2F24
	for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1647855808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UBbI11cQgXH05OBJATzTVqXodvbWMt8yABBqk+BXUg=;
	b=VwZeCEmmEoTh7LFC21dcad6Vry5psxnVwPBu0BKRdmzxMm4aKPPvHJY/SdIS4YIDqEJMlk
	8bTFnyEkCPwJm9GSd6zdnmOFKe5E3lOwSYwyNiqDJJEeGRRPeIUDwJbl3KNORj6mP7eP4i
	ypXO9U9Crp/rPxkOtnSjC8Z3VkwwenE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-SU6gvZA6PSeCCLXrIxkMOw-1; Mon, 21 Mar 2022 05:43:23 -0400
X-MC-Unique: SU6gvZA6PSeCCLXrIxkMOw-1
Received: by mail-qv1-f69.google.com with SMTP id g2-20020a0562141cc200b004123b0abe18so11270186qvd.2
        for <mptcp@lists.linux.dev>; Mon, 21 Mar 2022 02:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+UBbI11cQgXH05OBJATzTVqXodvbWMt8yABBqk+BXUg=;
        b=ydPAMiYVe2264vDOEBTq3SQXAhigaHAK1MUrLCNWVP4Z7xyNY0GgXWKST1g7ikM1iw
         aT+hfcX8WRyACvjJ33GsnX12wH+XxZoBYysd7buIVqH8Xod+2J7J+Vml4TYZzn0IO2n5
         tJyEEx+IUr0aTJbPwF+Z//VzhQznGC6GyT7ygu+FyhxraPEBbT/HgaqNX1PRq5fMyu0I
         xB1fWRK1pX8usygfOQVVem4yNRtN7B04gYSpes9sjf/nKI/aQNFeww9BrvWsROPqMDsk
         ISg1Y2D6h3n31P3qrUycbfnAu5+Nione7EX4Uw5nwU4UqRqaMLbrirzwdOg6/TBPBeAE
         1+8A==
X-Gm-Message-State: AOAM531Glwdh9keGN3d90CyPDiROKyCLS3szgeLmbR6rS1xs9J9oFzg5
	Zfy5Np8ygB6q7ZCZijUEr0P/p9lI3n07VUyGjqaN/I/f1yzZhmTSUvVjnd99F2n/a0bN0Ms7dVw
	FruuPMy2TyiN25Xs=
X-Received: by 2002:a05:620a:1432:b0:67d:36cd:1f16 with SMTP id k18-20020a05620a143200b0067d36cd1f16mr11711467qkj.166.1647855802610;
        Mon, 21 Mar 2022 02:43:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuQAVD+N7D6QtD2sYlBNweu3wzc9WF4lHlnXoLsc0Jv8hRNVPNuJh320KTuUqFGsfaL3dj/g==
X-Received: by 2002:a05:620a:1432:b0:67d:36cd:1f16 with SMTP id k18-20020a05620a143200b0067d36cd1f16mr11711461qkj.166.1647855802265;
        Mon, 21 Mar 2022 02:43:22 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id j11-20020a05622a038b00b002e1f0bc2e8csm9228440qtx.81.2022.03.21.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 02:43:21 -0700 (PDT)
Message-ID: <67be2502ac695a76da2ea758b7e03636a4ec9540.camel@redhat.com>
Subject: Re: MPTCP Linux Implementation
From: Paolo Abeni <pabeni@redhat.com>
To: Sam Kumar <samkumar@berkeley.edu>, mptcp@lists.linux.dev
Date: Mon, 21 Mar 2022 10:43:19 +0100
In-Reply-To: <CA+5NP0kpxDU-+57tZe0V7TkcWGH5Jc8cMhck6sKA7ptz2tvbmw@mail.gmail.com>
References: <CA+5NP0kpxDU-+57tZe0V7TkcWGH5Jc8cMhck6sKA7ptz2tvbmw@mail.gmail.com>
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35)
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
Content-Transfer-Encoding: 8bit

On Sat, 2022-03-19 at 11:54 -0700, Sam Kumar wrote:
> I'm Sam Kumar, a PhD student in Computer Science at UC Berkeley. I
> read the NSDI 2011 paper about congestion control in MPTCP (this
> paper: https://www.usenix.org/conference/nsdi11/design-implementation-and-evaluation-congestion-control-multipath-tcp).
> I think it is really nice work and I would like to try running it.
> 
> I came across your community's work on upstreaming Multipath TCP
> (https://github.com/multipath-tcp/mptcp_net-next/wiki), and I wanted
> to ask about the congestion control algorithm that your implementation
> supports. Does the version of Multipath TCP in Linux support the
> congestion control protocols for preferring subflows with less packet
> loss, such as the COUPLED, SEMICOUPLED, or MPTCP (Sec. 2.5) algorithms
> described in the paper? 

Nothing of the above. The in-kernel MPTCP implementation uses a single
scheduler algorithm, which is a custom heuristic based on the bleast
scheduler:

https://ieeexplore.ieee.org/document/7497206

For the gory details see:

https://elixir.bootlin.com/linux/latest/source/net/mptcp/protocol.c#L1431

and onwards.

> In case it affects the answer, I'm on Linux 5.13. 

Way too old.

> I'm happy to use a
> more recent kernel version if newer kernels support these congestion
> control algorithms.

The most up2date scheduler version is present into Linus tree since
v5.17-rc1, but if you are interested into any real devel work, I
suggest to check-out our devel branch, and keep your local tree
up2date:

https://github.com/multipath-tcp/mptcp_net-next.git

> I'm alsv5.17-rc1o aware of the MPTCPv0 work
> (https://github.com/multipath-tcp/mptcp_net-next/wiki) --- are the
> congestion control protocols supported by that work any different?

With 'MPTCPv0 work' do you refer to the out-of-tree implementation? 

In that case, yes: the the out-of-tree and upstream[1] implementations
are quite different independent. As said, the upstream packet scheduler
is somewhat related to the out-of-tree blest scheduler, which is the
default scheduler for the out-of-tree kernel.

Note that the vanilla Linux implementation has no support for the
version 0 of the MPTCP protocol.

Cheers,

Paolo

[1] note: I use 'in-kernel', 'upstream' and 'vanilla' as synonyms.

