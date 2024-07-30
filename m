Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4542A1D5
	for <mptcp@lists.linux.dev>; Tue, 30 Jul 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306306; cv=none; b=MVN9LcYnFK5LYMIMbNK4k7G1QBe3cKXEPvTb9KXjc9oLAvTobD/PzAEbocn/0bQdbxVqbvSnTn5PkP+/MiWpU8Dk6SZCPGUTwLsZGL0amXPo/KklKE7mXpERLF/DS2P7a63fu8FXWVZPwYndKgb9lRq6OdzOukACdEKbkyaR0bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306306; c=relaxed/simple;
	bh=st7JDU1Q0hswsvrsgCdmiyRBEkxlhelZrbogfkOUIhM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TospaVqsbLBYLr7KuJ4h+CkQb5JWqidkMEC/LRuoS056Haoxmz83teNI0Mf4ZN66hi/b0ExR1WQENzJmyKG6bjXDPfaNJKil1SOXVACWQrtdiIikxiRW1Ow4lv6J9PRvUmur6FwFugrYObEK7dEdbE/btSJ29KO0UpwipSpO7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvRIq2PE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvRIq2PE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BBEC32786;
	Tue, 30 Jul 2024 02:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722306305;
	bh=st7JDU1Q0hswsvrsgCdmiyRBEkxlhelZrbogfkOUIhM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cvRIq2PEnalHBQU6BDfTcyS5a5PpM+/H05TBw6q7iLOf8AMArZjmiGtzCmw2DlsfB
	 xONNXNOUS+223ZCvthLRqrNrBWg3fVcalCiRCKRck1ePnRMQV62ZKDahBr4SeOQqJ7
	 EMl0E55b4MjCAUaBLd1CowtcW2mcjhCatMHZFO/SQeNnuJNk2xutPM1YIu0yn9bh78
	 rYtsmzgqJQ1KUQB2vPFQ0nzbW/nhInrIpV8FhOC/qcBLga5uWqjcx7G1iggOc5KamZ
	 JfPT3O/d4dURptCVBZOz8XPd3KQ4Q112Az/X8TIi79MBrvycnaP9bQuIexFSr8mQJd
	 shXD1/H7qFfQA==
Message-ID: <920cfe5f4f29f6b84480e791886bb0c5a59b986c.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v5 09/13] selftests: mptcp: join: validate
 fullmesh endp on 1st sf
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, Mat Martineau <martineau@kernel.org>
Date: Tue, 30 Jul 2024 10:24:58 +0800
In-Reply-To: <39e788d2-dfb0-4b12-b891-99a8cb15a1ef@kernel.org>
References: <20240726-mptcp-pm-avail-v5-0-fb1117ddeef6@kernel.org>
	 <20240726-mptcp-pm-avail-v5-9-fb1117ddeef6@kernel.org>
	 <5a5a7e689dbdad1afe1971759b780493fc7cc7de.camel@kernel.org>
	 <39e788d2-dfb0-4b12-b891-99a8cb15a1ef@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Mon, 2024-07-29 at 11:35 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 29/07/2024 03:19, Geliang Tang wrote:
> > On Fri, 2024-07-26 at 16:28 +0200, Matthieu Baerts (NGI0) wrote:
> > > This case was not covered, and the wrong ID was set before the
> > > previous
> > > commit.
> > > 
> > > The rest is not modified, it is just that it will increase the
> > > code
> > > coverage.
> > > 
> > > The right address ID can be verified by looking at the packet
> > > traces.
> > > We
> > > could automate that using Netfilter with some cBPF code for
> > > example,
> > > but
> > > that's always a bit cryptic. Packetdrill seems better fitted for
> > > that.
> > > 
> > > Fixes: 4f49d63352da ("selftests: mptcp: add fullmesh testcases")
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > >  tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > index f609c02c6123..e4ac275366ce 100755
> > > --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> > > @@ -3058,6 +3058,7 @@ fullmesh_tests()
> > >  	if reset "fullmesh test 1x1"; then
> > >  		pm_nl_set_limits $ns1 1 3
> > >  		pm_nl_set_limits $ns2 1 3
> > > +		pm_nl_add_endpoint $ns2 10.0.1.2 flags
> > > subflow,fullmesh
> > 
> > nit: add this line behind "pm_nl_add_endpoint $ns1 10.0.2.1 flags
> > signal". Usually, set n1 first and then n2.
> 
> It looks like we have a mix, but yes, most of the time we set the
> endpoints for the ns1, then the ns2. I can fix that when applying the
> patches if there are no other big changes needed here.

Sure, please update this when merging it.

> 
> > >  		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> > >  		fullmesh=1 speed=slow \
> > >  			run_tests $ns1 $ns2 10.0.1.1
> > > 
> > 
> > 
> 
> Cheers,
> Matt

