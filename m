Content-Type: multipart/mixed; boundary="===============6554279041218902276=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] RFC6824bis edits based on implementation
 feedback
Date: Tue, 11 Feb 2020 14:29:58 -0800
Message-ID: <F3D07C9D-12B2-45A7-B9D0-23E862DDF4BA@apple.com>
In-Reply-To: CAAK044QoFh_eXE+MwggOn5X0uUs3xuzTcw2kdJaKuUnEP745dA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3620

--===============6554279041218902276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+MPTCP-upstreaming

> On Feb 11, 2020, at 1:05 AM, Yoshifumi Nishida <nsd.ietf(a)gmail.com> wro=
te:
> =

> Hi folks,
> I guess we might want to know the behavior of existing implementations su=
ch as linux.
> When an mptcp stack tries to send a data packet and find that there's no =
enough option space for data mapping, what it will do?

iOS, multipath-tcp.org <http://multipath-tcp.org/> and Linux 5.6 implementa=
tion all favor the DSS-option over any other option (except TCP Timestamps)=
. And TCP Timestamps and DSS comfortably fit in the TCP option-space.

If SACK-blocks should be added, we only add SACK-blocks up to the remaining=
 space. SACK is anyways opportunistic as once there are more than 3 blocks =
they don't fit either.


Christoph

> Split the packet to create more option space?
> --
> Yoshi
> =

> On Thu, Feb 6, 2020 at 10:10 AM V Anil Kumar <anil(a)csir4pi.in <mailto:a=
nil(a)csir4pi.in>> wrote:
> Hi Alan,
> =

> Thank you for your reply. I have two points to clarify. Please see them i=
n line.
> =

> From: "Alan Ford" <alan.ford(a)gmail.com <mailto:alan.ford(a)gmail.com>>
> To: "V Anil Kumar" <anil(a)csir4pi.in <mailto:anil(a)csir4pi.in>>jk =

> Cc: "Yoshifumi Nishida" <nsd.ietf(a)gmail.com <mailto:nsd.ietf(a)gmail.co=
m>>, "multipathtcp" <multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.or=
g>>
> Sent: Thursday, February 6, 2020 2:49:29 AM
> Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feed=
back
> Hi Anil,
> =

> This would not be forbidden if the mapping was carried on a pure ACK with=
 no data.
> As far as I understand, delivery of DSM through pure ACK is not in the sc=
ope of the current draft. If we intend to do this, we may need an approach =
similar to the one proposed for delivery of ADD_ADDR option in pure ACK wit=
h reliability feature.  So, packing DSM on pure ACK does not seem to be an =
option at this stage.
> =

> I do see the point here: if a packet of 1000 bytes contains 500 bytes of =
one mapping and 500 bytes of another mapping, then only one DSM would appea=
r on one packet, leaving the mapping for the second 500 bytes to be carried=
 somewhere else - the only option being a pure ACK. But this kind of scenar=
io would be extremely rare
> Yes, I do agree that the scenario you mentioned above would be extremely =
rare. In fact, I wonder whether such a situation (i.e., need to cover the b=
ytes in a single packet with two different maps) would ever arise. Probably=
 there might be some corner cases, which I don't get it rightly now. =

> =

> More importantly, the scenario that Yoshi and me are referring to is tota=
lly different: the one I had given as part of my comments in response to th=
e proposed change 2. In this scenario, which you could see in the trailing =
mail, data segment-1 is transmitted without including its map, something wh=
ich is permitted in the  mptcp framework (6824 bis). I make this inference =
from the below text in 6824 bis:
> =

> "...even if a mapping does not exist from the subflow space to the data- =
level space, the data SHOULD still be ACKed at the subflow (if it is in-win=
dow). This data cannot, however, be acknowledged at the data level (Section=
 3.3.2) because its data sequence numbers are unknown. Implementations MAY =
hold onto such unmapped data for a short while in the expectation that a ma=
pping will arrive shortly."
> =

> One option the data sender has at this stage is to include the map for da=
ta in segment-1, in segment-3 (please see the two-subflow example I gave in=
 response to the change 2 you had proposed). But the proposed change does n=
ot permit this. What would happen to  subflow-1 in this case ?
> =

> With regards,
> =

> Anil    =

> and I would imagine any implementation would just split into two 500 byte=
 segments each with the PSH flag set. I don=E2=80=99t think we need to spel=
l this out in the spec however.
> =

> Regards,
> Alan
> =

> On 5 Feb 2020, at 15:09, V Anil Kumar <anil(a)csir4pi.in <mailto:anil(a)c=
sir4pi.in>> wrote:
> Hi Yoshi,
> =

> Please see in line.
> =

> From: "Yoshifumi Nishida" <nsd.ietf(a)gmail.com <mailto:nsd.ietf(a)gmail.=
com>>
> To: "V Anil Kumar" <anil(a)csir4pi.in <mailto:anil(a)csir4pi.in>>
> Cc: "alan ford" <alan.ford(a)gmail.com <mailto:alan.ford(a)gmail.com>>, "=
multipathtcp" <multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>>
> Sent: Tuesday, February 4, 2020 1:08:45 PM
> Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feed=
back
> =

> Hi Anil,
> =

> Thanks for pointing it out. I overlooked this one.
> This looks an interesting point.
> =

> It seems to me that whether RST is happen or not depends on the size of r=
eceive window according to the text.
> If the receive window size is big enough to accommodate segment 1 and seg=
ment 3, the text "Implementations MAY hold onto such unmapped data for a sh=
ort while in the expectation that a mapping will arrive shortly. " can be a=
pplied to the segment 1. As a result, the segment 1 won't be discarded. =

> =

> Yes.  So, segment 1 may be kept in the data receiver's buffer in expectat=
ion that its mapping will arrive shortly. And in the example that we are re=
ferring to, the data sender will not be able to include the map for the dat=
a in segment 1 in segment 3 or any higher segment.
> =

> Regards,
> =

> Anil
> =

> However, this might be contradict with the new texts Alan proposed? Or, a=
m I missing something?
> =

> Thanks,
> --
> Yoshi
> =

> =

> =

> On Sun, Feb 2, 2020 at 8:42 AM V Anil Kumar <anil(a)csir4pi.in <mailto:an=
il(a)csir4pi.in>> wrote:
> Hi Yoshi,
> =

> Thanks for this point. In fact, I had initially not thought of a scenario=
, where the map is being delivered through a retransmitted data packet whil=
e its first transmission did not include the map. Now I am just seeing the =
document (RFC 6824-bis) in this context.
> =

> My understanding is that in scenarios like what I described in my previou=
s mail, RST is likely to happen whether we explicitly state so or not. Plea=
se see the paragraph containing the below text in RFC 6824-bis.  =

> =

> "If a mapping for that subflow-level sequence space does not arrive withi=
n a receive window of data, that subflow SHOULD be treated as broken, close=
d with a RST, and any unmapped data silently discarded."
> =

> if we assume that the map is included while retransmitting the data (even=
 though the first transmission did not contain the map for some reasons),  =
we could argue that RST could be avoided provided that the retransmission i=
s triggered within a receive window of data. But the question here would be=
 how and when will the retransmission take place. In this case, the subflow=
 may not initiate the retransmission of data by its own (i..e., no retransm=
ission due to three duplicate ACKs or RTO expiry at subflow level) as there=
 is no segment loss at subflow level sequence space. So there could be a hi=
gh possibility of RST happening even before the map delivery through retran=
smission. =

> =

> With regards, =

> =

> Anil
>  =

> From: "Yoshifumi Nishida" <nsd.ietf(a)gmail.com <mailto:nsd.ietf(a)gmail.=
com>>
> To: "V Anil Kumar" <anil(a)csir4pi.in <mailto:anil(a)csir4pi.in>>
> Cc: "alan ford" <alan.ford(a)gmail.com <mailto:alan.ford(a)gmail.com>>, "=
multipathtcp" <multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>>
> Sent: Saturday, February 1, 2020 3:39:51 AM
> Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feed=
back
> =

> Hi Anil,
> =

> I have a question about your proposed text.
> I am actually wondering if we really want to terminate connection here. =

> =

> The packets without proper mappings will be treated as invalid and will b=
e discarded. =

> If an implementation failed to attach proper mapping for some reasons (e.=
g. option space), it might be able to attach the proper one when it retrans=
mits the packets. This also looks ok to me.
> =

> I don't have strong preference for this. But, do we have a reason to term=
inate connection?
> =

> Thanks,
> --
> Yoshi
> =

> On Mon, Jan 13, 2020 at 10:28 AM V Anil Kumar <anil(a)csir4pi.in <mailto:=
anil(a)csir4pi.in>> wrote:
> Hi,
> =

> I have some points related to the  modifications (Change 2) being propose=
d on data sequence map. Please see them inline. Though I am putting forward=
 the below points, if the consensus is in favour of the proposed change for=
 reducing implementation complexity, I am also OK with that as well. =

> =

> From: "alan ford" <alan.ford(a)gmail.com <mailto:alan.ford(a)gmail.com>>
> To: multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>
> Sent: Thursday, January 2, 2020 4:21:32 AM
> Subject: [multipathtcp] RFC6824bis edits based on implementation feedback
> =

> Hi all,
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
 and thus, if analogous to TCP, must be acknowledged. >From an implementati=
on point of view it would make sense not to have this hanging around foreve=
r and instead define it is acknowledged at the connection level as soon as =
received. This change ensures the first data packet also DATA_ACKs this MP_=
CAPABLE octet.
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

> Below are my comments on this. I had shared some of these points in a pre=
vious thread that you had initiated in the same context. =

> =

> Transmitting large number of non-contiguous data sequence maps could be a=
 misbehaviour (map-flooding), though it is not clear whether this can go to=
 the extent of causing a potential DoS to the data receiver. So some sort o=
f restriction on this could be useful.  One approach could be to insist tha=
t the data sender should ensure that the map being transmitted is for in-wi=
ndow data, as per the receiver advertised window. A receiver should anyhow =
be willing to store the maps for in-window data to deal with packet loss. F=
or example, when a window of data segments (say 1 to 64) is transmitted, ea=
ch carrying its corresponding map, and segment-1 is lost, the maps for the =
remaining 63 need to be stored till the lost segment is retransmitted. Of c=
ourse, in this case the maps will be stored at the receiver side along with=
 their corresponding data. But the need to store multiple maps for in-windo=
w data would still be there.
> =

