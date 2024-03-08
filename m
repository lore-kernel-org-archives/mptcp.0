Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06518C3B
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 13:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904435; cv=none; b=qPH9BGB+8fuV69XKPK7YaB0J5SA0ODuCghB1zv9umFRmm+E9SUpRLIl4jHX/6G+LxVNxUuHfOqkwruYm+l005ejyWz2jW8Oew8qrp7R0oZiBI8xwkOP7AyDf7Ci4jRts8BiEm3IYrha6xQbPOehs8+p9jBzFZ7an8WfAzIrVf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904435; c=relaxed/simple;
	bh=eHjvJwOchMGgKw6VjTW/icyHHgQWqHm2PivtZOj8QF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7zGhA1Qr/4nLYsLwdOP5JEaawnTW8jVzLB99d/O64uYwRrw0L0ldUzZ2o0YYNTPPdroyHhZ8ubfIcmg04YBX+mNQ0Uc7dlmgoi5an6v3LOzDR/M0jQFRlw9TC/3Y+uclgY1qj5kIeHrxxNRNkjmCIo1DzGpetC5aSiD8hj6IwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctw8Np76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctw8Np76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55677C433C7;
	Fri,  8 Mar 2024 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709904435;
	bh=eHjvJwOchMGgKw6VjTW/icyHHgQWqHm2PivtZOj8QF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ctw8Np76oRvY2TT7RL+7mJ8MVKsGat2gDNh1Qz0YIUo41huv+99OuJO7gi8hqxmXx
	 iBieGpeKkHCMZIpchBEVk3g5nAFI9vM1arghGrGyZxahMG4MzaTJtsaa6Xd8rUgL/m
	 a1y/7nZz0A+3RICa7Z7MVtHgTF/lh1iku7h/HwuvtS7PXvV6h2WU/bToYRwWr19KPu
	 onZoLjPeG2VOcgNPDXPQmFycY0S0IqtIaTeXc9xKrTqMxE/82YTszi9OrM59IP/Wpx
	 3vQsAWD/DUfD4Ob2Lg5mheSykW9Fm3PITjfJKSj23sZpP3iqluPIz8Gu/ZG7WkOgdf
	 kak/8iSx1CqeQ==
Date: Fri, 8 Mar 2024 21:27:10 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 0/7] add helpers and vars in mptcp_lib.sh,
 part 4
Message-ID: <ZesSLljdEO9xou4X@t480>
References: <cover.1709876991.git.tanggeliang@kylinos.cn>
 <32a33aa4-84a8-4615-82d4-b8ea0a685492@kernel.org>
 <b20180d5-18e8-46a0-a493-71abfac1bc66@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b20180d5-18e8-46a0-a493-71abfac1bc66@kernel.org>

Hi Matt,

On Fri, Mar 08, 2024 at 01:11:43PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 08/03/2024 11:35, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 08/03/2024 06:57, Geliang Tang wrote:
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> v2:
> >>  - add new patches #1 & #3
> >>  - #2 drop the tab in
> >> "\tExpected value for '${var}': '${!exp}', got '${!var}'.", this breaks
> >> the alignments.
> >>  - drop 'rc' in patch #2 & #4
> >>  - use declare in #5
> >>  - drop 
> >> extra_srv_args+=" $extra_args"
> >> extra_cl_args+=" $extra_args"
> >>    in #7
> > 
> > Thank you for the new version!
> > 
> > Did you check that after your modifications errors are still caught as
> > before, and presented correctly? (the CI didn't get any error)
> 

Yes, I checked the error logs, they are fine as before.

Old userspace_pm log:

34 MP_PRIO TX                                                          [ OK ]
35 MP_PRIO RX                                                          [ OK ]
INFO: Listener tests
36 CREATE_LISTENER 0:57916                                             [FAIL]
	Expected value for 'family': '0', got '2'.
	Expected value for 'saddr': '0', got '10.0.2.2'.
37 CLOSE_LISTENER 0:57916                                              [FAIL]
	Expected value for 'family': '0', got '2'.
	Expected value for 'saddr': '0', got '10.0.2.2'.
... ...
not ok 36 - userspace_pm: CREATE_LISTENER 0:57916
not ok 37 - userspace_pm: CLOSE_LISTENER 0:57916

New userspace_pm log:

34 MP_PRIO TX                                                          [ OK ]
35 MP_PRIO RX                                                          [ OK ]
INFO: Listener tests
36 CREATE_LISTENER 10.0.2.2:57310                                      [FAIL]
Expected value for 'family': '0', got '2'.
Expected value for 'saddr': '0', got '10.0.2.2'.
37 CLOSE_LISTENER 10.0.2.2:57310                                       [FAIL]
Expected value for 'family': '0', got '2'.
Expected value for 'saddr': '0', got '10.0.2.2'.
... ...
not ok 36 - userspace_pm: CREATE_LISTENER 10.0.2.2:57310
not ok 37 - userspace_pm: CLOSE_LISTENER 10.0.2.2:57310

Old mptcp_join.sh log:

      rm                                  [ OK ]
      rmsf                                [ OK ]
      Info: invert
      LISTENER_CREATED 0:10100            [FAIL] 15:15 0:2 0:10.0.2.1 10100:10100
Server ns stats
MPTcpExtPortAdd                 1                  0.0
MPTcpExtMPJoinPortSynAckRx      1                  0.0
MPTcpExtRmAddr                  1                  0.0
... ...
      LISTENER_CLOSED  0:10100            [FAIL] 16:16 0:2 0:10.0.2.1 10100:10100
... ...
not ok 3 - mptcp_join: remove single address with port


New mptcp_join.sh log:

      rmsf                                [ OK ]
      Info: invert
      LISTENER_CREATED 10.0.2.1:10100     [FAIL]
Expected value for 'family': '0', got '2'.
Expected value for 'saddr': '0', got '10.0.2.1'.
MPTcpExtPortAdd                 1                  0.0
MPTcpExtMPJoinPortSynAckRx      1                  0.0
MPTcpExtRmAddr                  1                  0.0
... ...
      LISTENER_CLOSED  10.0.2.1:10100     [FAIL]
Expected value for 'family': '0', got '2'.
Expected value for 'saddr': '0', got '10.0.2.1'.
... ...
not ok 3 - mptcp_join: remove single address with port

Thanks,
-Geliang

> While waiting for your reply to this question ↑, I just applied these
> patches in our tree (feat. for net-next), so I can check if we can
> already send them to netdev today or tomorrow:
> 
> New patches for t/upstream:
> - a472412db36f: selftests: mptcp: call test_fail without argument
> - b4d6c3097bd0: selftests: mptcp: extract mptcp_lib_check_expected
> - f826a35f7b2d: selftests: mptcp: print_test out of verify_listener_events
> - f469a988b798: selftests: mptcp: add mptcp_lib_verify_listener_events
> - 0f5aa3b047a7: selftests: mptcp: declare event macros in mptcp_lib
> - 31fffc8fa3b8: selftests: mptcp: use KSFT_SKIP/KSFT_PASS/KSFT_FAIL
> - 4913857b325c: selftests: mptcp: join: use += operator to append strings
> - Results: 2d8b9fa0983b..2c35e2ddd1b1 (export)
> 
> Tests are now in progress:
> 
> https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20240308T121027
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 
