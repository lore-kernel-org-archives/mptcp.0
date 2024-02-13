Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3764224D5
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838244; cv=none; b=AAwgZncLMbeuweOc9c0ARyJUzUUmHq4EsVaSXIYn6eGnTr7KFpZUuQej5r3RWa8OkMOWHHHyevI5ckcEOek0k6CDtwWn2v3AcVKfHxVNmicJbiNkFHpO1NXfUpqqpCQ5FbsM7SF5r7hMTUvGJVOtY/K0jzFxj79YhtwPAJtr1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838244; c=relaxed/simple;
	bh=8g9pVPIAzhPoGIwFXdFRmJ8DIoZog94AJyG62LDOADo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+Q6Amvu++srsHLsTq7YfH6LV9PURfC/EfdJi0B6ZtlK+ZEuqqT/AfmCS8P11jkENq9tMMtA2orNerIzgmSTiE219P5rdp320nbKDKBgxumszf5BoivSXfn98FgqQnpmUbEJLua0cmmiRLS4J5MmQYtmTf+dz0+1eXaZlr1i3YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfLeAxaz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfLeAxaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA93C433C7;
	Tue, 13 Feb 2024 15:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707838243;
	bh=8g9pVPIAzhPoGIwFXdFRmJ8DIoZog94AJyG62LDOADo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JfLeAxazQ4EMsBJRO27/kGzkhek/WaPdEiy9tN323ck46UNQuVxihIUhlteCaq1hK
	 YDhKqeefSMGskMIbgVHmjEqCEfzjVSBq0ebjqSlGbe/dgCXGYzAKj2a2zBBacaxTRb
	 PW5ZBhETNIla9NJtnj/ZnrliUZ6BXNJlw1+dZVbKqCKU9+JA/uuPsR14MeSsEBrp1C
	 jVXwGuCKo14dWV9UEO1kpQMzmDmh4Vw544GPdJRILHtjkrJj7sLpM6XbkWlEXaQIqI
	 tqFzOOucrW+etMdjQ3brAEZ64eY5kBpSFNWwMggXmPFDfSMiT+NN8reing07k8n1YX
	 lrA9mphCZMSSg==
Date: Tue, 13 Feb 2024 23:30:39 +0800
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 0/5] selftests: mptcp: unique subtest names
Message-ID: <ZcuLHz0O+kl0PZY1@t480>
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

LGTM!

Reviewed-by: Geliang Tang <geliang@kernel.org>

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
