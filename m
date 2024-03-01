Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF069304
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276626; cv=none; b=Tf+tc3Mr++cpm6vbP/onVa3kDAAvjLNzrH4IhJZBcVnDaqD1FNSDV1l/G/KEo/LkGrlkxDydM25Bh7bkuLXpT2ZCM1uNfiFXEFV5AuBxbthkao15yuvk50SPTss4qSwJdpy55+4f0ZJXBZNtx+FmwjPu9wdVrggrt4S7gVak4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276626; c=relaxed/simple;
	bh=Ltxxk3dbHldCAfqPTbnKZ6SdMBOq0jr+Ln8cBS4goek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rDr7g8VWopMY/kkXkSyfwEN9JOvg4h7oIgkMGb7A0bzjSF693/zWk/KtfwBB3ldqZe0MF4UGDnwJJpcNE+1nI/rqfVVPToxA4WX1mdzox9xUEMW2tKr/JgfiaaYkg+Zy9Qpil46yfUlB/Hb0fKJzd3xjo1GyQf/QW6IGytKuxv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHIBcv9e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHIBcv9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0796BC433C7;
	Fri,  1 Mar 2024 07:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709276626;
	bh=Ltxxk3dbHldCAfqPTbnKZ6SdMBOq0jr+Ln8cBS4goek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LHIBcv9eV6j8cl/0S1o3YnrG4C/KBC0PDQuYHf8VcAexpPX1Fpgh6dFyiML1Eqerf
	 z2y26+pNJsrm968frmc/7Uf1q5xVFuw4Z7QGyeyorT3sqOA4qM4Py0/Xt8kFbcouQF
	 ENVbfWpH9+WSAKaeThjNUoIzsIHCCftwS8/ktxuB5PyVnrnYSeC0jcTmjkv/fMavWa
	 QSqh3ULWe/prJX6yrFvdsYrqraSvzm2ealCK09pFR4U+FKdxFjEoCTuF2a3Obsrrea
	 Zznf7HRUtNuoogEMy2o2I0RDcMC1Gp9SuxDzWHap8J/5i4hF7m+/hHr8HJ6GOGhRqj
	 tdKJlkgvWUBcw==
Message-ID: <35fa8b8fa6b68152b63163a8e853e6629fa8155e.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v7 6/8] selftests: mptcp: add test counter
 helpers
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Fri, 01 Mar 2024 15:03:41 +0800
In-Reply-To: <4930a445-3a30-4272-aa26-4dbff29b0c15@kernel.org>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
	 <9a31a17605edb4546467a172d8619eff3f15a002.1709200070.git.tanggeliang@kylinos.cn>
	 <fea0084f-665b-4ea2-96cd-f9c025c02a28@kernel.org>
	 <4930a445-3a30-4272-aa26-4dbff29b0c15@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Thu, 2024-02-29 at 13:28 +0100, Matthieu Baerts wrote:
> On 29/02/2024 12:58, Matthieu Baerts wrote:
> > Hi Geliang,
> >=20
> > On 29/02/2024 10:51, Geliang Tang wrote:
> > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > >=20
> > > This patch adds two vars in mptcp_lib.sh, MPTCP_LIB_TEST_COUNTER
> > > for
> > > the test counter and MPTCP_LIB_TEST_FORMAT for the test print
> > > format.
> > > Also add two helpers, mptcp_lib_inc_test_counter(), increase the
> > > test
> > > counter, and mptcp_lib_pr_title_counter(), print the test title
> > > with
> > > counter. They are used in mptcp_join.sh first.
> >=20
> > Please add the reason, something like: Each MPTCP selftest is
> > having
> > subtests, and it helps to give them a number to quickly identify
> > them.
> > This can be managed by mptcp_lib.sh, reusing what has been done
> > here.
> > The following commit will use these new helpers in the other tests.
> >=20
> > > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > > ---
>=20
> (...)
>=20
> > > +mptcp_lib_pr_title_counter() {
> > > +	: "${MPTCP_LIB_TEST_COUNTER:?}"
> > > +	: "${MPTCP_LIB_TEST_FORMAT:=3D"%02u %-50s"}"
> > > +
> > > +	printf "${MPTCP_LIB_TEST_FORMAT}"
> > > "${MPTCP_LIB_TEST_COUNTER}" "${*}"
> >=20
> > I didn't check: can you not print the title and increment the
> > counter
> > (via mptcp_lib_inc_test_counter) from here? I think that would be a
> > good
> > practice to do that instead of having to deal with the counter in
> > different places.
> >=20
> > We would only call "mptcp_lib_inc_test_counter()" from other
> > scripts
> > when a test is skipped.
>=20
> OK, I just saw you added mptcp_lib_print_title() in the next patch.
> Why
> did you not use it for mptcp_join.sh?
>=20
> Can you not call "mptcp_lib_inc_test_counter" in the "if skip_test"
> from
> mptcp_join.sh and use mptcp_lib_print_title()? (if you do that, I
> guess
> we don't need mptcp_lib_pr_title_counter(), no?)

Yes, I dropped mptcp_lib_pr_title_counter in v9.

>=20
> >=20
> > > +}
> >=20
> > Cheers,
> > Matt
>=20
> Cheers,
> Matt

