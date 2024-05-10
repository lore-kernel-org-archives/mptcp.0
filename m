Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34A4F1F2
	for <mptcp@lists.linux.dev>; Fri, 10 May 2024 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372580; cv=none; b=JvyXWr7/DVm+BX2bzF6FGHbN3T1xXK85B0GaOzs+a+YSMD+7uvDD2MT6LFTjo4/DuwWC1QDBnQmBblAWGrchcM2rhoeWVMzxHAMfGA6hTcFCwZz+ChtK2CotCAnwpBkZ+IlX2nUFvQxNF7BfEpm+m2pVpgi5oxAy1hnBMPB4NXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372580; c=relaxed/simple;
	bh=MN8NBbIoa8cZkVmA3uStunwRLd46ADyQXWl65jHpHJI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ra9EvpPClMLyRaWxNnaxHLif9DM+tvCKkJ9UIXFUbgMCo3wtCbgvhLgWrBjLZGQ8bWBBXMB+9LWG0uVV2Hr1LJ4R6Phv++oPcNTtOtg2IF9UGH5dCuwJplv8ZmA2F0J9OoXQKdEYCTKKIryj3l5QwQk65iwYdAs9K16d6opokmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6DzZ+iW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6DzZ+iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB2CC113CC;
	Fri, 10 May 2024 20:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715372580;
	bh=MN8NBbIoa8cZkVmA3uStunwRLd46ADyQXWl65jHpHJI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=s6DzZ+iW6moIF0sHr7ON1D6nYSK0e02OZm6WhD4V0OE/jr26W/vOpdLHlQkWDir44
	 0O5Bl826q7vma3e+E9Dq1EXah6kux/B3NoIWLjGl9iS53mU57x/gT6/EnIBxA+Dp7v
	 Muw6K67dnFMW/nr7O0ajIdkZ7fkU0n/8ylRm61T0hoE38PkGiI04u+dcTf/XVUxFw1
	 EmJK6UEY8KImUAXAh7I87Epny9rQWYWlQG/PxLhZuMV+fdwS5TD1Lb/J+Oe2iSpVnF
	 TDp2w86Y/kqOf3wnVB9vcSA5NiwQdHM/MtH8fnkwgnpm5Zq/LPE9B8AXxVF2/ADJ3Y
	 LBtoBF8Y41Alg==
Date: Fri, 10 May 2024 22:22:57 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <af5fcf12-e9db-4bbe-8704-4bd04ba55e62@kernel.org>
In-Reply-To: <3BFB4741-22F2-4CBC-8FB4-9988DEE7E25A@meta.com>
References: <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-0-4048c2948665@kernel.org> <20240509-upstream-bpf-next-20240506-mptcp-subflow-test-v2-2-4048c2948665@kernel.org> <daf7ed61-e09b-439b-9cdd-b6d9aa003e27@kernel.org> <CAADnVQ+Tp8+Hhy__=uevSZsEetsWYommjhC9SqSfKEeBu51cKA@mail.gmail.com> <3BFB4741-22F2-4CBC-8FB4-9988DEE7E25A@meta.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add mptcp subflow
 subtest
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <af5fcf12-e9db-4bbe-8704-4bd04ba55e62@kernel.org>

Hi Geliang,

(MPTCP list only)

10 May 2024 21:22:16 Manu Bretelle <chantra@meta.com>:

> =EF=BB=BFOn 5/10/24, 7:06 AM, "Alexei Starovoitov" <alexei.starovoitov@gm=
ail.com <mailto:alexei.starovoitov@gmail.com>> wrote:
>
>
> !-------------------------------------------------------------------|
> This Message Is From an External Sender
>
>
> |-------------------------------------------------------------------!
>
>
> On Thu, May 9, 2024 at 11:31 AM Matthieu Baerts <matttbe@kernel.org <mail=
to:matttbe@kernel.org>> wrote:
>>
>> Hello,
>>
>> On 09/05/2024 17:49, Matthieu Baerts (NGI0) wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn <mailto:tanggeliang@kylinos.=
cn>>
>>>
>>> This patch adds a subtest named test_subflow to load and verify the new=
ly
>>> added mptcp subflow example in test_mptcp. Add a helper endpoint_init()
>>> to add a new subflow endpoint. Add another helper ss_search() to verify=
 the
