Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0253A923
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707798359; cv=none; b=Ct/R5zVjZlRDH0BppnxQRqSWmwaCtIR2nJgw5/y2Km8g6yFdG3SHQ63IoXEQ+cGhWAqi/D8ZnW0QofSzXIjbJWf32LkWLPC1z+NXJPzOxp3LyQoe6yi0O+NVAXW9vYAVWVkP+aHiAbq4pceYriBcTizUn3XqkJxs7P98gk+o7h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707798359; c=relaxed/simple;
	bh=DJDtEyomcZ52YPmXwZBTudTsAMP29zLQX1t/8TLkb00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxfP1wvDuC9wvfVD8r8AneJS85NNwYVdVSDbIY46o1miZ4M2ZKrfqY1aeAohXfoSxspNjP30D6Smps2jGbYiABr/tUH3IUeboej8DEJFWmHWUZLhj73Famk3XvMkTFBztYBpT8WMnqPaKdG81MOd5RoKFb+Lysa0iSJBbdoCoXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J36nRBm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J36nRBm5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE49C433C7;
	Tue, 13 Feb 2024 04:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707798359;
	bh=DJDtEyomcZ52YPmXwZBTudTsAMP29zLQX1t/8TLkb00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J36nRBm5L4c/uNHpvrN0+cCNeJkiZv0zLOnzMms4EFaCPA9DWF0p1BEdCzsk8v7/c
	 1zR+GcwDUWKYH9k0doUDZFlGGLhntXeqtf1/WS+ROAnjKRtfRZDCinVQYh8MztS2SV
	 zU0xvqfxRAGqwhsPLVrAlDHH0OTPFJsrs5fQcwp+lnMVdahEVEmR3u8ukLEdBPw1Ny
	 xXWT57Da0nXQoJZtto+CNc198weyADLzOZkMfxYostcRf4QoeiGuDhMJ9ZUqXDop9A
	 68TuxktRQ5f8YIo17nEa1gapRPKwvomJWL1SlaDhkguDdYC0uHJDu6mAW8/EabFqBd
	 zbQs6nB5LPpjA==
Date: Tue, 13 Feb 2024 12:25:54 +0800
From: Geliang Tang <geliang@kernel.org>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 00/15] add helpers and vars in mptcp_lib.sh
Message-ID: <ZcrvUkBhCbOvcfPX@t480>
References: <cover.1703158128.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1703158128.git.geliang.tang@linux.dev>

On Thu, Dec 21, 2023 at 07:31:03PM +0800, Geliang Tang wrote:
> v6:
>  - rebased with:
>  v3 fixes for CURRESTAB
>  v5 dump for userspace pm
> 
> v5:
>  - rebased with "userspace pm enhancements" v13
> 
> v4:
>  - rebased with "userspace pm enhancements" v12
> 
> v3:
>  - merge squash-to patch for v2:
>  Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
>  - add a new patch:
>  selftests: mptcp: simult flows: define missing vars
>  - update patches:
>  selftests: mptcp: export event macros in mptcp_lib
>  selftests: mptcp: export cin/cout/sin/sout vars
>  selftests: mptcp: netlink: fix positions of newline
>  - update some commit subjects and commit logs.
> 
> v2:
>  - add more patches.
> 
> Geliang Tang (15):
>   selftests: mptcp: add mptcp_lib_evts_* helpers
>   selftests: mptcp: userspace: capitalize test_name
>   selftests: mptcp: userspace: print colored output
>   selftests: mptcp: capitalize ok/fail/skip
>   selftests: mptcp: netlink: drop duplicate var ret
>   selftests: mptcp: export ret into mptcp_lib
>   selftests: mptcp: extract mptcp_lib_check_expected
>   selftests: mptcp: export event macros in mptcp_lib
>   selftests: mptcp: add mptcp_lib_verify_listener_events
>   selftests: mptcp: unify namespace names
>   selftests: mptcp: add mptcp_lib_ns_* helpers
>   selftests: mptcp: add ss mptcp support checks
>   selftests: mptcp: add mptcp_lib_check_tools helper
>   selftests: mptcp: add mptcp_lib_cleanup helper
>   selftests: mptcp: add mptcp_lib_check_output helper

New version of this series was sent out, please change them as
"Superseded" on Patchwork.

Thanks,
-Geliang

> 
>  tools/testing/selftests/net/mptcp/diag.sh     |  75 ++---
>  .../selftests/net/mptcp/mptcp_connect.sh      |  31 +-
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 204 ++++---------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 264 +++++++++++++++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      |  48 +---
>  .../testing/selftests/net/mptcp/pm_netlink.sh |  48 +---
>  .../selftests/net/mptcp/simult_flows.sh       |  30 +-
>  .../selftests/net/mptcp/userspace_pm.sh       | 270 ++++++------------
>  8 files changed, 464 insertions(+), 506 deletions(-)
> 
> -- 
> 2.35.3
