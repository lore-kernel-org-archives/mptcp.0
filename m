Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F831CAAF
	for <mptcp@lists.linux.dev>; Sun, 12 May 2024 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715517758; cv=none; b=mSF5Csw7FEbl/eE3faPLVeE2PDYraXKEBOceauIYYQ6EAEBFOhmAYJs24UUBNvGsgI3+KRA2MFKc1CkJyFUKzIjibovte/z0MU64hbU9ax3Lic0P22B37XEoWpsh7NILbLaj9vQvipd5GsCgxFxPiSMhfXOOKooiCKuf9ksQ+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715517758; c=relaxed/simple;
	bh=YWEgrDXE3YSTRoUShXCoIl7SAJx8eUnQD9KE+s+Qs4M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=d2AUCKjZx4liJixRa2V6oVDCeDD1+343BKlaZfK1q9cAaMsKJieY2w39l8Spf91TgvsVVX//JgOrfcsFlsUNGFIm34tVJX+V/0OktK/nQPm5UirfIyUGCjZ1LbzCp950Jt2pa1ZN97DezVRJo7kiBIJBiHzxlItOMR7s6396XyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1GJ9h9T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1GJ9h9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49388C116B1;
	Sun, 12 May 2024 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715517758;
	bh=YWEgrDXE3YSTRoUShXCoIl7SAJx8eUnQD9KE+s+Qs4M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=V1GJ9h9TKBotAReOl1fjoLPSCJjPY0luGdqRFOWANEu7bpy1kfgSU7qzHEs5jXhBe
	 J5VeaRIQeVeNynVZE7qm08im2n04truegTkDSDr2R1dluNljvDihDJ5tr7L6e4XShT
	 Raic7PH1QD838AyXxlMUA1k1xSVuGYm4GTwOuy6JiZ4KMy0/Bn8XUTEc885UMTJ7if
	 QaKEF0XtjyjQWyT6BS4nNcchq/sVQbeUHKDtJxyu59vBMEN9M0qVCqt9FmEN/X6wlt
	 Ne+KnGLVFQIYP41Sqfkeb3qhXDG7MIJ+FqILz5QquBXf47aefuY7PdbXZX3X+Z06ul
	 R3G2XQw2SsrFw==
Date: Sun, 12 May 2024 14:42:34 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
Message-ID: <fd4359ab-f30a-468d-96f4-df43e34a3f81@kernel.org>
In-Reply-To: <ZkCrxpnEvIeYACTQ@T480>
References: <48d243a507dc8b48932df4995ff98e5ec056e733.1715424100.git.tanggeliang@kylinos.cn> <45e113c1-7c33-4380-b85c-56dcb9048a73@kernel.org> <Zj_8dK-hT2JV-1eB@T480> <551a0206-2e72-45a6-8807-3d5fd27ef0a8@kernel.org> <ZkCrxpnEvIeYACTQ@T480>
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
X-Correlation-ID: <fd4359ab-f30a-468d-96f4-df43e34a3f81@kernel.org>

12 May 2024 13:45:15 Geliang Tang <geliang@kernel.org>:

