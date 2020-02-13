Content-Type: multipart/mixed; boundary="===============4127552828060051013=="
MIME-Version: 1.0
From: Yoshifumi Nishida <nsd.ietf at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [multipathtcp] RFC6824bis edits based on implementation
 feedback
Date: Thu, 13 Feb 2020 01:34:29 -0800
Message-ID: <CAAK044SQb0utvjZToU=+OCg0hB-KX6vs1bFZGsJ=tJ5WvfETog@mail.gmail.com>
In-Reply-To: F3D07C9D-12B2-45A7-B9D0-23E862DDF4BA@apple.com
X-Status: 
X-Keywords:                  
X-UID: 3641

--===============4127552828060051013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

Thanks for the clarification. It seems that there are several ways to deal
with this situation.
I think these are not ideal, but at the same time, it won't be fatal. I
think more thorough solutions can be discussed in future versions.
Given that there're several ways to address it, I guess the draft doesn't
have to specify the behavior for this.
--
Yoshi

On Tue, Feb 11, 2020 at 2:30 PM Christoph Paasch <cpaasch(a)apple.com> wrot=
e:

> +MPTCP-upstreaming
>
> On Feb 11, 2020, at 1:05 AM, Yoshifumi Nishida <nsd.ietf(a)gmail.com> wro=
te:
>
> Hi folks,
> I guess we might want to know the behavior of existing implementations
> such as linux.
>
> When an mptcp stack tries to send a data packet and find that there's no
> enough option space for data mapping, what it will do?
>
>
> iOS, multipath-tcp.org and Linux 5.6 implementation all favor the
> DSS-option over any other option (except TCP Timestamps). And TCP
> Timestamps and DSS comfortably fit in the TCP option-space.
>
> If SACK-blocks should be added, we only add SACK-blocks up to the
> remaining space. SACK is anyways opportunistic as once there are more than
> 3 blocks they don't fit either.
>
>
> Christoph
>
> Split the packet to create more option space?
> --
> Yoshi
>
> On Thu, Feb 6, 2020 at 10:10 AM V Anil Kumar <anil(a)csir4pi.in> wrote:
>
>> Hi Alan,
>>
>> Thank you for your reply. I have two points to clarify. Please see them
>> in line.
>>
>> ------------------------------
>>
>> *From: *"Alan Ford" <alan.ford(a)gmail.com>
>> *To: *"V Anil Kumar" <anil(a)csir4pi.in>jk
>> *Cc: *"Yoshifumi Nishida" <nsd.ietf(a)gmail.com>, "multipathtcp" <
>> multipathtcp(a)ietf.org>
>> *Sent: *Thursday, February 6, 2020 2:49:29 AM
>> *Subject: *Re: [multipathtcp] RFC6824bis edits based on implementation
>> feedback
>>
>> Hi Anil,
>>
>> This would not be forbidden if the mapping was carried on a pure ACK with
>> no data.
>>
>> As far as I understand, delivery of DSM through pure ACK is not in the
>> scope of the current draft. If we intend to do this, we may need an
>> approach similar to the one proposed for delivery of ADD_ADDR option in
>> pure ACK with reliability feature.  So, packing DSM on pure ACK does not
>> seem to be an option at this stage.
>>
>>
>> I do see the point here: if a packet of 1000 bytes contains 500 bytes of
>> one mapping and 500 bytes of another mapping, then only one DSM would
>> appear on one packet, leaving the mapping for the second 500 bytes to be
>> carried somewhere else - the only option being a pure ACK. But this kind=
 of
>> scenario would be extremely rare
>>
>> Yes, I do agree that the scenario you mentioned above would be extremely
>> rare. In fact, I wonder whether such a situation (i.e., need to cover the
>> bytes in a single packet with two different maps) would ever arise.
>> Probably there might be some corner cases, which I don't get it rightly
>> now.
>>
>> More importantly, the scenario that Yoshi and me are referring to is
>> totally different: the one I had given as part of my comments in response
>> to the proposed change 2. In this scenario, which you could see in the
>> trailing mail, data segment-1 is transmitted without including its map,
>> something which is permitted in the  mptcp framework (6824 bis). I make
>> this inference from the below text in 6824 bis:
>>
>> "...even if a mapping does not exist from the subflow space to the data-
>> level space, the data SHOULD still be ACKed at the subflow (if it is
>> in-window). This data cannot, however, be acknowledged at the data level
>> (Section 3.3.2) because its data sequence numbers are unknown.
>> Implementations MAY hold onto such unmapped data for a short while in the
>> expectation that a mapping will arrive shortly."
>>
>> One option the data sender has at this stage is to include the map for
>> data in segment-1, in segment-3 (please see the two-subflow example I ga=
ve
>> in response to the change 2 you had proposed). But the proposed change d=
oes
>> not permit this. What would happen to  subflow-1 in this case ?
>>
>> With regards,
>>
>> Anil
>>
>> and I would imagine any implementation would just split into two 500 byte
>> segments each with the PSH flag set. I don=E2=80=99t think we need to sp=
ell this
>> out in the spec however.
>>
>> Regards,
>> Alan
>>
>> On 5 Feb 2020, at 15:09, V Anil Kumar <anil(a)csir4pi.in> wrote:
>> Hi Yoshi,
>>
>> Please see in line.
>>
>> ------------------------------
>> *From: *"Yoshifumi Nishida" <nsd.ietf(a)gmail.com>
>> *To: *"V Anil Kumar" <anil(a)csir4pi.in>
>> *Cc: *"alan ford" <alan.ford(a)gmail.com>, "multipathtcp" <
>> multipathtcp(a)ietf.org>
>> *Sent: *Tuesday, February 4, 2020 1:08:45 PM
>> *Subject: *Re: [multipathtcp] RFC6824bis edits based on implementation
>> feedback
>>
>> Hi Anil,
>>
>> Thanks for pointing it out. I overlooked this one.
>> This looks an interesting point.
>>
>> It seems to me that whether RST is happen or not depends on the size of
>> receive window according to the text.
>> If the receive window size is big enough to accommodate segment 1 and
>> segment 3, the text "Implementations MAY hold onto such unmapped data
>> for a short while in the expectation that a mapping will arrive shortly.
>> " can be applied to the segment 1. As a result, the segment 1 won't be
>> discarded.
>>
>> *Yes.  So, segment 1 may be kept in the data receiver's buffer in
>> expectation that its mapping will arrive shortly. And in the example that
>> we are referring to, the data sender will not be able to include the map
>> for the data in segment 1 in segment 3 or any higher segment.*
>>
>> *Regards,*
>>
>> *Anil*
>>
>> However, this might be contradict with the new texts Alan proposed? Or,
>> am I missing something?
>>
>> Thanks,
>> --
>> Yoshi
>>
>>
>>
>> On Sun, Feb 2, 2020 at 8:42 AM V Anil Kumar <anil(a)csir4pi.in> wrote:
>>
>>> Hi Yoshi,
>>>
>>> Thanks for this point. In fact, I had initially not thought of a
>>> scenario, where the map is being delivered through a retransmitted data
>>> packet while its first transmission did not include the map. Now I am j=
ust
>>> seeing the document (RFC 6824-bis) in this context.
>>>
>>> My understanding is that in scenarios like what I described in my
>>> previous mail, RST is likely to happen whether we explicitly state so or
>>> not. Please see the paragraph containing the below text in RFC 6824-bis.
>>>
>>> "If a mapping for that subflow-level sequence space does not arrive
>>> within a receive window of data, that subflow SHOULD be treated as brok=
en,
>>> closed with a RST, and any unmapped data silently discarded."
>>>
>>> if we assume that the map is included while retransmitting the data
>>> (even though the first transmission did not contain the map for some
>>> reasons),  we could argue that RST could be avoided provided that the
>>> retransmission is triggered within a receive window of data. But the
>>> question here would be how and when will the retransmission take place.=
 In
>>> this case, the subflow may not initiate the retransmission of data by i=
ts
>>> own (i..e., no retransmission due to three duplicate ACKs or RTO expiry=
 at
>>> subflow level) as there is no segment loss at subflow level sequence sp=
ace.
>>> So there could be a high possibility of RST happening even before the m=
ap
>>> delivery through retransmission.
>>>
>>> With regards,
>>>
>>> Anil
>>>
>>> ------------------------------
>>> *From: *"Yoshifumi Nishida" <nsd.ietf(a)gmail.com>
>>> *To: *"V Anil Kumar" <anil(a)csir4pi.in>
>>> *Cc: *"alan ford" <alan.ford(a)gmail.com>, "multipathtcp" <
>>> multipathtcp(a)ietf.org>
>>> *Sent: *Saturday, February 1, 2020 3:39:51 AM
>>> *Subject: *Re: [multipathtcp] RFC6824bis edits based on implementation
>>> feedback
>>>
>>> Hi Anil,
>>>
>>> I have a question about your proposed text.
>>> I am actually wondering if we really want to terminate connection here.
>>>
>>> The packets without proper mappings will be treated as invalid and will
>>> be discarded.
>>> If an implementation failed to attach proper mapping for some reasons
>>> (e.g. option space), it might be able to attach the proper one when it
>>> retransmits the packets. This also looks ok to me.
>>>
>>> I don't have strong preference for this. But, do we have a reason to
>>> terminate connection?
>>>
>>> Thanks,
>>> --
>>> Yoshi
>>>
>>> On Mon, Jan 13, 2020 at 10:28 AM V Anil Kumar <anil(a)csir4pi.in> wrote:
>>>
>>>> Hi,
>>>>
>>>> I have some points related to the  modifications (Change 2) being
>>>> proposed on data sequence map. Please see them inline. Though I am
>>>> putting forward the below points, if the consensus is in favour of the
>>>> proposed change for reducing implementation complexity, I am also OK w=
ith
>>>> that as well.
>>>>
>>>> ------------------------------
>>>> *From: *"alan ford" <alan.ford(a)gmail.com>
>>>> *To: *multipathtcp(a)ietf.org
>>>> *Sent: *Thursday, January 2, 2020 4:21:32 AM
>>>> *Subject: *[multipathtcp] RFC6824bis edits based on implementation
>>>> feedback
>>>>
>>>> Hi all,
>>>> We=E2=80=99d love to get this to a state of completion as soon as poss=
ible, and
>>>> to this end I am starting a new thread on this topic. In discussion wi=
th
>>>> the chairs, it *is *possible to make the desired changes in AUTH48 as
>>>> long as there is WG consensus. The discussion so far has been fairly
>>>> limited in terms of participation.
>>>>
>>>> I would ask the chairs please if it was possible to specify a time
>>>> bound for this discussion and a default conclusion.
>>>>
>>>> Regarding the changes, in summary, there are two areas where changes
>>>> have been requested by the implementation community. As we are the IET=
F we
>>>> obviously have strong focus on =E2=80=9Crunning code=E2=80=9D and so e=
ase of implementing
>>>> standards-compliant code is strongly desirable. However, we do not wis=
h to
>>>> reduce functionality agreed by the IETF community if it is considered a
>>>> required feature by the community.
>>>>
>>>>
>>>> *Change 1*
>>>>
>>>> Change the sentence reading:
>>>>
>>>>
>>>> *   If B has data to send first, then the reliable delivery of the ACK
>>>> + MP_CAPABLE can be inferred by the receipt of this data with an MPTCP=
 Data
