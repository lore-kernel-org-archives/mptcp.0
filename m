Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95C134744
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038111; cv=none; b=GQ5+YSCsILBJ3jCFh7kDVY0rDUHCsX4ldc1dtLfGlXU/CmoTIoOXGdc1xK6mMOaihNuUtY6njD6m/U79/UKXsnT+Cjmn37rNTaBiueNIC+0HeQyxuzsI/wCA/d20Ndd61ocu0biyjwI7yTjVmAdgaovqWDcxUmJqqk4o0rOvXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038111; c=relaxed/simple;
	bh=GSCIPsDo7OozKk8b2ITPc+iPL8xaUBDv80F8qfFZU/g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hNN/U77OZlt5yYze9a+sCmfaDEyY9N5C+nR5bTDSttnl9NFVuS6eoc+gVmR35IcfNEX9WtNvLqQFrlWqNbgI+CNzzo41+ckGX5ySRJRq1t56wLD+tMK8hK6CwA9BEZrkN4y5QaNH9A/tohtrxc3rbyfaQJdRUtmJGi+dnUWdwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xqb3S8fI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xqb3S8fI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E16C433C7;
	Thu, 15 Feb 2024 23:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708038111;
	bh=GSCIPsDo7OozKk8b2ITPc+iPL8xaUBDv80F8qfFZU/g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Xqb3S8fIxiPcnAB3s//nBpE36MyU2kE7DTQ98xxpP/vOW7vy2vIPjCEgv5e/1yur7
	 I3FKfKf0q9LANMpVIJ/LeR4sGFq09WgtTAxTqPsGOkN0hn2zEwKEJc4sLwmzxlKXIp
	 zNtraCZIcB3+mqhvufZnm/5124WEv71RJOWueS8/Uvj6CkgWX42gAO4kRvC2i8pujd
	 e1qLNaA4C6l0m5hSExhdFKC1NKQ3GQ3DJHCFdDC2vyzqnUhHXYax0X711Jr196XA+m
	 BktTodSUtrLC/uKlsVFpdi02ug/FptYQolHl8VU+uL8KQFNQaK38pvMp3kYe9555RT
	 WZM7jUZggaQfw==
Date: Thu, 15 Feb 2024 15:01:50 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 0/3] mptcp: check the protocol with
 DEBUG_NET
In-Reply-To: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
Message-ID: <fc259bf3-2ebd-120d-fed3-8c5b35ad2e54@kernel.org>
References: <20240215-mptcp-check-protocol-v4-0-16e932665e21@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 15 Feb 2024, Matthieu Baerts (NGI0) wrote:

> Recently, Paolo fixed a bug where a TCP-specific helper was used with an
> MPTCP socket [1]. The bug was not detected by fuzzer or static analysis.
>
> Following this, it has been suggested to add a check, only in debug
> mode. This is what this series is doing.
>
> The series has been split to be upstreamed: a preparation patch for
> MPTCP, the modification for TCP, then for MPTCP. It is not clear if it
> would be OK to add that upstream. If not, we can squash these three
> patches in "DO-NOT-MERGE: mptcp: improve code coverage for CI" commit we
> have in our export tree.
>
> Note that the MPTCP Token kUnit test needs to be adapted for this new
> check. This is what is done in patch 1/3.
>
> Link: https://lore.kernel.org/mptcp/35875ef9cb7194563b580e14c71cc8cb065f846c.1706043786.git.pabeni@redhat.com/ [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v4:
> - Patch 2 and 3 have been modified, please the changelog on each patch
> - Link to v3: https://lore.kernel.org/r/20240207-mptcp-check-protocol-v3-0-77c69c596f55@kernel.org

Thanks Matthieu, v4 LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>

>
> Changes in v3:
> - Patch 2 and 3 have been modified, please the changelog on each patch
> - Link to v2: https://lore.kernel.org/r/20240201-mptcp-check-protocol-v2-0-1e253ef51990@kernel.org
>
> Changes in v2:
> - Patch 2 and 3 have been modified, please the changelog on each patch
> - Link to v1: https://lore.kernel.org/r/20240131-mptcp-check-protocol-v1-0-a06067f0bd08@kernel.org
>
> ---
> Matthieu Baerts (NGI0) (3):
>      mptcp: token kunit: set protocol
>      mptcp: check the protocol in tcp_sk() with DEBUG_NET
>      mptcp: check the protocol in mptcp_sk() with DEBUG_NET
>
> net/mptcp/protocol.h   | 16 ++++++++++++++++
> net/mptcp/token_test.c |  7 ++++++-
> 2 files changed, 22 insertions(+), 1 deletion(-)
> ---
> base-commit: 52e05de42e1094a943053af93ea08c51a44091f7
> change-id: 20240131-mptcp-check-protocol-e32e53d04a75
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
