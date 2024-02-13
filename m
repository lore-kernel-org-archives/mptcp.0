Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D37EA923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707798117; cv=none; b=tGbHC9QTlSGnVvmlt5hBpkr7JotW99m5isbX8I4MiSjI2pu2toxfGUuQfJUTR7q0E63edMP85O8bBQ2SYC+k9WmcCA/Tiqwtt7aiHh2WQ+JSueIEqMufEn3FZL5uqyvrdTkcsqTLM2SIa7UX/DMEeEkZ6LlNRxo208fuZUfEfXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707798117; c=relaxed/simple;
	bh=uHDIrYxYBT/+dQUEo7Oa8+lz3izgyd7Fbgd1U51x9Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dK0S4omFyb86NnYxVb8nysuZSLbJKNVr4xqhne38/L2DDfkANXckwj67KkLbjjtddLfAobkD8J7bGiny+IUL1lC9xKit9gFj7f+ht5/WdxeOz6ep9j1izMwH6HYx4SzRpoUS69iAnutIqVXKJDtOCRjoVtZRwx8QQP/fsOWwrM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tH791/+v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tH791/+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4122C433F1;
	Tue, 13 Feb 2024 04:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707798116;
	bh=uHDIrYxYBT/+dQUEo7Oa8+lz3izgyd7Fbgd1U51x9Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tH791/+vMMiLQMy0YXHJk8Ly3Z3BDPyWLnqoh0Z+V2DIOnpk0OFQWktj5fiCsfQhs
	 Sem+9S5lKG6V6QiqOxPA24GleTK/8UZkL6xONfVahlZ9SmqL01PQ6u5uL7JmDR8TXR
	 pK829h+jqeGIHCcTiLAOq1M02GZOWPfkfqer1P+4nOvKzYjl5V98xJXH/+Uat5unQq
	 jiNscP+VptLkex/KLXCcfnxTkElt1gQhiGXQ0JMg2TNgbqlGBbv6UM9NXPH2ibYcu3
	 fY7UAk1izJnbnTNalIfVkIvMPXw3JtELXXt8kJ0K8adKHEQvPZyP0ITIrTFVnFQlxW
	 RNQqQwvZqZbMA==
Date: Tue, 13 Feb 2024 12:21:52 +0800
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/5] selftests: mptcp: unique subtest names
Message-ID: <ZcruYEtG8MjhSkJG@t480>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>

On Fri, Feb 09, 2024 at 06:28:38PM +0100, Matthieu Baerts (NGI0) wrote:
> It is important to have a unique (sub)test name in TAP, because some CI
> environments drop tests with duplicated name.
> 
> When working on adding subtests support in Netdev's NIPA CI, I found out
> some subtests had the same name. The name is used as a key, it should
> then be unique, otherwise we don't track duplicated tests.
> 
> The fixes have been split in different patches, because it fixes
> different commits. But the idea is always the same: make sure subtest
> names are unique.
> 
> The last patch is not for -net, that's a new feature to make sure we
> don't add duplicated names later.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (5):
>       selftests: mptcp: simult flows: fix some subtest names
>       selftests: mptcp: userspace_pm: unique subtest names
>       selftests: mptcp: diag: unique 'in use' subtest names
>       selftests: mptcp: diag: unique 'cestab' subtest names
>       selftests: mptcp: lib: catch duplicated subtest entries

Hi Matt,

I'd like to review this series this week. Please delegate them for
me on Patchwork. I can't delegate them by myself.

Thanks,
-Geliang

> 
>  tools/testing/selftests/net/mptcp/diag.sh         | 37 ++++++++++++++---------
>  tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 21 +++++++++++++
>  tools/testing/selftests/net/mptcp/simult_flows.sh |  3 +-
>  tools/testing/selftests/net/mptcp/userspace_pm.sh |  4 +--
>  4 files changed, 48 insertions(+), 17 deletions(-)
> ---
> base-commit: 0c8d1475f726a95cddb393e45f0b4d8ec0e15785
> change-id: 20240209-selftests-mptcp-uniq-title-2e2df0c17695
> 
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
