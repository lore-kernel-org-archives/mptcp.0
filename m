Received: from rn-mx04.apple.com (rn-mx04.apple.com [17.132.108.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF51AAE38
	for <mptcp@lists.linux.dev>; Thu,  3 Oct 2024 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.132.108.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990047; cv=none; b=eMZAM2Wf7w10KucfdTAIQ7yzFTihElUkQN3/iqiYD14vQMcDSQscKvwRMXmPe1kDY9898ZomtbwpJiko5uDZ9Oyab+nQ6xWHkWI7BWWopdsNgLKRkByftIBhJvoWbVNpF5VcL/7LIesROszZAQ+2dGI/uUxv2syG0AUDP719u7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990047; c=relaxed/simple;
	bh=tjWKO8zJnINfyWToqhtYQ12RH9Og0IEF2Rw6Lux6TgE=;
	h=Content-type:MIME-version:Subject:From:In-reply-to:Date:Cc:
	 Message-id:References:To; b=HdyVPlD/1jJtJ9aUnwAPW5w3o15C9fZLJi7fJB6a17pgnrlMgVwoLl5Yxf3UJDxm6zr3tZ0LCrQrDFTP8sjK7PBAklsZSnUDqguUJ5t1ejoiGg6pRZtgKgHmPq3CrmPSlcIXLK270qrJk0XIZ2UKVP8gDf6mVPuFVs/RxyIb+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com; spf=pass smtp.mailfrom=apple.com; dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b=kv8G/Ql4; arc=none smtp.client-ip=17.132.108.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=apple.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apple.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=apple.com header.i=@apple.com header.b="kv8G/Ql4"
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by mr55p01nt-mxp04.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SKS1LPWRQVB5U00@mr55p01nt-mxp04.apple.com> for
 mptcp@lists.linux.dev; Thu, 03 Oct 2024 20:13:59 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_17,2024-10-03_01,2024-09-30_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=20180706;
 bh=uumaqnKKeDpi0b5fXzuysdPXjtkrr3VcX/YTH6VrHek=;
 b=kv8G/Ql4ucRK3hHibEfA56btUXcis69sHwncj1aI8DZyzUaTZPGkGeWihJNWN1tvDmk3
 ecn8Q/4I3qiDEG05Mao4/jFxNiejAPNYtH8mBpk2gFzQOgoPdtc+9Iyl85z01e+lWg7v
 3U0IYvwK6pk9pcYrvHgJsHQnMU9m9KvxnE4QQv9v53dyOSTUlyMl76Oh8NtsPI8HzjKE
 oXHGr+nMo4E+78ojFZFi0IPoEunUQuxDwKv983uXed1qV8u7eDQxNzXVMIULhbpVsT72
 umJbgCvcIRLtXezaSZrxX9Azs5eeJEIe/FAg3okZhonUejkuQnZs+/ZhheoVvR9oWCih ow==
Received: from mr55p01nt-mmpp05.apple.com
 (mr55p01nt-mmpp05.apple.com [10.170.185.201])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SKS00TI3QVBEOV0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Thu, 03 Oct 2024 13:13:59 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp05.apple.com by
 mr55p01nt-mmpp05.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SKS0IP00QT0Y900@mr55p01nt-mmpp05.apple.com>; Thu,
 03 Oct 2024 20:13:59 +0000 (GMT)
X-Va-A:
X-Va-T-CD: 3eab4c5fc6cee5e97005c243497e205f
X-Va-E-CD: e6baaedccdb0fc0c1d69103afc7342d3
X-Va-R-CD: 1889d4c959161808f881ae2f19dda8d8
X-Va-ID: eb7e6ada-a4fc-4d6b-a7b8-76bae4b085eb
X-Va-CD: 0
X-V-A:
X-V-T-CD: 3eab4c5fc6cee5e97005c243497e205f
X-V-E-CD: e6baaedccdb0fc0c1d69103afc7342d3
X-V-R-CD: 1889d4c959161808f881ae2f19dda8d8
X-V-ID: 85656e01-d5b5-46f2-ae9b-5d772c37697b
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_17,2024-10-03_01,2024-09-30_01
Received: from smtpclient.apple ([17.230.165.118])
 by mr55p01nt-mmpp05.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SKS0HVCPQVAXR00@mr55p01nt-mmpp05.apple.com>; Thu,
 03 Oct 2024 20:13:59 +0000 (GMT)
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
In-reply-to: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
Date: Thu, 03 Oct 2024 13:07:10 -0700
Cc: mptcp@lists.linux.dev, Davide Caratti <dcaratti@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Craig Taylor <cmtaylor@apple.com>
Content-transfer-encoding: quoted-printable
Message-id: <1393FB5B-A830-48C8-9E56-2C9DDA122F83@apple.com>
References: <20241003-mptcp-gh-518-v1-1-e79e1f6434ad@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: Apple Mail (2.3826.200.55)

+Craig from Apple

Hello,

> On Oct 3, 2024, at 11:43=E2=80=AFAM, Matthieu Baerts (NGI0) =
<matttbe@kernel.org> wrote:
>=20
> As reported by Christoph [1], before this patch, an MPTCP connection =
was
> wrongly reset when a host received a first data packet with MPTCP
> options after the 3wHS, but got the next ones without.
>=20
> According to the MPTCP v1 specs [2], a fallback should happen in this
> case, because the host didn't receive a DATA_ACK from the other peer,
> nor receive data for more than the initial window which implies a
> DATA_ACK being received by the other peer.
>=20
> The patch here re-uses the same logic as the one used in other places:
> by looking at allow_infinite_fallback, which is disabled at the =
creation
> of an additional subflow. It's not looking at the first DATA_ACK (or
> implying one received from the other side) as suggested by the RFC, =
but
> it is in continuation with what was already done, which is safer, and =
it
> fixes the reported issue. The next step, looking at this first =
DATA_ACK,
> is tracked in [4].
>=20
> This patch has been validated using the following Packetdrill script:
>=20
>   0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
>  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>  +0 bind(3, ..., ...) =3D 0
>  +0 listen(3, 1) =3D 0
>=20
>  // 3WHS is OK
>  +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, =
wscale 6, mpcapable v1 flags[flag_h] nokey>
>  +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, =
wscale 8, mpcapable v1 flags[flag_h] key[skey]>
>  +0.1 <  . 1:1(0) ack 1 win 2048                                       =
       <mpcapable v1 flags[flag_h] key[ckey=3D2, skey]>
>  +0 accept(3, ..., ...) =3D 4
>=20
>  // Data from the client with valid MPTCP options (no DATA_ACK: =
normal)
>  +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] =
key[skey, ckey] mpcdatalen 500, nop, nop>
>  // =46rom here, the MPTCP options will be dropped by a middlebox
>  +0.0 >  . 1:1(0)     ack 501        <dss dack8=3D501 dll=3D0 nocs>
>=20
>  +0.1 read(4, ..., 500) =3D 500
>  +0   write(4, ..., 100) =3D 100
>=20
>  // The server replies with data, still thinking MPTCP is being used
>  +0.0 > P. 1:101(100)   ack 501          <dss dack8=3D501 dsn8=3D1 =
ssn=3D1 dll=3D100 nocs, nop, nop>
>  // But the client already did a fallback to TCP, because the two =
previous packets have been received without MPTCP options
>  +0.1 <  . 501:501(0)   ack 101 win 2048
>=20
>  +0.0 < P. 501:601(100) ack 101 win 2048
>  // The server should fallback to TCP, not reset: it didn't get a =
DATA_ACK, nor data for more than the initial window
>  +0.0 >  . 101:101(0)   ack 601
>=20
> Note that this script requires Packetdrill with MPTCP support, see =
[3].
>=20
> Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on =
mapping errors")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
> Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
> Link: https://github.com/multipath-tcp/packetdrill [3]
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Cc: Davide Caratti <dcaratti@redhat.com>
> Cc: Paolo Abeni <pabeni@redhat.com>

awesome! Is this ready to be tested or does this need to go through the =
CI,=E2=80=A6 first ?


Christoph

> ---
> net/mptcp/subflow.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index =
a1e28e1d8b4e39e14bc8f98164013d302d62595c..61482f8b425b5dde17a4f3272d04973a=
e5ec7849 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1282,7 +1282,7 @@ static bool subflow_can_fallback(struct =
mptcp_subflow_context *subflow)
> 	else if (READ_ONCE(msk->csum_enabled))
> 		return !subflow->valid_csum_seen;
> 	else
> -		return !READ_ONCE(subflow->fully_established);
> +		return READ_ONCE(msk->allow_infinite_fallback);
> }
>=20
> static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock =
*ssk)
>=20
> ---
> base-commit: 8567c53ad205aa6e13f8d6c2739522907da3504a
> change-id: 20241003-mptcp-gh-518-b91ffc4b1fcf
>=20
> Best regards,
> --=20
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>=20

