Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8F62C80
	for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1634136903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0CDK9A6zioZRUiPAWZP6TZG2FZFhqFBxn2b5EcVSQuE=;
	b=gEVnR22Qf7Pz8HpTw+E/3hQWkHZUIa2XDpEBexVpG7BicDBdkUBcuvUkDrG+MSqc17OaSU
	xCFSJbI33mM5CAmgvGD/iTYsiuDft2ipeZSBo8iJ+xkUf+CHlaszowdm8QzL5dUKVHjyy9
	PS8DBtXE/ZZHTp4c7GFw7z/TxdpwXCo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-gdrPCMaXO-qHOiVg6cMZ_Q-1; Wed, 13 Oct 2021 10:55:02 -0400
X-MC-Unique: gdrPCMaXO-qHOiVg6cMZ_Q-1
Received: by mail-wr1-f69.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso2219479wrc.2
        for <mptcp@lists.linux.dev>; Wed, 13 Oct 2021 07:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=0CDK9A6zioZRUiPAWZP6TZG2FZFhqFBxn2b5EcVSQuE=;
        b=IRo76bGXg/6HUz+OumkYaFYbcK/Ndc5cv82KPbziVtT4MI4Gvb3V9Scs5mG/wH1T8G
         D8EnazliHyTpYsR7eifwpOAzBs+/0uoLeZxGK59pD5SKiMQwlRDSILnoi/5zgowhbpYh
         pQ1clozW88JZHkrBh66OG9Eva6IDpd2L3paE7GU6g6UUtj9NiyYlv1N6Hh/p1qFzTPKq
         HpA+joF7sctJ96A+Ve48VBYcStqBP5mTAtyVcKlCFkcbV9VWxTCYbqsotlqtWle/oZfO
         K9qS8JpIayzxjGwN9VKipom9Et5xlE1G+QJP3097TK8hylLewFqT30n1GV/ystCrENFq
         i6xw==
X-Gm-Message-State: AOAM530Wot75sxUFtZqu3je42xpOoMj4tzcdVsRra5+qWsY0miy5Nn2T
	kG6Do+Mf7buetdKLO6RViicJM/VtYa0kA83wZYuQl+gkzzn0erl/3GLwtJT/7AZP1Esom2tOspi
	UxMN6Qz0YDo7VF4s=
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr19296870wri.161.1634136900961;
        Wed, 13 Oct 2021 07:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh2n64hHKufx8wpAXk4XB1MVn3JtA0DOXG73x805OGWR29CcnoQE8ZJH02V2Cwu8rvG2Qf5g==
X-Received: by 2002:a05:6000:1869:: with SMTP id d9mr19296851wri.161.1634136900723;
        Wed, 13 Oct 2021 07:55:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-16.dyn.eolo.it. [146.241.231.16])
        by smtp.gmail.com with ESMTPSA id w1sm5543893wmc.19.2021.10.13.07.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:55:00 -0700 (PDT)
Message-ID: <f9860e6de0d54d4644a4a7eb94748ee2a1cb0fab.camel@redhat.com>
Subject: Re: [PATCH mptcp-next] mptcp: increase default max additional
 subflows to 2
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Wed, 13 Oct 2021 16:54:59 +0200
In-Reply-To: <ed428aeb-8d9f-90c8-60cf-5c714b3460e5@tessares.net>
References: <b7e5c73d59113afe32eec831b620997c86b56460.1633712415.git.pabeni@redhat.com>
	 <ed428aeb-8d9f-90c8-60cf-5c714b3460e5@tessares.net>
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

On Mon, 2021-10-11 at 18:09 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> 
> On 08/10/2021 19:27, Paolo Abeni wrote:
> > The current default does not allowing additional subflows, mostly
> > as a safety restriction to avoid uncontrolled resource consumption
> > on busy servers.
> > 
> > Still the system admin and/or the application have to opt-in to
> > MPTCP explicitly. After that, they need to change (increase) the
> > default maximum number of additional subflows.
> > 
> > Let set that to reasonable default, and make end-users life easier.
> > 
> > Additionally we need to update some self-tests accordingly.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/pm_netlink.c                          | 3 +++
> >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 ++++-
> >  tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++---
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index 050eea231528..f7d33a9abd57 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> > @@ -2052,6 +2052,9 @@ static int __net_init pm_nl_init_net(struct net *net)
> >  	struct pm_nl_pernet *pernet = net_generic(net, pm_nl_pernet_id);
> >  
> >  	INIT_LIST_HEAD_RCU(&pernet->local_addr_list);
> > +
> > +	/* Cit. 2 subflows ought to be enough for anybody. */
> > +	pernet->subflows_max = 2;
> 
> Sorry for the late reply, I just thought about something when looking at
> applying this: let say that in a typical setup we would have 2 subflows
> per connections because the client has 2 interfaces and connect to a
> server not announcing other addresses. With this setup, could we arrive
> in situations where we would (internally) have 3 subflows?
> 
> I mean, could we arrive in a situation where 1 (or 0) subflow is OK, 1
> is being deleted (network reconnection?) and the PM is already trying to
> create a new one? In this case and because of the limit, the PM might
> not try to create this 3rd subflow and might not retry when the dying
> subflow is actually being deleted? Or maybe the PM already wait for the
> full deletion before re-trying to establish a new subflow?

If I understand correctly, your fear is that we can end-up with 2
additional subflows even if there are only 2 different local IP
addresses/interface, is that correct?

Anyhow the above scenario is not possible with the in-kernel path
manager: it will create new subflows only for local addresses not
already used by the mptcp connection.

Unless the 'fullmash' flag is set, but in that case user really wants
multiple subflows per local address.

Please let me know if the above solves your doubts.

Side note: the in-kernel path manager takes no additional action when a
subflow is closed.

Cheers,

Paolo

