Content-Type: multipart/mixed; boundary="===============1785423604621085707=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Thu, 05 Dec 2019 09:39:46 -0800
Message-ID: <DEE3E51B-373C-40BE-A296-8517FB23A7B7@apple.com>
In-Reply-To: 3278EB11-686A-4E0F-9DE4-321B239F8913@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2795

--===============1785423604621085707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Alan,

> On Dec 5, 2019, at 7:03 AM, Alan Ford <alan.ford(a)gmail.com> wrote:
>> On 5 Dec 2019, at 00:33, Christoph Paasch <cpaasch(a)apple.com <mailto:c=
paasch(a)apple.com>> wrote:
>>> On Dec 4, 2019, at 1:50 PM, Alan Ford <alan.ford(a)gmail.com <mailto:al=
an.ford(a)gmail.com>> wrote:
>>> Thank you for the clarifications. I was revisiting the text to see ways=
 to make these clarifications, however I find myself unsure of the need; pl=
ease see comments below:
>>> =

>>> =

>>> Section 3.1 clarification
>>> =

>>> Towards the end of Section 3.1 we actually say the following:
>>> =

>>>    The SYN with MP_CAPABLE occupies the first octet of data sequence sp=
ace, although this does not need to be acknowledged at the connection level=
 until the first data is sent (see Section 3.3).
>>> =

>>> Which would seem to cover exactly this concern.
>> =

>> I'm not sure how it covers the concern, because the issue I raise is tha=
t the client needs to somehow find out if the MP_CAPABLE made it to the rec=
eiver. And the clarification I suggest is to spell out that it is the DATA_=
ACK (see my next comment).
>> =

>>> However if you still feel further clarification is required, then we co=
uld add this also to the sentence you suggest, i.e.:
>>> =

>>>    If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data =
Sequence Signal (DSS) option (Section 3.3). =

>>> =

>> =

>> The ambiguity here is that DSS does not imply DATA_ACK. One could send a=
 DSS without a DATA_ACK, but that would not signal to the client the reliab=
le delivery of the MP_CAPABLE. Only the DATA_ACK will do so.
> =

> OK well maybe I am not understanding your concern here. The first sentenc=
e I quote says that the MP_CAPABLE needs to be DATA_ACKed when the first da=
ta is sent.

Actually, strictly reading, the first sentence says that it must not be ack=
nowledged until first data sent. It does not say that a MP_CAPABLE MUST be =
DATA_ACKed.

> The sentence beginning =E2=80=9CIf B has Data to send first=E2=80=9D mean=
s:
> =

> - A->B SYN
> - B->A SYN/ACK + MP_CAPABLE
> - A->B ACK + MP_CAPABLE
> - B->A ACK + DATA + DSS
> =

> DSS can contain one or both of DSM and DATA_ACK. However the previously q=
uoted sentence says that the MP_CAPABLE needs to be acknowledged at the con=
nection-level (i.e. DATA_ACKed) when the first data is sent.
> =

> However in writing this I realise that that text makes no comment about w=
ho is sending data. Because the intention is it applies to any data being s=
ent (if B is sending, then it will include a DATA_ACK as well as a DSS; if =
A is sending then B will acknowledge with a DATA_ACK), but it could be read=
 by someone to mean =E2=80=9Conly when acknowledging the first data does th=
e MP_CAPABLE need to be included in the DATA_ACK=E2=80=9D, which is not the=
 desired meaning.
> =

> I am all for improving clarity so I think a clearer version of =E2=80=9CI=
f B has data=E2=80=A6=E2=80=9D would go:
> =

>     If B has data to send first, then the reliable delivery of the ACK + =
MP_CAPABLE is ensured by the receipt of this data with an MPTCP Data Sequen=
ce Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_CAPAB=
LE (which is the first octet of the data sequence space).
> =

> Would you be ok with that? It is shorter than the other edits whilst stil=
l being unambiguous.

This however does not say that the reception fo a DATA_ACK allows A to stop=
 sending the MP_CAPABLE. I still think that it should be spelled out somewh=
ere.

> =

>>> Can change to:
>>> =

>>>    If B has data to send first, then the reliable delivery of the ACK +=
 MP_CAPABLE can be inferred by the receipt of this data with an MPTCP Data =
Sequence Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP=
_CAPABLE (which is the first octet of the data sequence space). Furthermore=
, when A receives a DATA_ACK from B it is a signal of the reliable delivery=
 of A's MP_CAPABLE.
>>> =

>>> Please confirm if you still feel this is necessary, given the quote I p=
rovide.
>> =

>> Yes, I still feel that this is necessary.
>> =

>>> =

>>> =

>>> Early Mapping
>>> =

>>>    A Data Sequence Mapping does not need to be included in every MPTCP
>>>    packet, as long as the subflow sequence space in that packet is
>>>    covered by a mapping known at the receiver.  This can be used to
>>>    reduce overhead in cases where the mapping is known in advance.  One
>>>    such case is when there is a single subflow between the hosts, and
>>>    another is when segments of data are scheduled in larger-than-packet-
>>>    sized chunks.
>>> =

>>> I would suggest simply adding a sentence at the beginning saying =E2=80=
=9CA Data Sequence Mapping MUST appear on a TCP segment which is covered by=
 the mapping=E2=80=9D.
>> =

>> Yes, adding that sentence would clarify this.
>> =

>> I also would remove the sentence "This can be used to..." and "One such =
case is..." - it adds to the confusion IMO.
> =

> I quite like to retain examples where possible; these seem harmless when =
combined with the clarification from the MUST, it ensures people behave!

Ok, fair enough!


Thanks,
Christoph

> =

> Best regards,
> Alan
> =

>>> =

>>> Regarding late mapping, we say:
>>> =

>>>    Implementations MAY hold onto such unmapped data for a
>>>    short while, in the expectation that a mapping will arrive shortly.
>>>    Such unmapped data cannot be counted as being within the connection-
>>>    level receive window because this is relative to the data sequence
>>>    numbers, so if the receiver runs out of memory to hold this data, it
>>>    will have to be discarded.  If a mapping for that subflow-level
>>>    sequence space does not arrive within a receive window of data, that
>>>    subflow SHOULD be treated as broken, closed with a RST, and any
>>>    unmapped data silently discarded.
>>> =

>>> Note the last sentence. We already bound this suggestion to just a subf=
low receive window of data, and provide a mechanism to reject (RST and sile=
ntly discard). If we add the above text re early mapping that would also ap=
ply in this case and provide your requirement that the mapping lands on a s=
egment covered by the mapping.
>> =

>> Yes, this last sentence, combined with the above-mentioned addition shou=
ld make things fine.
>> =

>> =

>> Thanks,
>> Christoph
>> =

>>> =

>>> Any thoughts?
>>> =

>>> Best regards,
>>> Alan
>>> =

>>>> On 2 Dec 2019, at 17:27, Christoph Paasch <cpaasch(a)apple.com <mailto=
:cpaasch(a)apple.com>> wrote:
>>>> =

>>>> Hello Alan,
>>>> =

>>>> On 29/11/19 - 21:13:38, Alan Ford wrote:
>>>>>> On 28 Nov 2019, at 19:49, Christoph Paasch <cpaasch(a)apple.com <mai=
lto:cpaasch(a)apple.com>> wrote:
>>>>>>> On Nov 28, 2019, at 8:16 AM, Alan Ford <alan.ford(a)gmail.com <mail=
to:alan.ford(a)gmail.com> <mailto:alan.ford(a)gmail.com <mailto:alan.ford(a=
)gmail.com>>> wrote:
>>>>>>>> On 27 Nov 2019, at 19:29, Christoph Paasch <cpaasch(a)apple.com <m=
ailto:cpaasch(a)apple.com> <mailto:cpaasch(a)apple.com <mailto:cpaasch(a)ap=
ple.com>>> wrote:
>>>>>>>> Section 3.3.1, page 32 & 33, "A data sequence mapping does not nee=
d..."
>>>>>>>> =

>>>>>>>> This paragraph states that it is permissive to send a mapping in a=
dvance. Late-mapping is specified a bit higher around the sentence =

>>>>>>>> "Implementations MAY hold onto such unmapped data for a short whil=
e in the expectation that a mapping will arrive shortly"
>>>>>>>> =

>>>>>>>> This kind of early/late mapping announcements are difficult to han=
dle in an implementation. The Linux Kernel implementation of multipath-tcp.=
org <http://multipath-tcp.org/> <http://multipath-tcp.org/ <http://multipat=
h-tcp.org/>> has always disallowed such kind of mappings. Meaning, whenever=
 a DSS-option is received such that the range specified by the relative sub=
