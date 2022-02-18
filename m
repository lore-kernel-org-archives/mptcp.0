Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA1648AC
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 08:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645174201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b9IXaU98SuYcX31xQ2KqVk5M5YpGUv6x0ClmsbnQvPo=;
	b=HfIqFhKRwRvPlkI1uv7WHjy/q9NRrFDEGKQrjXlMxhegI80i1H88YYX8gcNbdGwIdu1Yds
	xNjeC0L13FINsSFTG/FcqknymUCSdE9iP88vLey1Lljrfn2TEM7L+fSVowvcisu/1KBf7o
	k9/jY20BwHEXEK7gfEuN6EDCAzy1h/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-AunkPyKuMd-9NRF-sYQ_4g-1; Fri, 18 Feb 2022 03:49:59 -0500
X-MC-Unique: AunkPyKuMd-9NRF-sYQ_4g-1
Received: by mail-wr1-f72.google.com with SMTP id w26-20020adf8bda000000b001e33dbc525cso3247119wra.18
        for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 00:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=b9IXaU98SuYcX31xQ2KqVk5M5YpGUv6x0ClmsbnQvPo=;
        b=uty7vAYPQjc23U3Ov8IkEKHT3Xq5yRSv5O3pCqFeBKhWRu8FxAKLKeNH/ajmX4FDq3
         UN1RV7nm/bwD55bXxP56Kai3vBRQl20EyVfs7TssUAVD7RKbUOWeUEg7i1ao2S1AxQrZ
         IfS4s73fjCxLoCx01QhAi+/cL4EBISdV/Uzq8yBB7EsWgvRZsmL1RvQEFCcgTz/RyvVO
         j84CzCfJO8cKktcW37YgaJBIOJVs/Ia/YQ/bPe7kV4qtdfMSzF92I87JDCUXcyLetBJC
         TcUN4B7k8cbR99+ZtSGW52/VLgoL+StYw0b41X+NR55z+wC/fJUhpPuhA10EBdAkpyIc
         KAgQ==
X-Gm-Message-State: AOAM532vr380rgiaaamnP35yozMVlN9XvMNRhY74pB1l7My53PrVztqc
	PQSxIa9ZiOLpk1M6TceyrK3b0tR8kM3RV68Y1PVoBHn0XToOt8V8Hlq7B/MsU2/zkOghwBKZCmU
	RV5r4d4dyVpptzA4=
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr9498867wmo.162.1645174198499;
        Fri, 18 Feb 2022 00:49:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyadYBCpMEcdhy3aBOFdXt+weXCXmm26tkCw40hSowGKj2ml3KoA7vUuBa6DadD5Uf7NVyd5g==
X-Received: by 2002:a05:600c:230d:b0:37d:5882:ec9b with SMTP id 13-20020a05600c230d00b0037d5882ec9bmr9498838wmo.162.1645174198153;
        Fri, 18 Feb 2022 00:49:58 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-112-206.dyn.eolo.it. [146.241.112.206])
        by smtp.gmail.com with ESMTPSA id i3sm44275505wrq.72.2022.02.18.00.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 00:49:57 -0800 (PST)
Message-ID: <5a512b1c1e6dce5d317d8445f045e8cbe58237d9.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 3/5] tcp: add mptcp join demultiplex hooks
From: Paolo Abeni <pabeni@redhat.com>
To: Florian Westphal <fw@strlen.de>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 18 Feb 2022 09:49:56 +0100
In-Reply-To: <20220218072930.GB30383@breakpoint.cc>
References: <20220217142538.7849-1-fw@strlen.de>
	 <20220217142538.7849-4-fw@strlen.de>
	 <f99582a630cdb54490462277f06dfaac204e9f86.camel@redhat.com>
	 <20220218072930.GB30383@breakpoint.cc>
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
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

On Fri, 2022-02-18 at 08:29 +0100, Florian Westphal wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> > If I read correctly, subflow_syn_recv_sock() will filter the incoming
> > packets vs the annonced list, but only if the incoming packet's
> > destination port is different from the listener port.
> 
> Same as today, if it hit listener port then no issue...?
> The listener port isn't in the announced list, so the check would fail.

Side not not related to this series: It looks like that if we have 2
MPTCP listeners on different addresses and/or ports, and no 'signal'
endpoints, the kernel will accept MPJ on either sockets for any mptcp
connection, regardless of the originating listener. I'm unsure if that
is expeted/fits the RFC fully. 
@Mat: ^^^ WDYT?

> 
> > - incoming request targeting a bad address and/or port will reach the
> > syn-ack before being rejected.
> 
> Yes.
> 
> > - incoming request targeting port 0 will likely be always accepted.
> 
> No, port 0 is illegal, there is an explicit check that prevents
> such port from being wired up to the magic listener.

whoops, I missed that check, despite the huge comment. Sorry for the
noise here.

> > What about moving the anno_list check in __mptcp_handle_join()? Should
> > address the 2 above points and keep the anno_list traversals to the
> > bare minimum.
> 
> I can have a look.

Thanks! It looks like some minor changes are needed to handle !ipv6
build.

Cheers,
Paolo