>>>> Sequence Signal (DSS) option (Section 3.3). *
>>>> To:
>>>>
>>>>
>>>> *   If B has data to send first, then the reliable delivery of the ACK
>>>> + MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data
>>>> Sequence Signal (DSS) option (Section 3.3) containing a DATA_ACK for t=
he
>>>> MP_CAPABLE (which is the first octet of the data sequence space).*
>>>> What this means:
>>>>
>>>> The current text is concerned only with ensuring a path is MPTCP
>>>> capable, and so only cares that DSS option occurs on a data packet.
>>>> However, the MP_CAPABLE option is defined to occupy the first octet of=
 data
>>>> sequence space and thus, if analogous to TCP, must be acknowledged. >F=
rom
>>>> an implementation point of view it would make sense not to have this
>>>> hanging around forever and instead define it is acknowledged at the
>>>> connection level as soon as received. This change ensures the first da=
ta
>>>> packet also DATA_ACKs this MP_CAPABLE octet.
>>>>
>>>>
>>>> *Change 2*
>>>>
>>>> Change the sentence reading:
>>>>
>>>> *   A Data Sequence Mapping does not need to be included in every MPTCP
>>>> packet, as long as the subflow sequence space in that packet is covere=
d by
>>>> a mapping known at the receiver.*
>>>>
>>>> To:
>>>>
>>>>
>>>> *   The mapping provided by a Data Sequence Mapping MUST apply to some
>>>> or all of the subflow sequence space in the TCP segment which carries =
the
>>>> option. It does not need to be included in every MPTCP packet, as long=
 as
>>>> the subflow sequence space in that packet is covered by a mapping know=
n at
>>>> the receiver.*
>>>> What this means:
>>>>
>>>> The current text does not place any restrictions on where a mapping
>>>> could appear. In theory a sender could define a thousand different map=
pings
>>>> up front, send them all, and expect a receiver to store this and reass=
emble
>>>> data according to these mappings as it arrives. Indeed, this was never
>>>> explicitly disallowed since it =E2=80=9Cmight have been useful=E2=80=
=9D. The implementation
>>>> community, however, has expressed concerns over the difficulty of
>>>> implementing this open-endedly. How many mappings is it reasonable to
>>>> store? Is there a DoS risk here? Instead, it has been requested that t=
hee
>>>> specification restricts the placement of the DSS option to being withi=
n the
>>>> subflow sequence space to which it applies.
>>>>
>>>> Below are my comments on this. I had shared some of these points in a
>>>> previous thread that you had initiated in the same context.
>>>>
>>>> Transmitting large number of non-contiguous data sequence maps could be
>>>> a misbehaviour (map-flooding), though it is not clear whether this can=
 go
>>>> to the extent of causing a potential DoS to the data receiver. So some=
 sort
>>>> of restriction on this could be useful.  One approach could be to insi=
st
>>>> that the data sender should ensure that the map being transmitted is f=
or
>>>> in-window data, as per the receiver advertised window. A receiver shou=
ld
>>>> anyhow be willing to store the maps for in-window data to deal with pa=
cket
>>>> loss. For example, when a window of data segments (say 1 to 64) is
>>>> transmitted, each carrying its corresponding map, and segment-1 is los=
t,
>>>> the maps for the remaining 63 need to be stored till the lost segment =
is
>>>> retransmitted. Of course, in this case the maps will be stored at the
>>>> receiver side along with their corresponding data. But the need to sto=
re
>>>> multiple maps for in-window data would still be there.
>>>>
>>>> The problem with the proposed change (restriction) is that a data
>>>> sender may find it difficult, in case a need arise to slightly delay t=
he
>>>> map delivery by few segments, i.e., sending some data first without ma=
p,
>>>> and then send the corresponding map in a later segment, as shown below:
>>>>
>>>> subflow-1:      segment-1                   segment-3
>>>>   segment-4                       segment-7
>>>>                       bytes:1-100                 bytes:201-300
>>>>      bytes:301-400                 bytes:601-700
>>>>                       no map                        map for 1-100
>>>>        map for 201-400             map for 601-700
>>>>
>>>>
>>>>
>>>> subflow-2:       segment-2                  segment-5
>>>>   segment-6                       segment-8
>>>>                        bytes: 101-200           bytes:401-500
>>>>         bytes: 501-600                bytes:701-800
>>>>                        map for 101-200       map for 401-600
>>>>  no map                            map for 701-800
>>>>
>>>>
>>>> In the above case, segment-1 goes without map and its map is included
>>>> later in segment-3, the next data segment in the same subflow. Further=
,  in
>>>> the above scheduling pattern, the map in segment-3 cannot cover the  d=
ata
>>>> in segment-1 and segment-3, as some  data in between (segment-2) is
>>>> transmitted through another subflow.  With the proposed change, the ma=
p in
>>>> segment-3 will become invalid and this will eventually break subflow-1,
>>>> though this could be a corner case..
>>>>
>>>> The question at this stage is why would segment-1 be transmitted
>>>> without its map. In the case of bidirectional data transfer, there cou=
ld be
>>>> a need to pack both timestamp and SACK  options in a data segment, i.e=
.,
>>>> piggybacking of  SACK with data. If we consider that timestamp takes 12
>>>> bytes and SACK, even with single block,  takes another 10 bytes, the
>>>> remaining 18 bytes option space is not adequate to carry data sequence
>>>> signal with map, especially when DSN is 64 bit long. So the delivery of
>>>> either of the two (SACK or map) would be delayed.
>>>>
>>>> As far as I understand, RFC 2018 (TCP Selective Acknowledgement
>>>> Options) implies that SACK should not be delayed. It states "If sent at
>>>> all, SACK options SHOULD be included in all ACKs which do not ACK the
>>>> highest sequence number in the data receiver's queue". It also says "If
>>>> data receiver generates SACK options under any circumstance, it SHOULD
>>>> generate them under all permitted circumstances".   So, as part of mee=
ting
>>>> the RFC 2018 requirements, if the combination of SACK and timestamp is
>>>> given preference over DSS, data segments could be transmitted without =
their
>>>> map.
>>>>
>>>> Another case of delaying map could arise if the data sender prefers to
>>>> send ADD_ADDR option, instead of map, in a data segment. It is nice th=
at
>>>> ADD_ADDR option can be delivered reliably in a pure ACK, but I think t=
his
>>>> is not the case with DSS at present.
>>>>
>>>> If we adopt the proposed change, I think it might also be helpful to
>>>> spell out how the receiver is supposed to behave, if it gets maps not
>>>> meeting the MUST condition in the proposed change.  For example termin=
ation
>>>> of the subflow with MP_TCPRST option (section 3.6 in RFC 6824-bis) with
>>>> appropriate reason code and T flag value to intimate the data sender t=
he
>>>> cause for subflow termination.
>>>>
>>>> With regards,
>>>>
>>>> Anil
>>>>
>>>> Please can members of the WG express whether they are happy with these
>>>> changes, or concerned.
>>>>
>>>> Best regards,
>>>> Alan
>>>>
>>>>
>>>> _______________________________________________
>>>> multipathtcp mailing list
>>>> multipathtcp(a)ietf.org
>>>> https://www.ietf.org/mailman/listinfo/multipathtcp
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> multipathtcp mailing list
>>>> multipathtcp(a)ietf.org
>>>> https://www.ietf.org/mailman/listinfo/multipathtcp
>>>>
>>>
>>>
>>>
>>
>>
>>
>>
>>
>>
>> _______________________________________________
> multipathtcp mailing list
> multipathtcp(a)ietf.org
> https://www.ietf.org/mailman/listinfo/multipathtcp
>
>
>

