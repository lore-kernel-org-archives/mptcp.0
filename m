Content-Type: multipart/mixed; boundary="===============0242404790472939294=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Wed, 11 Dec 2019 18:15:52 +0100
Message-ID: <321b1a9a3dc4c553f985b5b4b9d61ba685fdf779.camel@redhat.com>
In-Reply-To: b4d68d34218e40cefaf811a81514ef7afae17b84.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2872

--===============0242404790472939294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 17:32 +0100, Paolo Abeni wrote:
> On Tue, 2019-12-10 at 22:27 +0100, Matthieu Baerts wrote:
> > Hi,
> > =

> > On 10/12/2019 19:24, Matthieu Baerts wrote:
> > > Hi Florian, Paolo,
> > > =

> > > On 09/12/2019 13:33, Paolo Abeni wrote:
> > > > Hi,
> > > > =

> > > > On Sun, 2019-12-08 at 19:24 +0100, Florian Westphal wrote:
> > > > > It includes 48 patches (down from 66), I will refrain from patch-=
bombing
> > > > > the list with it.  There is one patch as followup here because its
> > > > > "almost new" in the sense that its an amalgamation of different p=
atches
> > > > > that I placed in that commit because the others seemed quite larg=
e =

> > > > > already.
> > > > > =

> > > > > The __tcp_poll patch is gone.  Later patches, in particular the =

> > > > > changes to
> > > > > only store 'tcp_sock' rather than 'struct socket' on the conn_lis=
t, have
> > > > > been brought forward and squashed into the relevant commits, woul=
d thus
> > > > > be implicitly part of basic mptcp submission.  I've amemded commit
> > > > > messages where appropriate.
> > > > =

> > > > Thank you Florian for the great work!
> > > > =

> > > > I went through the patches up to v1 support, and LGTM.
> > > =

> > > It is also good to me! Thank you very much for the very big work! The =

> > > kind of work where even you you have to sit down to do it! ...  O:-D
> > > =

> > > I just re-created the tree using your branch. I am also checking now =

> > > that all commits are OK, with and without MPTCP. Also the usual =

> > > compilation tests with i386 and without IPv6.
> > =

> > FYI, all tests are green!
> > I didn't re-enable the automatic sync with net-next. I will do that =

> > after having applied recent Paolo's changes.
> =

> The rebased and amost squashed thing is available here:
> =

> https://github.com/pabeni/mptcp/tree/fwestpha-mptcp_export_rebase_19_fall=
back_cleanup_2
> =

> It build on each commit. Not tested yet, sent-out early for review's
> sake.

Just tested successfully on top of V1 patches and on branch head.

For the record, I observed once on the unsquashed patches, the
following warn (with decoded stack trace):

[ 1093.576154] ------------[ cut here ]------------
[ 1093.577188] refcount_t: addition on 0; use-after-free.
[ 1093.577966] WARNING: CPU: 2 PID: 29790 at lib/refcount.c:25 refcount_war=
n_saturate (/home/pabeni/devel/linux-mptcp/lib/refcount.c:25 (discriminator=
 3))
[ 1093.579153] Modules linked in: sch_netem veth intel_rapl_msr rfkill inte=
l_rapl_common kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_c=
lmulni_intel joydev pcspkr virtio_balloon i2c_piix4 ip_tables xfs libcrc32c=
 crc32c_intel serio_raw virtio_net net_failover virtio_blk ata_generic fail=
