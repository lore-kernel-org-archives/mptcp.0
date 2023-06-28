Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06344322E
	for <mptcp@lists.linux.dev>; Wed, 28 Jun 2023 17:35:35 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0RWZ00TX521FN000@ma-mailsvcp-mx-lapp03.apple.com> for
 mptcp@lists.linux.dev; Wed, 28 Jun 2023 09:35:28 -0700 (PDT)
X-Proofpoint-ORIG-GUID: q34QNOM36znqOvV-3FDwY-1BTgCF54lA
X-Proofpoint-GUID: q34QNOM36znqOvV-3FDwY-1BTgCF54lA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.591,18.0.957
 definitions=2023-06-28_12:2023-06-27,2023-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=/PJAtCD5IX/kDzYnd1lr8JWMeKto4W4jh/HtadckAis=;
 b=kLab+yeXLC1KOV1Leg9nREtBD3dzOIiSh9vxx0eZ1UOIHzythEwi+TRsHfAKQE4rLQ4M
 BSs5vnq2WJ0Uls6GrbXSjYtZqVf2MFUA91VVF/c+AgL2V61IzxfKMuDyG+RHo2y9uic5
 pCAkL3hCGXwXnb2Jn2WgvfSNwlwyxiqObbSwnBfpOicgjxnUY49yP3sp+vOYixvbnizx
 InC21bsgGjJOqbkbPfh4piegSt2H0inRyKM4CskysDcGmgUSd4FeFNBJsIW4O2HPJldx
 KCXCS8T33vTAPA71I4rIwjQdB7Aod71DNnRwlRIFo1EPb/Qn6EvGpqMr0sp0u3d8XPFy fA==
Received: from rn-mailsvcp-mmp-lapp04.rno.apple.com
 (rn-mailsvcp-mmp-lapp04.rno.apple.com [17.179.253.17])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0RWZ00YM022D1410@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Wed, 28 Jun 2023 09:35:08 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp04.rno.apple.com by
 rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0RWZ00O001XSP300@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Wed,
 28 Jun 2023 09:35:07 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 485dde3f30341d8e501e0b6f5b138a1f
X-Va-R-CD: e7abda42d7c58ac292ee43166d384ebc
X-Va-ID: e474639e-acfc-464e-84d4-c9d95d4d8abf
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 485dde3f30341d8e501e0b6f5b138a1f
X-V-R-CD: e7abda42d7c58ac292ee43166d384ebc
X-V-ID: 9f7e6e8d-507f-4efd-8454-483750e78e55
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.591,18.0.957
 definitions=2023-06-28_12:2023-06-27,2023-06-28 signatures=0
Received: from smtpclient.apple ([17.192.155.222])
 by rn-mailsvcp-mmp-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023))
 with ESMTPSA id <0RWZ00E9O22CL600@rn-mailsvcp-mmp-lapp04.rno.apple.com>; Wed,
 28 Jun 2023 09:35:07 -0700 (PDT)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3766.100.3\))
Subject: Re: [PATCH mptcp-net] mptcp: do not rely on implicit state check in
 mptcp_listen()
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
Date: Wed, 28 Jun 2023 09:34:50 -0700
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <54EC46E7-B042-4E13-9F18-015263E0AB57@apple.com>
References:
 <9a42270be1b4d109351b22ad0331bab8051803fb.1687951613.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3766.100.3)



> On Jun 28, 2023, at 4:27=E2=80=AFAM, Paolo Abeni <pabeni@redhat.com> =
wrote:
>=20
> Since the blamed commit, closing the first subflow resets the first
> subflow socket state to SS_UNCONNECTED.
>=20
> The current mptcp listen implementation relies only on such
> state to prevent touching not-fully-disconnected sockets.
>=20
> Incoming mptcp fastclose (or paired endpoint removal) unconditionally
> closes the first subflow.
>=20
> All the above allows an incoming fastclose followed by a listen() call
> to successfully race with a blocking recvmsg(), potentially causing =
the
> latter to hit a divide by zero bug in =
cleanup_rbuf/__tcp_select_window().
>=20
> Address the issue explicitly checking the msk socket state in
> mptcp_listen(). An alternative solution would be moving the first
> subflow socket state update into mptcp_disconnect(), but in the long
> term the first subflow socket should be removed: better avoid relaying
> on it for internal consistency check.
>=20
> Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> This is basically a new version of "mptcp: fix bogus socket state =
update",
> but since it uses a quite different logic, no revision increase ;)
>=20
> Should close issues/414
> ---
> net/mptcp/protocol.c | 5 +++++
> 1 file changed, 5 insertions(+)

I=E2=80=99m running syzkaller now with this patch.


Christoph

>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index a50eaa01ba8a..d3ff2a2c60de 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3751,6 +3751,11 @@ static int mptcp_listen(struct socket *sock, =
int backlog)
> 	pr_debug("msk=3D%p", msk);
>=20
> 	lock_sock(sk);
> +
> +	err =3D -EINVAL;
> +	if (sock->state !=3D SS_UNCONNECTED || sock->type !=3D =
SOCK_STREAM)
> +		goto unlock;
> +
> 	ssock =3D __mptcp_nmpc_socket(msk);
> 	if (IS_ERR(ssock)) {
> 		err =3D PTR_ERR(ssock);
> --=20
> 2.40.1
>=20
>=20

