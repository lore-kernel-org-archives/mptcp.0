Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95351FC7E1
	for <mptcp@lists.linux.dev>; Tue,  4 Mar 2025 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741084006; cv=none; b=K4mWUyl79WmMkgqeGGPAuhmQ7hGjaw3IU3tnznNcN4vPCQ+IVbuS3Y0TeAgTM1tCTUmzOaqnoTy+X01YK0OtLzPndzxDIoA6kT3V7yAgA4dAj0Guu1zH+HJ5ib8XfRMOXYHkmTp+XF75JcZ5Zx9D3CR98dOsWqmVoCynxS7QrME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741084006; c=relaxed/simple;
	bh=I2FWZZX0GxavNOBYZ4lLRcT0xfdOe4ihyDVZr+zbESk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXAQ6J+HQE6G05kM7ytFZ8F9o4PLt9LN6z/mePwZtD2dtpQ4Wd3830m5DkU6ca/cYlvxgOg6xagvy0e8BFYm91zlUqy2YncN7iwEdeW1hg5Uum1NnzIqvjEB23mAU8+LaAzn7GOxslmo2naDG9mafqGIBGxFEpE6qDD39uN0wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 287165a6f8e311efa216b1d71e6e1362-20250304
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e7e8fe68-934c-456f-b9f9-2eb6133cf314,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:e7e8fe68-934c-456f-b9f9-2eb6133cf314,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:52e1f5f0e26137bb29f8a22a7fb528e3,BulkI
	D:250304182639G1XC7E36,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 287165a6f8e311efa216b1d71e6e1362-20250304
X-User: yangang@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <yangang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1817915665; Tue, 04 Mar 2025 18:26:39 +0800
From: Gang Yan <yangang@kylinos.cn>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [mptcp-net] mptcp: fix NULL pointer in can_accept_new_subflow
Date: Tue,  4 Mar 2025 18:26:34 +0800
Message-Id: <20250304102634.331497-1-yangang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing Valkey with MPTCP, a kernel panic occurs in
'mptcp_can_accept_new_subflow' when 'subflow_req->msk' is NULL.

The attached logs on 6.14.0-rc4 confirm the crash:

