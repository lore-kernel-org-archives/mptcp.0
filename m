Received: from rn-mx04.apple.com (rn-mx04.apple.com [17.132.108.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A293C4CDEC
	for <mptcp@lists.linux.dev>; Fri,  4 Oct 2024 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.132.108.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061057; cv=none; b=kbGq2jE1uGdnM7/DTwXV5t2mlFtRC+jFBWn3UwvlY85nGr0yqigY87i8OgDNOPaFw9SRFhc8V7vmb5oIKTG1yFm0CWvBJr7Hr7RMahguA5B9uBPv+ofTuVJYqElCbeowVVnGjBn4c4AD+OBYpOchsjCuWQDX5RhrwVYMbnYrmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061057; c=relaxed/simple;
	bh=U0mScmhh28h+3vONvV2rNTsgyrE0YGnGK1S0SbPITzo=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=hSx6OL5fwF/AXfaHxilUwoBuLmyJr4SJWcUQAU3NwqmD4uRFBniMTQ+GZoY4ja4l5/chuQHPo4mljHfay1xe7ec6K7NuvCkrI+m4eVVfLXDbUTNExBp0XHoNIiOk5lUeovB7Jbls8Lzvlgv0PtVYUkfKEy0G8bjRCKTBJPZoQ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=IlHtaJdW; arc=none smtp.client-ip=17.132.108.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="IlHtaJdW"
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by mr55p01nt-mxp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SKU0TKN5CFW9710@mr55p01nt-mxp04.apple.com> for
 mptcp@lists.linux.dev; Fri, 04 Oct 2024 16:57:35 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=b3w8cK9+VpNGU+zDuPsciQk8Ryv5sU4jk7JunLrNXM8=;
 b=IlHtaJdWO3lgC3kTOlrca706coAtbv5/yrnRJ8vFIvX2Jk1Oxbb6/lNrW2I5h6+yGL/A
 uA/cGHif9b5OWCCOxHtph2O2LzEdv+A3BLp7KdwJS78iyGu4lzisLI6B17y/tJe9z77y
 47gHWtioLWAnMFh29pua7oO8RBp7seGtverbH2J4q5NfDdCFvh/1D2fwx/89AN+6YCjS
 J2vz9EBG9BSc7rnkbCVWZdziO5Vp5qBNZX/hpurgEif9K8eJCdq+KaomLPHLBv+2ckTW
 dVRzUOp28EZyyjUre8Mt55lqUBYYLDw3sxR4NDVWSHBfguhOMFrGQQ2JiLwHRhcTv8Yw iw==
Received: from mr55p01nt-mmpp07.apple.com
 (mr55p01nt-mmpp07.apple.com [10.170.185.196])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SKU00REVCFY7AP0@rn-mailsvcp-mta-lapp04.rno.apple.com>;
 Fri, 04 Oct 2024 09:57:34 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp07.apple.com by
 mr55p01nt-mmpp07.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SKU02P00C6SL300@mr55p01nt-mmpp07.apple.com>; Fri,
 04 Oct 2024 16:57:34 +0000 (GMT)
X-Va-A:
X-Va-T-CD: 4e447c9e81b145b613229683db9d49f9
X-Va-E-CD: e6baaedccdb0fc0c1d69103afc7342d3
X-Va-R-CD: 1889d4c959161808f881ae2f19dda8d8
X-Va-ID: fb41d6e5-ebca-4e92-9f40-b1aee5fd7537
X-Va-CD: 0
X-V-A:
X-V-T-CD: 4e447c9e81b145b613229683db9d49f9
X-V-E-CD: e6baaedccdb0fc0c1d69103afc7342d3
X-V-R-CD: 1889d4c959161808f881ae2f19dda8d8
X-V-ID: 5fe9360f-f667-4147-9bf3-fe63a599500e
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_14,2024-10-04_01,2024-09-30_01
Received: from smtpclient.apple ([17.192.155.171])
 by mr55p01nt-mmpp07.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SKU0320UCFY3B00@mr55p01nt-mmpp07.apple.com>; Fri,
 04 Oct 2024 16:57:34 +0000 (GMT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3826.200.55\))
Subject: Re: [PATCH mptcp-net] mptcp: fallback if MPTCP opts are dropped after
 1st data
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <d22ff620-d244-4ce1-8b2d-6ed6c8aefc35@kernel.org>
Date: Fri, 04 Oct 2024 09:57:23 -0700
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>
Content-transfer-encoding: quoted-printable
Message-id: <49803E32-C2F2-42A1-AF5F-2C82E49D792C@apple.com>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
 <1393FB5B-A830-48C8-9E56-2C9DDA122F83@apple.com>
 <d22ff620-d244-4ce1-8b2d-6ed6c8aefc35@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, Craig Taylor <cmtaylor@apple.com>
X-Mailer: Apple Mail (2.3826.200.55)



> On Oct 3, 2024, at 2:29=E2=80=AFPM, Matthieu Baerts =
<matttbe@kernel.org> wrote:
>=20
> Hi Christoph,
>=20
> 3 Oct 2024 23:14:07 Christoph Paasch <cpaasch@apple.com>:
>=20
>> +Craig from Apple
>>=20
>> Hello,
>>=20
>>> On Oct 3, 2024, at 11:43=E2=80=AFAM, Matthieu Baerts (NGI0) =
<matttbe@kernel.org> wrote:
>>>=20
>>> As reported by Christoph [1], before this patch, an MPTCP connection =
was
>>> wrongly reset when a host received a first data packet with MPTCP
>>> options after the 3wHS, but got the next ones without.
>>>=20
>>> According to the MPTCP v1 specs [2], a fallback should happen in =
this
>>> case, because the host didn't receive a DATA_ACK from the other =
peer,
>>> nor receive data for more than the initial window which implies a
>>> DATA_ACK being received by the other peer.
>>>=20
>>> The patch here re-uses the same logic as the one used in other =
places:
>>> by looking at allow_infinite_fallback, which is disabled at the =
creation
>>> of an additional subflow. It's not looking at the first DATA_ACK (or
>>> implying one received from the other side) as suggested by the RFC, =
but
>>> it is in continuation with what was already done, which is safer, =
and it
>>> fixes the reported issue. The next step, looking at this first =
DATA_ACK,
>>> is tracked in [4].
>>>=20
>>> This patch has been validated using the following Packetdrill =
script:
>>>=20
>>>   0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
>>> +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>>> +0 bind(3, ..., ...) =3D 0
>>> +0 listen(3, 1) =3D 0
>>>=20
>>> // 3WHS is OK
>>> +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, =
wscale 6, mpcapable v1 flags[flag_h] nokey>
>>> +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, =
wscale 8, mpcapable v1 flags[flag_h] key[skey]>
>>> +0.1 <  . 1:1(0) ack 1 win 2048                                      =
        <mpcapable v1 flags[flag_h] key[ckey=3D2, skey]>
