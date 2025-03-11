Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A3156861
	for <mptcp@lists.linux.dev>; Tue, 11 Mar 2025 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676066; cv=none; b=sDqqmll1+hxWQFnOO8HUSZN59kIgrcIHKn2GPw9RP8qSp+7kTN2NBFFe/9oSlmVqqJu+DA7ALqy4KeJvG+nK5w0Fdk/OavHAjlxwKt0zxVZuRPCwrbSnuIPTuA023KTJPr4OoPoXTMjdYWHclXhm7dG8I5+8Djw0aOq5ni2a2nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676066; c=relaxed/simple;
	bh=V0Za8As53DBdGv9IOQ68stQed/CD/ev5PCYGlNZaAPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfJHrzFqGNFVDKJ+SlssKmRuuez3WvDOR2t2k/nhw9thVcd1zLC+3HYYgxSfD0QDx1favPBFe58IOshx3I9gwxCmVgvW89HlwGWsbjyXPsaWd9SbNP0J8b0wq8+fQytrJsxnAzyLH8tMhriWqZ0WKtHhJyYTPy68Vfn6qBvPl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZFQU++h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZFQU++h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7079CC4CEE9;
	Tue, 11 Mar 2025 06:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741676065;
	bh=V0Za8As53DBdGv9IOQ68stQed/CD/ev5PCYGlNZaAPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iZFQU++hus4r4UJaBh8yJcJTApmbtNFMvnGxnEPlsbRNwjcde0pg+viR5VMa8hfdl
	 dPt2CHe581RgGZJg/c0tw+vU4xHQx43kGPhZds5Sn3/YKmFV3XIz7lfnGzwj5Dj4/l
	 AUyTZ8p2c7CUoC9VHZf8yLf8AGofwNaBPXA50VkKuDxpAxCx9BZhBNYRxI3J6Tc4wW
	 p0pgZQvxxdEVz4eodrC233SpF7bJ/QwGXwReFzUlmftx7jMSIxtT9AI2Z77EV4DftP
	 GBHV2bAGH/skGegdrNSJm/2L9sOmZt6+jO8XnmdOQA6crj6Qzh+wni2E5TO316z7h5
	 J+n4wRMSlTWFw==
Message-ID: <29feb9623a11f6030d3d61d03a5d4150eee3cc3f.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v10 12/12] selftests: mptcp: add path_manager
 sysctl tests
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 11 Mar 2025 14:54:21 +0800
In-Reply-To: <6935189a-0afa-4d55-a210-dc67370c32ea@kernel.org>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
	 <d011c0b9ad15e4bc293fcb46b5864515b8239553.1741258415.git.tanggeliang@kylinos.cn>
	 <6935189a-0afa-4d55-a210-dc67370c32ea@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Tue, 2025-03-11 at 00:25 +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 06/03/2025 12:01, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch checks if the newly added net.mptcp.path_manager is
