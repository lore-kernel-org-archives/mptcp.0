Content-Type: multipart/mixed; boundary="===============2612136054723901074=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][BUG] kmemleak in cookie_tcp_reqsk_alloc
Date: Wed, 09 Sep 2020 14:39:42 +0800
Message-ID: <CA+WQbwsbesSDpPqyPO=jjC8O=ncX13rOiW1+w72BeiQJcD9Dbw@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 5766

--===============2612136054723901074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When I run today's mptcp_net-next kernel with selftest script mptcp_join.sh,
I get this kmemleak report:

unreferenced object 0xffff9e83383af608 (size 368):
  comm "softirq", pid 0, jiffies 4294809590 (age 237.243s)
  hex dump (first 32 bytes):
    0a 00 03 02 0a 00 01 01 6f b6 93 1c b0 3f 1f 27  ........o....?.'
    02 00 0c 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000004235750>] inet_reqsk_alloc+0x21/0x130
    [<00000000e50be1b8>] cookie_tcp_reqsk_alloc+0x29/0xf0
    [<00000000de164302>] cookie_v4_check+0x14d/0x690
    [<000000002f8e27b7>] tcp_v4_do_rcv+0x18d/0x1f0
    [<000000003c898e94>] tcp_v4_rcv+0xc5f/0xcf0
    [<00000000d8a4f3ab>] ip_protocol_deliver_rcu+0x2b/0x180
    [<00000000098dd537>] ip_local_deliver_finish+0x4b/0x60
    [<000000007919d713>] __netif_receive_skb_one_core+0x67/0x70
    [<00000000d814cfd1>] process_backlog+0x9d/0x170
    [<000000009fa3369b>] net_rx_action+0xf1/0x380
    [<000000000750ea92>] __do_softirq+0xd9/0x2e4
    [<0000000083859707>] asm_call_on_stack+0xf/0x20
    [<000000009f5b0716>] do_softirq_own_stack+0x39/0x50
    [<000000006f63cba9>] do_softirq+0x5e/0x70
    [<00000000ade94a36>] __local_bh_enable_ip+0x4b/0x50
    [<00000000cd74b5d0>] ip_finish_output2+0x19c/0x560

My kernel version is export/20200909T050747.

-Geliang
--===============2612136054723901074==--
