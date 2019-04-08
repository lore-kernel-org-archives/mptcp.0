Content-Type: multipart/mixed; boundary="===============3148049913425568736=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] memory accounting issue with current mptcp-proposal branch
Date: Mon, 08 Apr 2019 14:33:34 -0700
Message-ID: <alpine.OSX.2.21.1904081430360.5172@mjmartin-mac01.local>
In-Reply-To: 5c6d99bb6d2861fcdba5d2fd05b4146fcc486050.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1056

--===============3148049913425568736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 4 Apr 2019, Paolo Abeni wrote:

> Hi all,
>
> I just checked-out the mptcp-proposal and did some tests vs a debug build=
 (CONFIG_KASAN and several CONFIG_*DEBUG* enabled).
>
> I also have the local change reported at the bottom, just to made the sel=
f-test a little bit more stressing.
>
> Running:
>
> while true; do ./mptcp_connect.sh; done

Thanks Paolo. I can duplicate this warning, but haven't tracked down the =

cause yet.


Mat



>
> I get the following splat after a few iterations:
>
> [  574.215874] WARNING: CPU: 2 PID: 3538 at net/core/stream.c:206 sk_stre=
am_kill_queues+0x370/0x510
> [  574.217403] Modules linked in: kvm_intel kvm irqbypass crct10dif_pclmu=
l crc32_pclmul ghash_clmulni_intel joydev pcspkr virtio_balloon i2c_piix4 s=
unrpc ip_tables xfs libcrc32c crc32c_intel serio_raw ata_generic virtio_net=
 virtio_blk net_failover failover virtio_console ata_piix libata
> [  574.221141] CPU: 2 PID: 3538 Comm: mptcp_connect Not tainted 5.0.0.mpt=
cp_dbg_b0afc0265a8b+ #10
> [  574.222219] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> [  574.223781] RIP: 0010:sk_stream_kill_queues+0x370/0x510
> [  574.224432] Code: 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 0f b=
6 04 02 84 c0 74 04 3c 03 7e 43 8b b3 40 02 00 00 eb 92 0f 0b 85 f6 74 be <=
0f> 0b 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b e9 ed fe
> [  574.226522] RSP: 0018:ffff8881033cfaf8 EFLAGS: 00010206
> [  574.227110] RAX: 0000000000000000 RBX: ffff88803581ee40 RCX: 000000000=
0000020
> [  574.227968] RDX: 1ffff11006b03e19 RSI: 0000000000000b00 RDI: ffff88803=
581f0c8
> [  574.228779] RBP: ffff88803581f080 R08: ffffed1021e7db10 R09: ffffed102=
1e7db0f
> [  574.229570] R10: ffffed1021e7db0f R11: ffff88810f3ed87b R12: ffffffff9=
cac4fa0
> [  574.230349] R13: ffff88803581efa8 R14: ffff88810b1a1700 R15: 00000000f=
8b7605b
> [  574.231205] FS:  00007f6446d5c740(0000) GS:ffff88810f200000(0000) knlG=
S:0000000000000000
> [  574.232219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  574.232942] CR2: 00000000008b3ad0 CR3: 0000000108d20002 CR4: 000000000=
01606e0
> [  574.233778] Call Trace:
> [  574.234093]  inet_csk_destroy_sock+0x15c/0x3a0
> [  574.234607]  tcp_rcv_state_process+0x1264/0x2391
> [  574.236230]  tcp_v4_do_rcv+0x2bc/0x790
> [  574.236680]  __release_sock+0x120/0x360
> [  574.237132]  tcp_close+0x540/0xeb0
> [  574.237590]  inet_release+0xdc/0x1c0
> [  574.238066]  __sock_release+0x1d2/0x2a0
> [  574.238578]  mptcp_close+0x182/0x380
> [  574.239066]  inet_release+0xdc/0x1c0
> [  574.239494]  __sock_release+0xc5/0x2a0
> [  574.239935]  sock_close+0x11/0x20
> [  574.240343]  __fput+0x261/0x800
> [  574.240734]  task_work_run+0x10e/0x190
> [  574.241196]  exit_to_usermode_loop+0x136/0x160
> [  574.241739]  do_syscall_64+0x3c3/0x480
> [  574.242196]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [  574.242881] RIP: 0033:0x7f64468667a0
> [  574.243339] Code: 00 64 c7 00 0d 00 00 00 b8 ff ff ff ff eb 90 b8 ff f=
f ff ff eb 89 0f 1f 40 00 83 3d fd c7 2d 00 00 75 10 b8 03 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 9e c5 01 00 48 89 04 24
>
> The warning is triggered by:
>
> 	WARN_ON(sk->sk_forward_alloc);
>
> so it looks like there is some memory accounting issue.
>
> Cheers,
>
> Paolo
>
> --
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_connect.sh
> index ec64e95a6d35..2f22f3ae0e2f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -36,6 +36,7 @@ SIZE=3D$((RANDOM % (1024 * 1024)))
> if [ $SIZE -eq 0 ] ; then
>        SIZE=3D1
> fi
> +SIZE=3D$((SIZE * 100))
>
> dd if=3D/dev/urandom of=3D"$tmpin" bs=3D1 count=3D$SIZE 2> /dev/null
>
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============3148049913425568736==--
