Content-Type: multipart/mixed; boundary="===============6653951703577660399=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: Re: [multipathtcp] RFC6824bis edits based on
 implementation feedback
Date: Thu, 02 Jan 2020 10:42:33 -0800
Message-ID: <20200102184233.GC44237@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 3251

--===============6653951703577660399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

(Only MPTCP upstream-list)

Hi all,

happy new year! :-)


To help in the IETF-process, it would be good if you reply to my previous
mail with a statement of support to the IETF mailing-list. That will help
getting these changes in.


Christoph


----- Forwarded message from Christoph Paasch <cpaasch=3D40apple.com(a)dmar=
c.ietf.org> -----

From: Christoph Paasch <cpaasch=3D40apple.com(a)dmarc.ietf.org>
To: Alan Ford <alan.ford(a)gmail.com>
Cc: MultiPath TCP - IETF WG <multipathtcp(a)ietf.org>, mptcp Upstreaming <m=
ptcp(a)lists.01.org>
Date: Thu, 02 Jan 2020 10:26:55 -0800
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck

+ MPTCP upstreaming community


Hello,

On 01/01/20 - 22:51:32, Alan Ford wrote:
> Hi all,
> =

> We=E2=80=99d love to get this to a state of completion as soon as possibl=
e, and to this end I am starting a new thread on this topic. In discussion =
with the chairs, it is possible to make the desired changes in AUTH48 as lo=
ng as there is WG consensus. The discussion so far has been fairly limited =
in terms of participation.
> =

> I would ask the chairs please if it was possible to specify a time bound =
for this discussion and a default conclusion.
> =

> Regarding the changes, in summary, there are two areas where changes have=
 been requested by the implementation community. As we are the IETF we obvi=
ously have strong focus on =E2=80=9Crunning code=E2=80=9D and so ease of im=
plementing standards-compliant code is strongly desirable. However, we do n=
ot wish to reduce functionality agreed by the IETF community if it is consi=
dered a required feature by the community.
> =

> =

> Change 1
> =

> Change the sentence reading:
> =

>    If B has data to send first, then the reliable delivery of the ACK + M=
P_CAPABLE can be inferred by the receipt of this data with an MPTCP Data Se=
quence Signal (DSS) option (Section 3.3). =

> =

> To:
> =

>    If B has data to send first, then the reliable delivery of the ACK + M=
P_CAPABLE is ensured by the receipt of this data with an MPTCP Data Sequenc=
e Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPABL=
E (which is the first octet of the data sequence space).
> =

> What this means:
> =

> The current text is concerned only with ensuring a path is MPTCP capable,=
 and so only cares that DSS option occurs on a data packet. However, the MP=
_CAPABLE option is defined to occupy the first octet of data sequence space=
 and thus, if analogous to TCP, must be acknowledged. From an implementatio=
n point of view it would make sense not to have this hanging around forever=
 and instead define it is acknowledged at the connection level as soon as r=
eceived. This change ensures the first data packet also DATA_ACKs this MP_C=
APABLE octet.
> =

> =

> Change 2
> =

> Change the sentence reading:
> =

>    A Data Sequence Mapping does not need to be included in every MPTCP pa=
cket, as long as the subflow sequence space in that packet is covered by a =
mapping known at the receiver.
> =

> To:
> =

>    The mapping provided by a Data Sequence Mapping MUST apply to some or =
all of the subflow sequence space in the TCP segment which carries the opti=
on. It does not need to be included in every MPTCP packet, as long as the s=
ubflow sequence space in that packet is covered by a mapping known at the r=
eceiver.
> =

> What this means:
> =

> The current text does not place any restrictions on where a mapping could=
 appear. In theory a sender could define a thousand different mappings up f=
ront, send them all, and expect a receiver to store this and reassemble dat=
a according to these mappings as it arrives. Indeed, this was never explici=
tly disallowed since it =E2=80=9Cmight have been useful=E2=80=9D. The imple=
mentation community, however, has expressed concerns over the difficulty of=
 implementing this open-endedly. How many mappings is it reasonable to stor=
e? Is there a DoS risk here? Instead, it has been requested that thee speci=
fication restricts the placement of the DSS option to being within the subf=
low sequence space to which it applies.
> =

> =

> Please can members of the WG express whether they are happy with these ch=
anges, or concerned.

As an implementor and having been the one kicking off this discussion, I fu=
lly
support this change.



Thanks,
Christoph

_______________________________________________
multipathtcp mailing list
multipathtcp(a)ietf.org
https://www.ietf.org/mailman/listinfo/multipathtcp

----- End forwarded message -----
--===============6653951703577660399==--
