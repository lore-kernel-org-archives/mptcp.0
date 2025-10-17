Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8021130F53A
	for <mptcp@lists.linux.dev>; Fri, 17 Oct 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682123; cv=none; b=n6U8XhdKV/z2RX3o1Vq5RJJKXVK9BbcbFSeM3WVufJXhtfKKYIcTQOTbJrBluD4BQgFViomucikjT6GUWrojNtLASxtMDeSYRgH6MWNmx2COXsDWQEi1wyO4FSp2uMdB+L1I/SsCHKXwYO2WWLmFb8i97ttY8bgnesSpcjsRyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682123; c=relaxed/simple;
	bh=ZeNM1uDi4qGIxQFCTQRE4D7dco0UK5VMW9DO/EIyyUc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Y2bSYPeFUYCZJGL579XPvCYw/VWgCXCi/grHVuos1V1ko+5EwEJufZ6w0uFX0LzlUDvnBLmYJHlV+0Gf6nl9YsXHB6rJ4bf62NbEmYkqw5JdK5l15o1bzIxm2HSA0Qw59ouMs7C+MX08khAndcHIKw0XnR3wz4oiXITbuA9IGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEkwEp8z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEkwEp8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825D5C4CEE7;
	Fri, 17 Oct 2025 06:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760682123;
	bh=ZeNM1uDi4qGIxQFCTQRE4D7dco0UK5VMW9DO/EIyyUc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rEkwEp8zvOscXi1RsnC+oldwSMThklDfe4gBEzpU4OthvfJ2jT+/wg5VID5ps4NrB
	 b/dOGLrGBTzkym3Y3LrETYT/SIkPaBTj5uY1iUy/HKekPTQLP8mWew2eDnhqs3ZBJ9
	 i1C72t4iDM/AXe/7NQ1t0g3R9kf/eLlhGC9js3P1Zf2Jl3h4pckyL11KBOfYa4Anm2
	 oeKwpUEE0zBXqdOUQK7o/cpHMQ9E84mw8Ux+y+piGLBjef6jTpct/iuMgqayc2p7j1
	 7Jv3zVppA+hxTJq2EcnosuG7xt+xJa8Par16cjeLRea0ayWIkKHWiktCkaIp0wpe5b
	 k8O3ZxvPpTLJw==
Date: Fri, 17 Oct 2025 08:21:58 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Message-ID: <bfbf803d-1431-4a16-9514-724000f3ffb1@kernel.org>
In-Reply-To: <96221a4b1a5e83a82d6c2293f4536aece7ff755e.camel@kernel.org>
References: <20251008-c-flag-add-addr-delay-v1-0-c624eb3bf10d@kernel.org> <20251008-c-flag-add-addr-delay-v1-1-c624eb3bf10d@kernel.org> <96221a4b1a5e83a82d6c2293f4536aece7ff755e.camel@kernel.org>
Subject: Re: [PATCH mptcp-net 1/7] mptcp: pm: in-kernel: C-flag: handle late
 ADD_ADDR
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <bfbf803d-1431-4a16-9514-724000f3ffb1@kernel.org>

Hi Geliang,

Thank you for the review!

17 Oct 2025 08:11:37 Geliang Tang <geliang@kernel.org>:

