Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9CD15FA66
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204326; cv=none; b=byz80Q2D7LLdO6KTA3bMSp+oie69uHRf7D4XjrODldXXetEnFEwopaNv9T1H/alyeBm0OA34lrTYjBQOv30nNhsTE7aJuleETO2aExw8NwsugNNhwfQ3jU8dL2S8LikXs/KNl60uMWnng0eK/rIM3TsQqO43ikJVmVuTTlQkZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204326; c=relaxed/simple;
	bh=b7beDJdnRm81i2xgz5xHvBCCMJxDIXgY+PMv6t9lGHo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohmd9swcBJfBIlgZNzA300TYPF8etSVh1gnLLlhtoeC5zjOaKTQ8HmOs1Pfy9oyj/BXkIwJB//ft9sBajpCibg9h1iBsSbWkzPrkXlfTLyxJVxDNr00yIJkuwEC40SDjjQu3tsCF4vtrnkT8dz/RAGtnaQPIDCIoKl+1C9Xquv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbYe9Vu7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbYe9Vu7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C609C32782;
	Fri,  9 Aug 2024 11:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723204326;
	bh=b7beDJdnRm81i2xgz5xHvBCCMJxDIXgY+PMv6t9lGHo=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=cbYe9Vu7luGNMNSbuIbQUhi/ndPLqMLH/6pThuorAsuMUhtj88WiHD++/qtPMaWGu
	 gvDYWTDG7BNZrlzVbp5SfSOzCzbShv0eWaWwyx5gGmTjcAuXf5FS3/LJSrtEzS4ea7
	 pefKnvgMtPbbFDF8TrTwxXPVQD3FNg/Y4Iq6fLB+HSVIMl+jeekYPoiaPSfVlOyMZh
	 zDW8G+s0lhYbmLrEjsoEkW9zqbNdjr8qliwCaRQeW19omII2272PUageeZPTpzR7qh
	 2/2jLziMv4qZ1kzL7DEUzRgIJ/OZYiqO+NfUDNcw2/QMvqkO6lfJQ1KxDgl+KTT8hP
	 a4rJaupnW4RPg==
Message-ID: <14b72b299c3ef1cd0c5631178f15b2c1d1424540.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v3 1/8] selftests: mptcp: join: no extra msg
 if no counter
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 09 Aug 2024 19:52:02 +0800
In-Reply-To: <3ed64a86-ab9a-48da-b4b6-6952e29da39d@kernel.org>
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
	 <20240806-mptcp-join-tx-mib-v3-1-c3b54d2099e9@kernel.org>
	 <2c144f50dc8e6f92e1bd1569802ec75f362a9ec9.camel@kernel.org>
	 <ef3e8f6d-18a5-4ffd-939d-c3d0c650fd39@kernel.org>
	 <8be6c6a01484696985cc90a800d749ed9acb4ff0.camel@kernel.org>
	 <3ed64a86-ab9a-48da-b4b6-6952e29da39d@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-08-09 at 13:32 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 09/08/2024 04:30, Geliang Tang wrote:
> > On Thu, 2024-08-08 at 12:17 +0200, Matthieu Baerts wrote:
> > > Hi Geliang,
> > > 
> > > Thank you for the review!
> > > 
> > > On 08/08/2024 04:38, Geliang Tang wrote:
> > > > Hi Matt,
> > > > 
> > > > Thanks for these patches.
> > > > 
> > > > On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0)
> > > > wrote:
> > > > > The checksum and fail counters might not be available. Then
> > > > > no
> > > > > need
> > > > > to
> > > > > display an extra message with missing info.
> > > > > 
> > > > > While at it, fix the indentation around, which is wrong since
> > > > > the
> > > > > same
> > > > > commit.
> > > > > 
> > > > > Fixes: 47867f0a7e83 ("selftests: mptcp: join: skip check if
> > > > > MIB
> > > > > counter not supported")
> > > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > > ---
> > > > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 12 ++++++-
> > > > > ----
> > > > > -
> > > > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > index 01c1e0871aca..a1f80dac59a7 100755
> > > > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > > > @@ -1112,7 +1112,7 @@ chk_csum_nr()
> > > > >  
> > > > >  	print_check "sum"
> > > > >  	count=$(mptcp_lib_get_counter ${ns1}
> > > > > "MPTcpExtDataCsumErr")
> > > > > -	if [ "$count" != "$csum_ns1" ]; then
> > > > > +	if [ -n "$count" ] && [ "$count" != "$csum_ns1" ];
> > > > > then
> > > > 
> > > > We have checked [ -z "$count" ] in mptcp_lib_get_counter()
> > > > already,
> > > > so
> > > > I think no need to double check it here. Can we just let
> > > > mptcp_lib_get_counter() return "0" in this [ -z "$count" ]
> > > > case,
> > > > then
> > > > we can drop all these [ -n "$count" ] or [ -z "$count" ] (like
> > > > in
> > > > chk_cestab_nr()) checks after mptcp_lib_get_counter()? WDYT?
> > > 
> > > I don't think we can do that: mptcp_lib_get_counter() will return
> > > nothing if the counter doesn't exist: if the kernel being used
> > > doesn't
> > > support it. If it is our CI running the tests, there will be a
> > > failure
> > > thanks to "mptcp_lib_fail_if_expected_feature()", but only with
> > > *our*
> > > CI, because "SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES" is set to
> > > 1.
> > > 
> > > So here, we need to check if '$count' is not empty, before
> > > comparing
> > > it
> > > with '$csum_ns1'. If it is empty, the check will be skipped (see
> > > 4
> > > lines
> > > below), but we don't want to print a useless "extra message" in
> > > this
> > > case, with just "ns1=".
> > 
> > If so, let's keep this patch as is. I'll try to fix it later.
> 
> I don't think there is anything to fix there. We need these two
> checks:
> one for our CI to detect missing features, and the other one to skip
> the
> test if the (old) kernel (ran by another CI) doesn't support the
> counter.

Yes, indeed, you are right.

> 
> Cheers,
> Matt

