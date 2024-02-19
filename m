Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694252D05D
	for <mptcp@lists.linux.dev>; Mon, 19 Feb 2024 12:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345326; cv=none; b=nUGqCz3KQWC1T1eXsm9Y9QwrgM5wsXLdQ9lDOB2jRjvlS/H6cl1I7NX9adj9fhx9ylsL/0lmI8uIQj8GnS09yhaCIoLn8DMGF4GcXOG05eSLA57q2yJ/UlLHeUeHUF3Mm/zIDBrMmn3SIP8PVhMZkL4XIqS8OU8KQMtDtzAeAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345326; c=relaxed/simple;
	bh=fompOvObmJq++IVzchoWK+Pa5fMupJvbE71lzv7PD8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxbuoEuUYR+P8dgpZL/La5mXoR3PWqdotQ7EK6b1M2D0Qk8bX7sy8Oee3ZX06L//RoJPa1Lgj7MSifhyz2yzfKiDbuq7VqizgzW3zre2wApUy0E80XsLUCg7o4pccYVskk23iZFzZTF2PVQqiXWQS6Ag+AVlXFPJbl+55ZzPO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv9HevHJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv9HevHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39688C433F1;
	Mon, 19 Feb 2024 12:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708345326;
	bh=fompOvObmJq++IVzchoWK+Pa5fMupJvbE71lzv7PD8M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dv9HevHJuMXfGdCudDpcONZ55spittXYL8o2JgoIbqvulUa/DOA1+Cc3VsSbrZXFD
	 JS2mURs0Kae4KRH/1sHDt41iAD4jIT8ydTIDbksKNbRx/zFXJTpjoAWiHtGSQaQsTo
	 Fo679Jov02NuE36wu1bEVgDS7YfszOujQenAgePQrFAStjMerHVnzSGSnQMzcRTct+
	 AYQRK29384KIHfylV+38ZudrW25c5ss8QzaiibFUIr9hapwOuM9Wn0eWjEKseXskMB
	 ENY2rlZKdtbgIu/3TjR+ab6A+Y1DexQwuoIx4T6aRyf0yqc8wvKHLqFpmKVis92AbM
	 gaoE8fbR3gA2w==
Message-ID: <418ca759-ba64-4bda-ac92-d57a674db203@kernel.org>
Date: Mon, 19 Feb 2024 13:22:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 5/5] selftests: mptcp: add mptcp_lib_evts_*
 helpers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708334850.git.tanggeliang@kylinos.cn>
 <1fbd9490d9c18f54b0685eb07da910749e43a0d5.1708334850.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <1fbd9490d9c18f54b0685eb07da910749e43a0d5.1708334850.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/02/2024 10:29, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To avoid duplicated code in different MPTCP selftests, we can add and
> use helpers defined in mptcp_lib.sh.
> 
> This patch unifies "pm_nl_ctl events" related code in userspace_pm.sh
> and mptcp_join.sh into four helpers: mptcp_lib_evts_init(), _start(),
> _kill() and _remove(). Define them in mptcp_lib.sh and use these new
> helpers in both scripts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 62 +++++++-----------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 63 +++++++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 31 ++-------
>  3 files changed, 92 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f75d22dbb28d..d4798495a17d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -33,10 +33,6 @@ ip_mptcp=0
>  check_invert=0
>  validate_checksum=false
>  init=0
> -evts_ns1=""
> -evts_ns2=""
> -evts_ns1_pid=0
> -evts_ns2_pid=0
>  last_test_failed=0
>  last_test_skipped=0
>  last_test_ignored=1
> @@ -148,8 +144,7 @@ init() {
>  	cin=$(mktemp)
>  	cinsent=$(mktemp)
>  	cout=$(mktemp)
> -	evts_ns1=$(mktemp)
> -	evts_ns2=$(mktemp)
> +	mptcp_lib_evts_init
>  
>  	trap cleanup EXIT
>  
> @@ -162,7 +157,7 @@ cleanup()
>  	rm -f "$cin" "$cout" "$sinfail"
>  	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
>  	rm -f "$tmpfile"
> -	rm -rf $evts_ns1 $evts_ns2
> +	mptcp_lib_evts_remove
>  	mptcp_lib_cleanup
>  	cleanup_partial
>  }

Same here, I think it is best to keep these global variables declared
here and pass their names to mptcp_lib_(...) functions.

By doing that, you can keep a different name in mptcp_join.sh and
userspace_pm.sh, and reduce the modifications here below.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
