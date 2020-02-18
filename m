Content-Type: multipart/mixed; boundary="===============0920719264677003087=="
MIME-Version: 1.0
From: philip.eardley at bt.com
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] RFC6824bis edits based on implementation
 feedback
Date: Tue, 18 Feb 2020 10:34:45 +0000
Message-ID: <LNXP123MB258793AE47D970277BAF3688EB110@LNXP123MB2587.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: CAAK044SQb0utvjZToU=+OCg0hB-KX6vs1bFZGsJ=tJ5WvfETog@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 3691

--===============0920719264677003087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Alan, please go ahead and make Change 2 to the document (as well as Change =
1). Please could you &/or Christoph add a small note based on the discussio=
n we=E2=80=99ve had, as it=E2=80=99s drawn out a couple of useful clarifica=
tions.

Thanks to everyone for the discussion,
Best wishes,
Phil & Yoshi.

From: multipathtcp <multipathtcp-bounces(a)ietf.org> On Behalf Of Yoshifumi=
 Nishida
Sent: 13 February 2020 09:34
To: Christoph Paasch <cpaasch(a)apple.com>
Cc: MultiPath TCP - IETF WG <multipathtcp(a)ietf.org>; mptcp Upstreaming <m=
ptcp(a)lists.01.org>
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck

Hi Christoph,

Thanks for the clarification. It seems that there are several ways to deal =
with this situation.
I think these are not ideal, but at the same time, it won't be fatal. I thi=
nk more thorough solutions can be discussed in future versions.
Given that there're several ways to address it, I guess the draft doesn't h=
ave to specify the behavior for this.
--
Yoshi

On Tue, Feb 11, 2020 at 2:30 PM Christoph Paasch <cpaasch(a)apple.com<mailt=
o:cpaasch(a)apple.com>> wrote:
+MPTCP-upstreaming


On Feb 11, 2020, at 1:05 AM, Yoshifumi Nishida <nsd.ietf(a)gmail.com<mailto=
:nsd.ietf(a)gmail.com>> wrote:

Hi folks,
I guess we might want to know the behavior of existing implementations such=
 as linux.
When an mptcp stack tries to send a data packet and find that there's no en=
ough option space for data mapping, what it will do?

iOS, multipath-tcp.org<http://multipath-tcp.org> and Linux 5.6 implementati=
on all favor the DSS-option over any other option (except TCP Timestamps). =
And TCP Timestamps and DSS comfortably fit in the TCP option-space.

If SACK-blocks should be added, we only add SACK-blocks up to the remaining=
 space. SACK is anyways opportunistic as once there are more than 3 blocks =
they don't fit either.


Christoph


Split the packet to create more option space?
--
Yoshi

On Thu, Feb 6, 2020 at 10:10 AM V Anil Kumar <anil(a)csir4pi.in<mailto:anil=
(a)csir4pi.in>> wrote:
Hi Alan,

Thank you for your reply. I have two points to clarify. Please see them in =
line.

________________________________
From: "Alan Ford" <alan.ford(a)gmail.com<mailto:alan.ford(a)gmail.com>>
To: "V Anil Kumar" <anil(a)csir4pi.in<mailto:anil(a)csir4pi.in>>jk
Cc: "Yoshifumi Nishida" <nsd.ietf(a)gmail.com<mailto:nsd.ietf(a)gmail.com>>=
, "multipathtcp" <multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>>
Sent: Thursday, February 6, 2020 2:49:29 AM
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck
Hi Anil,

This would not be forbidden if the mapping was carried on a pure ACK with n=
o data.
As far as I understand, delivery of DSM through pure ACK is not in the scop=
e of the current draft. If we intend to do this, we may need an approach si=
milar to the one proposed for delivery of ADD_ADDR option in pure ACK with =
reliability feature.  So, packing DSM on pure ACK does not seem to be an op=
tion at this stage.

I do see the point here: if a packet of 1000 bytes contains 500 bytes of on=
e mapping and 500 bytes of another mapping, then only one DSM would appear =
on one packet, leaving the mapping for the second 500 bytes to be carried s=
omewhere else - the only option being a pure ACK. But this kind of scenario=
 would be extremely rare
Yes, I do agree that the scenario you mentioned above would be extremely ra=
re. In fact, I wonder whether such a situation (i.e., need to cover the byt=
es in a single packet with two different maps) would ever arise. Probably t=
here might be some corner cases, which I don't get it rightly now.

More importantly, the scenario that Yoshi and me are referring to is totall=
y different: the one I had given as part of my comments in response to the =
proposed change 2. In this scenario, which you could see in the trailing ma=
il, data segment-1 is transmitted without including its map, something whic=
h is permitted in the  mptcp framework (6824 bis). I make this inference fr=
om the below text in 6824 bis:

"...even if a mapping does not exist from the subflow space to the data- le=
vel space, the data SHOULD still be ACKed at the subflow (if it is in-windo=
w). This data cannot, however, be acknowledged at the data level (Section 3=
.3.2) because its data sequence numbers are unknown. Implementations MAY ho=
ld onto such unmapped data for a short while in the expectation that a mapp=
ing will arrive shortly."

One option the data sender has at this stage is to include the map for data=
 in segment-1, in segment-3 (please see the two-subflow example I gave in r=
esponse to the change 2 you had proposed). But the proposed change does not=
 permit this. What would happen to  subflow-1 in this case ?

With regards,

Anil
and I would imagine any implementation would just split into two 500 byte s=
egments each with the PSH flag set. I don=E2=80=99t think we need to spell =
this out in the spec however.

Regards,
Alan

On 5 Feb 2020, at 15:09, V Anil Kumar <anil(a)csir4pi.in<mailto:anil(a)csir=
4pi.in>> wrote:
Hi Yoshi,

Please see in line.

________________________________
From: "Yoshifumi Nishida" <nsd.ietf(a)gmail.com<mailto:nsd.ietf(a)gmail.com=
>>
To: "V Anil Kumar" <anil(a)csir4pi.in<mailto:anil(a)csir4pi.in>>
Cc: "alan ford" <alan.ford(a)gmail.com<mailto:alan.ford(a)gmail.com>>, "mul=
tipathtcp" <multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>>
Sent: Tuesday, February 4, 2020 1:08:45 PM
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck

Hi Anil,

Thanks for pointing it out. I overlooked this one.
This looks an interesting point.

It seems to me that whether RST is happen or not depends on the size of rec=
eive window according to the text.
If the receive window size is big enough to accommodate segment 1 and segme=
nt 3, the text "Implementations MAY hold onto such unmapped data for a shor=
t while in the expectation that a mapping will arrive shortly.. " can be ap=
plied to the segment 1. As a result, the segment 1 won't be discarded.

Yes.  So, segment 1 may be kept in the data receiver's buffer in expectatio=
n that its mapping will arrive shortly. And in the example that we are refe=
rring to, the data sender will not be able to include the map for the data =
in segment 1 in segment 3 or any higher segment.

Regards,

Anil

However, this might be contradict with the new texts Alan proposed? Or, am =
I missing something?

Thanks,
--
Yoshi


On Sun, Feb 2, 2020 at 8:42 AM V Anil Kumar <anil(a)csir4pi.in<mailto:anil(=
a)csir4pi.in>> wrote:
Hi Yoshi,

Thanks for this point. In fact, I had initially not thought of a scenario, =
where the map is being delivered through a retransmitted data packet while =
its first transmission did not include the map. Now I am just seeing the do=
cument (RFC 6824-bis) in this context.

My understanding is that in scenarios like what I described in my previous =
mail, RST is likely to happen whether we explicitly state so or not. Please=
 see the paragraph containing the below text in RFC 6824-bis.

"If a mapping for that subflow-level sequence space does not arrive within =
a receive window of data, that subflow SHOULD be treated as broken, closed =
with a RST, and any unmapped data silently discarded."

if we assume that the map is included while retransmitting the data (even t=
hough the first transmission did not contain the map for some reasons),  we=
 could argue that RST could be avoided provided that the retransmission is =
triggered within a receive window of data. But the question here would be h=
ow and when will the retransmission take place. In this case, the subflow m=
ay not initiate the retransmission of data by its own (i..e., no retransmis=
sion due to three duplicate ACKs or RTO expiry at subflow level) as there i=
s no segment loss at subflow level sequence space. So there could be a high=
 possibility of RST happening even before the map delivery through retransm=
ission.

With regards,

Anil

________________________________
From: "Yoshifumi Nishida" <nsd.ietf(a)gmail.com<mailto:nsd.ietf(a)gmail.com=
>>
To: "V Anil Kumar" <anil(a)csir4pi.in<mailto:anil(a)csir4pi.in>>
Cc: "alan ford" <alan.ford(a)gmail.com<mailto:alan.ford(a)gmail.com>>, "mul=
tipathtcp" <multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>>
Sent: Saturday, February 1, 2020 3:39:51 AM
Subject: Re: [multipathtcp] RFC6824bis edits based on implementation feedba=
ck

Hi Anil,

I have a question about your proposed text.
I am actually wondering if we really want to terminate connection here.

The packets without proper mappings will be treated as invalid and will be =
discarded.
If an implementation failed to attach proper mapping for some reasons (e.g.=
 option space), it might be able to attach the proper one when it retransmi=
ts the packets. This also looks ok to me.

I don't have strong preference for this. But, do we have a reason to termin=
ate connection?

Thanks,
--
Yoshi

On Mon, Jan 13, 2020 at 10:28 AM V Anil Kumar <anil(a)csir4pi.in<mailto:ani=
l(a)csir4pi.in>> wrote:
Hi,

I have some points related to the  modifications (Change 2) being proposed =
on data sequence map. Please see them inline. Though I am putting forward t=
he below points, if the consensus is in favour of the proposed change for r=
educing implementation complexity, I am also OK with that as well.

________________________________
From: "alan ford" <alan.ford(a)gmail.com<mailto:alan.ford(a)gmail.com>>
To: multipathtcp(a)ietf..org<mailto:multipathtcp(a)ietf.org>
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
ld be a corner case..

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
multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>
https://www.ietf.org/mailman/listinfo/multipathtcp







_______________________________________________
multipathtcp mailing list
multipathtcp(a)ietf.org<mailto:multipathtcp(a)ietf.org>
https://www.ietf.org/mailman/listinfo/multipathtcp


