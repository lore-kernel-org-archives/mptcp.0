Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD8A56473
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832720; cv=none; b=rmcPtTd3NQ/Z/KfEmTNMzz1gAMs9HNgkqGBb2SxJaWLpZaZ/+Jj4c5AdafdEvi4m9df8p0bmbd9Wo9pBZVecD9vUEvjytaf3syO2EAnHjV+oe4Cwc1Nem+2yAGbio8XdguPiWqlTQd7KG7moFCnV7IEDYU4R71UU7GGk6Q2FktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832720; c=relaxed/simple;
	bh=2uP3Ux+nEmsLTS/t9rj7OdOLEYZMAQCV5AZEx+Q/3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssYR5ijclhPvIkJ1vZ/ZNTkoUs+hWlamgNg6rJO/S3KrG1OmMY8JWzOhSKmb7ic99xohopVNugAQxBM0nghYVkGmb4E7hl6G0BbPrzr355/DmrIOPgGohSp5Hcx7BsK+vGBXQViml09RoJAFIbJHjtSKO55Cy1F8JL2FSmzqGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCgDQsF0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCgDQsF0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D13C433C7;
	Tue, 13 Feb 2024 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707832720;
	bh=2uP3Ux+nEmsLTS/t9rj7OdOLEYZMAQCV5AZEx+Q/3TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCgDQsF0SaSRRxuLe0ZbOeCaTtZnt2RoztDqkQJec1YVMV5iareGNVN09Bc7Muh8U
	 O/vFq2yaYebmSTvNJu/eD9qqF53Eaj1vytsUvvsWfP/nEIlF1Pqd6oa7+nM8TIn2yf
	 2TxDvkXiCxiRoIQiDR9DLCs8/KZhJePbyg6yk87KlDfUhsF9iHRHWY6GDVfmQDdmS/
	 hY4246ae/Jzg/ZPrx5HJ2le5h6VHAN0mMzzbvW67ojWXKxElY0ac0uQOK4mtbvB9GF
	 BIURe20CQ9hBm/hGyuy2TXvZWuK4Y6XuDPRBMTHAkh8vaeg6kUHouKALC5G7qsuWKg
	 /+k8qeBNWHuZQ==
Date: Tue, 13 Feb 2024 21:58:36 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 00/15] add helpers and vars in mptcp_lib.sh
Message-ID: <Zct1jAaOcc8EmB1s@t480>
References: <cover.1703158128.git.geliang.tang@linux.dev>
 <ZcrvUkBhCbOvcfPX@t480>
 <8253246b-9fbd-4dd9-940f-59667905de85@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8253246b-9fbd-4dd9-940f-59667905de85@kernel.org>

Hi Matt,

On Tue, Feb 13, 2024 at 01:02:42PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 13/02/2024 05:25, Geliang Tang wrote:
> > On Thu, Dec 21, 2023 at 07:31:03PM +0800, Geliang Tang wrote:
> >> v6:
> >>  - rebased with:
> >>  v3 fixes for CURRESTAB
> >>  v5 dump for userspace pm
> >>
> >> v5:
> >>  - rebased with "userspace pm enhancements" v13
> >>
> >> v4:
> >>  - rebased with "userspace pm enhancements" v12
> >>
> >> v3:
> >>  - merge squash-to patch for v2:
> >>  Squash to "selftests: mptcp: add mptcp_lib_ns_* helpers"
> >>  - add a new patch:
> >>  selftests: mptcp: simult flows: define missing vars
> >>  - update patches:
> >>  selftests: mptcp: export event macros in mptcp_lib
> >>  selftests: mptcp: export cin/cout/sin/sout vars
> >>  selftests: mptcp: netlink: fix positions of newline
> >>  - update some commit subjects and commit logs.
> >>
> >> v2:
> >>  - add more patches.
> >>
> >> Geliang Tang (15):
> >>   selftests: mptcp: add mptcp_lib_evts_* helpers
> >>   selftests: mptcp: userspace: capitalize test_name
> >>   selftests: mptcp: userspace: print colored output
> >>   selftests: mptcp: capitalize ok/fail/skip
> >>   selftests: mptcp: netlink: drop duplicate var ret
> >>   selftests: mptcp: export ret into mptcp_lib
> >>   selftests: mptcp: extract mptcp_lib_check_expected
> >>   selftests: mptcp: export event macros in mptcp_lib
> >>   selftests: mptcp: add mptcp_lib_verify_listener_events
> >>   selftests: mptcp: unify namespace names
> >>   selftests: mptcp: add mptcp_lib_ns_* helpers
> >>   selftests: mptcp: add ss mptcp support checks
> >>   selftests: mptcp: add mptcp_lib_check_tools helper
> >>   selftests: mptcp: add mptcp_lib_cleanup helper
> >>   selftests: mptcp: add mptcp_lib_check_output helper
> > 
> > New version of this series was sent out, please change them as
> > "Superseded" on Patchwork.
> 
> Thank you for the notification!
> 
> Sorry, I'm taking a long time to do the review. But I will do it.
> Because I took so long to finish it, I can do the rebase of the other
> patches if you prefer, that's the least I can do.

Sorry, I put too many patches into one series. This makes the review
difficult. This time I'll split them into smaller series to make the
review simpler.

> 
> I marked patches 5/15 and 12/15 as superseded. Best to not mark them all
> like that if the new version is not published.
> 
> Should I "drop" others?

We can "drop" them in this series. New version is very different from
this one.

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
