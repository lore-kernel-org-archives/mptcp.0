Content-Type: multipart/mixed; boundary="===============3030548299106045267=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] New Linux TCP feature: generic upper layer protocol
Date: Fri, 16 Jun 2017 17:18:32 -0700
Message-ID: <20170617001832.GC82528@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1706161610100.43467@tgates-mobl1.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 47

--===============3030548299106045267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 16/06/17 - 17:12:14, Mat Martineau wrote:
> =

> On Fri, 16 Jun 2017, Christoph Paasch wrote:
> =

> > Hello Mat,
> > =

> > On 15/06/17 - 16:35:17, Mat Martineau wrote:
> > > =

> > > Hello,
> > > =

> > > A new piece of TCP extension infrastructure was just merged to net-ne=
xt:
> > > generic upper layer protocol (ULP) support for TCP.
> > > =

> > > The relevant commit is https://git.kernel.org/pub/scm/linux/kernel/gi=
t/davem/net-next.git/commit/?id=3D734942cc4ea6478eed125af258da1bdbb4afe578
> > =

> > thanks for the pointer. That's really interesting.
> > =

> > =

> > One thing I am wondering is, how this covers against races?
> > =

> > Because, one might do the setsockopt() at the same time as calling send=
msg().
> > =

> > The following scenario could happen in my opinion:
> > =

> > setsockopt is first, goes all the way until lock_sock() in do_tcp_setso=
ckopt().
> > Then, sendmsg() gets some CPU-cycles and goes until tcp_sendmsg() (than=
ks to
> > sk->sk_prot->sendmsg) and blocks on the lock_sock(). Now, back to the s=
etsockopt,
> > which will end up changing sk->sk_prot. setsockopt now finishes and rel=
eases
> > the lock.
> > =

> > Now we end up with the sendmsg inside tcp_sendmsg(), while it should be=
 in
> > the ULP's sendmsg. This looks extremely unsafe to me.
> =

> Yes, indeed. Glad you spotted that.
> =

> > =

> > I will check on netdev if there has been discussion about this.
> =

> I spent some time yesterday looking for any discussion of the ULP patch a=
nd
> the only thing I found in the archives was the original suggestion to cre=
ate
> the generalized ULP feature:
> =

> http://www.mail-archive.com/netdev(a)vger.kernel.org/msg160375.html

I actually just sent out an e-mail to netdev about this, before I saw your
mail here.

I spent some time looking through the code and the more I look at it, the
more unsafe it seems to me :)

For example, one could change the sk_prot.sendpage callback to NULL. And if
then a race happens, we might panic in inet_sendpage() because we first
check for existence and then call it:

if (sk->sk_prot->sendpage)
	return sk->sk_prot->sendpage(sk, page, offset, size, flags);

If there is a ULP that changes sendpage to NULL, we can panic here
(depending on how the compiler accesses these pointers).



Christoph


--===============3030548299106045267==--
