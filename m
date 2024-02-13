Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AB56767
	for <mptcp@lists.linux.dev>; Tue, 13 Feb 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832108; cv=none; b=oo7yRKFT3PiiKUvJJMBRsiq47ZugwK0fEtLRp20Skq/7/F4wMDyXLP2QQyg4RakdTDG9JXpRZmnX52Rp49cUhBKvgkyKW90F7qhXSzzD981xE4ScR4Bj5N40BFoBLWS1kCPnc2FxMR6ibSkL7gxEsqPxPH59x6o47lOIn7m1a3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832108; c=relaxed/simple;
	bh=JA64qwRixXswdOAeiG5pgkqAeTWA9eCxzIZoQPXU/q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noK4qjn0D2pR4N1bjHFeoxrIUXM3kTwO3VkJzny1KMtUmlhkh/F0xdm0zLWL/cM8yQQ65ODEPrVufFJ5lWR0BOm9JBHwNN/Vm/k2HqdYbiOqJ5mUqceCSTre6N7NXAOmawMLJ7yMo86zF3++Nyh3vuIXqdsfRDm5KTNS4t58NCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSQwJZls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSQwJZls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E050FC43399;
	Tue, 13 Feb 2024 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707832107;
	bh=JA64qwRixXswdOAeiG5pgkqAeTWA9eCxzIZoQPXU/q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSQwJZlsrJZ2L0lLTM2moU6QD7wm/pngB6jfB7auqVAYOrDLtf1Ik/R1VNne69BcY
	 YdQR8JGrIS+q9nXdSpqnvLEQwucXHl0OQiZ08FI9/PsSshfTk/4kZYA03RibH0jioO
	 yPdqJYMNdfaKYDmIifAP80S0gbaLUrKRj2h/v/Nvrq3Kc/Ml0d+3u33hUMNYfbuFyT
	 +qL502IklSFjO9mpmIxe9h+D9Di9WMphyWxD/16YHR474XJrtRUepIZt3VnnxnE1iP
	 xUQ1Lke88qoUb+OWyTExH6YE9LB0FBB2LcxlPEUjcfhSq1VdUthg3+RPVKpaU2K/hy
	 CINsvq9b5keXw==
Date: Tue, 13 Feb 2024 21:48:23 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net 1/5] selftests: mptcp: simult flows: fix some
 subtest names
Message-ID: <ZctzJ8qc2RhpZDlC@t480>
References: <20240209-selftests-mptcp-uniq-title-v1-0-e4fb3a3b5f66@kernel.org>
 <20240209-selftests-mptcp-uniq-title-v1-1-e4fb3a3b5f66@kernel.org>
 <ZctT4/w/nH6+4Ocz@t480>
 <3668c451-c2e8-4654-8ab2-42c7eabc099e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3668c451-c2e8-4654-8ab2-42c7eabc099e@kernel.org>

Hi Matt,

On Tue, Feb 13, 2024 at 01:06:40PM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the review!
> 
> On 13/02/2024 12:34, Geliang Tang wrote:
> > Hi Matt,
> > 
> > On Fri, Feb 09, 2024 at 06:28:39PM +0100, Matthieu Baerts (NGI0) wrote:
> >> The selftest was correctly recording all the results, but the 'reverse
> >> direction' part was missing in the name when needed.
> >>
> >> It is important to have a unique (sub)test name in TAP, because some CI
> >> environments drop tests with duplicated name.
> >>
> >> Fixes: 675d99338e7a ("selftests: mptcp: simult flows: format subtests results in TAP")
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >>  tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> >> index 619be0e1acf5..f377ef01970b 100755
> >> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> >> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> >> @@ -250,7 +250,8 @@ run_test()
> >>  		[ $bail -eq 0 ] || exit $ret
> >>  	fi
> >>  
> >> -	printf "%-60s" "$msg - reverse direction"
> >> +	msg="${msg} - reverse direction"
> > 
> > How about using '+=' operator to append a string like:
> > 
> > 	msg+=" - reverse direction"
> > 
> > The same in patch 3 and patch 4:
> > 
> > 	msg+=" after flush"
> > 
> > WDYT?
> 
> I usually prefer not to do that, because that's Bash specific, and it
> doesn't work with 'sh'.
> 
> Here, we explicitly use '/bin/bash', so nothing is blocking me, just an
> habit when often switching between "bash" and "sh" :)
> I can do the modification if you prefer.

Both are fine to me. You can modify them or not when merging them. All
tests passed on my side.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
