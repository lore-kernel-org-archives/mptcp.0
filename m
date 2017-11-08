Content-Type: multipart/mixed; boundary="===============3804293641651179656=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Wed, 08 Nov 2017 12:41:31 -0800
Message-ID: <cea6ef13-6f80-87a9-3734-2484e57e2a71@oracle.com>
In-Reply-To: 20171108002552.GK5226@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 161

--===============3804293641651179656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 11/07/2017 04:25 PM, Christoph Paasch wrote:
> The way it is handled currently is that the mapping is decided during
> mptcp_skb_entail(), which writes the mapping to the skb->cb.
>
>  From that moment on it won't change anymore and, as you know, it will si=
mply
> get copied from the skb->cb to the TCP-header in mptcp_options_write().
>
>
> Christoph
Yes thanks I get it. And the receiver is coded that way. That is very =

implementation specific.

RFC 6824 Says:


 =C2=A0=C2=A0 A data sequence mapping does not need to be included in every=
 MPTCP
 =C2=A0=C2=A0 packet, as long as the subflow sequence space in that packet =
is
 =C2=A0=C2=A0 covered by a mapping known at the receiver.=C2=A0 This can be=
 used to
 =C2=A0=C2=A0 reduce overhead in cases where the mapping is known in advanc=
e; one
 =C2=A0=C2=A0 such case is when there is a single subflow between the hosts,
 =C2=A0=C2=A0 another is when segments of data are scheduled in larger than=
 packet-
 =C2=A0=C2=A0 sized chunks.

So DSS mapping is not required in every packet. There could also be a =

sub mapping for the segment itself that does not violates the original =

larger mapping or there can be a super mapping which extends the current =

mapping without violating it. Current code does not handle that, I will =

update the code.

Thanks for pointing out this case as I had not tested partial ACK. =

Without partial ACK everything will work. Luckily the fix is very =

straight forward.

Regards,

Shoaib



--===============3804293641651179656==--
