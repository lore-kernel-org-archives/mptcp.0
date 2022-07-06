Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E95317C9
	for <mptcp@lists.linux.dev>; Wed,  6 Jul 2022 01:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B614C341C7;
	Wed,  6 Jul 2022 01:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657069225;
	bh=MzJuE//AKJavxoC74gsxrg9madb2bNPljuxHhQNuUaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IRdtd6/sDr7T7yy5m5Dn0ZNoQPScEk5nS/FNf7gJO3hpFjlReAvB4T6YXL1PPDdCj
	 jtgydbhCprizu9Pz5tiyvhQW6yh9EiIy386kR8QXBPxHAQSdXJG6Av5Axjk52w5nn/
	 +uWZbhb8OMDsCAsimlSgiiK6U+6LIvLzwdRrgd1fFsIlZ4LDvzXNvnKe0RkU32vSvj
	 I0VH93O7roJQ9gC5N+Byv8i7joA5++oxIuY1ZNRK5fKG0dUAbx88THyn08dN9EB//K
	 v+P6vZam/XkJX1uTq/q/3TIBA18coiBhP8ertx+VkpsSGWIZAQz/zj+t9Xb7zUH2KP
	 A6cm2SsFt2k8A==
Date: Tue, 5 Jul 2022 18:00:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, fw@strlen.de, geliang.tang@suse.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev
Subject: Re: [PATCH net 0/7] mptcp: Path manager fixes for 5.19
Message-ID: <20220705180024.4196a2bf@kernel.org>
In-Reply-To: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
References: <20220705213217.146898-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Jul 2022 14:32:10 -0700 Mat Martineau wrote:
> The MPTCP userspace path manager is new in 5.19, and these patches fix
> some issues in that new code.

Two questions looking at patchwork checks:

Is userspace_pm.sh not supposed to be included in the Makefile 
so that it's run by all the CIs that execute selftests?

Is it possible to CC folks who authored patches under Fixes?
Sorry if I already asked about this. I'm trying to work on refining 
the CC check in patchwork but I'm a little ambivalent about adding
this one to exceptions.

Those are sort of independent of the series, no need to repost.