flow-sequence number in the DSS-option and the data-length does not (partia=
lly) cover the TCP sequence number of the packet itself, the subflow will b=
e killed with a TCP-RST. The problem around handling such early/late mappin=
gs is that it is unclear for how long the stack needs to remember these map=
pings (in the early-mapping case), or for how long he needs to hold on to t=
he data (in the late-mapping case).
>>>>>>>> =

>>>>>>>> We thus suggest to change this to the following:
>>>>>>>> Whenever a DSS-option is received on a packet such that the mappin=
g of the subflow-sequence space does not partially cover the TCP-sequence n=
umber of  the packet itself, the host MUST discard this mapping and MAY des=
troy the subflow with a TCP-RST. It should be noted that a DATA_FIN that do=
es not come with data has a relative subflow-sequence number of 0 and thus =
should be handled separately.
>>>>>>> =

>>>>>>> This one I do have an issue with:
>>>>>>> =

>>>>>>> - It is a technical change
>>>>>>> - Wording to this effect has been in the document since pretty much=
 the beginning
>>>>>>> - It is a MAY which might as well say =E2=80=9Cthere is no guarante=
e this would work=E2=80=9D
>>>>>> =

>>>>>> The problem with the MAY is that the sender can't really know if the=
 receiver accepts it (more regarding this below)
>>>>>> =

>>>>>>> Most importantly, the replacement text seems not to address this is=
sue at all. If I read it correctly, it says that the data sequence mapping =
option MUST partially cover the subflow sequence space of the packet itself=
. But that has nothing to do with late or early mapping, both could partial=
ly cover the subflow sequence space and preceding data.
>>>>>>> =

>>>>>>> Can you clarify exactly what you want to permit and prevent, here?
>>>>>> =

>>>>>> Let me try to clarify what exactly we mean with early/late mapping s=
o that we are all on the same terms here:
>>>>>> =

>>>>>> Early mapping:
>>>>>> =

>>>>>> A TCP-segment with sequence-number 1 holds a DSS-option with subflow=
-sequence number 1001 and data-length 100. This means we need to allocate s=
pace to store this DSS-option so that when the TCP-segment with seqno 1001 =
arrives we can know the mapping. There may be coming more of these DSS-opti=
ons which all need to be stored in allocated memory. It is unclear what the=
 limit to this is and there is no way to communicate this limit to the send=
er.
>>>>> =

>>>>> I don=E2=80=99t think we have ever intended to support a mapping like=
 this. If the text is not clear here then yes, we might have an issue.
>>>> =

>>>> Yes, I do think that the text is not very clear on that  - we should c=
larify
>>>> that.
>>>> =

>>>>> We intend only to support: A TCP segment with sequence-number 1 holds=
 a DSS option for SSN 1 and length 10000 (so multiple segments in the futur=
e).
>>>> =

>>>> Sounds good!
>>>> =

>>>>> Or, slightly more convoluted, a TCP segment with SN 100, length 100, =
which holds a DSS option for 151-250, and bytes 50-150 were already covered=
 by a previous mapping.
>>>> =

>>>> Also good.
>>>> =

>>>>> I do not believe we have ever intended mappings on data segments wher=
e the segments do not include any of the mapped data. We did, however, inte=
nd to support mappings on pure ACKs in order to avoid any option space limi=
ts.
>>>> =

>>>> Mappings on a pure ACK are an unlikely use-case. The problem is that i=
n the
>>>> end the mapping needs to reliably make it to the receiver as otherwise=
 he
>>>> needs to throw the data away. Combining it with data implicitly makes =
it
>>>> reliable.
>>>> =

>>>> In case of option-space limits, it is better to send the options that =
do
>>>> consume a lot of space (ADD_ADDR,...) on the pure ACK.
>>>> =

>>>>> =

>>>>>> Late mapping:
>>>>>> =

>>>>>> The receiver receives data without DSS-options with TCP-sequence 1 t=
o 1001. The corresponding DSS-option however arrives with the TCP-segment w=
ith seqno 2001. Here, the receiver needs to hold on to this data, waiting f=
or the TCP-segment with the DSS-option. At one point the receiver needs to =
drop the data due to memory limits. Again, the sender has no way for knowin=
g what this limit is.
>>>>> =

>>>>> So this is slightly more problematic, and this is what the MAY in the=
 text is designed to discuss.
>>>>> =

>>>>> I believe we had intended to support a situation where you could have=
 a segment 1-1000 without a DSS option, and 1001-2000 also without, and the=
n 2001-3000 with the option then providing a mapping for 1 to 2001 or highe=
r.
>>>> =

>>>> I think this scenario is fine to some extend with a slight change that=
 the
>>>> provided mapping should be for 1 to 2002 or higher (thus, including th=
e byte
>>>> of the 2001-3000 segment).
>>>> =

>>>>> This would allow a sender to start pushing out data before it knew wh=
at a mapping might look like.
>>>>> It does, however, seem an unlikely situation but you as a receiver co=
uld of course reduce the subflow window size in order to limit buffering. T=
he text does recognise the memory issue and point out that this won=E2=80=
=99t be DATA ACKed and as such a sender should soon realise and retransmit =
on a separate subflow and then this subflow may eventually be closed.
>>>> =

>>>> Yes, it seems like an unlikerly situation and I'm not sure about the
>>>> use-case for doing this.
>>>> =

>>>>> Another situation would involve two mappings on the same TCP segment.=
 If the first 50 bytes of a segment are covered by the mapping provided in =
that segment, but there are then also another 50 bytes, then the mapping ca=
n=E2=80=99t be provided until the next segment.
>>>> =

>>>> Yes, two mappings on a single packet are problematic simply because of=
 the
>>>> lack of option-space.
>>>> =

>>>>> I guess my initial thought here is that this was intended to cover a =
number of corner cases but if it does not work for you then there are sever=
al compliant ways of dealing with it.
>>>>> =

>>>>>> When the DSS-option comes together with the corresponding TCP-sequen=
ce it is straight-forward to store it together with the data. There are no =
issues with memory-allocation,... as all of this is accounted together with=
 the announced window (yes, the memory is not counted against the window, b=
ut the receiver can foresee the DSS-option overhead when computing what win=
dow he should announce).
>>>>>> =

>>>>>> When a receiver gets data without a DSS-option, he can store it for =
up to 64KB of data as that is the maximum data-level length and the last se=
gment of the 64KB-train could be holding the DSS-option. After that he has =
to drop the data.
>>>>>> =

>>>>>> When the mapping partially covers the segment it also isn't a proble=
m as the unmapped part can safely be dropped and the mapped part can be pas=
sed on to the MPTCP-layer.
>>>>>> =

>>>>>> All of this does not imply that every segment of a mapping needs to =
hold the DSS-option. Just one of them needs to have it.
>>>>> =

>>>>> That last statement aligns with what was intended in the text. But ar=
e you really saying that, or are you saying that the first one needs to hav=
e it? Because that would be a change.
>>>> =

>>>> No, the first one does not need to have it. Just one of them.
>>>> =

>>>> =

>>>> Cheers,
>>>> Christoph
> =



