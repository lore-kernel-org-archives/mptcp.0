Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9282C9C
	for <mptcp@lists.linux.dev>; Thu,  9 Dec 2021 10:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1639044794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IK6aigw1WfgnT18cVOunxQPfveWPYJAfY8qKmMyeh8=;
	b=C0bCn84gCTNu5ML7YxkTcv/z136RICC2FYUdVF4yBBfvG9biD/3K5fSXTrYXIC3Eu8wX1P
	qJ6AE5/OrHmGqpITS0hhC0//gj2xkxRSlaeCkQY1xrAT3bnCHpoOad4S5TpqKQsLcgqqdm
	q4fBI4ZkZHt36K+rnDy7MJRC77uj9jY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-QPIUYcEDOTOmPk6_qkEVLg-1; Thu, 09 Dec 2021 05:13:13 -0500
X-MC-Unique: QPIUYcEDOTOmPk6_qkEVLg-1
Received: by mail-wm1-f72.google.com with SMTP id y141-20020a1c7d93000000b0033c2ae3583fso2900322wmc.5
        for <mptcp@lists.linux.dev>; Thu, 09 Dec 2021 02:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1IK6aigw1WfgnT18cVOunxQPfveWPYJAfY8qKmMyeh8=;
        b=NoXDZ0Im4IEocxm4gJoUMYokwYV9rkstf3QVVjzAUzoUAQNpTVQtAV8h5M/QtIX48h
         +LkBMKrT7O5Yn0G+fQ7D4G2bEPfBUVrySlRnjerbqWZg2ojMc+caNOGjxEuCi7vfCMEl
         l3caPh3kS/9NqNxbmxb3JXA1VERhDZcNbiUZyV/7HiCTN5gfpknTdcitTHju74WtbQNP
         uv5NaQ1ggib4hRM03G+Zhy14cHP/LrzMXX4FQRZ659D6pQbOmCAAy0OxTYehb9Yy51sG
         mUC/z9SA5B7YrM/n8nwSZkp2xt3GUD1MdkeKbBwxvyyqpySV9CZskxI0RewWjRp2AMtY
         Lz3w==
X-Gm-Message-State: AOAM5323zXD1DUD2UgIxmJO6xVCvOzM3I3VeOCwsUNR+nzD8ALIynoMJ
	4svl7U8gj42YzqPHtwbSMVzNdm2zr5a2+WvgK9r1/HnjnixABOPu7ZQveKqc7l/odZrZaMkRCqI
	EzSasOyeDsHcGgsc=
X-Received: by 2002:adf:f80c:: with SMTP id s12mr5311583wrp.627.1639044792120;
        Thu, 09 Dec 2021 02:13:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyWSVt4kI6XOnKWTMCqfIi0K2F9axqLQWrz1vvK1WL6fOpaF928bt7268cVqqjP25+oIsj0HA==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr5311551wrp.627.1639044791872;
        Thu, 09 Dec 2021 02:13:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-237-50.dyn.eolo.it. [146.241.237.50])
        by smtp.gmail.com with ESMTPSA id j134sm5563185wmj.3.2021.12.09.02.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 02:13:11 -0800 (PST)
Message-ID: <c8c409375134a662fb6ea1c95a997e0d6ba0e75f.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v4 3/5] mptcp: keep track of local endpoint
 still available for each msk
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Thu, 09 Dec 2021 11:13:10 +0100
In-Reply-To: <983be82e-7d50-4618-2773-be94d9f428b8@linux.intel.com>
References: <cover.1638544716.git.pabeni@redhat.com>
	  <20e1d11df9396b33ab49b07204bd8b7db2e21a01.1638544716.git.pabeni@redhat.com>
	  <e5ea098-af36-e35-1813-f97d7a187ffa@linux.intel.com>
	  <b17fea76ad24e5a1cc6b793427f827ba9ea3c887.camel@redhat.com>
	 <b4d0359bad87ee5bd0431be516aa1fc1574a7851.camel@redhat.com>
	 <983be82e-7d50-4618-2773-be94d9f428b8@linux.intel.com>
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35)
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

