Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2472
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1627291943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjdax77cM89T5Llo3cpkxHDNvpd6rNEVjI5Tmqlvs0o=;
	b=XAo/r5PqvOobcFB4sDxFcF247/CgyQrgkMIpwuF2w3SSpD/YdoWj9MBkCxes3PR08EtuKj
	iuiTvxtwG4lh1/5laviJEcbn6vhGZE02fj/+94XN4kWgJe8+sD9zbBzo3LPV7WZN54szA1
	zg9pwhD45Uoi7lg5njUoRjMvuMOYYKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-m2Od5VmvP1CfeepY1djtkA-1; Mon, 26 Jul 2021 05:32:22 -0400
X-MC-Unique: m2Od5VmvP1CfeepY1djtkA-1
Received: by mail-wr1-f69.google.com with SMTP id d10-20020a056000114ab02901537f048363so1285539wrx.8
        for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 02:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xjdax77cM89T5Llo3cpkxHDNvpd6rNEVjI5Tmqlvs0o=;
        b=ceUNTfY3NJY1AzsR4WFHnxqQawHrnazV8Ns5gQSwjR/ddc5PgASk/1Tti4Wjn6kx8M
         /EJ9dZl5jAyL2ZySRgLtlu7vwXvEuEvBXyelm+kGXz1p96+IuY/4zb/sJkl7wmtTgYvW
         L2ZUKdvSgICXJtQ4+AltvQRlB46nkQoYfRWf2c/aSTMWy0EOHrL4RAbtHONsMZz39HzY
         UhFE5KNNAz5RYcZRkQPYa2cHVEF6qXzpJf9XhRZIE8MsvomMvWfOiujQHiUoJffXbZZr
         TYAVkf5osnnBOj8RCwEw21ZRZpYKYpKmU7+Y/qS0+0b3mOchtNxRY58B1zOZTVKLsG+N
         /LUQ==
X-Gm-Message-State: AOAM530lutAVydipOR8XGOFY45x/xHCrhb3YW7+JqugeZh124kX8Ax1v
	J0mMsEBr9Dzm7WUYxceN6T25/Hlomh36uhke0nmRWw4Zb8ljveqcnjm7p1IUFOyrwK88XIbDfCO
	vUbv+1FKPuQGQIF8=
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr13479810wmi.11.1627291940823;
        Mon, 26 Jul 2021 02:32:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytpgReITUXhxUR85AajoLhzwxufpsSldnkUFUVM8B/16UENkBcYXNqYbJiHA20CrXi+Mn7Nw==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr13479797wmi.11.1627291940657;
        Mon, 26 Jul 2021 02:32:20 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-57.dyn.eolo.it. [146.241.97.57])
        by smtp.gmail.com with ESMTPSA id s13sm6509242wmc.47.2021.07.26.02.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:32:20 -0700 (PDT)
Message-ID: <b263100b44ade87c4c8de95e549d1e761f7bd1e1.camel@redhat.com>
Subject: Re: [MPTCP][PATCH v3 mptcp-next 2/5] mptcp: local addresses fullmesh
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Date: Mon, 26 Jul 2021 11:32:19 +0200
In-Reply-To: <CA+WQbwtmVWv+JkVd=RifG=o6=V0VMjaaGvJj2sMZQb6UDA0nYA@mail.gmail.com>
References: <cover.1627272435.git.geliangtang@xiaomi.com>
	 <6f7aa2fec63dcaa337c7b78184a73a90d58b580f.1627272435.git.geliangtang@xiaomi.com>
	 <043ce3b46a70bd59ae7aaa53ed1afdf44b7f3ad2.1627272435.git.geliangtang@xiaomi.com>
	 <e201da79ddf683eb0b2c6198e2b7a8c69b5a3c88.camel@redhat.com>
	 <CA+WQbwtmVWv+JkVd=RifG=o6=V0VMjaaGvJj2sMZQb6UDA0nYA@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 2021-07-26 at 16:32 +0800, Geliang Tang wrote:
> Paolo Abeni <pabeni@redhat.com> 于2021年7月26日周一 下午4:24写道：
> > On Mon, 2021-07-26 at 12:12 +0800, Geliang Tang wrote:
> > > From: Geliang Tang <geliangtang@xiaomi.com>
> > > 
> > > In mptcp_pm_nl_add_addr_received(), fill a temporary allocate array of
> > > all local address corresponding to the fullmesh endpoint. If such array
> > > is empty, keep the current behavior.
> > > 
> > > Elsewhere loop on such array and create a subflow for each local address
> > > towards the given remote address
> > > 
> > > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > > Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> > > ---
> > >  net/mptcp/pm_netlink.c | 35 ++++++++++++++++++++++++++++++++---
> > >  1 file changed, 32 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> > > index f57db5b9a50f..a03e8fd3a584 100644
> > > --- a/net/mptcp/pm_netlink.c
> > > +++ b/net/mptcp/pm_netlink.c
> > > @@ -526,12 +526,17 @@ static void mptcp_pm_nl_subflow_established(struct mptcp_sock *msk)
> > > 
> > >  static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> > >  {
> > > +     struct mptcp_pm_addr_entry entries[MPTCP_PM_ADDR_MAX];
> > >       struct sock *sk = (struct sock *)msk;
> > > +     struct mptcp_pm_addr_entry *entry;
> > >       unsigned int add_addr_accept_max;
> > > +     struct mptcp_pm_addr_entry local;
> > >       struct mptcp_addr_info remote;
> > > -     struct mptcp_addr_info local;
> > > +     struct pm_nl_pernet *pernet;
> > >       unsigned int subflows_max;
> > > +     int i, n = 0;
> > > 
> > > +     pernet = net_generic(sock_net(sk), pm_nl_pernet_id);
> > >       add_addr_accept_max = mptcp_pm_get_add_addr_accept_max(msk);
> > >       subflows_max = mptcp_pm_get_subflows_max(msk);
> > > 
> > > @@ -555,10 +560,34 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
> > >       if (!remote.port)
> > >               remote.port = sk->sk_dport;
> > >       memset(&local, 0, sizeof(local));
> > > -     local.family = remote.family;
> > > +     local.addr.family = remote.family;
> > > 
> > > +     entries[n++] = local;
> > 
> > If I read correctly, I think this entry should be added only if the
> > full-mesh selection below find no other entries. Otherwise, e.g. in the
> > simple scenario with 2 locals address, 3 subflows will be created.
> 
> local is the id 0 address, this address should always be used, and it's
> not on the local_addr_list. 

Uhm... if the user-space configures correctly the mptcp endpoints,
every relevant address should be in local_addr_list.

e.g.

The client has 2 IPs:

192.168.255.2/24 dev eth0
192.168.254.2/24 dev eth1

The user-space should create 2 endpoints with full-mesh flags, one for
each of the above IPs, at addresses creation time.

When the mptcp socket is established, it's first subflow will use as
local address one of such IPs/endpoints.

If mptcp_pm_nl_add_addr_received() adds to the 'entries' array an
'IPADDRANY' address, and than the 2 addresses above, the client will
end-up creating 3 subflows towards the newly signaled address, instead
of the expected 2.

WDYT?

Paolo

