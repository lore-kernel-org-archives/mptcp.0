Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDD327457
	for <mptcp@lists.linux.dev>; Sat, 11 May 2024 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715469433; cv=none; b=Rc26CxljeZzvSZ7mV1oUgyKckEU4ImqZwZGoSB0jMjFUzLoulf2PDDryqhnHnpSb/22f4KtBOcvQeekQ7QPu5zCise1/O3zGTYQUT16haYR6RI9dW1rhX39vNm0sN8v/rVDyWPlunTpdHzkKxUIawBwksm5aCxDYoeXjBzpny8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715469433; c=relaxed/simple;
	bh=S3MA2o9Ay3TmpK3Itm4V5kFOTLZfvGOjWuhqek3fYdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLLt9YjKz92LcFI5ElsEbb5mSXRVTy51OQ/CFTpp72O8oLak0ACNmCiiwxXFeDD3fZNK0Q5CcT7PmBT8izMGMtWBSUxj+792GHAhAgae3HBIV4qsiu7H6sVH4H14rT+rtk8XYeZPSUk2FawJ0+q/SYRvwz+RNuwgEIoq/hboCQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGpdchgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGpdchgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA36C2BBFC;
	Sat, 11 May 2024 23:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715469432;
	bh=S3MA2o9Ay3TmpK3Itm4V5kFOTLZfvGOjWuhqek3fYdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGpdchgoWiBAHxBJ92gV594HrG5fSBNfwa9zHcGPDrNbFZc6C3z4EwJgBlwAZCnbn
	 eU8KWnhejfo79yHQ3xKMgdn9xJClkVP0aQYNzcBWKEGILByMjjrTpdEje3RW/U8LN8
	 oFTy34KGIg40ABMDD7kSjVQqjo43sqRm4xGH21II1wdO7XumiNlMNlJSuTIRhNgSoa
	 MJW0a0HCc7aJT/1fhv+DipM4DFqA9gxQ1ssjaYraHYZ/PHKshlBOsAVP5wblaYeuQc
	 K4ME1/AZ6F1BUiLrwAOJnjYc3yFMHpp3eD9f/CEPpx+5fVAmXvvYYN3fOeBL2OtlcW
	 1nyEw1b4m7jfQ==
Date: Sun, 12 May 2024 07:17:08 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
Message-ID: <Zj_8dK-hT2JV-1eB@T480>
References: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
 <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org>

On Sat, May 11, 2024 at 03:50:29PM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> Thank you for this fix!
> 
> 11 May 2024 12:42:08 Geliang Tang <geliang@kernel.org>:
> 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >
> > Add pm_nl_ctl.
> > Use SYS_NOFAIL in _ss_search().
> >
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > tools/testing/selftests/bpf/Makefile           |  2 +-
> > tools/testing/selftests/bpf/pm_nl_ctl.c        |  1 +
> > tools/testing/selftests/bpf/prog_tests/mptcp.c | 15 ++++-----------
> > 3 files changed, 6 insertions(+), 12 deletions(-)
> > create mode 120000 tools/testing/selftests/bpf/pm_nl_ctl.c
> >
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index b90c718218ae..bd2e3b138a5c 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -131,7 +131,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >     flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> >     test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> >     xskxceiver xdp_redirect_multi xdp_synproxy veristat xdp_hw_metadata \
> > -   xdp_features bpf_test_no_cfi.ko
> > +   xdp_features bpf_test_no_cfi.ko pm_nl_ctl
> >
> > TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
> >
> > diff --git a/tools/testing/selftests/bpf/pm_nl_ctl.c b/tools/testing/selftests/bpf/pm_nl_ctl.c
> > new file mode 120000
> > index 000000000000..5a08c255b278
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/pm_nl_ctl.c
> 
> Best to prefix it with "mptcp_": clearer and it will be linked to MPTCP in the maintainers file.

mptcp_ prefix has already added in v2. Please update the maintainers
file when merging this.

> 
> > @@ -0,0 +1 @@
> > +../net/mptcp/pm_nl_ctl.c
> > \ No newline at end of file
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 793b4b9c2bd2..9c6d1e4f6f35 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -362,7 +362,8 @@ static int endpoint_init(char *flags)
> >     SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> >     SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
> >     SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> > -   SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
> > +   if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags))
> 
> It is maybe better to only use mptcp_pm_nl_ctl here: to maintain one way here, our CI will do the same as what the BPF one will do, and we avoid errors printed in stderr if "ip mptcp" is not supported.
>

No, I prefer this one. "ip mptcp" should be used here since it's
the normal way to set mptcp. pm_nl_ctl is just a work-around for it.

No error printed in stderr if "ip mptcp" is not supported since
SYS_NOFAIL is used here, not SYS. I have tested this case already.

> > +       SYS(fail, "ip netns exec %s ./pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
> >
> >     return 0;
> > fail:
> > @@ -371,16 +372,8 @@ static int endpoint_init(char *flags)
> >
> > static int _ss_search(char *src, char *dst, char *port, char *keyword)
> > {
> > -   char cmd[128];
> > -   int n;
> > -
> > -   n = snprintf(cmd, sizeof(cmd),
> > -            "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> > -            NS_TEST, src, dst, port, PORT_1, keyword);
> > -   if (n < 0 || n >= sizeof(cmd))
> > -       return -1;
> > -
> > -   return system(cmd);
> > +   return SYS_NOFAIL("ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> > +             NS_TEST, src, dst, port, PORT_1, keyword);
> 
> If "ip mptcp" is not supported, I guess "ss -M" will not be supported as well, no?
> 
> Do we need -M here for these tests?

No need to do this yet until we actually encounter it.

Regards,
Geliang

> 
> Cheers,
> Matt
> 
> > }
> >
> > static int ss_search(char *src, char *keyword)
> > --
> > 2.43.0
