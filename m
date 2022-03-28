Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434907C
	for <mptcp@lists.linux.dev>; Mon, 28 Mar 2022 09:51:55 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1nYm2T-0005AH-6x; Mon, 28 Mar 2022 11:51:53 +0200
Date: Mon, 28 Mar 2022 11:51:53 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v7 4/8] mptcp: add sched in mptcp_sock
Message-ID: <20220328095153.GC18687@breakpoint.cc>
References: <cover.1648459865.git.geliang.tang@suse.com>
 <2812381119c23048dadbf5372293c724ff4b7970.1648459865.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2812381119c23048dadbf5372293c724ff4b7970.1648459865.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> +void mptcp_release_sched(struct mptcp_sock *msk)
> +{
> +	if (msk->sched && msk->sched->release)
> +		msk->sched->release(msk);
> +	bpf_module_put(msk->sched, msk->sched->owner);
> +	msk->sched = NULL;

Strange.  First line makes sure we don't null deref on msk->sched ==
NULL, but bpf_module_put() passes msk->sched->owner?

Does bpf_module_put need to live in a 
if (msk->sched) { branch or is the null test redundant?
