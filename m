Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B2A3F
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1645691783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfQw1zajgWWqp/Nk35C3BWU3SDTmy34ppTMc0L3xTWI=;
	b=MMVw4u4ijGztcjAWD/c4tUdaDFgn1bFr+TE/eXwDjRE0ez0Ye0VKK425rxtC7S3CqQV3wV
	YSn2VT6ifMGmIoW6URBJtsdoNRDlGqjfG8Wk/lgQjt0fqQHE1an1ZOsnB2S4MzznEgFFkO
	gas7bhY5FFWeMOysb+7oIdwnUaXiJwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-PStIoZsQOEGzycT7sn5H3g-1; Thu, 24 Feb 2022 03:36:22 -0500
X-MC-Unique: PStIoZsQOEGzycT7sn5H3g-1
Received: by mail-wm1-f71.google.com with SMTP id r206-20020a1c44d7000000b00380e36c6d34so2379312wma.4
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 00:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gfQw1zajgWWqp/Nk35C3BWU3SDTmy34ppTMc0L3xTWI=;
        b=k06k6h9UY+Kvz/TYfyP9Z6n39PySXq2WJA6SHcc/nXas/ag7M7Ax7xFl3n7xenmIng
         VcGEIVrGixBMIL92EgO3R+b2/m7cL2oMy6avFUFWstm4mHsUbfdp0g20aLRBBmI+JoS+
         r2HKfzNyHAhupopDpDs3UveULelgFMGh8wI2nmFa0nH/WgyUw1maqXidOwylH6HJPcTj
         3CTWYS7i5RJ6dBA8J3Z7frHXCVo54xVwivtKMDTqxjIZ1qf8LHknCoWaZ6x3prxYEC39
         SdM2SPbFB8ZG9eW3PQDKO2SzOafQ/L2a9bjzNaadmCE2v+r6tC+3gsZ4+vhvvSipzYZC
         0PBA==
X-Gm-Message-State: AOAM530qnjRHFpF4zx+KmnP/MC8h2TMKXkYZjyH1O4vDt6fGDO1nlGNu
	ILqdiMFnPK5IvVxix7Qg+6TNkltcMehKlHZ5uYXb7OHXauixzKklxWoc1TRXmPiTgwfK0/2vtfj
	Vqi8Y6UZyUWWjt5w=
X-Received: by 2002:a5d:6d8e:0:b0:1ea:7987:d2c with SMTP id l14-20020a5d6d8e000000b001ea79870d2cmr1339801wrs.279.1645691781201;
        Thu, 24 Feb 2022 00:36:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywqpdgkesbt/Zc40k7N8OvDGm69Uf2c7utN8PMt0s7htlSUR2A18k6y7JydaYVmQ5oSTGLgQ==
X-Received: by 2002:a5d:6d8e:0:b0:1ea:7987:d2c with SMTP id l14-20020a5d6d8e000000b001ea79870d2cmr1339781wrs.279.1645691780876;
        Thu, 24 Feb 2022 00:36:20 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-108-216.dyn.eolo.it. [146.241.108.216])
        by smtp.gmail.com with ESMTPSA id c13sm2112777wrv.24.2022.02.24.00.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 00:36:20 -0800 (PST)
Message-ID: <ead396eea40ae17c3a39ee8d4e2b5fa3ba908cde.camel@redhat.com>
Subject: Re: [PATCH 3/4] mptcp: handle join requests via pernet listen socket
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, Florian Westphal
	 <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Date: Thu, 24 Feb 2022 09:36:19 +0100
In-Reply-To: <ff6fbff-8753-4a55-8aa6-9c7dff89644@linux.intel.com>
References: <20220223110832.29357-1-fw@strlen.de>
	 <20220223110832.29357-4-fw@strlen.de>
	 <ff6fbff-8753-4a55-8aa6-9c7dff89644@linux.intel.com>
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

On Wed, 2022-02-23 at 17:26 -0800, Mat Martineau wrote:
> On Wed, 23 Feb 2022, Florian Westphal wrote:
> 
> > Currently mptcp adds kernel-based listener socket for all
> > netlink-configured mptcp address endpoints.
> > 
> > This has caveats because kernel may interfere with unrelated programs
> > that use same address/port pairs.
> > 
> > RFC 8684 says:
> > Demultiplexing subflow SYNs MUST be done using the token; this is
> > unlike traditional TCP, where the destination port is used for
> > demultiplexing SYN packets.  Once a subflow is set up, demultiplexing
> > packets is done using the 5-tuple, as in traditional TCP.
> > 
> > This patch deviates from this in that it retains the existing checks of
> > verifying the incoming requests destination vs. the list of announced
> > addresses.  If the request is to an address that was not assigned, its
> > treated like an invalid token, i.e. we send a tcp reset with mptcp
> > error specific code is returned.
> > 
> > The checks that do this are moved from subflow specific code to the
> > new hook, this allows us to perform the check at an earlier stage.
> > 
> > Furthermore, TCP-only listeners take precedence: An MPTCP peer MUST NOT
> > announce addr:port pairs that are already in use by a non-mptcp listener.
> > 
> 
> This rule seems ok to me. But there's a loophole: MPTCP can announce the 
> addr:port, then a TCP listener is created for that same addr:port and 
> starts rejecting any incoming MP_JOINs.

I believe an host can't reliably announce an address and ensure syn
packets towards such address/port will be accepted: local firewalling
rules can reject such packet, or even middle-boxes.

I think the important point is ensuring the MPTCP protocol behaves in a
consistent way. IMHO the behavior exposed here is more consistent than
what we currently have.

Yes, a third party application can interfer with the announce list, to
me that is no more different than configuring an explicit drop rule 
for incoming syn packet on the relevant port: conflicting persistent
misconfiguration.

> > This could be changed, but it requires move of mptcp_handle_join() hook
> > *before* the tcp port demux, i.e. an additional conditional in hotpath.
> > 
> 
> One possibility that doesn't disturb the hot path too much: Let the TCP 
> listener try to handle the SYN. In tcp_parse_options(), add just enough 
> code to set a bit in struct tcp_options_received if MP_JOIN is present 
> (don't fully parse the MPTCP option). If MP_JOIN is there and MPTCP is 
> enabled, return early from tcp_check_req() and have tcp_v4_rcv() treat it 
> similar to req_stolen==true. Instead of kicking back to a regular lookup, 
> try a token lookup.

If I read correctly, the above will need 3 additional hooks (code and
conditionals) is fast path: in tcp_parse_options(), in tcp_check_req()
and in tcp_v4_rcv(), and possibly even in tcp_v4_do_rcv()

The above in addition to the hooks added by this series, right?
otherwise we will not cover issues/203

Imho that looks a bit too much.


Cheers,

Paolo