--===============0920719264677003087==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPCEtLVtp
ZiAhbXNvXT48c3R5bGU+dlw6KiB7YmVoYXZpb3I6dXJsKCNkZWZhdWx0I1ZNTCk7fQ0Kb1w6KiB7
YmVoYXZpb3I6dXJsKCNkZWZhdWx0I1ZNTCk7fQ0Kd1w6KiB7YmVoYXZpb3I6dXJsKCNkZWZhdWx0
I1ZNTCk7fQ0KLnNoYXBlIHtiZWhhdmlvcjp1cmwoI2RlZmF1bHQjVk1MKTt9DQo8L3N0eWxlPjwh
W2VuZGlmXS0tPjxzdHlsZT48IS0tDQovKiBGb250IERlZmluaXRpb25zICovDQpAZm9udC1mYWNl
DQoJe2ZvbnQtZmFtaWx5OkhlbHZldGljYTsNCglwYW5vc2UtMToyIDExIDYgNCAyIDIgMiAyIDIg
NDt9DQpAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OiJDYW1icmlhIE1hdGgiOw0KCXBhbm9zZS0x
OjIgNCA1IDMgNSA0IDYgMyAyIDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZhbWlseTpDYWxpYnJp
Ow0KCXBhbm9zZS0xOjIgMTUgNSAyIDIgMiA0IDMgMiA0O30NCkBmb250LWZhY2UNCgl7Zm9udC1m
YW1pbHk6IlNlZ29lIFVJIjsNCglwYW5vc2UtMToyIDExIDUgMiA0IDIgNCAyIDIgMzt9DQovKiBT
dHlsZSBEZWZpbml0aW9ucyAqLw0KcC5Nc29Ob3JtYWwsIGxpLk1zb05vcm1hbCwgZGl2Lk1zb05v
cm1hbA0KCXttYXJnaW46MGNtOw0KCW1hcmdpbi1ib3R0b206LjAwMDFwdDsNCglmb250LXNpemU6
MTEuMHB0Ow0KCWZvbnQtZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmO30NCmE6bGluaywgc3Bh
bi5Nc29IeXBlcmxpbmsNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOmJsdWU7DQoJ
dGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9DQphOnZpc2l0ZWQsIHNwYW4uTXNvSHlwZXJsaW5r
Rm9sbG93ZWQNCgl7bXNvLXN0eWxlLXByaW9yaXR5Ojk5Ow0KCWNvbG9yOnB1cnBsZTsNCgl0ZXh0
LWRlY29yYXRpb246dW5kZXJsaW5lO30NCnAubXNvbm9ybWFsMCwgbGkubXNvbm9ybWFsMCwgZGl2
Lm1zb25vcm1hbDANCgl7bXNvLXN0eWxlLW5hbWU6bXNvbm9ybWFsOw0KCW1zby1tYXJnaW4tdG9w
LWFsdDphdXRvOw0KCW1hcmdpbi1yaWdodDowY207DQoJbXNvLW1hcmdpbi1ib3R0b20tYWx0OmF1
dG87DQoJbWFyZ2luLWxlZnQ6MGNtOw0KCWZvbnQtc2l6ZToxMS4wcHQ7DQoJZm9udC1mYW1pbHk6
IkNhbGlicmkiLHNhbnMtc2VyaWY7fQ0Kc3Bhbi5FbWFpbFN0eWxlMTkNCgl7bXNvLXN0eWxlLXR5
cGU6cGVyc29uYWwtcmVwbHk7DQoJZm9udC1mYW1pbHk6IkFyaWFsIixzYW5zLXNlcmlmOw0KCWNv
bG9yOndpbmRvd3RleHQ7fQ0KLk1zb0NocERlZmF1bHQNCgl7bXNvLXN0eWxlLXR5cGU6ZXhwb3J0
LW9ubHk7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMtc2VyaWY7DQoJbXNvLWZhcmVhc3Qt
bGFuZ3VhZ2U6RU4tVVM7fQ0KQHBhZ2UgV29yZFNlY3Rpb24xDQoJe3NpemU6NjEyLjBwdCA3OTIu
MHB0Ow0KCW1hcmdpbjo3Mi4wcHQgNzIuMHB0IDcyLjBwdCA3Mi4wcHQ7fQ0KZGl2LldvcmRTZWN0
aW9uMQ0KCXtwYWdlOldvcmRTZWN0aW9uMTt9DQotLT48L3N0eWxlPjwhLS1baWYgZ3RlIG1zbyA5
XT48eG1sPg0KPG86c2hhcGVkZWZhdWx0cyB2OmV4dD0iZWRpdCIgc3BpZG1heD0iMTAyNiIgLz4N
CjwveG1sPjwhW2VuZGlmXS0tPjwhLS1baWYgZ3RlIG1zbyA5XT48eG1sPg0KPG86c2hhcGVsYXlv
dXQgdjpleHQ9ImVkaXQiPg0KPG86aWRtYXAgdjpleHQ9ImVkaXQiIGRhdGE9IjEiIC8+DQo8L286
c2hhcGVsYXlvdXQ+PC94bWw+PCFbZW5kaWZdLS0+DQo8L2hlYWQ+DQo8Ym9keSBsYW5nPSJFTi1H
QiIgbGluaz0iYmx1ZSIgdmxpbms9InB1cnBsZSI+DQo8ZGl2IGNsYXNzPSJXb3JkU2VjdGlvbjEi
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LHNhbnMtc2VyaWY7bXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPkFsYW4sIHBs
ZWFzZSBnbyBhaGVhZCBhbmQgbWFrZSBDaGFuZ2UgMiB0byB0aGUgZG9jdW1lbnQgKGFzIHdlbGwg
YXMgQ2hhbmdlIDEpLiBQbGVhc2UgY291bGQgeW91ICZhbXA7L29yIENocmlzdG9waCBhZGQgYSBz
bWFsbCBub3RlIGJhc2VkIG9uIHRoZSBkaXNjdXNzaW9uIHdl4oCZdmUgaGFkLCBhcw0KIGl04oCZ
cyBkcmF3biBvdXQgYSBjb3VwbGUgb2YgdXNlZnVsIGNsYXJpZmljYXRpb25zLjxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmO21zby1mYXJlYXN0LWxhbmd1YWdlOkVOLVVT
Ij48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZjttc28tZmFy
ZWFzdC1sYW5ndWFnZTpFTi1VUyI+VGhhbmtzIHRvIGV2ZXJ5b25lIGZvciB0aGUgZGlzY3Vzc2lv
biw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iZm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZjttc28tZmFyZWFzdC1s
YW5ndWFnZTpFTi1VUyI+QmVzdCB3aXNoZXMsPG86cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7
LHNhbnMtc2VyaWY7bXNvLWZhcmVhc3QtbGFuZ3VhZ2U6RU4tVVMiPlBoaWwgJmFtcDsgWW9zaGku
PG86cD48L286cD48L3NwYW4+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9
ImZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWY7bXNvLWZhcmVhc3QtbGFu
Z3VhZ2U6RU4tVVMiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxiPjxzcGFuIGxhbmc9IkVOLVVTIj5Gcm9tOjwvc3Bhbj48L2I+PHNwYW4gbGFuZz0i
RU4tVVMiPiBtdWx0aXBhdGh0Y3AgJmx0O211bHRpcGF0aHRjcC1ib3VuY2VzQGlldGYub3JnJmd0
Ow0KPGI+T24gQmVoYWxmIE9mIDwvYj5Zb3NoaWZ1bWkgTmlzaGlkYTxicj4NCjxiPlNlbnQ6PC9i
PiAxMyBGZWJydWFyeSAyMDIwIDA5OjM0PGJyPg0KPGI+VG86PC9iPiBDaHJpc3RvcGggUGFhc2No
ICZsdDtjcGFhc2NoQGFwcGxlLmNvbSZndDs8YnI+DQo8Yj5DYzo8L2I+IE11bHRpUGF0aCBUQ1Ag
LSBJRVRGIFdHICZsdDttdWx0aXBhdGh0Y3BAaWV0Zi5vcmcmZ3Q7OyBtcHRjcCBVcHN0cmVhbWlu
ZyAmbHQ7bXB0Y3BAbGlzdHMuMDEub3JnJmd0Ozxicj4NCjxiPlN1YmplY3Q6PC9iPiBSZTogW211
bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBmZWVk
YmFjazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5i
c3A7PC9vOnA+PC9wPg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IaSBDaHJp
c3RvcGgsPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPlRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uIEl0IHNlZW1zIHRoYXQgdGhlcmUgYXJl
IHNldmVyYWwgd2F5cyB0byBkZWFsIHdpdGggdGhpcyBzaXR1YXRpb24uJm5ic3A7PG86cD48L286
cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5JIHRoaW5rIHRoZXNl
IGFyZSBub3QgaWRlYWwsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lLCBpdCB3b24ndCBiZSBmYXRhbC4g
SSB0aGluayBtb3JlIHRob3JvdWdoIHNvbHV0aW9ucyBjYW4gYmUgZGlzY3Vzc2VkIGluIGZ1dHVy
ZSB2ZXJzaW9ucy4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPkdpdmVuIHRoYXQgdGhlcmUncmUgc2V2ZXJhbCB3YXlzIHRvIGFkZHJlc3Mg
aXQsIEkgZ3Vlc3MgdGhlIGRyYWZ0IGRvZXNuJ3QgaGF2ZSB0byBzcGVjaWZ5IHRoZSBiZWhhdmlv
ciBmb3IgdGhpcy4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPi0tPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5Zb3NoaTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+T24gVHVlLCBGZWIgMTEsIDIwMjAgYXQgMjozMCBQTSBDaHJpc3RvcGggUGFhc2NoICZs
dDs8YSBocmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBsZS5jb20iPmNwYWFzY2hAYXBwbGUuY29tPC9h
PiZndDsgd3JvdGU6PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJi
b3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCAjQ0NDQ0NDIDEuMHB0O3BhZGRpbmc6MGNtIDBj
bSAwY20gNi4wcHQ7bWFyZ2luLWxlZnQ6NC44cHQ7bWFyZ2luLXJpZ2h0OjBjbSI+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+JiM0MztNUFRDUC11cHN0cmVhbWluZzxvOnA+PC9vOnA+PC9w
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxicj4NCjxicj4NCjxvOnA+PC9vOnA+PC9w
Pg0KPGJsb2NrcXVvdGUgc3R5bGU9Im1hcmdpbi10b3A6NS4wcHQ7bWFyZ2luLWJvdHRvbTo1LjBw
dCI+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T24gRmViIDExLCAyMDIwLCBhdCAxOjA1
IEFNLCBZb3NoaWZ1bWkgTmlzaGlkYSAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5zZC5pZXRmQGdtYWls
LmNvbSIgdGFyZ2V0PSJfYmxhbmsiPm5zZC5pZXRmQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxv
OnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwv
bzpwPjwvcD4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhpIGZv
bGtzLDxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
SSBndWVzcyB3ZSBtaWdodCB3YW50IHRvIGtub3cgdGhlIGJlaGF2aW9yIG9mIGV4aXN0aW5nIGlt
cGxlbWVudGF0aW9ucyBzdWNoIGFzIGxpbnV4LjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8L2Rp
dj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPGJsb2NrcXVvdGUgc3R5bGU9Im1hcmdpbi10b3A6
NS4wcHQ7bWFyZ2luLWJvdHRvbTo1LjBwdCI+DQo8ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj5XaGVuIGFuIG1wdGNwIHN0YWNrIHRyaWVzIHRvIHNlbmQgYSBkYXRhIHBh
Y2tldCBhbmQgZmluZCB0aGF0IHRoZXJlJ3Mgbm8gZW5vdWdoIG9wdGlvbiBzcGFjZSBmb3IgZGF0
YSBtYXBwaW5nLCB3aGF0IGl0IHdpbGwgZG8/PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjwvZGl2
Pg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86
cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5p
T1MsIDxhIGhyZWY9Imh0dHA6Ly9tdWx0aXBhdGgtdGNwLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPm11
bHRpcGF0aC10Y3Aub3JnPC9hPiZuYnNwO2FuZCBMaW51eCA1LjYgaW1wbGVtZW50YXRpb24gYWxs
IGZhdm9yIHRoZSBEU1Mtb3B0aW9uIG92ZXIgYW55IG90aGVyIG9wdGlvbiAoZXhjZXB0IFRDUCBU
aW1lc3RhbXBzKS4gQW5kIFRDUCBUaW1lc3RhbXBzIGFuZCBEU1MgY29tZm9ydGFibHkgZml0IGlu
IHRoZSBUQ1Agb3B0aW9uLXNwYWNlLjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj5JZiBTQUNLLWJsb2NrcyBzaG91bGQgYmUgYWRkZWQsIHdlIG9u
bHkgYWRkIFNBQ0stYmxvY2tzIHVwIHRvIHRoZSByZW1haW5pbmcgc3BhY2UuIFNBQ0sgaXMgYW55
d2F5cyBvcHBvcnR1bmlzdGljIGFzIG9uY2UgdGhlcmUgYXJlIG1vcmUgdGhhbiAzIGJsb2NrcyB0
aGV5IGRvbid0IGZpdCBlaXRoZXIuPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+Q2hyaXN0b3BoPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxicj4NCjxicj4NCjxvOnA+PC9vOnA+PC9wPg0KPGJsb2NrcXVv
dGUgc3R5bGU9Im1hcmdpbi10b3A6NS4wcHQ7bWFyZ2luLWJvdHRvbTo1LjBwdCI+DQo8ZGl2Pg0K
PGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5TcGxpdCB0aGUgcGFja2V0IHRvIGNy
ZWF0ZSBtb3JlIG9wdGlvbiBzcGFjZT88bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPi0tPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5Zb3NoaTxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+T24gVGh1LCBGZWIgNiwgMjAyMCBhdCAxMDoxMCBBTSBWIEFuaWwgS3VtYXIg
Jmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iIHRhcmdldD0iX2JsYW5rIj5hbmls
QGNzaXI0cGkuaW48L2E+Jmd0OyB3cm90ZTo8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGJsb2Nr
cXVvdGUgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlkICNDQ0NDQ0MgMS4wcHQ7
cGFkZGluZzowY20gMGNtIDBjbSA2LjBwdDttYXJnaW4tbGVmdDo0LjhwdDttYXJnaW4tcmlnaHQ6
MGNtIj4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkhpIEFsYW4s
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpw
PiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlRo
YW5rIHlvdSBmb3IgeW91ciByZXBseS4gSSBoYXZlIHR3byBwb2ludHMgdG8gY2xhcmlmeS4gUGxl
YXNlIHNlZSB0aGVtIGluIGxpbmUuPG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdiBjbGFz
cz0iTXNvTm9ybWFsIiBhbGlnbj0iY2VudGVyIiBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXIiPg0K
PGhyIHNpemU9IjIiIHdpZHRoPSIxMDAlIiBhbGlnbj0iY2VudGVyIiBpZD0iZ21haWwtbV8tNTQw
NjU0MzU1NjczNzcyMjAxZ21haWwtbV84NzczMzU3NDM5Nzc3MDgxNTkwendjaHIiPg0KPC9kaXY+
DQo8ZGl2Pg0KPGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlk
ICMxMDEwRkYgMS41cHQ7cGFkZGluZzowY20gMGNtIDBjbSA0LjBwdDttYXJnaW4tbGVmdDozLjc1
cHQ7bWFyZ2luLXRvcDo1LjBwdDttYXJnaW4tYm90dG9tOjUuMHB0Ij4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90
O0hlbHZldGljYSZxdW90OyxzYW5zLXNlcmlmIj5Gcm9tOg0KPC9zcGFuPjwvYj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtIZWx2ZXRpY2EmcXVvdDssc2Fu
cy1zZXJpZiI+JnF1b3Q7QWxhbiBGb3JkJnF1b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5m
b3JkQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmFsYW4uZm9yZEBnbWFpbC5jb208L2E+Jmd0
Ozxicj4NCjxiPlRvOiA8L2I+JnF1b3Q7ViBBbmlsIEt1bWFyJnF1b3Q7ICZsdDs8YSBocmVmPSJt
YWlsdG86YW5pbEBjc2lyNHBpLmluIiB0YXJnZXQ9Il9ibGFuayI+YW5pbEBjc2lyNHBpLmluPC9h
PiZndDtqayZuYnNwOzxicj4NCjxiPkNjOiA8L2I+JnF1b3Q7WW9zaGlmdW1pIE5pc2hpZGEmcXVv
dDsgJmx0OzxhIGhyZWY9Im1haWx0bzpuc2QuaWV0ZkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5r
Ij5uc2QuaWV0ZkBnbWFpbC5jb208L2E+Jmd0OywgJnF1b3Q7bXVsdGlwYXRodGNwJnF1b3Q7ICZs
dDs8YSBocmVmPSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3JnIiB0YXJnZXQ9Il9ibGFuayI+
bXVsdGlwYXRodGNwQGlldGYub3JnPC9hPiZndDs8YnI+DQo8Yj5TZW50OiA8L2I+VGh1cnNkYXks
IEZlYnJ1YXJ5IDYsIDIwMjAgMjo0OToyOSBBTTxicj4NCjxiPlN1YmplY3Q6IDwvYj5SZTogW211
bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBmZWVk
YmFjazxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPGRpdj4N
CjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXI6bm9uZTtib3JkZXItbGVmdDpzb2xpZCAjMTAxMEZG
IDEuNXB0O3BhZGRpbmc6MGNtIDBjbSAwY20gNC4wcHQ7bWFyZ2luLWxlZnQ6My43NXB0O21hcmdp
bi10b3A6NS4wcHQ7bWFyZ2luLWJvdHRvbTo1LjBwdCI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtIZWx2ZXRpY2Em
cXVvdDssc2Fucy1zZXJpZiI+SGkgQW5pbCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7SGVsdmV0aWNhJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+
PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0hlbHZldGljYSZxdW90Oyxz
YW5zLXNlcmlmIj5UaGlzIHdvdWxkIG5vdCBiZSBmb3JiaWRkZW4gaWYgdGhlIG1hcHBpbmcgd2Fz
IGNhcnJpZWQgb24gYSBwdXJlIEFDSyB3aXRoIG5vIGRhdGEuPG86cD48L286cD48L3NwYW4+PC9w
Pg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QXMg
ZmFyIGFzIEkgdW5kZXJzdGFuZCwgZGVsaXZlcnkgb2YgRFNNIHRocm91Z2ggcHVyZSBBQ0sgaXMg
bm90IGluIHRoZSBzY29wZSBvZiB0aGUgY3VycmVudCBkcmFmdC4gSWYgd2UgaW50ZW5kIHRvIGRv
IHRoaXMsIHdlIG1heSBuZWVkIGFuIGFwcHJvYWNoIHNpbWlsYXIgdG8gdGhlIG9uZSBwcm9wb3Nl
ZCBmb3IgZGVsaXZlcnkgb2YgQUREX0FERFIgb3B0aW9uIGluIHB1cmUgQUNLIHdpdGggcmVsaWFi
aWxpdHkNCiBmZWF0dXJlLiZuYnNwOyBTbywgcGFja2luZyBEU00gb24gcHVyZSBBQ0sgZG9lcyBu
b3Qgc2VlbSB0byBiZSBhbiBvcHRpb24gYXQgdGhpcyBzdGFnZS48bzpwPjwvbzpwPjwvcD4NCjwv
ZGl2Pg0KPGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlcjpub25lO2JvcmRlci1sZWZ0OnNvbGlkICMx
MDEwRkYgMS41cHQ7cGFkZGluZzowY20gMGNtIDBjbSA0LjBwdDttYXJnaW4tbGVmdDozLjc1cHQ7
bWFyZ2luLXRvcDo1LjBwdDttYXJnaW4tYm90dG9tOjUuMHB0Ij4NCjxkaXY+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVv
dDtIZWx2ZXRpY2EmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7SGVsdmV0aWNhJnF1b3Q7LHNhbnMtc2VyaWYi
PkkgZG8gc2VlIHRoZSBwb2ludCBoZXJlOiBpZiBhIHBhY2tldCBvZiAxMDAwIGJ5dGVzIGNvbnRh
aW5zIDUwMCBieXRlcyBvZiBvbmUgbWFwcGluZyBhbmQgNTAwIGJ5dGVzIG9mIGFub3RoZXIgbWFw
cGluZywgdGhlbiBvbmx5IG9uZSBEU00gd291bGQgYXBwZWFyIG9uIG9uZSBwYWNrZXQsIGxlYXZp
bmcNCiB0aGUgbWFwcGluZyBmb3IgdGhlIHNlY29uZCA1MDAgYnl0ZXMgdG8gYmUgY2FycmllZCBz
b21ld2hlcmUgZWxzZSAtIHRoZSBvbmx5IG9wdGlvbiBiZWluZyBhIHB1cmUgQUNLLiBCdXQgdGhp
cyBraW5kIG9mIHNjZW5hcmlvIHdvdWxkIGJlIGV4dHJlbWVseSByYXJlPG86cD48L286cD48L3Nw
YW4+PC9wPg0KPC9kaXY+DQo8L2Jsb2NrcXVvdGU+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+WWVzLCBJIGRvIGFncmVlIHRoYXQgdGhlIHNjZW5hcmlvIHlvdSBtZW50aW9uZWQgYWJvdmUg
d291bGQgYmUgZXh0cmVtZWx5IHJhcmUuIEluIGZhY3QsIEkgd29uZGVyIHdoZXRoZXIgc3VjaCBh
IHNpdHVhdGlvbiAoaS5lLiwgbmVlZCB0byBjb3ZlciB0aGUgYnl0ZXMgaW4gYSBzaW5nbGUgcGFj
a2V0IHdpdGggdHdvIGRpZmZlcmVudCBtYXBzKSB3b3VsZCBldmVyIGFyaXNlLiBQcm9iYWJseSB0
aGVyZSBtaWdodA0KIGJlIHNvbWUgY29ybmVyIGNhc2VzLCB3aGljaCBJIGRvbid0IGdldCBpdCBy
aWdodGx5IG5vdy4mbmJzcDs8bzpwPjwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+TW9yZSBpbXBvcnRhbnRseSwgdGhlIHNjZW5hcmlvIHRoYXQgWW9zaGkg
YW5kIG1lIGFyZSByZWZlcnJpbmcgdG8gaXMgdG90YWxseSBkaWZmZXJlbnQ6IHRoZSBvbmUgSSBo
YWQgZ2l2ZW4gYXMgcGFydCBvZiBteSBjb21tZW50cyBpbiByZXNwb25zZSB0byB0aGUgcHJvcG9z
ZWQgY2hhbmdlIDIuIEluIHRoaXMgc2NlbmFyaW8sIHdoaWNoIHlvdSBjb3VsZCBzZWUgaW4gdGhl
IHRyYWlsaW5nIG1haWwsIGRhdGEgc2VnbWVudC0xDQogaXMgdHJhbnNtaXR0ZWQgd2l0aG91dCBp
bmNsdWRpbmcgaXRzIG1hcCwgc29tZXRoaW5nIHdoaWNoIGlzIHBlcm1pdHRlZCBpbiB0aGUgJm5i
c3A7bXB0Y3AgZnJhbWV3b3JrICg2ODI0IGJpcykuIEkgbWFrZSB0aGlzIGluZmVyZW5jZSBmcm9t
IHRoZSBiZWxvdyB0ZXh0IGluIDY4MjQgYmlzOjxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj4mcXVvdDsuLi5ldmVuIGlmIGEgbWFwcGluZyBkb2Vz
IG5vdCBleGlzdCBmcm9tIHRoZSBzdWJmbG93IHNwYWNlIHRvIHRoZSBkYXRhLSBsZXZlbCBzcGFj
ZSwgdGhlIGRhdGEgU0hPVUxEIHN0aWxsIGJlIEFDS2VkIGF0IHRoZSBzdWJmbG93IChpZiBpdCBp
cyBpbi13aW5kb3cpLiBUaGlzIGRhdGEgY2Fubm90LCBob3dldmVyLCBiZSBhY2tub3dsZWRnZWQg
YXQgdGhlIGRhdGEgbGV2ZWwgKFNlY3Rpb24gMy4zLjIpIGJlY2F1c2UNCiBpdHMgZGF0YSBzZXF1
ZW5jZSBudW1iZXJzIGFyZSB1bmtub3duLiBJbXBsZW1lbnRhdGlvbnMgTUFZIGhvbGQgb250byBz
dWNoIHVubWFwcGVkIGRhdGEgZm9yIGEgc2hvcnQgd2hpbGUgaW4gdGhlIGV4cGVjdGF0aW9uIHRo
YXQgYSBtYXBwaW5nIHdpbGwgYXJyaXZlIHNob3J0bHkuJnF1b3Q7DQo8bzpwPjwvbzpwPjwvcD4N
CjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9w
Pg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+T25lIG9wdGlvbiB0aGUgZGF0
YSBzZW5kZXIgaGFzIGF0IHRoaXMgc3RhZ2UgaXMgdG8gaW5jbHVkZSB0aGUgbWFwIGZvciBkYXRh
IGluIHNlZ21lbnQtMSwgaW4gc2VnbWVudC0zIChwbGVhc2Ugc2VlIHRoZSB0d28tc3ViZmxvdyBl
eGFtcGxlIEkgZ2F2ZSBpbiByZXNwb25zZSB0byB0aGUgY2hhbmdlIDIgeW91IGhhZCBwcm9wb3Nl
ZCkuIEJ1dCB0aGUgcHJvcG9zZWQgY2hhbmdlIGRvZXMgbm90IHBlcm1pdCB0aGlzLg0KIFdoYXQg
d291bGQgaGFwcGVuIHRvICZuYnNwO3N1YmZsb3ctMSBpbiB0aGlzIGNhc2UgPzxvOnA+PC9vOnA+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286
cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5XaXRoIHJlZ2FyZHMs
PG86cD48L286cD48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpw
PiZuYnNwOzwvbzpwPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPkFu
aWwgJm5ic3A7ICZuYnNwOzxvOnA+PC9vOnA+PC9wPg0KPC9kaXY+DQo8YmxvY2txdW90ZSBzdHls
ZT0iYm9yZGVyOm5vbmU7Ym9yZGVyLWxlZnQ6c29saWQgIzEwMTBGRiAxLjVwdDtwYWRkaW5nOjBj
bSAwY20gMGNtIDQuMHB0O21hcmdpbi1sZWZ0OjMuNzVwdDttYXJnaW4tdG9wOjUuMHB0O21hcmdp
bi1ib3R0b206NS4wcHQiPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0hlbHZldGljYSZxdW90OyxzYW5z
LXNlcmlmIj5hbmQgSSB3b3VsZCBpbWFnaW5lIGFueSBpbXBsZW1lbnRhdGlvbiB3b3VsZCBqdXN0
IHNwbGl0IGludG8gdHdvIDUwMCBieXRlIHNlZ21lbnRzIGVhY2ggd2l0aCB0aGUgUFNIIGZsYWcg
c2V0LiBJIGRvbuKAmXQgdGhpbmsgd2UgbmVlZCB0byBzcGVsbCB0aGlzIG91dCBpbiB0aGUgc3Bl
YyBob3dldmVyLjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZx
dW90O0hlbHZldGljYSZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtIZWx2ZXRpY2EmcXVvdDssc2Fucy1zZXJp
ZiI+UmVnYXJkcyw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTom
cXVvdDtIZWx2ZXRpY2EmcXVvdDssc2Fucy1zZXJpZiI+QWxhbjxvOnA+PC9vOnA+PC9zcGFuPjwv
cD4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7SGVsdmV0aWNhJnF1b3Q7LHNhbnMtc2VyaWYi
PjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxibG9ja3F1b3RlIHN0eWxlPSJtYXJnaW4t
dG9wOjUuMHB0O21hcmdpbi1ib3R0b206NS4wcHQiPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3Jt
YWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0hlbHZl
dGljYSZxdW90OyxzYW5zLXNlcmlmIj5PbiA1IEZlYiAyMDIwLCBhdCAxNTowOSwgViBBbmlsIEt1
bWFyICZsdDs8YSBocmVmPSJtYWlsdG86YW5pbEBjc2lyNHBpLmluIiB0YXJnZXQ9Il9ibGFuayI+
YW5pbEBjc2lyNHBpLmluPC9hPiZndDsgd3JvdGU6PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9k
aXY+DQo8ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPGRp
dj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQt
c2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+SGkg
WW9zaGksPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZx
dW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1p
bHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+UGxlYXNlIHNlZSBpbiBsaW5lLjxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1z
ZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRpdiBjbGFzcz0iTXNvTm9ybWFs
IiBhbGlnbj0iY2VudGVyIiBzdHlsZT0idGV4dC1hbGlnbjpjZW50ZXIiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYi
Pg0KPGhyIHNpemU9IjIiIHdpZHRoPSIxMDAlIiBhbGlnbj0iY2VudGVyIiBpZD0iZ21haWwtbV8t
NTQwNjU0MzU1NjczNzcyMjAxZ21haWwtbV84NzczMzU3NDM5Nzc3MDgxNTkwendjaHIiPg0KPC9z
cGFuPjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYi
PkZyb206DQo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFt
aWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPiZxdW90O1lvc2hpZnVtaSBOaXNoaWRh
JnF1b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86bnNkLmlldGZAZ21haWwuY29tIiB0YXJnZXQ9Il9i
bGFuayI+bnNkLmlldGZAZ21haWwuY29tPC9hPiZndDs8YnI+DQo8Yj5UbzogPC9iPiZxdW90O1Yg
QW5pbCBLdW1hciZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxAY3NpcjRwaS5pbiIgdGFy
Z2V0PSJfYmxhbmsiPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7PGJyPg0KPGI+Q2M6IDwvYj4mcXVv
dDthbGFuIGZvcmQmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFuLmZvcmRAZ21haWwuY29t
IiB0YXJnZXQ9Il9ibGFuayI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7LCAmcXVvdDttdWx0
aXBhdGh0Y3AmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmci
IHRhcmdldD0iX2JsYW5rIj5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+Jmd0Ozxicj4NCjxiPlNl
bnQ6IDwvYj5UdWVzZGF5LCBGZWJydWFyeSA0LCAyMDIwIDE6MDg6NDUgUE08YnI+DQo8Yj5TdWJq
ZWN0OiA8L2I+UmU6IFttdWx0aXBhdGh0Y3BdIFJGQzY4MjRiaXMgZWRpdHMgYmFzZWQgb24gaW1w
bGVtZW50YXRpb24gZmVlZGJhY2s8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwv
cD4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwm
cXVvdDssc2Fucy1zZXJpZiI+SGkgQW5pbCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQt
ZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9z
cGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5UaGFu
a3MgZm9yIHBvaW50aW5nIGl0IG91dC4gSSBvdmVybG9va2VkIHRoaXMgb25lLjxvOnA+PC9vOnA+
PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMt
c2VyaWYiPlRoaXMgbG9va3MgYW4gaW50ZXJlc3RpbmcgcG9pbnQuPG86cD48L286cD48L3NwYW4+
PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZu
YnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fu
cy1zZXJpZiI+SXQgc2VlbXMgdG8gbWUgdGhhdCB3aGV0aGVyIFJTVCBpcyBoYXBwZW4gb3Igbm90
IGRlcGVuZHMgb24gdGhlIHNpemUgb2YgcmVjZWl2ZSB3aW5kb3cgYWNjb3JkaW5nIHRvIHRoZSB0
ZXh0LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LHNhbnMtc2VyaWYiPklmIHRoZSByZWNlaXZlIHdpbmRvdyBzaXplIGlzIGJpZyBl
bm91Z2ggdG8gYWNjb21tb2RhdGUmbmJzcDtzZWdtZW50IDEgYW5kIHNlZ21lbnQgMywgdGhlIHRl
eHQgJnF1b3Q7PC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkltcGxlbWVudGF0aW9ucw0KIE1BWSBob2xk
IG9udG8gc3VjaCB1bm1hcHBlZCBkYXRhIGZvciBhIHNob3J0IHdoaWxlIGluJm5ic3A7dGhlIGV4
cGVjdGF0aW9uIHRoYXQgYSBtYXBwaW5nIHdpbGwgYXJyaXZlIHNob3J0bHkuLiAmcXVvdDsmbmJz
cDs8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+Y2FuIGJlIGFwcGxpZWQgdG8gdGhlIHNlZ21lbnQgMS4g
QXMgYSByZXN1bHQsIHRoZSBzZWdtZW50IDEgd29uJ3QgYmUgZGlzY2FyZGVkLiZuYnNwOzxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1z
ZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxlbT48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVv
dDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5ZZXMuJm5ic3A7IFNvLCBzZWdtZW50IDEgbWF5IGJl
IGtlcHQgaW4gdGhlIGRhdGEgcmVjZWl2ZXIncyBidWZmZXIgaW4gZXhwZWN0YXRpb24gdGhhdCBp
dHMgbWFwcGluZyB3aWxsIGFycml2ZSBzaG9ydGx5LiBBbmQgaW4gdGhlIGV4YW1wbGUgdGhhdCB3
ZSBhcmUgcmVmZXJyaW5nIHRvLCB0aGUgZGF0YSBzZW5kZXINCiB3aWxsIG5vdCBiZSBhYmxlIHRv
IGluY2x1ZGUgdGhlIG1hcCBmb3IgdGhlIGRhdGEgaW4gc2VnbWVudCAxIGluIHNlZ21lbnQgMyBv
ciBhbnkgaGlnaGVyIHNlZ21lbnQuPC9zcGFuPjwvZW0+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZTox
Mi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD48L286
cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlm
Ij48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PGVtPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LHNhbnMtc2VyaWYiPlJlZ2FyZHMsPC9zcGFuPjwvZW0+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+
PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90Oyxz
YW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PGVtPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkFuaWw8L3NwYW4+PC9lbT48c3BhbiBzdHls
ZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNl
cmlmIj48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1
b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5Ib3dldmVyLCB0aGlzIG1pZ2h0IGJlIGNv
bnRyYWRpY3Qgd2l0aCB0aGUgbmV3IHRleHRzIEFsYW4gcHJvcG9zZWQ/IE9yLCBhbSBJIG1pc3Np
bmcgc29tZXRoaW5nPzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2Zv
bnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPlRoYW5rcyw8bzpwPjwvbzpw
Pjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5z
LXNlcmlmIj4tLTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZx
dW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPllvc2hpPG86cD48L286cD48L3NwYW4+PC9wPg0K
PC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1
b3Q7LHNhbnMtc2VyaWYiPjxicj4NCjxicj4NCjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4w
cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+T24gU3VuLCBGZWIg
MiwgMjAyMCBhdCA4OjQyIEFNIFYgQW5pbCBLdW1hciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxA
Y3NpcjRwaS5pbiIgdGFyZ2V0PSJfYmxhbmsiPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7IHdyb3Rl
OjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRl
cjpub25lO2JvcmRlci1sZWZ0OnNvbGlkICNDQ0NDQ0MgMS4wcHQ7cGFkZGluZzowY20gMGNtIDBj
bSA2LjBwdDttYXJnaW4tbGVmdDo0LjhwdDttYXJnaW4tcmlnaHQ6MGNtIj4NCjxkaXY+DQo8ZGl2
Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9
ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJp
ZiI+SGkgWW9zaGksPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtB
cmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+VGhhbmtzIGZvciB0aGlzIHBv
aW50LiBJbiBmYWN0LCBJIGhhZCBpbml0aWFsbHkgbm90IHRob3VnaHQgb2YgYSBzY2VuYXJpbywg
d2hlcmUgdGhlIG1hcCBpcyBiZWluZyBkZWxpdmVyZWQgdGhyb3VnaCBhIHJldHJhbnNtaXR0ZWQg
ZGF0YSBwYWNrZXQgd2hpbGUgaXRzIGZpcnN0IHRyYW5zbWlzc2lvbiBkaWQNCiBub3QgaW5jbHVk
ZSB0aGUgbWFwLiBOb3cgSSBhbSBqdXN0IHNlZWluZyB0aGUgZG9jdW1lbnQgKFJGQyA2ODI0LWJp
cykgaW4gdGhpcyBjb250ZXh0LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6
JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9w
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIu
MHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPk15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCBpbiBzY2VuYXJpb3MgbGlrZSB3aGF0IEkgZGVzY3JpYmVkIGluIG15IHBy
ZXZpb3VzIG1haWwsIFJTVCBpcyBsaWtlbHkgdG8gaGFwcGVuIHdoZXRoZXIgd2UgZXhwbGljaXRs
eSBzdGF0ZSBzbyBvciBub3QuIFBsZWFzZSBzZWUgdGhlIHBhcmFncmFwaCBjb250YWluaW5nDQog
dGhlIGJlbG93IHRleHQgaW4gUkZDIDY4MjQtYmlzLiAmbmJzcDs8bzpwPjwvbzpwPjwvc3Bhbj48
L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5i
c3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5z
LXNlcmlmIj4mcXVvdDtJZiBhIG1hcHBpbmcgZm9yIHRoYXQgc3ViZmxvdy1sZXZlbCBzZXF1ZW5j
ZSBzcGFjZSBkb2VzIG5vdCBhcnJpdmUgd2l0aGluIGEgcmVjZWl2ZSB3aW5kb3cgb2YgZGF0YSwg
dGhhdCBzdWJmbG93IFNIT1VMRCBiZSB0cmVhdGVkIGFzIGJyb2tlbiwgY2xvc2VkIHdpdGggYSBS
U1QsIGFuZCBhbnkgdW5tYXBwZWQNCiBkYXRhIHNpbGVudGx5IGRpc2NhcmRlZC4mcXVvdDs8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMt
c2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtB
cmlhbCZxdW90OyxzYW5zLXNlcmlmIj5pZiB3ZSBhc3N1bWUgdGhhdCB0aGUgbWFwIGlzIGluY2x1
ZGVkIHdoaWxlIHJldHJhbnNtaXR0aW5nIHRoZSBkYXRhIChldmVuIHRob3VnaCB0aGUgZmlyc3Qg
dHJhbnNtaXNzaW9uIGRpZCBub3QgY29udGFpbiB0aGUgbWFwIGZvciBzb21lIHJlYXNvbnMpLCAm
bmJzcDt3ZSBjb3VsZCBhcmd1ZSB0aGF0IFJTVCBjb3VsZA0KIGJlIGF2b2lkZWQgcHJvdmlkZWQg
dGhhdCB0aGUgcmV0cmFuc21pc3Npb24gaXMgdHJpZ2dlcmVkIHdpdGhpbiBhIHJlY2VpdmUgd2lu
ZG93IG9mIGRhdGEuIEJ1dCB0aGUgcXVlc3Rpb24gaGVyZSB3b3VsZCBiZSBob3cgYW5kIHdoZW4g
d2lsbCB0aGUgcmV0cmFuc21pc3Npb24gdGFrZSBwbGFjZS4gSW4gdGhpcyBjYXNlLCB0aGUgc3Vi
ZmxvdyBtYXkgbm90IGluaXRpYXRlIHRoZSByZXRyYW5zbWlzc2lvbiBvZiBkYXRhIGJ5IGl0cyBv
d24gKGkuLmUuLA0KIG5vIHJldHJhbnNtaXNzaW9uIGR1ZSB0byB0aHJlZSBkdXBsaWNhdGUgQUNL
cyBvciBSVE8gZXhwaXJ5IGF0IHN1YmZsb3cgbGV2ZWwpIGFzIHRoZXJlIGlzIG5vIHNlZ21lbnQg
bG9zcyBhdCBzdWJmbG93IGxldmVsIHNlcXVlbmNlIHNwYWNlLiBTbyB0aGVyZSBjb3VsZCBiZSBh
IGhpZ2ggcG9zc2liaWxpdHkgb2YgUlNUIGhhcHBlbmluZyBldmVuIGJlZm9yZSB0aGUgbWFwIGRl
bGl2ZXJ5IHRocm91Z2ggcmV0cmFuc21pc3Npb24uJm5ic3A7PG86cD48L286cD48L3NwYW4+PC9w
Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNw
OzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1z
ZXJpZiI+V2l0aCByZWdhcmRzLCZuYnNwOzxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3Nw
YW4+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkFuaWw8
bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZx
dW90OyxzYW5zLXNlcmlmIj4mbmJzcDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxk
aXYgY2xhc3M9Ik1zb05vcm1hbCIgYWxpZ249ImNlbnRlciIgc3R5bGU9InRleHQtYWxpZ246Y2Vu
dGVyIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlh
bCZxdW90OyxzYW5zLXNlcmlmIj4NCjxociBzaXplPSIyIiB3aWR0aD0iMTAwJSIgYWxpZ249ImNl
bnRlciIgaWQ9ImdtYWlsLW1fLTU0MDY1NDM1NTY3Mzc3MjIwMWdtYWlsLW1fODc3MzM1NzQzOTc3
NzA4MTU5MGdtYWlsLW1fMjE4MDg2NTk2OTUxNzI0NTAxZ21haWwtbV8yOTgyMjY3MDMzNTc3OTAy
OTg1endjaHIiPg0KPC9zcGFuPjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1
b3Q7LHNhbnMtc2VyaWYiPkZyb206DQo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPiZxdW90O1lv
c2hpZnVtaSBOaXNoaWRhJnF1b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86bnNkLmlldGZAZ21haWwu
Y29tIiB0YXJnZXQ9Il9ibGFuayI+bnNkLmlldGZAZ21haWwuY29tPC9hPiZndDs8YnI+DQo8Yj5U
bzogPC9iPiZxdW90O1YgQW5pbCBLdW1hciZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxA
Y3NpcjRwaS5pbiIgdGFyZ2V0PSJfYmxhbmsiPmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7PGJyPg0K
PGI+Q2M6IDwvYj4mcXVvdDthbGFuIGZvcmQmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFu
LmZvcmRAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4m
Z3Q7LCAmcXVvdDttdWx0aXBhdGh0Y3AmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzptdWx0aXBh
dGh0Y3BAaWV0Zi5vcmciIHRhcmdldD0iX2JsYW5rIj5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+
Jmd0Ozxicj4NCjxiPlNlbnQ6IDwvYj5TYXR1cmRheSwgRmVicnVhcnkgMSwgMjAyMCAzOjM5OjUx
IEFNPGJyPg0KPGI+U3ViamVjdDogPC9iPlJlOiBbbXVsdGlwYXRodGNwXSBSRkM2ODI0YmlzIGVk
aXRzIGJhc2VkIG9uIGltcGxlbWVudGF0aW9uIGZlZWRiYWNrPG86cD48L286cD48L3NwYW4+PC9w
Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNw
OzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFt
aWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkhpIEFuaWwsPG86cD48L286cD48L3Nw
YW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpw
PiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNw
YW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDss
c2Fucy1zZXJpZiI+SSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgeW91ciBwcm9wb3NlZCB0ZXh0Ljxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNv
Tm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtB
cmlhbCZxdW90OyxzYW5zLXNlcmlmIj5JIGFtIGFjdHVhbGx5IHdvbmRlcmluZyBpZiB3ZSByZWFs
bHkgd2FudCB0byB0ZXJtaW5hdGUgY29ubmVjdGlvbiBoZXJlLiZuYnNwOzxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHls
ZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNl
cmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJp
YWwmcXVvdDssc2Fucy1zZXJpZiI+VGhlIHBhY2tldHMgd2l0aG91dCBwcm9wZXIgbWFwcGluZ3Mg
d2lsbCBiZSB0cmVhdGVkIGFzIGludmFsaWQgYW5kIHdpbGwgYmUgZGlzY2FyZGVkLiZuYnNwOzxv
OnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1
b3Q7LHNhbnMtc2VyaWYiPklmIGFuIGltcGxlbWVudGF0aW9uIGZhaWxlZCB0byBhdHRhY2ggcHJv
cGVyIG1hcHBpbmcgZm9yIHNvbWUgcmVhc29ucyAoZS5nLiBvcHRpb24gc3BhY2UpLCBpdCBtaWdo
dCBiZSBhYmxlIHRvIGF0dGFjaCB0aGUgcHJvcGVyIG9uZSB3aGVuIGl0IHJldHJhbnNtaXRzIHRo
ZSBwYWNrZXRzLiBUaGlzIGFsc28NCiBsb29rcyBvayB0byBtZS48bzpwPjwvbzpwPjwvc3Bhbj48
L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5i
c3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5z
LXNlcmlmIj5JIGRvbid0IGhhdmUgc3Ryb25nIHByZWZlcmVuY2UgZm9yIHRoaXMuIEJ1dCwgZG8g
d2UgaGF2ZSBhIHJlYXNvbiB0byB0ZXJtaW5hdGUgY29ubmVjdGlvbj88bzpwPjwvbzpwPjwvc3Bh
bj48L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNp
emU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+
Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90Oyxz
YW5zLXNlcmlmIj5UaGFua3MsPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0K
PHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+LS08bzpwPjwvbzpwPjwvc3Bhbj48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5Z
b3NoaTxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+
PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVv
dDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250
LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5PbiBNb24sIEphbiAxMywgMjAy
MCBhdCAxMDoyOCBBTSBWIEFuaWwgS3VtYXIgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0
cGkuaW4iIHRhcmdldD0iX2JsYW5rIj5hbmlsQGNzaXI0cGkuaW48L2E+Jmd0OyB3cm90ZTo8bzpw
PjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXI6bm9u
ZTtib3JkZXItbGVmdDpzb2xpZCAjQ0NDQ0NDIDEuMHB0O3BhZGRpbmc6MGNtIDBjbSAwY20gNi4w
cHQ7bWFyZ2luLWxlZnQ6NC44cHQ7bWFyZ2luLXJpZ2h0OjBjbSI+DQo8ZGl2Pg0KPGRpdj4NCjxk
aXY+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250
LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkhp
LDxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxkaXY+DQo8ZGl2Pg0KPGRp
dj4NCjxkaXY+DQo8ZGl2Pg0KPGRpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3Bh
biBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90Oyxz
YW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1
b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+SSBoYXZlIHNvbWUgcG9pbnRzIHJlbGF0ZWQgdG8g
dGhlICZuYnNwO21vZGlmaWNhdGlvbnMgKENoYW5nZSAyKSBiZWluZyBwcm9wb3NlZCBvbiBkYXRh
IHNlcXVlbmNlIG1hcC4gUGxlYXNlIHNlZSB0aGVtIGlubGluZS4mbmJzcDs8c3BhbiBzdHlsZT0i
Y29sb3I6YmxhY2s7YmFja2dyb3VuZDp3aGl0ZSI+VGhvdWdoIEkgYW0NCiBwdXR0aW5nIGZvcndh
cmQgdGhlIGJlbG93IHBvaW50cywgaWYgdGhlIGNvbnNlbnN1cyBpcyBpbiBmYXZvdXIgb2YgdGhl
IHByb3Bvc2VkIGNoYW5nZSBmb3IgcmVkdWNpbmcgaW1wbGVtZW50YXRpb24gY29tcGxleGl0eSwg
SSBhbSBhbHNvIE9LIHdpdGggdGhhdCBhcyB3ZWxsLiZuYnNwOzwvc3Bhbj48bzpwPjwvbzpwPjwv
c3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250
LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxv
OnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXYgY2xhc3M9Ik1zb05vcm1hbCIgYWxpZ249
ImNlbnRlciIgc3R5bGU9InRleHQtYWxpZ246Y2VudGVyIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj4NCjxociBz
aXplPSIyIiB3aWR0aD0iMTAwJSIgYWxpZ249ImNlbnRlciIgaWQ9ImdtYWlsLW1fLTU0MDY1NDM1
NTY3Mzc3MjIwMWdtYWlsLW1fODc3MzM1NzQzOTc3NzA4MTU5MGdtYWlsLW1fMjE4MDg2NTk2OTUx
NzI0NTAxZ21haWwtbV8yOTgyMjY3MDMzNTc3OTAyOTg1Z21haWwtbV83Njg3MTg0MzgyMjk5NTk2
Nzc0endjaHIiPg0KPC9zcGFuPjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxi
PjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1
b3Q7LHNhbnMtc2VyaWYiPkZyb206DQo8L3NwYW4+PC9iPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPiZxdW90O2Fs
YW4gZm9yZCZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5hbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDs8YnI+DQo8Yj5UbzogPC9i
PjxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmciIHRhcmdldD0iX2JsYW5rIj5t
dWx0aXBhdGh0Y3BAaWV0Zi4ub3JnPC9hPjxicj4NCjxiPlNlbnQ6IDwvYj5UaHVyc2RheSwgSmFu
dWFyeSAyLCAyMDIwIDQ6MjE6MzIgQU08YnI+DQo8Yj5TdWJqZWN0OiA8L2I+W211bHRpcGF0aHRj
cF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBmZWVkYmFjazxvOnA+
PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1z
ZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LHNhbnMtc2VyaWYiPkhpIGFsbCw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9u
dC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+V2XigJlkIGxvdmUgdG8gZ2V0
IHRoaXMgdG8gYSBzdGF0ZSBvZiBjb21wbGV0aW9uIGFzIHNvb24gYXMgcG9zc2libGUsIGFuZCB0
byB0aGlzIGVuZCBJIGFtIHN0YXJ0aW5nIGEgbmV3IHRocmVhZCBvbiB0aGlzIHRvcGljLiBJbiBk
aXNjdXNzaW9uIHdpdGggdGhlIGNoYWlycywgaXQNCjxpPmlzIDwvaT5wb3NzaWJsZSB0byBtYWtl
IHRoZSBkZXNpcmVkIGNoYW5nZXMgaW4gQVVUSDQ4IGFzIGxvbmcgYXMgdGhlcmUgaXMgV0cgY29u
c2Vuc3VzLiBUaGUgZGlzY3Vzc2lvbiBzbyBmYXIgaGFzIGJlZW4gZmFpcmx5IGxpbWl0ZWQgaW4g
dGVybXMgb2YgcGFydGljaXBhdGlvbi48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFt
aWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFu
PjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXpl
OjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5JIHdvdWxk
IGFzayB0aGUgY2hhaXJzIHBsZWFzZSBpZiBpdCB3YXMgcG9zc2libGUgdG8gc3BlY2lmeSBhIHRp
bWUgYm91bmQgZm9yIHRoaXMgZGlzY3Vzc2lvbiBhbmQgYSBkZWZhdWx0IGNvbmNsdXNpb24uPG86
cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBz
dHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5z
LXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+UmVnYXJkaW5nIHRoZSBjaGFuZ2VzLCBpbiBzdW1tYXJ5
LCB0aGVyZSBhcmUgdHdvIGFyZWFzIHdoZXJlIGNoYW5nZXMgaGF2ZSBiZWVuIHJlcXVlc3RlZCBi
eSB0aGUgaW1wbGVtZW50YXRpb24gY29tbXVuaXR5LiBBcyB3ZSBhcmUgdGhlIElFVEYgd2Ugb2J2
aW91c2x5IGhhdmUgc3Ryb25nIGZvY3VzIG9uDQog4oCccnVubmluZyBjb2Rl4oCdIGFuZCBzbyBl
YXNlIG9mIGltcGxlbWVudGluZyBzdGFuZGFyZHMtY29tcGxpYW50IGNvZGUgaXMgc3Ryb25nbHkg
ZGVzaXJhYmxlLiBIb3dldmVyLCB3ZSBkbyBub3Qgd2lzaCB0byByZWR1Y2UgZnVuY3Rpb25hbGl0
eSBhZ3JlZWQgYnkgdGhlIElFVEYgY29tbXVuaXR5IGlmIGl0IGlzIGNvbnNpZGVyZWQgYSByZXF1
aXJlZCBmZWF0dXJlIGJ5IHRoZSBjb21tdW5pdHkuPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9k
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPjxz
cGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7
LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5DaGFuZ2UgMTwvc3Bhbj48L2I+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fu
cy1zZXJpZiI+PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1
b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1ib3R0b206
MTIuMHB0Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtB
cmlhbCZxdW90OyxzYW5zLXNlcmlmIj5DaGFuZ2UgdGhlIHNlbnRlbmNlIHJlYWRpbmc6PGJyPg0K
PGJyPg0KPGk+Jm5ic3A7ICZuYnNwO0lmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0
aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyAmIzQzOyBNUF9DQVBBQkxFIGNhbiBiZSBp
bmZlcnJlZCBieSB0aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNl
cXVlbmNlIFNpZ25hbCAoRFNTKSBvcHRpb24gKFNlY3Rpb24gMy4zKS4mbmJzcDs8YnI+DQo8L2k+
PGJyPg0KVG86PGJyPg0KPGJyPg0KPGk+Jm5ic3A7ICZuYnNwO0lmIEIgaGFzIGRhdGEgdG8gc2Vu
ZCBmaXJzdCwgdGhlbiB0aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyAmIzQzOyBNUF9D
QVBBQkxFIGlzIGVuc3VyZWQgYnkgdGhlIHJlY2VpcHQgb2YgdGhpcyBkYXRhIHdpdGggYW4gTVBU
Q1AgRGF0YSBTZXF1ZW5jZSBTaWduYWwgKERTUykgb3B0aW9uIChTZWN0aW9uIDMuMykgY29udGFp
bmluZyBhIERBVEFfQUNLIGZvciB0aGUgTVBfQ0FQQUJMRSAod2hpY2ggaXMgdGhlIGZpcnN0IG9j
dGV0IG9mDQogdGhlIGRhdGEgc2VxdWVuY2UmbmJzcDtzcGFjZSkuPC9pPjxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2Vy
aWYiPldoYXQgdGhpcyBtZWFuczo8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwv
cD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5UaGUgY3VycmVu
dCB0ZXh0IGlzIGNvbmNlcm5lZCBvbmx5IHdpdGggZW5zdXJpbmcgYSBwYXRoIGlzIE1QVENQIGNh
cGFibGUsIGFuZCBzbyBvbmx5IGNhcmVzIHRoYXQgRFNTIG9wdGlvbiBvY2N1cnMgb24gYSBkYXRh
IHBhY2tldC4gSG93ZXZlciwgdGhlIE1QX0NBUEFCTEUgb3B0aW9uIGlzIGRlZmluZWQNCiB0byBv
Y2N1cHkgdGhlIGZpcnN0IG9jdGV0IG9mIGRhdGEgc2VxdWVuY2Ugc3BhY2UgYW5kIHRodXMsIGlm
IGFuYWxvZ291cyB0byBUQ1AsIG11c3QgYmUgYWNrbm93bGVkZ2VkLiAmZ3Q7RnJvbSBhbiBpbXBs
ZW1lbnRhdGlvbiBwb2ludCBvZiB2aWV3IGl0IHdvdWxkIG1ha2Ugc2Vuc2Ugbm90IHRvIGhhdmUg
dGhpcyBoYW5naW5nIGFyb3VuZCBmb3JldmVyIGFuZCBpbnN0ZWFkIGRlZmluZSBpdCBpcyBhY2tu
b3dsZWRnZWQgYXQgdGhlIGNvbm5lY3Rpb24NCiBsZXZlbCBhcyBzb29uIGFzIHJlY2VpdmVkLiBU
aGlzIGNoYW5nZSBlbnN1cmVzIHRoZSBmaXJzdCBkYXRhIHBhY2tldCBhbHNvIERBVEFfQUNLcyB0
aGlzIE1QX0NBUEFCTEUgb2N0ZXQuPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0ibWFyZ2luLWJvdHRvbToxMi4wcHQiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2Vy
aWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj48Yj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtB
cmlhbCZxdW90OyxzYW5zLXNlcmlmIj5DaGFuZ2UgMjwvc3Bhbj48L2I+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+
PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwm
cXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8
ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7
Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+Q2hhbmdlIHRoZSBzZW50
ZW5jZSByZWFkaW5nOjxicj4NCjxicj4NCjxpPiZuYnNwOyAmbmJzcDtBIERhdGEgU2VxdWVuY2Ug
TWFwcGluZyBkb2VzIG5vdCBuZWVkIHRvIGJlIGluY2x1ZGVkIGluIGV2ZXJ5IE1QVENQIHBhY2tl
dCwgYXMgbG9uZyBhcyB0aGUgc3ViZmxvdyBzZXF1ZW5jZSBzcGFjZSBpbiB0aGF0IHBhY2tldCBp
cyBjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2ZXIuPC9pPjxicj4NCjxi
cj4NClRvOjxicj4NCjxicj4NCjxpPiZuYnNwOyAmbmJzcDtUaGUgbWFwcGluZyBwcm92aWRlZCBi
eSBhIERhdGEgU2VxdWVuY2UgTWFwcGluZyBNVVNUIGFwcGx5IHRvIHNvbWUgb3IgYWxsIG9mIHRo
ZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGluIHRoZSBUQ1Agc2VnbWVudCB3aGljaCBjYXJyaWVz
IHRoZSBvcHRpb24uIEl0IGRvZXMgbm90IG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4gZXZlcnkgTVBU
Q1AgcGFja2V0LCBhcyBsb25nIGFzIHRoZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGluIHRoYXQg
cGFja2V0DQogaXMgY292ZXJlZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2VpdmVyLjxi
cj4NCjwvaT48YnI+DQpXaGF0IHRoaXMgbWVhbnM6PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9k
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtm
b250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpw
Pjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZv
bnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+
VGhlIGN1cnJlbnQgdGV4dCBkb2VzIG5vdCBwbGFjZSBhbnkgcmVzdHJpY3Rpb25zIG9uIHdoZXJl
IGEgbWFwcGluZyBjb3VsZCBhcHBlYXIuIEluIHRoZW9yeSBhIHNlbmRlciBjb3VsZCBkZWZpbmUg
YSB0aG91c2FuZCBkaWZmZXJlbnQgbWFwcGluZ3MgdXAgZnJvbnQsIHNlbmQgdGhlbSBhbGwsIGFu
ZCBleHBlY3QNCiBhIHJlY2VpdmVyIHRvIHN0b3JlIHRoaXMgYW5kIHJlYXNzZW1ibGUgZGF0YSBh
Y2NvcmRpbmcgdG8gdGhlc2UgbWFwcGluZ3MgYXMgaXQgYXJyaXZlcy4gSW5kZWVkLCB0aGlzIHdh
cyBuZXZlciBleHBsaWNpdGx5IGRpc2FsbG93ZWQgc2luY2UgaXQg4oCcbWlnaHQgaGF2ZSBiZWVu
IHVzZWZ1bOKAnS4gVGhlIGltcGxlbWVudGF0aW9uIGNvbW11bml0eSwgaG93ZXZlciwgaGFzIGV4
cHJlc3NlZCBjb25jZXJucyBvdmVyIHRoZSBkaWZmaWN1bHR5IG9mIGltcGxlbWVudGluZw0KIHRo
aXMgb3Blbi1lbmRlZGx5LiBIb3cgbWFueSBtYXBwaW5ncyBpcyBpdCByZWFzb25hYmxlIHRvIHN0
b3JlPyBJcyB0aGVyZSBhIERvUyByaXNrIGhlcmU/IEluc3RlYWQsIGl0IGhhcyBiZWVuIHJlcXVl
c3RlZCB0aGF0IHRoZWUgc3BlY2lmaWNhdGlvbiByZXN0cmljdHMgdGhlIHBsYWNlbWVudCBvZiB0
aGUgRFNTIG9wdGlvbiB0byBiZWluZyB3aXRoaW4gdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2Ug
dG8gd2hpY2ggaXQgYXBwbGllcy48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNs
YXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5
OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwv
cD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5CZWxvdyBhcmUg
bXkgY29tbWVudHMgb24gdGhpcy4gSSBoYWQgc2hhcmVkIHNvbWUgb2YgdGhlc2UgcG9pbnRzIGlu
IGEgcHJldmlvdXMgdGhyZWFkIHRoYXQgeW91IGhhZCBpbml0aWF0ZWQgaW4gdGhlIHNhbWUgY29u
dGV4dC4mbmJzcDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxwIGNsYXNzPSJNc29O
b3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0Fy
aWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250
LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5UcmFuc21pdHRpbmcgbGFyZ2Ug
bnVtYmVyIG9mIG5vbi1jb250aWd1b3VzIGRhdGEgc2VxdWVuY2UgbWFwcyBjb3VsZCBiZSBhIG1p
c2JlaGF2aW91ciAobWFwLWZsb29kaW5nKSwgdGhvdWdoIGl0IGlzIG5vdCBjbGVhciB3aGV0aGVy
IHRoaXMgY2FuIGdvIHRvIHRoZSBleHRlbnQgb2YgY2F1c2luZyBhIHBvdGVudGlhbA0KIERvUyB0
byB0aGUgZGF0YSByZWNlaXZlci4gU28gc29tZSBzb3J0IG9mIHJlc3RyaWN0aW9uIG9uIHRoaXMg
Y291bGQgYmUgdXNlZnVsLiZuYnNwOyBPbmUgYXBwcm9hY2ggY291bGQgYmUgdG8gaW5zaXN0IHRo
YXQgdGhlIGRhdGEgc2VuZGVyIHNob3VsZCBlbnN1cmUgdGhhdCB0aGUgbWFwIGJlaW5nIHRyYW5z
bWl0dGVkIGlzIGZvciBpbi13aW5kb3cgZGF0YSwgYXMgcGVyIHRoZSByZWNlaXZlciBhZHZlcnRp
c2VkIHdpbmRvdy4gQSByZWNlaXZlciBzaG91bGQNCiBhbnlob3cgYmUgd2lsbGluZyB0byBzdG9y
ZSB0aGUgbWFwcyBmb3IgaW4td2luZG93IGRhdGEgdG8gZGVhbCB3aXRoIHBhY2tldCBsb3NzLiBG
b3IgZXhhbXBsZSwgd2hlbiBhIHdpbmRvdyBvZiBkYXRhIHNlZ21lbnRzIChzYXkgMSB0byA2NCkg
aXMgdHJhbnNtaXR0ZWQsIGVhY2ggY2FycnlpbmcgaXRzIGNvcnJlc3BvbmRpbmcgbWFwLCBhbmQg
c2VnbWVudC0xIGlzIGxvc3QsIHRoZSBtYXBzIGZvciB0aGUgcmVtYWluaW5nIDYzIG5lZWQgdG8g
YmUNCiBzdG9yZWQgdGlsbCB0aGUgbG9zdCBzZWdtZW50IGlzIHJldHJhbnNtaXR0ZWQuIE9mIGNv
dXJzZSwgaW4gdGhpcyBjYXNlIHRoZSBtYXBzIHdpbGwgYmUgc3RvcmVkIGF0IHRoZSByZWNlaXZl
ciBzaWRlIGFsb25nIHdpdGggdGhlaXIgY29ycmVzcG9uZGluZyBkYXRhLiBCdXQgdGhlIG5lZWQg
dG8gc3RvcmUgbXVsdGlwbGUgbWFwcyBmb3IgaW4td2luZG93IGRhdGEgd291bGQgc3RpbGwgYmUg
dGhlcmUuPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFs
Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZx
dW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1p
bHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjpibGFjaztiYWNrZ3JvdW5kOndo
aXRlIj5UaGUgcHJvYmxlbSB3aXRoIHRoZSBwcm9wb3NlZCBjaGFuZ2UgKHJlc3RyaWN0aW9uKSBp
cyB0aGF0IGEgZGF0YSBzZW5kZXIgbWF5IGZpbmQgaXQgZGlmZmljdWx0LCBpbiBjYXNlIGEgbmVl
ZCBhcmlzZSB0byBzbGlnaHRseSBkZWxheSB0aGUgbWFwIGRlbGl2ZXJ5DQogYnkgZmV3IHNlZ21l
bnRzLCBpLmUuLCBzZW5kaW5nIHNvbWUgZGF0YSBmaXJzdCB3aXRob3V0IG1hcCwgYW5kIHRoZW4g
c2VuZCB0aGUgY29ycmVzcG9uZGluZyBtYXAgaW4gYSBsYXRlciBzZWdtZW50LCBhcyBzaG93biBi
ZWxvdzo8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1
b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250
LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwv
c3Bhbj48L3A+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJiYWNr
Z3JvdW5kOndoaXRlIj48c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7
Zm9udC1mYW1pbHk6JnF1b3Q7U2Vnb2UgVUkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjpibGFjayI+
c3ViZmxvdy0xOiZuYnNwOyAmbmJzcDsgJm5ic3A7IHNlZ21lbnQtMSZuYnNwOyZuYnNwOyZuYnNw
OyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsm
bmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsgc2VnbWVudC0zJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNlZ21l
bnQtNCAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNlZ21lbnQtNzwvc3Bhbj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjEwLjVwdDtmb250LWZhbWlseTomcXVvdDtTZWdvZSBVSSZxdW90OyxzYW5zLXNlcmlm
Ij48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIiBzdHlsZT0iYmFja2dyb3VuZDp3aGl0ZSI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJm
b250LXNpemU6MTAuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O1NlZ29lIFVJJnF1b3Q7LHNhbnMtc2Vy
aWY7Y29sb3I6YmxhY2siPiZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNw
OyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDtieXRlczoxLTEwMCAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IGJ5dGVzOjIwMS0zMDAgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7Ynl0ZXM6MzAxLTQw
MCAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
IGJ5dGVzOjYwMS03MDA8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC41cHQ7Zm9udC1m
YW1pbHk6JnF1b3Q7U2Vnb2UgVUkmcXVvdDssc2Fucy1zZXJpZiI+PG86cD48L286cD48L3NwYW4+
PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9ImJhY2tncm91
bmQ6d2hpdGUiPjxzcGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250
LWZhbWlseTomcXVvdDtTZWdvZSBVSSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOmJsYWNrIj4mbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7Jm5ic3A7bm8gbWFwICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7bWFw
IGZvciAxLTEwMCAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDttYXAgZm9yIDIwMS00MDAgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgbWFwIGZvciA2MDEtNzAwPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuNXB0O2Zv
bnQtZmFtaWx5OiZxdW90O1NlZ29lIFVJJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+PC9vOnA+PC9z
cGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJiYWNr
Z3JvdW5kOndoaXRlIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjVwdDtmb250LWZhbWlseTom
cXVvdDtTZWdvZSBVSSZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0iYmFja2dyb3Vu
ZDp3aGl0ZSI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC41cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
U2Vnb2UgVUkmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0K
PC9kaXY+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9ImJhY2tncm91bmQ6d2hp
dGUiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTAuNXB0O2ZvbnQtZmFtaWx5OiZxdW90O1NlZ29l
IFVJJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2
Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJiYWNrZ3JvdW5kOndoaXRlIj48
c3BhbiBsYW5nPSJFTi1VUyIgc3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1
b3Q7U2Vnb2UgVUkmcXVvdDssc2Fucy1zZXJpZjtjb2xvcjpibGFjayI+c3ViZmxvdy0yOiZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwO3NlZ21lbnQtMiZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7IHNlZ21lbnQtNSAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgc2VnbWVudC02ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgc2VnbWVudC04PC9zcGFuPjxzcGFuIHN0
eWxlPSJmb250LXNpemU6MTAuNXB0O2ZvbnQtZmFtaWx5OiZxdW90O1NlZ29lIFVJJnF1b3Q7LHNh
bnMtc2VyaWYiPjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPGRpdj4NCjxwIGNsYXNz
PSJNc29Ob3JtYWwiIHN0eWxlPSJiYWNrZ3JvdW5kOndoaXRlIj48c3BhbiBsYW5nPSJFTi1VUyIg
c3R5bGU9ImZvbnQtc2l6ZToxMC4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7U2Vnb2UgVUkmcXVvdDss
c2Fucy1zZXJpZjtjb2xvcjpibGFjayI+Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5i
c3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7
Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwO2J5dGVzOiAxMDEtMjAw
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgYnl0ZXM6NDAxLTUwMCZuYnNwOyZu
YnNwOyZuYnNwOyZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsmbmJzcDsmbmJz
cDsmbmJzcDsmbmJzcDsgYnl0ZXM6IDUwMS02MDAgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO2J5dGVzOjcwMS04MDAmbmJzcDsmbmJzcDsmbmJz
cDs8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMC41cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
U2Vnb2UgVUkmcXVvdDssc2Fucy1zZXJpZiI+PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+
DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9ImJhY2tncm91bmQ6d2hpdGUiPjxz
cGFuIGxhbmc9IkVOLVVTIiBzdHlsZT0iZm9udC1zaXplOjEwLjBwdDtmb250LWZhbWlseTomcXVv
dDtTZWdvZSBVSSZxdW90OyxzYW5zLXNlcmlmO2NvbG9yOmJsYWNrIj4mbmJzcDsgJm5ic3A7ICZu
YnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwO21hcCBmb3IgMTAxLTIwMCAmbmJzcDsgJm5ic3A7ICZuYnNwOyBtYXAgZm9yIDQw
MS02MDAgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDtubyBtYXAgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwO21hcCBmb3IgNzAxLTgwMDwvc3Bh
bj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEwLjVwdDtmb250LWZhbWlseTomcXVvdDtTZWdvZSBV
SSZxdW90OyxzYW5zLXNlcmlmIj48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIiBzdHlsZT0iYmFja2dyb3VuZDp3aGl0ZSI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMC41cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7U2Vnb2UgVUkmcXVvdDssc2Fu
cy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8ZGl2Pg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9ImJhY2tncm91bmQ6d2hpdGUiPjxzcGFuIHN0eWxlPSJm
b250LXNpemU6MTAuNXB0O2ZvbnQtZmFtaWx5OiZxdW90O1NlZ29lIFVJJnF1b3Q7LHNhbnMtc2Vy
aWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05v
cm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJp
YWwmcXVvdDssc2Fucy1zZXJpZiI+SW4gdGhlIGFib3ZlIGNhc2UsIHNlZ21lbnQtMSBnb2VzIHdp
dGhvdXQgbWFwIGFuZCBpdHMgbWFwIGlzIGluY2x1ZGVkIGxhdGVyIGluIHNlZ21lbnQtMywgdGhl
IG5leHQgZGF0YSBzZWdtZW50IGluIHRoZSBzYW1lIHN1YmZsb3cuIEZ1cnRoZXIsICZuYnNwO2lu
IHRoZSBhYm92ZSBzY2hlZHVsaW5nIHBhdHRlcm4sDQogdGhlIG1hcCBpbiBzZWdtZW50LTMgY2Fu
bm90IGNvdmVyIHRoZSAmbmJzcDtkYXRhIGluIHNlZ21lbnQtMSBhbmQgc2VnbWVudC0zLCBhcyBz
b21lICZuYnNwO2RhdGEgaW4gYmV0d2VlbiAoc2VnbWVudC0yKSBpcyB0cmFuc21pdHRlZCB0aHJv
dWdoIGFub3RoZXIgc3ViZmxvdy4mbmJzcDsgV2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlLCB0aGUg
bWFwIGluIHNlZ21lbnQtMyB3aWxsIGJlY29tZSBpbnZhbGlkIGFuZCB0aGlzIHdpbGwgZXZlbnR1
YWxseSBicmVhayBzdWJmbG93LTEsDQogdGhvdWdoIHRoaXMgY291bGQgYmUgYSBjb3JuZXIgY2Fz
ZS4uPG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90
OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xh
c3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6
JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+VGhlIHF1ZXN0aW9uIGF0IHRoaXMgc3RhZ2Ug
aXMgd2h5IHdvdWxkIHNlZ21lbnQtMSBiZSB0cmFuc21pdHRlZCB3aXRob3V0IGl0cyBtYXAuIElu
IHRoZSBjYXNlIG9mIGJpZGlyZWN0aW9uYWwgZGF0YSB0cmFuc2ZlciwgdGhlcmUgY291bGQgYmUg
YSBuZWVkIHRvIHBhY2sgYm90aCB0aW1lc3RhbXAgYW5kDQogU0FDSyAmbmJzcDtvcHRpb25zIGlu
IGEgZGF0YSBzZWdtZW50LCBpLmUuLCBwaWdneWJhY2tpbmcgb2YgJm5ic3A7U0FDSyB3aXRoIGRh
dGEuIElmIHdlIGNvbnNpZGVyIHRoYXQgdGltZXN0YW1wIHRha2VzIDEyIGJ5dGVzIGFuZCBTQUNL
LCBldmVuIHdpdGggc2luZ2xlIGJsb2NrLCAmbmJzcDt0YWtlcyBhbm90aGVyIDEwIGJ5dGVzLCB0
aGUgcmVtYWluaW5nIDE4IGJ5dGVzIG9wdGlvbiBzcGFjZSBpcyBub3QgYWRlcXVhdGUgdG8gY2Fy
cnkgZGF0YSBzZXF1ZW5jZSBzaWduYWwNCiB3aXRoIG1hcCwgZXNwZWNpYWxseSB3aGVuIERTTiBp
cyA2NCBiaXQgbG9uZy4gU28gdGhlIGRlbGl2ZXJ5IG9mIGVpdGhlciBvZiB0aGUgdHdvIChTQUNL
IG9yIG1hcCkgd291bGQgYmUgZGVsYXllZC48bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4N
CjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQt
ZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9z
cGFuPjwvcD4NCjxkaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5BcyBm
YXIgYXMgSSB1bmRlcnN0YW5kLCBSRkMgMjAxOCAoVENQIFNlbGVjdGl2ZSBBY2tub3dsZWRnZW1l
bnQgT3B0aW9ucykgaW1wbGllcyB0aGF0IFNBQ0sgc2hvdWxkIG5vdCBiZSBkZWxheWVkLiBJdCBz
dGF0ZXMgJnF1b3Q7SWYgc2VudCBhdCBhbGwsIFNBQ0sgb3B0aW9ucyBTSE9VTEQgYmUgaW5jbHVk
ZWQgaW4NCiBhbGwgQUNLcyB3aGljaCBkbyBub3QgQUNLIHRoZSBoaWdoZXN0IHNlcXVlbmNlIG51
bWJlciBpbiB0aGUgZGF0YSByZWNlaXZlcidzIHF1ZXVlJnF1b3Q7LiBJdCBhbHNvIHNheXMgJnF1
b3Q7SWYgZGF0YSByZWNlaXZlciBnZW5lcmF0ZXMgU0FDSyBvcHRpb25zIHVuZGVyIGFueSBjaXJj
dW1zdGFuY2UsIGl0IFNIT1VMRCBnZW5lcmF0ZSB0aGVtIHVuZGVyIGFsbCBwZXJtaXR0ZWQgY2ly
Y3Vtc3RhbmNlcyZxdW90Oy4gJm5ic3A7IFNvLCBhcyBwYXJ0IG9mIG1lZXRpbmcgdGhlIFJGQw0K
IDIwMTggcmVxdWlyZW1lbnRzLCBpZiB0aGUgY29tYmluYXRpb24gb2YgU0FDSyBhbmQgdGltZXN0
YW1wIGlzIGdpdmVuIHByZWZlcmVuY2Ugb3ZlciBEU1MsIGRhdGEgc2VnbWVudHMgY291bGQgYmUg
dHJhbnNtaXR0ZWQgd2l0aG91dCB0aGVpciBtYXAuJm5ic3A7PG86cD48L286cD48L3NwYW4+PC9w
Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNw
OzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5
bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1z
ZXJpZiI+QW5vdGhlciBjYXNlIG9mIGRlbGF5aW5nIG1hcCBjb3VsZCBhcmlzZSBpZiB0aGUgZGF0
YSBzZW5kZXIgcHJlZmVycyB0byBzZW5kIEFERF9BRERSIG9wdGlvbiwgaW5zdGVhZCBvZiBtYXAs
IGluIGEgZGF0YSBzZWdtZW50LiBJdCBpcyBuaWNlIHRoYXQgQUREX0FERFIgb3B0aW9uIGNhbiBi
ZSBkZWxpdmVyZWQNCiByZWxpYWJseSBpbiBhIHB1cmUgQUNLLCBidXQgSSB0aGluayB0aGlzIGlz
IG5vdCB0aGUgY2FzZSB3aXRoIERTUyBhdCBwcmVzZW50LjxvOnA+PC9vOnA+PC9zcGFuPjwvcD4N
CjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4w
cHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8
L286cD48L3NwYW4+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2Vy
aWYiPklmIHdlIGFkb3B0IHRoZSBwcm9wb3NlZCBjaGFuZ2UsIEkgdGhpbmsgaXQgbWlnaHQgYWxz
byBiZSBoZWxwZnVsIHRvIHNwZWxsIG91dCBob3cgdGhlIHJlY2VpdmVyIGlzIHN1cHBvc2VkIHRv
IGJlaGF2ZSwgaWYgaXQgZ2V0cyBtYXBzIG5vdCBtZWV0aW5nIHRoZSBNVVNUIGNvbmRpdGlvbiBp
biB0aGUgcHJvcG9zZWQNCiBjaGFuZ2UuJm5ic3A7IEZvciBleGFtcGxlIHRlcm1pbmF0aW9uIG9m
IHRoZSBzdWJmbG93IHdpdGggTVBfVENQUlNUIG9wdGlvbiAoc2VjdGlvbiAzLjYgaW4gUkZDIDY4
MjQtYmlzKSB3aXRoIGFwcHJvcHJpYXRlIHJlYXNvbiBjb2RlIGFuZCBUIGZsYWcgdmFsdWUgdG8g
aW50aW1hdGUgdGhlIGRhdGEgc2VuZGVyIHRoZSBjYXVzZSBmb3Igc3ViZmxvdyB0ZXJtaW5hdGlv
bi4mbmJzcDsmbmJzcDs8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxkaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj4mbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDsgJm5ic3A7PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxkaXY+DQo8
cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZh
bWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5XaXRoIHJlZ2FyZHMsPG86cD48L286
cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0i
Zm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlm
Ij48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8ZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1h
bCIgc3R5bGU9Im1hcmdpbi1ib3R0b206MTIuMHB0Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEy
LjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5BbmlsPG86cD48
L286cD48L3NwYW4+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxl
PSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2Vy
aWYiPlBsZWFzZSBjYW4gbWVtYmVycyBvZiB0aGUgV0cgZXhwcmVzcyB3aGV0aGVyIHRoZXkgYXJl
IGhhcHB5IHdpdGggdGhlc2UgY2hhbmdlcywgb3IgY29uY2VybmVkLjxvOnA+PC9vOnA+PC9zcGFu
PjwvcD4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6
ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4m
bmJzcDs8L286cD48L3NwYW4+PC9wPg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFu
IHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFtaWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNh
bnMtc2VyaWYiPkJlc3QgcmVnYXJkcyw8bzpwPjwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjxk
aXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtm
b250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj5BbGFuPG86cD48L286cD48
L3NwYW4+PC9wPg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9u
dC1zaXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48
YnI+DQo8YnI+DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xzxicj4NCm11bHRpcGF0aHRjcCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVmPSJtYWlsdG86bXVs
dGlwYXRodGNwQGlldGYub3JnIiB0YXJnZXQ9Il9ibGFuayI+bXVsdGlwYXRodGNwQGlldGYub3Jn
PC9hPjxicj4NCjxhIGhyZWY9Imh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8v
bXVsdGlwYXRodGNwIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1h
bi9saXN0aW5mby9tdWx0aXBhdGh0Y3A8L2E+PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9kaXY+
DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4N
CjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpw
PiZuYnNwOzwvbzpwPjwvc3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTom
cXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48YnI+DQo8YnI+DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj4NCm11bHRpcGF0aHRjcCBtYWlsaW5n
IGxpc3Q8YnI+DQo8YSBocmVmPSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3JnIiB0YXJnZXQ9
Il9ibGFuayI+bXVsdGlwYXRodGNwQGlldGYub3JnPC9hPjxicj4NCjxhIGhyZWY9Imh0dHBzOi8v
d3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vbXVsdGlwYXRodGNwIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3A8L2E+
PG86cD48L286cD48L3NwYW4+PC9wPg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8L2Rpdj4NCjwv
ZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PHNwYW4g
c3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7QXJpYWwmcXVvdDssc2Fu
cy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjxw
IGNsYXNzPSJNc29Ob3JtYWwiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6MTIuMHB0O2ZvbnQtZmFt
aWx5OiZxdW90O0FyaWFsJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFu
PjwvcD4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9k
aXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWls
eTomcXVvdDtBcmlhbCZxdW90OyxzYW5zLXNlcmlmIj48bzpwPiZuYnNwOzwvbzpwPjwvc3Bhbj48
L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCIgc3R5bGU9Im1hcmdpbi1i
b3R0b206MTIuMHB0Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEyLjBwdDtmb250LWZhbWlseTom
cXVvdDtIZWx2ZXRpY2EmcXVvdDssc2Fucy1zZXJpZiI+PG86cD4mbmJzcDs8L286cD48L3NwYW4+
PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1z
b05vcm1hbCI+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMi4wcHQ7Zm9udC1mYW1pbHk6JnF1b3Q7
SGVsdmV0aWNhJnF1b3Q7LHNhbnMtc2VyaWYiPjxvOnA+Jm5ic3A7PC9vOnA+PC9zcGFuPjwvcD4N
CjwvZGl2Pg0KPC9kaXY+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48c3BhbiBzdHlsZT0iZm9udC1z
aXplOjEyLjBwdDtmb250LWZhbWlseTomcXVvdDtIZWx2ZXRpY2EmcXVvdDssc2Fucy1zZXJpZiI+
PG86cD4mbmJzcDs8L286cD48L3NwYW4+PC9wPg0KPC9ibG9ja3F1b3RlPg0KPC9kaXY+DQo8L2Rp
dj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiIHN0eWxlPSJtYXJnaW4tYm90dG9tOjEyLjBwdCI+PG86
cD4mbmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPC9kaXY+
DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXzxicj4NCm11bHRpcGF0aHRjcCBtYWlsaW5nIGxpc3Q8YnI+DQo8YSBocmVm
PSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3JnIiB0YXJnZXQ9Il9ibGFuayI+bXVsdGlwYXRo
dGNwQGlldGYub3JnPC9hPjxicj4NCjxhIGhyZWY9Imh0dHBzOi8vd3d3LmlldGYub3JnL21haWxt
YW4vbGlzdGluZm8vbXVsdGlwYXRodGNwIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuaWV0
Zi5vcmcvbWFpbG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3A8L2E+PG86cD48L286cD48L3A+DQo8
L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4m
bmJzcDs8L286cD48L3A+DQo8L2Rpdj4NCjwvYmxvY2txdW90ZT4NCjwvZGl2Pg0KPC9kaXY+DQo8
L2Rpdj4NCjwvYm9keT4NCjwvaHRtbD4NCg==

--===============0920719264677003087==--
