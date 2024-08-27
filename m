Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089D19581F
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748547; cv=none; b=Nklg0BBx9twl6cHjboqSUTBkf6r4WZzZ3mg68TWo6v//GWibwRUQC/ZTZDjUjNfl7n4QQtvrmZIjZf+I4cbCtZxd9xtrLSKvk2n9n4QmO/I/DnCCcvTmTSr3JQorcpeZOSWE8TNmLD1ntj2D4VkvfhFKsU4YQkGkhnc1zpM6Esc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748547; c=relaxed/simple;
	bh=atJMVFFAR2Ggbm8nkoFvQT1CN0h9t+MO/JMhETD04dc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o7dkSk15btIsx3pgyJsFg8h9SS2Yjda49OZqiYxi3SDA27RNiG9/+qxNP5ugVj3d9q3zFBaHPSv/4dSpz5juvbOcnJqp6x8xEKM0ljg7vmFNX0rHSnvFSGp0auDvug4A42u4reLDYD2569I/dUMZZbrJkL31B6LMQ3rJ51ZCzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQrtJvOx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQrtJvOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A858C8B7A0;
	Tue, 27 Aug 2024 08:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724748546;
	bh=atJMVFFAR2Ggbm8nkoFvQT1CN0h9t+MO/JMhETD04dc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GQrtJvOxRsIZoxwNNqGVihp8Vw6HfQdM3Vj2CFvokJbsCrPSFxOuGCFS0+quiHSex
	 b2E8SXjpKbcidLty/n4588HIha90yOMFVFF/MichMPkWnp9MPxsyiKGd5oSLHsuFQ3
	 g67NYBGU6bF+J2RTweISbvyfKwUV5QDzpOQXE3oTxD/3bHfQJZorTu0FQ3ZM6QYDmn
	 BnKok26U22vfpJoSpglG9ZAlxuBmruCC1FUHnz0z6ezqnb9I1GrEwqUrAaeHvhyzqI
	 iCwbJS9fEeuwnUpGsE5W7X6q3FvOvSXmQAo/PbuAymhihtg6wNDeUBg0gxTXqVBB1n
	 NuL0Hsj6sZWJg==
Message-ID: <363548497c01a3955412d32b281022104f993563.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 3/3] Squash to "selftests/bpf: Add mptcp
 subflow subtest"
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Tue, 27 Aug 2024 16:49:03 +0800
In-Reply-To: <26a19624-f042-487f-8227-a992ab786696@kernel.org>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
	 <ac6c7b2338205693434883a34256eddfd7605985.1724415435.git.tanggeliang@kylinos.cn>
	 <26a19624-f042-487f-8227-a992ab786696@kernel.org>
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

Hi Matt,

Thanks for the review.