--===============1785423604621085707==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8gQWxhbiw8YnIgY2xhc3M9IiI+PGRpdj48YnIgY2xhc3M9
IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5PbiBEZWMg
NSwgMjAxOSwgYXQgNzowMyBBTSwgQWxhbiBGb3JkICZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5m
b3JkQGdtYWlsLmNvbSIgY2xhc3M9IiI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3Rl
OjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3JkOyAt
d2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyIg
Y2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNp
dGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gNSBEZWMgMjAxOSwgYXQgMDA6MzMsIENocmlz
dG9waCBQYWFzY2ggJmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgY2xhc3M9
IiI+Y3BhYXNjaEBhcHBsZS5jb208L2E+Jmd0OyB3cm90ZTo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxk
aXYgc3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBIZWx2ZXRp
Y2E7IGZvbnQtc2l6ZTogMTJweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fw
czogbm9ybWFsOyBmb250LXdlaWdodDogbm9ybWFsOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0
ZXh0LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7
IHdoaXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ry
b2tlLXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiIGNsYXNzPSIiPjxibG9ja3F1
b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+T24gRGVjIDQsIDIwMTksIGF0
IDE6NTAgUE0sIEFsYW4gRm9yZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5j
b20iIGNsYXNzPSIiPmFsYW4uZm9yZEBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8L2Rpdj48ZGl2
IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiIgc3R5bGU9IndvcmQtd3JhcDogYnJlYWstd29yZDsgLXdl
YmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFrOiBhZnRlci13aGl0ZS1zcGFjZTsiPjxk
aXYgY2xhc3M9IiI+VGhhbmsgeW91IGZvciB0aGUgY2xhcmlmaWNhdGlvbnMuIEkgd2FzIHJldmlz
aXRpbmcgdGhlIHRleHQgdG8gc2VlIHdheXMgdG8gbWFrZSB0aGVzZSBjbGFyaWZpY2F0aW9ucywg
aG93ZXZlciBJIGZpbmQgbXlzZWxmIHVuc3VyZSBvZiB0aGUgbmVlZDsgcGxlYXNlIHNlZSBjb21t
ZW50cyBiZWxvdzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNs
YXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxpIGNsYXNzPSIiPlNlY3Rp
b24gMy4xIGNsYXJpZmljYXRpb248L2k+PC9kaXY+PGRpdiBjbGFzcz0iIj48aSBjbGFzcz0iIj48
YnIgY2xhc3M9IiI+PC9pPjwvZGl2PjxkaXYgY2xhc3M9IiI+VG93YXJkcyB0aGUgZW5kIG9mIFNl
Y3Rpb24gMy4xIHdlIGFjdHVhbGx5IHNheSB0aGUgZm9sbG93aW5nOjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48Zm9udCBm
YWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO1RoZSBTWU4gd2l0aCBNUF9DQVBBQkxF
IG9jY3VwaWVzIHRoZSBmaXJzdCBvY3RldCBvZiBkYXRhIHNlcXVlbmNlIHNwYWNlLCBhbHRob3Vn
aCB0aGlzIGRvZXMgbm90IG5lZWQgdG8gYmUgYWNrbm93bGVkZ2VkIGF0IHRoZSBjb25uZWN0aW9u
IGxldmVsIHVudGlsIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQgKHNlZSBTZWN0aW9uIDMuMykuPC9m
b250PjwvZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPldoaWNoIHdvdWxkIHNl
ZW0gdG8gY292ZXIgZXhhY3RseSB0aGlzIGNvbmNlcm4uPC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9j
a3F1b3RlPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+SSdt
IG5vdCBzdXJlIGhvdyBpdCBjb3ZlcnMgdGhlIGNvbmNlcm4sIGJlY2F1c2UgdGhlIGlzc3VlIEkg
cmFpc2UgaXMgdGhhdCB0aGUgY2xpZW50IG5lZWRzIHRvIHNvbWVob3cgZmluZCBvdXQgaWYgdGhl
IE1QX0NBUEFCTEUgbWFkZSBpdCB0byB0aGUgcmVjZWl2ZXIuIEFuZCB0aGUgY2xhcmlmaWNhdGlv
biBJIHN1Z2dlc3QgaXMgdG8gc3BlbGwgb3V0IHRoYXQgaXQgaXMgdGhlIERBVEFfQUNLIChzZWUg
bXkgbmV4dCBjb21tZW50KS48L2Rpdj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiIHN0eWxlPSJ3b3JkLXdyYXA6
IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXIt
d2hpdGUtc3BhY2U7Ij48ZGl2IGNsYXNzPSIiPkhvd2V2ZXIgaWYgeW91IHN0aWxsIGZlZWwgZnVy
dGhlciBjbGFyaWZpY2F0aW9uIGlzIHJlcXVpcmVkLCB0aGVuIHdlIGNvdWxkIGFkZCB0aGlzIGFs
c28gdG8gdGhlIHNlbnRlbmNlIHlvdSBzdWdnZXN0LCBpLmUuOjwvZGl2PjxkaXYgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNl
PSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0lmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJz
dCwgdGhlbiB0aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyArIE1QX0NBUEFCTEUgY2Fu
IGJlIGluZmVycmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3aXRoIGFuIE1QVENQIERh
dGEgU2VxdWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlvbiAzLjMpLiZuYnNwOzwvZm9u
dD48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFz
cz0iIj5UaGUgYW1iaWd1aXR5IGhlcmUgaXMgdGhhdCBEU1MgZG9lcyBub3QgaW1wbHkgREFUQV9B
Q0suIE9uZSBjb3VsZCBzZW5kIGEgRFNTIHdpdGhvdXQgYSBEQVRBX0FDSywgYnV0IHRoYXQgd291
bGQgbm90IHNpZ25hbCB0byB0aGUgY2xpZW50IHRoZSByZWxpYWJsZSBkZWxpdmVyeSBvZiB0aGUg
TVBfQ0FQQUJMRS4gT25seSB0aGUgREFUQV9BQ0sgd2lsbCBkbyBzby48L2Rpdj48L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+T0sgd2VsbCBt
YXliZSBJIGFtIG5vdCB1bmRlcnN0YW5kaW5nIHlvdXIgY29uY2VybiBoZXJlLiBUaGUgZmlyc3Qg
c2VudGVuY2UgSSBxdW90ZSBzYXlzIHRoYXQgdGhlIE1QX0NBUEFCTEUgbmVlZHMgdG8gYmUgREFU
QV9BQ0tlZCB3aGVuIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQuPC9kaXY+PC9kaXY+PC9kaXY+PC9k
aXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+QWN0dWFsbHksIHN0
cmljdGx5IHJlYWRpbmcsIHRoZSBmaXJzdCBzZW50ZW5jZSBzYXlzIHRoYXQgaXQgbXVzdCA8YiBj
bGFzcz0iIj5ub3Q8L2I+IGJlIGFja25vd2xlZGdlZCB1bnRpbCBmaXJzdCBkYXRhIHNlbnQuIEl0
IGRvZXMgbm90IHNheSB0aGF0IGEgTVBfQ0FQQUJMRSBNVVNUIGJlIERBVEFfQUNLZWQuPC9kaXY+
PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9
IiI+PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTog
c3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyIgY2xhc3M9IiI+PGRpdiBjbGFz
cz0iIj48ZGl2IGNsYXNzPSIiPlRoZSBzZW50ZW5jZSBiZWdpbm5pbmcg4oCcSWYgQiBoYXMgRGF0
YSB0byBzZW5kIGZpcnN04oCdIG1lYW5zOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PjwvZGl2PjxkaXYgY2xhc3M9IiI+LSBBLSZndDtCIFNZTjwvZGl2PjxkaXYgY2xhc3M9IiI+LSBC
LSZndDtBIFNZTi9BQ0sgKyBNUF9DQVBBQkxFPC9kaXY+PGRpdiBjbGFzcz0iIj4tIEEtJmd0O0Ig
QUNLICsgTVBfQ0FQQUJMRTwvZGl2PjxkaXYgY2xhc3M9IiI+LSBCLSZndDtBIEFDSyArIERBVEEg
KyBEU1M8YnIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBj
bGFzcz0iIj5EU1MgY2FuIGNvbnRhaW4gb25lIG9yIGJvdGggb2YgRFNNIGFuZCBEQVRBX0FDSy4g
SG93ZXZlciB0aGUgcHJldmlvdXNseSBxdW90ZWQgc2VudGVuY2Ugc2F5cyB0aGF0IHRoZSBNUF9D
QVBBQkxFIG5lZWRzIHRvIGJlIGFja25vd2xlZGdlZCBhdCB0aGUgY29ubmVjdGlvbi1sZXZlbCAo
aS5lLiBEQVRBX0FDS2VkKSB3aGVuIHRoZSBmaXJzdCBkYXRhIGlzIHNlbnQuPC9kaXY+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj5Ib3dldmVyIGluIHdyaXRp
bmcgdGhpcyBJIHJlYWxpc2UgdGhhdCB0aGF0IHRleHQgbWFrZXMgbm8gY29tbWVudCBhYm91dCB3
aG8gaXMgc2VuZGluZyBkYXRhLiBCZWNhdXNlIHRoZSBpbnRlbnRpb24gaXMgaXQgYXBwbGllcyB0
byBhbnkgZGF0YSBiZWluZyBzZW50IChpZiBCIGlzIHNlbmRpbmcsIHRoZW4gaXQgd2lsbCBpbmNs
dWRlIGEgREFUQV9BQ0sgYXMgd2VsbCBhcyBhIERTUzsgaWYgQSBpcyBzZW5kaW5nIHRoZW4gQiB3
aWxsIGFja25vd2xlZGdlIHdpdGggYSBEQVRBX0FDSyksIGJ1dCBpdCBjb3VsZCBiZSByZWFkIGJ5
IHNvbWVvbmUgdG8gbWVhbiZuYnNwO+KAnG9ubHkgd2hlbiBhY2tub3dsZWRnaW5nIHRoZSBmaXJz
dCBkYXRhIGRvZXMgdGhlIE1QX0NBUEFCTEUgbmVlZCB0byBiZSBpbmNsdWRlZCBpbiB0aGUgREFU
QV9BQ0vigJ0sIHdoaWNoIGlzIG5vdCB0aGUgZGVzaXJlZCBtZWFuaW5nLjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+SSBhbSBhbGwgZm9yIGltcHJv
dmluZyBjbGFyaXR5IHNvIEkgdGhpbmsgYSBjbGVhcmVyIHZlcnNpb24gb2Yg4oCcSWYgQiBoYXMg
ZGF0YeKApuKAnSB3b3VsZCBnbzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7
IElmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhlbiB0aGUgcmVsaWFibGUgZGVsaXZlcnkg
b2YgdGhlIEFDSyArIE1QX0NBUEFCTEUgaXMgZW5zdXJlZCBieSB0aGUgcmVjZWlwdCBvZiB0aGlz
IGRhdGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNlcXVlbmNlIFNpZ25hbCAoRFNTKSBvcHRpb24gKFNl
Y3Rpb24gMy4zKSBjb250YWluaW5nIGEgREFUQV9BQ0sgZm9yIHRoZSBNUF9DQVBBQkxFJm5ic3A7
KHdoaWNoIGlzIHRoZSBmaXJzdCBvY3RldCBvZiB0aGUgZGF0YSBzZXF1ZW5jZSBzcGFjZSkuPC9m
b250PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+
V291bGQgeW91IGJlIG9rIHdpdGggdGhhdD8gSXQgaXMgc2hvcnRlciB0aGFuIHRoZSBvdGhlciBl
ZGl0cyB3aGlsc3Qgc3RpbGwgYmVpbmcgdW5hbWJpZ3VvdXMuPC9kaXY+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+VGhpcyBo
b3dldmVyIGRvZXMgbm90IHNheSB0aGF0IHRoZSByZWNlcHRpb24gZm8gYSBEQVRBX0FDSyBhbGxv
d3MgQSB0byBzdG9wIHNlbmRpbmcgdGhlIE1QX0NBUEFCTEUuIEkgc3RpbGwgdGhpbmsgdGhhdCBp
dCBzaG91bGQgYmUgc3BlbGxlZCBvdXQgc29tZXdoZXJlLjwvZGl2PjxiciBjbGFzcz0iIj48Ymxv
Y2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgc3R5bGU9Indv
cmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFr
OiBhZnRlci13aGl0ZS1zcGFjZTsiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFz
cz0iIj48ZGl2IHN0eWxlPSJjYXJldC1jb2xvcjogcmdiKDAsIDAsIDApOyBmb250LWZhbWlseTog
SGVsdmV0aWNhOyBmb250LXNpemU6IDEycHg7IGZvbnQtc3R5bGU6IG5vcm1hbDsgZm9udC12YXJp
YW50LWNhcHM6IG5vcm1hbDsgZm9udC13ZWlnaHQ6IG5vcm1hbDsgbGV0dGVyLXNwYWNpbmc6IG5v
cm1hbDsgdGV4dC1hbGlnbjogc3RhcnQ7IHRleHQtaW5kZW50OiAwcHg7IHRleHQtdHJhbnNmb3Jt
OiBub25lOyB3aGl0ZS1zcGFjZTogbm9ybWFsOyB3b3JkLXNwYWNpbmc6IDBweDsgLXdlYmtpdC10
ZXh0LXN0cm9rZS13aWR0aDogMHB4OyB0ZXh0LWRlY29yYXRpb246IG5vbmU7IiBjbGFzcz0iIj48
YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9
IiIgc3R5bGU9IndvcmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNl
OyBsaW5lLWJyZWFrOiBhZnRlci13aGl0ZS1zcGFjZTsiPjxkaXYgY2xhc3M9IiI+Q2FuIGNoYW5n
ZSB0bzo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIi
PjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtJ
ZiBCIGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9m
IHRoZSBBQ0sgKyBNUF9DQVBBQkxFIGNhbiBiZSBpbmZlcnJlZCBieSB0aGUgcmVjZWlwdCBvZiB0
aGlzIGRhdGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNlcXVlbmNlIFNpZ25hbCAoRFNTKSBvcHRpb24g
KFNlY3Rpb24gMy4zKSBjb250YWluaW5nIGEgREFUQV9BQ0sgZm9yIHRoZSBNUF9DQVBBQkxFICh3
aGljaCBpcyB0aGUgZmlyc3Qgb2N0ZXQgb2YgdGhlIGRhdGEgc2VxdWVuY2Ugc3BhY2UpLiZuYnNw
O0Z1cnRoZXJtb3JlLCB3aGVuIEEgcmVjZWl2ZXMgYSBEQVRBX0FDSyBmcm9tIEIgaXQgaXMgYSBz
aWduYWwgb2YgdGhlIHJlbGlhYmxlIGRlbGl2ZXJ5IG9mIEEncyBNUF9DQVBBQkxFLjwvZm9udD48
L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIi
PlBsZWFzZSBjb25maXJtIGlmIHlvdSBzdGlsbCBmZWVsIHRoaXMgaXMgbmVjZXNzYXJ5LCBnaXZl
biB0aGUgcXVvdGUgSSBwcm92aWRlLjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPlllcywgSSBzdGlsbCBm
ZWVsIHRoYXQgdGhpcyBpcyBuZWNlc3NhcnkuPC9kaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3Rl
IHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIiBzdHlsZT0i
d29yZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJl
YWs6IGFmdGVyLXdoaXRlLXNwYWNlOyI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+
PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj48aSBjbGFzcz0i
Ij5FYXJseSBNYXBwaW5nPC9pPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2
PjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5sbyIgY2xhc3M9IiI+
Jm5ic3A7ICZuYnNwO0EgRGF0YSBTZXF1ZW5jZSBNYXBwaW5nIGRvZXMgbm90IG5lZWQgdG8gYmUg
aW5jbHVkZWQgaW4gZXZlcnkgTVBUQ1A8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48Zm9udCBm
YWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3BhY2tldCwgYXMgbG9uZyBhcyB0aGUg
c3ViZmxvdyBzZXF1ZW5jZSBzcGFjZSBpbiB0aGF0IHBhY2tldCBpczwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7Y292ZXJl
ZCBieSBhIG1hcHBpbmcga25vd24gYXQgdGhlIHJlY2VpdmVyLiAmbmJzcDtUaGlzIGNhbiBiZSB1
c2VkIHRvPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNz
PSIiPiZuYnNwOyAmbmJzcDtyZWR1Y2Ugb3ZlcmhlYWQgaW4gY2FzZXMgd2hlcmUgdGhlIG1hcHBp
bmcgaXMga25vd24gaW4gYWR2YW5jZS4gJm5ic3A7T25lPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtzdWNoIGNhc2UgaXMg
d2hlbiB0aGVyZSBpcyBhIHNpbmdsZSBzdWJmbG93IGJldHdlZW4gdGhlIGhvc3RzLCBhbmQ8L2Zv
bnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7
ICZuYnNwO2Fub3RoZXIgaXMgd2hlbiBzZWdtZW50cyBvZiBkYXRhIGFyZSBzY2hlZHVsZWQgaW4g
bGFyZ2VyLXRoYW4tcGFja2V0LTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9
Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7c2l6ZWQgY2h1bmtzLjwvZm9udD48L2Rpdj48
L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkkgd291
bGQgc3VnZ2VzdCBzaW1wbHkgYWRkaW5nIGEgc2VudGVuY2UgYXQgdGhlIGJlZ2lubmluZyBzYXlp
bmc8c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+PGkgY2xh
c3M9IiI+4oCcQSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgTVVTVCBhcHBlYXIgb24gYSBUQ1Agc2Vn
bWVudCB3aGljaCBpcyBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5n4oCdLjwvaT48L2Rpdj48L2Rpdj48
L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBj
bGFzcz0iIj5ZZXMsIGFkZGluZyB0aGF0IHNlbnRlbmNlIHdvdWxkIGNsYXJpZnkgdGhpcy48L2Rp
dj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkkgYWxzbyB3
b3VsZCByZW1vdmUgdGhlIHNlbnRlbmNlICJUaGlzIGNhbiBiZSB1c2VkIHRvLi4uIiBhbmQgIk9u
ZSBzdWNoIGNhc2UgaXMuLi4iIC0gaXQgYWRkcyB0byB0aGUgY29uZnVzaW9uIElNTy48L2Rpdj48
L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+
PGRpdiBjbGFzcz0iIj5JIHF1aXRlIGxpa2UgdG8gcmV0YWluIGV4YW1wbGVzIHdoZXJlIHBvc3Np
YmxlOyB0aGVzZSBzZWVtIGhhcm1sZXNzIHdoZW4gY29tYmluZWQgd2l0aCB0aGUgY2xhcmlmaWNh
dGlvbiBmcm9tIHRoZSBNVVNULCBpdCBlbnN1cmVzIHBlb3BsZSBiZWhhdmUhPC9kaXY+PC9kaXY+
PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXY+T2ssIGZhaXIgZW5vdWdoITwvZGl2PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+PGJy
IGNsYXNzPSIiPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+Q2hyaXN0b3BoPC9kaXY+PGJy
IGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+
PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3Bh
Y2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyIgY2xhc3M9IiI+PGRpdiBjbGFzcz0i
Ij48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xh
c3M9IiI+QmVzdCByZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9IiI+QWxhbjwvZGl2PjxiciBjbGFz
cz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYg
c3R5bGU9ImNhcmV0LWNvbG9yOiByZ2IoMCwgMCwgMCk7IGZvbnQtZmFtaWx5OiBIZWx2ZXRpY2E7
IGZvbnQtc2l6ZTogMTJweDsgZm9udC1zdHlsZTogbm9ybWFsOyBmb250LXZhcmlhbnQtY2Fwczog
bm9ybWFsOyBmb250LXdlaWdodDogbm9ybWFsOyBsZXR0ZXItc3BhY2luZzogbm9ybWFsOyB0ZXh0
LWFsaWduOiBzdGFydDsgdGV4dC1pbmRlbnQ6IDBweDsgdGV4dC10cmFuc2Zvcm06IG5vbmU7IHdo
aXRlLXNwYWNlOiBub3JtYWw7IHdvcmQtc3BhY2luZzogMHB4OyAtd2Via2l0LXRleHQtc3Ryb2tl
LXdpZHRoOiAwcHg7IHRleHQtZGVjb3JhdGlvbjogbm9uZTsiIGNsYXNzPSIiPjxibG9ja3F1b3Rl
IHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIiBzdHlsZT0i
d29yZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJl
YWs6IGFmdGVyLXdoaXRlLXNwYWNlOyI+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+
PGRpdiBjbGFzcz0iIj5SZWdhcmRpbmcgbGF0ZSBtYXBwaW5nLCB3ZSBzYXk6PC9kaXY+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxm
b250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7SW1wbGVtZW50YXRpb25zIE1B
WSBob2xkIG9udG8gc3VjaCB1bm1hcHBlZCBkYXRhIGZvciBhPC9mb250PjwvZGl2PjxkaXYgY2xh
c3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtzaG9ydCB3aGls
ZSwgaW4gdGhlIGV4cGVjdGF0aW9uIHRoYXQgYSBtYXBwaW5nIHdpbGwgYXJyaXZlIHNob3J0bHku
PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZu
YnNwOyAmbmJzcDtTdWNoIHVubWFwcGVkIGRhdGEgY2Fubm90IGJlIGNvdW50ZWQgYXMgYmVpbmcg
d2l0aGluIHRoZSBjb25uZWN0aW9uLTwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSIiPjxmb250IGZh
Y2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7bGV2ZWwgcmVjZWl2ZSB3aW5kb3cgYmVj
YXVzZSB0aGlzIGlzIHJlbGF0aXZlIHRvIHRoZSBkYXRhIHNlcXVlbmNlPC9mb250PjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtudW1i
ZXJzLCBzbyBpZiB0aGUgcmVjZWl2ZXIgcnVucyBvdXQgb2YgbWVtb3J5IHRvIGhvbGQgdGhpcyBk
YXRhLCBpdDwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFz
cz0iIj4mbmJzcDsgJm5ic3A7d2lsbCBoYXZlIHRvIGJlIGRpc2NhcmRlZC4gJm5ic3A7SWYgYSBt
YXBwaW5nIGZvciB0aGF0IHN1YmZsb3ctbGV2ZWw8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48
Zm9udCBmYWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3NlcXVlbmNlIHNwYWNlIGRv
ZXMgbm90IGFycml2ZSB3aXRoaW4gYSByZWNlaXZlIHdpbmRvdyBvZiBkYXRhLCB0aGF0PC9mb250
PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAm
bmJzcDtzdWJmbG93IFNIT1VMRCBiZSB0cmVhdGVkIGFzIGJyb2tlbiwgY2xvc2VkIHdpdGggYSBS
U1QsIGFuZCBhbnk8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5sbyIg
Y2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3VubWFwcGVkIGRhdGEgc2lsZW50bHkgZGlzY2FyZGVkLjwv
Zm9udD48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNs
YXNzPSIiPk5vdGUgdGhlIGxhc3Qgc2VudGVuY2UuIFdlIGFscmVhZHkgYm91bmQgdGhpcyBzdWdn
ZXN0aW9uIHRvIGp1c3QgYSBzdWJmbG93IHJlY2VpdmUgd2luZG93IG9mIGRhdGEsIGFuZCBwcm92
aWRlIGEgbWVjaGFuaXNtIHRvIHJlamVjdCAoUlNUIGFuZCBzaWxlbnRseSBkaXNjYXJkKS4gSWYg
d2UgYWRkIHRoZSBhYm92ZSB0ZXh0IHJlIGVhcmx5IG1hcHBpbmcgdGhhdCB3b3VsZCBhbHNvIGFw
cGx5IGluIHRoaXMgY2FzZSBhbmQgcHJvdmlkZSB5b3VyIHJlcXVpcmVtZW50IHRoYXQgdGhlIG1h
cHBpbmcgbGFuZHMgb24gYSBzZWdtZW50IGNvdmVyZWQgYnkgdGhlIG1hcHBpbmcuPC9kaXY+PC9k
aXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
aXYgY2xhc3M9IiI+WWVzLCB0aGlzIGxhc3Qgc2VudGVuY2UsIGNvbWJpbmVkIHdpdGggdGhlIGFi
b3ZlLW1lbnRpb25lZCBhZGRpdGlvbiBzaG91bGQgbWFrZSB0aGluZ3MgZmluZS48L2Rpdj48ZGl2
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48
L2Rpdj48ZGl2IGNsYXNzPSIiPlRoYW5rcyw8L2Rpdj48ZGl2IGNsYXNzPSIiPkNocmlzdG9waDwv
ZGl2PjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNs
YXNzPSIiPjxkaXYgY2xhc3M9IiIgc3R5bGU9IndvcmQtd3JhcDogYnJlYWstd29yZDsgLXdlYmtp
dC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFrOiBhZnRlci13aGl0ZS1zcGFjZTsiPjxkaXYg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QW55IHRob3VnaHRzPzwv
ZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+QmVzdCBy
ZWdhcmRzLDwvZGl2PjxkaXYgY2xhc3M9IiI+QWxhbjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRp
diBjbGFzcz0iIj5PbiAyIERlYyAyMDE5LCBhdCAxNzoyNywgQ2hyaXN0b3BoIFBhYXNjaCAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmNwYWFzY2hAYXBwbGUuY29tIiBjbGFzcz0iIj5jcGFhc2NoQGFwcGxl
LmNvbTwvYT4mZ3Q7IHdyb3RlOjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3
bGluZSI+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPkhlbGxvIEFsYW4sPGJyIGNsYXNzPSIi
PjxiciBjbGFzcz0iIj5PbiAyOS8xMS8xOSAtIDIxOjEzOjM4LCBBbGFuIEZvcmQgd3JvdGU6PGJy
IGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIGNsYXNzPSIiPk9uIDI4IE5vdiAyMDE5LCBhdCAxOTo0OSwgQ2hyaXN0b3BoIFBh
YXNjaCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNwYWFzY2hAYXBwbGUuY29tIiBjbGFzcz0iIj5jcGFh
c2NoQGFwcGxlLmNvbTwvYT4mZ3Q7IHdyb3RlOjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBl
PSJjaXRlIiBjbGFzcz0iIj5PbiBOb3YgMjgsIDIwMTksIGF0IDg6MTYgQU0sIEFsYW4gRm9yZCAm
bHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb20iIGNsYXNzPSIiPmFsYW4uZm9y
ZEBnbWFpbC5jb208L2E+PHNwYW4gY2xhc3M9IkFwcGxlLWNvbnZlcnRlZC1zcGFjZSI+Jm5ic3A7
PC9zcGFuPiZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5mb3JkQGdtYWlsLmNvbSIgY2xhc3M9IiI+
bWFpbHRvOmFsYW4uZm9yZEBnbWFpbC5jb208L2E+Jmd0OyZndDsgd3JvdGU6PGJyIGNsYXNzPSIi
PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPk9uIDI3IE5vdiAyMDE5LCBhdCAxOToy
OSwgQ2hyaXN0b3BoIFBhYXNjaCAmbHQ7PGEgaHJlZj0ibWFpbHRvOmNwYWFzY2hAYXBwbGUuY29t
IiBjbGFzcz0iIj5jcGFhc2NoQGFwcGxlLmNvbTwvYT48c3BhbiBjbGFzcz0iQXBwbGUtY29udmVy
dGVkLXNwYWNlIj4mbmJzcDs8L3NwYW4+Jmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxl
LmNvbSIgY2xhc3M9IiI+bWFpbHRvOmNwYWFzY2hAYXBwbGUuY29tPC9hPiZndDsmZ3Q7IHdyb3Rl
OjxiciBjbGFzcz0iIj5TZWN0aW9uIDMuMy4xLCBwYWdlIDMyICZhbXA7IDMzLCAiQSBkYXRhIHNl
cXVlbmNlIG1hcHBpbmcgZG9lcyBub3QgbmVlZC4uLiI8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PlRoaXMgcGFyYWdyYXBoIHN0YXRlcyB0aGF0IGl0IGlzIHBlcm1pc3NpdmUgdG8gc2VuZCBhIG1h
cHBpbmcgaW4gYWR2YW5jZS4gTGF0ZS1tYXBwaW5nIGlzIHNwZWNpZmllZCBhIGJpdCBoaWdoZXIg
YXJvdW5kIHRoZSBzZW50ZW5jZTxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZu
YnNwOzwvc3Bhbj48YnIgY2xhc3M9IiI+IkltcGxlbWVudGF0aW9ucyBNQVkgaG9sZCBvbnRvIHN1
Y2ggdW5tYXBwZWQgZGF0YSBmb3IgYSBzaG9ydCB3aGlsZSBpbiB0aGUgZXhwZWN0YXRpb24gdGhh
dCBhIG1hcHBpbmcgd2lsbCBhcnJpdmUgc2hvcnRseSI8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PlRoaXMga2luZCBvZiBlYXJseS9sYXRlIG1hcHBpbmcgYW5ub3VuY2VtZW50cyBhcmUgZGlmZmlj
dWx0IHRvIGhhbmRsZSBpbiBhbiBpbXBsZW1lbnRhdGlvbi4gVGhlIExpbnV4IEtlcm5lbCBpbXBs
ZW1lbnRhdGlvbiBvZjxzcGFuIGNsYXNzPSJBcHBsZS1jb252ZXJ0ZWQtc3BhY2UiPiZuYnNwOzwv
c3Bhbj48YSBocmVmPSJodHRwOi8vbXVsdGlwYXRoLXRjcC5vcmcvIiBjbGFzcz0iIj5tdWx0aXBh
dGgtdGNwLm9yZzwvYT48c3BhbiBjbGFzcz0iQXBwbGUtY29udmVydGVkLXNwYWNlIj4mbmJzcDs8
L3NwYW4+Jmx0OzxhIGhyZWY9Imh0dHA6Ly9tdWx0aXBhdGgtdGNwLm9yZy8iIGNsYXNzPSIiPmh0
dHA6Ly9tdWx0aXBhdGgtdGNwLm9yZy88L2E+Jmd0OyBoYXMgYWx3YXlzIGRpc2FsbG93ZWQgc3Vj
aCBraW5kIG9mIG1hcHBpbmdzLiBNZWFuaW5nLCB3aGVuZXZlciBhIERTUy1vcHRpb24gaXMgcmVj
ZWl2ZWQgc3VjaCB0aGF0IHRoZSByYW5nZSBzcGVjaWZpZWQgYnkgdGhlIHJlbGF0aXZlIHN1YmZs
b3ctc2VxdWVuY2UgbnVtYmVyIGluIHRoZSBEU1Mtb3B0aW9uIGFuZCB0aGUgZGF0YS1sZW5ndGgg
ZG9lcyBub3QgKHBhcnRpYWxseSkgY292ZXIgdGhlIFRDUCBzZXF1ZW5jZSBudW1iZXIgb2YgdGhl
IHBhY2tldCBpdHNlbGYsIHRoZSBzdWJmbG93IHdpbGwgYmUga2lsbGVkIHdpdGggYSBUQ1AtUlNU
LiBUaGUgcHJvYmxlbSBhcm91bmQgaGFuZGxpbmcgc3VjaCBlYXJseS9sYXRlIG1hcHBpbmdzIGlz
IHRoYXQgaXQgaXMgdW5jbGVhciBmb3IgaG93IGxvbmcgdGhlIHN0YWNrIG5lZWRzIHRvIHJlbWVt
YmVyIHRoZXNlIG1hcHBpbmdzIChpbiB0aGUgZWFybHktbWFwcGluZyBjYXNlKSwgb3IgZm9yIGhv
dyBsb25nIGhlIG5lZWRzIHRvIGhvbGQgb24gdG8gdGhlIGRhdGEgKGluIHRoZSBsYXRlLW1hcHBp
bmcgY2FzZSkuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5XZSB0aHVzIHN1Z2dlc3QgdG8gY2hh
bmdlIHRoaXMgdG8gdGhlIGZvbGxvd2luZzo8YnIgY2xhc3M9IiI+V2hlbmV2ZXIgYSBEU1Mtb3B0
aW9uIGlzIHJlY2VpdmVkIG9uIGEgcGFja2V0IHN1Y2ggdGhhdCB0aGUgbWFwcGluZyBvZiB0aGUg
c3ViZmxvdy1zZXF1ZW5jZSBzcGFjZSBkb2VzIG5vdCBwYXJ0aWFsbHkgY292ZXIgdGhlIFRDUC1z
ZXF1ZW5jZSBudW1iZXIgb2YgJm5ic3A7dGhlIHBhY2tldCBpdHNlbGYsIHRoZSBob3N0IE1VU1Qg
ZGlzY2FyZCB0aGlzIG1hcHBpbmcgYW5kIE1BWSBkZXN0cm95IHRoZSBzdWJmbG93IHdpdGggYSBU
Q1AtUlNULiBJdCBzaG91bGQgYmUgbm90ZWQgdGhhdCBhIERBVEFfRklOIHRoYXQgZG9lcyBub3Qg
Y29tZSB3aXRoIGRhdGEgaGFzIGEgcmVsYXRpdmUgc3ViZmxvdy1zZXF1ZW5jZSBudW1iZXIgb2Yg
MCBhbmQgdGh1cyBzaG91bGQgYmUgaGFuZGxlZCBzZXBhcmF0ZWx5LjxiciBjbGFzcz0iIj48L2Js
b2NrcXVvdGU+PGJyIGNsYXNzPSIiPlRoaXMgb25lIEkgZG8gaGF2ZSBhbiBpc3N1ZSB3aXRoOjxi
ciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+LSBJdCBpcyBhIHRlY2huaWNhbCBjaGFuZ2U8YnIgY2xh
c3M9IiI+LSBXb3JkaW5nIHRvIHRoaXMgZWZmZWN0IGhhcyBiZWVuIGluIHRoZSBkb2N1bWVudCBz
aW5jZSBwcmV0dHkgbXVjaCB0aGUgYmVnaW5uaW5nPGJyIGNsYXNzPSIiPi0gSXQgaXMgYSBNQVkg
d2hpY2ggbWlnaHQgYXMgd2VsbCBzYXkg4oCcdGhlcmUgaXMgbm8gZ3VhcmFudGVlIHRoaXMgd291
bGQgd29ya+KAnTxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPlRoZSBwcm9i
bGVtIHdpdGggdGhlIE1BWSBpcyB0aGF0IHRoZSBzZW5kZXIgY2FuJ3QgcmVhbGx5IGtub3cgaWYg
dGhlIHJlY2VpdmVyIGFjY2VwdHMgaXQgKG1vcmUgcmVnYXJkaW5nIHRoaXMgYmVsb3cpPGJyIGNs
YXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5Nb3N0
IGltcG9ydGFudGx5LCB0aGUgcmVwbGFjZW1lbnQgdGV4dCBzZWVtcyBub3QgdG8gYWRkcmVzcyB0
aGlzIGlzc3VlIGF0IGFsbC4gSWYgSSByZWFkIGl0IGNvcnJlY3RseSwgaXQgc2F5cyB0aGF0IHRo
ZSBkYXRhIHNlcXVlbmNlIG1hcHBpbmcgb3B0aW9uIE1VU1QgcGFydGlhbGx5IGNvdmVyIHRoZSBz
dWJmbG93IHNlcXVlbmNlIHNwYWNlIG9mIHRoZSBwYWNrZXQgaXRzZWxmLiBCdXQgdGhhdCBoYXMg
bm90aGluZyB0byBkbyB3aXRoIGxhdGUgb3IgZWFybHkgbWFwcGluZywgYm90aCBjb3VsZCBwYXJ0
aWFsbHkgY292ZXIgdGhlIHN1YmZsb3cgc2VxdWVuY2Ugc3BhY2UgYW5kIHByZWNlZGluZyBkYXRh
LjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+Q2FuIHlvdSBjbGFyaWZ5IGV4YWN0bHkgd2hhdCB5
b3Ugd2FudCB0byBwZXJtaXQgYW5kIHByZXZlbnQsIGhlcmU/PGJyIGNsYXNzPSIiPjwvYmxvY2tx
dW90ZT48YnIgY2xhc3M9IiI+TGV0IG1lIHRyeSB0byBjbGFyaWZ5IHdoYXQgZXhhY3RseSB3ZSBt
ZWFuIHdpdGggZWFybHkvbGF0ZSBtYXBwaW5nIHNvIHRoYXQgd2UgYXJlIGFsbCBvbiB0aGUgc2Ft
ZSB0ZXJtcyBoZXJlOjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+RWFybHkgbWFwcGluZzo8YnIg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPkEgVENQLXNlZ21lbnQgd2l0aCBzZXF1ZW5jZS1udW1iZXIg
MSBob2xkcyBhIERTUy1vcHRpb24gd2l0aCBzdWJmbG93LXNlcXVlbmNlIG51bWJlciAxMDAxIGFu
ZCBkYXRhLWxlbmd0aCAxMDAuIFRoaXMgbWVhbnMgd2UgbmVlZCB0byBhbGxvY2F0ZSBzcGFjZSB0
byBzdG9yZSB0aGlzIERTUy1vcHRpb24gc28gdGhhdCB3aGVuIHRoZSBUQ1Atc2VnbWVudCB3aXRo
IHNlcW5vIDEwMDEgYXJyaXZlcyB3ZSBjYW4ga25vdyB0aGUgbWFwcGluZy4gVGhlcmUgbWF5IGJl
IGNvbWluZyBtb3JlIG9mIHRoZXNlIERTUy1vcHRpb25zIHdoaWNoIGFsbCBuZWVkIHRvIGJlIHN0
b3JlZCBpbiBhbGxvY2F0ZWQgbWVtb3J5LiBJdCBpcyB1bmNsZWFyIHdoYXQgdGhlIGxpbWl0IHRv
IHRoaXMgaXMgYW5kIHRoZXJlIGlzIG5vIHdheSB0byBjb21tdW5pY2F0ZSB0aGlzIGxpbWl0IHRv
IHRoZSBzZW5kZXIuPGJyIGNsYXNzPSIiPjwvYmxvY2txdW90ZT48YnIgY2xhc3M9IiI+SSBkb27i
gJl0IHRoaW5rIHdlIGhhdmUgZXZlciBpbnRlbmRlZCB0byBzdXBwb3J0IGEgbWFwcGluZyBsaWtl
IHRoaXMuIElmIHRoZSB0ZXh0IGlzIG5vdCBjbGVhciBoZXJlIHRoZW4geWVzLCB3ZSBtaWdodCBo
YXZlIGFuIGlzc3VlLjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPlllcywg
SSBkbyB0aGluayB0aGF0IHRoZSB0ZXh0IGlzIG5vdCB2ZXJ5IGNsZWFyIG9uIHRoYXQgJm5ic3A7
LSB3ZSBzaG91bGQgY2xhcmlmeTxiciBjbGFzcz0iIj50aGF0LjxiciBjbGFzcz0iIj48YnIgY2xh
c3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+V2UgaW50ZW5kIG9ubHkgdG8g
c3VwcG9ydDogQSBUQ1Agc2VnbWVudCB3aXRoIHNlcXVlbmNlLW51bWJlciAxIGhvbGRzIGEgRFNT
IG9wdGlvbiBmb3IgU1NOIDEgYW5kIGxlbmd0aCAxMDAwMCAoc28gbXVsdGlwbGUgc2VnbWVudHMg
aW4gdGhlIGZ1dHVyZSkuPGJyIGNsYXNzPSIiPjwvYmxvY2txdW90ZT48YnIgY2xhc3M9IiI+U291
bmRzIGdvb2QhPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRl
IiBjbGFzcz0iIj5Pciwgc2xpZ2h0bHkgbW9yZSBjb252b2x1dGVkLCBhIFRDUCBzZWdtZW50IHdp
dGggU04gMTAwLCBsZW5ndGggMTAwLCB3aGljaCBob2xkcyBhIERTUyBvcHRpb24gZm9yIDE1MS0y
NTAsIGFuZCBieXRlcyA1MC0xNTAgd2VyZSBhbHJlYWR5IGNvdmVyZWQgYnkgYSBwcmV2aW91cyBt
YXBwaW5nLjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPkFsc28gZ29vZC48
YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIi
PkkgZG8gbm90IGJlbGlldmUgd2UgaGF2ZSBldmVyIGludGVuZGVkIG1hcHBpbmdzIG9uIGRhdGEg
c2VnbWVudHMgd2hlcmUgdGhlIHNlZ21lbnRzIGRvIG5vdCBpbmNsdWRlIGFueSBvZiB0aGUgbWFw
cGVkIGRhdGEuIFdlIGRpZCwgaG93ZXZlciwgaW50ZW5kIHRvIHN1cHBvcnQgbWFwcGluZ3Mgb24g
cHVyZSBBQ0tzIGluIG9yZGVyIHRvIGF2b2lkIGFueSBvcHRpb24gc3BhY2UgbGltaXRzLjxiciBj
bGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPk1hcHBpbmdzIG9uIGEgcHVyZSBBQ0sg
YXJlIGFuIHVubGlrZWx5IHVzZS1jYXNlLiBUaGUgcHJvYmxlbSBpcyB0aGF0IGluIHRoZTxiciBj
bGFzcz0iIj5lbmQgdGhlIG1hcHBpbmcgbmVlZHMgdG8gcmVsaWFibHkgbWFrZSBpdCB0byB0aGUg
cmVjZWl2ZXIgYXMgb3RoZXJ3aXNlIGhlPGJyIGNsYXNzPSIiPm5lZWRzIHRvIHRocm93IHRoZSBk
YXRhIGF3YXkuIENvbWJpbmluZyBpdCB3aXRoIGRhdGEgaW1wbGljaXRseSBtYWtlcyBpdDxiciBj
bGFzcz0iIj5yZWxpYWJsZS48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPkluIGNhc2Ugb2Ygb3B0
aW9uLXNwYWNlIGxpbWl0cywgaXQgaXMgYmV0dGVyIHRvIHNlbmQgdGhlIG9wdGlvbnMgdGhhdCBk
bzxiciBjbGFzcz0iIj5jb25zdW1lIGEgbG90IG9mIHNwYWNlIChBRERfQUREUiwuLi4pIG9uIHRo
ZSBwdXJlIEFDSy48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNp
dGUiIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0i
Ij5MYXRlIG1hcHBpbmc6PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGUgcmVjZWl2ZXIgcmVj
ZWl2ZXMgZGF0YSB3aXRob3V0IERTUy1vcHRpb25zIHdpdGggVENQLXNlcXVlbmNlIDEgdG8gMTAw
MS4gVGhlIGNvcnJlc3BvbmRpbmcgRFNTLW9wdGlvbiBob3dldmVyIGFycml2ZXMgd2l0aCB0aGUg
VENQLXNlZ21lbnQgd2l0aCBzZXFubyAyMDAxLiBIZXJlLCB0aGUgcmVjZWl2ZXIgbmVlZHMgdG8g
aG9sZCBvbiB0byB0aGlzIGRhdGEsIHdhaXRpbmcgZm9yIHRoZSBUQ1Atc2VnbWVudCB3aXRoIHRo
ZSBEU1Mtb3B0aW9uLiBBdCBvbmUgcG9pbnQgdGhlIHJlY2VpdmVyIG5lZWRzIHRvIGRyb3AgdGhl
IGRhdGEgZHVlIHRvIG1lbW9yeSBsaW1pdHMuIEFnYWluLCB0aGUgc2VuZGVyIGhhcyBubyB3YXkg
Zm9yIGtub3dpbmcgd2hhdCB0aGlzIGxpbWl0IGlzLjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+
PGJyIGNsYXNzPSIiPlNvIHRoaXMgaXMgc2xpZ2h0bHkgbW9yZSBwcm9ibGVtYXRpYywgYW5kIHRo
aXMgaXMgd2hhdCB0aGUgTUFZIGluIHRoZSB0ZXh0IGlzIGRlc2lnbmVkIHRvIGRpc2N1c3MuPGJy
IGNsYXNzPSIiPjxiciBjbGFzcz0iIj5JIGJlbGlldmUgd2UgaGFkIGludGVuZGVkIHRvIHN1cHBv
cnQgYSBzaXR1YXRpb24gd2hlcmUgeW91IGNvdWxkIGhhdmUgYSBzZWdtZW50IDEtMTAwMCB3aXRo
b3V0IGEgRFNTIG9wdGlvbiwgYW5kIDEwMDEtMjAwMCBhbHNvIHdpdGhvdXQsIGFuZCB0aGVuIDIw
MDEtMzAwMCB3aXRoIHRoZSBvcHRpb24gdGhlbiBwcm92aWRpbmcgYSBtYXBwaW5nIGZvciAxIHRv
IDIwMDEgb3IgaGlnaGVyLjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPkkg
dGhpbmsgdGhpcyBzY2VuYXJpbyBpcyBmaW5lIHRvIHNvbWUgZXh0ZW5kIHdpdGggYSBzbGlnaHQg
Y2hhbmdlIHRoYXQgdGhlPGJyIGNsYXNzPSIiPnByb3ZpZGVkIG1hcHBpbmcgc2hvdWxkIGJlIGZv
ciAxIHRvIDIwMDIgb3IgaGlnaGVyICh0aHVzLCBpbmNsdWRpbmcgdGhlIGJ5dGU8YnIgY2xhc3M9
IiI+b2YgdGhlIDIwMDEtMzAwMCBzZWdtZW50KS48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxi
bG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPlRoaXMgd291bGQgYWxsb3cgYSBzZW5kZXIg
dG8gc3RhcnQgcHVzaGluZyBvdXQgZGF0YSBiZWZvcmUgaXQga25ldyB3aGF0IGEgbWFwcGluZyBt
aWdodCBsb29rIGxpa2UuPGJyIGNsYXNzPSIiPkl0IGRvZXMsIGhvd2V2ZXIsIHNlZW0gYW4gdW5s
aWtlbHkgc2l0dWF0aW9uIGJ1dCB5b3UgYXMgYSByZWNlaXZlciBjb3VsZCBvZiBjb3Vyc2UgcmVk
dWNlIHRoZSBzdWJmbG93IHdpbmRvdyBzaXplIGluIG9yZGVyIHRvIGxpbWl0IGJ1ZmZlcmluZy4g
VGhlIHRleHQgZG9lcyByZWNvZ25pc2UgdGhlIG1lbW9yeSBpc3N1ZSBhbmQgcG9pbnQgb3V0IHRo
YXQgdGhpcyB3b27igJl0IGJlIERBVEEgQUNLZWQgYW5kIGFzIHN1Y2ggYSBzZW5kZXIgc2hvdWxk
IHNvb24gcmVhbGlzZSBhbmQgcmV0cmFuc21pdCBvbiBhIHNlcGFyYXRlIHN1YmZsb3cgYW5kIHRo
ZW4gdGhpcyBzdWJmbG93IG1heSBldmVudHVhbGx5IGJlIGNsb3NlZC48YnIgY2xhc3M9IiI+PC9i
bG9ja3F1b3RlPjxiciBjbGFzcz0iIj5ZZXMsIGl0IHNlZW1zIGxpa2UgYW4gdW5saWtlcmx5IHNp
dHVhdGlvbiBhbmQgSSdtIG5vdCBzdXJlIGFib3V0IHRoZTxiciBjbGFzcz0iIj51c2UtY2FzZSBm
b3IgZG9pbmcgdGhpcy48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9
ImNpdGUiIGNsYXNzPSIiPkFub3RoZXIgc2l0dWF0aW9uIHdvdWxkIGludm9sdmUgdHdvIG1hcHBp
bmdzIG9uIHRoZSBzYW1lIFRDUCBzZWdtZW50LiBJZiB0aGUgZmlyc3QgNTAgYnl0ZXMgb2YgYSBz
ZWdtZW50IGFyZSBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5nIHByb3ZpZGVkIGluIHRoYXQgc2VnbWVu
dCwgYnV0IHRoZXJlIGFyZSB0aGVuIGFsc28gYW5vdGhlciA1MCBieXRlcywgdGhlbiB0aGUgbWFw
cGluZyBjYW7igJl0IGJlIHByb3ZpZGVkIHVudGlsIHRoZSBuZXh0IHNlZ21lbnQuPGJyIGNsYXNz
PSIiPjwvYmxvY2txdW90ZT48YnIgY2xhc3M9IiI+WWVzLCB0d28gbWFwcGluZ3Mgb24gYSBzaW5n
bGUgcGFja2V0IGFyZSBwcm9ibGVtYXRpYyBzaW1wbHkgYmVjYXVzZSBvZiB0aGU8YnIgY2xhc3M9
IiI+bGFjayBvZiBvcHRpb24tc3BhY2UuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5JIGd1ZXNzIG15IGluaXRpYWwgdGhvdWdodCBoZXJl
IGlzIHRoYXQgdGhpcyB3YXMgaW50ZW5kZWQgdG8gY292ZXIgYSBudW1iZXIgb2YgY29ybmVyIGNh
c2VzIGJ1dCBpZiBpdCBkb2VzIG5vdCB3b3JrIGZvciB5b3UgdGhlbiB0aGVyZSBhcmUgc2V2ZXJh
bCBjb21wbGlhbnQgd2F5cyBvZiBkZWFsaW5nIHdpdGggaXQuPGJyIGNsYXNzPSIiPjxiciBjbGFz
cz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5XaGVuIHRoZSBEU1Mtb3B0aW9u
IGNvbWVzIHRvZ2V0aGVyIHdpdGggdGhlIGNvcnJlc3BvbmRpbmcgVENQLXNlcXVlbmNlIGl0IGlz
IHN0cmFpZ2h0LWZvcndhcmQgdG8gc3RvcmUgaXQgdG9nZXRoZXIgd2l0aCB0aGUgZGF0YS4gVGhl
cmUgYXJlIG5vIGlzc3VlcyB3aXRoIG1lbW9yeS1hbGxvY2F0aW9uLC4uLiBhcyBhbGwgb2YgdGhp
cyBpcyBhY2NvdW50ZWQgdG9nZXRoZXIgd2l0aCB0aGUgYW5ub3VuY2VkIHdpbmRvdyAoeWVzLCB0
aGUgbWVtb3J5IGlzIG5vdCBjb3VudGVkIGFnYWluc3QgdGhlIHdpbmRvdywgYnV0IHRoZSByZWNl
aXZlciBjYW4gZm9yZXNlZSB0aGUgRFNTLW9wdGlvbiBvdmVyaGVhZCB3aGVuIGNvbXB1dGluZyB3
aGF0IHdpbmRvdyBoZSBzaG91bGQgYW5ub3VuY2UpLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
V2hlbiBhIHJlY2VpdmVyIGdldHMgZGF0YSB3aXRob3V0IGEgRFNTLW9wdGlvbiwgaGUgY2FuIHN0
b3JlIGl0IGZvciB1cCB0byA2NEtCIG9mIGRhdGEgYXMgdGhhdCBpcyB0aGUgbWF4aW11bSBkYXRh
LWxldmVsIGxlbmd0aCBhbmQgdGhlIGxhc3Qgc2VnbWVudCBvZiB0aGUgNjRLQi10cmFpbiBjb3Vs
ZCBiZSBob2xkaW5nIHRoZSBEU1Mtb3B0aW9uLiBBZnRlciB0aGF0IGhlIGhhcyB0byBkcm9wIHRo
ZSBkYXRhLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+V2hlbiB0aGUgbWFwcGluZyBwYXJ0aWFs
bHkgY292ZXJzIHRoZSBzZWdtZW50IGl0IGFsc28gaXNuJ3QgYSBwcm9ibGVtIGFzIHRoZSB1bm1h
cHBlZCBwYXJ0IGNhbiBzYWZlbHkgYmUgZHJvcHBlZCBhbmQgdGhlIG1hcHBlZCBwYXJ0IGNhbiBi
ZSBwYXNzZWQgb24gdG8gdGhlIE1QVENQLWxheWVyLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
QWxsIG9mIHRoaXMgZG9lcyBub3QgaW1wbHkgdGhhdCBldmVyeSBzZWdtZW50IG9mIGEgbWFwcGlu
ZyBuZWVkcyB0byBob2xkIHRoZSBEU1Mtb3B0aW9uLiBKdXN0IG9uZSBvZiB0aGVtIG5lZWRzIHRv
IGhhdmUgaXQuPGJyIGNsYXNzPSIiPjwvYmxvY2txdW90ZT48YnIgY2xhc3M9IiI+VGhhdCBsYXN0
IHN0YXRlbWVudCBhbGlnbnMgd2l0aCB3aGF0IHdhcyBpbnRlbmRlZCBpbiB0aGUgdGV4dC4gQnV0
IGFyZSB5b3UgcmVhbGx5IHNheWluZyB0aGF0LCBvciBhcmUgeW91IHNheWluZyB0aGF0IHRoZSBm
aXJzdCBvbmUgbmVlZHMgdG8gaGF2ZSBpdD8gQmVjYXVzZSB0aGF0IHdvdWxkIGJlIGEgY2hhbmdl
LjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPk5vLCB0aGUgZmlyc3Qgb25l
IGRvZXMgbm90IG5lZWQgdG8gaGF2ZSBpdC4gSnVzdCBvbmUgb2YgdGhlbS48YnIgY2xhc3M9IiI+
PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5DaGVlcnMsPGJyIGNsYXNzPSIiPkNocmlzdG9waDwv
ZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVv
dGU+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48L2Rp
dj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyIGNsYXNzPSIiPjwvYm9keT48L2h0bWw+
--===============1785423604621085707==--