> On Sun, May 12, 2024 at 11:14:38AM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> 12 May 2024 01:17:13 Geliang Tang <geliang@kernel.org>:
>>> On Sat, May 11, 2024 at 03:50:29PM +0200, Matthieu Baerts wrote:
>>>> 11 May 2024 12:42:08 Geliang Tang <geliang@kernel.org>:
>>>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> (...)
>>
>>>>> @@ -0,0 +1 @@
>>>>> +../net/mptcp/pm_nl_ctl.c
>>>>> \ No newline at end of file
>>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/t=
esting/selftests/bpf/prog_tests/mptcp.c
>>>>> index 793b4b9c2bd2..9c6d1e4f6f35 100644
>>>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>>>> @@ -362,7 +362,8 @@ static int endpoint_init(char *flags)
>>>>> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s link set dev veth1 up", NS_T=
EST);
>>>>> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s addr add %s/24 dev veth2", N=
S_TEST, ADDR_2);
>>>>> =C2=A0=C2=A0=C2=A0 SYS(fail, "ip -net %s link set dev veth2 up", NS_T=
EST);
>>>>> -=C2=A0=C2=A0 SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TES=
T, ADDR_2, flags);
>>>>> +=C2=A0=C2=A0 if (SYS_NOFAIL("ip -net %s mptcp endpoint add %s %s", N=
S_TEST, ADDR_2, flags))
>>>>
>>>> It is maybe better to only use mptcp_pm_nl_ctl here: to maintain one w=
ay here, our CI will do the same as what the BPF one will do, and we avoid =
errors printed in stderr if "ip mptcp" is not supported.
>>>>
>>>
>>> No, I prefer this one. "ip mptcp" should be used here since it's
>>> the normal way to set mptcp. pm_nl_ctl is just a work-around for it.
>>>
>>> No error printed in stderr if "ip mptcp" is not supported since
>>> SYS_NOFAIL is used here, not SYS. I have tested this case already.
>>
>> SYS_NOFAIL doesn't redirect stderr to /dev/null, does it?
>> If "ip mptcp" is not supported and a fatal error happens, will you not s=
ee
>> in the logs "ip mptcp is not supported" as well, creating confusions?
>>
>> I would also prefer to use "ip mptcp" if available, but my main reason t=
o
>> use only the workaround, is: if we change the syntax of pm_nl_ctl, not
>> realising we have to modify the code here as well, our CI will not
>> complain, but BPF CI will later, likely when validating something else.
>> We want our CI to catch such issues before upstreaming patches.
>>
>> Why not adding a comment instead?
>>
>> =C2=A0 /* Equivalent of: "ip -net %s mptcp endpoint add %s %s" */
>>
>> So people interested in knowing how to do that the "proper" way will see
>> what to do, no?
>
> SYS_NOFAIL is defined in test_progs.h:
>
> 388 #define ALL_TO_DEV_NULL " >/dev/null 2>&1"
> 389
> 390 #define SYS_NOFAIL(fmt, ...)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> 391=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ({=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> 392=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 char cmd[1024];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> 393=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int n;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> 394=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 n =3D snprintf(cmd, sizeof(cmd), fmt, ##__VA_AR=
GS__);=C2=A0=C2=A0=C2=A0=C2=A0 \
> 395=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (n < sizeof(cmd) && sizeof(cmd) - n >=3D siz=
eof(ALL_TO_DEV_NULL)) \
> 396=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 strcat(cmd, ALL_TO_DEV_NULL);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> 397=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 system(cmd);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 \
> 398=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>
> See ALL_TO_DEV_NULL here.

My bad, I was looking at the code from v6.8.

But still, I think it would be better to avoid sending patches upstream
and potentially breaking stuff on BPF side because we didn't test
the same way as what is done on their side, no?

>
>>
>>>
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SYS(fail, "ip netns exec %s ./p=
m_nl_ctl add %s flags %s", NS_TEST, ADDR_2, flags);
>>>>>
>>>>> =C2=A0=C2=A0=C2=A0 return 0;
>>>>> fail:
>>>>> @@ -371,16 +372,8 @@ static int endpoint_init(char *flags)
>>>>>
>>>>> static int _ss_search(char *src, char *dst, char *port, char *keyword=
)
>>>>> {
>>>>> -=C2=A0=C2=A0 char cmd[128];
>>>>> -=C2=A0=C2=A0 int n;
>>>>> -
>>>>> -=C2=A0=C2=A0 n =3D snprintf(cmd, sizeof(cmd),
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
ip netns exec %s ss -Menita src %s dst %s %s %d | grep -q '%s'",
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N=
S_TEST, src, dst, port, PORT_1, keyword);
>>>>> -=C2=A0=C2=A0 if (n < 0 || n >=3D sizeof(cmd))
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>>> -
>>>>> -=C2=A0=C2=A0 return system(cmd);
>>>>> +=C2=A0=C2=A0 return SYS_NOFAIL("ip netns exec %s ss -Menita src %s d=
st %s %s %d | grep -q '%s'",
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 NS_TEST, src, dst, port, PORT_1, keyword);
>>>>
>>>> If "ip mptcp" is not supported, I guess "ss -M" will not be supported =
as well, no?
>>>>
>>>> Do we need -M here for these tests?
>>>
>>> No need to do this yet until we actually encounter it.
>>
>> "-e" is not needed as well I think. Don't hesitate to remove it as well.
>
> "-e" is needed by has_bytes_sent:
>
> 458 static int has_bytes_sent(char *dst)
> 459 {
> 460=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return _ss_search(ADD=
R_1, dst, "sport", "bytes_sent:");
> 461 }
>
> BPF sched tests fail if remove it.

Thank you for having checked! It looks like ss' man page is missing
this case.

Cheers,
Matt
