Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5A1FA1
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712380406; cv=none; b=Y3rSRQ66rKH+36wSGyZUi7q1QNq24eDzd/RjEGvFlObopfg+j56Yokl9yNKWtnl8LwGRYkNPQlxEAMFQRSpY5e+91qVGyhVc3JRDFQQoNtYmdaBtdTEd18xdmrB0C+b5kQnocfp/lmf/3OhQBn+hJebBqfGzNXblT8j4zLNGlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712380406; c=relaxed/simple;
	bh=7+n9aJcKDlHw2sVNzL1Bw1mjWkBGoTZBc2R6s4SgWR0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mP9Eqp5LfrFfO4XhrLu0ygzmMeoc5PR50GeZykhOqT5R7MnWtbGf+y57R+DJ20EiLIi3P4HJrT02TaRucKXJXM/dP/7rEt5jWr94n2K41W1HEmK3SLI5LtW0i7PinzTAptfN54npAvnw4JMgXZ3odVXPXVUgAXgJ408yekuRBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlXsVDd4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlXsVDd4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3821BC433F1;
	Sat,  6 Apr 2024 05:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712380406;
	bh=7+n9aJcKDlHw2sVNzL1Bw1mjWkBGoTZBc2R6s4SgWR0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=HlXsVDd40PUoXi5q3824i1J3/DW3QdHPJFNyuIsBQUe2jmFGVknMtclcfSNJQ3DXG
	 ssWZBEqLhMxhiGz1ouYB0Tip8PF6IC6Hi4HrPkN51emjhcajeAoRwnAPikbm0zTu/a
	 uDKaShjgkahuKY7VeDpdE17TUrjm8bml+5xWaV/HSxmxiEwgSjp6iQdETX0ai4jilY
	 gUCKgUmsOi9+N771Jp0Y+o8zerQwnO0pLmw8YQA+JKRPKNrTKe7qdc1c8K2LNU4pTh
	 L4Brw8XI75qjlSTuejG2K3Ngpznju43tkTOlE3ZP3r8enStSgj6hpBIxfL2PF/KRjO
	 r/1GvHiJ2wf5A==
Date: Sat, 6 Apr 2024 07:13:22 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>
Message-ID: <dac737b6-ec30-4edf-a3f0-8471d93c54a1@kernel.org>
In-Reply-To: <5900b56b-6654-b7e0-2fd4-88abeaeb52c1@kernel.org>
References: <0979b4df687213cfaccaca526ad74958db8f67cf.1712363381.git.tanggeliang@kylinos.cn> <5900b56b-6654-b7e0-2fd4-88abeaeb52c1@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "mptcp: add last time fields in
 mptcp_info"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <dac737b6-ec30-4edf-a3f0-8471d93c54a1@kernel.org>

Hi Mat,

6 Apr 2024 02:48:20 Mat Martineau <martineau@kernel.org>:

> On Sat, 6 Apr 2024, Geliang Tang wrote:
>
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Reload now =3D jiffies32 as Eric suggested.
>>
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>> ---
>> net/mptcp/sockopt.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 2ec2fdf9f4af..17223da5436d 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -944,6 +944,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, st=
ruct mptcp_info *info)
>> =C2=A0=C2=A0=C2=A0 info->mptcpi_bytes_retrans =3D msk->bytes_retrans;
>> =C2=A0=C2=A0=C2=A0 info->mptcpi_subflows_total =3D info->mptcpi_subflows=
 +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __mptcp_has_initial_subflow(m=
sk);
>> +=C2=A0=C2=A0 now =3D tcp_jiffies32; /* reload it, lock_sock_fast can sl=
eep and be quite slow */
>> =C2=A0=C2=A0=C2=A0 info->mptcpi_last_data_sent =3D jiffies_to_msecs(now =
- msk->last_data_sent);
>> =C2=A0=C2=A0=C2=A0 info->mptcpi_last_data_recv =3D jiffies_to_msecs(now =
- msk->last_data_recv);
>> =C2=A0=C2=A0=C2=A0 unlock_sock_fast(sk, slow);
>
> Geliang and Matthieu -
>
> I'd like to minimize the time difference between the assigments for all t=
he last time fields. For example, if the last_ack_recv is copied before the=
 socket lock is acquired, the value in the info struct could become stale w=
hile waiting for the lock and not match up well with last_data_sent.
>
> Could instead move the entire mptcp_data_lock()/mptcp_data_unlock() block=
 inside the socket lock critical section. Then, if 'now' is assigned with b=
oth locks acquired there should not be significant delays between them.

Yes, that's what I had in mind when I replied to Eric.

Because the data lock is a spin lock, maybe we don't need to reload it ther=
e if this block is moved after the sk lock? So all the counters would be sy=
nced.

Cheers,
Matt
