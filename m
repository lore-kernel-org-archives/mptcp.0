Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0D62CA1
	for <mptcp@lists.linux.dev>; Tue,  1 Feb 2022 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1643716165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuAHeQ+qDb7MY2CbYMVz7NlNabRXrDJHMrUxHueiZPg=;
	b=LTnyvXe7CuK1C2W6nCKmOjFo7LnihtDRdz9/wlkd+JwzZ0oWSowm5drFNVPpGG2DOulZ6l
	N02+S7WLOAE9Azl82EHA7WW02qp7R1GSZQ5n2jLXgkrfUz3oziyn5IDwpwiLhydcjo90Ez
	fGUWNuTk+QXzsB/g0dQlKk4KpoXGN28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263--Z-e8mWUPF2Ge7ik5zQ7aA-1; Tue, 01 Feb 2022 06:49:24 -0500
X-MC-Unique: -Z-e8mWUPF2Ge7ik5zQ7aA-1
Received: by mail-wr1-f69.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so5908762wrv.10
        for <mptcp@lists.linux.dev>; Tue, 01 Feb 2022 03:49:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=FuAHeQ+qDb7MY2CbYMVz7NlNabRXrDJHMrUxHueiZPg=;
        b=J3koGQOff+L5XI/XZ4e/zupQh6QsjxKCDfq0VcCbR6lk7eGXqTiYti+Qkf+e4fRLDP
         4UI2hw5n7JqgMs8UDVvp/8by+h3xfMXShmnHQqO7g8QYxmw36vghyEmgutU4zZ90oqUQ
         57CpsRZ0p7zBlQQAC5f1ZbQ2ZL39a2fDapLZ9wun79gSxq5waHB2gkVBjXE1bjQ599d9
         o6Tez/OG31wWEM+OYSBiRmd0z7cjvKmtnFcMd6YnD7CfbAe9izhZkw3iwaycCDS1kKQL
         gBzE0QwJzfaj1bEBSISFY/HH33kFnzhPxor0c/0vAUmtHYIvNooeGI1G25IAQFlseNNV
         R2ng==
X-Gm-Message-State: AOAM533TcD4Ax3f3Gr5AYKxs0ylEvtjtZdyJmby07Q9qbVeGDt22CVAD
	vN6+NY9ViTeXr8caOkXqMQee2ebMe1/gnRYLVb+smfYZWj69GvVE2MYhplKaiOC3p6bvmBdaS7w
	sASoDljc5Js8nfQc=
X-Received: by 2002:a05:6000:178e:: with SMTP id e14mr21005692wrg.564.1643716163340;
        Tue, 01 Feb 2022 03:49:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsm1TC6qc9TaR5hMG/Q+8eD96uXRQjNEolFhjhMCXuytuZdW2hEYlJ2xWgQMrLj6/5brhTyQ==
X-Received: by 2002:a05:6000:178e:: with SMTP id e14mr21005671wrg.564.1643716163062;
        Tue, 01 Feb 2022 03:49:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-96-254.dyn.eolo.it. [146.241.96.254])
        by smtp.gmail.com with ESMTPSA id c14sm15689162wri.56.2022.02.01.03.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 03:49:22 -0800 (PST)
Message-ID: <ae8ee5081d51235ed2c97edd023991c398e632c1.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v3 01/14] mptcp: add sysctl param to limit
 userspace PM activity
From: Paolo Abeni <pabeni@redhat.com>
To: Kishen Maloor <kishen.maloor@intel.com>, Geliang Tang
	 <geliangtang@gmail.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Tue, 01 Feb 2022 12:49:21 +0100
In-Reply-To: <01efbd33-cd64-8b71-7553-a80a9348f6e6@intel.com>
References: <20220128003836.2732694-1-kishen.maloor@intel.com>
	 <20220128003836.2732694-2-kishen.maloor@intel.com>
	 <CA+WQbws7UHpc0LA3kd7wSqB_k-6aEN9HLm_JbeNSi0XzsPw=Gg@mail.gmail.com>
	 <01efbd33-cd64-8b71-7553-a80a9348f6e6@intel.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 2022-01-31 at 14:23 -0800, Kishen Maloor wrote:
