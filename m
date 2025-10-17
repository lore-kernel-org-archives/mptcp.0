Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD05222578
	for <mptcp@lists.linux.dev>; Fri, 17 Oct 2025 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760683128; cv=none; b=J+NZkTFOTFKbthlQv78jRgqtbfbk1Q3Y7Xq0A7ysHzdp9oUCmeTs7tL152VNyqWeC8SBDLDDeDWFlREk3ZcqEStkh4S4SVRzumiduIW/xo5CjuBqAbSAP65537DcP7Y/y8I5ooh/chv5JPmz1vP8x0GXwjuw3ZnJpM0bWZRngQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760683128; c=relaxed/simple;
	bh=oFQaLmpnbR+FAkzT6tpFFsMZKocA/X2QJVSmc2ay4Jo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlRJJfTr6ZmDB9JnfkM7y/EAqnKovBQYsinhul9fuyFMQ3aJr1+BT/sHcYeF7WVyxW3gsKtLQr9ZsPNgm9xj+Il98mPAZmy/qYUQkpGvMtoLH6BZ/qEG/yjbS11GVgBrEpB16kqZJxcm1XuiSj85Kb5zQLDbP7mCqM+EZp/OG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bowhxFdX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bowhxFdX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F2AC4CEE7;
	Fri, 17 Oct 2025 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760683128;
	bh=oFQaLmpnbR+FAkzT6tpFFsMZKocA/X2QJVSmc2ay4Jo=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=bowhxFdXAVP44BlSiMW27AmqVeDtvC4JUmcWbXlxd7wvSU/960q3vk11TL/PoYhbv
	 MsLW9cUgwoQn+Q7MsK3bbeIhE68frgw8TdnVU0xYeLkdrCEsvBJd49RPTp2xMUCCIG
	 Xt5Ec8Ar4m+l1ju/dTAbD1Ke4+wpem6CRL0hnT1zlXJpctFUz4b7XbqtxekHsoWxeb
	 Vt9WQYp8DO+zJhbRAUYhuCgzQa5HS/E91TlcW3ho7LVO+dDBygb9J4w9hLOSX/8+7t
	 3yJMU3nOe+F2297UDaREd3bcuDiMFqtg7b8S6AMmUOZoT4SReXgIyRBRPeymf9uGA6
	 5ZLAMqipgREyg==
Message-ID: <fc39dd4b9b36334ad52ba3e0940e642db4a560ee.camel@kernel.org>
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, mptcp@lists.linux.dev
Date: Fri, 17 Oct 2025 14:38:42 +0800
In-Reply-To: <281e24d1-da6a-493e-9d12-66bd3cdd7ed4@redhat.com>
References: <cover.1759737859.git.pabeni@redhat.com>
	 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
	 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
	 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
	 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
	 <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
	 <c53540268cb422a14d38745c6d0bdb440deb7c11.camel@kernel.org>
	 <6d3545fc-f342-4532-b1c3-fb96d9c79fe6@redhat.com>
	 <e759f7f6-b90f-4663-9ab4-040f76c2bbba@redhat.com>
	 <53ed629a-d364-470f-8a52-5a34692f0da7@redhat.com>
	 <20a3df573803203df6b672d1ecd606e242e84b20.camel@kernel.org>
	 <ef0495fe4e1012bb4b68a72361bdeb39872d96b6.camel@kernel.org>
	 <281e24d1-da6a-493e-9d12-66bd3cdd7ed4@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo, Matt, Mat,

On Wed, 2025-10-15 at 11:00 +0200, Paolo Abeni wrote:
> On 10/13/25 11:07 AM, Geliang Tang wrote:
> > On Fri, 2025-10-10 at 20:22 +0800, Geliang Tang wrote:
> > > Hi Paolo,
> > > 
> > > On Fri, 2025-10-10 at 10:21 +0200, Paolo Abeni wrote:
> > > > On 10/9/25 3:58 PM, Paolo Abeni wrote:
> > > > > @Geliang: if you reproduce the issue multiple times, are
> > > > > there
> > > > > any
> > > > > common patterns ? i.e. sender files considerably larger than
> > > > > the
> > > > > client
> > > > > one, or only a specific subsets of all the test-cases
> > > > > failing, or
> > > > > ...
> > > > 
> > > > Other questions:
> > > > - Can you please share your setup details (VM vs baremetal,
> > > > debug
> > > > config
> > > > vs non debug, vmg vs plain qemu, number of [v]cores...)? I
> > > > can't
> > > > repro
> > > > the issue locally.
> > > 
> > > Here are my modifications:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/geliang/mptcp_net-next.git/log/?h=splice_new
> > > 
> > > I used mptcp-upstream-virtme-docker normal config to reproduce
> > > it:
> > > 
> > > docker run \
> > > 	-e INPUT_NO_BLOCK=1 \
> > > 	-e INPUT_PACKETDRILL_NO_SYNC=1 \
> > > 	-v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it
> > > \
> > >         --pull always ghcr.io/multipath-tcp/mptcp-upstream-
> > > virtme-
> > > docker:latest \
> > > 	auto-normal
> > > 
> > > $ cat .virtme-exec-run 
> > > run_loop run_selftest_one ./mptcp_connect_splice.sh
> > > 
> > > Running mptcp_connect_splice.sh in a loop dozens of times should
> > > reproduce the test failure.
> > > 
> > > > - Can you please share a pcap capture _and_ the selftest text
> > > > output
> > > > for
> > > > the same failing  test?
> > 
> > The pcap captures (gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
> > connector.pcap, gQQ13x-ns1-ns3-MPTCP-MPTCP-dead:beef:3::2-10013-
> > listener.pcap) and the selftest text output (selftest_output) are
> > attached.
> 
> Looks like the 'stuck' scenario is quite consistent. The receiver
> filled
> it's receive window, and sent an ack shortly after when re-opening,
> but
> the sender did not react to such ack.
> 
> The perf instrumentation I mentioned would be very useful. I tried to
> capture it myself, but so far I failed - the repro run for several
> hundred iterations without issues and finally podmad stuck (podman
> bug
> apparently, or local resources exhausted).
> 
> Did you have better luck collecting the perf trace?

Sorry, I haven't made any progress yet. Please give me some more time.


I was thinking, since this issue only occurs during the splice test,
let's move the discussion to the future "implement mptcp read_sock and
splice" series. We shouldn't let it block the merging of this current
series.

I don't have any further constructive review comments on patches 9 and
10. I'm wondering if we should get input from Matt and Mat.

Thanks,
-Geliang

> 
> /P
> 
> 