On Mon, 2024-08-26 at 18:54 +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 23/08/2024 14:19, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Drop ss_search() from run_subflow().
> > 
> > Now ss_search() are only used by bpf_sched tests. It will be
> > dropped
> > in next step.
> > 
> > Use the "cgroup/getsockopt" way to inspect the subflows.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  .../testing/selftests/bpf/prog_tests/mptcp.c  | 57 ++++++++++++---
> > ----
> >  1 file changed, 35 insertions(+), 22 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > index 73adc58cd776..ce464b1e0802 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> > @@ -368,22 +368,13 @@ static int endpoint_init(char *flags)
> >   return -1;
> >  }
> >  
> > -static int _ss_search(char *src, char *dst, char *port, char
> > *keyword)
> > -{
> > - return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d
> > | grep -q '%s'",
> > -   NS_TEST, src, dst, port, PORT_1, keyword);
> > -}
> > -
> > -static int ss_search(char *src, char *keyword)
> > -{
> > - return _ss_search(src, ADDR_1, "dport", keyword);
> > -}
> > -
> >  static void run_subflow(char *new)
> >  {
> > - int server_fd, client_fd, err;
> > + int server_fd, client_fd, err, i;
> >   char cc[TCP_CA_NAME_MAX];
> > + unsigned int mark;
> >   socklen_t len;
> > + u8 subflows;
> >  
> >   server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> >   if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> > @@ -393,17 +384,26 @@ static void run_subflow(char *new)
> >   if (!ASSERT_GE(client_fd, 0, "connect to fd"))
> >   goto close_server;
> >  
> > - len = sizeof(cc);
> > - err = getsockopt(server_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> > - if (!ASSERT_OK(err, "getsockopt(server_fd, TCP_CONGESTION)"))
> > - goto close_client;
> > -
> >   send_byte(client_fd);
> >  
> > - ASSERT_OK(ss_search(ADDR_1, "fwmark:0x1"), "ss_search
> > fwmark:0x1");
> > - ASSERT_OK(ss_search(ADDR_2, "fwmark:0x2"), "ss_search
> > fwmark:0x2");
> > - ASSERT_OK(ss_search(ADDR_1, new), "ss_search new cc");
> > - ASSERT_OK(ss_search(ADDR_2, cc), "ss_search default cc");
> > + len = sizeof(subflows);
> > + /* Wait max 1 sec for new subflows to be created */
> > + for (i = 0; i < 10; i++) {
> > + err = getsockopt(client_fd, SOL_MPTCP, MPTCP_INFO, &subflows,
> > &len);
> > + if (!err && subflows > 0)
> > + break;
> > +
> > + sleep(0.1);
> > + }
> > +
> > + len = sizeof(mark);
> > + err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
> > + if (!ASSERT_OK(err || mark != 2, "getsockopt(client_fd,
> > SO_MARK)"))
> 
> The mark should be 0 on the MPTCP socket, no?

optval is modified in _check_getsockopt_subflows_mark(), so the mark is
2 now.

> 
> Also, I don't think you can do this check:
> 
>   err || mark != 2
> 
> That will be converted to:
> 
>   (err || mark != 2) == 0
> 
> We need to check there was no error and the mark is 0.
> 
> You could use ASSERT_TRUE/ASSERT_FALSE instead, but I think it is
> better
> to use two different assert: check 'err' is OK, then check the mark
> is
> 0, no?

Will update in v5.

> 
> 
> > + goto close_client;
> 
> Please see my previous comment on the v3:
> 
> It is not needed to stop earlier here, we should check everything we
> can
> to give more info about the issue:
> 
>   err = getsockopt(client_fd, SOL_SOCKET, SO_MARK, &mark, &len);
>   ASSERT_OK(err, "getsockopt(client_fd, SO_MARK)");
>   ASSERT_EQ(mark, 0, "mark");
> 
>   err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
>   ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)");
>   ASSERT_STREQ(new, cc, "cc");
> 
> > +
> > + len = sizeof(cc);
> > + err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> > + ASSERT_OK(err || strcmp(cc, new), "getsockopt(client_fd,
> > TCP_CONGESTION)");
> 
> (See above)
> 
> But after your modification in patch 1/3, 'cc' should be equal to
> '/proc/sys/net/ipv4/tcp_congestion_control' (not 'new'). So you need
> to
> get the value of the default CC first, then compare it to 'cc'. It
> should be different from 'new' (except if 'new' == default cc from
> /proc, so maybe enough to compare that 'cc' is the same as the
> default one).

optval is modified in _check_getsockopt_subflow_cc(), so 'cc' is equal
to 'new' now.

> 
> >  
> >  close_client:
> >   close(client_fd);
> > @@ -416,6 +416,7 @@ static void test_subflow(void)
> >   int cgroup_fd, prog_fd, err;
> >   struct mptcp_subflow *skel;
> >   struct nstoken *nstoken;
> > + struct bpf_link *link;
> >  
> >   cgroup_fd = test__join_cgroup("/mptcp_subflow");
> >   if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
> > @@ -441,6 +442,11 @@ static void test_subflow(void)
> >   if (endpoint_init("subflow") < 0)
> >   goto close_netns;
> >  
> > + link = bpf_program__attach_cgroup(skel-
> > >progs._getsockopt_subflow,
> > +   cgroup_fd);
> > + if (!ASSERT_OK_PTR(link, "getsockopt prog"))
> > + goto close_netns;
> > +
> >   run_subflow(skel->data->cc);
> >  
> >  close_netns:
> > @@ -449,6 +455,7 @@ static void test_subflow(void)
> >   mptcp_subflow__destroy(skel);
> >  close_cgroup:
> >   close(cgroup_fd);
> > + bpf_link__destroy(link);
> 
> That should be done just before 'close_netns' label, otherwise this
> will
> be called with 'link' that has not been defined.

Good catch, will update in v5.

> 
> >  }
> >  
> >  static struct nstoken *sched_init(char *flags, char *sched)
> > @@ -470,9 +477,15 @@ static struct nstoken *sched_init(char *flags,
> > char *sched)
> >   return NULL;
> >  }
> >  
> > +static int ss_search(char *src, char *dst, char *port, char
> > *keyword)
> 
> I guess this part should not be squashed in "selftests/bpf: Add mptcp
> subflow subtest", but in a different patch ("selftests/bpf: Add bpf
> scheduler test"), no?

Yes, it's for a different patch.

> 
> If yes, and if you need to send a new version, please split that in a
> separated patch, otherwise I might forget and apply this in
> "selftests/bpf: Add mptcp subflow subtest" instead.

Sure, will update in v5.

Thanks,
-Geliang

> 
> > +{
> > + return SYS_NOFAIL("ip netns exec %s ss -enita src %s dst %s %s %d
> > | grep -q '%s'",
> > +   NS_TEST, src, dst, port, PORT_1, keyword);
> > +}
> > +
> >  static int has_bytes_sent(char *dst)
> >  {
> > - return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
> > + return ss_search(ADDR_1, dst, "sport", "bytes_sent:");
> >  }
> >  
> >  static void send_data_and_verify(char *sched, bool addr1, bool
> > addr2)
> 
> Cheers,
> Matt

