Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305BD1DE3D2
	for <mptcp@lists.linux.dev>; Mon, 10 Mar 2025 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649138; cv=none; b=djMhznlM4uW7E21OZ+tnI0F/JJhEUQReZro0YOSpDWRBZlsLTF7AvkPk2mzouy28w5lDZqK0Q6dqQ2baiXljTycOyBaGpBJ5f0wLupx4mPMLDXsKvU7XcJZTd70xspTvdYOUq8zB2COA2Yy7ihE1xoKrKYGur5V1os7WsoG4frw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649138; c=relaxed/simple;
	bh=PdzR6m9E86VaukG7TYVHZevgHUQNuuyWEwan5WHYxTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNBt3zCVUZn1y34LPTaXTOEJXcTxZPmGyOGO+o0jTQxc8n0rpUMLEPuq8ShHW3FYVjFNZ0SyKxlIWL6ofhtDJdScmQN0I0SsdaxxqAtFUThbupyeQUn8Ema6TlXuL517eArH67VQtb/jxGn8dlqPsULmXPVkquscPM0XD9kjW1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJFfHZoo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJFfHZoo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB928C4CEEE;
	Mon, 10 Mar 2025 23:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741649137;
	bh=PdzR6m9E86VaukG7TYVHZevgHUQNuuyWEwan5WHYxTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kJFfHZoodOThak/qfUNaRUm6F6IlZvX4yNik2/NXU81O56iTiPbRKzU/gsvjvKlRT
	 xerFOx1Z3yPnSf9/2HCNzDW6t8NLPz3jtZbRibgEZmCe4sptA5IHYupogxg/UVHYxO
	 XFyoFW08XkHl151F1fR0iRGsZtzlhvddOyK7ANBx5xlAMyd3h5QfxmegncZRm8bN/u
	 YMGzb7YmleFSv1bKGXqEqj2DMkSg/m+mroVXRKaJgpOAeiLw1IDTiljgucZZ6f+Mgg
	 xjT7upzyl2v6/Hui4W0PeaEotE+FV4of4F20ZvHJIUsdYRz5U5+fnIb+hG12I++Udv
	 NkwszxKUE1Xcw==
Message-ID: <6935189a-0afa-4d55-a210-dc67370c32ea@kernel.org>
Date: Tue, 11 Mar 2025 00:25:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v10 12/12] selftests: mptcp: add path_manager
 sysctl tests
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
 <d011c0b9ad15e4bc293fcb46b5864515b8239553.1741258415.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d011c0b9ad15e4bc293fcb46b5864515b8239553.1741258415.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 06/03/2025 12:01, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch checks if the newly added net.mptcp.path_manager is mapped
> successfully from or to the old net.mptcp.pm_type. And add a new helper
> set_path_manager() to set the newly added net.mptcp.path_manager.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> 
> fix

(typo)

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../selftests/net/mptcp/userspace_pm.sh       | 58 ++++++++++++++++++-
>  1 file changed, 55 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 3651f73451cf..35ba4edc0fa2 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -118,9 +118,61 @@ trap cleanup EXIT
>  
>  # Create and configure network namespaces for testing

I see that you didn't move the "print_title" and "print_test" here. I
think you should do that to be able to print test_fail properly, no?

>  mptcp_lib_ns_init ns1 ns2
> -for i in "$ns1" "$ns2" ;do
> -	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
> -done
> +
> +set_path_manager()
> +{
> +	local ns=$1
> +	local pm=$2
> +
> +	if ! ip netns exec ${ns} sysctl net.mptcp.available_path_managers |
> +	     grep -wq "${pm}"; then
> +		test_fail "path manager ${pm} not found"
> +		return 1
> +	fi
> +	ip netns exec ${ns} sysctl -q net.mptcp.path_manager="${pm}"
> +}
> +

Maybe add a comment here to explain what's the goal, e.g.

  # check path_manager and pm_type sysctl mapping

> +if [ -f /proc/sys/net/mptcp/path_manager ]; then
> +	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
> +	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
> +	if [ "${pm_name}" != "kernel" ]; then
> +		test_fail "unexpected pm_name: ${pm_name}"
> +		mptcp_lib_result_print_all_tap
> +		exit ${KSFT_FAIL}
> +	fi
I don't think this step should be moved below, because here we don't
change values: pm_type=0 is the default value.

> +	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=1
> +	pm_name="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
> +	if [ "${pm_name}" != "userspace" ]; then
> +		test_fail "unexpected pm_name: ${pm_name}"
> +		mptcp_lib_result_print_all_tap
> +		exit ${KSFT_FAIL}
> +	fi

I don't think you need this step if you keep the for-loop out of the
'else', like before, see below. It implicitly check that setting pm_type
to 1 also changes "path_manager", otherwise the rest of the tests will fail.

> +
> +	set_path_manager "$ns1" "kernel"
> +	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
> +	if [ "${pm_type}" != "0" ]; then
> +		test_fail "unexpected pm_type: ${pm_type}"
> +		mptcp_lib_result_print_all_tap
> +		exit ${KSFT_FAIL}
> +	fi
> +
> +	set_path_manager "$ns1" "userspace"
> +	pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
> +	if [ "${pm_type}" != "1" ]; then
> +		test_fail "unexpected pm_type: ${pm_type}"
> +		mptcp_lib_result_print_all_tap
> +		exit ${KSFT_FAIL}
> +	fi
> +
> +	set_path_manager "$ns2" "userspace"
> +	print_test "check path_manager and pm_type sysctl mapping"
> +	test_pass
> +else
> +	for i in "$ns1" "$ns2"; do
> +		ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
> +	done
> +fi

I do think there is no need to do repeating tests here, Just having
these 3 steps are enough to cover all cases directly and indirectly,
easier to maintain without the repeat, and only focus on the mapping
aspect, not on the final values we set (so keeping the 'pm_type=1' at
the end for all kernel versions is easier).

In other words:

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

  for i in "$ns1" "$ns2"; do
      ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
  done

  (...)

Small and enough, no?

(If you want, you can also add an extra test setting "path_manager" to
"error", and checking that "pm_type" is unchanged, e.g. place this in
the middle of the two.)

      ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=error
2>/dev/null
      pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
      if [ "${pm_type}" != "1" ]; then
          test_fail "unexpected pm_type after error: ${pm_type}"
          mptcp_lib_result_print_all_tap
          exit ${KSFT_FAIL}
      fi

And no need to have the same tests on ns2. Easier to keep the for-loop
setting pm_type=1 like before.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