> Hi Matt,
>
> On Wed, 2025-10-08 at 15:59 +0200, Matthieu Baerts (NGI0) wrote:
>> The special C-flag case expects the ADD_ADDR to be received when
>> switching to 'fully-established'. But for various reasons, the
>> ADD_ADDR
>> could be sent after the "4th ACK", and the special case doesn't work.
>>
>> On NIPA, the new test validating this special case for the C-flag
>> failed
>> a few times, e.g.
>>
>> =C2=A0 102 default limits, server deny join id 0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn rx=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [FAIL] got 0 JOIN[s] syn rx expected 2
>>
>> =C2=A0 Server ns stats
>> =C2=A0 (...)
>> =C2=A0 MPTcpExtAddAddrTx=C2=A0 1
>> =C2=A0 MPTcpExtEchoAdd=C2=A0=C2=A0=C2=A0 1
>>
>> =C2=A0 Client ns stats
>> =C2=A0 (...)
>> =C2=A0 MPTcpExtAddAddr=C2=A0=C2=A0=C2=A0 1
>> =C2=A0 MPTcpExtEchoAddTx=C2=A0 1
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 synack rx=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [FAIL] got 0 J=
OIN[s] synack rx
>> expected 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ack rx=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [FAIL] got 0 JOIN[s] ack rx expected 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 join Rx=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [FAIL=
] see above
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syn tx=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 [FAIL] got 0 JOIN[s] syn tx expected 2
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 join Tx=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [FAIL=
] see above
>>
>> I had a suspicion about what the issue could be: the ADD_ADDR might
>> have
>> been received after the switch to the 'fully-established' state. The
>> issue was not easy to reproduce. The packet capture shown that the
>
> It was indeed not easy to reproduce, but after spending a lot of time,
> I finally managed to reproduce it and also verified that this patch
> indeed works.

Thanks!

>> ADD_ADDR can indeed be sent with a delay, and the client would not
>> try
>> to establish subflows to it as expected.
>>
>> A simple fix is not to mark the endpoints as 'used' in the C-flag
>> case,
>> when looking at creating subflows to the remote initial IP address
>> and
>> port. In this case, there is no need to try.
>>
>> Note: newly added fullmesh endpoints will still continue to be used
>> as
>> expected, thanks to the conditions behind
>> mptcp_pm_add_addr_c_flag_case.
>>
>> Fixes: 4b1ff850e0c1 ("mptcp: pm: in-kernel: usable client side with
>> C-flag")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> =C2=A0net/mptcp/pm_kernel.c | 6 ++++++
>> =C2=A01 file changed, 6 insertions(+)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index da431da16ae0..df2bc36593d0 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -370,6 +370,10 @@ static void
>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>> =C2=A0=C2=A0=C2=A0 }
>> =C2=A0
>> =C2=A0subflow:
>> +=C2=A0=C2=A0 /* No need to try establishing subflows to remote id0 if n=
ot
>> allowed */
>> +=C2=A0=C2=A0 if (mptcp_pm_add_addr_c_flag_case(msk))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto exit;
>> +
>
> I think it would be better to place this c_flag check inside the while
> loop below.
>
>> =C2=A0=C2=A0=C2=A0 /* check if should create a new subflow */
>> =C2=A0=C2=A0=C2=A0 while (msk->pm.local_addr_used < endp_subflow_max &&
>> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msk->pm.extra_su=
bflows < limit_extra_subflows) {
>> @@ -401,6 +405,8 @@ static void
>> mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mpt=
cp_subflow_connect(sk, &local,
>> &addrs[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock_bh(&msk->pm.lock);
>> =C2=A0=C2=A0=C2=A0 }
>> +
>> +exit:
>
> This way, we won't need to add an exit label and can simply use a
> break. Something like this:
>
> subflow:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* check if should create a ne=
w subflow */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (msk->pm.local_addr_used=
 < endp_subflow_max &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 msk->pm.extra_subflows < limit_extra_subflows) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct mptcp_addr_info addrs[MPTCP_PM_ADDR_MAX];
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bool fullmesh;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 int i, nr;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* No need to try establishing subflows to remote
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 id0 if not allowed */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp_pm_add_addr_c_flag_case(msk))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;

I'm not convinced: that means these conditions will be checked for each
local address, for each iteration here, while the result will be always the
same.

Here it sounds better to me to skip the selection before starting, if there
is no need to do that.

Cheers,
Matt

>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (signal_and_subflow)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal_a=
nd_subflow =3D false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else if (!select_local_address(pernet, msk, &local))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>
> WDYT?
>
> Thanks,
> -Geliang
>
>> =C2=A0=C2=A0=C2=A0 mptcp_pm_nl_check_work_pending(msk);
>> =C2=A0}
>> =C2=A0
>>

