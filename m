Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC617583
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715505283; cv=none; b=bqyk1/NauMv16ErE1KzcY8opWtvR9PV5AKamNtN1/NmA9nlIp8Fff5rhqwxDkCr25YmbeVpX+j+7LIYyh7+dh641pq1QTk9yLhYCjzj9ESrnn+LCRTVOI+c6fjkj7gYVXUJiA2C/embxZTokhMaBDqLTWz9qbaPE2fWD3W1+c+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715505283; c=relaxed/simple;
	bh=bYkQ0JMePykCFWlRILY+tM/FV5ZXeeGLdDeygJ1n2x0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=r/ZfpFSQv0c4HpIEZRzbn3/lOmDkdiFsurLjnIKy2IuUTDiOhs3/xcFKEbP8yel+J87JgWl6lK5twLOmJpCJqQ6EUQgHHoDfbj7owd48F61KWdxZWg9y2PKEvxTarIEd4sbHtWSJ4kTgQMDjNaUgesYrzqyl0giWCEsfVOrKihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4lfUKna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4lfUKna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68B4C116B1;
	Sun, 12 May 2024 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715505282;
	bh=bYkQ0JMePykCFWlRILY+tM/FV5ZXeeGLdDeygJ1n2x0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=U4lfUKnaEzclL3lNzK/gSI1Ik1gc3N6LGZ8nMF0mPmpm2klgCBHw1Om4s9NI8su2A
	 j/sofW0mgs6B5tW1wXpdbqi1E4lJeUePg+4FQY7xLJ+Enc2ZeNYDFeyRRr0YGvAs0f
	 NDB2fvTWFoXry9o1Bf86I9YJRz6zCmb8Jr6Peo36Z/sj3YTbRvFuewvMlkKktl8fkn
	 Sxuy0YKfM3uE3+ypx0j2BrmLVYiSG/Ujfy7d2JfSirYMePabNjpkhykoJxHUuDxgOw
	 VdtMVdOnPnGydbpO/tT1o/L4js0ELkHY6vd8QSG7H9MdM/m2ECN5unwILgYp1RciHh
	 5F6mbodjUekKA==
Date: Sun, 12 May 2024 11:14:38 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <551a0206-2e72-45a6-8807-3d5fd27ef0a8@kernel.org>
In-Reply-To: <Zj_8dK-hT2JV-1eB@T480>
References: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn> <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org> <Zj_8dK-hT2JV-1eB@T480>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <551a0206-2e72-45a6-8807-3d5fd27ef0a8@kernel.org>

Hi Geliang,

12 May 2024 01:17:13 Geliang Tang <geliang@kernel.org>:
> On Sat, May 11, 2024 at 03:50:29PM +0200, Matthieu Baerts wrote:
>> 11 May 2024 12:42:08 Geliang Tang <geliang@kernel.org>:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>

(...)

>>> @@ -0,0 +1 @@
>>> +../net/mptcp/pm_nl_ctl.c
>>> \ No newline at end of file
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
>>> index 793b4b9c2bd2..9c6d1e4f6f35 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> @@ -362,7 +362,8 @@ static int endpoint_init(char *flags)
>>> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s link set dev veth1 up", NS_TES=
T);
>>> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_=
TEST, ADDR_2);
>>> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s link set dev veth2 up", NS_TES=
T);
>>> -=C2=A0=C2=A0 SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST,=
 ADDR_2, flags);
>>> +=C2=A0=C2=A0 if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", NS_=
TEST, ADDR_2, flags))
>>
>> It is maybe better to only use mptcp_pm_nl_ctl here: to maintain one way=
 here, our CI will do the same as what the BPF one will do, and we avoid er=
rors printed in stderr if "ip mptcp" is not supported.
>>
>
> No, I prefer this one. "ip mptcp" should be used here since it's
> the normal way to set mptcp. pm_nl_ctl is just a work-around for it.
>
> No error printed in stderr if "ip mptcp" is not supported since
> SYS_NOFAIL is used here, not SYS. I have tested this case already.

SYS_NOFAIL doesn't redirect stderr to /dev/null, does it?
If "ip mptcp" is not supported and a fatal error happens, will you not see
in the logs "ip mptcp is not supported" as well, creating confusions?

I would also prefer to use "ip mptcp" if available, but my main reason to
use only the workaround, is: if we change the syntax of pm_nl_ctl, not
realising we have to modify the code here as well, our CI will not
complain, but BPF CI will later, likely when validating something else.
We want our CI to catch such issues before upstreaming patches.

Why not adding a comment instead?

=C2=A0 /* Equivalent of: "ip -net %s mptcp endpoint add %s %s" */

So people interested in knowing how to do that the "proper" way will see
what to do, no?

>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYS(fail, "ip netns exec %s ./pm_=
nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
>>>
>>> =C2=A0=C2=A0=C2=A0 return 0;
>>> fail:
>>> @@ -371,16 +372,8 @@ static int endpoint_init(char *flags)
>>>
>>> static int _ss_search(char *src, char *dst, char *port, char *keyword)
>>> {
>>> -=C2=A0=C2=A0 char cmd[128];
>>> -=C2=A0=C2=A0 int n;
>>> -
>>> -=C2=A0=C2=A0 n =3D snprintf(cmd, sizeof(cmd),
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "ip=
 netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NS_=
TEST, src, dst, port, PORT_1, keyword);
>>> -=C2=A0=C2=A0 if (n < 0 || n >=3D sizeof(cmd))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>> -
>>> -=C2=A0=C2=A0 return system(cmd);
>>> +=C2=A0=C2=A0 return SYS_NOFAIL("ip netns exec %s ss -Menita src %s dst=
 %s %s %d | grep -q '%s'",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 NS_TEST, src, dst, port, PORT_1, keyword);
>>
>> If "ip mptcp" is not supported, I guess "ss -M" will not be supported as=
 well, no?
>>
>> Do we need -M here for these tests?
>
> No need to do this yet until we actually encounter it.

"-e" is not needed as well I think. Don't hesitate to remove it as well.
