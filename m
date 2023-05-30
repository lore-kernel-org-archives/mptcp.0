Received: from ma-mailsvcp-mx-lapp01.apple.com (ma-mailsvcp-mx-lapp01.apple.com [17.32.222.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DF63B1
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 06:04:40 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp01.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RVG000XZGQ2EK00@ma-mailsvcp-mx-lapp01.apple.com> for
 mptcp@lists.linux.dev; Mon, 29 May 2023 22:04:34 -0700 (PDT)
X-Proofpoint-ORIG-GUID: Ql-NfcFx6paJpoBTVobvCrPNjZiD8XNI
X-Proofpoint-GUID: Ql-NfcFx6paJpoBTVobvCrPNjZiD8XNI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-05-10_04:2023-05-05,2023-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=Gt3sLZ17Iwi25qfNxLRYYJAQmI5ynUdMxezKygFTLAs=;
 b=hwtG3j3iUTk4DCf9VaS0H3LALF6V9wQ2mNHTyYazK1wfEskBzUYZ4EYUcrxdmQEhEfkk
 l4VRwJT4s64HYDwOk+7lluWuzVyq/Jrovpq64gwR46p1u0T4ek/8pjGW4IJkXt//FThl
 i9kKjzIGSUhP9tug5hs3Mu2FToLi5TOIF0+YmzZuX0JwOHKOw32jw2HvcA/yrD1nFm9y
 DiEp6jdFDw2nhxKHHArcb7MOhrOiMNPvfcPEqKqOczNJQEuaAt3pDy7WvKNOXzmgWXwU
 JdCP1Z7lio1hZ25POeDKUIh+lJ8MbNCwFaSfZHPr7CYQ87Z33UqhIrJpe4uI1xey94rc Hg==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RVG00JU9GRGI430@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Mon, 29 May 2023 22:04:28 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) id <0RVG01000GKY4X00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 29 May 2023 22:04:28 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 72ba7d5984591196c3fe3186495684ad
X-Va-R-CD: f19c9f568869f73a2293970a2cb1d804
X-Va-ID: 156d08f6-8b64-4e46-b86a-f22f08740679
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 72ba7d5984591196c3fe3186495684ad
X-V-R-CD: f19c9f568869f73a2293970a2cb1d804
X-V-ID: a790379e-70a5-4c90-9a85-c613131f7433
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.957
 definitions=2023-05-30_02:2023-05-29,2023-05-30 signatures=0
Received: from smtpclient.apple (unknown [17.234.83.128])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023))
 with ESMTPSA id <0RVG0104NGRFF200@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Mon,
 29 May 2023 22:04:28 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH mptcp-net] mptcp: fix possible divide by zero in recvmsg()
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <48d92dad7566fffb4bbd10c4cc9ee60414fbb4a0.1685034996.git.pabeni@redhat.com>
Date: Mon, 29 May 2023 22:04:17 -0700
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <88932B84-8F72-4B59-BCBB-49023F2BFEF3@apple.com>
References:
 <48d92dad7566fffb4bbd10c4cc9ee60414fbb4a0.1685034996.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.600.7)



> On May 25, 2023, at 10:17 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> Christoph reported a devide by zero bug in mptcp_recvmsg():
>=20
> divide error: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 19978 Comm: syz-executor.6 Not tainted =
6.4.0-rc2-gffcc7899081b #20
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-2.el7 04/01/2014
> RIP: 0010:__tcp_select_window+0x30e/0x420 net/ipv4/tcp_output.c:3018
> Code: 11 ff 0f b7 cd c1 e9 0c b8 ff ff ff ff d3 e0 89 c1 f7 d1 01 cb =
21 c3 eb 17 e8 2e 83 11 ff 31 db eb 0e e8 25 83 11 ff 89 d8 99 <f7> 7c =
24 04 29 d3 65 48 8b 04 25 28 00 00 00 48 3b 44 24 10 75 60
> RSP: 0018:ffffc90000a07a18 EFLAGS: 00010246
> RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000040000
> RDX: 0000000000000000 RSI: 000000000003ffff RDI: 0000000000040000
> RBP: 000000000000ffd7 R08: ffffffff820cf297 R09: 0000000000000001
> R10: 0000000000000000 R11: ffffffff8103d1a0 R12: 0000000000003f00
> R13: 0000000000300000 R14: ffff888101cf3540 R15: 0000000000180000
> FS:  00007f9af4c09640(0000) GS:ffff88813bd00000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b33824000 CR3: 000000012f241001 CR4: 0000000000170ee0
> Call Trace:
> <TASK>
> __tcp_cleanup_rbuf+0x138/0x1d0 net/ipv4/tcp.c:1611
> mptcp_recvmsg+0xcb8/0xdd0 net/mptcp/protocol.c:2034
> inet_recvmsg+0x127/0x1f0 net/ipv4/af_inet.c:861
> ____sys_recvmsg+0x269/0x2b0 net/socket.c:1019
> ___sys_recvmsg+0xe6/0x260 net/socket.c:2764
> do_recvmmsg+0x1a5/0x470 net/socket.c:2858
> __do_sys_recvmmsg net/socket.c:2937 [inline]
> __se_sys_recvmmsg net/socket.c:2953 [inline]
> __x64_sys_recvmmsg+0xa6/0x130 net/socket.c:2953
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x47/0xa0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7f9af58fc6a9
> Code: 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 8b 0d 4f 37 0d 00 f7 d8 64 89 01 48
> RSP: 002b:00007f9af4c08cd8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
> RAX: ffffffffffffffda RBX: 00000000006bc050 RCX: 00007f9af58fc6a9
> RDX: 0000000000000001 RSI: 0000000020000140 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000f00 R11: 0000000000000246 R12: 00000000006bc05c
> R13: fffffffffffffea8 R14: 00000000006bc050 R15: 000000000001fe40
> </TASK>
>=20
> mptcp_recvmsg is allowed to release the msk socket lock when
> blocking, and before re-acquiring it another thread could have
> switched the sock to TCP_LISTEN status - with a prior
> connect(AF_UNSPEC) - also clearing icsk_ack.rcv_mss.
>=20
> Address the issue explicitly checking again the sock status
> after re-acquiring the lock.
>=20
> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/404
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

It works!

Tested-by: Christoph Paasch <cpaasch@apple.com>

> ---
> net/mptcp/protocol.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d8e152a8619a..ede6b4c7641e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2228,6 +2228,10 @@ static int mptcp_recvmsg(struct sock *sk, =
struct msghdr *msg, size_t len,
>=20
> 		pr_debug("block timeout %ld", timeo);
> 		sk_wait_data(sk, &timeo, NULL);
> +		if (unlikely(sk->sk_state =3D=3D TCP_LISTEN)) {
> +			copied =3D copied ? : -ENOTCONN;
> +			goto out_release;
> +		}
> 	}
>=20
> out_err:
> @@ -2248,6 +2252,7 @@ static int mptcp_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> 	if (!(flags & MSG_PEEK))
> 		mptcp_rcv_space_adjust(msk, copied);
>=20
> +out_release:
> 	release_sock(sk);
> 	return copied;
> }
> --=20
> 2.40.1
>=20

