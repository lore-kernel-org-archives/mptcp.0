Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AFE68
	for <mptcp@lists.linux.dev>; Mon,  6 Dec 2021 17:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1638812871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5/6EyW1MkkWDxx0ChRQr+Ty+FVI+BG/Ly08gYzbJWb0=;
	b=eHeEShLLkWUymLJ+4hB+AnkAjj63aVYWqERcIxSKKxmBiPvPcy8F8jrykMCQ2QjNG4bPmU
	ji58axGrI2vnXLrKV6V/O4Cmyv6UDE/xaO2ou6X5N1us8kUto3YnexlH61ZQ5n2GWA/0CI
	yCr6yncZGTygiFMd1K4va4Ih1fF7ups=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-LSksCAoYPh-XWJpJrsSEpQ-1; Mon, 06 Dec 2021 12:47:50 -0500
X-MC-Unique: LSksCAoYPh-XWJpJrsSEpQ-1
Received: by mail-wm1-f71.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so211914wmb.4
        for <mptcp@lists.linux.dev>; Mon, 06 Dec 2021 09:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5/6EyW1MkkWDxx0ChRQr+Ty+FVI+BG/Ly08gYzbJWb0=;
        b=LaI1XK+jvnwLOcEQuCBOEfEMU+kUjktPZbYOK4WEpBpGUqmt/DV3N0TTc/Y8euQiVx
         0HXoHWL8A9oiRGywGOod2s5nkIOC2WQcNk8QHDQ28S9ysj10ofy3jjwYtyh86HCecCpK
         UKRcZDGdRaUIrtnlkuBuYEA37cimYUXL34QYsCBy2VvYPFi3hyymOHRijIJw95hMgW9e
         wLrFfOKVl9j4jmhRnBCTULP3rA5dbT49JFUiO9VXjWOT0bqIpPU50Agszjj/L9Ts66Lu
         5T2O/K09v44sjWAlYyxzMHwXtkBBqdMwV5H4Xeb1iWhJoAZYT6ECGOwqzT4nBU7+3sZD
         0CKg==
X-Gm-Message-State: AOAM531UZL3rU+ArVuKt3k/qB8/0l7nAcTK8Um5KqNkt56luEcsvFU+h
	mj74102sFa3f7jiTD7wh47NNZlrwwT6KEoQRghZogE0KavSCAJnX2+YLpuSlvqCZeQMXkPx3mL9
	MqdiVpAyFdxAOd8s=
X-Received: by 2002:a05:6000:47:: with SMTP id k7mr43753637wrx.485.1638812868591;
        Mon, 06 Dec 2021 09:47:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzH4v2dBfM74dEOSHUrJ1SC2/6qD0vwP0WzCUJgzBkT3YEKdZ1JczqsD21HudnACsP8dyX+eA==
X-Received: by 2002:a05:6000:47:: with SMTP id k7mr43753610wrx.485.1638812868335;
        Mon, 06 Dec 2021 09:47:48 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-1.dyn.eolo.it. [146.241.252.1])
        by smtp.gmail.com with ESMTPSA id j18sm28390wmq.44.2021.12.06.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:47:48 -0800 (PST)
Message-ID: <2190ad1b150179fb1b311aa8c89344e440d7befa.camel@redhat.com>
Subject: Re: [PATCH mptcp-next v2 5/6] mptcp: Add a per-namespace sysctl to
 set the default path manager type
From: Paolo Abeni <pabeni@redhat.com>
To: Geliang Tang <geliangtang@gmail.com>, Mat Martineau
	 <mathew.j.martineau@linux.intel.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Mon, 06 Dec 2021 18:47:47 +0100
In-Reply-To: <CA+WQbwuwfq0E-JQj_7cDf0R+NuMJ44uq+_6VYVceAfrwjYA8BQ@mail.gmail.com>
References: <20211202005216.154787-1-mathew.j.martineau@linux.intel.com>
	 <20211202005216.154787-6-mathew.j.martineau@linux.intel.com>
	 <CA+WQbwuwfq0E-JQj_7cDf0R+NuMJ44uq+_6VYVceAfrwjYA8BQ@mail.gmail.com>
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
Content-Transfer-Encoding: 8bit

