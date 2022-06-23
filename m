Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB243D9
	for <mptcp@lists.linux.dev>; Thu, 23 Jun 2022 12:36:00 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1o4LYP-0005Gy-Qd; Thu, 23 Jun 2022 14:03:21 +0200
Date: Thu, 23 Jun 2022 14:03:21 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v8 1/6] Squash to "mptcp: add get_subflow
 wrappers"
Message-ID: <20220623120321.GA21459@breakpoint.cc>
References: <cover.1655979747.git.geliang.tang@suse.com>
 <a911f0b25336c9c4098daa4d58a1d8a2ee81213f.1655979747.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a911f0b25336c9c4098daa4d58a1d8a2ee81213f.1655979747.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> -struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> +struct sock *mptcp_sched_get_send(struct mptcp_sock *msk, int *err)
>  {

Why the extra *err?
Almost everyone else uses ERR_PTR, PTR_ERR, IS_ERR, etc. to return
the error code directly, why not follow that model?
