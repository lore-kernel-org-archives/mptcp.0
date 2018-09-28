Content-Type: multipart/mixed; boundary="===============9041995610166315447=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Using do_tcp_sendpages() for MPTCP (?)
Date: Fri, 28 Sep 2018 10:53:44 -0700
Message-ID: <20180928175344.GZ1948@MacBook-Pro-19.local>
In-Reply-To: alpine.OSX.2.21.1809271522280.10925@cordarry-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 760

--===============9041995610166315447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 27/09/18 - 16:12:12, Mat Martineau wrote:
> =

> On Thu, 27 Sep 2018, Christoph Paasch wrote:
> =

> > Hello,
> > =

> > I am trying to rework our handling of the skb-building in tcp_sendmsg
> > (avoiding custom function-pointers for select_size,...) to reduce our i=
mpact
> > on regular TCP.
> > =

> > So, I started looking into what it takes to use do_tcp_sendpages when
> > pushing from the MPTCP-level to the subflow-level.
> > =

> > A problem is that do_tcp_sendpages() only works on subflows that have
> > SG-support (see the check in tcp_sendpage_locked()).
> > =

> > So, that would be kind of problematic, no?
> > =

> > I'm also not 100% sure how that is handled for the in-kernel TLS :-/
> =

> Hi Christoph -
> =

> I'm not quite sure why tcp_sendpage_locked() has that check. It may even
> force extra copying by GSO. If the net device does not have NETIF_F_SG wh=
en
> an skb is to be sent to the device, the skb will get linearized just befo=
re
> getting pushed to the device (see __dev_queue_xmit() and
> validate_xmit_skb())
> =

> What's more, NETIF_F_SG is not necessarily fixed for a given device over
> time (see commit message for 113f99c3358564a0647d444c2ae34e8b1abfd5b9), so
> the stack must be able to handle scatter/gather skbs from do_tcp_sendpages
> even if the device turns off that feature while those skbs are queued abo=
ve
> the device layer.
> =

> GSO being always enabled now may also be a factor in not requiring
> linearized skbs.
> =

> This is what I've pieced together this afternoon, anyway - if anyone has
> better information, please share!

yes you are probably right in the sense that it does not matter now with GSO
always-on. I just got confused because tcp_sendmsg is still checking for SG
to decide whether or not to do zero-copy.


Thanks,
Christoph


--===============9041995610166315447==--
