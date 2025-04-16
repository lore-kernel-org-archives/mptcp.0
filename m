Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCC41DF260
	for <mptcp@lists.linux.dev>; Wed, 16 Apr 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787987; cv=none; b=gJRh8UMKf8las9F5U2eI3MhQ8YMTLpqm1Ky+BGfheuFkf2NvU1ZhmO4H0vPUIa26bzyzYlGipwxfu4q529ys+1f2MjrPN6YAhrcNhmk9qPXXbiOYbEYOPWYOwIDGhjDiVBZggeUryJX2z2d9sRi+CQe3dLztYtrwgr7JKV1o/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787987; c=relaxed/simple;
	bh=1+DC264mmeq2Itr1FyFDnfdyS+lH2u5x8viW+o/RLvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nCaF6s8vJNbnzAporwnvZckshr8CFR7gEHJoO3BgmsinAfvBIpAUevUf8kmVMRlnlhKeLowktn/0Li/asTiivXdNL3TBh9aZ6XkIPxPqXlpp5vP5K+TnMVcgiNaKLEoaHdC1LO0LtJD73O0dpuiJYHK0ORZFua0F3SnxtyXxvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flxbBPev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flxbBPev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99773C4CEF0;
	Wed, 16 Apr 2025 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744787986;
	bh=1+DC264mmeq2Itr1FyFDnfdyS+lH2u5x8viW+o/RLvg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=flxbBPevJUE8RJxCVkodGz2HKlApHTODAJLJ7xYhnmIRardwmbrVMLRDKbq6Kn6SH
	 GPxxowPS9NjS0tFprcUTvk9xQ5aBd3DxpLujD4KO/p8AkBr8q+ZQgAaa2YQ5uspT7y
	 LyWTvle6NQWK3A8nlI3YDKkT6wUboQJkWWtOCX1H9jAlR0ldO/t2396DwSE5uwrbDH
	 kwQviD02Q+uhBcZomqdJOGOps/L+/MgK/hcs3oENiUP4g8WqOdKzwgNbp2Y1ZOxk5z
	 Rngv46pPdHnbrLGO5GNDp1Ya/GqLhPRMSlpi9+ugpaQ2hYYCxTqoKTYZkepc1dwbHI
	 XGlD5+iteNf5A==
Message-ID: <e3873d83fe93adc6519a67a20c87f90a8d543157.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: pm: userspace: drop
 delete_local_addr helper
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 16 Apr 2025 15:16:21 +0800
In-Reply-To: <100ce0ca-d6e3-4ea5-8227-909e671a1ead@kernel.org>
References: <cover.1744257362.git.tanggeliang@kylinos.cn>
	 <2b140a3cefd7d5766a79e8c55b73cf2d38c710d0.1744257362.git.tanggeliang@kylinos.cn>
	 <ebdb4b2d-19fe-29ef-65df-d201b201b151@kernel.org>
	 <0caab1005d589bbda1e4e9224757ccc258ab37d4.camel@kernel.org>
	 <66f456226a68cc9e5458bb49eae348fadbe8649a.camel@kernel.org>
	 <100ce0ca-d6e3-4ea5-8227-909e671a1ead@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Matt,

