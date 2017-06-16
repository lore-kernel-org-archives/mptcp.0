Content-Type: multipart/mixed; boundary="===============5817795830935525443=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] New Linux TCP feature: generic upper layer protocol
Date: Fri, 16 Jun 2017 16:04:49 -0700
Message-ID: <20170616230449.GB82528@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1706151550060.33450@jrhamric-mobl03.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 44

--===============5817795830935525443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On 15/06/17 - 16:35:17, Mat Martineau wrote:
> =

> Hello,
> =

> A new piece of TCP extension infrastructure was just merged to net-next:
> generic upper layer protocol (ULP) support for TCP.
> =

> The relevant commit is https://git.kernel.org/pub/scm/linux/kernel/git/da=
vem/net-next.git/commit/?id=3D734942cc4ea6478eed125af258da1bdbb4afe578

thanks for the pointer. That's really interesting.


One thing I am wondering is, how this covers against races?

Because, one might do the setsockopt() at the same time as calling sendmsg(=
).

The following scenario could happen in my opinion:

setsockopt is first, goes all the way until lock_sock() in do_tcp_setsockop=
t().
Then, sendmsg() gets some CPU-cycles and goes until tcp_sendmsg() (thanks to
sk->sk_prot->sendmsg) and blocks on the lock_sock(). Now, back to the setso=
ckopt,
which will end up changing sk->sk_prot. setsockopt now finishes and releases
the lock.

Now we end up with the sendmsg inside tcp_sendmsg(), while it should be in
the ULP's sendmsg. This looks extremely unsafe to me.

I will check on netdev if there has been discussion about this.


Christoph

> =

> It was added as part of in-kernel TLS support. The TLS code didn't initia=
lly
> have this framework, but Tom Herbert asked them to generalize this feature
> when reviewing an early patch set.
> =

> If we use ULP for MPTCP, creating a multipatch socket would look like:
> =

> sock =3D socket(AF_INET, SOCK_STREAM, 0);
> setsockopt(sock, SOL_TCP, TCP_ULP, "mptcp", sizeof("mptcp"));
> =

> instead of:
> =

> sock =3D socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> =

> =

> A case can be made for either interface. MPTCP shares an IP protocol numb=
er
> with TCP, so IPPROTO_MPTCP is a awkward to define in a way that's consist=
ent
> with other AF_INET{,6} protocols. On the other hand, MPTCP is not a layer
> above TCP like TLS - however, we have the same need to override some TCP
> socket behavior.
> =

> In the end, there's not much difference in functionality, but the
> maintainers may favor the ULP approach. Any preferences here on this list?
> =

> --
> Mat Martineau
> Intel OTC
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp

--===============5817795830935525443==--
