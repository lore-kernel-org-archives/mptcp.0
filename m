Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28861991A8
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736975537; cv=none; b=Uw7a2qEFNSiGOLEwCaQPN1Gjwpc5q/112aX+CXo3H7gS/bXMrpFj7nHpvL8vCsj8hq2v28zuQ8JmPVEDVqC2NjPsHv0qQ00wE90hiFc6MPMShj1AZjKHqQd/y2llCVRs78iS4RfXO+fdMPU19KpQo6IekYdWujrH9XVnGVYritI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736975537; c=relaxed/simple;
	bh=2ZpWGWIZQGahW4KTcLZDuEmDrA3/56z7zW8DoSQYrCM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=TUWbnJjyG0PHPbM4bMY4Xs9kAcW5EYtl9w46xbfay72mwfO4b+cNmHnx3FND23MqmaFINdtOZfVYnf09efw4scC0GbDPcwhGD/g9RLClR0/QEoruNU/peUSo4j7Sx3Ecds4a44UA8DK02TA6e7uvjxQBrszeEW2kpTWCOie583o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jC4ucRg3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jC4ucRg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736975533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XtkEm4NzqqwxKWqCtAwiSMGjKy3xElZkNMDyZ7F5OP8=;
	b=jC4ucRg3Q2t5wcScXd0WKc86EiB0QPxQu+YUh0KRLCwHlrv1YOFJU5FtSC19dVQ4CZT7Kp
	c6PFijbC4KGCNnrm/eNsH6D0qCzeipC9m89AcW+1cX1V48/tfFJ8rwhN85MH/Fqb3vWved
	ZoI1nf37mExi3s7ybo1SKJurPGY6SDw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-B-_VotIHN-mYRNKPdVZ0zw-1; Wed,
 15 Jan 2025 16:12:12 -0500
X-MC-Unique: B-_VotIHN-mYRNKPdVZ0zw-1
X-Mimecast-MFC-AGG-ID: B-_VotIHN-mYRNKPdVZ0zw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91C9F19560BB
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 21:12:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.218])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B6CA219560A3
	for <mptcp@lists.linux.dev>; Wed, 15 Jan 2025 21:12:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: consolidate suboption status.
Date: Wed, 15 Jan 2025 22:12:05 +0100
Message-ID: <7c8a258328ed6d235a100e3fa13c2da355119951.1736974476.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 466_VtstRUbszKquqJSICPcutqjACxa7gM3Fe-1UtPw_1736975531
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP maintains the received sub-options status is the bitmask carrying
the received suboptions and in several bitfields carrying per suboption
additional info.

Zeroing the bitmask before parsing is not enough to ensure a consistent
status, and the MPTCP code has to additionally clear some bitfiled
depending on the actually parsed suboption.

The above schema is fragile, and syzbot menaged to trigger a path where
a relevant bitfield is not cleared/initialized:

BUG: KMSAN: uninit-value in __mptcp_expand_seq net/mptcp/options.c:1030 [inline]
BUG: KMSAN: uninit-value in mptcp_expand_seq net/mptcp/protocol.h:864 [inline]
BUG: KMSAN: uninit-value in ack_update_msk net/mptcp/options.c:1060 [inline]
BUG: KMSAN: uninit-value in mptcp_incoming_options+0x2036/0x3d30 net/mptcp/options.c:1209
 __mptcp_expand_seq net/mptcp/options.c:1030 [inline]
 mptcp_expand_seq net/mptcp/protocol.h:864 [inline]
 ack_update_msk net/mptcp/options.c:1060 [inline]
 mptcp_incoming_options+0x2036/0x3d30 net/mptcp/options.c:1209
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
 tcp_rcv_established+0x1061/0x2510 net/ipv4/tcp_input.c:6264
 tcp_v4_do_rcv+0x7f3/0x11a0 net/ipv4/tcp_ipv4.c:1916
 tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595
 do_softirq+0x9a/0x100 kernel/softirq.c:462
 __local_bh_enable_ip+0x9f/0xb0 kernel/softirq.c:389
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x2758/0x57d0 net/core/dev.c:4493
 dev_queue_xmit include/linux/netdevice.h:3168 [inline]
 neigh_hh_output include/net/neighbour.h:523 [inline]
 neigh_output include/net/neighbour.h:537 [inline]
 ip_finish_output2+0x187c/0x1b70 net/ipv4/ip_output.c:236
 __ip_finish_output+0x287/0x810
 ip_finish_output+0x4b/0x600 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x15f/0x3f0 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:450 [inline]
 ip_local_out net/ipv4/ip_output.c:130 [inline]
 __ip_queue_xmit+0x1f2a/0x20d0 net/ipv4/ip_output.c:536
 ip_queue_xmit+0x60/0x80 net/ipv4/ip_output.c:550
 __tcp_transmit_skb+0x3cea/0x4900 net/ipv4/tcp_output.c:1468
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mptcp_get_options+0x2c0f/0x2f20 net/mptcp/options.c:397
 mptcp_incoming_options+0x19a/0x3d30 net/mptcp/options.c:1150
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
 tcp_rcv_established+0x1061/0x2510 net/ipv4/tcp_input.c:6264
 tcp_v4_do_rcv+0x7f3/0x11a0 net/ipv4/tcp_ipv4.c:1916
 tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595