>>> fwmark and congestion values set by mptcp_subflow prog using setsockopt=
s.
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/76 <http=
s://github.com/multipath-tcp/mptcp_net-next/issues/76>
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn <mailto:tanggeliang=
@kylinos.cn>>
>>> Reviewed-by: Mat Martineau <martineau@kernel.org <mailto:martineau@kern=
el.org>>
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org <mailto:mattt=
be@kernel.org>>
>>> ---
>>> tools/testing/selftests/bpf/prog_tests/mptcp.c | 109 ++++++++++++++++++=
+++++++
>>> 1 file changed, 109 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/tes=
ting/selftests/bpf/prog_tests/mptcp.c
>>> index 274d2e033e39..6039b0ff3801 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
>>
>> (...)
>>
>>> @@ -340,10 +344,115 @@ static void test_mptcpify(void)
>>> close(cgroup_fd);
>>> }
>>>
>>> +static int endpoint_init(char *flags)
>>> +{
>>> + SYS(fail, "ip -net %s link add veth1 type veth peer name veth2", NS_T=
EST);
>>> + SYS(fail, "ip -net %s addr add %s/24 dev veth1", NS_TEST, ADDR_1);
>>> + SYS(fail, "ip -net %s link set dev veth1 up", NS_TEST);
>>> + SYS(fail, "ip -net %s addr add %s/24 dev veth2", NS_TEST, ADDR_2);
>>> + SYS(fail, "ip -net %s link set dev veth2 up", NS_TEST);
>>> + SYS(fail, "ip -net %s mptcp endpoint add %s %s", NS_TEST, ADDR_2, fla=
gs);
>>
>> I just noticed that this command is failing on the BPF CI:
>>
>> https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=3D7009 =
<https://github.com/kernel-patches/bpf/actions/runs/9020020315?pr=3D7009>
>>
>> Is it possible that an old version of IPRoute2 is installed?
>> 'ip mptcp' is supported since v5.8.0 (from 2020).
>>
>> It looks like Ubuntu Focal 20.04 is being used, which has the v5.5.0. Do
>> we then need to find another way to set the MPTCP endpoints?
>
>
>
>
> Manu, any idea?
>
> // retrying plain text format.... please outlook, please, make this happe=
n!
>
> Indeed, this is running Ubuntu 20.04. I am planning to eventually update =
to 22.04 (which has iproute 5.15),
> But I don=E2=80=99t have a good ETA to give other than this is not going =
to be in the coming month.
>
> It does not seem that iproute provides an easy way to check its version, =
and the version returned by the container is:
>
> root@081a02e57175:/actions-runner# ip --json -V
> ip utility, iproute2-ss200127
> root@081a02e57175:/actions-runner# dpkg -l iproute2
> Desired=3DUnknown/Install/Remove/Purge/Hold
> | Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Tr=
ig-pend
> |/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
> ||/ Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Vers=
ion=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Architecture Description
> +++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> ii=C2=A0 iproute2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.5.0-1ubuntu1 amd6=
4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 networking and traffic control =
tools
>
>
> How complicated is it to set MPTCP directly using netlink following https=
://github.com/iproute2/iproute2/blob/397383a30c3b0e3ff551042b6654898a0872b8=
3e/ip/ipmptcp.c#L573 ?
> Seems tools/testing/selftests/bpf/netlink_helpers.c could be useful to de=
al with the netlink part. And the former link to find out how to format the=
 message?

Maybe we could use pm_nl_ctl?
Could we add a symlink (mptcp_pm_nl_ctl.c) in progs?

Cheers,
Matth

