Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D207F7C
	for <mptcp@lists.linux.dev>; Mon, 29 May 2023 10:29:25 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1q3a7v-0000rc-Q2; Mon, 29 May 2023 12:29:23 +0200
Date: Mon, 29 May 2023 12:29:23 +0200
From: Florian Westphal <fw@strlen.de>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 04/12] mptcp: add last_snd in sched_data
Message-ID: <20230529102923.GB19295@breakpoint.cc>
References: <cover.1685351620.git.geliang.tang@suse.com>
 <6171af792f902d1e413507ec1b0507f304b1e034.1685351620.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6171af792f902d1e413507ec1b0507f304b1e034.1685351620.git.geliang.tang@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Geliang Tang <geliang.tang@suse.com> wrote:
> This patch moves last_snd from struct mptcp_sock to struct
> mptcp_sched_data.

Please describe why you are moving it.

It might seem obvious to you, but it might not be obvious to
reviewers.

I guess "... to make it accessible to bpf schedulers"?