> The problem with the proposed change (restriction) is that a data sender =
may find it difficult, in case a need arise to slightly delay the map deliv=
ery by few segments, i.e., sending some data first without map, and then se=
nd the corresponding map in a later segment, as shown below:
> =

> subflow-1:      segment-1                   segment-3                    =
segment-4                       segment-7
>                       bytes:1-100                 bytes:201-300          =
    bytes:301-400                 bytes:601-700
>                       no map                        map for 1-100        =
      map for 201-400             map for 601-700
> =

> =

> =

> subflow-2:       segment-2                  segment-5                    =
 segment-6                       segment-8
>                        bytes: 101-200           bytes:401-500            =
   bytes: 501-600                bytes:701-800   =

>                        map for 101-200       map for 401-600            n=
o map                            map for 701-800
> =

> =

> In the above case, segment-1 goes without map and its map is included lat=
er in segment-3, the next data segment in the same subflow. Further,  in th=
e above scheduling pattern, the map in segment-3 cannot cover the  data in =
segment-1 and segment-3, as some  data in between (segment-2) is transmitte=
d through another subflow.  With the proposed change, the map in segment-3 =
will become invalid and this will eventually break subflow-1, though this c=
ould be a corner case..
> =

> The question at this stage is why would segment-1 be transmitted without =
its map. In the case of bidirectional data transfer, there could be a need =
to pack both timestamp and SACK  options in a data segment, i.e., piggyback=
ing of  SACK with data. If we consider that timestamp takes 12 bytes and SA=
CK, even with single block,  takes another 10 bytes, the remaining 18 bytes=
 option space is not adequate to carry data sequence signal with map, espec=
ially when DSN is 64 bit long. So the delivery of either of the two (SACK o=
r map) would be delayed.
> =

> As far as I understand, RFC 2018 (TCP Selective Acknowledgement Options) =
implies that SACK should not be delayed. It states "If sent at all, SACK op=
tions SHOULD be included in all ACKs which do not ACK the highest sequence =
number in the data receiver's queue". It also says "If data receiver genera=
tes SACK options under any circumstance, it SHOULD generate them under all =
permitted circumstances".   So, as part of meeting the RFC 2018 requirement=
s, if the combination of SACK and timestamp is given preference over DSS, d=
ata segments could be transmitted without their map. =

> =

> Another case of delaying map could arise if the data sender prefers to se=
nd ADD_ADDR option, instead of map, in a data segment. It is nice that ADD_=
ADDR option can be delivered reliably in a pure ACK, but I think this is no=
t the case with DSS at present.
> =

> If we adopt the proposed change, I think it might also be helpful to spel=
l out how the receiver is supposed to behave, if it gets maps not meeting t=
he MUST condition in the proposed change.  For example termination of the s=
ubflow with MP_TCPRST option (section 3.6 in RFC 6824-bis) with appropriate=
 reason code and T flag value to intimate the data sender the cause for sub=
flow termination.  =

>          =

> With regards,
> =

> Anil
> =

> Please can members of the WG express whether they are happy with these ch=
anges, or concerned.
> =

> Best regards,
> Alan
> =

> =

> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>
> https://www.ietf.org/mailman/listinfo/multipathtcp <https://www.ietf.org/=
mailman/listinfo/multipathtcp>
> =

> =

> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org <mailto:multipathtcp(a)ietf.org>
> https://www.ietf.org/mailman/listinfo/multipathtcp <https://www.ietf.org/=
mailman/listinfo/multipathtcp>
> =

> =

> =

> =

> =

> =

> =

> =

> =

> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org
> https://www.ietf.org/mailman/listinfo/multipathtcp


