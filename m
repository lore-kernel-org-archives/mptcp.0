Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A850817
	for <mptcp@lists.linux.dev>; Mon, 26 Feb 2024 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708912544; cv=none; b=DEBC1rGcjWifOqaucLE/6tnLPeSOWvZP4AHc6WMQdluIBScboVLeJi9gVDZ1J6Yzrl8fu6+xmgKv4ZkQEK9dl249as6LI+Op4zRRNaPV6DjPeftyr7DJZtpysCFdST6VACK9aeJkv192cBmBnSsPFEaewp3DUBOErsSDXFjVZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708912544; c=relaxed/simple;
	bh=wAXZ4hyJemOApnCphdxxVBJAWRBn3zCVkVMrO0FK4Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJ0Nwhx5OWVk7oAaZYm8eentel0SUEZaLRJzO2zd7aqhCpfXKjbcbvHsvuJYzJiLnPyeiZ9vSxg1S2Q1v3zvx3K3wlUvqHscBwkCa5TeQWCFZPXDQq/XY09TCjk/+6PFlH0fy3B/pyPVNmBNXaaZ/GCNTpZhVlndLIpLVoYgVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4b1NiOq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4b1NiOq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E837C433F1;
	Mon, 26 Feb 2024 01:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708912544;
	bh=wAXZ4hyJemOApnCphdxxVBJAWRBn3zCVkVMrO0FK4Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4b1NiOq0deKIz+lcl+sCJRUY/vT2NaIcZLqLW9vSuQP7dsYL5ZGdYY1CtIgdEU+/
	 LR93kpNBavzko2iI78jsHFj+JYIo4jrFuvGel64YqkGnENoXYotXJB0L1TCcZZD3/l
	 892MN/fr4NFBcNDOyPAt2dm4FsFw6uFAFKmf+uzBoLekhEIyIboNlt+hnKEILgTskP
	 i1xABZ7rwFS6utw4V1f2rPcMcQ2qlqXC5UQ7Q0v3dsv5MwvZZSl+fp8TAc3Bh9y6e+
	 IBiLkbrkfpK/vXvuaMwOId9vad0sL5R8r+YhF4Ui2lGGapXdhrO8bkj/ybNWBbKsRi
	 c8YvfXMQQxiQw==
Date: Mon, 26 Feb 2024 09:55:37 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: don't exit when a symbol not
 found
Message-ID: <Zdvvme+jNATvNMkF@t480>
References: <37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn>
 <338c256c-1492-4ea8-8d3d-eca7e075b0ef@kernel.org>
 <ZdcibFuKvYXnXF5J@t480>
 <2f6096ac-568f-46a6-9938-3d57ad02536b@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f6096ac-568f-46a6-9938-3d57ad02536b@kernel.org>

Hi Matt,

On Thu, Feb 22, 2024 at 11:49:18AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/02/2024 11:31 am, Geliang Tang wrote:
> > On Thu, Feb 22, 2024 at 09:58:39AM +0100, Matthieu Baerts wrote:
> >> Hi Geliang,
> >>
> >> On 22/02/2024 8:56 am, Geliang Tang wrote:
> >>> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>>
> >>> mptcp_lib_kallsyms_has() will always exit when a symbol has not found, it
> >>> breaks the test itself. Unexpected errors occur:
> >>>
> >>>  007 userspace pm add & remove address
> >>>        syn                                 [ OK ]
> >>>        synack                              [ OK ]
> >>>        ack                                 [ OK ]
> >>>        add                                 [ OK ]
> >>>        echo                                [ OK ]
> >>>        mptcp_info subflows=2:2             [ OK ]
> >>>        mptcp_info subflows_total=3:3       [ OK ]
> >>>        mptcp_info add_addr_signal=2:2      [ OK ]
> >>>        mptcp_info last_data_sent=191:18    [ OK ]
> >>>        mptcp_info last_data_recv=40:68     [ OK ]
> >>>        mptcp_info last_ack_recv=93:74      [ OK ]
> >>>        dump addrs signal                   ERROR: missing feature: \
> >>> 			mptcp_userspace_pm_dump_addr$ symbol not found
> >>>  Cannot open network namespace "ns1-65d6fb5a-5FviVK": \
> >>> 			No such file or directory
> >>>  Cannot open network namespace "ns2-65d6fb5a-5FviVK": \
> >>> 			No such file or directory
> >>>  cmp: /tmp/tmp.a7osJs7Nj0: No such file or directory
> >>>  cmp: /tmp/tmp.f02z6brCQu: No such file or directory
> >>>  cat: /tmp/tmp.27TzxD2efV: No such file or directory
> >>> not ok 1 test: selftest_mptcp_join # FAIL
> >>>
> >>> To fix this, this patch adds a new argument 'continue' for the helper
> >>> mptcp_lib_fail_if_expected_feature() to control whether exit or not.
> >>>
> >>> Always set this argument to 1 in mptcp_lib_kallsyms_has().
> >>>
> >>> Fixes: 83013bdf90a ("selftests: mptcp: connect: skip if MPTCP is not supported")
> >>
> >> I'm not sure to understand why you sent this :)
> > 
> > Say in the test "signal addresses race test":
> > 
> >                 if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
> >                         chk_join_nr 3 3 2
> >                         chk_add_nr 4 4
> >                 else
> >                         chk_join_nr 3 3 3
> >                         # the server will not signal the address terminating
> >                         # the MPC subflow
> >                         chk_add_nr 3 3
> >                 fi
> > 
> > This code will never run to this block:
> > 
> >                         chk_join_nr 3 3 2
> >                         chk_add_nr 4 4
> > 
> > Since if no symbal of mptcp_pm_subflow_check_next, mptcp_lib_kallsyms_has exit.
> 
> This block will never be executed in our CI, because our CI always run
> the selftests linked to the same version of the kernel. In this case,
> that would not be normal to execute this block in our CI, it has to
> complain because we expect to have this symbol in the latest version.
> 
> Other CIs, like LKFT, which are validating stable kernels (e.g. 5.15.x)
> using the selftests from the last stable kernel (e.g. 6.7.x) will not
> have SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var being set to 1 as
> we did in our CI. Then it is fine, tests and checks will be skipped if
> some features are missing:
> 
> https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2cJxC6Sua3VVzRZmpQYKK2jzzNN/logs?format=html
> 
> > You can trigger this by renaming "mptcp_pm_subflow_check_next$" to
> > "no_mptcp_pm_subflow_check_next$", an non-exist function name, for test.
> 
> I confirm that if you use 'mptcp-upstream-virtme-docker', this env var
> will be set to 1 by default:
> 
>   SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1
> 
> You can unset it on your side, but it only makes sense to do that if you
> work on stable kernels (and you use selftests from a more recent
> version, not the ones attached to the kernel you are validating).
> 
> So yes, in this environment (where we force setting the env var to 1,
> not the "default" behaviour), picking a non-existing function name will
> cause the test to fail: but that's what we want → we want to be notified
> if we picked a non-existing function, like it happened recently:
> 
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/7988706773

Thanks for your explanation, it took me some time to understand it. Yes, we
can use SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES to control whether exit or
not. Let's drop this patch.

-Geliang

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
