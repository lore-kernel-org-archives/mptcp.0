Received: from rn-mailsvcp-mx-lapp03.apple.com (rn-mailsvcp-mx-lapp03.apple.com [17.179.253.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D263A
	for <mptcp@lists.linux.dev>; Thu,  9 Feb 2023 05:55:03 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp01.rno.apple.com
 (rn-mailsvcp-mta-lapp01.rno.apple.com [10.225.203.149])
 by rn-mailsvcp-mx-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) with ESMTPS id <0RPS00BH9QZLDZ10@rn-mailsvcp-mx-lapp03.rno.apple.com>
 for mptcp@lists.linux.dev; Wed, 08 Feb 2023 20:54:57 -0800 (PST)
X-Proofpoint-GUID: 6ivTs72JyBpvbJ6wHTwwYAUiCkayo1bn
X-Proofpoint-ORIG-GUID: 6ivTs72JyBpvbJ6wHTwwYAUiCkayo1bn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.562,18.0.930
 definitions=2023-02-09_02:2023-02-08,2023-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=0tZbtpX+DvSEueVOdi6F3B5oznFhRPzkcZVyOm1h184=;
 b=kohcydKHMzBYsImRdMBviCYqEAfA8QesoMgxejgbO8S3zyYl64STDVEohvSKEJjtnYld
 xsNYxWzhGaEz/gmsaoxa3vuQ5I5VfP5rV+AYto5HUf+apLUOst+/JrYmTufUaOynt6dn
 y+l6ky0fz7cDRuu/9IQlfk3fJa1y6f90VC4ZeN2gC4pQdhS818UTmKHGuuGsJXMibFGQ
 qGYKD0gkilQ+tIuceJ1x4YX0V1mZYjgModEUrm9oMPEfSkKlDbdVj8g8R89MVobRTVmT
 zEPex+y0RLQqB5N662+/L9qPzQDJ3UQ8AO0dOMxyXmofWEzPFySgDdGlp5Df9hH93VtK dA==
Received: from rn-mailsvcp-policy-lapp01.rno.apple.com
 (rn-mailsvcp-policy-lapp01.rno.apple.com [17.179.253.18])
 by rn-mailsvcp-mta-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) with ESMTPS id <0RPS001QJQZKP370@rn-mailsvcp-mta-lapp01.rno.apple.com>;
 Wed, 08 Feb 2023 20:54:57 -0800 (PST)
Received: from process_milters-daemon.rn-mailsvcp-policy-lapp01.rno.apple.com
 by rn-mailsvcp-policy-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022)) id <0RPS00J00QWS3W00@rn-mailsvcp-policy-lapp01.rno.apple.com>; Wed,
 08 Feb 2023 20:54:57 -0800 (PST)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 2d0f2c043516c8e8e7cf6dd2d1b137a6
X-Va-R-CD: f3dd1c712c7ef6cceebdf54c81f041cd
X-Va-ID: 7bd04b1f-3a36-4ca1-8897-f3d1ad4c4a47
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 2d0f2c043516c8e8e7cf6dd2d1b137a6
X-V-R-CD: f3dd1c712c7ef6cceebdf54c81f041cd
X-V-ID: cf63201c-10b1-4725-8c1c-ce0f53bbfbc3
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.562,18.0.930
 definitions=2023-02-09_02:2023-02-08,2023-02-09 signatures=0
Received: from smtpclient.apple (unknown [17.11.100.206])
 by rn-mailsvcp-policy-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.20.20220923 64bit (built Sep 23
 2022))
 with ESMTPSA id <0RPS000BIQZKE700@rn-mailsvcp-policy-lapp01.rno.apple.com>;
 Wed, 08 Feb 2023 20:54:57 -0800 (PST)
Content-type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.500.161\))
Subject: Re: [PATCH mptcp-net 0/2] mptcp: tentative fix for issues246 &&
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to: <cover.1675892307.git.pabeni@redhat.com>
Date: Wed, 08 Feb 2023 20:54:46 -0800
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <6706D7F2-9E02-4D78-9FDE-E95DD376CF51@apple.com>
References: <cover.1675892307.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.500.161)


> On Feb 8, 2023, at 1:44 PM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> Sharing these very early, because I can't reproduce the issues =
locally.
> Even the commit messages are early draft.

Turns out I can=E2=80=99t repro either (neither with the syzkaller-repro =
nor with the c-repro). All I have is the syzkaller report=E2=80=A6

I will update my syzkaller kernel and also apply Kuniyuki=E2=80=99s =
patch and run syzkaller again.


Christoph

>=20
> @Christoph could you please check the relevant repros here?
>=20
> I *think* there still some refcount problem to address in the new =
code,
> any sharp eyes more then welcome ;)
>=20
> Targeting -net even if bases on top of corrent mptcp-next, as
> the merge window is almost imminent.
>=20
> Paolo Abeni (2):
>  mptcp: use the workqueue to destroy unaccepted sockets.
>  mptcp: fix UaF in listener shutdown
>=20
> net/mptcp/protocol.c | 27 ++++++++-----
> net/mptcp/protocol.h |  4 +-
> net/mptcp/subflow.c  | 91 +++++---------------------------------------
> 3 files changed, 28 insertions(+), 94 deletions(-)
>=20
> --=20
> 2.39.1
>=20
>=20

