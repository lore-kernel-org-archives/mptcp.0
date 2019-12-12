Content-Type: multipart/mixed; boundary="===============6172456950649181803=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 0/1] proposed export branch rebase
Date: Thu, 12 Dec 2019 13:03:06 +0100
Message-ID: <49c558b80bd2119b87458e1839e9f2a37ee8044c.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1912111543150.11852@amhui-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2885

--===============6172456950649181803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-11 at 17:06 -0800, Mat Martineau wrote:
> On Wed, 11 Dec 2019, Paolo Abeni wrote:
> =

> > On Wed, 2019-12-11 at 17:32 +0100, Paolo Abeni wrote:
> > > On Tue, 2019-12-10 at 22:27 +0100, Matthieu Baerts wrote:
> > > > Hi,
> > > > =

> > > > On 10/12/2019 19:24, Matthieu Baerts wrote:
> > > > > Hi Florian, Paolo,
> > > > > =

> > > > > On 09/12/2019 13:33, Paolo Abeni wrote:
> > > > > > Hi,
> > > > > > =

> > > > > > On Sun, 2019-12-08 at 19:24 +0100, Florian Westphal wrote:
> > > > > > > It includes 48 patches (down from 66), I will refrain from pa=
tch-bombing
> > > > > > > the list with it.  There is one patch as followup here becaus=
e its
> > > > > > > "almost new" in the sense that its an amalgamation of differe=
nt patches
> > > > > > > that I placed in that commit because the others seemed quite =
large
> > > > > > > already.
> > > > > > > =

> > > > > > > The __tcp_poll patch is gone.  Later patches, in particular t=
he
> > > > > > > changes to
> > > > > > > only store 'tcp_sock' rather than 'struct socket' on the conn=
_list, have
> > > > > > > been brought forward and squashed into the relevant commits, =
would thus
> > > > > > > be implicitly part of basic mptcp submission.  I've amemded c=
ommit
> > > > > > > messages where appropriate.
> > > > > > =

> > > > > > Thank you Florian for the great work!
> > > > > > =

> > > > > > I went through the patches up to v1 support, and LGTM.
> > > > > =

> > > > > It is also good to me! Thank you very much for the very big work!=
 The
> > > > > kind of work where even you you have to sit down to do it! ...  O=
:-D
> > > > > =

> > > > > I just re-created the tree using your branch. I am also checking =
now
> > > > > that all commits are OK, with and without MPTCP. Also the usual
> > > > > compilation tests with i386 and without IPv6.
> > > > =

> > > > FYI, all tests are green!
> > > > I didn't re-enable the automatic sync with net-next. I will do that
> > > > after having applied recent Paolo's changes.
> > > =

> > > The rebased and amost squashed thing is available here:
> > > =

> > > https://github.com/pabeni/mptcp/tree/fwestpha-mptcp_export_rebase_19_=
fallback_cleanup_2
> > > =

> > > It build on each commit. Not tested yet, sent-out early for review's
> > > sake.
> > =

> > Just tested successfully on top of V1 patches and on branch head.
> > =

> > For the record, I observed once on the unsquashed patches, the
> > following warn (with decoded stack trace):
> > =

> > [ 1093.576154] ------------[ cut here ]------------
> > [ 1093.577188] refcount_t: addition on 0; use-after-free.
> > [ 1093.577966] WARNING: CPU: 2 PID: 29790 at lib/refcount.c:25 refcount=
_warn_saturate (/home/pabeni/devel/linux-mptcp/lib/refcount.c:25 (discrimin=
ator 3))
> > [ 1093.579153] Modules linked in: sch_netem veth intel_rapl_msr rfkill =
intel_rapl_common kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul gha=
sh_clmulni_intel joydev pcspkr virtio_balloon i2c_piix4 ip_tables xfs libcr=
c32c crc32c_intel serio_raw virtio_net net_failover virtio_blk ata_generic =
failover virtio_console ata_piix libata
> > [ 1093.584101] CPU: 2 PID: 29790 Comm: mptcp_connect Not tainted 5.4.0.=
mptcp_bfaef67f2a47+ #464
> > [ 1093.585723] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.12.0-2.fc30 04/01/2014
> > [ 1093.587415] RIP: 0010:refcount_warn_saturate (/home/pabeni/devel/lin=
ux-mptcp/lib/refcount.c:25 (discriminator 3))
> > [ 1093.588409] Code: b9 2d 41 02 01 e8 3b 90 41 ff 0f 0b eb 9d 80 3d a8=
 2d 41 02 00 75 94 48 c7 c7 c0 09 e8 87 c6 05 98 2d 41 02 01 e8 1b 90 41 ff=
 <0f> 0b e9 7a ff ff ff 80 3d 82 2d 41 02 00 0f 85 6d ff ff ff 48 c7
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >   0:   b9 2d 41 02 01          mov    $0x102412d,%ecx
> >   5:   e8 3b 90 41 ff          callq  0xffffffffff419045
> >   a:   0f 0b                   ud2
> >   c:   eb 9d                   jmp    0xffffffffffffffab
> >   e:   80 3d a8 2d 41 02 00    cmpb   $0x0,0x2412da8(%rip)        # 0x2=
412dbd
> >  15:   75 94                   jne    0xffffffffffffffab
> >  17:   48 c7 c7 c0 09 e8 87    mov    $0xffffffff87e809c0,%rdi
> >  1e:   c6 05 98 2d 41 02 01    movb   $0x1,0x2412d98(%rip)        # 0x2=
412dbd
> >  25:   e8 1b 90 41 ff          callq  0xffffffffff419045
> >  2a:*  0f 0b                   ud2             <-- trapping instruction
> >  2c:   e9 7a ff ff ff          jmpq   0xffffffffffffffab
> >  31:   80 3d 82 2d 41 02 00    cmpb   $0x0,0x2412d82(%rip)        # 0x2=
412dba
> >  38:   0f 85 6d ff ff ff       jne    0xffffffffffffffab
> >  3e:   48                      rex.W
> >  3f:   c7                      .byte 0xc7
> > =

> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   0:   0f 0b                   ud2
> >   2:   e9 7a ff ff ff          jmpq   0xffffffffffffff81
> >   7:   80 3d 82 2d 41 02 00    cmpb   $0x0,0x2412d82(%rip)        # 0x2=
412d90
> >   e:   0f 85 6d ff ff ff       jne    0xffffffffffffff81
> >  14:   48                      rex.W
> >  15:   c7                      .byte 0xc7
> > [ 1093.592029] RSP: 0018:ffff8881061f7cd0 EFLAGS: 00010282
> > [ 1093.593155] RAX: 0000000000000000 RBX: ffff888035b54040 RCX: 0000000=
000000000
> > [ 1093.594476] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffed1=
020c3ef8c
> > [ 1093.595769] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffed1=
02187c4d1
> > [ 1093.597063] R10: ffffed102187c4d0 R11: ffff88810c3e2687 R12: ffff888=
035b53fe8
> > [ 1093.598354] R13: ffff888035b54040 R14: ffff888035b53fc0 R15: ffff888=
035b53fc0
> > [ 1093.599654] FS:  00007f9b8b9ad740(0000) GS:ffff88810c200000(0000) kn=
lGS:0000000000000000
> > [ 1093.601104] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1093.602174] CR2: 00007fffdcdc0000 CR3: 0000000103e04001 CR4: 0000000=
000160ee0
> > [ 1093.603472] Call Trace:
> > [ 1093.603997] tcp_close (/home/pabeni/devel/linux-mptcp/./include/linu=
x/refcount.h:191 /home/pabeni/devel/linux-mptcp/./include/linux/refcount.h:=
228 /home/pabeni/devel/linux-mptcp/./include/net/sock.h:647 /home/pabeni/de=
vel/linux-mptcp/net/ipv4/tcp.c:2434)
> =

> There's an extra sock_put() (or a missing sock_hold()) somewhere before =

> the sock_hold() in tcp_close(). Seems like the only candidate for that is =

> an unmatched sock_put() in subflow_ulp_release() which is releasing the =

> reference count for mptcp_subflow_context->conn.
> =

> It looks like that mptcp_subflow_context->conn reference count is intende=
d =

> to be matched by a sock_hold() when the conn value is assigned (see =

> mptcp_subflow_create_socket()). There are other assignments to =

> mptcp_subflow_context->conn in subflow_syn_recv_sock() and mptcp_accept() =

> which are not calling sock_hold() - so maybe that's the problem. If that'=
s =

> it, I'm not sure why this warning happens rarely instead of all the time.
> =

> I'll try adding some debug statements to confirm this theory.

[...]

> [ 1093.605757] mptcp_close (/home/pabeni/devel/linux-mptcp/net/mptcp/prot=
ocol.c:521 /home/pabeni/devel/linux-mptcp/net/mptcp/protocol.c:579)

Thank you for the feedback!

I think the refcount mismatch happens on a subflow socket, in the
relevant checked-out tree:

/home/pabeni/devel/linux-mptcp/net/mptcp/protocol.c:521 is:

static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
                              struct mptcp_subflow_context *subflow,
                              long timeout)
{
        struct socket *sock =3D READ_ONCE(ssk->sk_socket);

        list_del(&subflow->node);

        if (sock && sock !=3D sk->sk_socket) {
                /* outgoing subflow */
                sock_release(sock);
        } else {
                /* incoming subflow */
                sock_orphan(ssk);
                tcp_close(ssk, timeout);  // XXXXXXX <- this line
        }
}

and /home/pabeni/devel/linux-mptcp/net/mptcp/protocol.c:579 is:

static void mptcp_close(struct sock *sk, long timeout)
{
        struct mptcp_subflow_context *subflow, *tmp;
        struct mptcp_sock *msk =3D mptcp_sk(sk);

        mptcp_token_destroy(msk->token);
        inet_sk_state_store(sk, TCP_CLOSE);

        lock_sock(sk);

        list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
                struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);

                __mptcp_close_ssk(sk, ssk, subflow, timeout);  =

// ^^^^^^^^^^^^^^^^^^ this line XXXXXXXXXXXXXXXXX ^^^^^^^^^^^^
        }
	=

Given the very low frequency of the event this, the refcount mismatch
is very likely due to some race conditions.

I think the following one could be a possible (even likely) root cause.
In __mptcp_close_ssk() - ssk lock is not held:

	sock_orphan(ssk); // ssk->flags |=3D SOCK_DEAD
	=

	// ssk is in LAST_ACK status, some other CPU
	// receives the last ack and call tcp_done()
	// which in turns call inet_csk_destroy_sock(), as ssk
	// has SOCK_DEAD set, ssk is freed

	tcp_close(ssk, timeout);
	// whooops :(

I'll try to validate the above with the following dumb/hacky fix, if it
works, we can think something more elegant meanwhile/later:

	sock_hold(ssk); // so that eventual inet_csk_destroy_sock() =

			// in between orphan and close will not free
			// ssk
	sock_orphan(ssk); =

	tcp_close(ssk, timeout);
	sock_put(ssk);

Cheers,

Paolo

--===============6172456950649181803==--
