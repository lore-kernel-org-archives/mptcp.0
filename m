Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243557C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 10:24:14 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q3a2o-0000pY-Gb; Mon, 29 May 2023 12:24:06 +0200
Date: Mon, 29 May 2023 12:24:06 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 02/12] Squash to "mptcp: add sched in
 mptcp_sock"
Message-ID: <20230529102406.GA19295@breakpoint.cc>
References: <cover.1685351620.git.geliang.tang@suse.com>
 <e74931ae5fd52b1353bf90727fbaedbc45c05a83.1685351620.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74931ae5fd52b1353bf90727fbaedbc45c05a83.1685351620.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> @@ -64,6 +64,10 @@ int mptcp_init_sched(struct mptcp_sock *msk,
>  	if (!bpf_try_module_get(sched, sched->owner))
>  		return -EBUSY;
>  
> +	msk->data = kzalloc(sizeof(struct mptcp_sched_data), GFP_ATOMIC);
> +	if (!msk->data)
> +		return -ENOMEM;
> +

Who will undo module_get call on sched->owner?

Might be a good idea to add a gfp_t arg to the function as well,
at least one caller could use GFP_KERNEL here.

data is a pretty generic name...
Maybe call ->data ->sched_data instead?