Uninit was stored to memory at:
 put_unaligned_be32 include/linux/unaligned.h:68 [inline]
 mptcp_write_options+0x17f9/0x3100 net/mptcp/options.c:1417
 mptcp_options_write net/ipv4/tcp_output.c:465 [inline]
 tcp_options_write+0x6d9/0xe90 net/ipv4/tcp_output.c:759
 __tcp_transmit_skb+0x294b/0x4900 net/ipv4/tcp_output.c:1414
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mptcp_pm_add_addr_signal+0x3d7/0x4c0
 mptcp_established_options_add_addr net/mptcp/options.c:666 [inline]
 mptcp_established_options+0x1b9b/0x3a00 net/mptcp/options.c:884
 tcp_established_options+0x2c4/0x7d0 net/ipv4/tcp_output.c:1012
 __tcp_transmit_skb+0x5b7/0x4900 net/ipv4/tcp_output.c:1333
 tcp_transmit_skb net/ipv4/tcp_output.c:1486 [inline]
 tcp_write_xmit+0x3b90/0x9070 net/ipv4/tcp_output.c:2829
 __tcp_push_pending_frames+0xc4/0x380 net/ipv4/tcp_output.c:3012
 tcp_send_fin+0x9f6/0xf50 net/ipv4/tcp_output.c:3618
 __tcp_close+0x140c/0x1550 net/ipv4/tcp.c:3130
 __mptcp_close_ssk+0x74e/0x16f0 net/mptcp/protocol.c:2496
 mptcp_close_ssk+0x26b/0x2c0 net/mptcp/protocol.c:2550
 mptcp_pm_nl_rm_addr_or_subflow+0x635/0xd10 net/mptcp/pm_netlink.c:889
 mptcp_pm_nl_rm_subflow_received net/mptcp/pm_netlink.c:924 [inline]
 mptcp_pm_flush_addrs_and_subflows net/mptcp/pm_netlink.c:1688 [inline]
 mptcp_nl_flush_addrs_list net/mptcp/pm_netlink.c:1709 [inline]
 mptcp_pm_nl_flush_addrs_doit+0xe10/0x1630 net/mptcp/pm_netlink.c:1750
 genl_family_rcv_msg_doit net/netlink/genetlink.c:1115 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x1214/0x12c0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x375/0x650 net/netlink/af_netlink.c:2542
 genl_rcv+0x40/0x60 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0xf52/0x1260 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x10da/0x11e0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x30f/0x380 net/socket.c:726
 ____sys_sendmsg+0x877/0xb60 net/socket.c:2583
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2637
 __sys_sendmsg net/socket.c:2669 [inline]
 __do_sys_sendmsg net/socket.c:2674 [inline]
 __se_sys_sendmsg net/socket.c:2672 [inline]
 __x64_sys_sendmsg+0x212/0x3c0 net/socket.c:2672
 x64_sys_call+0x2ed6/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
 mptcp_pm_add_addr_received+0x95f/0xdd0 net/mptcp/pm.c:235
 mptcp_incoming_options+0x2983/0x3d30 net/mptcp/options.c:1169
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233
 tcp_rcv_state_process+0x2a38/0x49d0 net/ipv4/tcp_input.c:6972
 tcp_v4_do_rcv+0xbf9/0x11a0 net/ipv4/tcp_ipv4.c:1939
 tcp_v4_rcv+0x51df/0x5750 net/ipv4/tcp_ipv4.c:2351
 ip_protocol_deliver_rcu+0x2a3/0x13d0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x336/0x500 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish+0x4a2/0x520 net/ipv4/ip_input.c:447
 NF_HOOK include/linux/netfilter.h:314 [inline]
 ip_rcv+0xcd/0x380 net/ipv4/ip_input.c:567
 __netif_receive_skb_one_core net/core/dev.c:5704 [inline]
 __netif_receive_skb+0x319/0xa00 net/core/dev.c:5817
 process_backlog+0x4ad/0xa50 net/core/dev.c:6149
 __napi_poll+0xe7/0x980 net/core/dev.c:6902
 napi_poll net/core/dev.c:6971 [inline]
 net_rx_action+0xa5a/0x19b0 net/core/dev.c:7093
 handle_softirqs+0x1a0/0x7c0 kernel/softirq.c:561
 __do_softirq+0x14/0x1a kernel/softirq.c:595