> > mapped
> > successfully from or to the old net.mptcp.pm_type. And add a new
> > helper
> > set_path_manager() to set the newly added net.mptcp.path_manager.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > fix
> 
> (typo)
> 
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../selftests/net/mptcp/userspace_pm.sh       | 58
> > ++++++++++++++++++-
> >  1 file changed, 55 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > index 3651f73451cf..35ba4edc0fa2 100755
> > --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> > @@ -118,9 +118,61 @@ trap cleanup EXIT
> >  
> >  # Create and configure network namespaces for testing
> 
> I see that you didn't move the "print_title" and "print_test" here. I
> think you should do that to be able to print test_fail properly, no?
> 
> >  mptcp_lib_ns_init ns1 ns2
> > -for i in "$ns1" "$ns2" ;do
> > -	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
> > -done
> > +
> > +set_path_manager()
> > +{
> > +	local ns=$1
> > +	local pm=$2
> > +
> > +	if ! ip netns exec ${ns} sysctl
> > net.mptcp.available_path_managers |
> > +	     grep -wq "${pm}"; then
> > +		test_fail "path manager ${pm} not found"
> > +		return 1
> > +	fi
> > +	ip netns exec ${ns} sysctl -q
> > net.mptcp.path_manager="${pm}"
> > +}
> > +
> 
> Maybe add a comment here to explain what's the goal, e.g.
> 
>   # check path_manager and pm_type sysctl mapping
> 
> > +if [ -f /proc/sys/net/mptcp/path_manager ]; then
> > +	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
> > +	pm_name="$(ip netns exec "$ns1" sysctl -n
> > net.mptcp.path_manager)"
> > +	if [ "${pm_name}" != "kernel" ]; then
> > +		test_fail "unexpected pm_name: ${pm_name}"
> > +		mptcp_lib_result_print_all_tap
> > +		exit ${KSFT_FAIL}
> > +	fi
> I don't think this step should be moved below, because here we don't
> change values: pm_type=0 is the default value.
> 
> > +	ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=1
> > +	pm_name="$(ip netns exec "$ns1" sysctl -n
> > net.mptcp.path_manager)"
> > +	if [ "${pm_name}" != "userspace" ]; then
> > +		test_fail "unexpected pm_name: ${pm_name}"
> > +		mptcp_lib_result_print_all_tap
> > +		exit ${KSFT_FAIL}
> > +	fi
> 
> I don't think you need this step if you keep the for-loop out of the
> 'else', like before, see below. It implicitly check that setting
> pm_type
> to 1 also changes "path_manager", otherwise the rest of the tests
> will fail.
> 
> > +
> > +	set_path_manager "$ns1" "kernel"
> > +	pm_type="$(ip netns exec "$ns1" sysctl -n
> > net.mptcp.pm_type)"
> > +	if [ "${pm_type}" != "0" ]; then
> > +		test_fail "unexpected pm_type: ${pm_type}"
> > +		mptcp_lib_result_print_all_tap
> > +		exit ${KSFT_FAIL}
> > +	fi
> > +
> > +	set_path_manager "$ns1" "userspace"
> > +	pm_type="$(ip netns exec "$ns1" sysctl -n
> > net.mptcp.pm_type)"
> > +	if [ "${pm_type}" != "1" ]; then
> > +		test_fail "unexpected pm_type: ${pm_type}"
> > +		mptcp_lib_result_print_all_tap
> > +		exit ${KSFT_FAIL}
> > +	fi
> > +
> > +	set_path_manager "$ns2" "userspace"
> > +	print_test "check path_manager and pm_type sysctl mapping"
> > +	test_pass
> > +else
> > +	for i in "$ns1" "$ns2"; do
> > +		ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
> > +	done
> > +fi
> 
> I do think there is no need to do repeating tests here, Just having
> these 3 steps are enough to cover all cases directly and indirectly,
> easier to maintain without the repeat, and only focus on the mapping
> aspect, not on the final values we set (so keeping the 'pm_type=1' at
> the end for all kernel versions is easier).
> 
> In other words:
> 
>   print_title "Init"
>   print_test "Created network namespaces ns1, ns2"
>   mptcp_lib_ns_init ns1 ns2

test_pass should be followed this print_test to print a [OK].
So this may be better:

print_title "Init"
mptcp_lib_ns_init ns1 ns2

if []; then
	test_fail "..."
fi

print_test "Created network namespaces ns1, ns2"
test_pass

So in v11, I just moved 'print_title "Init"' forward but kept
"print_test" and "test_pass" unchanged.

Thanks,
-Geliang

> 
>   # check path_manager and pm_type sysctl mapping
>   if [ -f /proc/sys/net/mptcp/path_manager ]; then
>       ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=userspace
>       pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
>       if [ "${pm_type}" != "1" ]; then
>           test_fail "unexpected pm_type: ${pm_type}"
>           mptcp_lib_result_print_all_tap
>           exit ${KSFT_FAIL}
>       fi
> 
>       ip netns exec "$ns1" sysctl -q net.mptcp.pm_type=0
>       pm="$(ip netns exec "$ns1" sysctl -n net.mptcp.path_manager)"
>       if [ "${pm}" != "kernel" ]; then
>           test_fail "unexpected path-manager: ${pm}"
>           mptcp_lib_result_print_all_tap
>           exit ${KSFT_FAIL}
>       fi
>   fi
> 
>   for i in "$ns1" "$ns2"; do
>       ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
>   done
> 
>   (...)
> 
> Small and enough, no?
> 
> (If you want, you can also add an extra test setting "path_manager"
> to
> "error", and checking that "pm_type" is unchanged, e.g. place this in
> the middle of the two.)
> 
>       ip netns exec "$ns1" sysctl -q net.mptcp.path_manager=error
> 2>/dev/null
>       pm_type="$(ip netns exec "$ns1" sysctl -n net.mptcp.pm_type)"
>       if [ "${pm_type}" != "1" ]; then
>           test_fail "unexpected pm_type after error: ${pm_type}"
>           mptcp_lib_result_print_all_tap
>           exit ${KSFT_FAIL}
>       fi
> 
> And no need to have the same tests on ns2. Easier to keep the for-
> loop
> setting pm_type=1 like before.
> 
> Cheers,
> Matt

