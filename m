Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351F1DFE4
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978241; cv=none; b=sBsG7GPqOCBeUf6XBGYfcNw4ac0OqyIWKctXvDJAOhOuarNpjD+nBet4YCUiTMHsP/Sn6YJbHBf6iV/HuhHxXVXuu0/luVHh/dcpoWv5Rfgqu9nu4vRCirSvmcvi4mcwTug0gZ/+ekWf6DuGhC7bAA0DffqlAKdqYwojFw0kcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978241; c=relaxed/simple;
	bh=+ZwKQnPGbTdQjFJ3p5GmvUZhEaozlen1QW5UlRoAfK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dcc872/LSdnVImfrfY35DK+e/hOIWcJMOEXlFTgfBKVjP0kcvetRd98BXfTW4woJ/2YA91V8b2HgerPAuRnWwJbZMfIQUAUJuJoijVv0TmJrP87xgxOxPfL6ujGCQFXZZuxXz2UpwD0JqjTd96AVpIZMmu2npT8C+CzQdqgPw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvJuZd/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvJuZd/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE5BC2BD10;
	Fri, 17 May 2024 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715978240;
	bh=+ZwKQnPGbTdQjFJ3p5GmvUZhEaozlen1QW5UlRoAfK8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=UvJuZd/tJ25J3AKO+6z9Oh6lALb/UINZcfUJWCgtRxdN4LdJ7m1bex1SWvJnWN/Fo
	 fyALo0Jgkz0qis2dHgZssJROpPgk60P0sB8/gluz/AcDWhiQoUXKXC2z048V8SLU00
	 BYWmf/bvnAF4ceY9LlGngrRHzbXvIq0RIGYVVHCR+lk4nRDgdCvJpo4PUZpy5ca+iZ
	 z6c3iWoUTr9FlcgXvhsBPEUNEORb/ycFWmayCq0Istbu7uQdFx/n+SMQSgFnlwZ6gY
	 gsdkaB9XB5gNe74A9xq2NU9EfMF0w9M6d/FNcxR5nyeGROwMP2hWZ0Qw93yRiy1sYX
	 NSBKPUtAzYv4Q==
Date: Fri, 17 May 2024 13:37:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/3] doc: mptcp: alphabetical order
In-Reply-To: <20240517-mptcp-doc-v1-2-fc1ef063584e@kernel.org>
Message-ID: <663611b7-0597-d3d8-3f95-e52748dbaba8@kernel.org>
References: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org> <20240517-mptcp-doc-v1-2-fc1ef063584e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 May 2024, Matthieu Baerts (NGI0) wrote:

> Similar to what is done in other 'sysctl' pages.
>
> Also, by not putting new entries at the end, this can help to reduce
> conflicts in case of backports.
>

Putting these in order makes sense to me from a readability perspective. 
This does replace one backporting problem with another, but we don't 
change the information here too often.

Reviewed-by: Mat Martineau <martineau@kernel.org>


> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Documentation/networking/mptcp-sysctl.rst | 78 +++++++++++++++----------------
> 1 file changed, 39 insertions(+), 39 deletions(-)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 102a45e7bfa8..fd514bba8c43 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -7,14 +7,6 @@ MPTCP Sysfs variables
> /proc/sys/net/mptcp/* Variables
> ===============================
>
> -enabled - BOOLEAN
> -	Control whether MPTCP sockets can be created.
> -
> -	MPTCP sockets can be created if the value is 1. This is a
> -	per-namespace sysctl.
> -
> -	Default: 1 (enabled)
> -
> add_addr_timeout - INTEGER (seconds)
> 	Set the timeout after which an ADD_ADDR control message will be
> 	resent to an MPTCP peer that has not acknowledged a previous
> @@ -25,25 +17,6 @@ add_addr_timeout - INTEGER (seconds)
>
> 	Default: 120
>
> -close_timeout - INTEGER (seconds)
> -	Set the make-after-break timeout: in absence of any close or
> -	shutdown syscall, MPTCP sockets will maintain the status
> -	unchanged for such time, after the last subflow removal, before
> -	moving to TCP_CLOSE.
> -
> -	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
> -	sysctl.
> -
> -	Default: 60
> -
> -checksum_enabled - BOOLEAN
> -	Control whether DSS checksum can be enabled.
> -
> -	DSS checksum can be enabled if the value is nonzero. This is a
> -	per-namespace sysctl.
> -
> -	Default: 0
> -
> allow_join_initial_addr_port - BOOLEAN
> 	Allow peers to send join requests to the IP address and port number used
> 	by the initial subflow if the value is 1. This controls a flag that is
> @@ -57,6 +30,37 @@ allow_join_initial_addr_port - BOOLEAN
>
> 	Default: 1
>
> +available_schedulers - STRING
> +	Shows the available schedulers choices that are registered. More packet
> +	schedulers may be available, but not loaded.
> +
> +checksum_enabled - BOOLEAN
> +	Control whether DSS checksum can be enabled.
> +
> +	DSS checksum can be enabled if the value is nonzero. This is a
> +	per-namespace sysctl.
> +
> +	Default: 0
> +
> +close_timeout - INTEGER (seconds)
> +	Set the make-after-break timeout: in absence of any close or
> +	shutdown syscall, MPTCP sockets will maintain the status
> +	unchanged for such time, after the last subflow removal, before
> +	moving to TCP_CLOSE.
> +
> +	The default value matches TCP_TIMEWAIT_LEN. This is a per-namespace
> +	sysctl.
> +
> +	Default: 60
> +
> +enabled - BOOLEAN
> +	Control whether MPTCP sockets can be created.
> +
> +	MPTCP sockets can be created if the value is 1. This is a
> +	per-namespace sysctl.
> +
> +	Default: 1 (enabled)
> +
> pm_type - INTEGER
> 	Set the default path manager type to use for each new MPTCP
> 	socket. In-kernel path management will control subflow
> @@ -74,6 +78,14 @@ pm_type - INTEGER
>
> 	Default: 0
>
> +scheduler - STRING
> +	Select the scheduler of your choice.
> +
> +	Support for selection of different schedulers. This is a per-namespace
> +	sysctl.
> +
> +	Default: "default"
> +
> stale_loss_cnt - INTEGER
> 	The number of MPTCP-level retransmission intervals with no traffic and
> 	pending outstanding data on a given subflow required to declare it stale.
> @@ -85,15 +97,3 @@ stale_loss_cnt - INTEGER
> 	This is a per-namespace sysctl.
>
> 	Default: 4
> -
> -scheduler - STRING
> -	Select the scheduler of your choice.
> -
> -	Support for selection of different schedulers. This is a per-namespace
> -	sysctl.
> -
> -	Default: "default"
> -
> -available_schedulers - STRING
> -	Shows the available schedulers choices that are registered. More packet
> -	schedulers may be available, but not loaded.
>
> -- 
> 2.43.0
>
>
>