over virtio_console ata_piix libata
[ 1093.584101] CPU: 2 PID: 29790 Comm: mptcp_connect Not tainted 5.4.0.mptc=
p_bfaef67f2a47+ #464
[ 1093.585723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.12.0-2.fc30 04/01/2014
[ 1093.587415] RIP: 0010:refcount_warn_saturate (/home/pabeni/devel/linux-m=
ptcp/lib/refcount.c:25 (discriminator 3))
[ 1093.588409] Code: b9 2d 41 02 01 e8 3b 90 41 ff 0f 0b eb 9d 80 3d a8 2d =
41 02 00 75 94 48 c7 c7 c0 09 e8 87 c6 05 98 2d 41 02 01 e8 1b 90 41 ff <0f=
> 0b e9 7a ff ff ff 80 3d 82 2d 41 02 00 0f 85 6d ff ff ff 48 c7
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   b9 2d 41 02 01          mov    $0x102412d,%ecx
   5:   e8 3b 90 41 ff          callq  0xffffffffff419045
   a:   0f 0b                   ud2
   c:   eb 9d                   jmp    0xffffffffffffffab
   e:   80 3d a8 2d 41 02 00    cmpb   $0x0,0x2412da8(%rip)        # 0x2412=
dbd
  15:   75 94                   jne    0xffffffffffffffab
  17:   48 c7 c7 c0 09 e8 87    mov    $0xffffffff87e809c0,%rdi
  1e:   c6 05 98 2d 41 02 01    movb   $0x1,0x2412d98(%rip)        # 0x2412=
dbd
  25:   e8 1b 90 41 ff          callq  0xffffffffff419045
  2a:*  0f 0b                   ud2             <-- trapping instruction
  2c:   e9 7a ff ff ff          jmpq   0xffffffffffffffab
  31:   80 3d 82 2d 41 02 00    cmpb   $0x0,0x2412d82(%rip)        # 0x2412=
dba
  38:   0f 85 6d ff ff ff       jne    0xffffffffffffffab
  3e:   48                      rex.W
  3f:   c7                      .byte 0xc7

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0:   0f 0b                   ud2
   2:   e9 7a ff ff ff          jmpq   0xffffffffffffff81
   7:   80 3d 82 2d 41 02 00    cmpb   $0x0,0x2412d82(%rip)        # 0x2412=
d90
   e:   0f 85 6d ff ff ff       jne    0xffffffffffffff81
  14:   48                      rex.W
  15:   c7                      .byte 0xc7
[ 1093.592029] RSP: 0018:ffff8881061f7cd0 EFLAGS: 00010282
[ 1093.593155] RAX: 0000000000000000 RBX: ffff888035b54040 RCX: 00000000000=
00000
[ 1093.594476] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffed1020c=
3ef8c
[ 1093.595769] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed10218=
7c4d1
[ 1093.597063] R10: ffffed102187c4d0 R11: ffff88810c3e2687 R12: ffff888035b=
53fe8
[ 1093.598354] R13: ffff888035b54040 R14: ffff888035b53fc0 R15: ffff888035b=
53fc0
[ 1093.599654] FS:  00007f9b8b9ad740(0000) GS:ffff88810c200000(0000) knlGS:=
0000000000000000
[ 1093.601104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1093.602174] CR2: 00007fffdcdc0000 CR3: 0000000103e04001 CR4: 00000000001=
60ee0
[ 1093.603472] Call Trace:
[ 1093.603997] tcp_close (/home/pabeni/devel/linux-mptcp/./include/linux/re=
fcount.h:191 /home/pabeni/devel/linux-mptcp/./include/linux/refcount.h:228 =
/home/pabeni/devel/linux-mptcp/./include/net/sock.h:647 /home/pabeni/devel/=
linux-mptcp/net/ipv4/tcp.c:2434)
[ 1093.605757] mptcp_close (/home/pabeni/devel/linux-mptcp/net/mptcp/protoc=
ol.c:521 /home/pabeni/devel/linux-mptcp/net/mptcp/protocol.c:579)
[ 1093.606604] inet_release (/home/pabeni/devel/linux-mptcp/net/ipv4/af_ine=
t.c:428)
[ 1093.607427] __sock_release (/home/pabeni/devel/linux-mptcp/net/socket.c:=
593)
[ 1093.608230] sock_close (/home/pabeni/devel/linux-mptcp/net/socket.c:1272)
[ 1093.608792] __fput (/home/pabeni/devel/linux-mptcp/fs/file_table.c:280)
[ 1093.609430] task_work_run (/home/pabeni/devel/linux-mptcp/kernel/task_wo=
rk.c:115 (discriminator 1))
[ 1093.610100] exit_to_usermode_loop (/home/pabeni/devel/linux-mptcp/./incl=
ude/linux/tracehook.h:188 /home/pabeni/devel/linux-mptcp/arch/x86/entry/com=
mon.c:164)
[ 1093.610858] do_syscall_64 (/home/pabeni/devel/linux-mptcp/arch/x86/entry=
/common.c:195 /home/pabeni/devel/linux-mptcp/arch/x86/entry/common.c:278 /h=
ome/pabeni/devel/linux-mptcp/arch/x86/entry/common.c:304)
[ 1093.611579] entry_SYSCALL_64_after_hwframe (/home/pabeni/devel/linux-mpt=
cp/arch/x86/entry/entry_64.S:177)
[ 1093.612617] RIP: 0033:0x7f9b8b4b77a0
[ 1093.613289] Code: 00 64 c7 00 0d 00 00 00 b8 ff ff ff ff eb 90 b8 ff ff =
ff ff eb 89 0f 1f 40 00 83 3d fd c7 2d 00 00 75 10 b8 03 00 00 00 0f 05 <48=
> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 9e c5 01 00 48 89 04 24
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   00 64 c7 00             add    %ah,0x0(%rdi,%rax,8)
   4:   0d 00 00 00 b8          or     $0xb8000000,%eax
   9:   ff                      (bad)
   a:   ff                      (bad)
   b:   ff                      (bad)
   c:   ff                      (bad)
   d:   eb 90                   jmp    0xffffffffffffff9f
   f:   b8 ff ff ff ff          mov    $0xffffffff,%eax
  14:   eb 89                   jmp    0xffffffffffffff9f
  16:   0f 1f 40 00             nopl   0x0(%rax)
  1a:   83 3d fd c7 2d 00 00    cmpl   $0x0,0x2dc7fd(%rip)        # 0x2dc81e
  21:   75 10                   jne    0x33
  23:   b8 03 00 00 00          mov    $0x3,%eax
  28:   0f 05                   syscall
  2a:*  48 3d 01 f0 ff ff       cmp    $0xfffffffffffff001,%rax         <--=
 trapping instruction
  30:   73 31                   jae    0x63
  32:   c3                      retq
---

But I could not reproduce it (so far) on the squashed branch.

I'll suggest to merge the patches as-is and ev. look after bug after
that.

Cheers,

Paolo

--===============0242404790472939294==--
