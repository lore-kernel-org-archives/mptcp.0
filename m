Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E882115ECEC
	for <mptcp@lists.linux.dev>; Wed, 24 Jul 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841252; cv=none; b=eh5qOc7HvSuf4LLJEDc1DEdpmblG/o5cl24K9ZIONEOyj1jZkDmzm1Keg3lZtNWUWfRHCWiLkmYZRlWZ+EeMoQ3qP9u1z8vQ4RCovG+OlZHSv6dHTCwXIHu0MZ1NqzcPwPuvVd9/8X04Dhi+51ZBQp5NbGKHHEOh70JUNqUeZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841252; c=relaxed/simple;
	bh=U0ZD7pCYFkWDBoDmTdmVjC9ccmu2Iy0GZU33AkkkLwc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MrrOXgYkLnu42lHgLrkNmFONf6JyQpu9A1xOOYAIBrS3C6LLmAFt/du88HLzdPGMRUWB9qXQw07zfZtjMYu9g9DVDeGVqbvkTz79Ipj+RJ7aZ5lGKRZE/JVTsFittjjfBZLIfnLFLzTfYGg5oq6NJ3GGCFLf48JCyx6tsA1JZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCEpJ2Sn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCEpJ2Sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A2FC32781;
	Wed, 24 Jul 2024 17:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721841251;
	bh=U0ZD7pCYFkWDBoDmTdmVjC9ccmu2Iy0GZU33AkkkLwc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nCEpJ2SnxrVj6uNYxCbrCf2bRYMlLtJYoGzDtn2vj4JBDwo3XSoEkED4q75o3U4XR
	 AW+vEqCIvdGjiYwjqUID5Q1D3AbT6686SQV0BDugm2nvu3s5pXDetx69Wfps+zz5hJ
	 95Z6E4kJSsv4isUns/Y+DkIy2CyIl62tQtkP2lpfkhrvtVGY7WkdLup79kmYI6Q7Q3
	 Syd0tSsyURHk0CG8Q6AvYY23TOgRt+18kAoCVoQnhy/I0J9OBUpvsKW4IjmayEQH7U
	 AbF/bX6eFh2diNS9vVOCFkVcJ6+Y9gpKBtVT1p9+M64dq4VbEN8/KH4npGhKvxYkh/
	 DHyysUlfubJJA==
Date: Wed, 24 Jul 2024 10:14:10 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v4 11/23] selftests: mptcp: join: check re-using
 ID of closed subflow
In-Reply-To: <20240722-mptcp-pm-avail-v4-11-15bfd73de384@kernel.org>
Message-ID: <1b2a66e3-424e-6ec8-3411-d7ef7b1f7fa0@kernel.org>
References: <20240722-mptcp-pm-avail-v4-0-15bfd73de384@kernel.org> <20240722-mptcp-pm-avail-v4-11-15bfd73de384@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 22 Jul 2024, Matthieu Baerts (NGI0) wrote:

> This test extends "delete and re-add" to validate the previous commit. A
> new 'subflow' endpoint is added, but the subflow request will be
> rejected. The result is that no subflow will be established from this
> address.
>
> Later, the endpoint is removed and re-added after having cleared the
> firewall rule. Before the previous commit, the client would not have
> been able to create this new subflow.
>
> While at it, extra checks have been added to validate the expected
> numbers of MPJ and RM_ADDR.
>
> The 'Fixes' tag here below is the same as the one from the previous
> commit: this patch here is not fixing anything wrong in the selftests,
> but it validates the previous fix for an issue introduced by this commit
> ID.
>
> Fixes: b6c08380860b ("mptcp: remove addr and subflow in PM netlink")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 27 ++++++++++++++++++++-----
> 1 file changed, 22 insertions(+), 5 deletions(-)

As we discussed in the meeting today, for patches 1-11:

Reviewed-by: Mat Martineau <martineau@kernel.org>
