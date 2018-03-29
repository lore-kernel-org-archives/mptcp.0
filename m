Content-Type: multipart/mixed; boundary="===============5128968181942651151=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using struct socket for subflows
Date: Thu, 29 Mar 2018 10:05:09 +0200
Message-ID: <20180329080509.GV71178@MacBook-Pro-6.lan>
In-Reply-To: alpine.OSX.2.21.1803280908300.16850@fmorale1-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 465

--===============5128968181942651151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28/03/18 - 09:25:46, Mat Martineau wrote:
> =

> On Wed, 28 Mar 2018, Christoph Paasch wrote:
> =

> > On 27/03/18 - 16:29:26, Mat Martineau wrote:
> > > =

> > > Hi Christoph,
> > > =

> > > On Tue, 27 Mar 2018, Christoph Paasch wrote:
> > > =

> > > > Hello,
> > > > =

> > > > =

> > > > (first, sorry for the long e-mail)
> > > > =

> > > > =

> > > > I now started working on cleaning up the input path to prepare it f=
or
> > > > input-processing without holding the MPTCP-level lock.
> > > > =

> > > > To do this, I go through all the places where we access data-struct=
ures from
> > > > the meta-socket and see if I can move it to mptcp_data_ready or
> > > > mptcp_write_space (the callbacks that are called from
> > > > sk_data_ready/sk_write_space).
> > > > =

> > > > In tcp_check_space() we have the following:
> > > >                if (mptcp(tcp_sk(sk)) ||
> > > >                    (sk->sk_socket &&
> > > >                     test_bit(SOCK_NOSPACE, &sk->sk_socket->flags)))=
 {
> > > >                        tcp_new_space(sk);
> > > >                        if (sk->sk_socket && !test_bit(SOCK_NOSPACE,=
 &sk->sk_socket->flags))
> > > >                                tcp_chrono_stop(sk, TCP_CHRONO_SNDBU=
F_LIMITED);
> > > >                }
> > > > =

> > > > We do the if (mptcp(...)), because currently subflow's sk_socket is=
 pointing to
> > > > application's struct socket. Thus, we need to avoid the check for
> > > > SOCK_NOSPACE, as otherwise we might end up not calling sk_write_spa=
ce.
> > > > =

> > > > =

> > > > Other kernel-modules that create TCP-connections rather have an in-=
kernel
> > > > struct socket. And modules like RDS even force SOCK_NOSPACE to be s=
et, such
> > > > that the TCP-stack keeps on up-calling. I thought that this was a g=
ood thing
> > > > to do in MPTCP as well.
> > > > =

> > > > So, my goal became to have a fully functional struct socket for sub=
flows.
> > > > The benefit is also that we can end up using kernel_sendmsg,
> > > > kernel_recvmsg,... in the future. It also allows to do kernel_accep=
t() on
> > > > the MPTCP-level socket to receive new subflows (a problem I mention=
ed in an
> > > > earlier mail).
> > > =

> > > I think we'll have a patch set illustrating this approach ready to po=
st
> > > tomorrow.
> > =

> > Awesome! I am waiting for your patch :)
> > =

> > > Peter and I have been working on this net-next-based code with
> > > in-kernel sockets for many months now. I missed the SOCK_NOSPACE deta=
il
> > > though - I'll take a look at that.
> > > =

> > > Rather than using kernel_sendmsg and kernel_recvmsg, I use do_tcp_sen=
dpages
> > > (to reduce copying and let the MPTCP connection layer share data acro=
ss skbs
> > > and subflows as it needs to) and tcp_read_sock (to read intact skbs o=
ut of
> > > the rx queue). The kernel_* functions are used for most everything el=
se
> > > though.
> > =

> > Do you also handle kernel_accept ?
> > If yes, how do you do it? Because, it's quite complex to avoid races.
> =

> Yes, but we don't support joins yet so it's maybe only the trivial case. =
The
> connection level socket owns a subflow listening socket (which it created=
 at
> init time), and when the application calls accept() it's immediately pass=
ed
> through to kernel_accept() for the subflow.

I see you posted your patches. I will try to go over them before our
meeting tonight.


Christoph


--===============5128968181942651151==--
