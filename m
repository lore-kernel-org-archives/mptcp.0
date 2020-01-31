Content-Type: multipart/mixed; boundary="===============0507873482202954772=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: Re: [multipathtcp] RFC6824bis edits based on
 implementation feedback
Date: Fri, 31 Jan 2020 14:50:50 -0800
Message-ID: <20200131225050.GC6008@MacBook-Pro-64.local>
X-Status: 
X-Keywords:                  
X-UID: 3570

--===============0507873482202954772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

the IETF working-group is still arguing whether or not to allow early/late
DSS-mappings.

If you feel strongly about it, feel free to express your support on the IETF
mailing-list (thanks to Paolo for already doing so).


Cheers,
Christoph


----- Forwarded message from philip.eardley(a)bt.com -----

From: philip.eardley(a)bt.com
To: anil(a)csir4pi.in, alan.ford(a)gmail.com
Cc: multipathtcp(a)ietf.org
Date: Thu, 23 Jan 2020 10:51:11 +0000
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck

I haven=E2=80=99t seen any responses about this. Please follow-up if you ca=
re about the issue.

Alan =E2=80=93 please consider Change 1 as agreed.


From: multipathtcp <multipathtcp-bounces(a)ietf.org> On Behalf Of V Anil Ku=
mar
Sent: 13 January 2020 18:25
To: alan ford <alan.ford(a)gmail.com>
Cc: multipathtcp(a)ietf.org
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck

Hi,

I have some points related to the  modifications (Change 2) being proposed =
on data sequence map. Please see them inline. Though I am putting forward t=
he below points, if the consensus is in favour of the proposed change for r=
educing implementation complexity, I am also OK with that as well.

________________________________
From: "alan ford" <alan.ford(a)gmail.com<mailto:alan.ford(a)gmail.com>>
To: multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>
Sent: Thursday, January 2, 2020 4:21:32 AM
Subject: [multipathtcp] RFC6824bis edits based on implementation feedback

Hi all,

We=E2=80=99d love to get this to a state of completion as soon as possible,=
 and to this end I am starting a new thread on this topic. In discussion wi=
th the chairs, it is possible to make the desired changes in AUTH48 as long=
 as there is WG consensus. The discussion so far has been fairly limited in=
 terms of participation.

I would ask the chairs please if it was possible to specify a time bound fo=
r this discussion and a default conclusion.

Regarding the changes, in summary, there are two areas where changes have b=
een requested by the implementation community. As we are the IETF we obviou=
sly have strong focus on =E2=80=9Crunning code=E2=80=9D and so ease of impl=
ementing standards-compliant code is strongly desirable. However, we do not=
 wish to reduce functionality agreed by the IETF community if it is conside=
red a required feature by the community.


Change 1

Change the sentence reading:

   If B has data to send first, then the reliable delivery of the ACK + MP_=
CAPABLE can be inferred by the receipt of this data with an MPTCP Data Sequ=
ence Signal (DSS) option (Section 3.3).

To:

   If B has data to send first, then the reliable delivery of the ACK + MP_=
CAPABLE is ensured by the receipt of this data with an MPTCP Data Sequence =
Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPABLE =
(which is the first octet of the data sequence space).
What this means:

The current text is concerned only with ensuring a path is MPTCP capable, a=
nd so only cares that DSS option occurs on a data packet. However, the MP_C=
APABLE option is defined to occupy the first octet of data sequence space a=
nd thus, if analogous to TCP, must be acknowledged. >From an implementation=
 point of view it would make sense not to have this hanging around forever =
and instead define it is acknowledged at the connection level as soon as re=
ceived. This change ensures the first data packet also DATA_ACKs this MP_CA=
PABLE octet.


Change 2

Change the sentence reading:

   A Data Sequence Mapping does not need to be included in every MPTCP pack=
et, as long as the subflow sequence space in that packet is covered by a ma=
pping known at the receiver.

To:

   The mapping provided by a Data Sequence Mapping MUST apply to some or al=
l of the subflow sequence space in the TCP segment which carries the option=
. It does not need to be included in every MPTCP packet, as long as the sub=
flow sequence space in that packet is covered by a mapping known at the rec=
eiver.

What this means:

The current text does not place any restrictions on where a mapping could a=
ppear. In theory a sender could define a thousand different mappings up fro=
nt, send them all, and expect a receiver to store this and reassemble data =
according to these mappings as it arrives. Indeed, this was never explicitl=
y disallowed since it =E2=80=9Cmight have been useful=E2=80=9D. The impleme=
ntation community, however, has expressed concerns over the difficulty of i=
mplementing this open-endedly. How many mappings is it reasonable to store?=
 Is there a DoS risk here? Instead, it has been requested that thee specifi=