Local variable mp_opt created at:
 mptcp_incoming_options+0x119/0x3d30 net/mptcp/options.c:1127
 tcp_data_queue+0xb4/0x7be0 net/ipv4/tcp_input.c:5233

The current schema is too fragile; address the issue grouping all the
state-related data together and clearing the whole group instead of
just the bitmask. This also cleans-up the code a bit, as there is no
need anymore to individually clear "random" bitfield in a couple of
places.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Reported-by: syzbot+23728c2df58b3bd175ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=23728c2df58b3bd175ad
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c  | 13 +++++--------
 net/mptcp/protocol.h | 30 ++++++++++++++++--------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a62bc874bf1e..c322a061b57b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -108,7 +108,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
-			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
@@ -157,11 +156,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		pr_debug("DSS\n");
 		ptr++;
 
-		/* we must clear 'mpc_map' be able to detect MP_CAPABLE
-		 * map vs DSS map in mptcp_incoming_options(), and reconstruct
-		 * map info accordingly
-		 */
-		mp_opt->mpc_map = 0;
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
 		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
@@ -369,8 +363,11 @@ void mptcp_get_options(const struct sk_buff *skb,
 	const unsigned char *ptr;
 	int length;
 
-	/* initialize option status */
-	mp_opt->suboptions = 0;
+	/* Ensure that casting the whole status to u32 is efficent and safe */
+	BUILD_BUG_ON(sizeof_field(struct mptcp_options_received, status) != sizeof(u32));
+	BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct mptcp_options_received, status),
+				 sizeof(u32)));
+	*(u32 *)&mp_opt->status = 0;
 
 	length = (th->doff * 4) - sizeof(struct tcphdr);
 	ptr = (const unsigned char *)(th + 1);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index a93e661ef5c4..1842d48ff0aa 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -149,22 +149,24 @@ struct mptcp_options_received {
 	u32	subflow_seq;
 	u16	data_len;
 	__sum16	csum;
-	u16	suboptions;
+	struct_group(status,
+		u16 suboptions;
+		u16 use_map:1,
+		    dsn64:1,
+		    data_fin:1,
+		    use_ack:1,
+		    ack64:1,
+		    mpc_map:1,
+		    reset_reason:4,
+		    reset_transient:1,
+		    echo:1,
+		    backup:1,
+		    deny_join_id0:1,
+		    __unused:2;
+	);
+	u8	join_id;
 	u32	token;
 	u32	nonce;
-	u16	use_map:1,
-		dsn64:1,
-		data_fin:1,
-		use_ack:1,
-		ack64:1,
-		mpc_map:1,
-		reset_reason:4,
-		reset_transient:1,
-		echo:1,
-		backup:1,
-		deny_join_id0:1,
-		__unused:2;
-	u8	join_id;
 	u64	thmac;
 	u8	hmac[MPTCPOPT_HMAC_LEN];
 	struct mptcp_addr_info addr;
-- 
2.47.1

