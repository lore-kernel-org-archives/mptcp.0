Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0901E24167F
	for <mptcp@lists.linux.dev>; Wed,  5 Mar 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741175902; cv=none; b=mnGywjrGuDfoJqO4atJzIXIJDj6/xH1sPPQiQNryQVJUvCZmZGpj5oYbNA1HnnoOCpnt18jxWOK83IFej028Ajb/FyM7e9aa/63Yp58UhICkWExYIV4T6nxbcgjw75LyVEha1bGhOuUKo8nIk6CExYLTQwQUSPOhFQGgUGs1R5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741175902; c=relaxed/simple;
	bh=V1xRCrQufIgSl4D72mASAcrDnJZrdw6vDvctgiqWo8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5YiicCz0vFeEbPewpHGqKATAzvTwgmIac17dVrzs4t9uvpGGEk7XlFyQhrNRD8SML8AlEP14S0x0YuNpZPhRrOEJbj0uqoa/Vvz8Kjt1yab65iY3dtKj+DgjC0/SZrq5D/Y0mTvyQl/gK1okXb4c6H/jS5xX1C1V4OM+DIzApI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNNlX8TG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNNlX8TG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC49DC4CEE2;
	Wed,  5 Mar 2025 11:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741175901;
	bh=V1xRCrQufIgSl4D72mASAcrDnJZrdw6vDvctgiqWo8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JNNlX8TGEd3EszeBrHHsW9Yu+4aYt4TDINAha3BgJqQ3NAfsxNPbRXQnUwAsP1Yiu
	 tZFL0qcJxWeS8mCnE6khJa/IWCgsDm53umg9cmKXAYY5ea4PLx9hMLcHN7W6fzVk0o
	 1GQPZ4xxwEu2829hq/U836QhHTnRS9qlihXn848rtOoowft1Ok8G4M/ol7lgXyZhno
	 1OWyCCBoq1W7vElwHZEAXGIFgppdCycd8J8iijpb5UC7TC7hh5eZgVcl6STGHndAdi
	 kFcex+E0Ohs3OuNY4IVjYrnvKIelOmb/t1LaZR3OTtnFC32i6lAqUwXHWOFemI0WdH
	 4LHIk/o9TfBSA==
Message-ID: <5e865270-414a-48f9-962b-68afd4913998@kernel.org>
Date: Wed, 5 Mar 2025 12:58:18 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v8 11/12] selftests: mptcp: add pm_type mapping
 tests
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741088339.git.tanggeliang@kylinos.cn>
 <5af6ae4fa325ea616e4f65beba00a0a20afb60bc.1741088339.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5af6ae4fa325ea616e4f65beba00a0a20afb60bc.1741088339.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/03/2025 12:40, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a new helper set_path_manager() to set the newly added
> net.mptcp.path_manager, and test it inside a userspace pm test.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 13a3b68181ee..fa1929ca6ad4 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3572,6 +3572,21 @@ userspace_tests()
>  	if reset_with_events "userspace pm add & remove address" &&
>  	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
>  		set_userspace_pm $ns1
> +		if continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/path_manager'; then

You cannot have a "continue_if" here, that will mark the whole subtest
as skip if the condition is not met, then continue.

Why not having this in userspace_pm.sh as I suggested. It feels wrong to
have it here, in the "join" test, no?

https://lore.kernel.org/c49517d2-38e2-4848-9fb9-1c7748689cec@kernel.org

So in userspace_pm.sh, around "mptcp_lib_ns_init ns1 ns2", having
something like (not tested):

  print_title "Init"
  print_test "Created network namespaces ns1, ns2"
  mptcp_lib_ns_init ns1 ns2

  # check path_manager and pm_type sysctl mapping
  if [ -f /proc/sys/net/mptcp/path_manager ]; then
      ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=userspace
      pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
      if [ "${pm_type}" != "1" ]; then
          test_fail "unexpected pm_type: ${pm_type}"
          mptcp_lib_result_print_all_tap
          exit ${KSFT_FAIL}
      fi

      ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
      pm="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
      if [ "${pm}" != "kernel" ]; then
          test_fail "unexpected path-manager: ${pm}"
          mptcp_lib_result_print_all_tap
          exit ${KSFT_FAIL}
      fi
  fi

  for i in "$ns1" "$ns2" ;do
      ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
  done

  (...)

WDYT?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

