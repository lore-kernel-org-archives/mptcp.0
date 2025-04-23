Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332BD2BAF7
	for <mptcp@lists.linux.dev>; Wed, 23 Apr 2025 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401849; cv=none; b=iAD/SH4YjMBorzHH0uP4lJzha0hnDADv+0OCP13mxz5lgcwk+usigprR27B/uHcJap0e7yTqp2r2iKFZlhW1WpJfPGc9hhOfGaUq5EWfW3GrPx4vQY4yfXNqcXBxOcPQDYZfVg0yPGbgbV++OJo9U+vbyui62timsDdu04bC+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401849; c=relaxed/simple;
	bh=VxBI+C3MGpha/eKAxmeERjCDuWCa7WgDkXtIM8T3yzo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=n7bIUM3eNWw1sGwX4MgKsyaq97uGz4vtGrvw4nk+uZOnUdU7tYmdSCZByS9h7+A4hTEB6Q2fFWUE2qBelyEE5VRrZS3ipE6Ec0qucpz6AbRCDRTCy6OBS7idHOrv0s8EVnJBSI7yYAW0Jtt7zQO4N2UBJmlliBNGO6az1c/2Y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOLsJncU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOLsJncU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49630C4CEE2;
	Wed, 23 Apr 2025 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745401848;
	bh=VxBI+C3MGpha/eKAxmeERjCDuWCa7WgDkXtIM8T3yzo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=jOLsJncUPaCHtSpcMARVDulw7hlntcxG0BrT0aCDjinzALtmfnnZKcqf2YIJ6u/9c
	 1cKFqc2ThBn2a3vIa6DmUwqYdmu5268NvaLQ3wVoZV19rOjTDKLNKFbzl33y7ZJdHA
	 4RxtCsqk/11KX45/qU62+YhYn68/270/7zO+akcoicCTncK4s94at/oh1nb81wtvms
	 oHIcVBHq6pZa7U1kkxrtr7goSTWm0/5vk07JRGSIqfpDILNdz9CgFY15cTdAP9GfeA
	 8u/kwJe5UAUewqdGFRI71n0F0lU7KzfpzeXPD9fAEYF72o2SBBwJhw8D/WfZ1o6Z8k
	 QRntw9dhy503Q==
Message-ID: <996f8df8fbbace706d3972f5d3a7727c2e652239.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v1 2/2] selftests: mptcp: sockopt: add
 TCP_MAXSEG sockopt tests
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
In-Reply-To: <1d68fc7d-06e7-493c-a207-658035c37af9@kernel.org>
References: <cover.1745314165.git.tanggeliang@kylinos.cn>
	 <98b1b574823f8447f8418b5567800ec01faba529.1745314165.git.tanggeliang@kylinos.cn>
	 <1d68fc7d-06e7-493c-a207-658035c37af9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Apr 2025 17:46:16 +0800
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Evolution 3.52.3-0ubuntu1 
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for the review.

> Hi Geliang,
> 
> On 22/04/2025 11:30, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch adds the TCP_MAXSEG sockopt tests in mptcp_sockopt.c.
> > Since
> > in getsockopt TCP_MAXSEG, the "user_mss" value can be obtained only
> > in
> > the LISTEN state (see do_tcp_getsockopt in net/ipv4/tcp.c), the
> > test
> > items are added to server() instead of client().
> 
> I think it is better to use packetdrill to do such validation,
> similar
> to what was done with other socket options. No?
> 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../selftests/net/mptcp/mptcp_sockopt.c       | 22
> > +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> > b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> > index 926b0be87c99..e2043c0261bd 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> > @@ -689,6 +689,26 @@ static int xaccept(int s)
> >  	return fd;
> >  }
> >  
> > +static void test_tcp_maxseg_sockopt(int fd)
> > +{
> > +	int maxseg = 1000;
> > +	socklen_t s;
> > +	int r;
> > +
> > +	s = sizeof(maxseg);
> > +	r = setsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &maxseg, s);
> > +	if (r != 0)
> > +		die_perror("setsockopt TCP_MAXSEG");
> > +
> > +	maxseg = 0;
> > +	r = getsockopt(fd, IPPROTO_TCP, TCP_MAXSEG, &maxseg, &s);
> > +	if (r != -1 && errno != EINVAL)
> > +		die_perror("getsockopt TCP_MAXSEG did not indicate
> > -EINVAL");
> > +
> > +	if (maxseg != 1000)
> > +		xerror("maxseg=%d", maxseg);
> > +}
> 
> Here, you set and get the value, but you don't really check the
> behaviour is the one we expect.
> 
> It is important to check the behaviour. It would be easier to do that
> with packetdrill I think.

I totally agree, but I want to verify the set and get values ​​in this
set first, I will add packetdrill tests for it later (once I learn how
to modify packetdrill).

Thanks,
-Geliang

> 
> > +
> >  static int server(int pipefd)
> >  {
> >  	int fd = -1, r;
> > @@ -713,6 +733,8 @@ static int server(int pipefd)
> >  
> >  	process_one_client(r, pipefd);
> >  
> > +	test_tcp_maxseg_sockopt(fd);
> > +
> >  	return 0;
> >  }
> >  
> 
> Cheers,
> Matt

