Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4614E17C0
	for <mptcp@lists.linux.dev>; Wed,  9 Mar 2022 10:27:17 +0000 (UTC)
HMM_SOURCE_IP:172.18.0.48:59450.1719171101
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-36.111.140.9 (unknown [172.18.0.48])
	by chinatelecom.cn (HERMES) with SMTP id 6B7E32800B4;
	Wed,  9 Mar 2022 18:20:12 +0800 (CST)
X-189-SAVE-TO-SEND: +liyonglong@chinatelecom.cn
Received: from  ([172.18.0.48])
	by app0024 with ESMTP id b086cb130e9d4f6a836c57dbf3cfb43d for mptcp@lists.linux.dev;
	Wed, 09 Mar 2022 18:20:14 CST
X-Transaction-ID: b086cb130e9d4f6a836c57dbf3cfb43d
X-Real-From: liyonglong@chinatelecom.cn
X-Receive-IP: 172.18.0.48
X-MEDUSA-Status: 0
Sender: liyonglong@chinatelecom.cn
From: Yonglong Li <liyonglong@chinatelecom.cn>
To: mptcp@lists.linux.dev
Cc: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [PATCH] mptcp: Fix crash due to tcp_tsorted_anchor was initialized before release skb
Date: Wed,  9 Mar 2022 18:20:09 +0800
Message-Id: <1646821209-35620-1-git-send-email-liyonglong@chinatelecom.cn>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

get crash when do pressure test of mptcp:

===========================================================================
dst_release: dst:ffffa06ce6e5c058 refcnt:-1
kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle kernel paging request at ffffa06ce6e5c058
PGD 190a01067 P4D 190a01067 PUD 43fffb067 PMD 22e403063 PTE 8000000226e5c063
Oops: 0011 [#1] SMP PTI
CPU: 7 PID: 7823 Comm: kworker/7:0 Kdump: loaded Tainted: G            E
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.2.1 04/01/2014
Call Trace:
 ? skb_release_head_state+0x68/0x100
 ? skb_release_all+0xe/0x30
 ? kfree_skb+0x32/0xa0
 ? mptcp_sendmsg_frag+0x57e/0x750
 ? __mptcp_retrans+0x21b/0x3c0
 ? __switch_to_asm+0x35/0x70
 ? mptcp_worker+0x25e/0x320
 ? process_one_work+0x1a7/0x360
 ? worker_thread+0x30/0x390
 ? create_worker+0x1a0/0x1a0
 ? kthread+0x112/0x130
 ? kthread_flush_work_fn+0x10/0x10
 ? ret_from_fork+0x35/0x40
===========================================================================

in __mptcp_alloc_tx_skb skb was alloced and skb->tcp_tsorted_anchor will be
initialized,  in under memory pressure situation sk_wmem_schedule will
return false and then kfree_skb. In this case skb->_skb_refdst is not null
because_skb_refdst and tcp_tsorted_anchor are stored in the same mem, and
kfree_skb will try to release dst and casue crash.

Signed-off-by: Yonglong Li <liyonglong@chinatelecom.cn>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3cb9752..fbb14df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1199,6 +1199,7 @@ static struct sk_buff *__mptcp_alloc_tx_skb(struct sock *sk, struct sock *ssk, g
 		tcp_skb_entail(ssk, skb);
 		return skb;
 	}
+	tcp_skb_tsorted_anchor_cleanup(skb);
 	kfree_skb(skb);
 	return NULL;
 }
-- 
1.8.3.1

