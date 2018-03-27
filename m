Content-Type: multipart/mixed; boundary="===============4315206052590043354=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Using struct socket for subflows
Date: Tue, 27 Mar 2018 11:18:47 +0200
Message-ID: <20180327091847.GC39174@MacBook-Pro-6.lan>
X-Status: 
X-Keywords:                  
X-UID: 423

--===============4315206052590043354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,


(first, sorry for the long e-mail)


I now started working on cleaning up the input path to prepare it for
input-processing without holding the MPTCP-level lock.

To do this, I go through all the places where we access data-structures from
the meta-socket and see if I can move it to mptcp_data_ready or
mptcp_write_space (the callbacks that are called from
sk_data_ready/sk_write_space).

In tcp_check_space() we have the following:
                if (mptcp(tcp_sk(sk)) ||
                    (sk->sk_socket &&
                     test_bit(SOCK_NOSPACE, &sk->sk_socket->flags))) {
                        tcp_new_space(sk);
                        if (sk->sk_socket && !test_bit(SOCK_NOSPACE, &sk->s=
k_socket->flags))
                                tcp_chrono_stop(sk, TCP_CHRONO_SNDBUF_LIMIT=
ED);
                }

We do the if (mptcp(...)), because currently subflow's sk_socket is pointin=
g to
application's struct socket. Thus, we need to avoid the check for
SOCK_NOSPACE, as otherwise we might end up not calling sk_write_space.


Other kernel-modules that create TCP-connections rather have an in-kernel
struct socket. And modules like RDS even force SOCK_NOSPACE to be set, such
that the TCP-stack keeps on up-calling. I thought that this was a good thing
to do in MPTCP as well.

So, my goal became to have a fully functional struct socket for subflows.
The benefit is also that we can end up using kernel_sendmsg,
kernel_recvmsg,... in the future. It also allows to do kernel_accept() on
the MPTCP-level socket to receive new subflows (a problem I mentioned in an
earlier mail).
It also would allow us to expose subflows as file-descriptors to the
user-space. That way the user-space can do setsockopt, getsockopt,... on the
subflows. An idea that came up in the past when we were thinking on how to
expose an MPTCP API that allows apps to control certain things on the
subflows.

To get there, there are a few places where things would need to change:

* mptcp_init4_subsockets - Here, this works perfectly. It also allows to
  avoid "faking" the struct socket, as we are currently doing.
* mptcp_alloc_mpcb for the active opener - This is the first problem. mptcp=
_alloc_mpcb() can be
  called with bh disabled. But sock_create_lite() assumes that bh is enabled
  as it ends up doing an alloc with GFP_KERNEL.
  A few ways this could be solved:
  - Schedule a work-queue item in mptcp_alloc_mpcb that creates the struct
    socket. This looks a bit racy to me. Not sure what side-effects this
    might have.
  - Change things entirely, such that the master-sock is being allocated
    when the connection is created. That way, we allocate all the necessary
    struct socket's right away.
    In the past, we decided to allocate the master-sk only when receiving
    the SYN/ACK. We did that so as to minimize the impact on regular TCP
    when the server does not support MPTCP. But, as we are moving towards
    explicitly exposing MPTCP at the socket-layer, we can rethink that
    decision.
    Any thoughts? Is it ok to pay the cost of allocating a master-sk before
    we know whether the server supports MPTCP?
    I think, we should do this, and transition to that model.
* mptcp_alloc_mpcb for the passive opener - same problem as above but on the
  other side. We could allocate the master's struct socket upon the accept()
  call from the application. This again sounds a bit racy to me. The struct
  socket will be there for the subflow potentially much later than it has
  been established. What happens if the peer sends data or an
  MP_FASTCLOSE,... ?
* New subflows on the passive opener side - again, we are receiving those
  subflows while bh is disabled. So, we have to schedule a work-queue to
  do a kerne_accept() on the MPTCP-socket.
  Again something that can potentially be racy.

In general, subflow-establishment on the passive-opener side again seems to
be a major pain-point. I think, we really need to redesign that.


Any thoughts, feedback, suggestions?
Or maybe, using real struct socket for subflows is not worth it? :)


Thanks,
Christoph


--===============4315206052590043354==--