On Mon, 2021-12-06 at 15:56 +0800, Geliang Tang wrote:
> Hi Mat,
> 
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年12月2日周四 08:52写道：
> > 
> > The new net.mptcp.pm_type sysctl determines which path manager will be
> > used by each newly-created MPTCP socket.
> > 
> > v2: Handle builds without CONFIG_SYSCTL
> > 
> > Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> > ---
> >  Documentation/networking/mptcp-sysctl.rst | 18 ++++++++++++++++++
> >  net/mptcp/ctrl.c                          | 21 +++++++++++++++++++++
> >  net/mptcp/pm.c                            | 13 +++++++++----
> >  net/mptcp/protocol.h                      |  1 +
> >  4 files changed, 49 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> > index b0d4da71e68e..e263dfcc4b40 100644
> > --- a/Documentation/networking/mptcp-sysctl.rst
> > +++ b/Documentation/networking/mptcp-sysctl.rst
> > @@ -46,6 +46,24 @@ allow_join_initial_addr_port - BOOLEAN
> > 
> >         Default: 1
> > 
> > +pm_type - INTEGER
> > +
> > +       Set the default path manager type to use for each new MPTCP
> > +       socket. In-kernel path management will control subflow
> > +       connections and address advertisements according to
> > +       per-namespace values configured over the MPTCP netlink
> > +       API. Userspace path management puts per-MPTCP-connection subflow
> > +       connection decisions and address advertisements under control of
> > +       a privileged userspace program, at the cost of more netlink
> > +       traffic to propagate all of the related events and commands.
> > +
> > +       This is a per-namespace sysctl.
> > +
> > +       * 0 - In-kernel path manager
> > +       * 1 - Userspace path manager
> > +
> > +       Default: 0
> > +
> >  stale_loss_cnt - INTEGER
> >         The number of MPTCP-level retransmission intervals with no traffic and
> >         pending outstanding data on a given subflow required to declare it stale.
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index 8b235468c88f..ae20b7d92e28 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
> > @@ -16,6 +16,11 @@
> >  #define MPTCP_SYSCTL_PATH "net/mptcp"
> > 
> >  static int mptcp_pernet_id;
> > +
> > +#ifdef CONFIG_SYSCTL
> > +static int mptcp_pm_type_max = __MPTCP_PM_TYPE_MAX;
> > +#endif
> > +
> >  struct mptcp_pernet {
> >  #ifdef CONFIG_SYSCTL
> >         struct ctl_table_header *ctl_table_hdr;
> > @@ -26,6 +31,7 @@ struct mptcp_pernet {
> >         u8 mptcp_enabled;
> >         u8 checksum_enabled;
> >         u8 allow_join_initial_addr_port;
> > +       u8 pm_type;
> >  };
> > 
> >  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> > @@ -58,6 +64,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
> >         return mptcp_get_pernet(net)->stale_loss_cnt;
> >  }
> > 
> > +int mptcp_get_pm_type(const struct net *net)
> > +{
> > +       return mptcp_get_pernet(net)->pm_type;
> > +}
> > +
> >  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> >  {
> >         pernet->mptcp_enabled = 1;
> > @@ -65,6 +76,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> >         pernet->checksum_enabled = 0;
> >         pernet->allow_join_initial_addr_port = 1;
> >         pernet->stale_loss_cnt = 4;
> > +       pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
> >  }
> > 
> >  #ifdef CONFIG_SYSCTL
> > @@ -108,6 +120,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
> >                 .mode = 0644,
> >                 .proc_handler = proc_douintvec_minmax,
> >         },
> > +       {
> > +               .procname = "pm_type",
> > +               .maxlen = sizeof(u8),
> > +               .mode = 0644,
> > +               .proc_handler = proc_dou8vec_minmax,
> > +               .extra1       = SYSCTL_ZERO,
> > +               .extra2       = &mptcp_pm_type_max
> > +       },
> >         {}
> >  };
> > 
> > @@ -128,6 +148,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> >         table[2].data = &pernet->checksum_enabled;
> >         table[3].data = &pernet->allow_join_initial_addr_port;
> >         table[4].data = &pernet->stale_loss_cnt;
> > +       table[5].data = &pernet->pm_type;
> > 
> >         hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
> >         if (!hdr)
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 451948b11030..f1fc08d89c20 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -365,8 +365,12 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
> > 
> >  void mptcp_pm_data_reset(struct mptcp_sock *msk)
> >  {
> > -       bool subflows_allowed = !!mptcp_pm_get_subflows_max(msk);
> > +       u8 pm_type = mptcp_get_pm_type(sock_net((struct sock *)msk));
> >         struct mptcp_pm_data *pm = &msk->pm;
> > +       bool subflows_allowed;
> > +
> > +       subflows_allowed = !!mptcp_pm_get_subflows_max(msk) &&
> > +               pm_type == MPTCP_PM_TYPE_KERNEL;
> > 
> >         pm->add_addr_signaled = 0;
> >         pm->add_addr_accepted = 0;
> > @@ -374,13 +378,14 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
> >         pm->subflows = 0;
> >         pm->rm_list_tx.nr = 0;
> >         pm->rm_list_rx.nr = 0;
> > -       WRITE_ONCE(pm->pm_type, MPTCP_PM_TYPE_KERNEL);
> > +       WRITE_ONCE(pm->pm_type, pm_type);
> >         /* pm->work_pending must be only be set to 'true' when
> >          * pm->pm_type is set to MPTCP_PM_TYPE_KERNEL
> >          */
> >         WRITE_ONCE(pm->work_pending,
> > -                  (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
> > -                  !!mptcp_pm_get_add_addr_signal_max(msk));
> > +                  pm_type == MPTCP_PM_TYPE_KERNEL &&
> > +                  ((!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
> > +                   !!mptcp_pm_get_add_addr_signal_max(msk)));
> 
> I think pm_type == MPTCP_PM_TYPE_KERNEL is somehow duplicate here, how
> about use this code instead:
> 
>         WRITE_ONCE(pm->work_pending,
>                    (!!mptcp_pm_get_local_addr_max(msk) && subflows_allowed) ||
>                    (!!mptcp_pm_get_add_addr_signal_max(msk) && pm_type
> == MPTCP_PM_TYPE_KERNEL));

Still apropos making this chunk of code more readable, what about:

	if (pm_type == MPTCP_PM_TYPE_KERNEL) {
		// [current code]
	} else {
		WRITE_ONCE(pm->work_pending, 0);
		WRITE_ONCE(pm->accept_addr, 0);
		WRITE_ONCE(pm->accept_subflow, 0); 
	}

?

Cheers,

Paolo

