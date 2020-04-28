Content-Type: multipart/mixed; boundary="===============0757911929999338764=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/6] mptcp: move option parsing into
 mptcp_incoming_options()
Date: Tue, 28 Apr 2020 10:39:13 -0700
Message-ID: <alpine.OSX.2.22.394.2004281012140.24016@masokan-mobl.amr.corp.intel.com>
In-Reply-To: c8efe5b26dde05b7f4053f6f070145151ca5a6e6.1588082498.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4264

--===============0757911929999338764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 28 Apr 2020, Paolo Abeni wrote:

> The mptcp_options_received structure carries several per
> packet flags (mp_capable, mp_join, etc.). Such field must
> be cleared on each packet, even on dropped ones or packet
> not carrying any MPTCP options, but the current mptcp
> code clear them only on TCP option reset.
>
> On several races/corner cases we end-up with stray bits in
> incoming options, leading to WARN_ON splats. e.g.:
>
> [  171.164906] Bad mapping: ssn=3D32714 map_seq=3D1 map_data_len=3D32713
> [  171.165006] WARNING: CPU: 1 PID: 5026 at net/mptcp/subflow.c:533 warn_=
bad_map (linux-mptcp/net/mptcp/subflow.c:533 linux-mptcp/net/mptcp/subflow.=
c:531)
> [  171.167632] Modules linked in: ip6_vti ip_vti ip_gre ipip sit tunnel4 =
ip_tunnel geneve ip6_udp_tunnel udp_tunnel macsec macvtap tap ipvlan macvla=
n 8021q garp mrp xfrm_interface veth netdevsim nlmon dummy team bonding vca=
n bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun binfmt_misc intel_rapl_=
msr intel_rapl_common rfkill kvm_intel kvm irqbypass crct10dif_pclmul crc32=
_pclmul ghash_clmulni_intel joydev virtio_balloon pcspkr i2c_piix4 sunrpc i=
p_tables xfs libcrc32c crc32c_intel serio_raw virtio_console ata_generic vi=
rtio_blk virtio_net net_failover failover ata_piix libata
> [  171.199464] CPU: 1 PID: 5026 Comm: repro Not tainted 5.7.0-rc1.mptcp_f=
227fdf5d388+ #95
> [  171.200886] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.12.0-2.fc30 04/01/2014
> [  171.202546] RIP: 0010:warn_bad_map (linux-mptcp/net/mptcp/subflow.c:53=
3 linux-mptcp/net/mptcp/subflow.c:531)
> [  171.206537] Code: c1 ea 03 0f b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d=
0 7c 04 84 d2 75 1d 8b 55 3c 44 89 e6 48 c7 c7 20 51 13 95 e8 37 8b 22 fe <=
0f> 0b 48 83 c4 08 5b 5d 41 5c c3 89 4c 24 04 e8 db d6 94 fe 8b 4c
> [  171.220473] RSP: 0018:ffffc90000150560 EFLAGS: 00010282
> [  171.221639] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
0000000
> [  171.223108] RDX: 0000000000000000 RSI: 0000000000000008 RDI: fffff5200=
002a09e
> [  171.224388] RBP: ffff8880aa6e3c00 R08: 0000000000000001 R09: fffffbfff=
2ec9955
> [  171.225706] R10: ffffffff9764caa7 R11: fffffbfff2ec9954 R12: 000000000=
0007fca
> [  171.227211] R13: ffff8881066f4a7f R14: ffff8880aa6e3c00 R15: 000000000=
0000020
> [  171.228460] FS:  00007f8623719740(0000) GS:ffff88810be00000(0000) knlG=
S:0000000000000000
> [  171.230065] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  171.231303] CR2: 00007ffdab190a50 CR3: 00000001038ea006 CR4: 000000000=
0160ee0
> [  171.232586] Call Trace:
> [  171.233109]  <IRQ>
> [  171.233531] get_mapping_status (linux-mptcp/net/mptcp/subflow.c:691)
> [  171.234371] mptcp_subflow_data_available (linux-mptcp/net/mptcp/subflo=
w.c:736 linux-mptcp/net/mptcp/subflow.c:832)
> [  171.238181] subflow_state_change (linux-mptcp/net/mptcp/subflow.c:1085=
 (discriminator 1))
> [  171.239066] tcp_fin (linux-mptcp/net/ipv4/tcp_input.c:4217)
> [  171.240123] tcp_data_queue (linux-mptcp/./include/linux/compiler.h:199=
 linux-mptcp/net/ipv4/tcp_input.c:4822)
> [  171.245083] tcp_rcv_established (linux-mptcp/./include/linux/skbuff.h:=
1785 linux-mptcp/./include/net/tcp.h:1774 linux-mptcp/./include/net/tcp.h:1=
847 linux-mptcp/net/ipv4/tcp_input.c:5238 linux-mptcp/net/ipv4/tcp_input.c:=
5730)
> [  171.254089] tcp_v4_rcv (linux-mptcp/./include/linux/spinlock.h:393 lin=
ux-mptcp/net/ipv4/tcp_ipv4.c:2009)
> [  171.258969] ip_protocol_deliver_rcu (linux-mptcp/net/ipv4/ip_input.c:2=
04 (discriminator 1))
> [  171.260214] ip_local_deliver_finish (linux-mptcp/./include/linux/rcupd=
ate.h:651 linux-mptcp/net/ipv4/ip_input.c:232)
> [  171.261389] ip_local_deliver (linux-mptcp/./include/linux/netfilter.h:=
307 linux-mptcp/./include/linux/netfilter.h:301 linux-mptcp/net/ipv4/ip_inp=
ut.c:252)
> [  171.265884] ip_rcv (linux-mptcp/./include/linux/netfilter.h:307 linux-=
mptcp/./include/linux/netfilter.h:301 linux-mptcp/net/ipv4/ip_input.c:539)
> [  171.273666] process_backlog (linux-mptcp/./include/linux/rcupdate.h:65=
1 linux-mptcp/net/core/dev.c:6135)
> [  171.275328] net_rx_action (linux-mptcp/net/core/dev.c:6572 linux-mptcp=
/net/core/dev.c:6640)
> [  171.280472] __do_softirq (linux-mptcp/./arch/x86/include/asm/jump_labe=
l.h:25 linux-mptcp/./include/linux/jump_label.h:200 linux-mptcp/./include/t=
race/events/irq.h:142 linux-mptcp/kernel/softirq.c:293)
> [  171.281379] do_softirq_own_stack (linux-mptcp/arch/x86/entry/entry_64.=
S:1083)
> [  171.282358]  </IRQ>
>
> We could address the issue clearing explicitly the relevant fields
> in several places - tcp_parse_option, tcp_fast_parse_options,
> possibly others.
>
> Instead we move mptcp option parsing into the already existing
> mptcp ingress hook, so that we need to clear the fields in a single
> place.
>
> This allows us dropping an mptcp hook from the TCP code and
> removing the quite large mptcp_options_received from the tcp_sock
> struct. As the filp side the MPTCP sockets will traverse the
> option space twice (in tcp_parse_option() and in
> mptcp_incoming_options(). That looks acceptable: we already
> do that for syn and 3rd ack packets, plain TCP socket will
> benefit from it, and even MPTCP sockets will experience better
> code locality, reducing the jumps between TCP and MPTCP code.
>


At first glance it seems unconventional to move the option parsing out of =

tcp_parse_option, but the parsed mptcp information isn't used at the TCP =

layer anyway. I agree that the tradeoffs look acceptable.

I think it would be good to target -net.


Thanks,

--
Mat Martineau
Intel
--===============0757911929999338764==--
