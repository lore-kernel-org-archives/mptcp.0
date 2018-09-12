Content-Type: multipart/mixed; boundary="===============6817069566387277288=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] mptcp: Iterate over subflow-list while holding
 the lock in tcp_splice_read
Date: Wed, 12 Sep 2018 11:16:40 -0700
Message-ID: <20180912181640.6663-3-cpaasch@apple.com>
In-Reply-To: 20180912181640.6663-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 717

--===============6817069566387277288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Subflows can get removed from under our feet, thus we might be iterating
on garbage here.

That can panic like:

[52899.160112] BUG: unable to handle kernel NULL pointer dereference at    =
       (null)
[52899.160157] IP: tcp_splice_read+0x225/0x330
[52899.160166] PGD 8000000164ff8067 P4D 8000000164ff8067 PUD 163d67067 PMD 0
[52899.160189] Oops: 0000 [#1] SMP PTI
[52899.160198] Modules linked in: binfmt_misc xt_REDIRECT nf_nat_redirect x=
t_statistic xt_mark ipt_MASQUERADE nf_nat_masquerade_ipv4 xt_connmark xt_na=
t xt_comment xt_geoip(O) xt_conntrack iptable_mangle iptable_nat nf_nat_ipv=
4 nf_nat iptable_filter sch_fq_codel nf_conntrack_tftp nf_conntrack_ipv4 nf=
_defrag_ipv4 nf_conntrack_proto_gre nf_conntrack_irc nf_conntrack_ftp nf_co=
nntrack pcspkr tun it87 hwmon_vid vfat fat x86_pkg_temp_thermal intel_power=
clamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_=
clmulni_intel pcbc aesni_intel crypto_simd glue_helper cryptd iTCO_wdt i2c_=
designware_platform iTCO_vendor_support i2c_designware_core intel_cstate in=
tel_rapl_perf idma64 i2c_i801 sg virt_dma pinctrl_sunrisepoint wmi pinctrl_=
intel acpi_pad intel_lpss_pci intel_lpss mei_me pcc_cpufreq
[52899.160410]  mfd_core intel_pch_thermal mei shpchp ip_tables xfs libcrc3=
2c sd_mod crc32c_intel igb ptp sdhci_pci pps_core sdhci dca i915 ahci i2c_a=
lgo_bit mmc_core libahci drm_kms_helper syscopyarea sysfillrect sysimgblt f=
b_sys_fops libata drm video [last unloaded: pcspkr]
[52899.160495] CPU: 0 PID: 21938 Comm: redsocks Tainted: G           O    4=
.14.64+ #1
[52899.160506] Hardware name: Default string Default string/Default string,=
 BIOS 5.12 07/01/2018
[52899.160518] task: ffff880164d45e00 task.stack: ffffc90002824000
[52899.160536] RIP: 0010:tcp_splice_read+0x225/0x330
[52899.160546] RSP: 0018:ffffc90002827dd8 EFLAGS: 00010286
[52899.160558] RAX: 0000000000000000 RBX: ffff88015b965280 RCX: 00000000001=
00000
[52899.160569] RDX: ffff88015ba30180 RSI: ffffc90002827ee8 RDI: ffff8801164=
d82c0
[52899.160579] RBP: ffffc90002827e50 R08: 00000000ffffffff R09: 00000000000=
00000
[52899.160589] R10: ffff880163940f00 R11: ffff88015ba30180 R12: ffff8801164=
d82c0
[52899.160599] R13: ffff88015ba30180 R14: ffffc90002827ee8 R15: 00000000000=
00003
[52899.160611] FS:  00007fae07922740(0000) GS:ffff88016ec00000(0000) knlGS:=
0000000000000000
[52899.160624] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[52899.160634] CR2: 0000000000000000 CR3: 0000000164c9a006 CR4: 00000000003=
606f0
[52899.160646] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[52899.160656] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[52899.160664] Call Trace:
[52899.160684]  ? kmem_cache_free+0x1aa/0x1c0
[52899.160702]  sock_splice_read+0x25/0x30
[52899.160719]  do_splice_to+0x76/0x90
[52899.160735]  SyS_splice+0x6fd/0x750
[52899.160750]  ? syscall_trace_enter+0x1cd/0x2b0
[52899.160766]  do_syscall_64+0x79/0x1b0
[52899.160784]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[52899.160795] RIP: 0033:0x7fae07213493
[52899.160804] RSP: 002b:00007fff48ffdfe8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000113
[52899.160819] RAX: ffffffffffffffda RBX: 00007fff48ffe040 RCX: 00007fae072=
13493
[52899.160829] RDX: 000000000000008b RSI: 0000000000000000 RDI: 00000000000=
00081
[52899.160839] RBP: 0000000000000081 R08: 0000000000100000 R09: 00000000000=
00003
[52899.160849] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000022=
14d40
[52899.160859] R13: 0000000000000081 R14: 0000000000000002 R15: 00000000022=
124f0
[52899.160870] Code: ff ff 48 8b 83 d0 07 00 00 48 8b 00 48 85 c0 0f 84 33 =
fe ff ff 44 8b 05 7a eb d3 00 41 f7 d0 0f 1f 44 00 00 48 8b 80 e8 07 00 00 =
<48> 8b 00 48 85 c0 75 ec e9 10 fe ff ff 0f b6 43 12 3c 01 0f 85
[52899.161029] RIP: tcp_splice_read+0x225/0x330 RSP: ffffc90002827dd8
[52899.161038] CR2: 0000000000000000

Github-issue: https://github.com/multipath-tcp/mptcp/issues/279

Fixes: ee4f8f6ba775 ("Support tcp_read_sock")
Reported-by: https://github.com/wapsi
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
(cherry picked from commit 80671d2955c1268367a651d037934e302c02d99c)
Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
---
 net/ipv4/tcp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index aec586819436..59ac6ef82258 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -811,13 +811,6 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *p=
pos,
 =

 	sock_rps_record_flow(sk);
 =

-#ifdef CONFIG_MPTCP
-	if (mptcp(tcp_sk(sk))) {
-		struct sock *sk_it;
-		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it)
-			sock_rps_record_flow(sk_it);
-	}
-#endif
 	/*
 	 * We can't seek on a socket input
 	 */
@@ -828,6 +821,14 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *p=
pos,
 =

 	lock_sock(sk);
 =

+#ifdef CONFIG_MPTCP
+	if (mptcp(tcp_sk(sk))) {
+		struct sock *sk_it;
+		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it)
+			sock_rps_record_flow(sk_it);
+	}
+#endif
+
 	timeo =3D sock_rcvtimeo(sk, sock->file->f_flags & O_NONBLOCK);
 	while (tss.len) {
 		ret =3D __tcp_splice_read(sk, &tss);
-- =

2.16.2


--===============6817069566387277288==--