--===============4127552828060051013==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgQ2hyaXN0b3BoLDxicj48L2Rpdj48ZGl2
IGRpcj0ibHRyIj48YnI+PC9kaXY+PGRpdj5UaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJ
dCBzZWVtcyB0aGF0IHRoZXJlIGFyZSBzZXZlcmFsIHdheXMgdG8gZGVhbCB3aXRoIHRoaXMgc2l0
dWF0aW9uLsKgPC9kaXY+PGRpdj5JIHRoaW5rIHRoZXNlIGFyZSBub3QgaWRlYWwsIGJ1dCBhdCB0
aGUgc2FtZSB0aW1lLCBpdCB3b24mIzM5O3QgYmUgZmF0YWwuIEkgdGhpbmsgbW9yZSB0aG9yb3Vn
aCBzb2x1dGlvbnMgY2FuIGJlIGRpc2N1c3NlZCBpbiBmdXR1cmUgdmVyc2lvbnMuwqA8L2Rpdj48
ZGl2PkdpdmVuIHRoYXQgdGhlcmUmIzM5O3JlIHNldmVyYWwgd2F5cyB0byBhZGRyZXNzIGl0LCBJ
IGd1ZXNzIHRoZSBkcmFmdCBkb2VzbiYjMzk7dCBoYXZlIHRvIHNwZWNpZnkgdGhlIGJlaGF2aW9y
IGZvciB0aGlzLsKgPC9kaXY+PGRpdj4tLTwvZGl2PjxkaXY+WW9zaGk8L2Rpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBU
dWUsIEZlYiAxMSwgMjAyMCBhdCAyOjMwIFBNIENocmlzdG9waCBQYWFzY2ggJmx0OzxhIGhyZWY9
Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSI+Y3BhYXNjaEBhcHBsZS5jb208L2E+Jmd0OyB3cm90
ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2lu
OjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQp
O3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgc3R5bGU9Im92ZXJmbG93LXdyYXA6IGJyZWFrLXdvcmQ7
Ij4rTVBUQ1AtdXBzdHJlYW1pbmc8YnI+PGRpdj48YnI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
PGRpdj5PbiBGZWIgMTEsIDIwMjAsIGF0IDE6MDUgQU0sIFlvc2hpZnVtaSBOaXNoaWRhICZsdDs8
YSBocmVmPSJtYWlsdG86bnNkLmlldGZAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+bnNkLmll
dGZAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PC9kaXY+PGJyPjxkaXY+PGRpdiBkaXI9Imx0ciI+
PGRpdj5IaSBmb2xrcyw8L2Rpdj48ZGl2PkkgZ3Vlc3Mgd2UgbWlnaHQgd2FudCB0byBrbm93IHRo
ZSBiZWhhdmlvciBvZiBleGlzdGluZyBpbXBsZW1lbnRhdGlvbnMgc3VjaCBhcyBsaW51eC48L2Rp
dj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+PGRpdj48
ZGl2IGRpcj0ibHRyIj48ZGl2PldoZW4gYW4gbXB0Y3Agc3RhY2sgdHJpZXMgdG8gc2VuZCBhIGRh
dGEgcGFja2V0IGFuZCBmaW5kIHRoYXQgdGhlcmUmIzM5O3Mgbm8gZW5vdWdoIG9wdGlvbiBzcGFj
ZSBmb3IgZGF0YSBtYXBwaW5nLCB3aGF0IGl0IHdpbGwgZG8/PC9kaXY+PC9kaXY+PC9kaXY+PC9i
bG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+aU9TLCA8YSBocmVmPSJodHRwOi8vbXVsdGlw
YXRoLXRjcC5vcmciIHRhcmdldD0iX2JsYW5rIj5tdWx0aXBhdGgtdGNwLm9yZzwvYT7CoGFuZCBM
aW51eCA1LjYgaW1wbGVtZW50YXRpb24gYWxsIGZhdm9yIHRoZSBEU1Mtb3B0aW9uIG92ZXIgYW55
IG90aGVyIG9wdGlvbiAoZXhjZXB0IFRDUCBUaW1lc3RhbXBzKS4gQW5kIFRDUCBUaW1lc3RhbXBz
IGFuZCBEU1MgY29tZm9ydGFibHkgZml0IGluIHRoZSBUQ1Agb3B0aW9uLXNwYWNlLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SWYgU0FDSy1ibG9ja3Mgc2hvdWxkIGJlIGFkZGVkLCB3ZSBvbmx5
IGFkZCBTQUNLLWJsb2NrcyB1cCB0byB0aGUgcmVtYWluaW5nIHNwYWNlLiBTQUNLIGlzIGFueXdh
eXMgb3Bwb3J0dW5pc3RpYyBhcyBvbmNlIHRoZXJlIGFyZSBtb3JlIHRoYW4gMyBibG9ja3MgdGhl
eSBkb24mIzM5O3QgZml0IGVpdGhlci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PkNocmlzdG9waDwvZGl2Pjxicj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIj48ZGl2Pjxk
aXYgZGlyPSJsdHIiPjxkaXY+U3BsaXQgdGhlIHBhY2tldCB0byBjcmVhdGUgbW9yZSBvcHRpb24g
c3BhY2U/PC9kaXY+PGRpdj4tLTxicj48L2Rpdj48ZGl2Pllvc2hpPC9kaXY+PGJyPjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVGh1
LCBGZWIgNiwgMjAyMCBhdCAxMDoxMCBBTSBWIEFuaWwgS3VtYXIgJmx0OzxhIGhyZWY9Im1haWx0
bzphbmlsQGNzaXI0cGkuaW4iIHRhcmdldD0iX2JsYW5rIj5hbmlsQGNzaXI0cGkuaW48L2E+Jmd0
OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGRpdj48ZGl2PkhpIEFsYW4sPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5UaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuIEkgaGF2ZSB0d28gcG9p
bnRzIHRvIGNsYXJpZnkuIFBsZWFzZSBzZWUgdGhlbSBpbiBsaW5lLjwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxociBpZD0iZ21haWwtbV8tNTQwNjU0MzU1NjczNzcyMjAxZ21haWwtbV84NzczMzU3NDM5
Nzc3MDgxNTkwendjaHIiPjxkaXY+PGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlci1sZWZ0OjJweCBz
b2xpZCByZ2IoMTYsMTYsMjU1KTttYXJnaW4tbGVmdDo1cHg7cGFkZGluZy1sZWZ0OjVweDtmb250
LXdlaWdodDpub3JtYWw7Zm9udC1zdHlsZTpub3JtYWw7dGV4dC1kZWNvcmF0aW9uOm5vbmU7Zm9u
dC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQiPjxiPkZy
b206IDwvYj4mcXVvdDtBbGFuIEZvcmQmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFuLmZv
cmRAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7
PGJyPjxiPlRvOiA8L2I+JnF1b3Q7ViBBbmlsIEt1bWFyJnF1b3Q7ICZsdDs8YSBocmVmPSJtYWls
dG86YW5pbEBjc2lyNHBpLmluIiB0YXJnZXQ9Il9ibGFuayI+YW5pbEBjc2lyNHBpLmluPC9hPiZn
dDtqa8KgPGJyPjxiPkNjOiA8L2I+JnF1b3Q7WW9zaGlmdW1pIE5pc2hpZGEmcXVvdDsgJmx0Ozxh
IGhyZWY9Im1haWx0bzpuc2QuaWV0ZkBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5uc2QuaWV0
ZkBnbWFpbC5jb208L2E+Jmd0OywgJnF1b3Q7bXVsdGlwYXRodGNwJnF1b3Q7ICZsdDs8YSBocmVm
PSJtYWlsdG86bXVsdGlwYXRodGNwQGlldGYub3JnIiB0YXJnZXQ9Il9ibGFuayI+bXVsdGlwYXRo
dGNwQGlldGYub3JnPC9hPiZndDs8YnI+PGI+U2VudDogPC9iPlRodXJzZGF5LCBGZWJydWFyeSA2
LCAyMDIwIDI6NDk6MjkgQU08YnI+PGI+U3ViamVjdDogPC9iPlJlOiBbbXVsdGlwYXRodGNwXSBS
RkM2ODI0YmlzIGVkaXRzIGJhc2VkIG9uIGltcGxlbWVudGF0aW9uIGZlZWRiYWNrPGJyPjwvYmxv
Y2txdW90ZT48L2Rpdj48ZGl2PjxibG9ja3F1b3RlIHN0eWxlPSJib3JkZXItbGVmdDoycHggc29s
aWQgcmdiKDE2LDE2LDI1NSk7bWFyZ2luLWxlZnQ6NXB4O3BhZGRpbmctbGVmdDo1cHg7Zm9udC13
ZWlnaHQ6bm9ybWFsO2ZvbnQtc3R5bGU6bm9ybWFsO3RleHQtZGVjb3JhdGlvbjpub25lO2ZvbnQt
ZmFtaWx5OkhlbHZldGljYSxBcmlhbCxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMnB0Ij5IaSBBbmls
LDxkaXY+PGJyPjwvZGl2PjxkaXY+VGhpcyB3b3VsZCBub3QgYmUgZm9yYmlkZGVuIGlmIHRoZSBt
YXBwaW5nIHdhcyBjYXJyaWVkIG9uIGEgcHVyZSBBQ0sgd2l0aCBubyBkYXRhLjwvZGl2PjwvYmxv
Y2txdW90ZT48ZGl2PkFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIGRlbGl2ZXJ5IG9mIERTTSB0aHJv
dWdoIHB1cmUgQUNLIGlzIG5vdCBpbiB0aGUgc2NvcGUgb2YgdGhlIGN1cnJlbnQgZHJhZnQuIElm
IHdlIGludGVuZCB0byBkbyB0aGlzLCB3ZSBtYXkgbmVlZCBhbiBhcHByb2FjaCBzaW1pbGFyIHRv
IHRoZSBvbmUgcHJvcG9zZWQgZm9yIGRlbGl2ZXJ5IG9mIEFERF9BRERSIG9wdGlvbiBpbiBwdXJl
IEFDSyB3aXRoIHJlbGlhYmlsaXR5IGZlYXR1cmUuwqAgU28sIHBhY2tpbmcgRFNNIG9uIHB1cmUg
QUNLIGRvZXMgbm90IHNlZW0gdG8gYmUgYW4gb3B0aW9uIGF0IHRoaXMgc3RhZ2UuPC9kaXY+PGJs
b2NrcXVvdGUgc3R5bGU9ImJvcmRlci1sZWZ0OjJweCBzb2xpZCByZ2IoMTYsMTYsMjU1KTttYXJn
aW4tbGVmdDo1cHg7cGFkZGluZy1sZWZ0OjVweDtmb250LXdlaWdodDpub3JtYWw7Zm9udC1zdHls
ZTpub3JtYWw7dGV4dC1kZWNvcmF0aW9uOm5vbmU7Zm9udC1mYW1pbHk6SGVsdmV0aWNhLEFyaWFs
LHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQiPjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBkbyBzZWUg
dGhlIHBvaW50IGhlcmU6IGlmIGEgcGFja2V0IG9mIDEwMDAgYnl0ZXMgY29udGFpbnMgNTAwIGJ5
dGVzIG9mIG9uZSBtYXBwaW5nIGFuZCA1MDAgYnl0ZXMgb2YgYW5vdGhlciBtYXBwaW5nLCB0aGVu
IG9ubHkgb25lIERTTSB3b3VsZCBhcHBlYXIgb24gb25lIHBhY2tldCwgbGVhdmluZyB0aGUgbWFw
cGluZyBmb3IgdGhlIHNlY29uZCA1MDAgYnl0ZXMgdG8gYmUgY2FycmllZCBzb21ld2hlcmUgZWxz
ZSAtIHRoZSBvbmx5IG9wdGlvbiBiZWluZyBhIHB1cmUgQUNLLiBCdXQgdGhpcyBraW5kIG9mIHNj
ZW5hcmlvIHdvdWxkIGJlIGV4dHJlbWVseSByYXJlPC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+WWVz
LCBJIGRvIGFncmVlIHRoYXQgdGhlIHNjZW5hcmlvIHlvdSBtZW50aW9uZWQgYWJvdmUgd291bGQg
YmUgZXh0cmVtZWx5IHJhcmUuIEluIGZhY3QsIEkgd29uZGVyIHdoZXRoZXIgc3VjaCBhIHNpdHVh
dGlvbiAoaS5lLiwgbmVlZCB0byBjb3ZlciB0aGUgYnl0ZXMgaW4gYSBzaW5nbGUgcGFja2V0IHdp
dGggdHdvIGRpZmZlcmVudCBtYXBzKSB3b3VsZCBldmVyIGFyaXNlLiBQcm9iYWJseSB0aGVyZSBt
aWdodCBiZSBzb21lIGNvcm5lciBjYXNlcywgd2hpY2ggSSBkb24mIzM5O3QgZ2V0IGl0IHJpZ2h0
bHkgbm93LsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Nb3JlIGltcG9ydGFudGx5LCB0aGUg
c2NlbmFyaW8gdGhhdCBZb3NoaSBhbmQgbWUgYXJlIHJlZmVycmluZyB0byBpcyB0b3RhbGx5IGRp
ZmZlcmVudDogdGhlIG9uZSBJIGhhZCBnaXZlbiBhcyBwYXJ0IG9mIG15IGNvbW1lbnRzIGluIHJl
c3BvbnNlIHRvIHRoZSBwcm9wb3NlZCBjaGFuZ2UgMi4gSW4gdGhpcyBzY2VuYXJpbywgd2hpY2gg
eW91IGNvdWxkIHNlZSBpbiB0aGUgdHJhaWxpbmcgbWFpbCwgZGF0YSBzZWdtZW50LTEgaXMgdHJh
bnNtaXR0ZWQgd2l0aG91dCBpbmNsdWRpbmcgaXRzIG1hcCwgc29tZXRoaW5nIHdoaWNoIGlzIHBl
cm1pdHRlZCBpbiB0aGUgwqBtcHRjcCBmcmFtZXdvcmsgKDY4MjQgYmlzKS4gSSBtYWtlIHRoaXMg
aW5mZXJlbmNlIGZyb20gdGhlIGJlbG93IHRleHQgaW4gNjgyNCBiaXM6PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj4gJnF1b3Q7Li4uZXZlbiBpZiBhIG1hcHBpbmcgZG9lcyBub3QgZXhpc3QgZnJv
bSB0aGUgc3ViZmxvdyBzcGFjZSB0byB0aGUgZGF0YS0gbGV2ZWwgc3BhY2UsIHRoZSBkYXRhIFNI
T1VMRCBzdGlsbCBiZSBBQ0tlZCBhdCB0aGUgc3ViZmxvdyAoaWYgaXQgaXMgaW4td2luZG93KS4g
VGhpcyBkYXRhIGNhbm5vdCwgaG93ZXZlciwgYmUgYWNrbm93bGVkZ2VkIGF0IHRoZSBkYXRhIGxl
dmVsIChTZWN0aW9uIDMuMy4yKSBiZWNhdXNlIGl0cyBkYXRhIHNlcXVlbmNlIG51bWJlcnMgYXJl
IHVua25vd24uIEltcGxlbWVudGF0aW9ucyBNQVkgaG9sZCBvbnRvIHN1Y2ggdW5tYXBwZWQgZGF0
YSBmb3IgYSBzaG9ydCB3aGlsZSBpbiB0aGUgZXhwZWN0YXRpb24gdGhhdCBhIG1hcHBpbmcgd2ls
bCBhcnJpdmUgc2hvcnRseS4mcXVvdDsgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PbmUgb3B0
aW9uIHRoZSBkYXRhIHNlbmRlciBoYXMgYXQgdGhpcyBzdGFnZSBpcyB0byBpbmNsdWRlIHRoZSBt
YXAgZm9yIGRhdGEgaW4gc2VnbWVudC0xLCBpbiBzZWdtZW50LTMgKHBsZWFzZSBzZWUgdGhlIHR3
by1zdWJmbG93IGV4YW1wbGUgSSBnYXZlIGluIHJlc3BvbnNlIHRvIHRoZSBjaGFuZ2UgMiB5b3Ug
aGFkIHByb3Bvc2VkKS4gQnV0IHRoZSBwcm9wb3NlZCBjaGFuZ2UgZG9lcyBub3QgcGVybWl0IHRo
aXMuIFdoYXQgd291bGQgaGFwcGVuIHRvIMKgc3ViZmxvdy0xIGluIHRoaXMgY2FzZSA/PC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5XaXRoIHJlZ2FyZHMsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5BbmlsIMKgIMKgPC9kaXY+PGJsb2NrcXVvdGUgc3R5bGU9ImJvcmRlci1sZWZ0OjJweCBzb2xp
ZCByZ2IoMTYsMTYsMjU1KTttYXJnaW4tbGVmdDo1cHg7cGFkZGluZy1sZWZ0OjVweDtmb250LXdl
aWdodDpub3JtYWw7Zm9udC1zdHlsZTpub3JtYWw7dGV4dC1kZWNvcmF0aW9uOm5vbmU7Zm9udC1m
YW1pbHk6SGVsdmV0aWNhLEFyaWFsLHNhbnMtc2VyaWY7Zm9udC1zaXplOjEycHQiPjxkaXY+YW5k
IEkgd291bGQgaW1hZ2luZSBhbnkgaW1wbGVtZW50YXRpb24gd291bGQganVzdCBzcGxpdCBpbnRv
IHR3byA1MDAgYnl0ZSBzZWdtZW50cyBlYWNoIHdpdGggdGhlIFBTSCBmbGFnIHNldC4gSSBkb27i
gJl0IHRoaW5rIHdlIG5lZWQgdG8gc3BlbGwgdGhpcyBvdXQgaW4gdGhlIHNwZWMgaG93ZXZlci48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj5BbGFuPGJyPjxkaXY+
PGRpdj48YnI+PGJsb2NrcXVvdGU+PGRpdj5PbiA1IEZlYiAyMDIwLCBhdCAxNTowOSwgViBBbmls
IEt1bWFyICZsdDs8YSBocmVmPSJtYWlsdG86YW5pbEBjc2lyNHBpLmluIiByZWw9Im5vZm9sbG93
IG5vb3BlbmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5hbmlsQGNzaXI0cGkuaW48L2E+
Jmd0OyB3cm90ZTo8L2Rpdj48ZGl2PjxkaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWws
aGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxkaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWws
aGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxkaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWws
aGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxkaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWws
aGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxkaXY+SGkgWW9zaGksPC9kaXY+PGJyPjxkaXY+UGxlYXNl
IHNlZSBpbiBsaW5lLjwvZGl2Pjxicj48aHIgaWQ9ImdtYWlsLW1fLTU0MDY1NDM1NTY3Mzc3MjIw
MWdtYWlsLW1fODc3MzM1NzQzOTc3NzA4MTU5MHp3Y2hyIj48ZGl2PjxiPkZyb206IDwvYj4mcXVv
dDtZb3NoaWZ1bWkgTmlzaGlkYSZxdW90OyAmbHQ7PGEgaHJlZj0ibWFpbHRvOm5zZC5pZXRmQGdt
YWlsLmNvbSIgcmVsPSJub2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFu
ayI+bnNkLmlldGZAZ21haWwuY29tPC9hPiZndDs8YnI+PGI+VG86IDwvYj4mcXVvdDtWIEFuaWwg
S3VtYXImcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iIHJlbD0ibm9m
b2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsiPmFuaWxAY3NpcjRwaS5p
bjwvYT4mZ3Q7PGJyPjxiPkNjOiA8L2I+JnF1b3Q7YWxhbiBmb3JkJnF1b3Q7ICZsdDs8YSBocmVm
PSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgcmVsPSJub2ZvbGxvdyBub29wZW5lciBub3Jl
ZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7LCAmcXVv
dDttdWx0aXBhdGh0Y3AmcXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0
Zi5vcmciIHJlbD0ibm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
Pm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT4mZ3Q7PGJyPjxiPlNlbnQ6IDwvYj5UdWVzZGF5LCBG
ZWJydWFyeSA0LCAyMDIwIDE6MDg6NDUgUE08YnI+PGI+U3ViamVjdDogPC9iPlJlOiBbbXVsdGlw
YXRodGNwXSBSRkM2ODI0YmlzIGVkaXRzIGJhc2VkIG9uIGltcGxlbWVudGF0aW9uIGZlZWRiYWNr
PGJyPjwvZGl2Pjxicj48ZGl2PjxkaXYgZGlyPSJsdHIiPjxkaXYgZGlyPSJsdHIiPjxkaXYgZGly
PSJsdHIiPjxkaXY+SGkgQW5pbCw8L2Rpdj48YnI+PGRpdj5UaGFua3MgZm9yIHBvaW50aW5nIGl0
IG91dC4gSSBvdmVybG9va2VkIHRoaXMgb25lLjwvZGl2PjxkaXY+VGhpcyBsb29rcyBhbiBpbnRl
cmVzdGluZyBwb2ludC48YnI+PC9kaXY+PGJyPjxkaXY+SXQgc2VlbXMgdG8gbWUgdGhhdCB3aGV0
aGVyIFJTVCBpcyBoYXBwZW4gb3Igbm90IGRlcGVuZHMgb24gdGhlIHNpemUgb2YgcmVjZWl2ZSB3
aW5kb3cgYWNjb3JkaW5nIHRvIHRoZSB0ZXh0Ljxicj48L2Rpdj48ZGl2PklmIHRoZSByZWNlaXZl
IHdpbmRvdyBzaXplIGlzIGJpZyBlbm91Z2ggdG8gYWNjb21tb2RhdGXCoHNlZ21lbnQgMSBhbmQg
c2VnbWVudCAzLCB0aGUgdGV4dCAmcXVvdDs8c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzLjMzMzNw
eCI+SW1wbGVtZW50YXRpb25zIE1BWSBob2xkIG9udG8gc3VjaCB1bm1hcHBlZCBkYXRhIGZvciBh
IHNob3J0IHdoaWxlIGluwqA8L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtc2l6ZToxMy4zMzMzcHgi
PnRoZSBleHBlY3RhdGlvbiB0aGF0IGEgbWFwcGluZyB3aWxsIGFycml2ZSBzaG9ydGx5LiAmcXVv
dDvCoDwvc3Bhbj5jYW4gYmUgYXBwbGllZCB0byB0aGUgc2VnbWVudCAxLiBBcyBhIHJlc3VsdCwg
dGhlIHNlZ21lbnQgMSB3b24mIzM5O3QgYmUgZGlzY2FyZGVkLsKgPC9kaXY+PGJyPjxkaXY+PGVt
Plllcy7CoCBTbywgc2VnbWVudCAxIG1heSBiZSBrZXB0IGluIHRoZSBkYXRhIHJlY2VpdmVyJiMz
OTtzIGJ1ZmZlciBpbiBleHBlY3RhdGlvbiB0aGF0IGl0cyBtYXBwaW5nIHdpbGwgYXJyaXZlIHNo
b3J0bHkuIEFuZCBpbiB0aGUgZXhhbXBsZSB0aGF0IHdlIGFyZSByZWZlcnJpbmcgdG8sIHRoZSBk
YXRhIHNlbmRlciB3aWxsIG5vdCBiZSBhYmxlIHRvIGluY2x1ZGUgdGhlIG1hcCBmb3IgdGhlIGRh
dGEgaW4gc2VnbWVudCAxIGluIHNlZ21lbnQgMyBvciBhbnkgaGlnaGVyIHNlZ21lbnQuPC9lbT48
L2Rpdj48YnI+PGRpdj48ZW0+UmVnYXJkcyw8L2VtPjwvZGl2Pjxicj48ZGl2PjxlbT5BbmlsPC9l
bT48L2Rpdj48YnI+PGRpdj5Ib3dldmVyLCB0aGlzIG1pZ2h0IGJlIGNvbnRyYWRpY3Qgd2l0aCB0
aGUgbmV3IHRleHRzIEFsYW4gcHJvcG9zZWQ/IE9yLCBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPzwv
ZGl2Pjxicj48ZGl2PlRoYW5rcyw8L2Rpdj48ZGl2Pi0tPC9kaXY+PGRpdj5Zb3NoaTwvZGl2Pjxi
cj48YnI+PGJyPjxkaXY+PGRpdiBkaXI9Imx0ciI+T24gU3VuLCBGZWIgMiwgMjAyMCBhdCA4OjQy
IEFNIFYgQW5pbCBLdW1hciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuaWxAY3NpcjRwaS5pbiIgcmVs
PSJub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIl
MjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxv
dyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0
YXJnZXQ9Il9ibGFuayI+YW5pbEBjc2lyNHBpLmluPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2Pjxi
bG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6
MWV4Ij48ZGl2PjxkaXY+PGRpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRp
Y2Esc2Fucy1zZXJpZiI+PGRpdj5IaSBZb3NoaSw8L2Rpdj48YnI+PGRpdj5UaGFua3MgZm9yIHRo
aXMgcG9pbnQuIEluIGZhY3QsIEkgaGFkIGluaXRpYWxseSBub3QgdGhvdWdodCBvZiBhIHNjZW5h
cmlvLCB3aGVyZSB0aGUgbWFwIGlzIGJlaW5nIGRlbGl2ZXJlZCB0aHJvdWdoIGEgcmV0cmFuc21p
dHRlZCBkYXRhIHBhY2tldCB3aGlsZSBpdHMgZmlyc3QgdHJhbnNtaXNzaW9uIGRpZCBub3QgaW5j
bHVkZSB0aGUgbWFwLiBOb3cgSSBhbSBqdXN0IHNlZWluZyB0aGUgZG9jdW1lbnQgKFJGQyA2ODI0
LWJpcykgaW4gdGhpcyBjb250ZXh0LjwvZGl2Pjxicj48ZGl2Pk15IHVuZGVyc3RhbmRpbmcgaXMg
dGhhdCBpbiBzY2VuYXJpb3MgbGlrZSB3aGF0IEkgZGVzY3JpYmVkIGluIG15IHByZXZpb3VzIG1h
aWwsIFJTVCBpcyBsaWtlbHkgdG8gaGFwcGVuIHdoZXRoZXIgd2UgZXhwbGljaXRseSBzdGF0ZSBz
byBvciBub3QuIFBsZWFzZSBzZWUgdGhlIHBhcmFncmFwaCBjb250YWluaW5nIHRoZSBiZWxvdyB0
ZXh0IGluIFJGQyA2ODI0LWJpcy4gwqA8L2Rpdj48YnI+PGRpdj4mcXVvdDtJZiBhIG1hcHBpbmcg
Zm9yIHRoYXQgc3ViZmxvdy1sZXZlbCBzZXF1ZW5jZSBzcGFjZSBkb2VzIG5vdCBhcnJpdmUgd2l0
aGluIGEgcmVjZWl2ZSB3aW5kb3cgb2YgZGF0YSwgdGhhdCBzdWJmbG93IFNIT1VMRCBiZSB0cmVh
dGVkIGFzIGJyb2tlbiwgY2xvc2VkIHdpdGggYSBSU1QsIGFuZCBhbnkgdW5tYXBwZWQgZGF0YSBz
aWxlbnRseSBkaXNjYXJkZWQuJnF1b3Q7PC9kaXY+PGJyPjxkaXY+aWYgd2UgYXNzdW1lIHRoYXQg
dGhlIG1hcCBpcyBpbmNsdWRlZCB3aGlsZSByZXRyYW5zbWl0dGluZyB0aGUgZGF0YSAoZXZlbiB0
aG91Z2ggdGhlIGZpcnN0IHRyYW5zbWlzc2lvbiBkaWQgbm90IGNvbnRhaW4gdGhlIG1hcCBmb3Ig
c29tZSByZWFzb25zKSwgwqB3ZSBjb3VsZCBhcmd1ZSB0aGF0IFJTVCBjb3VsZCBiZSBhdm9pZGVk
IHByb3ZpZGVkIHRoYXQgdGhlIHJldHJhbnNtaXNzaW9uIGlzIHRyaWdnZXJlZCB3aXRoaW4gYSBy
ZWNlaXZlIHdpbmRvdyBvZiBkYXRhLiBCdXQgdGhlIHF1ZXN0aW9uIGhlcmUgd291bGQgYmUgaG93
IGFuZCB3aGVuIHdpbGwgdGhlIHJldHJhbnNtaXNzaW9uIHRha2UgcGxhY2UuIEluIHRoaXMgY2Fz
ZSwgdGhlIHN1YmZsb3cgbWF5IG5vdCBpbml0aWF0ZSB0aGUgcmV0cmFuc21pc3Npb24gb2YgZGF0
YSBieSBpdHMgb3duIChpLi5lLiwgbm8gcmV0cmFuc21pc3Npb24gZHVlIHRvIHRocmVlIGR1cGxp
Y2F0ZSBBQ0tzIG9yIFJUTyBleHBpcnkgYXQgc3ViZmxvdyBsZXZlbCkgYXMgdGhlcmUgaXMgbm8g
c2VnbWVudCBsb3NzIGF0IHN1YmZsb3cgbGV2ZWwgc2VxdWVuY2Ugc3BhY2UuIFNvIHRoZXJlIGNv
dWxkIGJlIGEgaGlnaCBwb3NzaWJpbGl0eSBvZiBSU1QgaGFwcGVuaW5nIGV2ZW4gYmVmb3JlIHRo
ZSBtYXAgZGVsaXZlcnkgdGhyb3VnaCByZXRyYW5zbWlzc2lvbi7CoDwvZGl2Pjxicj48ZGl2Pldp
dGggcmVnYXJkcyzCoDwvZGl2Pjxicj48ZGl2PkFuaWw8L2Rpdj48ZGl2PsKgPC9kaXY+PGhyIGlk
PSJnbWFpbC1tXy01NDA2NTQzNTU2NzM3NzIyMDFnbWFpbC1tXzg3NzMzNTc0Mzk3NzcwODE1OTBn
bWFpbC1tXzIxODA4NjU5Njk1MTcyNDUwMWdtYWlsLW1fMjk4MjI2NzAzMzU3NzkwMjk4NXp3Y2hy
Ij48ZGl2PjxiPkZyb206IDwvYj4mcXVvdDtZb3NoaWZ1bWkgTmlzaGlkYSZxdW90OyAmbHQ7PGEg
aHJlZj0ibWFpbHRvOm5zZC5pZXRmQGdtYWlsLmNvbSIgcmVsPSJub2ZvbGxvdyUyMG5vb3BlbmVy
JTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xs
b3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciBub2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+bnNkLmll
dGZAZ21haWwuY29tPC9hPiZndDs8YnI+PGI+VG86IDwvYj4mcXVvdDtWIEFuaWwgS3VtYXImcXVv
dDsgJmx0OzxhIGhyZWY9Im1haWx0bzphbmlsQGNzaXI0cGkuaW4iIHJlbD0ibm9mb2xsb3clMjBu
b29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUy
MG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUy
MG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJfYmxhbmsi
PmFuaWxAY3NpcjRwaS5pbjwvYT4mZ3Q7PGJyPjxiPkNjOiA8L2I+JnF1b3Q7YWxhbiBmb3JkJnF1
b3Q7ICZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgcmVsPSJub2ZvbGxv
dyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVy
cmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3Bl
bmVyJTIwbm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7LCAmcXVvdDttdWx0aXBhdGh0Y3AmcXVv
dDsgJmx0OzxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmciIHJlbD0ibm9mb2xs
b3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJlciIgdGFyZ2V0PSJf
YmxhbmsiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT4mZ3Q7PGJyPjxiPlNlbnQ6IDwvYj5TYXR1
cmRheSwgRmVicnVhcnkgMSwgMjAyMCAzOjM5OjUxIEFNPGJyPjxiPlN1YmplY3Q6IDwvYj5SZTog
W211bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlvbiBm
ZWVkYmFjazxicj48L2Rpdj48YnI+PGRpdj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRpcj0ibHRyIj48
ZGl2IGRpcj0ibHRyIj48ZGl2PkhpIEFuaWwsPC9kaXY+PGJyPjxkaXY+SSBoYXZlIGEgcXVlc3Rp
b24gYWJvdXQgeW91ciBwcm9wb3NlZCB0ZXh0LjwvZGl2PjxkaXY+PGRpdj5JIGFtIGFjdHVhbGx5
IHdvbmRlcmluZyBpZiB3ZSByZWFsbHkgd2FudCB0byB0ZXJtaW5hdGUgY29ubmVjdGlvbiBoZXJl
LsKgPC9kaXY+PC9kaXY+PGJyPjxkaXY+VGhlIHBhY2tldHMgd2l0aG91dCBwcm9wZXIgbWFwcGlu
Z3Mgd2lsbCBiZSB0cmVhdGVkIGFzIGludmFsaWQgYW5kIHdpbGwgYmUgZGlzY2FyZGVkLsKgPC9k
aXY+PGRpdj5JZiBhbiBpbXBsZW1lbnRhdGlvbiBmYWlsZWQgdG8gYXR0YWNoIHByb3BlciBtYXBw
aW5nIGZvciBzb21lIHJlYXNvbnMgKGUuZy4gb3B0aW9uIHNwYWNlKSwgaXQgbWlnaHQgYmUgYWJs
ZSB0byBhdHRhY2ggdGhlIHByb3BlciBvbmUgd2hlbiBpdCByZXRyYW5zbWl0cyB0aGUgcGFja2V0
cy4gVGhpcyBhbHNvIGxvb2tzIG9rIHRvIG1lLjwvZGl2Pjxicj48ZGl2PkkgZG9uJiMzOTt0IGhh
dmUgc3Ryb25nIHByZWZlcmVuY2UgZm9yIHRoaXMuIEJ1dCwgZG8gd2UgaGF2ZSBhIHJlYXNvbiB0
byB0ZXJtaW5hdGUgY29ubmVjdGlvbj88L2Rpdj48YnI+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj4t
LTxicj48L2Rpdj48ZGl2Pllvc2hpPC9kaXY+PGJyPjxkaXY+PGRpdiBkaXI9Imx0ciI+T24gTW9u
LCBKYW4gMTMsIDIwMjAgYXQgMTA6MjggQU0gViBBbmlsIEt1bWFyICZsdDs8YSBocmVmPSJtYWls
dG86YW5pbEBjc2lyNHBpLmluIiByZWw9Im5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVy
JTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVy
JTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xs
b3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciBub2ZvbGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+YW5pbEBj
c2lyNHBpLmluPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFp
bF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHgg
c29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PjxkaXY+PGRpdj48
ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiI+PGRpdj48
c3BhbiBzdHlsZT0iZm9udC1zaXplOjEycHQ7bGluZS1oZWlnaHQ6MS4zIj5IaSw8L3NwYW4+PGJy
PjwvZGl2PjxkaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMt
c2VyaWYiPjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlm
Ij48ZGl2IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiI+PGRp
diBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxkaXYgc3R5
bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmIj48ZGl2IHN0eWxlPSJm
b250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZiI+PGRpdiBzdHlsZT0iZm9udC1m
YW1pbHk6YXJpYWwsaGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxicj48ZGl2PkkgaGF2ZSBzb21lIHBv
aW50cyByZWxhdGVkIHRvIHRoZSDCoG1vZGlmaWNhdGlvbnMgKENoYW5nZSAyKSBiZWluZyBwcm9w
b3NlZCBvbiBkYXRhIHNlcXVlbmNlIG1hcC4gUGxlYXNlIHNlZSB0aGVtIGlubGluZS7CoDxzcGFu
IHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNpemU6
MTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDo0MDA7bGV0dGVyLXNwYWNpbmc6bm9y
bWFsO3RleHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3doaXRlLXNwYWNlOm5vcm1h
bDt3b3JkLXNwYWNpbmc6MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KTtmbG9h
dDpub25lO2Rpc3BsYXk6aW5saW5lIj5UaG91Z2ggSSBhbSBwdXR0aW5nIGZvcndhcmQgdGhlIGJl
bG93IHBvaW50cywgaWYgdGhlIGNvbnNlbnN1cyBpcyBpbiBmYXZvdXIgb2YgdGhlIHByb3Bvc2Vk
IGNoYW5nZSBmb3IgcmVkdWNpbmcgaW1wbGVtZW50YXRpb24gY29tcGxleGl0eSwgSSBhbSBhbHNv
IE9LIHdpdGggdGhhdCBhcyB3ZWxsLsKgPC9zcGFuPjxicj48L2Rpdj48YnI+PGhyIGlkPSJnbWFp
bC1tXy01NDA2NTQzNTU2NzM3NzIyMDFnbWFpbC1tXzg3NzMzNTc0Mzk3NzcwODE1OTBnbWFpbC1t
XzIxODA4NjU5Njk1MTcyNDUwMWdtYWlsLW1fMjk4MjI2NzAzMzU3NzkwMjk4NWdtYWlsLW1fNzY4
NzE4NDM4MjI5OTU5Njc3NHp3Y2hyIj48ZGl2PjxiPkZyb206IDwvYj4mcXVvdDthbGFuIGZvcmQm
cXVvdDsgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFuLmZvcmRAZ21haWwuY29tIiByZWw9Im5vZm9s
bG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVm
ZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9v
cGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBu
b2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciBub3JlZmVy
cmVyIiB0YXJnZXQ9Il9ibGFuayI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7PGJyPjxiPlRv
OiA8L2I+PGEgaHJlZj0ibWFpbHRvOm11bHRpcGF0aHRjcEBpZXRmLm9yZyIgcmVsPSJub2ZvbGxv
dyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVy
cmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3Bl
bmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9m
b2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIgbm9mb2xsb3cgbm9vcGVuZXIgbm9yZWZlcnJl
ciIgdGFyZ2V0PSJfYmxhbmsiPm11bHRpcGF0aHRjcEBpZXRmLm9yZzwvYT48YnI+PGI+U2VudDog
PC9iPlRodXJzZGF5LCBKYW51YXJ5IDIsIDIwMjAgNDoyMTozMiBBTTxicj48Yj5TdWJqZWN0OiA8
L2I+W211bHRpcGF0aHRjcF0gUkZDNjgyNGJpcyBlZGl0cyBiYXNlZCBvbiBpbXBsZW1lbnRhdGlv
biBmZWVkYmFjazxicj48L2Rpdj48YnI+PGRpdj5IaSBhbGwsPGJyPjxkaXY+V2XigJlkIGxvdmUg
dG8gZ2V0IHRoaXMgdG8gYSBzdGF0ZSBvZiBjb21wbGV0aW9uIGFzIHNvb24gYXMgcG9zc2libGUs
IGFuZCB0byB0aGlzIGVuZCBJIGFtIHN0YXJ0aW5nIGEgbmV3IHRocmVhZCBvbiB0aGlzIHRvcGlj
LiBJbiBkaXNjdXNzaW9uIHdpdGggdGhlIGNoYWlycywgaXQgPGk+aXMgPC9pPnBvc3NpYmxlIHRv
IG1ha2UgdGhlIGRlc2lyZWQgY2hhbmdlcyBpbiBBVVRINDggYXMgbG9uZyBhcyB0aGVyZSBpcyBX
RyBjb25zZW5zdXMuIFRoZSBkaXNjdXNzaW9uIHNvIGZhciBoYXMgYmVlbiBmYWlybHkgbGltaXRl
ZCBpbiB0ZXJtcyBvZiBwYXJ0aWNpcGF0aW9uLjwvZGl2Pjxicj48ZGl2Pkkgd291bGQgYXNrIHRo
ZSBjaGFpcnMgcGxlYXNlIGlmIGl0IHdhcyBwb3NzaWJsZSB0byBzcGVjaWZ5IGEgdGltZSBib3Vu
ZCBmb3IgdGhpcyBkaXNjdXNzaW9uIGFuZCBhIGRlZmF1bHQgY29uY2x1c2lvbi48L2Rpdj48YnI+
PGRpdj5SZWdhcmRpbmcgdGhlIGNoYW5nZXMsIGluIHN1bW1hcnksIHRoZXJlIGFyZSB0d28gYXJl
YXMgd2hlcmUgY2hhbmdlcyBoYXZlIGJlZW4gcmVxdWVzdGVkIGJ5IHRoZSBpbXBsZW1lbnRhdGlv
biBjb21tdW5pdHkuIEFzIHdlIGFyZSB0aGUgSUVURiB3ZSBvYnZpb3VzbHkgaGF2ZSBzdHJvbmcg
Zm9jdXMgb24g4oCccnVubmluZyBjb2Rl4oCdIGFuZCBzbyBlYXNlIG9mIGltcGxlbWVudGluZyBz
dGFuZGFyZHMtY29tcGxpYW50IGNvZGUgaXMgc3Ryb25nbHkgZGVzaXJhYmxlLiBIb3dldmVyLCB3
ZSBkbyBub3Qgd2lzaCB0byByZWR1Y2UgZnVuY3Rpb25hbGl0eSBhZ3JlZWQgYnkgdGhlIElFVEYg
Y29tbXVuaXR5IGlmIGl0IGlzIGNvbnNpZGVyZWQgYSByZXF1aXJlZCBmZWF0dXJlIGJ5IHRoZSBj
b21tdW5pdHkuPC9kaXY+PGJyPjxicj48ZGl2PjxiPkNoYW5nZSAxPC9iPjwvZGl2PjxkaXY+PGI+
PGJyPjwvYj48L2Rpdj48ZGl2PkNoYW5nZSB0aGUgc2VudGVuY2UgcmVhZGluZzo8YnI+PGJyPjxp
PsKgIMKgSWYgQiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJsZSBkZWxp
dmVyeSBvZiB0aGUgQUNLICsgTVBfQ0FQQUJMRSBjYW4gYmUgaW5mZXJyZWQgYnkgdGhlIHJlY2Vp
cHQgb2YgdGhpcyBkYXRhIHdpdGggYW4gTVBUQ1AgRGF0YSBTZXF1ZW5jZSBTaWduYWwgKERTUykg
b3B0aW9uIChTZWN0aW9uIDMuMykuwqA8YnI+PC9pPjxicj5Ubzo8YnI+PGJyPjxpPsKgIMKgSWYg
QiBoYXMgZGF0YSB0byBzZW5kIGZpcnN0LCB0aGVuIHRoZSByZWxpYWJsZSBkZWxpdmVyeSBvZiB0
aGUgQUNLICsgTVBfQ0FQQUJMRSBpcyBlbnN1cmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0
YSB3aXRoIGFuIE1QVENQIERhdGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlv
biAzLjMpIGNvbnRhaW5pbmcgYSBEQVRBX0FDSyBmb3IgdGhlIE1QX0NBUEFCTEUgKHdoaWNoIGlz
IHRoZSBmaXJzdCBvY3RldCBvZiB0aGUgZGF0YSBzZXF1ZW5jZcKgc3BhY2UpLjxicj48L2k+PGJy
PjwvZGl2PjxkaXY+V2hhdCB0aGlzIG1lYW5zOjwvZGl2Pjxicj48ZGl2PlRoZSBjdXJyZW50IHRl
eHQgaXMgY29uY2VybmVkIG9ubHkgd2l0aCBlbnN1cmluZyBhIHBhdGggaXMgTVBUQ1AgY2FwYWJs
ZSwgYW5kIHNvIG9ubHkgY2FyZXMgdGhhdCBEU1Mgb3B0aW9uIG9jY3VycyBvbiBhIGRhdGEgcGFj
a2V0LiBIb3dldmVyLCB0aGUgTVBfQ0FQQUJMRSBvcHRpb24gaXMgZGVmaW5lZCB0byBvY2N1cHkg
dGhlIGZpcnN0IG9jdGV0IG9mIGRhdGEgc2VxdWVuY2Ugc3BhY2UgYW5kIHRodXMsIGlmIGFuYWxv
Z291cyB0byBUQ1AsIG11c3QgYmUgYWNrbm93bGVkZ2VkLiAmZ3Q7RnJvbSBhbiBpbXBsZW1lbnRh
dGlvbiBwb2ludCBvZiB2aWV3IGl0IHdvdWxkIG1ha2Ugc2Vuc2Ugbm90IHRvIGhhdmUgdGhpcyBo
YW5naW5nIGFyb3VuZCBmb3JldmVyIGFuZCBpbnN0ZWFkIGRlZmluZSBpdCBpcyBhY2tub3dsZWRn
ZWQgYXQgdGhlIGNvbm5lY3Rpb24gbGV2ZWwgYXMgc29vbiBhcyByZWNlaXZlZC4gVGhpcyBjaGFu
Z2UgZW5zdXJlcyB0aGUgZmlyc3QgZGF0YSBwYWNrZXQgYWxzbyBEQVRBX0FDS3MgdGhpcyBNUF9D
QVBBQkxFIG9jdGV0LjwvZGl2Pjxicj48YnI+PGRpdj48Yj5DaGFuZ2UgMjwvYj48L2Rpdj48ZGl2
PjxiPjxicj48L2I+PC9kaXY+PGRpdj5DaGFuZ2UgdGhlIHNlbnRlbmNlIHJlYWRpbmc6PGJyPjxi
cj48aT7CoCDCoEEgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIGRvZXMgbm90IG5lZWQgdG8gYmUgaW5j
bHVkZWQgaW4gZXZlcnkgTVBUQ1AgcGFja2V0LCBhcyBsb25nIGFzIHRoZSBzdWJmbG93IHNlcXVl
bmNlIHNwYWNlIGluIHRoYXQgcGFja2V0IGlzIGNvdmVyZWQgYnkgYSBtYXBwaW5nIGtub3duIGF0
IHRoZSByZWNlaXZlci48L2k+PGJyPjxicj5Ubzo8YnI+PGJyPjxpPsKgIMKgVGhlIG1hcHBpbmcg
cHJvdmlkZWQgYnkgYSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgTVVTVCBhcHBseSB0byBzb21lIG9y
IGFsbCBvZiB0aGUgc3ViZmxvdyBzZXF1ZW5jZSBzcGFjZSBpbiB0aGUgVENQIHNlZ21lbnQgd2hp
Y2ggY2FycmllcyB0aGUgb3B0aW9uLiBJdCBkb2VzIG5vdCBuZWVkIHRvIGJlIGluY2x1ZGVkIGlu
IGV2ZXJ5IE1QVENQIHBhY2tldCwgYXMgbG9uZyBhcyB0aGUgc3ViZmxvdyBzZXF1ZW5jZSBzcGFj
ZSBpbiB0aGF0IHBhY2tldCBpcyBjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVj
ZWl2ZXIuPGJyPjwvaT48YnI+V2hhdCB0aGlzIG1lYW5zOjwvZGl2Pjxicj48ZGl2PlRoZSBjdXJy
ZW50IHRleHQgZG9lcyBub3QgcGxhY2UgYW55IHJlc3RyaWN0aW9ucyBvbiB3aGVyZSBhIG1hcHBp
bmcgY291bGQgYXBwZWFyLiBJbiB0aGVvcnkgYSBzZW5kZXIgY291bGQgZGVmaW5lIGEgdGhvdXNh
bmQgZGlmZmVyZW50IG1hcHBpbmdzIHVwIGZyb250LCBzZW5kIHRoZW0gYWxsLCBhbmQgZXhwZWN0
IGEgcmVjZWl2ZXIgdG8gc3RvcmUgdGhpcyBhbmQgcmVhc3NlbWJsZSBkYXRhIGFjY29yZGluZyB0
byB0aGVzZSBtYXBwaW5ncyBhcyBpdCBhcnJpdmVzLiBJbmRlZWQsIHRoaXMgd2FzIG5ldmVyIGV4
cGxpY2l0bHkgZGlzYWxsb3dlZCBzaW5jZSBpdCDigJxtaWdodCBoYXZlIGJlZW4gdXNlZnVs4oCd
LiBUaGUgaW1wbGVtZW50YXRpb24gY29tbXVuaXR5LCBob3dldmVyLCBoYXMgZXhwcmVzc2VkIGNv
bmNlcm5zIG92ZXIgdGhlIGRpZmZpY3VsdHkgb2YgaW1wbGVtZW50aW5nIHRoaXMgb3Blbi1lbmRl
ZGx5LiBIb3cgbWFueSBtYXBwaW5ncyBpcyBpdCByZWFzb25hYmxlIHRvIHN0b3JlPyBJcyB0aGVy
ZSBhIERvUyByaXNrIGhlcmU/IEluc3RlYWQsIGl0IGhhcyBiZWVuIHJlcXVlc3RlZCB0aGF0IHRo
ZWUgc3BlY2lmaWNhdGlvbiByZXN0cmljdHMgdGhlIHBsYWNlbWVudCBvZiB0aGUgRFNTIG9wdGlv
biB0byBiZWluZyB3aXRoaW4gdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2UgdG8gd2hpY2ggaXQg
YXBwbGllcy48L2Rpdj48YnI+PGRpdj5CZWxvdyBhcmUgbXkgY29tbWVudHMgb24gdGhpcy4gSSBo
YWQgc2hhcmVkIHNvbWUgb2YgdGhlc2UgcG9pbnRzIGluIGEgcHJldmlvdXMgdGhyZWFkIHRoYXQg
eW91IGhhZCBpbml0aWF0ZWQgaW4gdGhlIHNhbWUgY29udGV4dC7CoDwvZGl2Pjxicj48ZGl2PlRy
YW5zbWl0dGluZyBsYXJnZSBudW1iZXIgb2Ygbm9uLWNvbnRpZ3VvdXMgZGF0YSBzZXF1ZW5jZSBt
YXBzIGNvdWxkIGJlIGEgbWlzYmVoYXZpb3VyIChtYXAtZmxvb2RpbmcpLCB0aG91Z2ggaXQgaXMg
bm90IGNsZWFyIHdoZXRoZXIgdGhpcyBjYW4gZ28gdG8gdGhlIGV4dGVudCBvZiBjYXVzaW5nIGEg
cG90ZW50aWFsIERvUyB0byB0aGUgZGF0YSByZWNlaXZlci4gU28gc29tZSBzb3J0IG9mIHJlc3Ry
aWN0aW9uIG9uIHRoaXMgY291bGQgYmUgdXNlZnVsLsKgIE9uZSBhcHByb2FjaCBjb3VsZCBiZSB0
byBpbnNpc3QgdGhhdCB0aGUgZGF0YSBzZW5kZXIgc2hvdWxkIGVuc3VyZSB0aGF0IHRoZSBtYXAg
YmVpbmcgdHJhbnNtaXR0ZWQgaXMgZm9yIGluLXdpbmRvdyBkYXRhLCBhcyBwZXIgdGhlIHJlY2Vp
dmVyIGFkdmVydGlzZWQgd2luZG93LiBBIHJlY2VpdmVyIHNob3VsZCBhbnlob3cgYmUgd2lsbGlu
ZyB0byBzdG9yZSB0aGUgbWFwcyBmb3IgaW4td2luZG93IGRhdGEgdG8gZGVhbCB3aXRoIHBhY2tl
dCBsb3NzLiBGb3IgZXhhbXBsZSwgd2hlbiBhIHdpbmRvdyBvZiBkYXRhIHNlZ21lbnRzIChzYXkg
MSB0byA2NCkgaXMgdHJhbnNtaXR0ZWQsIGVhY2ggY2FycnlpbmcgaXRzIGNvcnJlc3BvbmRpbmcg
bWFwLCBhbmQgc2VnbWVudC0xIGlzIGxvc3QsIHRoZSBtYXBzIGZvciB0aGUgcmVtYWluaW5nIDYz
IG5lZWQgdG8gYmUgc3RvcmVkIHRpbGwgdGhlIGxvc3Qgc2VnbWVudCBpcyByZXRyYW5zbWl0dGVk
LiBPZiBjb3Vyc2UsIGluIHRoaXMgY2FzZSB0aGUgbWFwcyB3aWxsIGJlIHN0b3JlZCBhdCB0aGUg
cmVjZWl2ZXIgc2lkZSBhbG9uZyB3aXRoIHRoZWlyIGNvcnJlc3BvbmRpbmcgZGF0YS4gQnV0IHRo
ZSBuZWVkIHRvIHN0b3JlIG11bHRpcGxlIG1hcHMgZm9yIGluLXdpbmRvdyBkYXRhIHdvdWxkIHN0
aWxsIGJlIHRoZXJlLjwvZGl2Pjxicj48ZGl2PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTphcmlh
bCxoZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNpemU6MTZweDtmb250LXN0eWxlOm5vcm1hbDtm
b250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0OjIwLjhw
eDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7
d29yZC1zcGFjaW5nOjBweDtmbG9hdDpub25lO2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUs
MjU1KTtkaXNwbGF5OmlubGluZSI+VGhlIHByb2JsZW0gd2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdl
IChyZXN0cmljdGlvbikgaXMgdGhhdCBhIGRhdGEgc2VuZGVyIG1heSBmaW5kIGl0IGRpZmZpY3Vs
dCwgaW4gY2FzZSBhIG5lZWQgYXJpc2UgdG8gc2xpZ2h0bHkgZGVsYXkgdGhlIG1hcCBkZWxpdmVy
eSBieSBmZXcgc2VnbWVudHMsIGkuZS4sIHNlbmRpbmcgc29tZSBkYXRhIGZpcnN0IHdpdGhvdXQg
bWFwLCBhbmQgdGhlbiBzZW5kIHRoZSBjb3JyZXNwb25kaW5nIG1hcCBpbiBhIGxhdGVyIHNlZ21l
bnQsIGFzIHNob3duIGJlbG93Ojwvc3Bhbj48YnI+PC9kaXY+PGJyPjxkaXY+PGRpdiBzdHlsZT0i
Zm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDss
c2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdo
dDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWlu
ZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFj
aW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PHNw
YW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCI+c3ViZmxvdy0xOsKgIMKgIMKg
IHNlZ21lbnQtMcKgwqDCoCDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlZ21lbnQtM8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlZ21lbnQtNCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzZWdtZW50LTc8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJp
Zjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7
bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7
dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDtt
YXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PHNwYW4gbGFuZz0i
RU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCDCoMKgwqDCoGJ5dGVzOjEtMTAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJ5dGVz
OjIwMS0zMDAgwqAgwqAgwqAgwqAgwqAgwqAgwqBieXRlczozMDEtNDAwIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIGJ5dGVzOjYwMS03MDA8L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1p
bHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJp
Zjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7
bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7
dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDtt
YXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PHNwYW4gbGFuZz0i
RU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqDCoG5vIG1hcCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG1hcCBmb3Ig
MS0xMDAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXAgZm9yIDIwMS00MDAgwqAgwqAgwqAgwqAgwqAg
wqAgbWFwIGZvciA2MDEtNzAwPC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiZx
dW90O3NlZ29lIHVpJnF1b3Q7LCZxdW90O2x1Y2lkYSBzYW5zJnF1b3Q7LHNhbnMtc2VyaWY7Zm9u
dC1zaXplOjE0LjE2cHg7Zm9udC1zdHlsZTpub3JtYWw7Zm9udC13ZWlnaHQ6bm9ybWFsO2xldHRl
ci1zcGFjaW5nOm5vcm1hbDtsaW5lLWhlaWdodDpub3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQt
dHJhbnNmb3JtOm5vbmU7d2hpdGUtc3BhY2U6bm9ybWFsO3dvcmQtc3BhY2luZzowcHg7bWFyZ2lu
OjBweDtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUsMjU1LDI1NSkiPjxzcGFuIGxhbmc9IkVOLVVT
IiBzdHlsZT0iZm9udC1zaXplOjEwcHQiPjxicj48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9u
dC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fu
cy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpu
b3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVu
dDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5n
OjBweDttYXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PHNwYW4g
bGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCI+PGJyPjwvc3Bhbj48L2Rpdj48ZGl2
IHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtzZWdvZSB1aSZxdW90OywmcXVvdDtsdWNpZGEgc2Fu
cyZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxNC4xNnB4O2ZvbnQtc3R5bGU6bm9ybWFsO2Zv
bnQtd2VpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzpub3JtYWw7bGluZS1oZWlnaHQ6bm9ybWFs
O3RleHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpub25lO3doaXRlLXNwYWNlOm5vcm1hbDt3
b3JkLXNwYWNpbmc6MHB4O21hcmdpbjowcHg7YmFja2dyb3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwy
NTUpIj48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVv
dDssJnF1b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtm
b250LXN0eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFs
O2xpbmUtaGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3
aGl0ZS1zcGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQt
Y29sb3I6cmdiKDI1NSwyNTUsMjU1KSI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNp
emU6MTBwdCI+c3ViZmxvdy0yOsKgIMKgIMKgIMKgc2VnbWVudC0ywqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc2VnbWVudC01IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNlZ21lbnQt
NiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZWdtZW50LTg8L3NwYW4+PC9kaXY+
PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1b3Q7bHVjaWRh
IHNhbnMmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtmb250LXN0eWxlOm5vcm1h
bDtmb250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUtaGVpZ2h0Om5v
cm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1zcGFjZTpub3Jt
YWw7d29yZC1zcGFjaW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6cmdiKDI1NSwy
NTUsMjU1KSI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBwdCI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgYnl0ZXM6IDEwMS0yMDAgwqAg
wqAgwqAgwqAgwqAgYnl0ZXM6NDAxLTUwMMKgwqDCoMKgwqDCoCDCoMKgwqDCoMKgwqDCoCBieXRl
czogNTAxLTYwMCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJ5dGVzOjcwMS04MDDCoMKgwqA8L3Nw
YW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7c2Vnb2UgdWkmcXVvdDssJnF1
b3Q7bHVjaWRhIHNhbnMmcXVvdDssc2Fucy1zZXJpZjtmb250LXNpemU6MTQuMTZweDtmb250LXN0
eWxlOm5vcm1hbDtmb250LXdlaWdodDpub3JtYWw7bGV0dGVyLXNwYWNpbmc6bm9ybWFsO2xpbmUt
aGVpZ2h0Om5vcm1hbDt0ZXh0LWluZGVudDowcHg7dGV4dC10cmFuc2Zvcm06bm9uZTt3aGl0ZS1z
cGFjZTpub3JtYWw7d29yZC1zcGFjaW5nOjBweDttYXJnaW46MHB4O2JhY2tncm91bmQtY29sb3I6
cmdiKDI1NSwyNTUsMjU1KSI+PHNwYW4gbGFuZz0iRU4tVVMiIHN0eWxlPSJmb250LXNpemU6MTBw
dCI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtYXAgZm9yIDEwMS0yMDAgwqAg
wqAgwqAgbWFwIGZvciA0MDEtNjAwIMKgIMKgIMKgIMKgIMKgIMKgbm8gbWFwIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbWFwIGZvciA3MDEtODAwPC9zcGFuPjwvZGl2
PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O3NlZ29lIHVpJnF1b3Q7LCZxdW90O2x1Y2lk
YSBzYW5zJnF1b3Q7LHNhbnMtc2VyaWY7Zm9udC1zaXplOjE0LjE2cHg7Zm9udC1zdHlsZTpub3Jt
YWw7Zm9udC13ZWlnaHQ6bm9ybWFsO2xldHRlci1zcGFjaW5nOm5vcm1hbDtsaW5lLWhlaWdodDpu
b3JtYWw7dGV4dC1pbmRlbnQ6MHB4O3RleHQtdHJhbnNmb3JtOm5vbmU7d2hpdGUtc3BhY2U6bm9y
bWFsO3dvcmQtc3BhY2luZzowcHg7bWFyZ2luOjBweDtiYWNrZ3JvdW5kLWNvbG9yOnJnYigyNTUs
MjU1LDI1NSkiPjxicj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtzZWdvZSB1
aSZxdW90OywmcXVvdDtsdWNpZGEgc2FucyZxdW90OyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxNC4x
NnB4O2ZvbnQtc3R5bGU6bm9ybWFsO2ZvbnQtd2VpZ2h0Om5vcm1hbDtsZXR0ZXItc3BhY2luZzpu
b3JtYWw7bGluZS1oZWlnaHQ6bm9ybWFsO3RleHQtaW5kZW50OjBweDt0ZXh0LXRyYW5zZm9ybTpu
b25lO3doaXRlLXNwYWNlOm5vcm1hbDt3b3JkLXNwYWNpbmc6MHB4O21hcmdpbjowcHg7YmFja2dy
b3VuZC1jb2xvcjpyZ2IoMjU1LDI1NSwyNTUpIj48YnI+PC9kaXY+SW4gdGhlIGFib3ZlIGNhc2Us
IHNlZ21lbnQtMSBnb2VzIHdpdGhvdXQgbWFwIGFuZCBpdHMgbWFwIGlzIGluY2x1ZGVkIGxhdGVy
IGluIHNlZ21lbnQtMywgdGhlIG5leHQgZGF0YSBzZWdtZW50IGluIHRoZSBzYW1lIHN1YmZsb3cu
IEZ1cnRoZXIsIMKgaW4gdGhlIGFib3ZlIHNjaGVkdWxpbmcgcGF0dGVybiwgdGhlIG1hcCBpbiBz
ZWdtZW50LTMgY2Fubm90IGNvdmVyIHRoZSDCoGRhdGEgaW4gc2VnbWVudC0xIGFuZCBzZWdtZW50
LTMsIGFzIHNvbWUgwqBkYXRhIGluIGJldHdlZW4gKHNlZ21lbnQtMikgaXMgdHJhbnNtaXR0ZWQg
dGhyb3VnaCBhbm90aGVyIHN1YmZsb3cuwqAgV2l0aCB0aGUgcHJvcG9zZWQgY2hhbmdlLCB0aGUg
bWFwIGluIHNlZ21lbnQtMyB3aWxsIGJlY29tZSBpbnZhbGlkIGFuZCB0aGlzIHdpbGwgZXZlbnR1
YWxseSBicmVhayBzdWJmbG93LTEsIHRob3VnaCB0aGlzIGNvdWxkIGJlIGEgY29ybmVyIGNhc2Uu
LjwvZGl2Pjxicj48ZGl2PlRoZSBxdWVzdGlvbiBhdCB0aGlzIHN0YWdlIGlzIHdoeSB3b3VsZCBz
ZWdtZW50LTEgYmUgdHJhbnNtaXR0ZWQgd2l0aG91dCBpdHMgbWFwLiBJbiB0aGUgY2FzZSBvZiBi
aWRpcmVjdGlvbmFsIGRhdGEgdHJhbnNmZXIsIHRoZXJlIGNvdWxkIGJlIGEgbmVlZCB0byBwYWNr
IGJvdGggdGltZXN0YW1wIGFuZCBTQUNLIMKgb3B0aW9ucyBpbiBhIGRhdGEgc2VnbWVudCwgaS5l
LiwgcGlnZ3liYWNraW5nIG9mIMKgU0FDSyB3aXRoIGRhdGEuIElmIHdlIGNvbnNpZGVyIHRoYXQg
dGltZXN0YW1wIHRha2VzIDEyIGJ5dGVzIGFuZCBTQUNLLCBldmVuIHdpdGggc2luZ2xlIGJsb2Nr
LCDCoHRha2VzIGFub3RoZXIgMTAgYnl0ZXMsIHRoZSByZW1haW5pbmcgMTggYnl0ZXMgb3B0aW9u
IHNwYWNlIGlzIG5vdCBhZGVxdWF0ZSB0byBjYXJyeSBkYXRhIHNlcXVlbmNlIHNpZ25hbCB3aXRo
IG1hcCwgZXNwZWNpYWxseSB3aGVuIERTTiBpcyA2NCBiaXQgbG9uZy4gU28gdGhlIGRlbGl2ZXJ5
IG9mIGVpdGhlciBvZiB0aGUgdHdvIChTQUNLIG9yIG1hcCkgd291bGQgYmUgZGVsYXllZC48L2Rp
dj48YnI+PGRpdj5BcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCBSRkMgMjAxOCAoVENQIFNlbGVjdGl2
ZSBBY2tub3dsZWRnZW1lbnQgT3B0aW9ucykgaW1wbGllcyB0aGF0IFNBQ0sgc2hvdWxkIG5vdCBi
ZSBkZWxheWVkLiBJdCBzdGF0ZXMgJnF1b3Q7SWYgc2VudCBhdCBhbGwsIFNBQ0sgb3B0aW9ucyBT
SE9VTEQgYmUgaW5jbHVkZWQgaW4gYWxsIEFDS3Mgd2hpY2ggZG8gbm90IEFDSyB0aGUgaGlnaGVz
dCBzZXF1ZW5jZSBudW1iZXIgaW4gdGhlIGRhdGEgcmVjZWl2ZXImIzM5O3MgcXVldWUmcXVvdDsu
IEl0IGFsc28gc2F5cyAmcXVvdDtJZiBkYXRhIHJlY2VpdmVyIGdlbmVyYXRlcyBTQUNLIG9wdGlv
bnMgdW5kZXIgYW55IGNpcmN1bXN0YW5jZSwgaXQgU0hPVUxEIGdlbmVyYXRlIHRoZW0gdW5kZXIg
YWxsIHBlcm1pdHRlZCBjaXJjdW1zdGFuY2VzJnF1b3Q7LiDCoCBTbywgYXMgcGFydCBvZiBtZWV0
aW5nIHRoZSBSRkMgMjAxOCByZXF1aXJlbWVudHMsIGlmIHRoZSBjb21iaW5hdGlvbiBvZiBTQUNL
IGFuZCB0aW1lc3RhbXAgaXMgZ2l2ZW4gcHJlZmVyZW5jZSBvdmVyIERTUywgZGF0YSBzZWdtZW50
cyBjb3VsZCBiZSB0cmFuc21pdHRlZCB3aXRob3V0IHRoZWlyIG1hcC7CoDwvZGl2Pjxicj48ZGl2
PkFub3RoZXIgY2FzZSBvZiBkZWxheWluZyBtYXAgY291bGQgYXJpc2UgaWYgdGhlIGRhdGEgc2Vu
ZGVyIHByZWZlcnMgdG8gc2VuZCBBRERfQUREUiBvcHRpb24sIGluc3RlYWQgb2YgbWFwLCBpbiBh
IGRhdGEgc2VnbWVudC4gSXQgaXMgbmljZSB0aGF0IEFERF9BRERSIG9wdGlvbiBjYW4gYmUgZGVs
aXZlcmVkIHJlbGlhYmx5IGluIGEgcHVyZSBBQ0ssIGJ1dCBJIHRoaW5rIHRoaXMgaXMgbm90IHRo
ZSBjYXNlIHdpdGggRFNTIGF0IHByZXNlbnQuPC9kaXY+PGJyPjxkaXY+SWYgd2UgYWRvcHQgdGhl
IHByb3Bvc2VkIGNoYW5nZSwgSSB0aGluayBpdCBtaWdodCBhbHNvIGJlIGhlbHBmdWwgdG8gc3Bl
bGwgb3V0IGhvdyB0aGUgcmVjZWl2ZXIgaXMgc3VwcG9zZWQgdG8gYmVoYXZlLCBpZiBpdCBnZXRz
IG1hcHMgbm90IG1lZXRpbmcgdGhlIE1VU1QgY29uZGl0aW9uIGluIHRoZSBwcm9wb3NlZCBjaGFu
Z2UuwqAgRm9yIGV4YW1wbGUgdGVybWluYXRpb24gb2YgdGhlIHN1YmZsb3cgd2l0aCBNUF9UQ1BS
U1Qgb3B0aW9uIChzZWN0aW9uIDMuNiBpbiBSRkMgNjgyNC1iaXMpIHdpdGggYXBwcm9wcmlhdGUg
cmVhc29uIGNvZGUgYW5kIFQgZmxhZyB2YWx1ZSB0byBpbnRpbWF0ZSB0aGUgZGF0YSBzZW5kZXIg
dGhlIGNhdXNlIGZvciBzdWJmbG93IHRlcm1pbmF0aW9uLsKgwqA8L2Rpdj48ZGl2PsKgIMKgIMKg
IMKgIMKgPC9kaXY+PC9kaXY+PGRpdj5XaXRoIHJlZ2FyZHMsPC9kaXY+PGJyPjxkaXY+QW5pbDxi
cj48YnI+PGRpdj5QbGVhc2UgY2FuIG1lbWJlcnMgb2YgdGhlIFdHIGV4cHJlc3Mgd2hldGhlciB0
aGV5IGFyZSBoYXBweSB3aXRoIHRoZXNlIGNoYW5nZXMsIG9yIGNvbmNlcm5lZC48L2Rpdj48YnI+
PGRpdj5CZXN0IHJlZ2FyZHMsPC9kaXY+PGRpdj5BbGFuPC9kaXY+PGJyPjxicj5fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj5tdWx0aXBhdGh0Y3AgbWFp
bGluZyBsaXN0PGJyPjxhIGhyZWY9Im1haWx0bzptdWx0aXBhdGh0Y3BAaWV0Zi5vcmciIHJlbD0i
bm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIw
bm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3cl
MjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJl
ciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyIG5vZm9sbG93IG5vb3BlbmVyIG5v
cmVmZXJyZXIiIHRhcmdldD0iX2JsYW5rIj5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+PGJyPjxh
IGhyZWY9Imh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vbXVsdGlwYXRodGNw
IiByZWw9Im5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5v
Zm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5v
cmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2ZvbGxvdyBub29w
ZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFp
bG1hbi9saXN0aW5mby9tdWx0aXBhdGh0Y3A8L2E+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pjxi
cj48YnI+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX188YnI+
bXVsdGlwYXRodGNwIG1haWxpbmcgbGlzdDxicj48YSBocmVmPSJtYWlsdG86bXVsdGlwYXRodGNw
QGlldGYub3JnIiByZWw9Im5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xs
b3clMjBub29wZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZl
cnJlciUyMG5vZm9sbG93JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29w
ZW5lciUyMG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciBub2Zv
bGxvdyBub29wZW5lciBub3JlZmVycmVyIiB0YXJnZXQ9Il9ibGFuayI+bXVsdGlwYXRodGNwQGll
dGYub3JnPC9hPjxicj48YSBocmVmPSJodHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL211bHRpcGF0aHRjcCIgcmVsPSJub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUy
MG5vcmVmZXJyZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93
JTIwbm9vcGVuZXIlMjBub3JlZmVycmVyJTIwbm9mb2xsb3clMjBub29wZW5lciUyMG5vcmVmZXJy
ZXIlMjBub2ZvbGxvdyUyMG5vb3BlbmVyJTIwbm9yZWZlcnJlciUyMG5vZm9sbG93JTIwbm9vcGVu
ZXIlMjBub3JlZmVycmVyIG5vZm9sbG93IG5vb3BlbmVyIG5vcmVmZXJyZXIiIHRhcmdldD0iX2Js
YW5rIj5odHRwczovL3d3dy5pZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL211bHRpcGF0aHRjcDwv
YT48YnI+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxi
cj48L2Rpdj48L2Rpdj48YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjxicj48L2Rpdj48L2Rpdj48
YnI+PGJyPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9kaXY+PC9kaXY+PGJy
PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj4KPGJyPgo8YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjwv
ZGl2PjwvZGl2PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xzxicj5tdWx0aXBhdGh0Y3AgbWFpbGluZyBsaXN0PGJyPjxhIGhyZWY9Im1haWx0bzptdWx0aXBh
dGh0Y3BAaWV0Zi5vcmciIHRhcmdldD0iX2JsYW5rIj5tdWx0aXBhdGh0Y3BAaWV0Zi5vcmc8L2E+
PGJyPjxhIGhyZWY9Imh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vbXVsdGlw
YXRodGNwIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0
aW5mby9tdWx0aXBhdGh0Y3A8L2E+PGJyPjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9k
aXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============4127552828060051013==--
