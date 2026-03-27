Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8034B410
	for <mptcp@lists.linux.dev>; Fri, 27 Mar 2026 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596741; cv=none; b=J2ox5F1vYm0Xa6Wnzkyw3oHsO0xy+p4E4+8c/hY/+I/iiVmRQ7ffYhFSAmhf3tF8p8iXB8S3RgF1jQNoB3VM+KNWowfzy38DTirRgeXdR/7ysyDwq+vgtz2glW4vBS9IORUgDd1OeCXTBsYObZdRmNriA/HBl1CNvj6gU5kPSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596741; c=relaxed/simple;
	bh=sPIq4oegDN+UKCJQyVm2Z2Ah5A/OXXT0CKNhqwvY1ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LG5wJp1evHytObiQjoPzW2xwri60hEwEBFvfxyh5c9Xu7mPbQa1vVOFOHv7L25AoK9mmHe0ZXGtUI+51LNEaOfDdIu6S0JxcFbj1os8wnVGq5YdxXyY8z3NKMB1zLZIu0O9j3/7JFCYHyB0NIYeAJVj1umTN4Pkv2Y13U7+XsGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=yrxc40M2; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="yrxc40M2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JlOVJvch5CnHpSnAoS69wCZR9XjUE7/EkqJycR+1o9A=;
	b=yrxc40M20ytoWJ3FnjbvHeDJVvaRzULkYULAsjamP8Ae3DDI1wDzh/nkIs0Pjev787bpuhmiR
	LeqOP0DhZk07NkXP/QE/nPh2ICgcd/AiHOGl7u6VZwT7+KiGz1yss/BOLzyFNN9hl8TssktuDMf
	Alc+K/TpCK+9++VYFbii0aY=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhsd60zZ0zKm67;
	Fri, 27 Mar 2026 15:26:02 +0800 (CST)
Received: from kwepemj500018.china.huawei.com (unknown [7.202.194.48])
	by mail.maildlp.com (Postfix) with ESMTPS id B04E94055B;
	Fri, 27 Mar 2026 15:32:10 +0800 (CST)
Received: from huawei.com (10.50.85.128) by kwepemj500018.china.huawei.com
 (7.202.194.48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Mar
 2026 15:32:10 +0800
From: Li Xiasong <lixiasong1@huawei.com>
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	<martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: <netdev@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH net v3] mptcp: fix soft lockup in mptcp_recvmsg()
Date: Fri, 27 Mar 2026 15:55:44 +0800
Message-ID: <20260327075544.3622851-1-lixiasong1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj500018.china.huawei.com (7.202.194.48)

syzbot reported a soft lockup in mptcp_recvmsg() [0].

When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
removed from the sk_receive_queue. This causes sk_wait_data() to always
find available data and never perform actual waiting, leading to a soft
lockup.

Fix this by adding a 'last' parameter to track the last peeked skb.
This allows sk_wait_data() to make informed waiting decisions and prevent
infinite loops when MSG_PEEK is used.

[0]:
watchdog: BUG: soft lockup - CPU#2 stuck for 156s! [server:1963]
Modules linked in:
CPU: 2 UID: 0 PID: 1963 Comm: server Not tainted 6.19.0-rc8 #61 PREEMPT(none)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
RIP: 0010:sk_wait_data+0x15/0x190
Code: 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 56 41 55 41 54 49 89 f4 55 48 89 d5 53 48 89 fb <48> 83 ec 30 65 48 8b 05 17 a4 6b 01 48 89 44 24 28 31 c0 65 48 8b
RSP: 0018:ffffc90000603ca0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff888102bf0800 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffc90000603d18 RDI: ffff888102bf0800
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000101
R10: 0000000000000000 R11: 0000000000000075 R12: ffffc90000603d18
R13: ffff888102bf0800 R14: ffff888102bf0800 R15: 0000000000000000
FS:  00007f6e38b8c4c0(0000) GS:ffff8881b877e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055aa7bff1680 CR3: 0000000105cbe000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 mptcp_recvmsg+0x547/0x8c0 net/mptcp/protocol.c:2329
 inet_recvmsg+0x11f/0x130 net/ipv4/af_inet.c:891
 sock_recvmsg+0x94/0xc0 net/socket.c:1100
 __sys_recvfrom+0xb2/0x130 net/socket.c:2256
 __x64_sys_recvfrom+0x1f/0x30 net/socket.c:2267
 do_syscall_64+0x59/0x2d0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x76/0x7e arch/x86/entry/entry_64.S:131
RIP: 0033:0x7f6e386a4a1d
Code: 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 8d 05 f1 de 2c 00 41 89 ca 8b 00 85 c0 75 20 45 31 c9 45 31 c0 b8 2d 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6b f3 c3 66 0f 1f 84 00 00 00 00 00 41 56 41
RSP: 002b:00007ffc3c4bb078 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 000000000000861e RCX: 00007f6e386a4a1d
RDX: 00000000000003ff RSI: 00007ffc3c4bb150 RDI: 0000000000000004
RBP: 00007ffc3c4bb570 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000103 R11: 0000000000000246 R12: 00005605dbc00be0
R13: 00007ffc3c4bb650 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Fixes: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
---

v2->v3:
Thanks to Matthieu Baerts for the review.
- Initialize last to NULL.
- Only update 'last' when MSG_PEEK is set, avoiding dangling pointer.

v1->v2:
Thanks to Matthieu Baerts for the suggestion and review.
- Move 'last' variable definition into the while loop in mptcp_recvmsg() to
  narrow its scope.
- In __mptcp_recvmsg_mskq(), assign 'last' right after 'copied' is updated,
  regardless of MSG_PEEK flag.
https://lore.kernel.org/netdev/20260324085131.4187473-1-lixiasong1@huawei.com/

v1:
https://lore.kernel.org/netdev/20260302052651.1466983-1-lixiasong1@huawei.com/

---
 net/mptcp/protocol.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cf1852b99963..60f6e6a189b7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
 static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 				size_t len, int flags, int copied_total,
 				struct scm_timestamping_internal *tss,
-				int *cmsg_flags)
+				int *cmsg_flags, struct sk_buff **last)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct sk_buff *skb, *tmp;
@@ -2058,6 +2058,8 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
 			}
 
 			mptcp_eat_recv_skb(sk, skb);
+		} else {
+			*last = skb;
 		}
 
 		if (copied >= len)
@@ -2288,10 +2290,12 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		cmsg_flags = MPTCP_CMSG_INQ;
 
 	while (copied < len) {
+		struct sk_buff *last = NULL;
 		int err, bytes_read;
 
 		bytes_read = __mptcp_recvmsg_mskq(sk, msg, len - copied, flags,
-						  copied, &tss, &cmsg_flags);
+						  copied, &tss, &cmsg_flags,
+						  &last);
 		if (unlikely(bytes_read < 0)) {
 			if (!copied)
 				copied = bytes_read;
@@ -2343,7 +2347,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 
 		pr_debug("block timeout %ld\n", timeo);
 		mptcp_cleanup_rbuf(msk, copied);
-		err = sk_wait_data(sk, &timeo, NULL);
+		err = sk_wait_data(sk, &timeo, last);
 		if (err < 0) {
 			err = copied ? : err;
 			goto out_err;
-- 
2.34.1

