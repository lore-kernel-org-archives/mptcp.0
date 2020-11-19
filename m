Content-Type: multipart/mixed; boundary="===============9192514437303748607=="
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju at linaro.org>
To: mptcp at lists.01.org
Subject: [MPTCP] WARNING: net/mptcp/protocol.c:719 mptcp_reset_timer+0x40/0x50
Date: Thu, 19 Nov 2020 12:34:55 +0530
Message-ID: <CA+G9fYvkRAKBzthvdurQ44q_f9HimG2ur9+M=bgyZ0c+XWucgg@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6807

--===============9192514437303748607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While running kselftest net/mptcp: mptcp_join.sh on x86_64 device running
linux next 20201118 tag the following warning was noticed.

# selftests: net/mptcp: mptcp_join.sh
<trim>
[ 1276.053194] ------------[ cut here ]------------
[ 1276.057857] WARNING: CPU: 2 PID: 27452 at
/usr/src/kernel/net/mptcp/protocol.c:719 mptcp_reset_timer+0x40/0x50
[ 1276.067870] Modules linked in: xt_tcpudp xt_bpf act_mirred cls_u32
ip6table_mangle mpls_gso mpls_iptunnel mpls_router sch_etf
ip6table_nat xt_nat iptable_nat nf_nat ip6table_filter xt_conntrack
nf_conntrack nf_defrag_ipv4 libcrc32c ip6_tables nf_defrag_ipv6 bridge
stp llc vrf xt_policy sch_fq 8021q iptable_filter xt_mark ip_tables
x_tables cls_bpf sch_ingress veth algif_hash x86_pkg_temp_thermal fuse
[last unloaded: test_blackhole_dev]
[ 1276.106416] CPU: 2 PID: 27452 Comm: kworker/2:4 Tainted: G        W
    K   5.10.0-rc4-next-20201118 #1
[ 1276.115808] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[ 1276.123293] Workqueue: events mptcp_worker
[ 1276.127407] RIP: 0010:mptcp_reset_timer+0x40/0x50
[ 1276.132119] Code: 45 ff 3c 07 74 22 48 8b 87 30 08 00 00 48 85 c0
74 18 48 8b 15 e1 34 d4 00 48 8d b7 50 06 00 00 48 01 c2 e8 72 3b ca
ff c9 c3 <0f> 0b b8 c8 00 00 00 eb df 0f 1f 80 00 00 00 00 0f 1f 44 00
00 55
[ 1276.150863] RSP: 0018:ffffa20b41137d28 EFLAGS: 00010246
[ 1276.156091] RAX: 0000000000000000 RBX: ffff95a6d444b090 RCX: 00000000000=
00000
[ 1276.163222] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: ffff95a6d44=
4a800
[ 1276.170354] RBP: ffffa20b41137d30 R08: 0000000000000000 R09: 00000000000=
00000
[ 1276.177487] R10: 0000000000024200 R11: fefefefefefefeff R12: ffff95a6d44=
4a800
[ 1276.184621] R13: 0000000000000000 R14: ffff95a6da9e44d8 R15: 00000000000=
00000
[ 1276.191752] FS:  0000000000000000(0000) GS:ffff95a9dfd00000(0000)
knlGS:0000000000000000
[ 1276.199838] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1276.205585] CR2: 00007f1770beb810 CR3: 0000000131026005 CR4: 00000000003=
706e0
[ 1276.212718] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 1276.219849] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 1276.226983] Call Trace:
[ 1276.229438]  mptcp_push_pending+0x5bf/0x6c0
[ 1276.233633]  mptcp_worker+0xf0/0x650
[ 1276.237218]  ? mptcp_worker+0xf0/0x650
[ 1276.240971]  ? process_one_work+0x21c/0x5e0
[ 1276.245157]  process_one_work+0x289/0x5e0
[ 1276.249171]  worker_thread+0x3c/0x3f0
[ 1276.252836]  ? __kthread_parkme+0x6f/0xa0
[ 1276.256848]  ? process_one_work+0x5e0/0x5e0
[ 1276.261034]  kthread+0x142/0x160
[ 1276.264269]  ? kthread_insert_work_sanity_check+0x60/0x60
[ 1276.269674]  ret_from_fork+0x22/0x30
[ 1276.273254] irq event stamp: 0
[ 1276.276316] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1276.282587] hardirqs last disabled at (0): [<ffffffffbbfbbf4d>]
copy_process+0x75d/0x1d60
[ 1276.290759] softirqs last  enabled at (0): [<ffffffffbbfbbf4d>]
copy_process+0x75d/0x1d60
[ 1276.298932] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1276.305197] ---[ end trace fe4f318db7e06cdb ]---

Reported-by: Naresh Kamboju <naresh.kamboju(a)linaro.org>

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git
  git commit: 2052923327794192c5d884623b5ee5fec1867bda
  git describe: next-20201118
  make_kernelversion: 5.10.0-rc4
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-corei7-64/lkf=
t/linux-next/902/config

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1952957#L15217

-- =

Linaro LKFT
https://lkft.linaro.org
--===============9192514437303748607==--