On Tue, 2025-04-15 at 13:00 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 15/04/2025 11:18, Geliang Tang wrote:
> > On Tue, 2025-04-15 at 11:09 +0800, Geliang Tang wrote:
> > > On Fri, 2025-04-11 at 17:26 -0700, Mat Martineau wrote:
> > > > On Thu, 10 Apr 2025, Geliang Tang wrote:
> > > > 
> > > > > From: Geliang Tang <tanggeliang@kylinos.cn>
> > > > > 
> > > > > Address entries should not be removed from local_addr_list
> > > > > when a
> > > > > subflow
> > > > > is deleted by the userspace PM, should only be removed when
> > > > > sending
> > > > > a
> > > > > REMOVE_ADDR.
> > > > > 
> > > > > So mptcp_userspace_pm_delete_local_addr() helper shouldn't be
> > > > > called in
> > > > > mptcp_pm_nl_subflow_create_doit() and
> > > > > mptcp_pm_nl_subflow_destroy_doit().
> > > > > 
> > > > > Since this helper is open-coding in
> > > > > mptcp_pm_nl_remove_doit(), it
> > > > > can be
> > > > > dropped now.
> > > > > 
> > > > > Address entries are removed from local_addr_list when sending
> > > > > a
> > > > > REMOVE_ADDR
> > > > > by the userspace PM, the local_addr_used counter of PM should
> > > > > also
> > > > > be
> > > > > decremented accordingly.
> > > > > 
> > > > 
> > > > Hi Geliang -
> > > > 
> > > > Have you tried this patch with mptcpd? Does it affect any tests
> > > > there?
> > > 
> > > I haven't tested it. To be honest, I don't know how to run the
> > > test
> > > items of mptcpd. Can you give me some guidance?
> 
> 'make check' should execute all the tests. Do you mind trying this
> with
> and without your modifications?

This is the output with and without my modifications:

make  check-TESTS
make[3]: Entering directory '/home/tgl/mptcpd/tests'
make[4]: Entering directory '/home/tgl/mptcpd/tests'
PASS: test-plugin
PASS: test-network-monitor
PASS: test-path-manager
PASS: test-commands
PASS: test-configuration
PASS: test-id-manager
PASS: test-listener-manager
PASS: test-sockaddr
PASS: test-addr-info
PASS: test-murmur-hash
PASS: test-cxx-build
PASS: test-bad-log-empty
PASS: test-bad-log-long
PASS: test-bad-log-short
PASS: test-bad-option
PASS: test-bad-path-manager
PASS: test-bad-plugin-dir
SKIP: test-start-stop
PASS: test-mptcpwrap
=======================================================================
=====
Testsuite summary for mptcpd 0.13
=======================================================================
=====
# TOTAL: 19
# PASS:  18
# SKIP:  1
# XFAIL: 0
# FAIL:  0
# XPASS: 0
# ERROR: 0
=======================================================================
=====
make[4]: Leaving directory '/home/tgl/mptcpd/tests'
make[3]: Leaving directory '/home/tgl/mptcpd/tests'
make[2]: Leaving directory '/home/tgl/mptcpd/tests'
make[1]: Leaving directory '/home/tgl/mptcpd/tests'
Making check in scripts
make[1]: Entering directory '/home/tgl/mptcpd/scripts'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/home/tgl/mptcpd/scripts'
make[1]: Entering directory '/home/tgl/mptcpd'
make[1]: Nothing to be done for 'check-am'.
make[1]: Leaving directory '/home/tgl/mptcpd'

> 
> Please make sure relevant ones are not skipped because of missing
> dependences or tools.
> 
> > I just tested it this way, and here are the test results:
> 
> (...)
> 
> > These results appear to be unchanged from before. And in fact these
> > tests do not test userspace pm.
> 
> I don't remember what is being tested, but I guess some parts of the
> userspace PM are tested somewhere, no?
> 
> Coveralls [1] seems to indicate it is tested, but I don't see the
> details.
> 
> [1] https://coveralls.io/github/multipath-tcp/mptcpd
> 
> > So it seems that this patch will not affect the tests of mptcpd.
> 
> Regarding your patch 2/2 of this series: did you have to modify the
> selftests to make the tests passing again due to a changed behaviour,
> or
> did you modify them to extend the behaviour.

The first one, I tried to make the tests passing again. I updated these
userspace selftests in v3 to make sure does not change the behaviour of
these tests.

Thanks,
-Geliang

> 
> It looks like the behaviour has changed, but it is unclear to me if
> it
> is to fix something or add a new feature.
> 
> Cheers,
> Matt

