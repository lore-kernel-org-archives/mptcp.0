Content-Type: multipart/mixed; boundary="===============5206443180671974919=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Thu, 09 Nov 2017 06:02:25 +0900
Message-ID: <20171108210225.GB58503@Chimay.local>
In-Reply-To: cea6ef13-6f80-87a9-3734-2484e57e2a71@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 163

--===============5206443180671974919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 08/11/17 - 12:41:31, Rao Shoaib wrote:
> =

> =

> On 11/07/2017 04:25 PM, Christoph Paasch wrote:
> > The way it is handled currently is that the mapping is decided during
> > mptcp_skb_entail(), which writes the mapping to the skb->cb.
> > =

> >  From that moment on it won't change anymore and, as you know, it will =
simply
> > get copied from the skb->cb to the TCP-header in mptcp_options_write().
> > =

> > =

> > Christoph
> Yes thanks I get it. And the receiver is coded that way. That is very
> implementation specific.
> =

> RFC 6824 Says:
> =

> =

> =C2=A0=C2=A0 A data sequence mapping does not need to be included in ever=
y MPTCP
> =C2=A0=C2=A0 packet, as long as the subflow sequence space in that packet=
 is
> =C2=A0=C2=A0 covered by a mapping known at the receiver.=C2=A0 This can b=
e used to
> =C2=A0=C2=A0 reduce overhead in cases where the mapping is known in advan=
ce; one
> =C2=A0=C2=A0 such case is when there is a single subflow between the host=
s,
> =C2=A0=C2=A0 another is when segments of data are scheduled in larger tha=
n packet-
> =C2=A0=C2=A0 sized chunks.
> =

> So DSS mapping is not required in every packet.

Yes, and currently Linux supports that gracefully.

> There could also be a sub
> mapping for the segment itself that does not violates the original larger
> mapping or there can be a super mapping which extends the current mapping
> without violating it. Current code does not handle that, I will update the
> code.

The difficulty here is in the DSS checksum verification. When you have
different overlapping mappings, you will need to do quite some magic to
verify the checksums.


Christoph

> Thanks for pointing out this case as I had not tested partial ACK. Without
> partial ACK everything will work. Luckily the fix is very straight forwar=
d.
> =

> Regards,
> =

> Shoaib
> =

>=20

--===============5206443180671974919==--
