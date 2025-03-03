Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A51F1300
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998377; cv=none; b=i8S/2POFmX7MKBYZhKHe1hP3LlgBteIQJ6fvhrpQ2nz7mRzUI97PN6C6GKcrUVyzYd4PkiJWgWFCQiVb3+69XepAZ7Pw4yza2ZR8skDr996AGpEshb0xYNvkkIJK3SlyopQVM71Slx2Pm99agdZKvTkRIHOhc6UHjDSccF8wlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998377; c=relaxed/simple;
	bh=+zhivfQqflDVEnKSU8+cQ29EeEATu9u9MSBbsCFaZgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIPR05f9R5b7sU21zG+pjLZnxa7ar0l7La7iModzIqoxD6eHr1bJWqvXbtSFaaXw/AVFkZxDSQTENNSUtcT5TySLc8Lz/iSk7y4rurfW5kJPJoDegQHAUe1sKEEzXLd1/c/QEgjwNpVHXm9THRNTwhMMNAuMqFKLVli1Pv+CqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Bx0jR+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Bx0jR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A168C4CED6;
	Mon,  3 Mar 2025 10:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998377;
	bh=+zhivfQqflDVEnKSU8+cQ29EeEATu9u9MSBbsCFaZgM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F3Bx0jR+5qn1yKF22lyR0Esb8sATGBSVv1lPuV0KGN97oCMJdmPGkYvULE/Saajwn
	 4L8b+xUi1iA1yMaNiTDtu9+uFNoHGgzc0LVuh64jopf0C2yuS24vQyukQmEnrZg/u0
	 5cy+8VLv/aO0IzmsmL4C141uLR2K3H5uVNASrJHaXv2JSrqQ08pMXZON8Ju9mOvsPL
	 2b8T12/pKSHcTfpo/eNb1FSkwPkZlN7X7b0CqoaVa/aS9uwhhGvyLxcP7lVCfuw9Pb
	 r43SRybI7JYhGRF5uzTayiRyQI3bQnSU7E6TFKWFLqHskBBhUJY0EVcHw0tVAbsyJK
	 q+PoZ69/p8xuw==
Message-ID: <4f4ee5fd-b518-4f3e-85f7-45c72a3b9927@kernel.org>
Date: Mon, 3 Mar 2025 11:39:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 01/11] mptcp: pm: define struct mptcp_pm_ops
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
 <993dd206cd1b29d4347514e3590bba675927f29a.1740975633.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <993dd206cd1b29d4347514e3590bba675927f29a.1740975633.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2025 05:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In order to allow users to develop their own BPF-based path manager,
> this patch defines a struct ops "mptcp_pm_ops" for a userspace path
> manager, which contains a set of interfaces.
> 
> Add a set of functions to register, unregister, find and validate a
> given struct ops.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  include/net/mptcp.h  | 17 ++++++++++++++
>  net/mptcp/pm.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.h |  5 ++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 72d6e6597add..53e67b90c37a 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -14,6 +14,7 @@
>  
>  struct mptcp_info;
>  struct mptcp_sock;
> +struct mptcp_pm_addr_entry;
>  struct seq_file;
>  
>  /* MPTCP sk_buff extension data */
> @@ -121,6 +122,22 @@ struct mptcp_sched_ops {
>  	void (*release)(struct mptcp_sock *msk);
>  } ____cacheline_aligned_in_smp;
>  
> +#define MPTCP_PM_NAME_MAX	16
> +
> +struct mptcp_pm_ops {
> +	int (*get_local_id)(struct mptcp_sock *msk,
> +			    struct mptcp_pm_addr_entry *skc);
> +	bool (*get_priority)(struct mptcp_sock *msk,
> +			     struct mptcp_addr_info *skc);

Detail, if you have something else to change in this series: it is
strange to see only two of them defined. I would expect all of them. Or,
probably better, nothing now, and only add them when being used to show
to the reviewers/devs how they are being used and where, no?

By doing that, it will also be clearer to understand which ops are
mandatory when we will see the modification of mptcp_pm_validate().

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