cation restricts the placement of the DSS option to being within the subflo=
w sequence space to which it applies.

Below are my comments on this. I had shared some of these points in a previ=
ous thread that you had initiated in the same context.

Transmitting large number of non-contiguous data sequence maps could be a m=
isbehaviour (map-flooding), though it is not clear whether this can go to t=
he extent of causing a potential DoS to the data receiver. So some sort of =
restriction on this could be useful.  One approach could be to insist that =
the data sender should ensure that the map being transmitted is for in-wind=
ow data, as per the receiver advertised window. A receiver should anyhow be=
 willing to store the maps for in-window data to deal with packet loss. For=
 example, when a window of data segments (say 1 to 64) is transmitted, each=
 carrying its corresponding map, and segment-1 is lost, the maps for the re=
maining 63 need to be stored till the lost segment is retransmitted. Of cou=
rse, in this case the maps will be stored at the receiver side along with t=
heir corresponding data. But the need to store multiple maps for in-window =
data would still be there.

The problem with the proposed change (restriction) is that a data sender ma=
y find it difficult, in case a need arise to slightly delay the map deliver=
y by few segments, i.e., sending some data first without map, and then send=
 the corresponding map in a later segment, as shown below:


subflow-1:      segment-1                   segment-3                    se=
gment-4                       segment-7
                      bytes:1-100                 bytes:201-300            =
  bytes:301-400                 bytes:601-700
                      no map                        map for 1-100          =
    map for 201-400             map for 601-700





subflow-2:       segment-2                  segment-5                     s=
egment-6                       segment-8
                       bytes: 101-200           bytes:401-500              =
 bytes: 501-600                bytes:701-800
                       map for 101-200       map for 401-600            no =
map                            map for 701-800


In the above case, segment-1 goes without map and its map is included later=
 in segment-3, the next data segment in the same subflow. Further,  in the =
above scheduling pattern, the map in segment-3 cannot cover the  data in se=
gment-1 and segment-3, as some  data in between (segment-2) is transmitted =
through another subflow.  With the proposed change, the map in segment-3 wi=
ll become invalid and this will eventually break subflow-1, though this cou=
ld be a corner case.

The question at this stage is why would segment-1 be transmitted without it=
s map. In the case of bidirectional data transfer, there could be a need to=
 pack both timestamp and SACK  options in a data segment, i.e., piggybackin=
g of  SACK with data. If we consider that timestamp takes 12 bytes and SACK=
, even with single block,  takes another 10 bytes, the remaining 18 bytes o=
ption space is not adequate to carry data sequence signal with map, especia=
lly when DSN is 64 bit long. So the delivery of either of the two (SACK or =
map) would be delayed.

As far as I understand, RFC 2018 (TCP Selective Acknowledgement Options) im=
plies that SACK should not be delayed. It states "If sent at all, SACK opti=
ons SHOULD be included in all ACKs which do not ACK the highest sequence nu=
mber in the data receiver's queue". It also says "If data receiver generate=
s SACK options under any circumstance, it SHOULD generate them under all pe=
rmitted circumstances".   So, as part of meeting the RFC 2018 requirements,=
 if the combination of SACK and timestamp is given preference over DSS, dat=
a segments could be transmitted without their map.

Another case of delaying map could arise if the data sender prefers to send=
 ADD_ADDR option, instead of map, in a data segment. It is nice that ADD_AD=
DR option can be delivered reliably in a pure ACK, but I think this is not =
the case with DSS at present.

If we adopt the proposed change, I think it might also be helpful to spell =
out how the receiver is supposed to behave, if it gets maps not meeting the=
 MUST condition in the proposed change.  For example termination of the sub=
flow with MP_TCPRST option (section 3.6 in RFC 6824-bis) with appropriate r=
eason code and T flag value to intimate the data sender the cause for subfl=
ow termination.

With regards,

Anil
Please can members of the WG express whether they are happy with these chan=
ges, or concerned.

Best regards,
Alan


_______________________________________________
multipathtcp mailing list
multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>
https://www.ietf.org/mailman/listinfo/multipathtcp



_______________________________________________
multipathtcp mailing list
multipathtcp(a)ietf.org
https://www.ietf.org/mailman/listinfo/multipathtcp


----- End forwarded message -----
--===============0507873482202954772==--