>>> +0 accept(3, ..., ...) =3D 4
>>>=20
>>> // Data from the client with valid MPTCP options (no DATA_ACK: =
normal)
>>> +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] =
key[skey, ckey] mpcdatalen 500, nop, nop>
>>> // =46rom here, the MPTCP options will be dropped by a middlebox
>>> +0.0 >  . 1:1(0)     ack 501        <dss dack8=3D501 dll=3D0 nocs>
>>>=20
>>> +0.1 read(4, ..., 500) =3D 500
>>> +0   write(4, ..., 100) =3D 100
>>>=20
>>> // The server replies with data, still thinking MPTCP is being used
>>> +0.0 > P. 1:101(100)   ack 501          <dss dack8=3D501 dsn8=3D1 =
ssn=3D1 dll=3D100 nocs, nop, nop>
>>> // But the client already did a fallback to TCP, because the two =
previous packets have been received without MPTCP options
>>> +0.1 <  . 501:501(0)   ack 101 win 2048
>>>=20
>>> +0.0 < P. 501:601(100) ack 101 win 2048
>>> // The server should fallback to TCP, not reset: it didn't get a =
DATA_ACK, nor data for more than the initial window
>>> +0.0 >  . 101:101(0)   ack 601
>>>=20
>>> Note that this script requires Packetdrill with MPTCP support, see =
[3].
>>>=20
>>> Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on =
mapping errors")
>>> Reported-by: Christoph Paasch <cpaasch@apple.com>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 =
[1]
>>> Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback =
[2]
>>> Link: https://github.com/multipath-tcp/packetdrill [3]
>>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>> ---
>>> Cc: Davide Caratti <dcaratti@redhat.com>
>>> Cc: Paolo Abeni <pabeni@redhat.com>
>>=20
>> awesome! Is this ready to be tested or does this need to go through =
the CI,=E2=80=A6 first ?
>=20
> To me, it looks ready to be tested, and reviewed :)
>=20
> It already went through the CI, everything was OK there:
>=20
> =
https://github.com/multipath-tcp/mptcp_net-next/actions/runs/11167965968

Thanks! Will get the testing going internally. And I will get back on =
syzkaller one day =F0=9F=98=85


Christoph

>=20
> Cheers,
> Matt

