Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB8217F3
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 10:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715422244; cv=none; b=Od3/XP4Xqve6Af5zLnHOHEOazmBeprz4B9VDuWPR8SMTuJiWDCB4Is1LtCBlTHRBzjfJpRY/8kypg7R3f7PmmGBglcciyj+AIsr+v6u9eVvSuCqNIl1rr84raMEkZ6jACGJKCUUz5Kx+Iawl9scr8OQlpYan0ggE1h0onSXwjr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715422244; c=relaxed/simple;
	bh=k6R7WoZr7AKEUf1t9r7FAivddAup627AfWN7dFQsHeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iytrw/T4yK8J7a/TrN/+cbuunmBLzR3O2L1SIdzAb+NcFPpZK3sS3QMMWpRSCz2imPWfcc3EeIo2pvP31WXcP7BglHWSbhsuSSVC9C9Ra7G8dTqtPMezQ6B/u5GnNue8BePUD5umTCUxCQtdtZVJvw4SY86oMvUNhrZ/bld2dhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOK8NyLI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOK8NyLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC072C2BBFC;
	Sat, 11 May 2024 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715422243;
	bh=k6R7WoZr7AKEUf1t9r7FAivddAup627AfWN7dFQsHeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mOK8NyLI5nO2CtB9k2WCJSCx6aV+RGPOhunwtGUzBn3hA/NPVG/eg5xIHyp89Cdl2
	 1F9nslRr6d1UgYPjf+zGjV6fMKQHyoTw3EhcfSmRxHmoWfcFFbNuqLZi4SKFKt/RZf
	 XNNa9Ycpd3LFy4V/Mv5QCOIwWzZkhO6MKoXOWtBNTdkUIoHo+g0PyMlmSgBkjJOogl
	 1Dx4DnKhLXfYTWDemzneuhuLCt0PctiksOul6H0O3OI3cEM307eSx7rRpLgxna0snu
	 JLvg4HMJQX6TuU6PaKyRcGl9sndPjZAlqsOh6NyXTRtU3P8RI9A0e16OI7Kx5pdGSS
	 ZZupVPrdmhBJg==
Message-ID: <2053078c8764d70b31720c4821bc9b39a26159df.camel@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow subtest
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Date: Sat, 11 May 2024 18:10:39 +0800
In-Reply-To: <af5fcf12-e9db-4bbe-8704-4bd04ba55e62@kernel.org>
References: 
	<20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org>
	 <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org>
	 <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org>
	 <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com>
	 <3BFB4741-22F2-4CBC-8FB4-9988DEE7E25A@meta.com>
	 <af5fcf12-e9db-4bbe-8704-4bd04ba55e62@kernel.org>
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

