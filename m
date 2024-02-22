Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3A2B9BF
	for <mptcp@lists.linux.dev>; Thu, 22 Feb 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597876; cv=none; b=A74D5Od3iizS4cMlRIgrTFwYH/VjV6wFySrzfn9/bktQUoXGlaL1jBbPn2QT4hJ1QKy+9AtJUJKEUY5wxAiDVoFNdQ4dQOyiyh7s2Xzh/VURsZm/y4eDQ6it7C+aHNly/WZRaqDcyMMI9zWHCde12HXzqGpZ9q9W14PYBIsCKQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597876; c=relaxed/simple;
	bh=lhj6yxS6MNBMwpMr/kRAGlmlMkCFAlAHofik8zx9jq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWqvVRnCrknc81JQ7bAGHBZfLJlrQbrhzM7YzLotnXUEwh/GOpoZFcnl+Ide9JseaPYHXN5OddrZU6myZ8M8mFfJZCpwi/45Ukl6cHQJ3u8txAGl5buwOYUddHRrMW4Tdon100H7TsvjRaPh2tkVazHtmvBLxEYkrrNX7KIaa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1fhHUBl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1fhHUBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC17C433C7;
	Thu, 22 Feb 2024 10:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708597876;
	bh=lhj6yxS6MNBMwpMr/kRAGlmlMkCFAlAHofik8zx9jq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q1fhHUBlh46BvDDLzP4zGkiFfz6aHjdxBO+zNry4P45YjGnrzauY9RVL6DblM9Z6E
	 6qZCJo/z89wOS0FrupV7dfL4OTUjNv5ijfIg9Mm5XakiOpPPf2RNqWFgVytbMI2vSL
	 C41yc9IKGthtxYwTXXh0dUnKrSi1AhpHN13KAFbZLTP08NEeFwvib0GIapDuhA9gJ6
	 s1+ddxaezxvtm8NMsrUzVOgWD8a/hQgYqgfM1X2n15IpF7FjqOCjMrykFprRh47+Tr
	 aFtFQ69JoCE3DDFjxsJMeNRRoahklKwzog0QVz7gFfc7GAfURwTeH5CHM8ZLZm2cdB
	 63AtN4MM02xDA==
Date: Thu, 22 Feb 2024 18:31:08 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net] selftests: mptcp: don't exit when a symbol not
 found
Message-ID: <ZdcibFuKvYXnXF5J@t480>
References: <37d9862958848f8f3737eafd1b1ea0bdb63acd91.1708588566.git.tanggeliang@kylinos.cn>
 <338c256c-1492-4ea8-8d3d-eca7e075b0ef@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <338c256c-1492-4ea8-8d3d-eca7e075b0ef@kernel.org>

On Thu, Feb 22, 2024 at 09:58:39AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 22/02/2024 8:56 am, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > mptcp_lib_kallsyms_has() will always exit when a symbol has not found, it
> > breaks the test itself. Unexpected errors occur:
> > 
> >  007 userspace pm add & remove address
> >        syn                                 [ OK ]
> >        synack                              [ OK ]
> >        ack                                 [ OK ]
> >        add                                 [ OK ]
> >        echo                                [ OK ]
> >        mptcp_info subflows=2:2             [ OK ]
> >        mptcp_info subflows_total=3:3       [ OK ]
> >        mptcp_info add_addr_signal=2:2      [ OK ]
> >        mptcp_info last_data_sent=191:18    [ OK ]
> >        mptcp_info last_data_recv=40:68     [ OK ]
> >        mptcp_info last_ack_recv=93:74      [ OK ]
> >        dump addrs signal                   ERROR: missing feature: \
> > 			mptcp_userspace_pm_dump_addr$ symbol not found
> >  Cannot open network namespace "ns1-65d6fb5a-5FviVK": \
> > 			No such file or directory
> >  Cannot open network namespace "ns2-65d6fb5a-5FviVK": \
> > 			No such file or directory
> >  cmp: /tmp/tmp.a7osJs7Nj0: No such file or directory
> >  cmp: /tmp/tmp.f02z6brCQu: No such file or directory
> >  cat: /tmp/tmp.27TzxD2efV: No such file or directory
> > not ok 1 test: selftest_mptcp_join # FAIL
> > 
> > To fix this, this patch adds a new argument 'continue' for the helper
> > mptcp_lib_fail_if_expected_feature() to control whether exit or not.
> > 
> > Always set this argument to 1 in mptcp_lib_kallsyms_has().
> > 
> > Fixes: 83013bdf90a ("selftests: mptcp: connect: skip if MPTCP is not supported")
> 
> I'm not sure to understand why you sent this :)

Say in the test "signal addresses race test":

                if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
                        chk_join_nr 3 3 2
                        chk_add_nr 4 4
                else
                        chk_join_nr 3 3 3
                        # the server will not signal the address terminating
                        # the MPC subflow
                        chk_add_nr 3 3
                fi

This code will never run to this block:

                        chk_join_nr 3 3 2
                        chk_add_nr 4 4

Since if no symbal of mptcp_pm_subflow_check_next, mptcp_lib_kallsyms_has exit.

You can trigger this by renaming "mptcp_pm_subflow_check_next$" to
"no_mptcp_pm_subflow_check_next$", an non-exist function name, for test.

Thanks,
-Geliang

> 
> The fixes commit ('d' is missing at the beginning) here mentions:
> 
> > Note that this check can also
> > mark the test as failed if 'SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES' env
> > var is set to 1: by doing that, we can make sure a test is not being
> > skipped by mistake.
> 
> So the goal is to fail when the env var is set. Otherwise, we would miss
> tests that are skipped by accident.
> 
> If you use 'mptcp-upstream-virtme-docker' and you want to run recent
> selftests on an older kernel, you can add this to the docker command not
> to exit if a feature is missing:
> 
>   -e INPUT_SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=0
> 
> But clearly here, we don't want to continue if we expect all features to
> work!
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
