Content-Type: multipart/mixed; boundary="===============8623957861835378676=="
MIME-Version: 1.0
From: cpaasch at apple.com
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Sun, 12 Nov 2017 22:47:05 -0800
Message-ID: <20171113064705.GC54399@Chimay.local>
In-Reply-To: alpine.OSX.2.21.1711090813060.34898@nagarwal-mobl2.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 173

--===============8623957861835378676==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Mat,

On 09/11/17 - 08:26:23, Mat Martineau wrote:
> =

> Hi everyone,
> =

> On Thu, 9 Nov 2017, cpaasch(a)apple.com wrote:
> =

> > On 09/11/17 - 04:32:54, Boris Pismenny wrote:
> > > +Ilya and Liran
> > > =

> > > Hi,
> > > =

> > > > -----Original Message-----
> > > > From: cpaasch(a)apple.com [mailto:cpaasch(a)apple.com]
> > > > Sent: Thursday, November 09, 2017 13:13
> > > > To: Mat Martineau <mathew.j.martineau(a)linux.intel.com>; Boris Pis=
menny
> > > > <borisp(a)mellanox.com>
> > > > Cc: mptcp(a)lists.01.org
> > > > Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
> > > > =

> > > > +Boris
> > > > =

> > > > On 20/10/17 - 16:02:31, Mat Martineau wrote:
> > > > > The sk_buff control buffer is of limited size, and cannot be enla=
rged
> > > > > without significant impact on systemwide memory use. However, add=
itional
> > > > > per-packet state is needed for some protocols, like Multipath TCP.
> > > > > =

> > > > > An optional shared control buffer placed after the normal struct
> > > > > skb_shared_info can accomodate the necessary state without imposi=
ng
> > > > > extra memory usage or code changes on normal struct sk_buff
> > > > > users. __alloc_skb will now place a skb_shared_info_ext structure=
 at
> > > > > skb->end when given the SKB_ALLOC_SHINFO_EXT flag. Most users of =
struct
> > > > > sk_buff continue to use the skb_shinfo() macro to access shared
> > > > > info. skb_shinfo(skb)->is_ext is set if the extended structure is
> > > > > available, and cleared if it is not.
> > > > > =

> > > > > pskb_expand_head will preserve the shared control buffer if it is=
 present.
> > > > > =

> > > > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.co=
m>
> > > > > ---
> > > > >  include/linux/skbuff.h | 24 +++++++++++++++++++++-
> > > > >  net/core/skbuff.c      | 56 ++++++++++++++++++++++++++++++++++++=
++-------
> > > > -----
> > > > >  2 files changed, 66 insertions(+), 14 deletions(-)
> > > > =

> > > > Boris, below is the change I mentioned to you.
> > > > =

> > > > It allows to allocate 48 additional bytes on-demand after skb_share=
d_info.
> > > > As it is on-demand, it won't increase the size of the skb for other=
 users.
> > > > =

> > > > For example, TLS could start using it when it creates the skb that =
it
> > > > pushes down to the TCP-stack. That way you don't need to handle the
> > > > tls_record lists.
> > > > =

> > > =

> > > One small problem is that TLS doesn't create SKBs. As a ULP it calls =
the transport send
> > > Functions (do_tcp_sendpages for TLS). This function receives a page a=
nd not a SKB.
> > =

> > yes, that's a good point. Mat has another patch as part of this series,
> > that adds an skb-arg to sendpages
> > (https://lists.01.org/pipermail/mptcp/2017-October/000130.html)
> > =

> > That should do the job for you.
> =

> After working with the extended control block some more, I found that the
> arg to sendpages (at least as I implemented it in that patch) doesn't work
> out because skb_entail() isn't called. I'm experimenting with allocating =
and
> entailing an empty skb before calling do_tcp_sendpages(), which will then
> find the extended skb on the write queue and append to it. It's involving=
 a
> lot of code to handle the memory waits and error conditions, though - it's
> probably cleaner to plumb some parameters in to do_tcp_sendpages() and
> sk_stream_alloc_skb() to request the extended skb.

we then also need a way for the ULP to pass the info down to
do_tcp_sendpages that should be written in the extended region of the skb.


Christoph


--===============8623957861835378676==--
