Content-Type: multipart/mixed; boundary="===============6134106814343889085=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix oops on accept
Date: Wed, 24 Apr 2019 10:28:03 +0200
Message-ID: <f97e711f1fb68c3b034a1ddaf1b612b068981aca.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1904231708570.13139@leejosex-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1084

--===============6134106814343889085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-04-23 at 17:17 -0700, Mat Martineau wrote:
> On Thu, 18 Apr 2019, Paolo Abeni wrote:
> =

> > while running the self-test on a multi core VM, with a standard (non
> > debug) kernel config, I hit the following oops:
> > =

> > [  234.587877] BUG: unable to handle kernel NULL pointer dereference at=
 0000000000000020
> > [  234.591567] #PF error: [normal kernel read fault]
> > [  234.593862] PGD 800000013a8ec067 P4D 800000013a8ec067 PUD 13a2ad067 =
PMD 0
> > [  234.596616] Oops: 0000 [#1] SMP PTI
> > [  234.597173] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.1.0-rc4.mptc=
p_xmit_07723d4+ #2139
> > [  234.598363] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> > [  234.599847] RIP: 0010:mptcp_finish_connect+0x2a/0x160
> =

> ...
> =

> > The problem is in mptcp_accept(): the newly created subflow is
> > already added to the mptcp subflow list, but conn_finished is not set.
> > =

> > On next rx dst cache update we enter subflow_finish_connect()/mptcp_fin=
ish_connect()
> > and hit the crash due to NULL msk->subflow de-referncing.
> > =

> > Fix the above properly initializing the subflow at accept() time.
> =

> Peter and I have been looking in to this crash. It could be due to a =

> use-after-free bug, since conn_finished isn't expected to be used on the =

> accepting socket. The symptoms are similar to KASAN report I was seeing o=
n =

> my multicore VM.

Uhmm... possibly there are some additional races, but the oops I'm
seeing is pretty much deterministic, not due to a race.

subflow_finish_connect() is invoked via:

tcp_rcv_established() -> inet_csk(sk)->icsk_af_ops->sk_rx_dst_set() ->
subflow_finish_connect()

every time that the rx cache dst expires on the subflow socket created
by the accept() syscall.

When the relevant mptcp socket and the subflow are created at accept()
time - in mptcp_accept(), we have:

	msk->subflow =3D NULL;
	// ...	=

	subflow->conn =3D new_mptcp_sock->sk;
	// subflow->conn_finished is memset to 0 at allocation time

so mptcp_finish_connect() is invoked. mptcp_finish_connect()
unconditionally dereference mptcp_sk(subflow->conn)->subflow, and that
causes the reported oops.

So I think setting 'msk->conn_finished =3D 1' in mptcp_accept() is
required to properly initialize the mptcp socket created on accept().

Cheers,

Paolo


--===============6134106814343889085==--
