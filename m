Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C202C88
	for <mptcp@lists.linux.dev>; Thu,  7 Oct 2021 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1633602466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihxQGY6c+fFERVyX2woyzvCVBkSLX9Hn28GcYaSUBnk=;
	b=MXAnk7j7IVPoCz/79Y66t65Y4bOL12by3jai6brWpymagD6TH8j6Y3bCsXTVozoWwfu7GY
	Q7XTY6r8ibvg8z8VId4DnmRFqu8Fa4d00XOuXSMay3qehekolPiQttk+duWNZhMkVVhDXm
	VzH8lQX0LxLyXI7ai1uPTb5lsJkJG6o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-ZH5CuNouN0Wzq7MVjsrQHA-1; Thu, 07 Oct 2021 06:27:44 -0400
X-MC-Unique: ZH5CuNouN0Wzq7MVjsrQHA-1
Received: by mail-wr1-f72.google.com with SMTP id o2-20020a5d4a82000000b00160c6b7622aso4225157wrq.12
        for <mptcp@lists.linux.dev>; Thu, 07 Oct 2021 03:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ihxQGY6c+fFERVyX2woyzvCVBkSLX9Hn28GcYaSUBnk=;
        b=30ifJkoRfqU2ztccGDjxhjVs/KtP2Z/eVkMZ/H06bHnZLGMn+XjLuc+H5/FBPKAXsG
         ns22YZdPKK56/o0xBMw8+pEFfS99r9D4dswXsaKVTOLKVhE5gSavoMYrH/2P66ae+khD
         HV/IOWXTgEbeqrnvaPKJA1oLbYM/pIFLsqjRYmDXUmtc1Zr9XM/3+DXAXO9FsfqLpW/P
         uQ6bxj0nj+31w3Bkj3gD8buIXLmmyIffKY8nZmyFx8xRBGyyJ1U09h3+1rMliL1nciv7
         6QvMR4tq9R5YZLmwop8lROtuRm7OhvCdbg08RmgGdh1IXEwRbyXweGGCPeKHrv+pWQjK
         7qEQ==
X-Gm-Message-State: AOAM530opIQL6N9R8ycVt7orwClh5+7ZZT8aPSsFFlLtvzphoF8paTGN
	AuD+F4ag2Tm9wWCoN1CEkPFf2ORGTPfhdRdZ8n65q/pK+kToamkWzbc7/ih4Bjq96F9rbjBStpD
	B9SQ0If+U2qI36zk=
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr9399307wmd.83.1633602463661;
        Thu, 07 Oct 2021 03:27:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHCfEAAuTEq0bXur1xmwPxVRQo3UEHf9PQNU76DoY4YnPP+E3yKlnwnWtJlMLqRACYAASFsg==
X-Received: by 2002:a05:600c:294a:: with SMTP id n10mr9399282wmd.83.1633602463424;
        Thu, 07 Oct 2021 03:27:43 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-183.dyn.eolo.it. [146.241.225.183])
        by smtp.gmail.com with ESMTPSA id p13sm4893328wma.22.2021.10.07.03.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 03:27:43 -0700 (PDT)
Message-ID: <fe75d37883a8805484bace4498f754d8c63b64ed.camel@redhat.com>
Subject: Re: [RFC PATCH 4/6] mptcp: Add a per-namespace sysctl to set the
 default path manager type
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>, mptcp@lists.linux.dev
Cc: kishen.maloor@intel.com
Date: Thu, 07 Oct 2021 12:27:42 +0200
In-Reply-To: <20211006235953.212243-5-mathew.j.martineau@linux.intel.com>
References: <20211006235953.212243-1-mathew.j.martineau@linux.intel.com>
	 <20211006235953.212243-5-mathew.j.martineau@linux.intel.com>
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

