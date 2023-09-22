Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFA14174B
	for <mptcp@lists.linux.dev>; Fri, 22 Sep 2023 16:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C80C433C8;
	Fri, 22 Sep 2023 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695399473;
	bh=Wmv2JgjasM45ucSctF2aeiQt2o87qHbqkIXh1kVl7bU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dPOqaY6SNMrMq8e6JI5hUmFD0mwsbmhhBuVPPwC5bgq1YwYT2XPj+kPS5/1LUZy+C
	 PevAtGtFVk4GSQoZF0AEzbUN44DJFVcccSZAKS0unKOgcRRqgaaog72zbO/LeJjEkA
	 rltEFYTPtuhSizdv6Nyhp+dr/qJ9t29UoeiavVDBwpimba3Y9fsX6ZOa9dqAy6eyY5
	 /+MzkwUYM7SEpkZEFIVVmpjgGTU4QaFzn1gWIk0rS0r+lnCpGoLsWc69Gels2v0iRq
	 6SCaCSrtIN66lQUzqa35wxyPhDqm8Ub+oTtV+8mOPug30xXXhZN6rInolixZdi7k3E
	 KxBaUlD5efs9w==
Date: Fri, 22 Sep 2023 09:17:48 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH v5 mptcp-next 0/4] mptcp: misc improvement
In-Reply-To: <cover.1695368456.git.pabeni@redhat.com>
Message-ID: <bf5dec6d-edc8-4a71-bd56-3628d195d05c@kernel.org>
References: <cover.1695368456.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 22 Sep 2023, Paolo Abeni wrote:

> This series is a follow-up the discussion ongoing here:
>
> https://github.com/multipath-tcp/mptcp_net-next/issues/437
>
> Daire reported several sub-optimal MPTCP behaviour on high-latency
> links.
>
> At least 3 different items stands off:
>
> * notsent_lowat setting fooling the scheduler
> * sub-optimal send buffer autotuning
> * delayed acks being de-facto disabled due to subflow rcvlowat
>
> This series is an attempt to address the first 2 points above.
>
> v4 -> v5:
> - dealing with Mat feedback in patch 1/4 and 4/4
>

v5 LGTM, thanks Paolo!

Reviewed-by: Mat Martineau <martineau@kernel.org>

> v3 -> v4:
> - added patch 1/4, fixing a pre-existing issue related. That patch
>   should likely go via -net, included here because the issue can not
>   manifest itself until patch 4/4.
>   Despite by best attempt to test this, I thing it would be easier
>   to just lest syzkaller crunch it more than a bit.
>
> v2 -> v3:
> - avoid ingremental updates, always recompute sum(ssk->sndbuf) to avoid
>   drift on memory pressure/decrease
> - add some needed comments
>
> v1 -> v2:
> - fixed compiler warning in patch 3/3 && more local testing
>
> Paolo Abeni (4):
>  mptcp: fix delegated action races.
>  mptcp: consolidate sockopt synchronization
>  mptcp: ignore notsent_lowat setting at the subflow level.
>  mptcp: refactor sndbuf auto-tuning.
>
> net/mptcp/protocol.c | 48 +++++++++++++++---------
> net/mptcp/protocol.h | 89 ++++++++++++++++++++++++++++++--------------
> net/mptcp/sockopt.c  | 33 +++++-----------
> net/mptcp/subflow.c  | 31 ++++++++-------
> 4 files changed, 119 insertions(+), 82 deletions(-)
>
> -- 
> 2.41.0
>
>
>
