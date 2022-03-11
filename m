Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840B7E
	for <mptcp@lists.linux.dev>; Fri, 11 Mar 2022 11:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1646998495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wmuz3YfASFt3dyCuCTh1OPw1/fvtLQC/clIwVaa2kI=;
	b=IHfFRBC5kXwI9W1coRazXP/KDwIRu4KIko9EjXCssdSiq1zVHBD1XWwQXGASXdUTq4d3bS
	na5FfA6ghq2bCTQtJ4jblZMuExHaFXgi0g22nhfMJUbBbQSdtD8N9PsiFW1C160/NMFeA2
	3NnufN2Rq4yatqp4Ow2LbLKQzm60hqk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-oXZ25Hy8OAW8iRM5zhIF4A-1; Fri, 11 Mar 2022 06:34:53 -0500
X-MC-Unique: oXZ25Hy8OAW8iRM5zhIF4A-1
Received: by mail-qv1-f70.google.com with SMTP id kj16-20020a056214529000b00435218e0f0dso7376721qvb.3
        for <mptcp@lists.linux.dev>; Fri, 11 Mar 2022 03:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/wmuz3YfASFt3dyCuCTh1OPw1/fvtLQC/clIwVaa2kI=;
        b=bkOSbO3VRJnb31uSriHwZeRUcao8J/8a3dw8/u9snXfLpubqZCvsb8z9/2Jtvqks+8
         JDYVK0xKvPf5GjH1MMlMUc4uHpg0Yp7EbE+xY8IdYozTSBqgub78uhp0Bl9oRW+x1q/y
         khMpj+SSNp/kbA1TnQOCraxbI0/LcYbRxzFK7OS/FwKnOfnGUEpi2PGgb9b4uNqmFhcw
         rMkCp/baYBIFXKaPzFbLWRXvktR5K9gKCRSB6P85bB9YPyQUzgwHowOpxguzMN/9Td7X
         S4ih0jaHrVtAnUpVjI5Xaq/lJPfdO4gks4+TU544JVD8B2ZTR3cUYquryMWJpF0e+pxO
         4tNw==
X-Gm-Message-State: AOAM530WFqCofLXd/FcN4ef1de2V2pJRNlHKGA0PVv893HXl9/HiQB+V
	OBqcIPg9eiOaD1be4U1epU3CQlDAUWq3i3AcxiVx/acbYasTqJgd88lZj+bEVeeRQ6rynmCknSM
	iHubEliCK1zg5gpw=
X-Received: by 2002:ad4:5748:0:b0:435:50b6:1163 with SMTP id q8-20020ad45748000000b0043550b61163mr358557qvx.118.1646998492950;
        Fri, 11 Mar 2022 03:34:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx56nKobtMuKzOcMUOQl2jBPSo+Sg4vg2xqaMWfRGgX8BsIdzDdOJ0k8BhILxTB8qLdcynDbw==
X-Received: by 2002:ad4:5748:0:b0:435:50b6:1163 with SMTP id q8-20020ad45748000000b0043550b61163mr358539qvx.118.1646998492612;
        Fri, 11 Mar 2022 03:34:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-232-135.dyn.eolo.it. [146.241.232.135])
        by smtp.gmail.com with ESMTPSA id v15-20020a05622a144f00b002e1c3b3431asm325461qtx.66.2022.03.11.03.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 03:34:52 -0800 (PST)
Message-ID: <ffbba48f37d3132f490e0b11a8ea3682daf2d155.camel@redhat.com>
Subject: Re: [Weekly meetings] MoM - 10th of March 2022
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Fri, 11 Mar 2022 12:34:49 +0100
In-Reply-To: <48686ee-4d79-c9fd-35d5-593b9ec9742b@linux.intel.com>
References: <75c7803c-89c6-9e93-8f58-d2c6f3e24360@tessares.net>
	 <48686ee-4d79-c9fd-35d5-593b9ec9742b@linux.intel.com>
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

On Thu, 2022-03-10 at 17:03 -0800, Mat Martineau wrote:
> On Thu, 10 Mar 2022, Matthieu Baerts wrote:
> 
> > 12758809: Needs ACK: [mptcp-next,1/4] mptcp: prefer ip address in syn
> > skb instead of listen sk bound address
> > 12758808: Needs ACK: [mptcp-next,2/4] tcp: add mptcp join demultiplex hooks
> > 12758810: Needs ACK: [mptcp-next,3/4] mptcp: handle join requests via
> > pernet listen socket
> > 12758811: Needs ACK: [mptcp-next,4/4] mptcp: remove per-address
> > listening sockets:
> > 12765701: RFC: [5/4] mptcp: handle join requests early:
> >    - series: mptcp: replace per-addr listener sockets
> > 
> >    - Kishen found a couple of possible issues (bind race conditions)
> > 
> >    - Paolo gave his view of the situation:
> >        - initial need:
> > https://github.com/multipath-tcp/mptcp_net-next/issues/203
> >        - (who opened that really...)
> >        - need: accept new subflows for existing connections but where
> > the listening socket has been closed
> > 
> >        - 2 approaches have been taken:
> >            - Kishen: create listening sockets (from the PM, with
> > options not to do that, etc;)
> >            - Florian: accept MPJ without having to create additional
> > sockets
> >        - these 2 approaches have pros and cons.
> > 
> >    - Issue 203 is a nice to have, maybe not even a bug depending on the
> > point of view
> > 
> >    - → probably not a good idea to add too much complexity in the
> > kernel, important bugs might come
> > 
> >    - → maybe easier to let the userspace PM to create listening socket
> > and not let the kernel doing that all the time.
> > 
> >    - → the complexity to addresses races discussed on the ML would be
> > managed from the userspace and maybe not even visible if opening
> > listening would be done only in specific cases
> > 
> >    - → idea would be to let the userspace PM (mptcpd) to do the bind +
> > listen:
> >        - not to have the complexity on the kernel side where we cannot
> > change the behaviour
> >        - having the kernel creating so many listening sockets "doesn't
> > smell good", we will likely have complex issues to fix
> >        - if we can do it from the userspace, probably best to let it do
> > that
> >        - 203 can then be fixed with mptcpd by creating listening
> > sockets if needed
> 
> 
> Ok, after this community discussion today, I think we should go with the 
> "userspace (mptcpd) handles the listening sockets" approach. Kishen and 
> Ossama are on board with this too.
> 
> In addition to the points just above (complexity, possible hidden issues, 
> flexibility), this will leave the in-kernel PM implementation as-is for 
> now. It also remains possible to change the kernel listening behavior for 
> MPTCP joins at some point in the future, but will unblock the userspace 
> PM.
> 
> Kishen is working on modifying the userspace PM patch set to add selftest 
> support for these listening sockets in pm_nl_ctl. Ossama is looking at the 
> mptcpd changes we'll need.
> 
> 
> Paolo brought up and advocated this solution today, so it seems likely 
> that he will concur. Considering the active participants in these 
> discussions in recent meetings and email threads, I think we have a good 
> consensus on this approach to the listening sockets.

Agreed!

/P