> On 1/27/22 10:38 PM, Geliang Tang wrote:
> > Hi Kishen,
> > 
> > Kishen Maloor <kishen.maloor@intel.com> 于2022年1月28日周五 08:39写道：
> > > 
> > > This change adds a new configurable param userspace_pm_local_addr_max
> > > to set a limit on the number of local addresses that may be recorded
> > > by a userspace path manager in the context of any MPTCP connection.
> > > Consequently, it also limits the # of subflows, i.e. to as many that
> > > could be established via the bounded set of local addresses.
> > > 
> > > The patch also ensures that other stats inside struct mptcp_pm_data
> > > that are updated along kernel code paths exercised by userspace PMs
> > > remain untouched for userspace PM managed sockets.
> > > 
> > > Signed-off-by: Kishen Maloor <kishen.maloor@intel.com>
> > > ---
> > >  net/mptcp/ctrl.c       | 17 +++++++++++++++++
> > >  net/mptcp/pm.c         |  4 +++-
> > >  net/mptcp/pm_netlink.c |  3 +++
> > >  net/mptcp/protocol.h   |  1 +
> > >  4 files changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > > index ae20b7d92e28..dffc2da6d713 100644
> > > --- a/net/mptcp/ctrl.c
> > > +++ b/net/mptcp/ctrl.c
> > > @@ -19,6 +19,7 @@ static int mptcp_pernet_id;
> > > 
> > >  #ifdef CONFIG_SYSCTL
> > >  static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
> > > +static int mptcp_max_addrs = MPTCP_PM_MAX_ADDR_ID;
> > >  #endif
> > > 
> > >  struct mptcp_pernet {
> > > @@ -32,6 +33,7 @@ struct mptcp_pernet {
> > >         u8 checksum_enabled;
> > >         u8 allow_join_initial_addr_port;
> > >         u8 pm_type;
> > > +       u8 userspace_pm_local_addr_max;
> > >  };
> > > 
> > >  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> > > @@ -69,6 +71,11 @@ int mptcp_get_pm_type(const struct net *net)
> > >         return mptcp_get_pernet(net)->pm_type;
> > >  }
> > > 
> > > +unsigned int mptcp_get_userspace_pm_local_addr_max(const struct net *net)
> > > +{
> > > +       return mptcp_get_pernet(net)->userspace_pm_local_addr_max;
> > > +}
> > > +
> > >  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> > >  {
> > >         pernet->mptcp_enabled = 1;
> > > @@ -77,6 +84,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> > >         pernet->allow_join_initial_addr_port = 1;
> > >         pernet->stale_loss_cnt = 4;
> > >         pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
> > > +       pernet->userspace_pm_local_addr_max = 10;
> > >  }
> > > 
> > >  #ifdef CONFIG_SYSCTL
> > > @@ -128,6 +136,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
> > >                 .extra1       = SYSCTL_ZERO,
> > >                 .extra2       = &mptcp_pm_type_max
> > >         },
> > > +       {
> > > +               .procname = "userspace_pm_local_addr_max",
> > > +               .maxlen = sizeof(u8),
> > > +               .mode = 0644,
> > > +               .proc_handler = proc_dou8vec_minmax,
> > > +               .extra1       = SYSCTL_ONE,
> > > +               .extra2       = &mptcp_max_addrs
> > > +       },
> > >         {}
> > >  };
> > > 
> > > @@ -149,6 +165,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> > >         table[3].data = &pernet->allow_join_initial_addr_port;
> > >         table[4].data = &pernet->stale_loss_cnt;
> > >         table[5].data = &pernet->pm_type;
> > > +       table[6].data = &pernet->userspace_pm_local_addr_max;
> > > 
> > >         hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> > >         if (!hdr)
> > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > index e5d5cb847209..24839cd7025c 100644
> > > --- a/net/mptcp/pm.c
> > > +++ b/net/mptcp/pm.c
> > > @@ -182,7 +182,9 @@ void mptcp_pm_subflow_check_next(struct mptcp_sock *msk, const struct sock *ssk,
> > >         bool update_subflows;
> > > 
> > >         update_subflows = (ssk->sk_state == TCP_CLOSE) &&
> > > -                         (subflow->request_join || subflow->mp_join);
> > > +                         (subflow->request_join || subflow->mp_join) &&
> > > +                         READ_ONCE(pm->pm_type) == MPTCP_PM_TYPE_KERNEL;
> > 
> > How about using mptcp_pm_is_userspace() instead for all the
> > MPTCP_PM_TYPE_KERNEL type check in this series?
> 
> Most PM related code paths in the kernel largely drive the in-kernel PM's flow and only a 
> small subset of those are shared with the userspace PM. Among those shared code paths, I 
> believe there's only one spot in my patches that has a userspace PM specific branch for
> which there's an explicit pm_type check against MPTCP_PM_TYPE_USERSPACE. The few remaining 
> checks are against MPTCP_PM_TYPE_KERNEL to bypass some in-kernel PM specific
> behaviors in *all* "non-kernel" PMs. As we may have > 2 PM types by construction, the code
> does not assume the userspace PM when pm_type != MPTCP_PM_TYPE_KERNEL.

You can introduce and use 'mptcp_pm_is_kernespace()'. There are a few
more chance to use it in later patches.

Thanks!

Paolo

