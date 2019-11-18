Content-Type: multipart/mixed; boundary="===============5907199164149558234=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Warn + crash in mptcp_sendmsg_frag()
Date: Mon, 18 Nov 2019 12:07:05 +0100
Message-ID: <4b863b915dcd0dd1f3421888e781fb16d308fd18.camel@redhat.com>
In-Reply-To: 39fd64d6-5fd5-ec15-3ed5-c123edb94f39@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2573

--===============5907199164149558234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-11-16 at 13:59 +0100, Matthieu Baerts wrote:
> On 15/11/2019 23:39, Paolo Abeni wrote:
> > On Fri, 2019-11-15 at 22:06 +0100, Matthieu Baerts wrote:
> > > If skb is NULL, mpext is NULL too (even if it could unlikely also be
> > > even if skb is no NULL but sounds more like a bug I guess) and
> > > can_collapse is False.
> > =

> > Uhm... I don't think this is the case. mpext is NULL even when
> > do_tcp_sendpages() did not collapsed the data - that is in the above
> > scenario.
> =

> I get the OOPS I got was because mpext was NULL, no?
> =

> BUG: kernel NULL pointer dereference, address: 0000000000000014
> =

> I didn't check with pahole but maybe linked to this instruction:
> =

>    mpext->data_len +=3D ret;

Sorry, I was not clear.

yes, very likely the crash is due to mpext, but I don't think mpext is
NULL because skb is NULL. I think it's NULL because there was no
coalescing on skb (and thus no prior mpext in place).

Cheers,

Paolo

--===============5907199164149558234==--
