Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F023A0
	for <mptcp@lists.linux.dev>; Sat, 24 Aug 2024 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460402; cv=none; b=ZtOUgSHJLqXFC+A7eE4t6fcatfb3y8x0LATpqeqsJWgX5bhSXHQqG0yJr+AV14VHC6ydbVtT9d2jSDP/Qj8wiGBNvGezWeDogQnk4lz0p2FWAIH9Ag5EX6FwQK2nH7n1NSPezml+gfhv8ekvwmyePIhnuc5OwxMTHe/PNKlRYFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460402; c=relaxed/simple;
	bh=WnSpe6VjS+2PX/zgIA/RJ/+ZGDkollvvVZFavN5uGII=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=umYETAetwWySVPs2+tf83oQfyhePg4CfJL3tW1zk8PKCUkMDF3fzfBiT1QoaF/WA+Io2MV0mUmr2aksxzbMg+9IoX3dmj6ErJbmEJzJWbWkTXs66zAuUfA5LRnTliXyRg9kHG82MHgE4ZMDhuuN1UexnA9Gts+GILWqkhl0I4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN04QNKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN04QNKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FA2C32786;
	Sat, 24 Aug 2024 00:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724460402;
	bh=WnSpe6VjS+2PX/zgIA/RJ/+ZGDkollvvVZFavN5uGII=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dN04QNKVFAWL/X0dNUkDV9T5ol8AzSfplgenVej9NdMGFJuU1OBK6qo6+lGoMqXQc
	 7fJtCFwJi7I4PtenVawIJz/R2At9jVt01NaoQS1PfR/TQkK/ui+RvHoi6ItGwlyXL8
	 TlyhJgy1sKcMzuF5poNljEsp5z3PXqe44KWpZDRiPsPQy65Su6prdA4K8n17GY418o
	 0ARm0QLdz9/12mhwJ9qDnKUw4PGN0l23Humx3eIDQgCIl8CdymFGUCrpHrx1GG8ITZ
	 qBRVpqksCff+OcYgrJ/p4oWgvXhqLpjMGSgc+mRSfopV3n21l8k4TEFJH9i+G256U7
	 kMSVwsOOv4LkQ==
Date: Fri, 23 Aug 2024 17:46:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 0/3] selftests: mptcp: add time per subtests
 in TAP output
In-Reply-To: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
Message-ID: <15747097-d702-ab6a-5973-2b93819e7d6e@kernel.org>
References: <20240821-mptcp-ksft-time-v1-0-c4ea94f41244@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 21 Aug 2024, Matthieu Baerts (NGI0) wrote:

> Patches here add 'time=<N>ms' in the diagnostic data of the TAP output,
> e.g.
>
>  ok 1 - pm_netlink: defaults addr list # time=9ms
>
> This addition is useful to quickly identify which subtests are taking a
> longer time than the others, or more than expected.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (3):
>      selftests: mptcp: lib: add time per subtests in TAP output
>      sefltests: mptcp: connect: remote time in TAP output
>      selftests: mptcp: reset the last TS before the first test
>

Matthieu -

Series LGTM, thanks!

Reviewed-by: Mat Martineau <martineau@kernel.org>
