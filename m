Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F633CE
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 18:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671820317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpIAOT/EzfKG1q61OVMWywEvIUuJPSg1eHetE6UwopU=;
	b=C+MSVDCubpWoewb2nCxusyEvzIWm0MZzAuac44S+rzJLU9C1qajuS3DqAXZrsO3fKYpBpa
	Wv8sAJPrBhKdXz0Fef0OkyHrggxrjs5PnudYmDOnskATs8xSKKDlkmY167REH7l0cvaEAj
	Tk6f+W3T+MnuKpzfST5kCJgI/1s6Y/M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-669-oCkJU_RtOtu_pKJnmxXT3Q-1; Fri, 23 Dec 2022 13:31:56 -0500
X-MC-Unique: oCkJU_RtOtu_pKJnmxXT3Q-1
Received: by mail-qk1-f197.google.com with SMTP id q20-20020a05620a0d9400b006fcaa1eac9bso3602737qkl.23
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 10:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wpIAOT/EzfKG1q61OVMWywEvIUuJPSg1eHetE6UwopU=;
        b=2w2J4HeWNjGFo6gyN6ojpX6cFuSUG+K/25y9P0O5/f0XeC9+hW1Ag4MWf0bLEq0fX6
         H/84KFgi20V1FXJ2el4J0oh2nntLhnFLWU2yvAJLDdXZFOocGqJObE8gdAOq7Od2gvEX
         P6ykAsTdyTzlVfkCLbqs3E11J8cHOiqcPa6pkhAY6RzfsCjPqCZr6lA59UYMLLeA3/sq
         w+su1ooZT3MQdsVahQtQ+mnhI4pT5UoeMCke45dGLcTNjRGxUqo8IflrEIcUMYLKeBIZ
         B+u48cvISdvzpDBOhEs+WizZS4Dx7VpegFCL5U7iDk299k3l7LTmK9posXKCiWOhmaA9
         Sk2g==
X-Gm-Message-State: AFqh2kqH/lh5NLv0Ftho6qNOqTdKAvHtY2RLTRdL1484fYZQeGugJfKi
	xgnXtNvC8eVw680MeFI4z3QK9X2UR+Rl7m5HNRLRD2uziuHMvp+jkj7Sh/5Lhp4vsiRYmqUzopG
	thwQx08pm5u1TGtE=
X-Received: by 2002:ac8:1287:0:b0:3a8:23d4:8d2b with SMTP id y7-20020ac81287000000b003a823d48d2bmr13111048qti.10.1671820315251;
        Fri, 23 Dec 2022 10:31:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvShnem248EQ3egjDJJF2fDEfeXhodZQ3t9rj8zu3RkZja3nM3GDxVFpZhMN2BbW6yVO71lZw==
X-Received: by 2002:ac8:1287:0:b0:3a8:23d4:8d2b with SMTP id y7-20020ac81287000000b003a823d48d2bmr13111018qti.10.1671820314949;
        Fri, 23 Dec 2022 10:31:54 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id v13-20020ac8748d000000b00398313f286dsm2349226qtq.40.2022.12.23.10.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:31:54 -0800 (PST)
Message-ID: <327c3b69dfdc46364130138565ce33aef2b59107.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 2/3] mptcp: let the in kernel PM use mixed
 ipv4 and ipv6 addresses
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 23 Dec 2022 19:31:51 +0100
In-Reply-To: <2124b7ef-563f-1f42-2315-ab00e18782b5@tessares.net>
References: <cover.1671799401.git.pabeni@redhat.com>
	 <2aabefc61c5e7212d57156971633660d50176a4b.1671799401.git.pabeni@redhat.com>
	 <2124b7ef-563f-1f42-2315-ab00e18782b5@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-12-23 at 15:35 +0100, Matthieu Baerts wrote:
> Hi Paolo,
> 
> Thank you for having looked at these patches!
> 
> On 23/12/2022 13:51, Paolo Abeni wrote:
> > Currently the in kernel PM arbitrary enforces that created subflow's
> > family must match the main MPTCP socket. The RFC allow instead for
> > mixing IPv4 and IPv6 subflows with no constraint.
> > 
> > This patch changes the in kernel PM logic to create subflows matching
> > the currently selected source (or destination) address, effectively
> > allowing the creation of IPv4 and IPv6 subflows under the same msk.
> > 
> > While at that, factor out a new helper for address family matching,
> > taking care of ipv4 vs ipv4-mapped-ipv6.
> > 
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/269
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  net/mptcp/pm_netlink.c | 57 ++++++++++++++++++++++--------------------
> >  1 file changed, 30 insertions(+), 27 deletions(-)
> > 
> > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > index f2a43e13bacd..1d4ba6716a98 100644
> > --- a/net/mptcp/pm_netlink.c
> > +++ b/net/mptcp/pm_netlink.c
> 
> (...)
> 
> > @@ -600,10 +610,10 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
> >  		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
> >  
> >  		msk->pm.local_addr_used++;
> > -		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
> > -		if (nr)
> > -			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> > +		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
> > +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> 
> I see that you removed the 'if (nr)' condition: was there a bug before?
> If no addresses have been filled, no new subflows will be created below
> and this ID is still available.

The previous behavior was uncorrect, I think. It's cleaner if we always
consider consumed an endpoint once we tried to process it, but I can't
easily think of a scenario demonstrating a real "bug". I think we can
squash the change in here.

/P

