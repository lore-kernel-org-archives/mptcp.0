Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82031AB506
	for <mptcp@lists.linux.dev>; Thu,  3 Oct 2024 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990982; cv=none; b=TDsrBwffhZRhtu620xanoae/CcyIJ5NXrmByrQbbH+1NC43ZD+pfI81Vt5uMrS2hTrtkQXjlTWy1issW1geR0E2c4nNoNcT2HrsQvhRKEpsZx2SU4CM2MB9ivUqkcZV5bwnykXa5/4wYRVxuAYqXqu/+Qol1DkQkoTt/pDgIj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990982; c=relaxed/simple;
	bh=RPt4+DrRj1Xrgj7o9BZkYQrRwXXH/7zDWE10hEKtZFs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=h5ElF0W/pJ88/Oua8uaduonJ/Hl8depG49IVFfaoUmrL/EtiU5feadpkHm22wEYhJrPTsAnOLOIuwsCFz8+1AgcDS1PxgKY1ftjqgfrltQWtMLT+xIbmA3jCZKM9IsP+wkUQyTrn0G34Yifwk/Mxxrf8WCellV8SSvmXlYDXW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IppGkn5A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IppGkn5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B1BC4CEC5;
	Thu,  3 Oct 2024 21:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727990981;
	bh=RPt4+DrRj1Xrgj7o9BZkYQrRwXXH/7zDWE10hEKtZFs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IppGkn5Ay3N2jFkb2dW/iNbpNVOHBAlfphgqU9gUfL9OdLuHBKhIUPnTDKW9Zt3rG
	 3nrKHSYq7ihwryiFrj+OO68NTudt6mlzQV4W56Ic8Bt+YYysPT1CEqnZRlCNaMwGER
	 GvO6EFeqyZZbUUu4yaXrRIaMSlldhLOGh5Rsv/JGfYaTD9TVuVSO+H/ZdUlbxxOZ/o
	 YNYM7elFnkQeCMaX92jtrh2ewtUn0xHXcK8mCsAfv2g6YzSVGmlUxbwlxPZ+iwwaAL
	 G6jRPSVujNp9eYRh4JaM6lGU5QWTCo3+pvmfM7gvOUQXC8Uuqe+LKZBbx1hzsmuI7/
	 zGokCl2JU85PQ==
Date: Thu, 3 Oct 2024 23:29:35 +0200 (GMT+02:00)
From: Matthieu Baerts <matttbe@kernel.org>
To: Christoph Paasch <cpaasch@apple.com>
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Craig Taylor <cmtaylor@apple.com>
Message-ID: <d22ff620-d244-4ce1-8b2d-6ed6c8aefc35@kernel.org>
In-Reply-To: <1393FB5B-A830-48C8-9E56-2C9DDA122F83@apple.com>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org> <1393FB5B-A830-48C8-9E56-2C9DDA122F83@apple.com>
Subject: Re: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped
 after 1st data
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <d22ff620-d244-4ce1-8b2d-6ed6c8aefc35@kernel.org>

Hi Christoph,

3 Oct 2024 23:14:07 Christoph Paasch <cpaasch@apple.com>:

> +Craig from Apple
>
> Hello,
>
>> On Oct 3, 2024, at 11:43=E2=80=AFAM, Matthieu Baerts (NGI0) <matttbe@ker=
nel.org> wrote:
>>
>> As reported by Christoph [1], before this patch, an MPTCP connection was
>> wrongly reset when a host received a first data packet with MPTCP
>> options after the 3wHS, but got the next ones without.
>>
>> According to the MPTCP v1 specs [2], a fallback should happen in this
>> case, because the host didn't receive a DATA_ACK from the other peer,
>> nor receive data for more than the initial window which implies a
>> DATA_ACK being received by the other peer.
>>
>> The patch here re-uses the same logic as the one used in other places:
>> by looking at allow_infinite_fallback, which is disabled at the creation
>> of an additional subflow. It's not looking at the first DATA_ACK (or
>> implying one received from the other side) as suggested by the RFC, but
>> it is in continuation with what was already done, which is safer, and it
>> fixes the reported issue. The next step, looking at this first DATA_ACK,
>> is tracked in [4].
>>
>> This patch has been validated using the following Packetdrill script:
>>
>> =C2=A0 0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
>> +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>> +0 bind(3, ..., ...) =3D 0
>> +0 listen(3, 1) =3D 0
>>
>> // 3WHS is OK
>> +0.0 < S=C2=A0 0:0(0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 win 65535=C2=
=A0 <mss 1460, sackOK, nop, nop, nop, wscale 6, mpcapable v1 flags[flag_h] =
nokey>
>> +0.0 > S. 0:0(0) ack 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1=
 flags[flag_h] key[skey]>
>> +0.1 <=C2=A0 . 1:1(0) ack 1 win 2048=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 <mpcapable v1 flags[flag_h] key[ckey=3D2, skey]>
>> +0 accept(3, ..., ...) =3D 4
>>
>> // Data from the client with valid MPTCP options (no DATA_ACK: normal)
>> +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] key[skey=
, ckey] mpcdatalen 500, nop, nop>
>> // From here, the MPTCP options will be dropped by a middlebox
>> +0.0 >=C2=A0 . 1:1(0)=C2=A0=C2=A0=C2=A0=C2=A0 ack 501=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 <dss dack8=3D501 dll=3D0 nocs>
>>
>> +0.1 read(4, ..., 500) =3D 500
>> +0=C2=A0=C2=A0 write(4, ..., 100) =3D 100
>>
>> // The server replies with data, still thinking MPTCP is being used
>> +0.0 > P. 1:101(100)=C2=A0=C2=A0 ack 501=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 <dss dack8=3D501 dsn8=3D1 ssn=3D1 dll=3D100 nocs, =
nop, nop>
>> // But the client already did a fallback to TCP, because the two previou=
s packets have been received without MPTCP options
>> +0.1 <=C2=A0 . 501:501(0)=C2=A0=C2=A0 ack 101 win 2048
>>
>> +0.0 < P. 501:601(100) ack 101 win 2048
>> // The server should fallback to TCP, not reset: it didn't get a DATA_AC=
K, nor data for more than the initial window
>> +0.0 >=C2=A0 . 101:101(0)=C2=A0=C2=A0 ack 601
>>
>> Note that this script requires Packetdrill with MPTCP support, see [3].
>>
>> Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on mapping =
errors")
>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
>> Link: https://github.com/multipath-tcp/packetdrill [3]
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Cc: Davide Caratti <dcaratti@redhat.com>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>
> awesome! Is this ready to be tested or does this need to go through the C=
I,=E2=80=A6 first ?

To me, it looks ready to be tested, and reviewed :)

It already went through the CI, everything was OK there:

https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11167965968

Cheers,
Matt