[ 2691.198090] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000012
[ 2691.202935] Internal error: Oops: 0000000096000004 [#1] SMP
[ 2691.205451] CPU: 5 UID: 0 PID: 7346 Comm: valkey-benchmar Not tainted 6.14.0-rc4+ #2
[ 2691.205657] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
[ 2691.205915] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[ 2691.206099] pc : mptcp_can_accept_new_subflow+0x24/0x100
[ 2691.206285] lr : subflow_syn_recv_sock+0x2ec/0x538
[ 2691.206413] sp : ffff8000833f38e0
[ 2691.206507] x29: ffff8000833f38e0 x28: 0000000000000a82 x27: 0000000000000000
[ 2691.206726] x26: 0000000000000001 x25: ffff000081972c00 x24: ffff0000efc1c188
[ 2691.206915] x23: ffff0000821fd100 x22: ffff8000833f3a2f x21: ffff0000bb0adf00
[ 2691.207108] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000833dd088
[ 2691.207308] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[ 2691.207504] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[ 2691.207707] x11: 0000000000000000 x10: 0000000000000000 x9 : ffff800081654214
[ 2691.207900] x8 : ffff8000833f37d8 x7 : 0000000000000000 x6 : 0000000000000000
[ 2691.208098] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[ 2691.208289] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000012
[ 2691.208478] Call trace:
[ 2691.208548]  mptcp_can_accept_new_subflow+0x24/0x100 (P)
[ 2691.208708]  subflow_syn_recv_sock+0x2ec/0x538
[ 2691.208826]  tcp_check_req+0x154/0x888
[ 2691.208940]  tcp_v4_rcv+0x6e4/0x12c0
[ 2691.209036]  ip_protocol_deliver_rcu+0x48/0x2d8
[ 2691.209172]  ip_local_deliver_finish+0x8c/0xf8
[ 2691.209294]  ip_local_deliver+0x8c/0x160
[ 2691.209402]  ip_rcv_finish+0x9c/0xe0
[ 2691.209497]  ip_rcv+0x64/0x138
[ 2691.209583]  __netif_receive_skb_one_core+0x68/0xc0
[ 2691.209721]  __netif_receive_skb+0x24/0x88
[ 2691.209831]  process_backlog+0x94/0x180
[ 2691.209957]  __napi_poll+0x44/0x2a8
[ 2691.210067]  net_rx_action+0x1e0/0x3f0
[ 2691.210206]  handle_softirqs+0x13c/0x418
[ 2691.210411]  __do_softirq+0x20/0x3c
[ 2691.210515]  ____do_softirq+0x1c/0x40
[ 2691.210616]  call_on_irq_stack+0x3c/0x50
[ 2691.210726]  do_softirq_own_stack+0x28/0x50
[ 2691.210836]  do_softirq+0xd4/0xe0
[ 2691.210936]  __local_bh_enable_ip+0xc8/0xe0
[ 2691.211057]  __dev_queue_xmit+0x280/0xf00
[ 2691.211194]  ip_finish_output2+0x340/0x6f0
[ 2691.211307]  __ip_finish_output+0xcc/0x200
[ 2691.211428]  ip_finish_output+0x40/0x1a8
[ 2691.211542]  ip_output+0x78/0x140
[ 2691.211631]  __ip_queue_xmit+0x178/0x498
[ 2691.211744]  ip_queue_xmit+0x20/0x50
[ 2691.211860]  __tcp_transmit_skb+0x508/0xf20
[ 2691.211974]  tcp_write_xmit+0x6fc/0x15f0
[ 2691.212096]  __tcp_push_pending_frames+0x48/0x160
[ 2691.212231]  tcp_push+0xc4/0x1e0
[ 2691.212328]  __mptcp_push_pending+0x150/0x2d8
[ 2691.212447]  mptcp_sendmsg+0x6f4/0x780
[ 2691.212571]  inet_sendmsg+0x50/0xb8
[ 2691.212669]  __sock_sendmsg+0x80/0x108
[ 2691.212777]  __sys_sendto+0x124/0x1c0
[ 2691.212881]  __arm64_sys_sendto+0x34/0x70
[ 2691.212987]  invoke_syscall+0x74/0x128
[ 2691.213096]  el0_svc_common.constprop.0+0x4c/0x140
[ 2691.213231]  do_el0_svc+0x28/0x58
[ 2691.213339]  el0_svc+0x40/0x1a0
[ 2691.213429]  el0t_64_sync_handler+0x134/0x160
[ 2691.213550]  el0t_64_sync+0x1b8/0x1c0
[ 2691.213647] Code: 910003fd a90153f3 aa0003f3 91004800 (08dffc00)
[ 2691.213815] ---[ end trace 0000000000000000 ]---
[ 2691.224406] Kernel panic - not syncing: Oops: Fatal exception in interrupt
[ 2691.224602] SMP: stopping secondary CPUs
[ 2691.247158] Kernel Offset: disabled
[ 2691.247290] CPU features: 0x000,00000050,00845250,ca07f723
[ 2691.247487] Memory Limit: none
[ 2691.260524] ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

The issue can be fixed by NULL check for 'subflow_req->msk' before
'mptcp_can_accept_new_subflow'.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/subflow.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index efe8d86496db..68b0e65e5239 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -852,6 +852,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 		mptcp_get_options(skb, &mp_opt);
 		if (!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK) ||
 		    !subflow_hmac_valid(req, &mp_opt) ||
+		    !subflow_req->msk ||
 		    !mptcp_can_accept_new_subflow(subflow_req->msk)) {
 			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKMAC);
 			fallback = true;
-- 
2.25.1

