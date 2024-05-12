Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC921C2AD
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715514314; cv=none; b=ccfYVgdWArdrjdvVrMqUmDoHf5kaWPRDBWxxVGI8VUAUcOXZHTk2wTGPbH4lEOySGdr0x1I9VqBO+efxd1NqsIw/y8qPolkdbJqYEJf87ZZh63HX/eYLKLoO4AFcIMrdTOUClGs4D4xJZhs/Hr3wZoO8nlLbV/drWZI2UI52iug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715514314; c=relaxed/simple;
	bh=4kN3Wfix6dTYPiluiRtnW5j99SzyvV2KqhuXGAkLwu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gROp382N2KkY2HHevV/nq6aQ1H2ZNmH4V6ZnqJA2LvCkNvlW8NCdGsPnvFbKVQhVenIt9VjSS3Vy6SZxZC+Fv6LnWZDYkRnpx03PXkphm1lczZ7hmt66qMA7BkjyVEBKVsyy64Uk7tlpb6YJbvPWf/ZoCadbUaW8bAnU0ljvBto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhmqZHGU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhmqZHGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BCCC116B1;
	Sun, 12 May 2024 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715514314;
	bh=4kN3Wfix6dTYPiluiRtnW5j99SzyvV2KqhuXGAkLwu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhmqZHGUjYq4YON6ONMsWSJGJnHuPo/gXjd7FVmHK/EMa2kRbnyQfTlWcANMM8PUa
	 q8lLxhD0i+zgbAsqSn3k326ZuR4nOJHd4ekndUvDOdZ+EjHtvpTtVaCAnNSYNUGl2p
	 eJQtNBTOOpjjX2USwpRCo9XDRa8udmnMHIFvtLhwU83Kc5X3lGtQGMXh6j6yfsWKSO
	 JW3iSScMdViLWpZDSr0KbLila4Czh5LTVvkNIW7w8bO9xadTdXExVHZEuhi6fV29/C
	 8ONEFETb6mKePWLo2xq0num/kjjFuS8TXORJzIOI13ckkNyAqkG5IDZ+2T2OKHDSsK
	 kjRbAIiuSqSug==
Date: Sun, 12 May 2024 19:45:10 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
Message-ID: <ZkCrxpnEvIeYACTQ@T480>
References: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn>
 <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org>
 <Zj_8dK-hT2JV-1eB@T480>
 <551a0206-2e72-45a6-8807-3d5fd27ef0a8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <551a0206-2e72-45a6-8807-3d5fd27ef0a8@kernel.org>

On Sun, May 12, 2024 at 11:14:38AM +0200, Matthieu Baerts wrote:
> Hi Geliang,
> 
> 12 May 2024 01:17:13 Geliang Tang <geliang@kernel.org>:
> > On Sat, May 11, 2024 at 03:50:29PM +0200, Matthieu Baerts wrote:
> >> 11 May 2024 12:42:08 Geliang Tang <geliang@kernel.org>:
> >>> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> (...)
> 
> >>> @@ -0,0 +1 @@
> >>> +../net/mptcp/pm_nl_ctl.c
> >>> \ No newline at end of file
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >>> index 793b4b9c2bd2..9c6d1e4f6f35 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> >>> @@ -362,7 +362,8 @@ static int endpoint_init(char *flags)
> >>>     SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
> >>>     SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
> >>>     SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
> >>> -   SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags);
> >>> +   if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, flags))
> >>
> >> It is maybe better to only use mptcp_pm_nl_ctl here: to maintain one way here, our CI will do the same as what the BPF one will do, and we avoid errors printed in stderr if "ip mptcp" is not supported.
> >>
> >
> > No, I prefer this one. "ip mptcp" should be used here since it's
> > the normal way to set mptcp. pm_nl_ctl is just a work-around for it.
> >
> > No error printed in stderr if "ip mptcp" is not supported since
> > SYS_NOFAIL is used here, not SYS. I have tested this case already.
> 
> SYS_NOFAIL doesn't redirect stderr to /dev/null, does it?
> If "ip mptcp" is not supported and a fatal error happens, will you not see
> in the logs "ip mptcp is not supported" as well, creating confusions?
> 
> I would also prefer to use "ip mptcp" if available, but my main reason to
> use only the workaround, is: if we change the syntax of pm_nl_ctl, not
> realising we have to modify the code here as well, our CI will not
> complain, but BPF CI will later, likely when validating something else.
> We want our CI to catch such issues before upstreaming patches.
> 
> Why not adding a comment instead?
> 
>   /* Equivalent of: "ip -net %s mptcp endpoint add %s %s" */
> 
> So people interested in knowing how to do that the "proper" way will see
> what to do, no?

SYS_NOFAIL is defined in test_progs.h:

388 #define ALL_TO_DEV_NULL " >/dev/null 2>&1"
389
390 #define SYS_NOFAIL(fmt, ...)                                            \
391         ({                                                              \
392                 char cmd[1024];                                         \
393                 int n;                                                  \
394                 n = snprintf(cmd, sizeof(cmd), fmt, ##__VA_ARGS__);     \
395                 if (n < sizeof(cmd) && sizeof(cmd) - n >= sizeof(ALL_TO_DEV_NULL)) \
396                         strcat(cmd, ALL_TO_DEV_NULL);                   \
397                 system(cmd);                                            \
398         })

See ALL_TO_DEV_NULL here.

> 
> >
> >>> +       SYS(fail, "ip netns exec %s ./pm_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
> >>>
> >>>     return 0;
> >>> fail:
> >>> @@ -371,16 +372,8 @@ static int endpoint_init(char *flags)
> >>>
> >>> static int _ss_search(char *src, char *dst, char *port, char *keyword)
> >>> {
> >>> -   char cmd[128];
> >>> -   int n;
> >>> -
> >>> -   n = snprintf(cmd, sizeof(cmd),
> >>> -            "ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> >>> -            NS_TEST, src, dst, port, PORT_1, keyword);
> >>> -   if (n < 0 || n >= sizeof(cmd))
> >>> -       return -1;
> >>> -
> >>> -   return system(cmd);
> >>> +   return SYS_NOFAIL("ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
> >>> +             NS_TEST, src, dst, port, PORT_1, keyword);
> >>
> >> If "ip mptcp" is not supported, I guess "ss -M" will not be supported as well, no?
> >>
> >> Do we need -M here for these tests?
> >
> > No need to do this yet until we actually encounter it.
> 
> "-e" is not needed as well I think. Don't hesitate to remove it as well.

"-e" is needed by has_bytes_sent:

458 static int has_bytes_sent(char *dst)
459 {
460         return _ss_search(ADDR_1, dst, "sport", "bytes_sent:");
461 }

BPF sched tests fail if remove it.

Regards,
Geliang
