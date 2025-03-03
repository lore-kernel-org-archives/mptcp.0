Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C51E5701
	for <mptcp@lists.linux.dev>; Mon,  3 Mar 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998423; cv=none; b=CVHmG9LsJjH6rJkShpkaUHTzlpzTh49qzVlHDHsr6PC95moKrQwlUpfkP5/ror7W6rwmpTjtQk4zMXRQFcMbhmSpOsO53bTZWg9hMBIO07JWWVOh6JzbPZI5dcnd3f4TSFh2aKS6l6iGz5GwxJ8Hpzpu7HHebTPzqO0yVYIdwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998423; c=relaxed/simple;
	bh=igyZALPA/p5iXpcxSxXvplxsZZBfb9zhPiW4JE1yZA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJPa74xHqn8POtb3TXaXvZW6UFckWqUGPKoTRGXtV1bPH7lvyhWth9pCLQgG64t9NhQzYAJ0yk90ZXtt9DzrHHw5MD0b7xx6n9gdSaYE5NWz2HZ9HEjzkTkaLdvXmaXbmEHymOB/jHBUrZmaioztktJcy5kzlJzCJGLymMjfPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRqbNw2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRqbNw2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A451C4CED6;
	Mon,  3 Mar 2025 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740998422;
	bh=igyZALPA/p5iXpcxSxXvplxsZZBfb9zhPiW4JE1yZA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MRqbNw2trdXcu2SO6/OVffy1ujShbJbvZZVKhjbQvgVnbPduVHUQ93TmcsR/M5RWj
	 pqZvHIdEmgyRHSt+fxQGgW4qtcdn2toIKqhfrnKQ1EJFt9/XyYFf81u9Rdd7EMpAHc
	 8q2G/pkoDt8YhCfI1ux09g2oAvt1moNUgwYKh/P8UgRS4L0vHvTdFlEIC1CP/R2H53
	 aoG8cyTvXxjb7t0wEOUFF7DP13FXuawrfOXYcYozkKnZvdlUc4hgJxaeMuecH4ZqZU
	 MOe3qiYSfYKmw+yHSQC7WpvorfbnuXHv1Kcx1IUsUhlDq0QJD7oRIcphsbZI/DBZWH
	 toPC5qpo5NfxA==
Message-ID: <f562ed84-487c-4b4d-9f34-55ab7e6e0c4b@kernel.org>
Date: Mon, 3 Mar 2025 11:40:20 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v7 02/11] mptcp: sysctl: new sysctl to set path
 manager by name
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740975633.git.tanggeliang@kylinos.cn>
 <6a04af1ad584b4e067b61ca4c7717f7d72c03202.1740975633.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6a04af1ad584b4e067b61ca4c7717f7d72c03202.1740975633.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 03/03/2025 05:22, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> A new net.mptcp.path_manager sysctl is added to determine which path
> manager will be used by each newly-created MPTCP socket by setting the
> name of it.
> 
> This sysctl makes the old one "pm_type" deprecated.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  Documentation/networking/mptcp-sysctl.rst | 22 ++++++++++
>  net/mptcp/ctrl.c                          | 50 +++++++++++++++++++++++
>  net/mptcp/protocol.h                      |  1 +
>  3 files changed, 73 insertions(+)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 03e1d3610333..5f6c02c12f5b 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -72,6 +72,26 @@ enabled - BOOLEAN
>  
>  	Default: 1 (enabled)
>  
> +path_manager - STRING
> +	Set the default path manager name to use for each new MPTCP
> +	socket. In-kernel path management will control subflow
> +	connections and address advertisements according to
> +	per-namespace values configured over the MPTCP netlink
> +	API. Userspace path management puts per-MPTCP-connection subflow
> +	connection decisions and address advertisements under control of
> +	a privileged userspace program, at the cost of more netlink
> +	traffic to propagate all of the related events and commands.
> +	User-defined BPF-based path managers can also be set via this
> +	sysctl.

Maybe we should add the last sentence about BPF-based PMs later on, when
everything will be ready, to avoid confusions. WDTY?

Also, because there are many patches to upstream, I don't think
everything will be ready for v6.15.

> +
> +	This is a per-namespace sysctl.
> +
> +	* "kernel"          - In-kernel path manager
> +	* "userspace"       - Userspace path manager
> +	* all other strings - BPF-based path managers

Same here.

> +
> +	Default: "kernel"
> +
>  pm_type - INTEGER
>  	Set the default path manager type to use for each new MPTCP
>  	socket. In-kernel path management will control subflow
> @@ -84,6 +104,8 @@ pm_type - INTEGER
>  
>  	This is a per-namespace sysctl.
>  
> +	(Deprecated, use path_manager instead.).

Detail: I think you can remove the parenthesis.

Also, maybe we should have "Deprecated since v6.15, use (...)"? I see
other sysctl knobs have that in their description.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