On Fri, 2024-05-10 at 22:22 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> (MPTCP list only)
> 
> 10 May 2024 21:22:16 Manu Bretelle <chantra@meta.com>:
> 
> > ﻿On 5/10/24, 7:06 AM, "Alexei Starovoitov"
> > <alexei.starovoitov@gmail.com <mailto:
> > alexei.starovoitov@gmail.com>> wrote:
> > 
> > 
> > !------------------------------------------------------------------
> > -|
> > This Message Is From an External Sender
> > 
> > 
> > > -----------------------------------------------------------------
> > > --!
> > 
> > 
> > On Thu, May 9, 2024 at 11:31 AM Matthieu Baerts
> > <matttbe@kernel.org <mailto:matttbe@kernel.org>> wrote:
> > > 
> > > Hello,
> > > 
> > > On 09/05/2024 17:49, Matthieu Baerts (NGI0) wrote:
> > > > From: Geliang Tang
> > > > <tanggeliang@kylinos.cn <mailto:tanggeliang@kylinos.cn>>
> > > > 
> > > > This patch adds a subtest named test_subflow to load and verify
> > > > the newly
> > > > added mptcp subflow example in test_mptcp. Add a helper
> > > > endpoint_init()
> > > > to add a new subflow endpoint. Add another helper ss_search()
> > > > to verify the
> > > > fwmark and congestion values set by mptcp_subflow prog using
> > > > setsockopts.
> > > > 
> > > > Closes:
> > > > https://github.com/multipath-tcp/mptcp_net-next/issues/76 <
> > > > https://github.com/multipath-tcp/mptcp_net-next/issues/76>
> > > > Signed-off-by: Geliang Tang
> > > > <tanggeliang@kylinos.cn <mailto:tanggeliang@kylinos.cn>>
> > > > Reviewed-by: Mat Martineau
> > > > <martineau@kernel.org <mailto:martineau@kernel.org>>
> > > > Signed-off-by: Matthieu Baerts (NGI0)
> > > > <matttbe@kernel.org <mailto:matttbe@kernel.org>>
> > > > ---
> > > > tools/testing/selftests/bpf/prog_tests/mptcp.c | 109
> > > > +++++++++++++++++++++++++
> > > > 1 file changed, 109 insertions(+)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > index 274d2e033e39..6039b0ff3801 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > > 
> > > (...)
> > > 
> > > > @@ -340,10 +344,115 @@ static void test_mptcpify(void)
> > > > close(cgroup_fd);
> > > > }
> > > > 
> > > > +static int endpoint_init(char *flags)
> > > > +{
> > > > + SYS(fail, "ip -net %s link add veth1 type veth peer name
> > > > veth2", NS_TEST);
> > > > + SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST,
> > > > ADDR_1);
> > > > + SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> > > > + SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST,
> > > > ADDR_2);
> > > > + SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> > > > + SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST,
> > > > ADDR_2, flags);
> > > 
> > > I just noticed that this command is failing on the BPF CI:
> > > 
> > > https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=7009
> > >  <
> > > https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=7009
> > > >
> > > 
> > > Is it possible that an old version of IPRoute2 is installed?
> > > 'ip mptcp' is supported since v5.8.0 (from 2020).
> > > 
> > > It looks like Ubuntu Focal 20.04 is being used, which has the
> > > v5.5.0. Do
> > > we then need to find another way to set the MPTCP endpoints?
> > 
> > 
> > 
> > 
> > Manu, any idea?
> > 
> > // retrying plain text format.... please outlook, please, make this
> > happen!
> > 
> > Indeed, this is running Ubuntu 20.04. I am planning to eventually
> > update to 22.04 (which has iproute 5.15),
> > But I don’t have a good ETA to give other than this is not going to
> > be in the coming month.
> > 
> > It does not seem that iproute provides an easy way to check its
> > version, and the version returned by the container is:
> > 
> > root@081a02e57175:/actions-runner# ip --json -V
> > ip utility, iproute2-ss200127
> > root@081a02e57175:/actions-runner# dpkg -l iproute2
> > Desired=Unknown/Install/Remove/Purge/Hold
> > > Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-
> > > aWait/Trig-pend
> > > / Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
> > > > / Name           Version        Architecture Description
> > +++-==============-==============-============-
> > ====================================
> > ii  iproute2       5.5.0-1ubuntu1 amd64        networking and
> > traffic control tools
> > 
> > 
> > How complicated is it to set MPTCP directly using netlink
> > followinghttps://github.com/iproute2/iproute2/blob/397383a30c3b0e3ff551042b6654898a0872b83e/ip/ipmptcp.c#L573
> >  ?
> > Seems tools/testing/selftests/bpf/netlink_helpers.c could be useful
> > to deal with the netlink part. And the former link to find out how
> > to format the message?
> 
> Maybe we could use pm_nl_ctl?
> Could we add a symlink (mptcp_pm_nl_ctl.c) in progs?

It works. I'll send a patch to do this to our ML soon.

Thanks,
-Geliang

> 
> Cheers,
> Matth
> 
> 

