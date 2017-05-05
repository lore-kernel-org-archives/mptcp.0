Content-Type: multipart/mixed; boundary="===============4704587538227090780=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Change to remove MPTCP members from tcp_skb_cb
Date: Fri, 05 May 2017 16:14:37 -0700
Message-ID: <alpine.OSX.2.21.1705051351420.27460@mjmartin-mac01.sea.intel.com>
In-Reply-To: 42d4a34e-623b-3a6a-9c80-5fe357d9b0f9@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 30

--===============4704587538227090780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao,


On Thu, 4 May 2017, Rao Shoaib wrote:

> Hi Mat,
> =

> You have raised concern about someone using the head room. I would like t=
o understand how Linux SKB's work as I have a different
> understanding.
> =

> I assumed that all code in Linux follows the basic principle that header =
space is reserved when the skb is allocated. That is why there is
> =

> LL_MAX_HEADER -- /* Compute the worst-case header length according to the=
 protocols used */
> =

> Plus the SKB usage rules are very clear about references.
> =

> /* We divide dataref into two halves.=C2=A0 The higher 16 bits hold refer=
ences
> =C2=A0* to the payload part of skb->data.=C2=A0 The lower 16 bits hold re=
ferences to
> =C2=A0* the entire skb->data.
> =C2=A0*
> In this case the dataref (lower 16 bits) will be greater than one and a I=
 expect a consumer to call skb_cow_head() to determine if the header
> can be changed or does it need to make a copy. __vlan_insert_tag() for ex=
ample does just that. So what are the condition that allow a
> consumer to disregard these rules and just use the header space ?

I generally refer to http://vger.kernel.org/~davem/skb_data.html for =

sk_buff basics. It's a little dated (sk_buff has grown since it was =

written), but still helpful.

skb_headroom() will indicate that space is available without regard to the =

reference counts in dataref, or the presence of MPTCP stuff at skb->head. =

I think that function needs to continue to return a trustworthy value.

As for when header space is writable, __skb_header_release() is used by =

the tcp stack before placing packets in the write queue, so clones of =

those skbs will be able to write in the header space without making a copy =

first.

> =

> As evident from the 2nd patch that I have sent out,=C2=A0 I am not commit=
ted to any fix. If the team does not agree, we have to keep trying. This
> is a good exercise for me to learn the nuances of Linux networking. I wil=
l be an expert on SKB's by the time we are done :-).

Thanks for sticking with it!

I spent some time this afternoon looking at sk_buff->reserved_tailroom =

(and associated functions like skb_availroom() and =

skb_tailroom_reserve()). This does reserve space (at least for some =

purposes) and seems to be used only by IGMP and IPv6 multicast, and avoids =

the ambiguity of writable headers. However, it's still putting the data =

buffer to use for something other than packet data (which I remain =

concerned about).

--
Mat Martineau
Intel OTC

--===============4704587538227090780==--
