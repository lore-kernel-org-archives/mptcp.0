Received: from ma-mailsvcp-mx-lapp02.apple.com (ma-mailsvcp-mx-lapp02.apple.com [17.32.222.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4C6AB6
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 18:17:56 +0000 (UTC)
Received: from rn-mailsvcp-mta-lapp04.rno.apple.com
 (rn-mailsvcp-mta-lapp04.rno.apple.com [10.225.203.152])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RS600Z7LW17WB00@ma-mailsvcp-mx-lapp02.apple.com> for
 mptcp@lists.linux.dev; Mon, 27 Mar 2023 10:17:49 -0700 (PDT)
X-Proofpoint-GUID: YKd6hCDbJjjzkfndjdDG7EEcZvzDPBK3
X-Proofpoint-ORIG-GUID: YKd6hCDbJjjzkfndjdDG7EEcZvzDPBK3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-03-27_02:2023-03-27,2023-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=interactive_user_notspam
 policy=interactive_user score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=content-type : mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=20180706;
 bh=Tp4RmS7Zs2NzfguIl5NvhIHtdXtcwEFWrUCVcMP2awI=;
 b=YW8HMKivZFjyPnmg2b2q4+EBLIb1afGvI5e4Gf82Pv1npNLBS+5IUjuq9Kag5aNRNxM3
 Sc/his76ujqIEAOlsXbzHHHQMC6GsQ4Wbc/frLo+KeVEhrM3iO0yBNk4FGRANRSu7GWr
 V/ziQXjLCNbpT1+hB7orDLtuFdLHRC9d4Q9SJ5tBH4+i7Z8IYPM6FFfym9mwp/CYUWdn
 dDgGnRViVv8clc1pJRfubyjOB3RMYQb5K3cFDrGIexa2v8gjxu+38WYlwwtO/ovB64rD
 T4If9epOpFnCx6vMFqduJT9vWVohZLXKCR2YPvAxk3WGCVDzLXVS0yZH6zkrOpXTWfXt 3Q==
Received: from rn-mailsvcp-mmp-lapp01.rno.apple.com
 (rn-mailsvcp-mmp-lapp01.rno.apple.com [17.179.253.14])
 by rn-mailsvcp-mta-lapp04.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) with ESMTPS id <0RS6008OEW1GHXX0@rn-mailsvcp-mta-lapp04.rno.apple.com>;
 Mon, 27 Mar 2023 10:17:41 -0700 (PDT)
Received: from process_milters-daemon.rn-mailsvcp-mmp-lapp01.rno.apple.com by
 rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023)) id <0RS600200VX3WL00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 27 Mar 2023 10:17:41 -0700 (PDT)
X-Va-A:
X-Va-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-Va-E-CD: be9e4c75391db0fe53fa8720f2cd1f62
X-Va-R-CD: d5c73c7759d83a80f7ebe43093ef4376
X-Va-ID: bdccb7b9-b53c-48bf-8636-aa9f1d94eef9
X-Va-CD: 0
X-V-A:
X-V-T-CD: 63633cf878a009867ff2b0b1cd43e165
X-V-E-CD: be9e4c75391db0fe53fa8720f2cd1f62
X-V-R-CD: d5c73c7759d83a80f7ebe43093ef4376
X-V-ID: 74a047a9-e832-4078-a4cb-160bbab68770
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.573,18.0.942
 definitions=2023-03-27_02:2023-03-27,2023-03-20 signatures=0
Received: from smtpclient.apple (unknown [17.192.155.144])
 by rn-mailsvcp-mmp-lapp01.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.22.20230228 64bit (built Feb 28
 2023))
 with ESMTPSA id <0RS600067W1CAS00@rn-mailsvcp-mmp-lapp01.rno.apple.com>; Mon,
 27 Mar 2023 10:17:40 -0700 (PDT)
Content-type: text/plain; charset=us-ascii
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.500.221\))
Subject: Re: [PATCH mptcp-net 2/2] mptcp: stricter state check in mptcp_worker
From: Christoph Paasch <cpaasch@apple.com>
In-reply-to:
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
Date: Mon, 27 Mar 2023 10:17:26 -0700
Cc: mptcp@lists.linux.dev
Content-transfer-encoding: quoted-printable
Message-id: <448BDE4E-50FB-4859-A9EC-F16AF00AC24A@apple.com>
References:
 <9aa2681941d55c2ae198167c86c3d0b8ecfbf551.1679654040.git.pabeni@redhat.com>
 <10b158069455d831d9efc547bcdb3a6379234f1c.1679654040.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3731.500.221)



> On Mar 24, 2023, at 3:34 AM, Paolo Abeni <pabeni@redhat.com> wrote:
>=20
> As reported by Christpher, the mptcp protocol can run the
> worker when the relevant msk socket is in an unexpected state:
>=20
> connect()
> // incoming reset + fastclose
> // the mptcp worker is scheduled
> mptcp_disconnect()
> // msk is now CLOSED
> listen()
> mptcp_worker()
>=20
> Leading to the following splat:
>=20
> divide error: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 21 Comm: kworker/1:0 Not tainted 6.3.0-rc1-gde5e8fd0123c =
#11
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.11.0-2.el7 04/01/2014
> Workqueue: events mptcp_worker
> RIP: 0010:__tcp_select_window+0x22c/0x4b0 net/ipv4/tcp_output.c:3018
> RSP: 0018:ffffc900000b3c98 EFLAGS: 00010293
> RAX: 000000000000ffd7 RBX: 000000000000ffd7 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: ffffffff8214ce97 RDI: 0000000000000004
> RBP: 000000000000ffd7 R08: 0000000000000004 R09: 0000000000010000
> R10: 000000000000ffd7 R11: ffff888005afa148 R12: 000000000000ffd7
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88803ed00000(0000) =
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000405270 CR3: 000000003011e006 CR4: 0000000000370ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> tcp_select_window net/ipv4/tcp_output.c:262 [inline]
> __tcp_transmit_skb+0x356/0x1280 net/ipv4/tcp_output.c:1345
> tcp_transmit_skb net/ipv4/tcp_output.c:1417 [inline]
> tcp_send_active_reset+0x13e/0x320 net/ipv4/tcp_output.c:3459
> mptcp_check_fastclose net/mptcp/protocol.c:2530 [inline]
> mptcp_worker+0x6c7/0x800 net/mptcp/protocol.c:2705
> process_one_work+0x3bd/0x950 kernel/workqueue.c:2390
> worker_thread+0x5b/0x610 kernel/workqueue.c:2537
> kthread+0x138/0x170 kernel/kthread.c:376
> ret_from_fork+0x2c/0x50 arch/x86/entry/entry_64.S:308
> </TASK>
>=20
> This change address the issue explicitly checking for bad states
> before running the mptcp worker.
>=20
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/374
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Works!

Tested-by: Christoph Paasch <cpaasch@apple.com>