On Tue, 2021-12-07 at 10:18 -0800, Mat Martineau wrote:
> On Tue, 7 Dec 2021, Paolo Abeni wrote:
> 
> > On Mon, 2021-12-06 at 11:18 +0100, Paolo Abeni wrote:
> > > On Fri, 2021-12-03 at 17:05 -0800, Mat Martineau wrote:
> > > > On Fri, 3 Dec 2021, Paolo Abeni wrote:
> > > > 
> > > > > Include into the path manager status a bitmap tracking the list
> > > > > of local endpoints still available - not yet used - for the
> > > > > relavant mptcp socket.
> > > > > Keep such map updated at endpoint creation/deleteion time, so
> > > > > that we can easily skip already used endpoint at local address
> > > > > selection time.
> > > > > This allows for fair local endpoints usage in case of subflow
> > > > > failure.
> > > > > 
> > > > > As a side effect, this patch also enforces that each endpoint
> > > > > is used at most once for each mptcp connection.
> > > > 
> > > > This seems like a significant change, possibly with unexpected
> > > > consequences (but maybe I've misunderstood the new constraint?).
> > > > Apparently the topoligies in our self tests happen to work fine!
> > > 
> > > Uhmmm... probably less then it may looks like. We already respected the
> > > above constraint in almost every scenarios. AFAICS, the only exception
> > > prior to this patch was following scenario:
> > > 
> > > 1) subflow is established endpoint A
> > > 
> > > 2) the peer closes the additional subflow
> > > 
> > > 2) a new local endpoint B is created
> > > 
> > > 3) the PM will create the 2nd subflow using again endpoint A.
> > > 
> > > which is arguibly unexpected, as reported by issues/242.
> > > 
> > > > If you have peer A with one interface and peer B with two, it seems like
> > > > this should be allowed:
> > > > 
> > > > Peer A connects to Peer B endpoint 0
> > > > Peer B announces endpoint 1
> > > > Peer A sends an MP_JOIN to Peer B interface 1
> > > > 
> > > > From the description above, it sounds like peer A would not be able to
> > > > create that second subflow.
> > > 
> > > Well, AFAICS the peer A will actually create the subflow, if the limits
> > > allow that, both with or without this patch.
> > > Specifically:
> > > 
> > > 1) no endpoint configured, add_addr_accepted >=1, subflows >=1 on peer
> > > A -> the subflow to peer be interface 1 will be created (with or
> > > without this patch) because we don't have any other additional
> > > constraint beyond the limits.
> > > 
> > > 2) endpoint configured on peer A matching the MPC subflow source
> > > address -> again the subflow towards peer B endpoint 1 will be created,
> > > because that will be the first time the PM will use the peer A
> > > endpoint.
> > 
> > Thinking again about this last scenario, I think there is something to
> > improve:
> > 
> > if peer A connects to peer B using the local endpoint address, it can
> > later use again such address for additional sublflows, as the MPC
> > subflow is no accounted by the current version of this patch. I'll cook
> > a v5 adding such account, too - and possibly a related self-tests
> > 
> 
> Thanks Paolo, that will help.

Still working on that, I hit a few additional corner-cases
> 
> My main concern is what happens when the bitmap fills up. While 
> __mptcp_subflow_connect() can still be called from 
> mptcp_pm_nl_add_addr_received() (so, you're right, we can still create 
> multiple outgoing connections this way), it won't be called from 
> mptcp_pm_create_subflow_or_signal_addr() because select_local_address() 
> will now return NULL. The latter case doesn't seem like expected/desired 
> behavior.

The scenario you describe already happens with the current code (prior
to this series): when all local endpoints have been used
(local_addr_used == local_addr_max),
mptcp_pm_create_subflow_or_signal_addr() will not invoke anymore
__mptcp_subflow_connect() even if subflows < subflows_max.

The problem with reling only on 'local_addr_used' is that it allows
duplicate endpoint usage (as opposed to fair endpoint usage) as
described by issues/242.

