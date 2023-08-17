Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8941518F
	for <mptcp@lists.linux.dev>; Thu, 17 Aug 2023 00:08:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E859CC433C8;
	Thu, 17 Aug 2023 00:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692230882;
	bh=zwvH/x+Ir5t4IjAIVG/jIqN/sK/nyAzFJFzFV8y16Iw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=mkZWsh6zMM8C3t6W0FhZIYQ2e7CgS4WAfcEgNgxz5B94uE0Cy9eY4w6oICGqNjPS8
	 A4q/VtfuMrcH3XAlBxVc7Fzqv9eDv9aDYA6h7tEHL5v8k0CAB8GSwPnByhupRnIiea
	 hYC4KExST513yfxXIbwyJLfYbo6E63SiQfIphHsZiuPgIhGWNsEaMNv5U9p7kGyo1i
	 +NbITmPDV1/pHS3NuWsQNQ1vnAZ4I7EX2WNTb4Mqz5bCIhFdIMFb2ZfCbIa4wGlGWo
	 pEDBozaPgowQJ7wf5pvWW0NQ2uw7PRsVAG+zBKMxSVAG88yHFRsF42Ym7GC5pb7nAM
	 4Fr4PGu9bYPNg==
Date: Wed, 16 Aug 2023 17:07:55 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/9] Update scheduler refactor commits
In-Reply-To: <cover.1692080803.git.geliang.tang@suse.com>
Message-ID: <ecf0e1f7-feae-e8bb-dad0-5e3a87b4aec5@kernel.org>
References: <cover.1692080803.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 15 Aug 2023, Geliang Tang wrote:

> Update scheduler refactor commits:
> - drop data_init interface.
> - call mptcp_sched_default_get_subflow in get_send/retrans.
> - update commit logs.
>

Thanks for the changes Geliang, these look good to squash.

Matthieu, I think the build failures were due to the squash commits being 
applied after the final export branch commit?

- Mat


> Geliang Tang (9):
>  Squash to "mptcp: add struct mptcp_sched_ops"
>  Squash to "mptcp: add scheduler wrappers"
>  Squash to "mptcp: register default scheduler"
>  Squash to "selftests/bpf: Add mptcp sched structs"
>  Squash to "selftests/bpf: Add bpf_first scheduler"
>  Squash to "selftests/bpf: Add bpf_bkup scheduler"
>  Squash to "selftests/bpf: Add bpf_rr scheduler"
>  Squash to "selftests/bpf: Add bpf_red scheduler"
>  Squash to "selftests/bpf: Add bpf_burst scheduler"
>
> include/net/mptcp.h                           |  4 +--
> net/mptcp/sched.c                             | 36 ++++---------------
> tools/testing/selftests/bpf/bpf_tcp_helpers.h |  4 +--
> .../selftests/bpf/progs/mptcp_bpf_bkup.c      | 11 ++----
> .../selftests/bpf/progs/mptcp_bpf_burst.c     | 15 +++-----
> .../selftests/bpf/progs/mptcp_bpf_first.c     | 10 ++----
> .../selftests/bpf/progs/mptcp_bpf_red.c       |  9 ++---
> .../selftests/bpf/progs/mptcp_bpf_rr.c        | 11 ++----
> 8 files changed, 23 insertions(+), 77 deletions(-)
>
> -- 
> 2.35.3
>
>
>
