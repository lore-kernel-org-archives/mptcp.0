Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D25EADA
	for <mptcp@lists.linux.dev>; Fri,  9 Feb 2024 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707438234; cv=none; b=JgijRN6LRjFbH2cM1/3g4mpR2A77QYbewBUWy5dg1Q5KA8cVL7xls+eYF+HNgHNkMhhFJYRpF6CYkx2EbPlI2Ug1Aunpz/rrDSk168SnzVtpKpbfJoWBhiahhNRAKcXopAC2RDMisrGNILq7k/2hIqNajFpLD+1vI4VoODI0njM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707438234; c=relaxed/simple;
	bh=fbtyj+SpHBVZMzQt3CkTr6UAZjZdwDAkmdPaiYQYTvA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UYgKMhujKComRmtpYhnqmfNsEKGz091EKnNDY5FxKckgBl0sHC5byYuJnPYcHUlONm/Ji1qdCtx1/P/EeMw726ZGgaBs6HbFJEeij5qVibvhUnDjLQ7Oi9Q/Isvtu6jybD/FdJog8WuFk4BVrPo9dS2vPvO9nPLt79glf/0lnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+9SBI8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+9SBI8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E8C433F1;
	Fri,  9 Feb 2024 00:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707438234;
	bh=fbtyj+SpHBVZMzQt3CkTr6UAZjZdwDAkmdPaiYQYTvA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=K+9SBI8flJUSocqMZ4x0mCRLtLjOvWAygsM2lxZ6Wz+6cBYj71N09oc7hnVE+FbmC
	 k9tj/kHKrKZcAUz40dMXVnkb+y8GmId4m2KEZVP6gxhEYzbP+CYMribZ2spIMbfy7p
	 dmPlog/7OGiCXgGoHYschlCxgy1p18WMktJXEqke1Y1lrVUJcDZf/FqshWLqpttBPm
	 2HYfwSWVEA/pZafGokI6Nw2YgBmtE0ARyWlnYT54jqelKkBBYS/dt7Yt0aQe+OcY4u
	 uPn8JpGdkUZHfTaw6QIBeCgSPKuBQvXC/qxyPoQ8yZh1qFSby6IZn6+Zodmu+GpiHx
	 y7dGfHewsRBDA==
Date: Thu, 8 Feb 2024 16:23:52 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v2 0/4] mptcp: fix duplicate subflow creation
In-Reply-To: <cover.1707418323.git.pabeni@redhat.com>
Message-ID: <8a48840b-8712-d2ca-6b48-9b3013cc6586@kernel.org>
References: <cover.1707418323.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 8 Feb 2024, Paolo Abeni wrote:

> As reported by Mat, the in kernel PM can, in some edge scenarios,
> unexpectedly create multiple subflows with the same local and remote
> address.
>
> The real fix is implemented by patch 4/4 with some more accurate check
> at subflow creation time.
>
> Patches 1-3 are roughly optional pre-requisities, added to avoid
> introducing more data-races with the actual fix. Patch 1/4 is a bit
> debatable, as it changes the existing ULP API, but I could not find a
> better solution and there is some similar prior art:
> commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info")
>
> This address feedback from Mat on v1, see the patches changelog for
> the details (no changes in patch 1/4).
>
> Paolo Abeni (4):
>  mptcp: fix lockless access in subflow ULP diag
>  mptcp: fix data races on local_id
>  mptcp: fix data races on remote_id
>  mptcp: fix duplicate subflow creation
>

Hi Paolo -

v2 LGTM, thanks:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> include/net/tcp.h        |  2 +-
> net/mptcp/diag.c         |  8 +++++--
> net/mptcp/pm_netlink.c   | 45 +++++++++++++++++++++-------------------
> net/mptcp/pm_userspace.c |  2 +-
> net/mptcp/protocol.c     |  2 +-
> net/mptcp/protocol.h     | 15 +++++++++++---
> net/mptcp/subflow.c      | 15 +++++++-------
> net/tls/tls_main.c       |  2 +-
> 8 files changed, 54 insertions(+), 37 deletions(-)
>
> -- 
> 2.43.0
>
>
>