--===============6554279041218902276==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+K01QVENQLXVwc3RyZWFtaW5nPGJyIGNsYXNzPSIiPjxkaXY+PGJy
IGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+
T24gRmViIDExLCAyMDIwLCBhdCAxOjA1IEFNLCBZb3NoaWZ1bWkgTmlzaGlkYSAmbHQ7PGEgaHJl
Zj0ibWFpbHRvOm5zZC5pZXRmQGdtYWlsLmNvbSIgY2xhc3M9IiI+bnNkLmlldGZAZ21haWwuY29t
PC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5nZS1uZXdsaW5l
Ij48ZGl2IGNsYXNzPSIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+SGkg
Zm9sa3MsPC9kaXY+PGRpdiBjbGFzcz0iIj5JIGd1ZXNzIHdlIG1pZ2h0IHdhbnQgdG8ga25vdyB0
aGUgYmVoYXZpb3Igb2YgZXhpc3RpbmcgaW1wbGVtZW50YXRpb25zIHN1Y2ggYXMgbGludXguPC9k
aXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNz
PSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5X
aGVuIGFuIG1wdGNwIHN0YWNrIHRyaWVzIHRvIHNlbmQgYSBkYXRhIHBhY2tldCBhbmQgZmluZCB0
aGF0IHRoZXJlJ3Mgbm8gZW5vdWdoIG9wdGlvbiBzcGFjZSBmb3IgZGF0YSBtYXBwaW5nLCB3aGF0
IGl0IHdpbGwgZG8/PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNz
PSIiPjwvZGl2PjxkaXY+aU9TLCA8YSBocmVmPSJodHRwOi8vbXVsdGlwYXRoLXRjcC5vcmciIGNs
YXNzPSIiPm11bHRpcGF0aC10Y3Aub3JnPC9hPiZuYnNwO2FuZCBMaW51eCA1LjYgaW1wbGVtZW50
YXRpb24gYWxsIGZhdm9yIHRoZSBEU1Mtb3B0aW9uIG92ZXIgYW55IG90aGVyIG9wdGlvbiAoZXhj
ZXB0IFRDUCBUaW1lc3RhbXBzKS4gQW5kIFRDUCBUaW1lc3RhbXBzIGFuZCBEU1MgY29tZm9ydGFi
bHkgZml0IGluIHRoZSBUQ1Agb3B0aW9uLXNwYWNlLjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwv
ZGl2PjxkaXY+SWYgU0FDSy1ibG9ja3Mgc2hvdWxkIGJlIGFkZGVkLCB3ZSBvbmx5IGFkZCBTQUNL
LWJsb2NrcyB1cCB0byB0aGUgcmVtYWluaW5nIHNwYWNlLiBTQUNLIGlzIGFueXdheXMgb3Bwb3J0
dW5pc3RpYyBhcyBvbmNlIHRoZXJlIGFyZSBtb3JlIHRoYW4gMyBibG9ja3MgdGhleSBkb24ndCBm
aXQgZWl0aGVyLjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+PGJyIGNsYXNzPSIi
PjwvZGl2PjxkaXY+Q2hyaXN0b3BoPC9kaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9
ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+PGRp
diBjbGFzcz0iIj5TcGxpdCB0aGUgcGFja2V0IHRvIGNyZWF0ZSBtb3JlIG9wdGlvbiBzcGFjZT88
L2Rpdj48ZGl2IGNsYXNzPSIiPi0tPGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+WW9z
aGk8L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJs
dHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUaHUsIEZlYiA2LCAyMDIwIGF0IDEwOjEwIEFNIFYg
QW5pbCBLdW1hciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxAY3NpcjRwaS5pbiIgY2xhc3M9IiI+
YW5pbEBjc2lyNHBpLmluPC9hPiZndDsgd3JvdGU6PGJyIGNsYXNzPSIiPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48
ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IaSBBbGFuLDwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+VGhhbmsgeW91IGZv
ciB5b3VyIHJlcGx5LiBJIGhhdmUgdHdvIHBvaW50cyB0byBjbGFyaWZ5LiBQbGVhc2Ugc2VlIHRo
ZW0gaW4gbGluZS48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48aHIgaWQ9
ImdtYWlsLW1fODc3MzM1NzQzOTc3NzA4MTU5MHp3Y2hyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIi
PjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGVmdC13aWR0aDogMnB4OyBib3JkZXItbGVmdC1z
dHlsZTogc29saWQ7IGJvcmRlci1sZWZ0LWNvbG9yOiByZ2IoMTYsIDE2LCAyNTUpOyBtYXJnaW4t
bGVmdDogNXB4OyBwYWRkaW5nLWxlZnQ6IDVweDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgZm9udC1z
dHlsZTogbm9ybWFsOyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IGZvbnQtZmFtaWx5OiBIZWx2ZXRp
Y2EsIEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHQ7IiBjbGFzcz0iIj48YiBjbGFz
cz0iIj5Gcm9tOiA8L2I+IkFsYW4gRm9yZCIgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFuLmZvcmRA
Z21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9IiI+YWxhbi5mb3JkQGdtYWlsLmNvbTwv
YT4mZ3Q7PGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIiPlRvOiA8L2I+IlYgQW5pbCBLdW1hciIgJmx0
OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iIHRhcmdldD0iX2JsYW5rIiBjbGFzcz0i
Ij5hbmlsQGNzaXI0cGkuaW48L2E+Jmd0O2prJm5ic3A7PGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIi
PkNjOiA8L2I+Illvc2hpZnVtaSBOaXNoaWRhIiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5zZC5pZXRm
QGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPm5zZC5pZXRmQGdtYWlsLmNvbTwv
YT4mZ3Q7LCAibXVsdGlwYXRodGNwIiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm11bHRpcGF0aHRjcEBp
ZXRmLm9yZyIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwv
YT4mZ3Q7PGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIiPlNlbnQ6IDwvYj5UaHVyc2RheSwgRmVicnVh
cnkgNiwgMjAyMCAyOjQ5OjI5IEFNPGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIiPlN1YmplY3Q6IDwv
Yj5SZTogW211bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRh
dGlvbiBmZWVkYmFjazxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PC9kaXY+PGRpdiBjbGFzcz0i
Ij48YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLWxlZnQtd2lkdGg6IDJweDsgYm9yZGVyLWxlZnQt
c3R5bGU6IHNvbGlkOyBib3JkZXItbGVmdC1jb2xvcjogcmdiKDE2LCAxNiwgMjU1KTsgbWFyZ2lu
LWxlZnQ6IDVweDsgcGFkZGluZy1sZWZ0OiA1cHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGZvbnQt
c3R5bGU6IG5vcm1hbDsgdGV4dC1kZWNvcmF0aW9uOiBub25lOyBmb250LWZhbWlseTogSGVsdmV0
aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB0OyIgY2xhc3M9IiI+SGkgQW5p
bCw8ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPlRoaXMgd291
bGQgbm90IGJlIGZvcmJpZGRlbiBpZiB0aGUgbWFwcGluZyB3YXMgY2FycmllZCBvbiBhIHB1cmUg
QUNLIHdpdGggbm8gZGF0YS48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj5BcyBmYXIg
YXMgSSB1bmRlcnN0YW5kLCBkZWxpdmVyeSBvZiBEU00gdGhyb3VnaCBwdXJlIEFDSyBpcyBub3Qg
aW4gdGhlIHNjb3BlIG9mIHRoZSBjdXJyZW50IGRyYWZ0LiBJZiB3ZSBpbnRlbmQgdG8gZG8gdGhp
cywgd2UgbWF5IG5lZWQgYW4gYXBwcm9hY2ggc2ltaWxhciB0byB0aGUgb25lIHByb3Bvc2VkIGZv
ciBkZWxpdmVyeSBvZiBBRERfQUREUiBvcHRpb24gaW4gcHVyZSBBQ0sgd2l0aCByZWxpYWJpbGl0
eSBmZWF0dXJlLiZuYnNwOyBTbywgcGFja2luZyBEU00gb24gcHVyZSBBQ0sgZG9lcyBub3Qgc2Vl
bSB0byBiZSBhbiBvcHRpb24gYXQgdGhpcyBzdGFnZS48L2Rpdj48YmxvY2txdW90ZSBzdHlsZT0i
Ym9yZGVyLWxlZnQtd2lkdGg6IDJweDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXIt
bGVmdC1jb2xvcjogcmdiKDE2LCAxNiwgMjU1KTsgbWFyZ2luLWxlZnQ6IDVweDsgcGFkZGluZy1s
ZWZ0OiA1cHg7IGZvbnQtd2VpZ2h0OiBub3JtYWw7IGZvbnQtc3R5bGU6IG5vcm1hbDsgdGV4dC1k
ZWNvcmF0aW9uOiBub25lOyBmb250LWZhbWlseTogSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJp
ZjsgZm9udC1zaXplOiAxMnB0OyIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
PC9kaXY+PGRpdiBjbGFzcz0iIj5JIGRvIHNlZSB0aGUgcG9pbnQgaGVyZTogaWYgYSBwYWNrZXQg
b2YgMTAwMCBieXRlcyBjb250YWlucyA1MDAgYnl0ZXMgb2Ygb25lIG1hcHBpbmcgYW5kIDUwMCBi
eXRlcyBvZiBhbm90aGVyIG1hcHBpbmcsIHRoZW4gb25seSBvbmUgRFNNIHdvdWxkIGFwcGVhciBv
biBvbmUgcGFja2V0LCBsZWF2aW5nIHRoZSBtYXBwaW5nIGZvciB0aGUgc2Vjb25kIDUwMCBieXRl
cyB0byBiZSBjYXJyaWVkIHNvbWV3aGVyZSBlbHNlIC0gdGhlIG9ubHkgb3B0aW9uIGJlaW5nIGEg
cHVyZSBBQ0suIEJ1dCB0aGlzIGtpbmQgb2Ygc2NlbmFyaW8gd291bGQgYmUgZXh0cmVtZWx5IHJh
cmU8L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj5ZZXMsIEkgZG8gYWdyZWUgdGhhdCB0
aGUgc2NlbmFyaW8geW91IG1lbnRpb25lZCBhYm92ZSB3b3VsZCBiZSBleHRyZW1lbHkgcmFyZS4g
SW4gZmFjdCwgSSB3b25kZXIgd2hldGhlciBzdWNoIGEgc2l0dWF0aW9uIChpLmUuLCBuZWVkIHRv
IGNvdmVyIHRoZSBieXRlcyBpbiBhIHNpbmdsZSBwYWNrZXQgd2l0aCB0d28gZGlmZmVyZW50IG1h
cHMpIHdvdWxkIGV2ZXIgYXJpc2UuIFByb2JhYmx5IHRoZXJlIG1pZ2h0IGJlIHNvbWUgY29ybmVy
IGNhc2VzLCB3aGljaCBJIGRvbid0IGdldCBpdCByaWdodGx5IG5vdy4mbmJzcDs8L2Rpdj48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPk1vcmUgaW1wb3J0YW50
bHksIHRoZSBzY2VuYXJpbyB0aGF0IFlvc2hpIGFuZCBtZSBhcmUgcmVmZXJyaW5nIHRvIGlzIHRv
dGFsbHkgZGlmZmVyZW50OiB0aGUgb25lIEkgaGFkIGdpdmVuIGFzIHBhcnQgb2YgbXkgY29tbWVu
dHMgaW4gcmVzcG9uc2UgdG8gdGhlIHByb3Bvc2VkIGNoYW5nZSAyLiBJbiB0aGlzIHNjZW5hcmlv
LCB3aGljaCB5b3UgY291bGQgc2VlIGluIHRoZSB0cmFpbGluZyBtYWlsLCBkYXRhIHNlZ21lbnQt
MSBpcyB0cmFuc21pdHRlZCB3aXRob3V0IGluY2x1ZGluZyBpdHMgbWFwLCBzb21ldGhpbmcgd2hp
Y2ggaXMgcGVybWl0dGVkIGluIHRoZSAmbmJzcDttcHRjcCBmcmFtZXdvcmsgKDY4MjQgYmlzKS4g
SSBtYWtlIHRoaXMgaW5mZXJlbmNlIGZyb20gdGhlIGJlbG93IHRleHQgaW4gNjgyNCBiaXM6PC9k
aXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj4gIi4uLmV2
ZW4gaWYgYSBtYXBwaW5nIGRvZXMgbm90IGV4aXN0IGZyb20gdGhlIHN1YmZsb3cgc3BhY2UgdG8g
dGhlIGRhdGEtIGxldmVsIHNwYWNlLCB0aGUgZGF0YSBTSE9VTEQgc3RpbGwgYmUgQUNLZWQgYXQg
dGhlIHN1YmZsb3cgKGlmIGl0IGlzIGluLXdpbmRvdykuIFRoaXMgZGF0YSBjYW5ub3QsIGhvd2V2
ZXIsIGJlIGFja25vd2xlZGdlZCBhdCB0aGUgZGF0YSBsZXZlbCAoU2VjdGlvbiAzLjMuMikgYmVj
YXVzZSBpdHMgZGF0YSBzZXF1ZW5jZSBudW1iZXJzIGFyZSB1bmtub3duLiBJbXBsZW1lbnRhdGlv
bnMgTUFZIGhvbGQgb250byBzdWNoIHVubWFwcGVkIGRhdGEgZm9yIGEgc2hvcnQgd2hpbGUgaW4g
dGhlIGV4cGVjdGF0aW9uIHRoYXQgYSBtYXBwaW5nIHdpbGwgYXJyaXZlIHNob3J0bHkuIiA8L2Rp
dj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPk9uZSBvcHRp
b24gdGhlIGRhdGEgc2VuZGVyIGhhcyBhdCB0aGlzIHN0YWdlIGlzIHRvIGluY2x1ZGUgdGhlIG1h
cCBmb3IgZGF0YSBpbiBzZWdtZW50LTEsIGluIHNlZ21lbnQtMyAocGxlYXNlIHNlZSB0aGUgdHdv
LXN1YmZsb3cgZXhhbXBsZSBJIGdhdmUgaW4gcmVzcG9uc2UgdG8gdGhlIGNoYW5nZSAyIHlvdSBo
YWQgcHJvcG9zZWQpLiBCdXQgdGhlIHByb3Bvc2VkIGNoYW5nZSBkb2VzIG5vdCBwZXJtaXQgdGhp
cy4gV2hhdCB3b3VsZCBoYXBwZW4gdG8gJm5ic3A7c3ViZmxvdy0xIGluIHRoaXMgY2FzZSA/PC9k
aXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5XaXRoIHJl
Z2FyZHMsPC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0i
Ij5BbmlsICZuYnNwOyAmbmJzcDs8L2Rpdj48YmxvY2txdW90ZSBzdHlsZT0iYm9yZGVyLWxlZnQt
d2lkdGg6IDJweDsgYm9yZGVyLWxlZnQtc3R5bGU6IHNvbGlkOyBib3JkZXItbGVmdC1jb2xvcjog
cmdiKDE2LCAxNiwgMjU1KTsgbWFyZ2luLWxlZnQ6IDVweDsgcGFkZGluZy1sZWZ0OiA1cHg7IGZv
bnQtd2VpZ2h0OiBub3JtYWw7IGZvbnQtc3R5bGU6IG5vcm1hbDsgdGV4dC1kZWNvcmF0aW9uOiBu
b25lOyBmb250LWZhbWlseTogSGVsdmV0aWNhLCBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXpl
OiAxMnB0OyIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5hbmQgSSB3b3VsZCBpbWFnaW5lIGFueSBp
bXBsZW1lbnRhdGlvbiB3b3VsZCBqdXN0IHNwbGl0IGludG8gdHdvIDUwMCBieXRlIHNlZ21lbnRz
IGVhY2ggd2l0aCB0aGUgUFNIIGZsYWcgc2V0LiBJIGRvbuKAmXQgdGhpbmsgd2UgbmVlZCB0byBz
cGVsbCB0aGlzIG91dCBpbiB0aGUgc3BlYyBob3dldmVyLjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+UmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSIi
PkFsYW48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48YmxvY2txdW90ZSBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPk9uIDUgRmViIDIwMjAsIGF0IDE1
OjA5LCBWIEFuaWwgS3VtYXIgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iIHJl
bD0ibm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIi
PmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBj
bGFzcz0iIj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJp
ZiIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxo
ZWx2ZXRpY2Esc2Fucy1zZXJpZiIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IHN0eWxlPSJm
b250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiIgY2xhc3M9IiI+PGRpdiBjbGFz
cz0iIj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiIg
Y2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IaSBZb3NoaSw8L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBj
bGFzcz0iIj5QbGVhc2Ugc2VlIGluIGxpbmUuPC9kaXY+PGJyIGNsYXNzPSIiPjxociBpZD0iZ21h
aWwtbV84NzczMzU3NDM5Nzc3MDgxNTkwendjaHIiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGIg
Y2xhc3M9IiI+RnJvbTogPC9iPiJZb3NoaWZ1bWkgTmlzaGlkYSIgJmx0OzxhIGhyZWY9Im1haWx0
bzpuc2QuaWV0ZkBnbWFpbC5jb20iIHJlbD0ibm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPm5zZC5pZXRmQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyIGNs
YXNzPSIiPjxiIGNsYXNzPSIiPlRvOiA8L2I+IlYgQW5pbCBLdW1hciIgJmx0OzxhIGhyZWY9Im1h
aWx0bzphbmlsQGNzaXI0cGkuaW4iIHJlbD0ibm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIg
dGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7PGJyIGNsYXNz
PSIiPjxiIGNsYXNzPSIiPkNjOiA8L2I+ImFsYW4gZm9yZCIgJmx0OzxhIGhyZWY9Im1haWx0bzph
bGFuLmZvcmRAZ21haWwuY29tIiByZWw9Im5vZm9sbG93IG5vb3BlbmVyIG5vcmVmZXJyZXIiIHRh
cmdldD0iX2JsYW5rIiBjbGFzcz0iIj5hbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDssICJtdWx0
aXBhdGh0Y3AiICZsdDs8YSBocmVmPSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3JnIiByZWw9
Im5vZm9sbG93IG5vb3BlbmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIiBjbGFzcz0iIj5t
dWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+Jmd0OzxiciBjbGFzcz0iIj48YiBjbGFzcz0iIj5TZW50
OiA8L2I+VHVlc2RheSwgRmVicnVhcnkgNCwgMjAyMCAxOjA4OjQ1IFBNPGJyIGNsYXNzPSIiPjxi
IGNsYXNzPSIiPlN1YmplY3Q6IDwvYj5SZTogW211bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0
cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBmZWVkYmFjazxiciBjbGFzcz0iIj48L2Rpdj48YnIg
Y2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkhpIEFu
aWwsPC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+VGhhbmtzIGZvciBwb2ludGluZyBp
dCBvdXQuIEkgb3Zlcmxvb2tlZCB0aGlzIG9uZS48L2Rpdj48ZGl2IGNsYXNzPSIiPlRoaXMgbG9v
a3MgYW4gaW50ZXJlc3RpbmcgcG9pbnQuPGJyIGNsYXNzPSIiPjwvZGl2PjxiciBjbGFzcz0iIj48
ZGl2IGNsYXNzPSIiPkl0IHNlZW1zIHRvIG1lIHRoYXQgd2hldGhlciBSU1QgaXMgaGFwcGVuIG9y
IG5vdCBkZXBlbmRzIG9uIHRoZSBzaXplIG9mIHJlY2VpdmUgd2luZG93IGFjY29yZGluZyB0byB0
aGUgdGV4dC48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5JZiB0aGUgcmVjZWl2ZSB3
aW5kb3cgc2l6ZSBpcyBiaWcgZW5vdWdoIHRvIGFjY29tbW9kYXRlJm5ic3A7c2VnbWVudCAxIGFu
ZCBzZWdtZW50IDMsIHRoZSB0ZXh0ICI8c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzLjMzMzNweCIg
Y2xhc3M9IiI+SW1wbGVtZW50YXRpb25zIE1BWSBob2xkIG9udG8gc3VjaCB1bm1hcHBlZCBkYXRh
IGZvciBhIHNob3J0IHdoaWxlIGluJm5ic3A7PC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTMuMzMzM3B4IiBjbGFzcz0iIj50aGUgZXhwZWN0YXRpb24gdGhhdCBhIG1hcHBpbmcgd2lsbCBh
cnJpdmUgc2hvcnRseS4gIiZuYnNwOzwvc3Bhbj5jYW4gYmUgYXBwbGllZCB0byB0aGUgc2VnbWVu
dCAxLiBBcyBhIHJlc3VsdCwgdGhlIHNlZ21lbnQgMSB3b24ndCBiZSBkaXNjYXJkZWQuJm5ic3A7
PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGVtIGNsYXNzPSIiPlllcy4mbmJzcDsg
U28sIHNlZ21lbnQgMSBtYXkgYmUga2VwdCBpbiB0aGUgZGF0YSByZWNlaXZlcidzIGJ1ZmZlciBp
biBleHBlY3RhdGlvbiB0aGF0IGl0cyBtYXBwaW5nIHdpbGwgYXJyaXZlIHNob3J0bHkuIEFuZCBp
biB0aGUgZXhhbXBsZSB0aGF0IHdlIGFyZSByZWZlcnJpbmcgdG8sIHRoZSBkYXRhIHNlbmRlciB3
aWxsIG5vdCBiZSBhYmxlIHRvIGluY2x1ZGUgdGhlIG1hcCBmb3IgdGhlIGRhdGEgaW4gc2VnbWVu
dCAxIGluIHNlZ21lbnQgMyBvciBhbnkgaGlnaGVyIHNlZ21lbnQuPC9lbT48L2Rpdj48YnIgY2xh
c3M9IiI+PGRpdiBjbGFzcz0iIj48ZW0gY2xhc3M9IiI+UmVnYXJkcyw8L2VtPjwvZGl2PjxiciBj
bGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxlbSBjbGFzcz0iIj5BbmlsPC9lbT48L2Rpdj48YnIgY2xh
c3M9IiI+PGRpdiBjbGFzcz0iIj5Ib3dldmVyLCB0aGlzIG1pZ2h0IGJlIGNvbnRyYWRpY3Qgd2l0
aCB0aGUgbmV3IHRleHRzIEFsYW4gcHJvcG9zZWQ/IE9yLCBhbSBJIG1pc3Npbmcgc29tZXRoaW5n
PzwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPlRoYW5rcyw8L2Rpdj48ZGl2IGNsYXNz
PSIiPi0tPC9kaXY+PGRpdiBjbGFzcz0iIj5Zb3NoaTwvZGl2PjxiciBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9IiI+
T24gU3VuLCBGZWIgMiwgMjAyMCBhdCA4OjQyIEFNIFYgQW5pbCBLdW1hciAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmFuaWxAY3NpcjRwaS5pbiIgcmVsPSJub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2Zv
bGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9IiI+YW5pbEBj
c2lyNHBpLmluPC9hPiZndDsgd3JvdGU6PGJyIGNsYXNzPSIiPjwvZGl2PjxibG9ja3F1b3RlIGNs
YXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXIt
bGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGNs
YXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IHN0eWxlPSJmb250LWZhbWls
eTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IaSBZ
b3NoaSw8L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5UaGFua3MgZm9yIHRoaXMgcG9p
bnQuIEluIGZhY3QsIEkgaGFkIGluaXRpYWxseSBub3QgdGhvdWdodCBvZiBhIHNjZW5hcmlvLCB3
aGVyZSB0aGUgbWFwIGlzIGJlaW5nIGRlbGl2ZXJlZCB0aHJvdWdoIGEgcmV0cmFuc21pdHRlZCBk
YXRhIHBhY2tldCB3aGlsZSBpdHMgZmlyc3QgdHJhbnNtaXNzaW9uIGRpZCBub3QgaW5jbHVkZSB0
aGUgbWFwLiBOb3cgSSBhbSBqdXN0IHNlZWluZyB0aGUgZG9jdW1lbnQgKFJGQyA2ODI0LWJpcykg
aW4gdGhpcyBjb250ZXh0LjwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPk15IHVuZGVy
c3RhbmRpbmcgaXMgdGhhdCBpbiBzY2VuYXJpb3MgbGlrZSB3aGF0IEkgZGVzY3JpYmVkIGluIG15
IHByZXZpb3VzIG1haWwsIFJTVCBpcyBsaWtlbHkgdG8gaGFwcGVuIHdoZXRoZXIgd2UgZXhwbGlj
aXRseSBzdGF0ZSBzbyBvciBub3QuIFBsZWFzZSBzZWUgdGhlIHBhcmFncmFwaCBjb250YWluaW5n
IHRoZSBiZWxvdyB0ZXh0IGluIFJGQyA2ODI0LWJpcy4gJm5ic3A7PC9kaXY+PGJyIGNsYXNzPSIi
PjxkaXYgY2xhc3M9IiI+IklmIGEgbWFwcGluZyBmb3IgdGhhdCBzdWJmbG93LWxldmVsIHNlcXVl
bmNlIHNwYWNlIGRvZXMgbm90IGFycml2ZSB3aXRoaW4gYSByZWNlaXZlIHdpbmRvdyBvZiBkYXRh
LCB0aGF0IHN1YmZsb3cgU0hPVUxEIGJlIHRyZWF0ZWQgYXMgYnJva2VuLCBjbG9zZWQgd2l0aCBh
IFJTVCwgYW5kIGFueSB1bm1hcHBlZCBkYXRhIHNpbGVudGx5IGRpc2NhcmRlZC4iPC9kaXY+PGJy
IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+aWYgd2UgYXNzdW1lIHRoYXQgdGhlIG1hcCBpcyBpbmNs
dWRlZCB3aGlsZSByZXRyYW5zbWl0dGluZyB0aGUgZGF0YSAoZXZlbiB0aG91Z2ggdGhlIGZpcnN0
IHRyYW5zbWlzc2lvbiBkaWQgbm90IGNvbnRhaW4gdGhlIG1hcCBmb3Igc29tZSByZWFzb25zKSwg
Jm5ic3A7d2UgY291bGQgYXJndWUgdGhhdCBSU1QgY291bGQgYmUgYXZvaWRlZCBwcm92aWRlZCB0
aGF0IHRoZSByZXRyYW5zbWlzc2lvbiBpcyB0cmlnZ2VyZWQgd2l0aGluIGEgcmVjZWl2ZSB3aW5k
b3cgb2YgZGF0YS4gQnV0IHRoZSBxdWVzdGlvbiBoZXJlIHdvdWxkIGJlIGhvdyBhbmQgd2hlbiB3
aWxsIHRoZSByZXRyYW5zbWlzc2lvbiB0YWtlIHBsYWNlLiBJbiB0aGlzIGNhc2UsIHRoZSBzdWJm
bG93IG1heSBub3QgaW5pdGlhdGUgdGhlIHJldHJhbnNtaXNzaW9uIG9mIGRhdGEgYnkgaXRzIG93
biAoaS4uZS4sIG5vIHJldHJhbnNtaXNzaW9uIGR1ZSB0byB0aHJlZSBkdXBsaWNhdGUgQUNLcyBv
ciBSVE8gZXhwaXJ5IGF0IHN1YmZsb3cgbGV2ZWwpIGFzIHRoZXJlIGlzIG5vIHNlZ21lbnQgbG9z
cyBhdCBzdWJmbG93IGxldmVsIHNlcXVlbmNlIHNwYWNlLiBTbyB0aGVyZSBjb3VsZCBiZSBhIGhp
Z2ggcG9zc2liaWxpdHkgb2YgUlNUIGhhcHBlbmluZyBldmVuIGJlZm9yZSB0aGUgbWFwIGRlbGl2
ZXJ5IHRocm91Z2ggcmV0cmFuc21pc3Npb24uJm5ic3A7PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYg
Y2xhc3M9IiI+V2l0aCByZWdhcmRzLCZuYnNwOzwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNz
PSIiPkFuaWw8L2Rpdj48ZGl2IGNsYXNzPSIiPiZuYnNwOzwvZGl2PjxociBpZD0iZ21haWwtbV84
NzczMzU3NDM5Nzc3MDgxNTkwZ21haWwtbV8yMTgwODY1OTY5NTE3MjQ1MDFnbWFpbC1tXzI5ODIy
NjcwMzM1Nzc5MDI5ODV6d2NociIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YiBjbGFzcz0iIj5G
cm9tOiA8L2I+Illvc2hpZnVtaSBOaXNoaWRhIiAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5zZC5pZXRm
QGdtYWlsLmNvbSIgcmVsPSJub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9s
bG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVm
ZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5l
ciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9IiI+bnNkLmlldGZAZ21haWwuY29t
PC9hPiZndDs8YnIgY2xhc3M9IiI+PGIgY2xhc3M9IiI+VG86IDwvYj4iViBBbmlsIEt1bWFyIiAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxAY3NpcjRwaS5pbiIgcmVsPSJub2ZvbGxvdyUyMG5vb3Bl
bmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9m
b2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9y
ZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayIgY2xh
c3M9IiI+YW5pbEBjc2lyNHBpLmluPC9hPiZndDs8YnIgY2xhc3M9IiI+PGIgY2xhc3M9IiI+Q2M6
IDwvYj4iYWxhbiBmb3JkIiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb20i
IHJlbD0ibm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3Bl
bmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9m
b2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPmFsYW4uZm9yZEBnbWFpbC5jb208L2E+Jmd0Oywg
Im11bHRpcGF0aHRjcCIgJmx0OzxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmci
IHJlbD0ibm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3Bl
bmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9m
b2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT4mZ3Q7
PGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIiPlNlbnQ6IDwvYj5TYXR1cmRheSwgRmVicnVhcnkgMSwg
MjAyMCAzOjM5OjUxIEFNPGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIiPlN1YmplY3Q6IDwvYj5SZTog
W211bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBm
ZWVkYmFjazxiciBjbGFzcz0iIj48L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2
IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iIj48ZGl2IGRpcj0ibHRy
IiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkhpIEFuaWwsPC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYg
Y2xhc3M9IiI+SSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgeW91ciBwcm9wb3NlZCB0ZXh0LjwvZGl2
PjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5JIGFtIGFjdHVhbGx5IHdvbmRlcmluZyBpZiB3
ZSByZWFsbHkgd2FudCB0byB0ZXJtaW5hdGUgY29ubmVjdGlvbiBoZXJlLiZuYnNwOzwvZGl2Pjwv
ZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPlRoZSBwYWNrZXRzIHdpdGhvdXQgcHJvcGVy
IG1hcHBpbmdzIHdpbGwgYmUgdHJlYXRlZCBhcyBpbnZhbGlkIGFuZCB3aWxsIGJlIGRpc2NhcmRl
ZC4mbmJzcDs8L2Rpdj48ZGl2IGNsYXNzPSIiPklmIGFuIGltcGxlbWVudGF0aW9uIGZhaWxlZCB0
byBhdHRhY2ggcHJvcGVyIG1hcHBpbmcgZm9yIHNvbWUgcmVhc29ucyAoZS5nLiBvcHRpb24gc3Bh
Y2UpLCBpdCBtaWdodCBiZSBhYmxlIHRvIGF0dGFjaCB0aGUgcHJvcGVyIG9uZSB3aGVuIGl0IHJl
dHJhbnNtaXRzIHRoZSBwYWNrZXRzLiBUaGlzIGFsc28gbG9va3Mgb2sgdG8gbWUuPC9kaXY+PGJy
IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+SSBkb24ndCBoYXZlIHN0cm9uZyBwcmVmZXJlbmNlIGZv
ciB0aGlzLiBCdXQsIGRvIHdlIGhhdmUgYSByZWFzb24gdG8gdGVybWluYXRlIGNvbm5lY3Rpb24/
PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+VGhhbmtzLDwvZGl2PjxkaXYgY2xhc3M9
IiI+LS08YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5Zb3NoaTwvZGl2PjxiciBjbGFz
cz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSIiPk9uIE1vbiwgSmFuIDEz
LCAyMDIwIGF0IDEwOjI4IEFNIFYgQW5pbCBLdW1hciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxA
Y3NpcjRwaS5pbiIgcmVsPSJub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9s
bG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVm
ZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9v
cGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIgbm9m
b2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiIGNsYXNzPSIiPmFuaWxA
Y3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3RlOjxiciBjbGFzcz0iIj48L2Rpdj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVy
LWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBj
bGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMnB0O2xpbmUtaGVpZ2h0OjEuMyIgY2xhc3M9IiI+SGksPC9z
cGFuPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxkaXYgc3R5bGU9ImZvbnQtZmFt
aWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIiBjbGFzcz0iIj48ZGl2IHN0eWxlPSJmb250
LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiIgY2xhc3M9IiI+PGRpdiBzdHlsZT0i
Zm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiIGNsYXNzPSIiPjxkaXYgc3R5
bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIiBjbGFzcz0iIj48ZGl2
IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiIgY2xhc3M9IiI+
PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiIGNsYXNz
PSIiPjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5JIGhhdmUgc29tZSBwb2ludHMgcmVs
YXRlZCB0byB0aGUgJm5ic3A7bW9kaWZpY2F0aW9ucyAoQ2hhbmdlIDIpIGJlaW5nIHByb3Bvc2Vk
IG9uIGRhdGEgc2VxdWVuY2UgbWFwLiBQbGVhc2Ugc2VlIHRoZW0gaW5saW5lLiZuYnNwOzxzcGFu
IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNpemU6
MTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDo0MDA7bGV0dGVyLXNwYWNpbmc6bm9y
bWFsO3RleHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3doaXRlLXNwYWNlOm5vcm1h
bDt3b3JkLXNwYWNpbmc6MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KTtmbG9h
dDpub25lO2Rpc3BsYXk6aW5saW5lIiBjbGFzcz0iIj5UaG91Z2ggSSBhbSBwdXR0aW5nIGZvcndh
cmQgdGhlIGJlbG93IHBvaW50cywgaWYgdGhlIGNvbnNlbnN1cyBpcyBpbiBmYXZvdXIgb2YgdGhl
IHByb3Bvc2VkIGNoYW5nZSBmb3IgcmVkdWNpbmcgaW1wbGVtZW50YXRpb24gY29tcGxleGl0eSwg
SSBhbSBhbHNvIE9LIHdpdGggdGhhdCBhcyB3ZWxsLiZuYnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+
PC9kaXY+PGJyIGNsYXNzPSIiPjxociBpZD0iZ21haWwtbV84NzczMzU3NDM5Nzc3MDgxNTkwZ21h
aWwtbV8yMTgwODY1OTY5NTE3MjQ1MDFnbWFpbC1tXzI5ODIyNjcwMzM1Nzc5MDI5ODVnbWFpbC1t
Xzc2ODcxODQzODIyOTk1OTY3NzR6d2NociIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YiBjbGFz
cz0iIj5Gcm9tOiA8L2I+ImFsYW4gZm9yZCIgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFuLmZvcmRA
Z21haWwuY29tIiByZWw9Im5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xs
b3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2Zv
bGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9IiI+YWxhbi5m
b3JkQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyIGNsYXNzPSIiPjxiIGNsYXNzPSIiPlRvOiA8L2I+PGEg
aHJlZj0ibWFpbHRvOm11bHRpcGF0aHRjcEBpZXRmLm9yZyIgcmVsPSJub2ZvbGxvdyUyMG5vb3Bl
bmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9m
b2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9y
ZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBu
b29wZW5lciUyMG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0
PSJfYmxhbmsiIGNsYXNzPSIiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT48YnIgY2xhc3M9IiI+
PGIgY2xhc3M9IiI+U2VudDogPC9iPlRodXJzZGF5LCBKYW51YXJ5IDIsIDIwMjAgNDoyMTozMiBB
TTxiciBjbGFzcz0iIj48YiBjbGFzcz0iIj5TdWJqZWN0OiA8L2I+W211bHRpcGF0aHRjcF0gUkZD
NjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBmZWVkYmFjazxiciBjbGFzcz0i
Ij48L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IaSBhbGwsPGJyIGNsYXNzPSIiPjxk
aXYgY2xhc3M9IiI+V2XigJlkIGxvdmUgdG8gZ2V0IHRoaXMgdG8gYSBzdGF0ZSBvZiBjb21wbGV0
aW9uIGFzIHNvb24gYXMgcG9zc2libGUsIGFuZCB0byB0aGlzIGVuZCBJIGFtIHN0YXJ0aW5nIGEg
bmV3IHRocmVhZCBvbiB0aGlzIHRvcGljLiBJbiBkaXNjdXNzaW9uIHdpdGggdGhlIGNoYWlycywg
aXQgPGkgY2xhc3M9IiI+aXMgPC9pPnBvc3NpYmxlIHRvIG1ha2UgdGhlIGRlc2lyZWQgY2hhbmdl
cyBpbiBBVVRINDggYXMgbG9uZyBhcyB0aGVyZSBpcyBXRyBjb25zZW5zdXMuIFRoZSBkaXNjdXNz
aW9uIHNvIGZhciBoYXMgYmVlbiBmYWlybHkgbGltaXRlZCBpbiB0ZXJtcyBvZiBwYXJ0aWNpcGF0
aW9uLjwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkkgd291bGQgYXNrIHRoZSBjaGFp
cnMgcGxlYXNlIGlmIGl0IHdhcyBwb3NzaWJsZSB0byBzcGVjaWZ5IGEgdGltZSBib3VuZCBmb3Ig
dGhpcyBkaXNjdXNzaW9uIGFuZCBhIGRlZmF1bHQgY29uY2x1c2lvbi48L2Rpdj48YnIgY2xhc3M9
IiI+PGRpdiBjbGFzcz0iIj5SZWdhcmRpbmcgdGhlIGNoYW5nZXMsIGluIHN1bW1hcnksIHRoZXJl
IGFyZSB0d28gYXJlYXMgd2hlcmUgY2hhbmdlcyBoYXZlIGJlZW4gcmVxdWVzdGVkIGJ5IHRoZSBp
bXBsZW1lbnRhdGlvbiBjb21tdW5pdHkuIEFzIHdlIGFyZSB0aGUgSUVURiB3ZSBvYnZpb3VzbHkg
aGF2ZSBzdHJvbmcgZm9jdXMgb24g4oCccnVubmluZyBjb2Rl4oCdIGFuZCBzbyBlYXNlIG9mIGlt
cGxlbWVudGluZyBzdGFuZGFyZHMtY29tcGxpYW50IGNvZGUgaXMgc3Ryb25nbHkgZGVzaXJhYmxl
LiBIb3dldmVyLCB3ZSBkbyBub3Qgd2lzaCB0byByZWR1Y2UgZnVuY3Rpb25hbGl0eSBhZ3JlZWQg
YnkgdGhlIElFVEYgY29tbXVuaXR5IGlmIGl0IGlzIGNvbnNpZGVyZWQgYSByZXF1aXJlZCBmZWF0
dXJlIGJ5IHRoZSBjb21tdW5pdHkuPC9kaXY+PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48ZGl2
IGNsYXNzPSIiPjxiIGNsYXNzPSIiPkNoYW5nZSAxPC9iPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGIg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvYj48L2Rpdj48ZGl2IGNsYXNzPSIiPkNoYW5nZSB0aGUg
c2VudGVuY2UgcmVhZGluZzo8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxpIGNsYXNzPSIiPiZu
YnNwOyAmbmJzcDtJZiBCIGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxl
IGRlbGl2ZXJ5IG9mIHRoZSBBQ0sgKyBNUF9DQVBBQkxFIGNhbiBiZSBpbmZlcnJlZCBieSB0aGUg
cmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNlcXVlbmNlIFNpZ25hbCAo
RFNTKSBvcHRpb24gKFNlY3Rpb24gMy4zKS4mbmJzcDs8YnIgY2xhc3M9IiI+PC9pPjxiciBjbGFz
cz0iIj5Ubzo8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxpIGNsYXNzPSIiPiZuYnNwOyAmbmJz
cDtJZiBCIGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5
IG9mIHRoZSBBQ0sgKyBNUF9DQVBBQkxFIGlzIGVuc3VyZWQgYnkgdGhlIHJlY2VpcHQgb2YgdGhp
cyBkYXRhIHdpdGggYW4gTVBUQ1AgRGF0YSBTZXF1ZW5jZSBTaWduYWwgKERTUykgb3B0aW9uIChT
ZWN0aW9uIDMuMykgY29udGFpbmluZyBhIERBVEFfQUNLIGZvciB0aGUgTVBfQ0FQQUJMRSAod2hp
Y2ggaXMgdGhlIGZpcnN0IG9jdGV0IG9mIHRoZSBkYXRhIHNlcXVlbmNlJm5ic3A7c3BhY2UpLjxi
ciBjbGFzcz0iIj48L2k+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+V2hhdCB0aGlz
IG1lYW5zOjwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPlRoZSBjdXJyZW50IHRleHQg
aXMgY29uY2VybmVkIG9ubHkgd2l0aCBlbnN1cmluZyBhIHBhdGggaXMgTVBUQ1AgY2FwYWJsZSwg
YW5kIHNvIG9ubHkgY2FyZXMgdGhhdCBEU1Mgb3B0aW9uIG9jY3VycyBvbiBhIGRhdGEgcGFja2V0
LiBIb3dldmVyLCB0aGUgTVBfQ0FQQUJMRSBvcHRpb24gaXMgZGVmaW5lZCB0byBvY2N1cHkgdGhl
IGZpcnN0IG9jdGV0IG9mIGRhdGEgc2VxdWVuY2Ugc3BhY2UgYW5kIHRodXMsIGlmIGFuYWxvZ291
cyB0byBUQ1AsIG11c3QgYmUgYWNrbm93bGVkZ2VkLiAmZ3Q7RnJvbSBhbiBpbXBsZW1lbnRhdGlv
biBwb2ludCBvZiB2aWV3IGl0IHdvdWxkIG1ha2Ugc2Vuc2Ugbm90IHRvIGhhdmUgdGhpcyBoYW5n
aW5nIGFyb3VuZCBmb3JldmVyIGFuZCBpbnN0ZWFkIGRlZmluZSBpdCBpcyBhY2tub3dsZWRnZWQg
YXQgdGhlIGNvbm5lY3Rpb24gbGV2ZWwgYXMgc29vbiBhcyByZWNlaXZlZC4gVGhpcyBjaGFuZ2Ug
ZW5zdXJlcyB0aGUgZmlyc3QgZGF0YSBwYWNrZXQgYWxzbyBEQVRBX0FDS3MgdGhpcyBNUF9DQVBB
QkxFIG9jdGV0LjwvZGl2PjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48
YiBjbGFzcz0iIj5DaGFuZ2UgMjwvYj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiIGNsYXNzPSIiPjxi
ciBjbGFzcz0iIj48L2I+PC9kaXY+PGRpdiBjbGFzcz0iIj5DaGFuZ2UgdGhlIHNlbnRlbmNlIHJl
YWRpbmc6PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48aSBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7
QSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgZG9lcyBub3QgbmVlZCB0byBiZSBpbmNsdWRlZCBpbiBl
dmVyeSBNUFRDUCBwYWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2Ug
aW4gdGhhdCBwYWNrZXQgaXMgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2Vp
dmVyLjwvaT48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPlRvOjxiciBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+PGkgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO1RoZSBtYXBwaW5nIHByb3ZpZGVkIGJ5IGEg
RGF0YSBTZXF1ZW5jZSBNYXBwaW5nIE1VU1QgYXBwbHkgdG8gc29tZSBvciBhbGwgb2YgdGhlIHN1
YmZsb3cgc2VxdWVuY2Ugc3BhY2UgaW4gdGhlIFRDUCBzZWdtZW50IHdoaWNoIGNhcnJpZXMgdGhl
IG9wdGlvbi4gSXQgZG9lcyBub3QgbmVlZCB0byBiZSBpbmNsdWRlZCBpbiBldmVyeSBNUFRDUCBw
YWNrZXQsIGFzIGxvbmcgYXMgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2UgaW4gdGhhdCBwYWNr
ZXQgaXMgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2VpdmVyLjxiciBjbGFz
cz0iIj48L2k+PGJyIGNsYXNzPSIiPldoYXQgdGhpcyBtZWFuczo8L2Rpdj48YnIgY2xhc3M9IiI+
PGRpdiBjbGFzcz0iIj5UaGUgY3VycmVudCB0ZXh0IGRvZXMgbm90IHBsYWNlIGFueSByZXN0cmlj
dGlvbnMgb24gd2hlcmUgYSBtYXBwaW5nIGNvdWxkIGFwcGVhci4gSW4gdGhlb3J5IGEgc2VuZGVy
IGNvdWxkIGRlZmluZSBhIHRob3VzYW5kIGRpZmZlcmVudCBtYXBwaW5ncyB1cCBmcm9udCwgc2Vu
ZCB0aGVtIGFsbCwgYW5kIGV4cGVjdCBhIHJlY2VpdmVyIHRvIHN0b3JlIHRoaXMgYW5kIHJlYXNz
ZW1ibGUgZGF0YSBhY2NvcmRpbmcgdG8gdGhlc2UgbWFwcGluZ3MgYXMgaXQgYXJyaXZlcy4gSW5k
ZWVkLCB0aGlzIHdhcyBuZXZlciBleHBsaWNpdGx5IGRpc2FsbG93ZWQgc2luY2UgaXQg4oCcbWln
aHQgaGF2ZSBiZWVuIHVzZWZ1bOKAnS4gVGhlIGltcGxlbWVudGF0aW9uIGNvbW11bml0eSwgaG93
ZXZlciwgaGFzIGV4cHJlc3NlZCBjb25jZXJucyBvdmVyIHRoZSBkaWZmaWN1bHR5IG9mIGltcGxl
bWVudGluZyB0aGlzIG9wZW4tZW5kZWRseS4gSG93IG1hbnkgbWFwcGluZ3MgaXMgaXQgcmVhc29u
YWJsZSB0byBzdG9yZT8gSXMgdGhlcmUgYSBEb1MgcmlzayBoZXJlPyBJbnN0ZWFkLCBpdCBoYXMg
YmVlbiByZXF1ZXN0ZWQgdGhhdCB0aGVlIHNwZWNpZmljYXRpb24gcmVzdHJpY3RzIHRoZSBwbGFj
ZW1lbnQgb2YgdGhlIERTUyBvcHRpb24gdG8gYmVpbmcgd2l0aGluIHRoZSBzdWJmbG93IHNlcXVl
bmNlIHNwYWNlIHRvIHdoaWNoIGl0IGFwcGxpZXMuPC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xh
c3M9IiI+QmVsb3cgYXJlIG15IGNvbW1lbnRzIG9uIHRoaXMuIEkgaGFkIHNoYXJlZCBzb21lIG9m
IHRoZXNlIHBvaW50cyBpbiBhIHByZXZpb3VzIHRocmVhZCB0aGF0IHlvdSBoYWQgaW5pdGlhdGVk
IGluIHRoZSBzYW1lIGNvbnRleHQuJm5ic3A7PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9
IiI+VHJhbnNtaXR0aW5nIGxhcmdlIG51bWJlciBvZiBub24tY29udGlndW91cyBkYXRhIHNlcXVl
bmNlIG1hcHMgY291bGQgYmUgYSBtaXNiZWhhdmlvdXIgKG1hcC1mbG9vZGluZyksIHRob3VnaCBp
dCBpcyBub3QgY2xlYXIgd2hldGhlciB0aGlzIGNhbiBnbyB0byB0aGUgZXh0ZW50IG9mIGNhdXNp
bmcgYSBwb3RlbnRpYWwgRG9TIHRvIHRoZSBkYXRhIHJlY2VpdmVyLiBTbyBzb21lIHNvcnQgb2Yg
cmVzdHJpY3Rpb24gb24gdGhpcyBjb3VsZCBiZSB1c2VmdWwuJm5ic3A7IE9uZSBhcHByb2FjaCBj
b3VsZCBiZSB0byBpbnNpc3QgdGhhdCB0aGUgZGF0YSBzZW5kZXIgc2hvdWxkIGVuc3VyZSB0aGF0
IHRoZSBtYXAgYmVpbmcgdHJhbnNtaXR0ZWQgaXMgZm9yIGluLXdpbmRvdyBkYXRhLCBhcyBwZXIg
dGhlIHJlY2VpdmVyIGFkdmVydGlzZWQgd2luZG93LiBBIHJlY2VpdmVyIHNob3VsZCBhbnlob3cg
YmUgd2lsbGluZyB0byBzdG9yZSB0aGUgbWFwcyBmb3IgaW4td2luZG93IGRhdGEgdG8gZGVhbCB3
aXRoIHBhY2tldCBsb3NzLiBGb3IgZXhhbXBsZSwgd2hlbiBhIHdpbmRvdyBvZiBkYXRhIHNlZ21l
bnRzIChzYXkgMSB0byA2NCkgaXMgdHJhbnNtaXR0ZWQsIGVhY2ggY2FycnlpbmcgaXRzIGNvcnJl
c3BvbmRpbmcgbWFwLCBhbmQgc2VnbWVudC0xIGlzIGxvc3QsIHRoZSBtYXBzIGZvciB0aGUgcmVt
YWluaW5nIDYzIG5lZWQgdG8gYmUgc3RvcmVkIHRpbGwgdGhlIGxvc3Qgc2VnbWVudCBpcyByZXRy
YW5zbWl0dGVkLiBPZiBjb3Vyc2UsIGluIHRoaXMgY2FzZSB0aGUgbWFwcyB3aWxsIGJlIHN0b3Jl
ZCBhdCB0aGUgcmVjZWl2ZXIgc2lkZSBhbG9uZyB3aXRoIHRoZWlyIGNvcnJlc3BvbmRpbmcgZGF0
YS4gQnV0IHRoZSBuZWVkIHRvIHN0b3JlIG11bHRpcGxlIG1hcHMgZm9yIGluLXdpbmRvdyBkYXRh
IHdvdWxkIHN0aWxsIGJlIHRoZXJlLjwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxz
cGFuIHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNp
emU6MTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNp
bmc6bm9ybWFsO2xpbmUtaGVpZ2h0OjIwLjhweDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zv
cm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDtmbG9hdDpub25lO2Jh
Y2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KTtkaXNwbGF5OmlubGluZSIgY2xhc3M9IiI+
VGhlIHByb2JsZW0gd2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlIChyZXN0cmljdGlvbikgaXMgdGhh
dCBhIGRhdGEgc2VuZGVyIG1heSBmaW5kIGl0IGRpZmZpY3VsdCwgaW4gY2FzZSBhIG5lZWQgYXJp
c2UgdG8gc2xpZ2h0bHkgZGVsYXkgdGhlIG1hcCBkZWxpdmVyeSBieSBmZXcgc2VnbWVudHMsIGku
ZS4sIHNlbmRpbmcgc29tZSBkYXRhIGZpcnN0IHdpdGhvdXQgbWFwLCBhbmQgdGhlbiBzZW5kIHRo
ZSBjb3JyZXNwb25kaW5nIG1hcCBpbiBhIGxhdGVyIHNlZ21lbnQsIGFzIHNob3duIGJlbG93Ojwv
c3Bhbj48YnIgY2xhc3M9IiI+PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBz
dHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMm
cXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250
LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0
ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29y
ZC1zcGFjaW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1
KSIgY2xhc3M9IiI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCIgY2xh
c3M9IiI+c3ViZmxvdy0xOiZuYnNwOyAmbmJzcDsgJm5ic3A7IHNlZ21lbnQtMSZuYnNwOyZuYnNw
OyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc2VnbWVudC0zJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
IHNlZ21lbnQtNCAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNlZ21lbnQtNzwvc3Bhbj48L2Rpdj48ZGl2
IHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtzZWdvZSB1aSZxdW90OywmcXVvdDtsdWNpZGEgc2Fu
cyZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxNC4xNnB4O2ZvbnQtc3R5bGU6bm9ybWFsO2Zv
bnQtd2VpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzpub3JtYWw7bGluZS1oZWlnaHQ6bm9ybWFs
O3RleHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3doaXRlLXNwYWNlOm5vcm1hbDt3
b3JkLXNwYWNpbmc6MHB4O21hcmdpbjowcHg7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwy
NTUpIiBjbGFzcz0iIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZToxMHB0IiBj
bGFzcz0iIj4mbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgJm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Ynl0ZXM6MS0xMDAgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBieXRlczoyMDEtMzAwICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO2J5dGVzOjMwMS00MDAgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBieXRlczo2
MDEtNzAwPC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O3NlZ29lIHVp
JnF1b3Q7LCZxdW90O2x1Y2lkYSBzYW5zJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjE0LjE2
cHg7Zm9udC1zdHlsZTpub3JtYWw7Zm9udC13ZWlnaHQ6bm9ybWFsO2xldHRlci1zcGFjaW5nOm5v
cm1hbDtsaW5lLWhlaWdodDpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3JtOm5v
bmU7d2hpdGUtc3BhY2U6bm9ybWFsO3dvcmQtc3BhY2luZzowcHg7bWFyZ2luOjBweDtiYWNrZ3Jv
dW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiIGNsYXNzPSIiPjxzcGFuIGxhbmc9IkVOLVVTIiBz
dHlsZT0iZm9udC1zaXplOjEwcHQiIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsmbmJzcDtu
byBtYXAgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDttYXAgZm9yIDEtMTAwICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO21hcCBmb3IgMjAxLTQwMCAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBtYXAgZm9yIDYwMS03MDA8L3Nw
YW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1
b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtmb250LXN0
eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUt
aGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1z
cGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6
cmdiKDI1NSwyNTUsMjU1KSIgY2xhc3M9IiI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250
LXNpemU6MTBwdCIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxl
PSJmb250LWZhbWlseTomcXVvdDtzZWdvZSB1aSZxdW90OywmcXVvdDtsdWNpZGEgc2FucyZxdW90
OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxNC4xNnB4O2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtd2Vp
Z2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzpub3JtYWw7bGluZS1oZWlnaHQ6bm9ybWFsO3RleHQt
aW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3doaXRlLXNwYWNlOm5vcm1hbDt3b3JkLXNw
YWNpbmc6MHB4O21hcmdpbjowcHg7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIiBj
bGFzcz0iIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZToxMHB0IiBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90
O3NlZ29lIHVpJnF1b3Q7LCZxdW90O2x1Y2lkYSBzYW5zJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1z
aXplOjE0LjE2cHg7Zm9udC1zdHlsZTpub3JtYWw7Zm9udC13ZWlnaHQ6bm9ybWFsO2xldHRlci1z
cGFjaW5nOm5vcm1hbDtsaW5lLWhlaWdodDpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJh
bnNmb3JtOm5vbmU7d2hpdGUtc3BhY2U6bm9ybWFsO3dvcmQtc3BhY2luZzowcHg7bWFyZ2luOjBw
eDtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiIGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtzZWdvZSB1aSZxdW90OywmcXVv
dDtsdWNpZGEgc2FucyZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxNC4xNnB4O2ZvbnQtc3R5
bGU6bm9ybWFsO2ZvbnQtd2VpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzpub3JtYWw7bGluZS1o
ZWlnaHQ6bm9ybWFsO3RleHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3doaXRlLXNw
YWNlOm5vcm1hbDt3b3JkLXNwYWNpbmc6MHB4O21hcmdpbjowcHg7YmFja2dyb3VuZC1jb2xvcjpy
Z2IoMjU1LDI1NSwyNTUpIiBjbGFzcz0iIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQt
c2l6ZToxMHB0IiBjbGFzcz0iIj5zdWJmbG93LTI6Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
c2VnbWVudC0yJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgc2VnbWVudC01ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyBzZWdtZW50LTYgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyBzZWdtZW50LTg8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6
JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJpZjtm
b250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7bGV0
dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4
dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDttYXJn
aW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSIgY2xhc3M9IiI+PHNwYW4g
bGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCIgY2xhc3M9IiI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwO2J5dGVzOiAxMDEtMjAwICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsg
Ynl0ZXM6NDAxLTUwMCZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgYnl0ZXM6IDUwMS02MDAgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO2J5dGVzOjcw
MS04MDAmbmJzcDsmbmJzcDsmbmJzcDs8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJp
Zjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7
bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7
dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDtt
YXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSIgY2xhc3M9IiI+PHNw
YW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCIgY2xhc3M9IiI+Jm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDttYXAgZm9yIDEwMS0yMDAgJm5ic3A7ICZuYnNwOyAmbmJzcDsgbWFw
IGZvciA0MDEtNjAwICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7bm8g
bWFwICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDttYXAgZm9yIDcwMS04
MDA8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVv
dDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtm
b250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFs
O2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3
aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQt
Y29sb3I6cmdiKDI1NSwyNTUsMjU1KSIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYg
c3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O3NlZ29lIHVpJnF1b3Q7LCZxdW90O2x1Y2lkYSBzYW5z
JnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjE0LjE2cHg7Zm9udC1zdHlsZTpub3JtYWw7Zm9u
dC13ZWlnaHQ6bm9ybWFsO2xldHRlci1zcGFjaW5nOm5vcm1hbDtsaW5lLWhlaWdodDpub3JtYWw7
dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3JtOm5vbmU7d2hpdGUtc3BhY2U6bm9ybWFsO3dv
cmQtc3BhY2luZzowcHg7bWFyZ2luOjBweDtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1
NSkiIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj5JbiB0aGUgYWJvdmUgY2FzZSwgc2VnbWVu
dC0xIGdvZXMgd2l0aG91dCBtYXAgYW5kIGl0cyBtYXAgaXMgaW5jbHVkZWQgbGF0ZXIgaW4gc2Vn
bWVudC0zLCB0aGUgbmV4dCBkYXRhIHNlZ21lbnQgaW4gdGhlIHNhbWUgc3ViZmxvdy4gRnVydGhl
ciwgJm5ic3A7aW4gdGhlIGFib3ZlIHNjaGVkdWxpbmcgcGF0dGVybiwgdGhlIG1hcCBpbiBzZWdt
ZW50LTMgY2Fubm90IGNvdmVyIHRoZSAmbmJzcDtkYXRhIGluIHNlZ21lbnQtMSBhbmQgc2VnbWVu
dC0zLCBhcyBzb21lICZuYnNwO2RhdGEgaW4gYmV0d2VlbiAoc2VnbWVudC0yKSBpcyB0cmFuc21p
dHRlZCB0aHJvdWdoIGFub3RoZXIgc3ViZmxvdy4mbmJzcDsgV2l0aCB0aGUgcHJvcG9zZWQgY2hh
bmdlLCB0aGUgbWFwIGluIHNlZ21lbnQtMyB3aWxsIGJlY29tZSBpbnZhbGlkIGFuZCB0aGlzIHdp
bGwgZXZlbnR1YWxseSBicmVhayBzdWJmbG93LTEsIHRob3VnaCB0aGlzIGNvdWxkIGJlIGEgY29y
bmVyIGNhc2UuLjwvZGl2PjxiciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPlRoZSBxdWVzdGlvbiBh
dCB0aGlzIHN0YWdlIGlzIHdoeSB3b3VsZCBzZWdtZW50LTEgYmUgdHJhbnNtaXR0ZWQgd2l0aG91
dCBpdHMgbWFwLiBJbiB0aGUgY2FzZSBvZiBiaWRpcmVjdGlvbmFsIGRhdGEgdHJhbnNmZXIsIHRo
ZXJlIGNvdWxkIGJlIGEgbmVlZCB0byBwYWNrIGJvdGggdGltZXN0YW1wIGFuZCBTQUNLICZuYnNw
O29wdGlvbnMgaW4gYSBkYXRhIHNlZ21lbnQsIGkuZS4sIHBpZ2d5YmFja2luZyBvZiAmbmJzcDtT
QUNLIHdpdGggZGF0YS4gSWYgd2UgY29uc2lkZXIgdGhhdCB0aW1lc3RhbXAgdGFrZXMgMTIgYnl0
ZXMgYW5kIFNBQ0ssIGV2ZW4gd2l0aCBzaW5nbGUgYmxvY2ssICZuYnNwO3Rha2VzIGFub3RoZXIg
MTAgYnl0ZXMsIHRoZSByZW1haW5pbmcgMTggYnl0ZXMgb3B0aW9uIHNwYWNlIGlzIG5vdCBhZGVx
dWF0ZSB0byBjYXJyeSBkYXRhIHNlcXVlbmNlIHNpZ25hbCB3aXRoIG1hcCwgZXNwZWNpYWxseSB3
aGVuIERTTiBpcyA2NCBiaXQgbG9uZy4gU28gdGhlIGRlbGl2ZXJ5IG9mIGVpdGhlciBvZiB0aGUg
dHdvIChTQUNLIG9yIG1hcCkgd291bGQgYmUgZGVsYXllZC48L2Rpdj48YnIgY2xhc3M9IiI+PGRp
diBjbGFzcz0iIj5BcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCBSRkMgMjAxOCAoVENQIFNlbGVjdGl2
ZSBBY2tub3dsZWRnZW1lbnQgT3B0aW9ucykgaW1wbGllcyB0aGF0IFNBQ0sgc2hvdWxkIG5vdCBi
ZSBkZWxheWVkLiBJdCBzdGF0ZXMgIklmIHNlbnQgYXQgYWxsLCBTQUNLIG9wdGlvbnMgU0hPVUxE
IGJlIGluY2x1ZGVkIGluIGFsbCBBQ0tzIHdoaWNoIGRvIG5vdCBBQ0sgdGhlIGhpZ2hlc3Qgc2Vx
dWVuY2UgbnVtYmVyIGluIHRoZSBkYXRhIHJlY2VpdmVyJ3MgcXVldWUiLiBJdCBhbHNvIHNheXMg
IklmIGRhdGEgcmVjZWl2ZXIgZ2VuZXJhdGVzIFNBQ0sgb3B0aW9ucyB1bmRlciBhbnkgY2lyY3Vt
c3RhbmNlLCBpdCBTSE9VTEQgZ2VuZXJhdGUgdGhlbSB1bmRlciBhbGwgcGVybWl0dGVkIGNpcmN1
bXN0YW5jZXMiLiAmbmJzcDsgU28sIGFzIHBhcnQgb2YgbWVldGluZyB0aGUgUkZDIDIwMTggcmVx
dWlyZW1lbnRzLCBpZiB0aGUgY29tYmluYXRpb24gb2YgU0FDSyBhbmQgdGltZXN0YW1wIGlzIGdp
dmVuIHByZWZlcmVuY2Ugb3ZlciBEU1MsIGRhdGEgc2VnbWVudHMgY291bGQgYmUgdHJhbnNtaXR0
ZWQgd2l0aG91dCB0aGVpciBtYXAuJm5ic3A7PC9kaXY+PGJyIGNsYXNzPSIiPjxkaXYgY2xhc3M9
IiI+QW5vdGhlciBjYXNlIG9mIGRlbGF5aW5nIG1hcCBjb3VsZCBhcmlzZSBpZiB0aGUgZGF0YSBz
ZW5kZXIgcHJlZmVycyB0byBzZW5kIEFERF9BRERSIG9wdGlvbiwgaW5zdGVhZCBvZiBtYXAsIGlu
IGEgZGF0YSBzZWdtZW50LiBJdCBpcyBuaWNlIHRoYXQgQUREX0FERFIgb3B0aW9uIGNhbiBiZSBk
ZWxpdmVyZWQgcmVsaWFibHkgaW4gYSBwdXJlIEFDSywgYnV0IEkgdGhpbmsgdGhpcyBpcyBub3Qg
dGhlIGNhc2Ugd2l0aCBEU1MgYXQgcHJlc2VudC48L2Rpdj48YnIgY2xhc3M9IiI+PGRpdiBjbGFz
cz0iIj5JZiB3ZSBhZG9wdCB0aGUgcHJvcG9zZWQgY2hhbmdlLCBJIHRoaW5rIGl0IG1pZ2h0IGFs
c28gYmUgaGVscGZ1bCB0byBzcGVsbCBvdXQgaG93IHRoZSByZWNlaXZlciBpcyBzdXBwb3NlZCB0
byBiZWhhdmUsIGlmIGl0IGdldHMgbWFwcyBub3QgbWVldGluZyB0aGUgTVVTVCBjb25kaXRpb24g
aW4gdGhlIHByb3Bvc2VkIGNoYW5nZS4mbmJzcDsgRm9yIGV4YW1wbGUgdGVybWluYXRpb24gb2Yg
dGhlIHN1YmZsb3cgd2l0aCBNUF9UQ1BSU1Qgb3B0aW9uIChzZWN0aW9uIDMuNiBpbiBSRkMgNjgy
NC1iaXMpIHdpdGggYXBwcm9wcmlhdGUgcmVhc29uIGNvZGUgYW5kIFQgZmxhZyB2YWx1ZSB0byBp
bnRpbWF0ZSB0aGUgZGF0YSBzZW5kZXIgdGhlIGNhdXNlIGZvciBzdWJmbG93IHRlcm1pbmF0aW9u
LiZuYnNwOyZuYnNwOzwvZGl2PjxkaXYgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOzwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9IiI+V2l0aCByZWdhcmRzLDwvZGl2Pjxi
ciBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkFuaWw8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxk
aXYgY2xhc3M9IiI+UGxlYXNlIGNhbiBtZW1iZXJzIG9mIHRoZSBXRyBleHByZXNzIHdoZXRoZXIg
dGhleSBhcmUgaGFwcHkgd2l0aCB0aGVzZSBjaGFuZ2VzLCBvciBjb25jZXJuZWQuPC9kaXY+PGJy
IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9IiI+
QWxhbjwvZGl2PjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+X19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188YnIgY2xhc3M9IiI+bXVsdGlwYXRodGNwIG1haWxp
bmcgbGlzdDxiciBjbGFzcz0iIj48YSBocmVmPSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3Jn
IiByZWw9Im5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5v
Zm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5v
cmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2ZvbGxvdyBub29w
ZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9IiI+bXVsdGlwYXRodGNwQGll
dGYub3JnPC9hPjxiciBjbGFzcz0iIj48YSBocmVmPSJodHRwczovL3d3dy5pZXRmLm9yZy9tYWls
bWFuL2xpc3RpbmZvL211bHRpcGF0aHRjcCIgcmVsPSJub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9y
ZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBu
b29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUy
MG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUy
MG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
IGNsYXNzPSIiPmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vbXVsdGlwYXRo
dGNwPC9hPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48L2Rpdj48L2Rpdj48YnIgY2xhc3M9IiI+PGJy
IGNsYXNzPSIiPl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
PGJyIGNsYXNzPSIiPm11bHRpcGF0aHRjcCBtYWlsaW5nIGxpc3Q8YnIgY2xhc3M9IiI+PGEgaHJl
Zj0ibWFpbHRvOm11bHRpcGF0aHRjcEBpZXRmLm9yZyIgcmVsPSJub2ZvbGxvdyUyMG5vb3BlbmVy
JTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xs
b3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiIGNsYXNzPSIiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT48YnIgY2xhc3M9IiI+PGEg
aHJlZj0iaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3Ai
IHJlbD0ibm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9m
b2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9y
ZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBu
b29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBu
b2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayIgY2xhc3M9IiI+aHR0
cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3A8L2E+PGJyIGNs
YXNzPSIiPjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48
YnIgY2xhc3M9IiI+PC9kaXY+PC9kaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjwvYmxvY2txdW90ZT48
L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Rp
dj48YnIgY2xhc3M9IiI+PC9kaXY+PC9kaXY+PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2PjxiciBj
bGFzcz0iIj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+CjxiciBjbGFzcz0iIj4KPGJyIGNsYXNz
PSIiPjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX188YnIgY2xhc3M9IiI+bXVsdGlwYXRodGNwIG1haWxp
bmcgbGlzdDxiciBjbGFzcz0iIj48YSBocmVmPSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3Jn
IiBjbGFzcz0iIj5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+PGJyIGNsYXNzPSIiPmh0dHBzOi8v
d3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vbXVsdGlwYXRodGNwPGJyIGNsYXNzPSIiPjwv
ZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnIgY2xhc3M9IiI+PC9ib2R5PjwvaHRtbD4=
--===============6554279041218902276==--
