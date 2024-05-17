Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EFC14F61
	for <mptcp@lists.linux.dev>; Fri, 17 May 2024 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715978078; cv=none; b=fgpDCiAYc5Rht39tW6EWPmnsgU9NrfPA9mmfzN/kFy9M6o5qzWyaNLLnswWWjaftXd+cOn/4cLswv/g6w5288ATgMNsU69WX7Na5c6Xg1ZEIRoYAwZLJr1dACXQJuJ7mlXtfKXyZ9rXTla4C4EFzJhxiAHsCk8RWJH/9FDNdhPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715978078; c=relaxed/simple;
	bh=RrNnFhMpbzsRwT8p+HtggpcV6CmIAosuPimeRpWt0mc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CsZ+ouIWcxeve5ZFo/rBAjL+cI6gR6UvcSNaTTZCCbRitVzy5CZTjhqPuW3DOfrPTPvxYNUigFzt2kC2qcQEdo8Q1QzB9T31bq+yGuz0wFtVpBApABdyW8uJ7ZVIXa2gSV9XS+papVklVfMKQIizuO9twd1WlksmrMvAcO8ygPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apAUB6MD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apAUB6MD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5636EC2BD10;
	Fri, 17 May 2024 20:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715978077;
	bh=RrNnFhMpbzsRwT8p+HtggpcV6CmIAosuPimeRpWt0mc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=apAUB6MDmLUVv3K4CWQ48beuvU3G40mpiv1m3LI6CpM7hIYorE5/Mv8DgwBytEbHM
	 /kclQAOLIcVU/Dx70qz34HFZ0gdlivTEyQZZmNP3Yoi7wCqOk6cgp3sd5CYToybmcW
	 l3kOXDoOucO/C2EN389a76+go7Swc4YGoHYyOfZZYXxc6/zitMkXRFgk8/qTp6TQ07
	 UvLsHnddES53NtnhGmhaTUlmWBCpSnEIkPDUGHRfKgqGlA0ZSxy7KQQF+w/mdMH9Qf
	 cKhTV8mehYmQUlTN5KkZKCUYW+8gSn9nEeVlNjkaAfgN63123TjhP7kqrZTZKRk/2d
	 8Qu7z4bDJ5V3g==
Date: Fri, 17 May 2024 13:34:36 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 1/3] doc: mptcp: add missing 'available_schedulers'
 entry
In-Reply-To: <20240517-mptcp-doc-v1-1-fc1ef063584e@kernel.org>
Message-ID: <1510608f-f306-3dfc-bb51-cf851cd3a8c2@kernel.org>
References: <20240517-mptcp-doc-v1-0-fc1ef063584e@kernel.org> <20240517-mptcp-doc-v1-1-fc1ef063584e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 17 May 2024, Matthieu Baerts (NGI0) wrote:

> This sysctl knob has been added recently, but the documentation has not
> been updated.
>
> This knob is used to show the available schedulers choices that are
> registered, similar to 'net.ipv4.tcp_available_congestion_control'.
>
> Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Documentation/networking/mptcp-sysctl.rst | 4 ++++
> 1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 69975ce25a02..102a45e7bfa8 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -93,3 +93,7 @@ scheduler - STRING
> 	sysctl.
>
> 	Default: "default"
> +
> +available_schedulers - STRING
> +	Shows the available schedulers choices that are registered. More packet
> +	schedulers may be available, but not loaded.
>
> --

Reviewed-by: Mat Martineau <martineau@kernel.org>
