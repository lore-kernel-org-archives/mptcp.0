Content-Type: multipart/mixed; boundary="===============8453852994427632877=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] stack trace for pure ACK
Date: Tue, 27 Jun 2017 12:22:01 -0700
Message-ID: <c238a2ab-ea42-1118-012c-102e305d2703@oracle.com>
In-Reply-To: 613f420f-a82e-2a7e-38bc-143578a9305a@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 55

--===============8453852994427632877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here is the code and stack trace

static struct sk_buff *
mptcp_process_options_ack(struct sock *sk, struct sk_buff *skb)
{
         struct tcp_sock *tp =3D tcp_sk(sk);
         const struct tcphdr *th =3D tcp_hdr(skb);

         skb->mptcp_flags =3D 0;
         skb->mptcp_dss_off =3D 0;

         tcp_parse_mptcp_options(skb, &tp->mptcp->rx_opt);
         if (mptcp_handle_options(sk, th, skb)) {
                 mptcp_reset_mopt(tp);
                 __skb_unlink(skb, &sk->sk_receive_queue);
                 __kfree_skb(skb);
                 skb =3D NULL;
         }
         if ((skb !=3D NULL) && skb->len =3D=3D 0) {
                 skb =3D mptcp_process_ack(sk, skb);
                 if (skb !=3D NULL && skb->len =3D=3D 0) {
                         WARN_ON(1); <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
                         /* Pure ack */
                         __skb_unlink(skb, &sk->sk_receive_queue);
                         __kfree_skb(skb);
                         skb =3D NULL;
                 }
         }
         return (skb);

[  122.755782] WARNING: CPU: 0 PID: 33 at net/mptcp/mptcp_input.c:1074 =

mptcp_data_ready+0x6c3/0x1910()
[  122.755784] Modules linked in: i915 i2c_algo_bit drm_kms_helper drm =

ip6table_filter ip6_tables iptable_filter ip_tables x_tables des_generic =

md4 nls_utf8 cifs fscache vboxpci(OE) vboxnetadp(OE) vboxnetflt(OE) =

vboxdrv(OE) joydev snd_hda_codec_hdmi snd_hda_codec_realtek =

snd_hda_codec_generic snd_hda_intel snd_hda_controller snd_hda_codec =

snd_hda_core snd_pcm snd_hwdep snd_seq_midi snd_seq_midi_event =

intel_rapl snd_rawmidi x86_pkg_temp_thermal snd_seq intel_powerclamp =

coretemp crct10dif_pclmul crc32_pclmul snd_timer snd_seq_device snd =

aesni_intel mei_me ie31200_edac edac_core mei aes_x86_64 glue_helper lrw =

gf128mul ablk_helper cryptd soundcore wmi lpc_ich mac_hid parport_pc =

ppdev lp parport autofs4 e1000e ptp hid_generic usbhid hid ahci libahci =

pps_core video
[  122.755836] CPU: 0 PID: 33 Comm: khugepaged Tainted: G W  OE   =

4.1.39--independent-mptcp+ #83
[  122.755837] Hardware name: LENOVO 2742AE6/MAHOBAY, BIOS 9SKT70AUS =

06/07/2013
[  122.755839]  0000000000000286 00000000afef9408 ffff88021e2037f8 =

ffffffff818115ed
[  122.755843]  0000000000000000 ffffffff81d21445 ffff88021e203838 =

ffffffff8107ee6a
[  122.755846]  ffff88021e203848 ffff8802117c1d22 ffff880211928898 =

ffff8801ecf5b900

[  122.815974] Call Trace:
[  122.815975]  <IRQ>  [<ffffffff818115ed>] dump_stack+0x63/0x81
[  122.815981]  [<ffffffff8107ee6a>] warn_slowpath_common+0x8a/0xc0
[  122.815983]  [<ffffffff8107ef9a>] warn_slowpath_null+0x1a/0x20
[  122.815986]  [<ffffffff817e9e83>] mptcp_data_ready+0x6c3/0x1910
[  122.815990]  [<ffffffff81755395>] ? tcp_set_rto+0x25/0x40
[  122.815993]  [<ffffffff817576ae>] tcp_data_queue+0x53e/0xe70
[  122.815996]  [<ffffffff8175823f>] tcp_rcv_established+0x25f/0x790
[  122.815999]  [<ffffffff817651fb>] tcp_v4_do_rcv+0x10b/0x2b0
[  122.816003]  [<ffffffff81765524>] mptcp_v4_do_rcv+0x184/0x320
[  122.816005]  [<ffffffff81766109>] tcp_v4_rcv+0x8d9/0x9f0
[  122.816008]  [<ffffffff817356a4>] ? nf_iterate+0xa4/0xc0
[  122.816011]  [<ffffffff8173c3c6>] ip_local_deliver_finish+0x66/0x100
[  122.816014]  [<ffffffff8173c915>] ip_local_deliver+0x55/0xc0
[  122.816018]  [<ffffffff8173c360>] ? inet_del_offload+0x40/0x40
[  122.816021]  [<ffffffff8173c4da>] ip_rcv_finish+0x7a/0x310
[  122.816024]  [<ffffffff8173cc3a>] ip_rcv+0x2ba/0x3d0
[  122.816026]  [<ffffffff817f9133>] ? packet_rcv+0x43/0x3c0
[  122.816029]  [<ffffffff81701f14>] __netif_receive_skb_core+0x264/0xa30
[  122.816032]  [<ffffffff817026f8>] __netif_receive_skb+0x18/0x60
[  122.816034]  [<ffffffff81702772>] netif_receive_skb_internal+0x32/0xb0
[  122.816036]  [<ffffffff81703498>] napi_gro_receive+0xf8/0x130
[  122.816045]  [<ffffffffc00bd0aa>] e1000_receive_skb+0x8a/0xf0 [e1000e]
[  122.816054]  [<ffffffffc00becd6>] e1000_clean_rx_irq+0x266/0x440 [e1000e]
[  122.816062]  [<ffffffffc00c61dc>] e1000e_poll+0x7c/0x2f0 [e1000e]
[  122.816065]  [<ffffffff810eee69>] ? enqueue_hrtimer+0x29/0xb0
[  122.816068]  [<ffffffff81702c8a>] net_rx_action+0x1ca/0x330
[  122.816071]  [<ffffffff81083813>] __do_softirq+0x113/0x2d0
[  122.816074]  [<ffffffff81083b5d>] irq_exit+0xad/0xb0
[  122.816076]  [<ffffffff8181b6e8>] do_IRQ+0x58/0xf0
[  122.816080]  [<ffffffff818195ae>] common_interrupt+0x6e/0x6e
[  122.816081]  <EOI>  [<ffffffff8102037d>] ? native_sched_clock+0x2d/0x90
[  122.816087]  [<ffffffff816a457d>] ? cpuidle_enter_state+0x8d/0x240
[  122.816089]  [<ffffffff816a4562>] ? cpuidle_enter_state+0x72/0x240
[  122.816093]  [<ffffffff816a4767>] cpuidle_enter+0x17/0x20
[  122.816095]  [<ffffffff810c4e51>] cpu_startup_entry+0x311/0x420
[  122.816098]  [<ffffffff81806efc>] rest_init+0x7c/0x80
[  122.816101]  [<ffffffff81f4d01a>] start_kernel+0x48c/0x4ad
[  122.816104]  [<ffffffff81f4c120>] ? early_idt_handler_array+0x120/0x120
[  122.816107]  [<ffffffff81f4c339>] x86_64_start_reservations+0x2a/0x2c
[  122.816110]  [<ffffffff81f4c480>] x86_64_start_kernel+0x145/0x168
[  122.816112] ---[ end trace 2bb70ec6f89c805c ]---

With everything else on my mind and the fact that things worked, no =

retransmissions etc I did not look very deep at every possible issue. =

Looking at the code just now seems like there might be some more work =

needed. However this is just a suggestion/prototype. I want to put in =

more work only if we want to go down this route.

Rao.



--===============8453852994427632877==--