On Wed, 2021-10-06 at 16:59 -0700, Mat Martineau wrote:
> The new net.mptcp.userspace_pm_default sysctl determines which path
> manager will be used by each newly-created MPTCP socket.
> 
> Alternative: set the per-namespace default using the netlink API instead.
> 
> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
> ---
>  Documentation/networking/mptcp-sysctl.rst | 17 +++++++++++++++++
>  net/mptcp/ctrl.c                          | 16 ++++++++++++++++
>  net/mptcp/pm.c                            |  4 +++-
>  net/mptcp/protocol.h                      |  1 +
>  4 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index b0d4da71e68e..9f5d7bad9fba 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -46,6 +46,23 @@ allow_join_initial_addr_port - BOOLEAN
>  
>  	Default: 1
>  
> +userspace_pm_default - BOOLEAN
> +
> +	Set the default path manager type to use for each new MPTCP
> +	socket.  The in-kernel path manager is used if this is set to 0,
> +	and a userspace path manager is used if the value is set
> +	to 1. In-kernel path management will control subflow connections
> +	and address advertisements according to per-namespace values
> +	configured over the MPTCP netlink API. Userspace path management
> +	puts per-MPTCP-connection subflow connection decisions and
> +	address advertisements under control of a privileged userspace
> +	program, at the cost of more netlink traffic to propagate all of
> +	the related events and commands.
> +
> +	This is a per-namespace sysctl.
> +
> +	Default: 0
> +
>  stale_loss_cnt - INTEGER
>  	The number of MPTCP-level retransmission intervals with no traffic and
>  	pending outstanding data on a given subflow required to declare it stale.
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 8b235468c88f..e7aedb90e35a 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -26,6 +26,7 @@ struct mptcp_pernet {
>  	u8 mptcp_enabled;
>  	u8 checksum_enabled;
>  	u8 allow_join_initial_addr_port;
> +	u8 userspace_pm_default;
>  };
>  
>  static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -58,6 +59,11 @@ unsigned int mptcp_stale_loss_cnt(const struct net *net)
>  	return mptcp_get_pernet(net)->stale_loss_cnt;
>  }
>  
> +int mptcp_userspace_pm_default(const struct net *net)
> +{
> +	return mptcp_get_pernet(net)->userspace_pm_default;
> +}
> +
>  static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  {
>  	pernet->mptcp_enabled = 1;
> @@ -65,6 +71,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
>  	pernet->checksum_enabled = 0;
>  	pernet->allow_join_initial_addr_port = 1;
>  	pernet->stale_loss_cnt = 4;
> +	pernet->userspace_pm_default = 0;
>  }
>  
>  #ifdef CONFIG_SYSCTL
> @@ -108,6 +115,14 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.mode = 0644,
>  		.proc_handler = proc_douintvec_minmax,
>  	},
> +	{
> +		.procname = "userspace_pm_default",
> +		.maxlen = sizeof(u8),
> +		.mode = 0644,
> +		.proc_handler = proc_dou8vec_minmax,
> +		.extra1       = SYSCTL_ZERO,
> +		.extra2       = SYSCTL_ONE
> +	},
>  	{}
>  };
>  
> @@ -128,6 +143,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
>  	table[2].data = &pernet->checksum_enabled;
>  	table[3].data = &pernet->allow_join_initial_addr_port;
>  	table[4].data = &pernet->stale_loss_cnt;
> +	table[5].data = &pernet->userspace_pm_default;
>  
>  	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
>  	if (!hdr)
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 3fa3c0faed48..e97a22fcc0fa 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -367,6 +367,8 @@ void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
>  
>  void mptcp_pm_data_init(struct mptcp_sock *msk)
>  {
> +	struct sock *sk = (struct sock *)msk;
> +
>  	msk->pm.add_addr_signaled = 0;
>  	msk->pm.add_addr_accepted = 0;
>  	msk->pm.local_addr_used = 0;
> @@ -378,7 +380,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
>  	WRITE_ONCE(msk->pm.accept_addr, false);
>  	WRITE_ONCE(msk->pm.accept_subflow, false);
>  	WRITE_ONCE(msk->pm.remote_deny_join_id0, false);
> -	WRITE_ONCE(msk->pm.userspace, false);
> +	WRITE_ONCE(msk->pm.userspace, mptcp_userspace_pm_default(sock_net(sk)));

I'm wondering if we could set work_pending as well, and avoid some
multiple conditionals in patch 2/6

Other than that LGTM!

It would be nice to have some simple self-test, enabling user-space pm
and observing no action is taken on add_addr, connection established,
etc.

I think the procfs switch for user-space pm fits more easily self-
tests.

/P

