Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558B26AFC
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138949; cv=none; b=jt6+2y56io2WHts5nXppK9JiKDZTJvtR+2pJKEYAyM9yEjiVzR2FyY8aRvooW8fOIwljH7E/olv6bReeYnGd35x0NZ7ul0HnjfLOvXywKmPruUac8i7m8TAav6SN2YD+7hFzuY18yfdic//w6q9KvxccbwqPcJpWryyP5XUkm9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138949; c=relaxed/simple;
	bh=Cp1Oeb65s7RVYZDfkdogBvGPOmuM76GypGsdzdNkT/U=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mr1vidFouMVSFFqrWI3BizqCxxT6+pkj7m+jwRqeX3FMlUx7tArBRbD1JyAFxDZDN+YsZVPpU6PX9EQFbh+GoEjHutQDC0C4+yziXBQLZCuECh+QpBbWc2LjJYjelbs86jWsI6LvE3Wx6KB60RrpB+pA3TmaX5UNR0odHNEfz0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYAKos77; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYAKos77"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0290CC4CEE5;
	Wed,  5 Mar 2025 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138949;
	bh=Cp1Oeb65s7RVYZDfkdogBvGPOmuM76GypGsdzdNkT/U=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=eYAKos77Vdei6ry+Zo4fDbv+Erq+63fJOAfSKFBjIIVd+DBtmiXDhsSo95Tzli+Bf
	 xwtzCYvc0MC5KVO6QtkV3lpu2yugJcAREURQLk70SJACTjWh8RUuNoDNFQS0YXLZ3f
	 O3vNVsp5bwuebXRLyldctYxx7dAhgvpZgQX80x4ykNN3UCX3Yj7nXTqQw5LvWG6qVw
	 MNNGJmuOzIORZ8wJshq4rJZRoZ2WIe10h6hUXGrzhTJJe+xNSHSjmhNvXkgr32GWtQ
	 guiO2GTYMYPhEfTsELf6o0nWbBC+uEXyR33I91gGdVWlQ5I1VSwmy1pDoGToIgGATl
	 SwgCnTwy9K8tQ==
Date: Tue, 4 Mar 2025 17:42:28 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/2] mptcp: sockopt: fix missing get options
In-Reply-To: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
Message-ID: <b0451713-3b59-f867-6cad-fde71b84b291@kernel.org>
References: <20250304-mptcp-sockopt-missing-get-v1-0-6d306d0384be@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 4 Mar 2025, Matthieu Baerts (NGI0) wrote:

> When adding a socket option support in MPTCP, both the get and set parts
> are supposed to be implemented.
>
> A few socket options had the 'set' part implemented, but not the 'get'
> part, while everything was in place to expose it, just the last step was
> missing. It looks like this was not intentional, and the 'get' support
> should have been present from the beginning, hence the 'Fixes' tags.
>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (2):
>      mptcp: sockopt: fix getting IPV6_V6ONLY
>      mptcp: sockopt: fix getting freebind & transparent
>
> net/mptcp/sockopt.c | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
> ---
> base-commit: b084c48057bbf45fbedc06d7a9d4ec417992fb1e
> change-id: 20250303-mptcp-sockopt-missing-get-356e26dc6955

Hi Matthieu -

The series looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>
