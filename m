Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF7A22EE5
	for <mptcp@lists.linux.dev>; Tue, 18 Mar 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260157; cv=none; b=stcFbi1XeRHRDqPV9UA4WbxjtFuil7tqQgi++6IPsWvZ9NP2oocqZeN+P7pL6swjsiIVE4qrLW1oUS25ylJQo6ZP/bRrXQfK3lEygGhUq4Omr0JM0xmkMB3B9jTHVxKSYbV4EiOSbewTdZ0zff+uFSPyeBsph8wYmByqB7P88YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260157; c=relaxed/simple;
	bh=ar97fPxjAqw0Zi6Y6euSj3yMwEIp7MWSzIAvFUzfH8M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gf0eKZWrzk6WNojRqF4vgVG7rOFtqQv8gFZJO9iTwSj79gR2Mrc3qXcbXRjpqTPwEgC0UZoC7eXhJOQrO+dNEzc69WigENF5JivdBSAMNncXkvHh30FavaiW325IwlC2pnUcf16lrb5mWtV5mDxyLkse1yNV5Yr2S6c5Pyle890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihKsWuJm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihKsWuJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192D7C4CEE3;
	Tue, 18 Mar 2025 01:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742260157;
	bh=ar97fPxjAqw0Zi6Y6euSj3yMwEIp7MWSzIAvFUzfH8M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ihKsWuJmkgicbRhg1dZfzurj1WhTTY84JS/13DVnmNscptoqfs48NBAN8WDcaudIO
	 Kj3Xm+xa4OPXv3lD1Jc27GmxzCWUFvg3HR5FsqmEKs0tW5yqW0Li/fPaYb4khL0QvT
	 gustnJL/C/S1S9EOledBsruxXqgSAOMe6UaS1IAkUDdvwZkPqHM4FX08Ipa40q8GM3
	 nj3JA/8Ct7Ji64jz6Xl6rJVoLt45GF+jfHaRH6yRfpDsMA5uYdgTV8RY5TOEw7R2Td
	 HgyubEwiOhV9zZFgRtJ68LPqz9a7PrvqTz1ForxfHcQ6ectu5DK/CCJj9rwwTAB+TU
	 JOKBlfZJzN3jg==
Date: Mon, 17 Mar 2025 18:09:15 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v1 1/8] mptcp: add mptcp_validate_scheduler
 helper
In-Reply-To: <01f14f2e6c9ba32887af1d52e29753dd6b85e544.1741226722.git.tanggeliang@kylinos.cn>
Message-ID: <757da9a0-9243-1df8-36ca-828410836768@kernel.org>
References: <cover.1741226722.git.tanggeliang@kylinos.cn> <01f14f2e6c9ba32887af1d52e29753dd6b85e544.1741226722.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 6 Mar 2025, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> New interface .validate is added in struct bpf_struct_ops recently, this
> patch implements it as a new helper mptcp_validate_scheduler() for struct
> mptcp_sched_ops.
>
> In this helper, check whether the required ops "get_subflow" of struct
> mptcp_sched_ops has been implemented.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

This patch LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

The rest of the series looks ok to squash, with one note on patch 3.


- Mat

> ---
> net/mptcp/protocol.h |  1 +
> net/mptcp/sched.c    | 17 +++++++++++++++--
> 2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 3492b256ecba..77b4ec0b0dd8 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -740,6 +740,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
> 			 struct sockaddr_storage *addr,
> 			 unsigned short family);
> struct mptcp_sched_ops *mptcp_sched_find(const char *name);
> +int mptcp_validate_scheduler(struct mptcp_sched_ops *sched);
> int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
> void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
> void mptcp_sched_init(void);
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index f09f7eb1d63f..1e59072d478c 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -82,10 +82,23 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
> 	rcu_read_unlock();
> }
>
> -int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
> +int mptcp_validate_scheduler(struct mptcp_sched_ops *sched)
> {
> -	if (!sched->get_send)
> +	if (!sched->get_send) {
> +		pr_err("%s does not implement required ops\n", sched->name);
> 		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
> +{
> +	int ret;
> +
> +	ret = mptcp_validate_scheduler(sched);
> +	if (ret)
> +		return ret;
>
> 	spin_lock(&mptcp_sched_list_lock);
> 	if (mptcp_sched_find(sched->name)) {
> -- 
> 2.43.0
>
>
>
