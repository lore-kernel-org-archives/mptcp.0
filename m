Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167DF4C6D
	for <mptcp@lists.linux.dev>; Sat, 16 Mar 2024 03:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710561421; cv=none; b=Unyta4akYxnZZbLEwDTC9e7uBgHV3GnVQIs6gRo9VLe4DEUBfdgsBRR1AwurjjoxYfBxZuMU1eDrKGcKKNtnk/c+V59+hyoyW148ZPsWANViwY10cISF+t+wGt8PGvFcUmPmu3si9WT9h+JA06keLCfI9N3FFhL8dodYz7171ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710561421; c=relaxed/simple;
	bh=9+t9u85JkCA6ygPOaeRZ6kPZZcKKbTQjA0YarB8j4I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9/eBp46dUs5g3HhcQ7tMDXFjnLjUb+VvXSvxFGYx5rt5nlpeU0HB0isC2zc7W2dzr3kNQ0mP/P0YfbtJt2uIkAufqYr2mljqOZFrLpLZ0xWEYonyO/f2ob2tk4iSYNUggNLwPcdJtDG2RkyGJ76/G8B7dE1558cU5TFs5SeV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR6GRoat; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR6GRoat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A19C433F1;
	Sat, 16 Mar 2024 03:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710561420;
	bh=9+t9u85JkCA6ygPOaeRZ6kPZZcKKbTQjA0YarB8j4I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QR6GRoatADcNQkkvkGLd2AwALZTJdlsT8GWvD84Jey9FoTCW+AFc27sf00y+V63m2
	 OhBKIGGS9OHOuG1ArRA7JFpsZ/vyHK3xkhleGHZfA1n84lRvP5RDm5J9n30DQGXkKZ
	 CipnKMVfvzuET9oqc8ZPPs85bUgtdYvrS3habOb3QaZ18/vdPyjMRJemlzsKRzhpvV
	 HF3d9PEY91Q2RhP4H95SOLz2LaVwt+DiRxPeTaiuU1ZPcyn94ugwuA4RwJMg0qjLF+
	 kzGscGhp5PPYCUkcXypXHqvmajD31jX2u3lz43VU67+4pxaW7MJA7gLk+KbqQnam2l
	 FkVf7dsdGoK6Q==
Date: Sat, 16 Mar 2024 11:56:55 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 00/10] add helpers and vars in mptcp_lib.sh,
 final
Message-ID: <ZfUYhzbEdk0YGOi6@t480>
References: <cover.1710121590.git.tanggeliang@kylinos.cn>
 <d4ad6607-3a57-49cd-a0d6-de7f3ceb38c9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4ad6607-3a57-49cd-a0d6-de7f3ceb38c9@kernel.org>

Hi Matt,

On Wed, Mar 13, 2024 at 07:46:41PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 11/03/2024 02:48, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This is the last part for "add helpers and vars in mptcp_lib.sh" series,
> > add endpoint operation helpers into mptcp_lib.sh.
> 
> Thank you for looking at that!
> 
> I just did a review, see my different replies.

Thanks for your review. It's very useful. I just sent a v2, addressed all
your comments.

> 
> In general, I think we should only add tests if they validate new code
> path on the kernel side, e.g. new feature. Having more tests means more
> code to maintain, a longer time to execute them, etc. Best to only add
> "valuable" ones.

I dropped them in v2.

> 
> > Geliang Tang (10):
> >   selftests: mptcp: export ip_mptcp to mptcp_lib
> >   selftests: mptcp: get support for limits
> >   selftests: mptcp: id support for show_endpoints
> >   selftests: mptcp: addr support for change_endpoint
> >   selftests: mptcp: netlink: fix positions of newline
> >   selftests: mptcp: netlink: add outputs for ip_mptcp
> >   selftests: mptcp: add endpoint_ops API helper
> >   selftests: mptcp: use mptcp_lib_endpoint_ops
> >   selftests: mptcp: add ip_mptcp option for more scripts
> 
> I hope some people are going to validate that. I don't think our CI
> should always run these tests with and without this new '-i' option.
> 
> Maybe once in a while, to validate the interface with 'ip mptcp' is
> still OK? Do you plan to do this check periodically? e.g. before a new
> version of 'iproute2'?

Sure, I can check them in the future.

Thanks,
-Geliang

> 
> 
> >   selftests: mptcp: netlink: drop disable=SC2086
> > 
> >  .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++-----
> >  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 166 ++++++++++
> >  .../selftests/net/mptcp/mptcp_sockopt.sh      |  34 ++-
> >  .../testing/selftests/net/mptcp/pm_netlink.sh | 288 +++++++++++-------
> >  .../selftests/net/mptcp/simult_flows.sh       |  14 +-
> >  5 files changed, 401 insertions(+), 209 deletions(-)
> > 
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
