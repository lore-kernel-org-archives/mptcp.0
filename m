Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32FE1CA8A
	for <mptcp@lists.linux.dev>; Wed, 19 Jun 2024 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761942; cv=none; b=Mv5xarl/ioPJHQ/IM7kZcVuRrJAbaSm5u9zBNHsbes8/iITLWYZ04FytmZqrnixWCfag1fedMFr4JoO/snMYW/s6KH8TA5mB6K4oIFL+/VEyagBt30yblhKmvGYTXjZ3wtV4Q5XjttQq8qZ+e+rQFlzFqohOsTgQ9M25aYApEiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761942; c=relaxed/simple;
	bh=6npHUBGn4+LzWplcWZsP0ICzVPBdwiDlbh4bURonJWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XGk2LQnRWdkddot89j+W1vVUfaeB17+Z6SHJ5/rOKn4EYVxa/AxIfS+7S4Dd7hRvi2eEbFs4qeizo9fjHkHpjlg1oAFakeG25GlV4bEOxUZaQjsbZF9qKXjPseNWhld5UJPkmmmx0TfIChGDtqtN7hHK3R8NCw5Vs9bDMpkJhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b20Z7aQH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b20Z7aQH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF13C4AF1C;
	Wed, 19 Jun 2024 01:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718761941;
	bh=6npHUBGn4+LzWplcWZsP0ICzVPBdwiDlbh4bURonJWc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b20Z7aQHSGlojc3QJvHNWc3JZUN7fR3ub5cJkT/pL1Jhwbu3Ccb5gzwZLdAgq+HFt
	 TAjxIcn9BGRj8JWuWVz8ssMkKDIWx0t37BKKK065ePWMGSJYuGvB6WdoPh+xekP4z8
	 lgykpVGqhjjL7LrwiIcpYWpeclywCnRFZryqnNAXjvvbSKvtYmMy9bC0tLdmzl3aWh
	 EqoeLnJKuPJ905yU29D8hBQqxumKXHkB/4dE4u6iImQyWXigOMoguGYqs0pQNsPAMQ
	 mD+nox0i09EiQXedL7lajbBQBtrfNrW9XsluG/eHdQbG2/gRBkBCAj+jK94thdd0c8
	 uefXYB7Tm0JVw==
Message-ID: <10ac1bd1eef26be7258aa6b67e4843d9c4f7ac88.camel@kernel.org>
Subject: Re: [PATCH iperf3 v3] add MPTCPv1 support
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Wed, 19 Jun 2024 09:52:17 +0800
In-Reply-To: <ZfAO4OKX8sjHTQW9@t480>
References: 
	<4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
	 <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org> <ZfADyFB1vDYABpf9@t480>
	 <4a1febfb-54e0-4d1f-ac56-e5fa4e1bdead@kernel.org> <ZfAO4OKX8sjHTQW9@t480>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2024-03-12 at 16:14 +0800, Geliang Tang wrote:
> On Tue, Mar 12, 2024 at 09:09:27AM +0100, Matthieu Baerts wrote:
> > Hi Geliang,
> > 
> > On 12/03/2024 08:27, Geliang Tang wrote:
> > > Hi Matt,
> > > 
> > > On Tue, Mar 12, 2024 at 08:10:28AM +0100, Matthieu Baerts wrote:
> > > > Hi Geliang,
> > > > 
> > > > 11 Mar 2024 08:04:05 Geliang Tang <geliang@kernel.org>:
> > > > 
> > > > > The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been
> > > > > added in
> > > > > the upstream Linux kernel since v5.6.
> > > > > 
> > > > > MPTCP is strongly tied to TCP, and the kernel APIs are almost
> > > > > the same.
> > > > > The only required dependency is the 'IPPROTO_MPTCP' protocol
> > > > > number
> > > > > definition, which should be provided by the netinet/in.h
> > > > > header if it
> > > > > is recent enough.
> > > > > 
> > > > > This patch adds a new flag '-m' or '--multipath' to support
> > > > > MPTCPv1.
> > > > 
> > > > I just noticed you switched back to "multipath" instead of
> > > > "mptcp".
> > > > I think it is best to stick with "mptcp", because "multipath"
> > > > is too vague, thus confusing: it could be multipath as in
> > > > multiple
> > > > flows, multicast, with other protocols like UDP, etc.
> > > > 
> > > > Best to use "mptcp" everywhere: variables, strings,
> > > > description, etc.
> > > 
> > > Sure, I'll send a v4 to update the flag to '--mptcp'.
> > 
> > Thanks!
> > 
> > > But I don't know
> > > how to update the pull request on github. Should I send another
> > > pull
> > > request?
> > 
> > No, please don't open a new pull request, nor close the old one,
> > simply
> > override your remote branch on GitHub (`git push --force`).
> 
> Sorry, I open a new one before reading this:
> 
> https://github.com/esnet/iperf/pull/1661

This pull request has not been merged yet, and I recently found that it
has conflicted with other code, so I resolved the conflict and updated
it this pull request again.

In addition, I found that before my pull request, there was already a
pull request for MPTCP support waiting
(https://github.com/esnet/iperf/pull/1615 by "marcosfsch"). I guess it
is because there are two conflicting requests with the same purpose
that MPTCP support has not been merged. If this is the reason, can we
contact "marcosfsch" to see if these two requests can be merged into
one? It doesn't matter whether mine or his is merged.

Or the reason why it has not been merged is that iperf maintainers are
not interested in MPTCP support because he has not given us any
feedback. If this is the case, it seems we have no choice but to give
up supporting MPTCP in iperf.

Thanks,
-Geliang

> 
> > 
> > > > > It can be used like this:>>>
> > > > > > iperf3 -m -s
> > > > > > iperf3 -m -c 127.0.0.1
> > > > 
> > > > If the server doesn't have "-m", only the client, does it use
> > > > MPTCP?
> > > 
> > > Yes, it use MPTCP in this case. I just tested it.
> > 
> > Great, thank you for having tested that!
> > 
> > Cheers,
> > Matt
> > -- 
> > Sponsored by the NGI0 Core fund.
> 

