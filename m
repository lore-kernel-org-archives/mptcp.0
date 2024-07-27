Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B6631
	for <mptcp@lists.linux.dev>; Sat, 27 Jul 2024 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722042760; cv=none; b=K0mogwduj7tll4c7thSj4rkFOmHmRiPnA6Sd4s6kRNLhGcbrUULwQcTSVcijT75VA3+LeZ9Jyyxxp9xIBZRUHxdYhg0KvABn1t+y4N3fIHTOEJxjYbT5CIfvddYaEKd9N069hkEGXCw2tJTNapJ9FlUZeu4aHXGuTchBsDE0vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722042760; c=relaxed/simple;
	bh=i0417OMG7DuH9PPrAEaSP8j58BesHGnuFJ3TKj3gUqU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODaPTfnzke1RuHwk8/hwmkP7O6+FA3UKz6brz76VS6sBkFSIgy0ZJPgNVUgr7Q/F8E8DqvzSOl+mA57PQpK0lmInHCY0ME+HZ3zVTGi9FZbGT1apPzoxePafACXo9mC12wJ8L8B48nHZL23XBvE6qTyiinWukHqro5sS0Y3F+04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPgYGztk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPgYGztk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E6C32782;
	Sat, 27 Jul 2024 01:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722042760;
	bh=i0417OMG7DuH9PPrAEaSP8j58BesHGnuFJ3TKj3gUqU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nPgYGztkQ2PknHr2mqzYpNQPN4GOgR3353WfZ0sJEDP5cmdw1bHQGZFLvGu6PyOFZ
	 EOKGVPIc6njPNwaP0v7C+qRjwwq0WwWha6l9IV/SvsmD+HPhB49h2uxYrcuiS76dCt
	 mr5x9pBCMpq4kbJit22KU+6ouhIcdoLXaDmmeDAUwjX8Le4bowbjbfu32BY73v0zbg
	 W6vceEzFOl1nJrk+Mwb32fOB8H0WekDIzWafmG8BGfCj9JN023+WElWdumSZavSA2z
	 luHu4NweH8bfYV6Q9WYEMgyXbZhyxIi+WtOPeEQaw3/Fr5WCRaMVD8wMjITZ/9ASrm
	 XV7VI2Gcn1a5Q==
Message-ID: <86e407fd9b45d662515693a742fea144be16e837.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Sat, 27 Jul 2024 09:12:35 +0800
In-Reply-To: <39a825a6-ddf4-4ba4-97f1-9ac72d9ac811@kernel.org>
References: 
	<fccaccd2e7a1ce8518782c85965a6e26d37a87f9.1721872694.git.tanggeliang@kylinos.cn>
	 <39a825a6-ddf4-4ba4-97f1-9ac72d9ac811@kernel.org>
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

Hi Matt,

On Fri, 2024-07-26 at 11:18 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for the patch!
> 
> On 25/07/2024 03:58, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Skip the test with test__skip() for systems that do not
> > support "ip mptcp", so that CI can also pass.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/mptcp.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 00f63f3f19f4..ddef8c61360f 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -357,10 +357,11 @@ static int endpoint_init(char *flags)
> >  	SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> >  	SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST,
> > ADDR_2);
> >  	SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> > -	/* It would be better to use  "ip -net %s mptcp endpoint
> > add %s %s",
> > -	 * but the BPF CI is using an old version of IPRoute
> > (5.5.0).
> > -	 */
> > -	SYS(fail, "ip netns exec %s ./mptcp_pm_nl_ctl add %s flags
> > %s", NS_TEST, ADDR_2, flags);
> > +	if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s",
> > NS_TEST, ADDR_2, flags)) {
> 
> This will silently mark the test as skipped, because stderr will be
> muted.
> 
> > +		/* "ip mptcp" not support, skip this test. */
> 
> Could it be possible to at least print this comment? I can add:
> 
>   fprintf(stderr, "'ip mptcp' not supported, skip this test.\n");
> 
> when applying the patch. WDYT?

Martin, BPF maintainer, replied on "[v3 2/3] selftests/bpf: Add mptcp
pm_nl_ctl link" recently to suggest us to send a v4 of it, if then, no
need to apply this squash-to patch at this moment. Please send a v4 to
continue using mptcp pm_nl_ctl.

Sorry for the confusion caused.

Thanks,
-Geliang

> 
> > +		test__skip();
> > +		goto fail;
> > +	}
> >  
> >  	return 0;
> >  fail:
> > @@ -435,7 +436,7 @@ static void test_subflow(void)
> >  	if (!ASSERT_OK_PTR(nstoken, "create_netns:
> > mptcp_subflow"))
> >  		goto skel_destroy;
> >  
> > -	if (!ASSERT_OK(endpoint_init("subflow"), "endpoint_init"))
> > +	if (endpoint_init("subflow"))
> >  		goto close_netns;
> >  
> >  	run_subflow(skel->data->cc);
> 
> Cheers,
> Matt

