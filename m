Received: from ma-mailsvcp-mx-lapp03.apple.com (ma-mailsvcp-mx-lapp03.apple.com [17.32.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A1125CC
	for <mptcp@lists.linux.dev>; Tue, 30 May 2023 17:06:02 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp03.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RVH007I5BDQFW10@ma-mailsvcp-mx-lapp03.apple.com> for
 mptcp@lists.linux.dev; Tue, 30 May 2023 09:05:52 -0700 (PDT)
X-Proofpoint-ORIG-GUID: yuTpUmj4zR72SYS-HBIG2fu1Tsmx_NlX
X-Proofpoint-GUID: yuTpUmj4zR72SYS-HBIG2fu1Tsmx_NlX
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
 bh=hg0PbZaGcQwQPCeR3p2Obro4KAs/0DXJGcHY6VfNkd8=;
 b=SqI062ZKrmBgEh+q5CyFSH+mhn6B1PfoAKeQh/8DzqfbzDORe1PxDvDvLk59ErcRPMFi
 LKLe7C2hw273+ch3pii6t1/TabSCWjlc2aDT5wsUe6h0RQwQjStLoUx+CExldpvG06hd
 L6iNpmm9pskuzXIhWhWIsOooFVFzh68Wi0uOnr9+G1mpGqgEVEjrJ9JL+9TEj4RYgCOO
 lJk4g/ODYI3Ai0xgCawN4mdK68+1Ki9mMPT90K6kmoNKgznEXg86mvg4iXuDltVJI/YK
 y6ljZ8UBz0yRwTXDqgPvE5VJZOqzeJoECvbAbUidUpiHiXBm+8VsE3GiEkv1NlFRND3Y Qg==
Received: from rn-mailsvcp-mmp-lapp03.rno.apple.com
 (rn-mailsvcp-mmp-lapp03.rno.apple.com [17.179.253.16])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RVH00ECPBDR5YC0@rn-mailsvcp-mta-lapp03.rno.apple.com>;
 Tue, 30 May 2023 09:05:51 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp03.rno.apple.com by
 rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) id <0RVH01000BDCM300@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 30 May 2023 09:05:51 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: 14ed46e03330c5b9faf4ae2eb27cdc02
X-Va-R-CD: 41fee3112b71eaa55c888833e2944c4d
X-Va-ID: 7600d0fa-a53a-4ca7-853f-32784f3d244b
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: 14ed46e03330c5b9faf4ae2eb27cdc02
X-V-R-CD: 41fee3112b71eaa55c888833e2944c4d
X-V-ID: 6b1ce6d0-6972-45fa-9bce-dc99e17176ed
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.957
 definitions=2023-05-30_12:2023-05-30,2023-05-30 signatures=0
Received: from smtpclient.apple (unknown [17.192.155.222])
 by rn-mailsvcp-mmp-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023))
 with ESMTPSA id <0RVH00O6BBDQTV00@rn-mailsvcp-mmp-lapp03.rno.apple.com>; Tue,
 30 May 2023 09:05:51 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 mptcp-net 2/2] mptcp: fix possible divide by zero in
 recvmsg()
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
Date: Tue, 30 May 2023 09:05:40 -0700
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <B2BF64A2-D0AE-4A65-92A0-D820C9D71BE3@apple.com>
References:
 <360b09c704b56f03c42c4f3520e6602fbf884651.1685367663.git.pabeni@redhat.com>
 <42bb08e7d5ec3c1cc5cba43fa1215f80255e99a9.1685367663.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.600.7)



> On May 29, 2023, at 6:41 AM, Paolo Abeni <pabeni@redhat.com> wrote:
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
> Address the issue preventing the disconnect if some other process is
> concurrently performing a blocking syscall on the same socket, alike
> commit XXXXXXXXX ("tcp: deny tcp_disconnect() when threads are =
waiting").
>=20
> Fixes: a6b118febbab ("mptcp: add receive buffer auto-tuning")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/404
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - refactor on top of the TCP fix
> note:
>  - the hash of the TCP fix is missing, such commit should be applied
>    today or tomorrow morning in the worst-case scenario.
> ---
> net/mptcp/protocol.c | 6 ++++++
> 1 file changed, 6 insertions(+)

Same on this one - it works!

Tested-by: Christoph Paasch <cpaasch@apple.com>

>=20
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index ce1a70ad37cf..585c84f0b0eb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3141,6 +3141,12 @@ static int mptcp_disconnect(struct sock *sk, =
int flags)
> {
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
>=20
> +	/* Deny disconnect if other threads are blocked in =
sk_wait_event()
> +	 * or inet_wait_for_connect().
> +	 */
> +	if (sk->sk_wait_pending)
> +		return -EBUSY;
> +
> 	/* We are on the fastopen error path. We can't call straight =
into the
> 	 * subflows cleanup code due to lock nesting (we are already =
under
> 	 * msk->firstsocket lock).
> --=20
> 2.40.1
>=20
>=20

