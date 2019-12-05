Content-Type: multipart/mixed; boundary="===============1547239798235377115=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: MPTCP implementation feedback for RFC6824bis
Date: Wed, 04 Dec 2019 16:33:29 -0800
Message-ID: <D784F90C-5027-4753-9088-00CF25D22DFD@apple.com>
In-Reply-To: CF3EBAFD-E24E-4233-8FCE-775396E747A2@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 2787

--===============1547239798235377115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Alan,

> On Dec 4, 2019, at 1:50 PM, Alan Ford <alan.ford(a)gmail.com> wrote:
> =

> Hi Christoph,
> =

> Thank you for the clarifications. I was revisiting the text to see ways t=
o make these clarifications, however I find myself unsure of the need; plea=
se see comments below:
> =

> =

> Section 3.1 clarification
> =

> Towards the end of Section 3.1 we actually say the following:
> =

>    The SYN with MP_CAPABLE occupies the first octet of data sequence spac=
e, although this does not need to be acknowledged at the connection level u=
ntil the first data is sent (see Section 3.3).
> =

> Which would seem to cover exactly this concern.

I'm not sure how it covers the concern, because the issue I raise is that t=
he client needs to somehow find out if the MP_CAPABLE made it to the receiv=
er. And the clarification I suggest is to spell out that it is the DATA_ACK=
 (see my next comment).

> However if you still feel further clarification is required, then we coul=
d add this also to the sentence you suggest, i.e.:
> =

>    If B has data to send first, then the reliable delivery of the ACK + M=
P_CAPABLE can be inferred by the receipt of this data with an MPTCP Data Se=
quence Signal (DSS) option (Section 3.3). =

> =


The ambiguity here is that DSS does not imply DATA_ACK. One could send a DS=
S without a DATA_ACK, but that would not signal to the client the reliable =
delivery of the MP_CAPABLE. Only the DATA_ACK will do so.

> Can change to:
> =

>    If B has data to send first, then the reliable delivery of the ACK + M=
P_CAPABLE can be inferred by the receipt of this data with an MPTCP Data Se=
quence Signal (DSS) option (Section 3.3) containing a DATA_ACK for the MP_C=
APABLE (which is the first octet of the data sequence space). Furthermore, =
when A receives a DATA_ACK from B it is a signal of the reliable delivery o=
f A's MP_CAPABLE.
> =

> Please confirm if you still feel this is necessary, given the quote I pro=
vide.

Yes, I still feel that this is necessary.

> =

> =

> Early Mapping
> =

>    A Data Sequence Mapping does not need to be included in every MPTCP
>    packet, as long as the subflow sequence space in that packet is
>    covered by a mapping known at the receiver.  This can be used to
>    reduce overhead in cases where the mapping is known in advance.  One
>    such case is when there is a single subflow between the hosts, and
>    another is when segments of data are scheduled in larger-than-packet-
>    sized chunks.
> =

> I would suggest simply adding a sentence at the beginning saying =E2=80=
=9CA Data Sequence Mapping MUST appear on a TCP segment which is covered by=
 the mapping=E2=80=9D.

Yes, adding that sentence would clarify this.

I also would remove the sentence "This can be used to..." and "One such cas=
e is..." - it adds to the confusion IMO.

> =

> Regarding late mapping, we say:
> =

>    Implementations MAY hold onto such unmapped data for a
>    short while, in the expectation that a mapping will arrive shortly.
>    Such unmapped data cannot be counted as being within the connection-
>    level receive window because this is relative to the data sequence
>    numbers, so if the receiver runs out of memory to hold this data, it
>    will have to be discarded.  If a mapping for that subflow-level
>    sequence space does not arrive within a receive window of data, that
>    subflow SHOULD be treated as broken, closed with a RST, and any
>    unmapped data silently discarded.
> =

> Note the last sentence. We already bound this suggestion to just a subflo=
w receive window of data, and provide a mechanism to reject (RST and silent=
ly discard). If we add the above text re early mapping that would also appl=
y in this case and provide your requirement that the mapping lands on a seg=
ment covered by the mapping.

Yes, this last sentence, combined with the above-mentioned addition should =
make things fine.


Thanks,
Christoph

> =

> Any thoughts?
> =

> Best regards,
> Alan
> =

>> On 2 Dec 2019, at 17:27, Christoph Paasch <cpaasch(a)apple.com <mailto:c=
paasch(a)apple.com>> wrote:
>> =

>> Hello Alan,
>> =

>> On 29/11/19 - 21:13:38, Alan Ford wrote:
>>>> On 28 Nov 2019, at 19:49, Christoph Paasch <cpaasch(a)apple.com <mailt=
o:cpaasch(a)apple.com>> wrote:
>>>>> On Nov 28, 2019, at 8:16 AM, Alan Ford <alan.ford(a)gmail.com <mailto=
:alan.ford(a)gmail.com> <mailto:alan.ford(a)gmail.com <mailto:alan.ford(a)g=
mail.com>>> wrote:
>>>>>> On 27 Nov 2019, at 19:29, Christoph Paasch <cpaasch(a)apple.com <mai=
lto:cpaasch(a)apple.com> <mailto:cpaasch(a)apple.com <mailto:cpaasch(a)appl=
e.com>>> wrote:
>>>>>> Section 3.3.1, page 32 & 33, "A data sequence mapping does not need.=
.."
>>>>>> =

>>>>>> This paragraph states that it is permissive to send a mapping in adv=
ance. Late-mapping is specified a bit higher around the sentence =

>>>>>> "Implementations MAY hold onto such unmapped data for a short while =
in the expectation that a mapping will arrive shortly"
>>>>>> =

>>>>>> This kind of early/late mapping announcements are difficult to handl=
e in an implementation. The Linux Kernel implementation of multipath-tcp.or=
g <http://multipath-tcp.org/> <http://multipath-tcp.org/ <http://multipath-=
tcp.org/>> has always disallowed such kind of mappings. Meaning, whenever a=
 DSS-option is received such that the range specified by the relative subfl=
ow-sequence number in the DSS-option and the data-length does not (partiall=
y) cover the TCP sequence number of the packet itself, the subflow will be =
killed with a TCP-RST. The problem around handling such early/late mappings=
 is that it is unclear for how long the stack needs to remember these mappi=
ngs (in the early-mapping case), or for how long he needs to hold on to the=
 data (in the late-mapping case).
>>>>>> =

>>>>>> We thus suggest to change this to the following:
>>>>>> Whenever a DSS-option is received on a packet such that the mapping =
of the subflow-sequence space does not partially cover the TCP-sequence num=
ber of  the packet itself, the host MUST discard this mapping and MAY destr=
oy the subflow with a TCP-RST. It should be noted that a DATA_FIN that does=
 not come with data has a relative subflow-sequence number of 0 and thus sh=
ould be handled separately.
>>>>> =

>>>>> This one I do have an issue with:
>>>>> =

>>>>> - It is a technical change
>>>>> - Wording to this effect has been in the document since pretty much t=
he beginning
>>>>> - It is a MAY which might as well say =E2=80=9Cthere is no guarantee =
this would work=E2=80=9D
>>>> =

>>>> The problem with the MAY is that the sender can't really know if the r=
eceiver accepts it (more regarding this below)
>>>> =

>>>>> Most importantly, the replacement text seems not to address this issu=
e at all. If I read it correctly, it says that the data sequence mapping op=
tion MUST partially cover the subflow sequence space of the packet itself. =
But that has nothing to do with late or early mapping, both could partially=
 cover the subflow sequence space and preceding data.
>>>>> =

>>>>> Can you clarify exactly what you want to permit and prevent, here?
>>>> =

>>>> Let me try to clarify what exactly we mean with early/late mapping so =
that we are all on the same terms here:
>>>> =

>>>> Early mapping:
>>>> =

>>>> A TCP-segment with sequence-number 1 holds a DSS-option with subflow-s=
equence number 1001 and data-length 100. This means we need to allocate spa=
ce to store this DSS-option so that when the TCP-segment with seqno 1001 ar=
rives we can know the mapping. There may be coming more of these DSS-option=
s which all need to be stored in allocated memory. It is unclear what the l=
imit to this is and there is no way to communicate this limit to the sender.
>>> =

>>> I don=E2=80=99t think we have ever intended to support a mapping like t=
his. If the text is not clear here then yes, we might have an issue.
>> =

>> Yes, I do think that the text is not very clear on that  - we should cla=
rify
>> that.
>> =

>>> We intend only to support: A TCP segment with sequence-number 1 holds a=
 DSS option for SSN 1 and length 10000 (so multiple segments in the future).
>> =

>> Sounds good!
>> =

>>> Or, slightly more convoluted, a TCP segment with SN 100, length 100, wh=
ich holds a DSS option for 151-250, and bytes 50-150 were already covered b=
y a previous mapping.
>> =

>> Also good.
>> =

>>> I do not believe we have ever intended mappings on data segments where =
the segments do not include any of the mapped data. We did, however, intend=
 to support mappings on pure ACKs in order to avoid any option space limits.
>> =

>> Mappings on a pure ACK are an unlikely use-case. The problem is that in =
the
>> end the mapping needs to reliably make it to the receiver as otherwise he
>> needs to throw the data away. Combining it with data implicitly makes it
>> reliable.
>> =

>> In case of option-space limits, it is better to send the options that do
>> consume a lot of space (ADD_ADDR,...) on the pure ACK.
>> =

>>> =

>>>> Late mapping:
>>>> =

>>>> The receiver receives data without DSS-options with TCP-sequence 1 to =
1001. The corresponding DSS-option however arrives with the TCP-segment wit=
h seqno 2001. Here, the receiver needs to hold on to this data, waiting for=
 the TCP-segment with the DSS-option. At one point the receiver needs to dr=
op the data due to memory limits. Again, the sender has no way for knowing =
what this limit is.
>>> =

>>> So this is slightly more problematic, and this is what the MAY in the t=
ext is designed to discuss.
>>> =

>>> I believe we had intended to support a situation where you could have a=
 segment 1-1000 without a DSS option, and 1001-2000 also without, and then =
2001-3000 with the option then providing a mapping for 1 to 2001 or higher.
>> =

>> I think this scenario is fine to some extend with a slight change that t=
he
>> provided mapping should be for 1 to 2002 or higher (thus, including the =
byte
>> of the 2001-3000 segment).
>> =

>>> This would allow a sender to start pushing out data before it knew what=
 a mapping might look like.
>>> It does, however, seem an unlikely situation but you as a receiver coul=
d of course reduce the subflow window size in order to limit buffering. The=
 text does recognise the memory issue and point out that this won=E2=80=99t=
 be DATA ACKed and as such a sender should soon realise and retransmit on a=
 separate subflow and then this subflow may eventually be closed.
>> =

>> Yes, it seems like an unlikerly situation and I'm not sure about the
>> use-case for doing this.
>> =

>>> Another situation would involve two mappings on the same TCP segment. I=
f the first 50 bytes of a segment are covered by the mapping provided in th=
at segment, but there are then also another 50 bytes, then the mapping can=
=E2=80=99t be provided until the next segment.
>> =

>> Yes, two mappings on a single packet are problematic simply because of t=
he
>> lack of option-space.
>> =

>>> I guess my initial thought here is that this was intended to cover a nu=
mber of corner cases but if it does not work for you then there are several=
 compliant ways of dealing with it.
>>> =

>>>> When the DSS-option comes together with the corresponding TCP-sequence=
 it is straight-forward to store it together with the data. There are no is=
sues with memory-allocation,... as all of this is accounted together with t=
he announced window (yes, the memory is not counted against the window, but=
 the receiver can foresee the DSS-option overhead when computing what windo=
w he should announce).
>>>> =

>>>> When a receiver gets data without a DSS-option, he can store it for up=
 to 64KB of data as that is the maximum data-level length and the last segm=
ent of the 64KB-train could be holding the DSS-option. After that he has to=
 drop the data.
>>>> =

>>>> When the mapping partially covers the segment it also isn't a problem =
as the unmapped part can safely be dropped and the mapped part can be passe=
d on to the MPTCP-layer.
>>>> =

>>>> All of this does not imply that every segment of a mapping needs to ho=
ld the DSS-option. Just one of them needs to have it.
>>> =

>>> That last statement aligns with what was intended in the text. But are =
you really saying that, or are you saying that the first one needs to have =
it? Because that would be a change.
>> =

>> No, the first one does not need to have it. Just one of them.
>> =

>> =

>> Cheers,
>> Christoph
>> =

> =



--===============1547239798235377115==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPjwvaGVhZD48Ym9keSBzdHlsZT0id29yZC13cmFwOiBicmVh
ay13b3JkOyAtd2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRl
LXNwYWNlOyIgY2xhc3M9IiI+SGVsbG8gQWxhbiw8YnIgY2xhc3M9IiI+PGRpdj48YnIgY2xhc3M9
IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5PbiBEZWMg
NCwgMjAxOSwgYXQgMTo1MCBQTSwgQWxhbiBGb3JkICZsdDs8YSBocmVmPSJtYWlsdG86YWxhbi5m
b3JkQGdtYWlsLmNvbSIgY2xhc3M9IiI+YWxhbi5mb3JkQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3Rl
OjwvZGl2PjxiciBjbGFzcz0iQXBwbGUtaW50ZXJjaGFuZ2UtbmV3bGluZSI+PGRpdiBjbGFzcz0i
Ij48bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRleHQvaHRtbDsgY2hh
cnNldD11dGYtOCIgY2xhc3M9IiI+PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3JkOyAt
d2Via2l0LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyIg
Y2xhc3M9IiI+SGkgQ2hyaXN0b3BoLDxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2Pjxk
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
a3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+SSdtIG5vdCBzdXJlIGhvdyBpdCBj
b3ZlcnMgdGhlIGNvbmNlcm4sIGJlY2F1c2UgdGhlIGlzc3VlIEkgcmFpc2UgaXMgdGhhdCB0aGUg
Y2xpZW50IG5lZWRzIHRvIHNvbWVob3cgZmluZCBvdXQgaWYgdGhlIE1QX0NBUEFCTEUgbWFkZSBp
dCB0byB0aGUgcmVjZWl2ZXIuIEFuZCB0aGUgY2xhcmlmaWNhdGlvbiBJIHN1Z2dlc3QgaXMgdG8g
c3BlbGwgb3V0IHRoYXQgaXQgaXMgdGhlIERBVEFfQUNLIChzZWUgbXkgbmV4dCBjb21tZW50KS48
L2Rpdj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBj
bGFzcz0iIj48ZGl2IHN0eWxlPSJ3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1t
b2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXItd2hpdGUtc3BhY2U7IiBjbGFzcz0iIj48ZGl2
IGNsYXNzPSIiPiBIb3dldmVyIGlmIHlvdSBzdGlsbCBmZWVsIGZ1cnRoZXIgY2xhcmlmaWNhdGlv
biBpcyByZXF1aXJlZCwgdGhlbiB3ZSBjb3VsZCBhZGQgdGhpcyBhbHNvIHRvIHRoZSBzZW50ZW5j
ZSB5b3Ugc3VnZ2VzdCwgaS5lLjo8L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2IGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIi
PiZuYnNwOyAmbmJzcDtJZiBCIGhhcyBkYXRhIHRvIHNlbmQgZmlyc3QsIHRoZW4gdGhlIHJlbGlh
YmxlIGRlbGl2ZXJ5IG9mIHRoZSBBQ0sgKyBNUF9DQVBBQkxFIGNhbiBiZSBpbmZlcnJlZCBieSB0
aGUgcmVjZWlwdCBvZiB0aGlzIGRhdGEgd2l0aCBhbiBNUFRDUCBEYXRhIFNlcXVlbmNlIFNpZ25h
bCAoRFNTKSBvcHRpb24gKFNlY3Rpb24gMy4zKS4mbmJzcDs8L2ZvbnQ+PC9kaXY+PC9kaXY+PGRp
diBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxk
aXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+VGhlIGFtYmlndWl0eSBoZXJlIGlzIHRoYXQgRFNT
IGRvZXMgbm90IGltcGx5IERBVEFfQUNLLiBPbmUgY291bGQgc2VuZCBhIERTUyB3aXRob3V0IGEg
REFUQV9BQ0ssIGJ1dCB0aGF0IHdvdWxkIG5vdCBzaWduYWwgdG8gdGhlIGNsaWVudCB0aGUgcmVs
aWFibGUgZGVsaXZlcnkgb2YgdGhlIE1QX0NBUEFCTEUuIE9ubHkgdGhlIERBVEFfQUNLIHdpbGwg
ZG8gc28uPC9kaXY+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIi
PjxkaXYgY2xhc3M9IiI+PGRpdiBzdHlsZT0id29yZC13cmFwOiBicmVhay13b3JkOyAtd2Via2l0
LW5ic3AtbW9kZTogc3BhY2U7IGxpbmUtYnJlYWs6IGFmdGVyLXdoaXRlLXNwYWNlOyIgY2xhc3M9
IiI+PGRpdiBjbGFzcz0iIj5DYW4gY2hhbmdlIHRvOjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5s
byIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0lmIEIgaGFzIGRhdGEgdG8gc2VuZCBmaXJzdCwgdGhl
biB0aGUgcmVsaWFibGUgZGVsaXZlcnkgb2YgdGhlIEFDSyArIE1QX0NBUEFCTEUgY2FuIGJlIGlu
ZmVycmVkIGJ5IHRoZSByZWNlaXB0IG9mIHRoaXMgZGF0YSB3aXRoIGFuIE1QVENQIERhdGEgU2Vx
dWVuY2UgU2lnbmFsIChEU1MpIG9wdGlvbiAoU2VjdGlvbiAzLjMpIGNvbnRhaW5pbmcgYSBEQVRB
X0FDSyBmb3IgdGhlIE1QX0NBUEFCTEUgKHdoaWNoIGlzIHRoZSBmaXJzdCBvY3RldCBvZiB0aGUg
ZGF0YSBzZXF1ZW5jZSBzcGFjZSkuJm5ic3A7RnVydGhlcm1vcmUsIHdoZW4gQSByZWNlaXZlcyBh
IERBVEFfQUNLIGZyb20gQiBpdCBpcyBhIHNpZ25hbCBvZiB0aGUgcmVsaWFibGUgZGVsaXZlcnkg
b2YgQSdzIE1QX0NBUEFCTEUuPC9mb250PjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNs
YXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+UGxlYXNlIGNvbmZpcm0gaWYgeW91IHN0aWxsIGZl
ZWwgdGhpcyBpcyBuZWNlc3NhcnksIGdpdmVuIHRoZSBxdW90ZSBJIHByb3ZpZGUuPC9kaXY+PC9k
aXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+WWVzLCBJ
IHN0aWxsIGZlZWwgdGhhdCB0aGlzIGlzIG5lY2Vzc2FyeS48L2Rpdj48YnIgY2xhc3M9IiI+PGJs
b2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj48ZGl2IHN0eWxlPSJ3
b3JkLXdyYXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQtbmJzcC1tb2RlOiBzcGFjZTsgbGluZS1icmVh
azogYWZ0ZXItd2hpdGUtc3BhY2U7IiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0i
Ij48L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPjxp
IGNsYXNzPSIiPkVhcmx5IE1hcHBpbmc8L2k+PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9
IiI+PC9kaXY+PGRpdiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBj
bGFzcz0iIj4mbmJzcDsgJm5ic3A7QSBEYXRhIFNlcXVlbmNlIE1hcHBpbmcgZG9lcyBub3QgbmVl
ZCB0byBiZSBpbmNsdWRlZCBpbiBldmVyeSBNUFRDUDwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSIi
Pjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7cGFja2V0LCBhcyBsb25n
IGFzIHRoZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGluIHRoYXQgcGFja2V0IGlzPC9mb250Pjwv
ZGl2PjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJz
cDtjb3ZlcmVkIGJ5IGEgbWFwcGluZyBrbm93biBhdCB0aGUgcmVjZWl2ZXIuICZuYnNwO1RoaXMg
Y2FuIGJlIHVzZWQgdG88L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5s
byIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3JlZHVjZSBvdmVyaGVhZCBpbiBjYXNlcyB3aGVyZSB0
aGUgbWFwcGluZyBpcyBrbm93biBpbiBhZHZhbmNlLiAmbmJzcDtPbmU8L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3N1Y2gg
Y2FzZSBpcyB3aGVuIHRoZXJlIGlzIGEgc2luZ2xlIHN1YmZsb3cgYmV0d2VlbiB0aGUgaG9zdHMs
IGFuZDwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0i
Ij4mbmJzcDsgJm5ic3A7YW5vdGhlciBpcyB3aGVuIHNlZ21lbnRzIG9mIGRhdGEgYXJlIHNjaGVk
dWxlZCBpbiBsYXJnZXItdGhhbi1wYWNrZXQtPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGZv
bnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtzaXplZCBjaHVua3MuPC9mb250
PjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9
IiI+SSB3b3VsZCBzdWdnZXN0IHNpbXBseSBhZGRpbmcgYSBzZW50ZW5jZSBhdCB0aGUgYmVnaW5u
aW5nIHNheWluZyA8aSBjbGFzcz0iIj7igJxBIERhdGEgU2VxdWVuY2UgTWFwcGluZyBNVVNUIGFw
cGVhciBvbiBhIFRDUCBzZWdtZW50IHdoaWNoIGlzIGNvdmVyZWQgYnkgdGhlIG1hcHBpbmfigJ0u
PC9pPjwvZGl2PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIj48L2Rp
dj48ZGl2PlllcywgYWRkaW5nIHRoYXQgc2VudGVuY2Ugd291bGQgY2xhcmlmeSB0aGlzLjwvZGl2
PjxkaXY+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXY+SSBhbHNvIHdvdWxkIHJlbW92ZSB0aGUgc2Vu
dGVuY2UgIlRoaXMgY2FuIGJlIHVzZWQgdG8uLi4iIGFuZCAiT25lIHN1Y2ggY2FzZSBpcy4uLiIg
LSBpdCBhZGRzIHRvIHRoZSBjb25mdXNpb24gSU1PLjwvZGl2PjxiciBjbGFzcz0iIj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48ZGl2IGNsYXNzPSIiPjxkaXYgc3R5bGU9IndvcmQt
d3JhcDogYnJlYWstd29yZDsgLXdlYmtpdC1uYnNwLW1vZGU6IHNwYWNlOyBsaW5lLWJyZWFrOiBh
ZnRlci13aGl0ZS1zcGFjZTsiIGNsYXNzPSIiPjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwv
ZGl2PjxkaXYgY2xhc3M9IiI+UmVnYXJkaW5nIGxhdGUgbWFwcGluZywgd2Ugc2F5OjwvZGl2Pjxk
aXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0i
Ij48Zm9udCBmYWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO0ltcGxlbWVudGF0aW9u
cyBNQVkgaG9sZCBvbnRvIHN1Y2ggdW5tYXBwZWQgZGF0YSBmb3IgYTwvZm9udD48L2Rpdj48ZGl2
IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7c2hvcnQg
d2hpbGUsIGluIHRoZSBleHBlY3RhdGlvbiB0aGF0IGEgbWFwcGluZyB3aWxsIGFycml2ZSBzaG9y
dGx5LjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0i
Ij4mbmJzcDsgJm5ic3A7U3VjaCB1bm1hcHBlZCBkYXRhIGNhbm5vdCBiZSBjb3VudGVkIGFzIGJl
aW5nIHdpdGhpbiB0aGUgY29ubmVjdGlvbi08L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48Zm9u
dCBmYWNlPSJNZW5sbyIgY2xhc3M9IiI+Jm5ic3A7ICZuYnNwO2xldmVsIHJlY2VpdmUgd2luZG93
IGJlY2F1c2UgdGhpcyBpcyByZWxhdGl2ZSB0byB0aGUgZGF0YSBzZXF1ZW5jZTwvZm9udD48L2Rp
dj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJzcDsgJm5ic3A7
bnVtYmVycywgc28gaWYgdGhlIHJlY2VpdmVyIHJ1bnMgb3V0IG9mIG1lbW9yeSB0byBob2xkIHRo
aXMgZGF0YSwgaXQ8L2ZvbnQ+PC9kaXY+PGRpdiBjbGFzcz0iIj48Zm9udCBmYWNlPSJNZW5sbyIg
Y2xhc3M9IiI+Jm5ic3A7ICZuYnNwO3dpbGwgaGF2ZSB0byBiZSBkaXNjYXJkZWQuICZuYnNwO0lm
IGEgbWFwcGluZyBmb3IgdGhhdCBzdWJmbG93LWxldmVsPC9mb250PjwvZGl2PjxkaXYgY2xhc3M9
IiI+PGZvbnQgZmFjZT0iTWVubG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDtzZXF1ZW5jZSBzcGFj
ZSBkb2VzIG5vdCBhcnJpdmUgd2l0aGluIGEgcmVjZWl2ZSB3aW5kb3cgb2YgZGF0YSwgdGhhdDwv
Zm9udD48L2Rpdj48ZGl2IGNsYXNzPSIiPjxmb250IGZhY2U9Ik1lbmxvIiBjbGFzcz0iIj4mbmJz
cDsgJm5ic3A7c3ViZmxvdyBTSE9VTEQgYmUgdHJlYXRlZCBhcyBicm9rZW4sIGNsb3NlZCB3aXRo
IGEgUlNULCBhbmQgYW55PC9mb250PjwvZGl2PjxkaXYgY2xhc3M9IiI+PGZvbnQgZmFjZT0iTWVu
bG8iIGNsYXNzPSIiPiZuYnNwOyAmbmJzcDt1bm1hcHBlZCBkYXRhIHNpbGVudGx5IGRpc2NhcmRl
ZC48L2ZvbnQ+PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PC9kaXY+PGRp
diBjbGFzcz0iIj5Ob3RlIHRoZSBsYXN0IHNlbnRlbmNlLiBXZSBhbHJlYWR5IGJvdW5kIHRoaXMg
c3VnZ2VzdGlvbiB0byBqdXN0IGEgc3ViZmxvdyByZWNlaXZlIHdpbmRvdyBvZiBkYXRhLCBhbmQg
cHJvdmlkZSBhIG1lY2hhbmlzbSB0byByZWplY3QgKFJTVCBhbmQgc2lsZW50bHkgZGlzY2FyZCku
IElmIHdlIGFkZCB0aGUgYWJvdmUgdGV4dCByZSBlYXJseSBtYXBwaW5nIHRoYXQgd291bGQgYWxz
byBhcHBseSBpbiB0aGlzIGNhc2UgYW5kIHByb3ZpZGUgeW91ciByZXF1aXJlbWVudCB0aGF0IHRo
ZSBtYXBwaW5nIGxhbmRzIG9uIGEgc2VnbWVudCBjb3ZlcmVkIGJ5IHRoZSBtYXBwaW5nLjwvZGl2
PjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2PjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2Plll
cywgdGhpcyBsYXN0IHNlbnRlbmNlLCBjb21iaW5lZCB3aXRoIHRoZSBhYm92ZS1tZW50aW9uZWQg
YWRkaXRpb24gc2hvdWxkIG1ha2UgdGhpbmdzIGZpbmUuPC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+
PC9kaXY+PGRpdj48YnIgY2xhc3M9IiI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj5DaHJp
c3RvcGg8L2Rpdj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+
PGRpdiBjbGFzcz0iIj48ZGl2IHN0eWxlPSJ3b3JkLXdyYXA6IGJyZWFrLXdvcmQ7IC13ZWJraXQt
bmJzcC1tb2RlOiBzcGFjZTsgbGluZS1icmVhazogYWZ0ZXItd2hpdGUtc3BhY2U7IiBjbGFzcz0i
Ij48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIiPkFueSB0aG91
Z2h0cz88L2Rpdj48ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj48L2Rpdj48ZGl2IGNsYXNzPSIi
PkJlc3QgcmVnYXJkcyw8L2Rpdj48ZGl2IGNsYXNzPSIiPkFsYW48L2Rpdj48ZGl2IGNsYXNzPSIi
PjxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNz
PSIiPjxkaXYgY2xhc3M9IiI+T24gMiBEZWMgMjAxOSwgYXQgMTc6MjcsIENocmlzdG9waCBQYWFz
Y2ggJmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgY2xhc3M9IiI+Y3BhYXNj
aEBhcHBsZS5jb208L2E+Jmd0OyB3cm90ZTo8L2Rpdj48YnIgY2xhc3M9IkFwcGxlLWludGVyY2hh
bmdlLW5ld2xpbmUiPjxkaXYgY2xhc3M9IiI+PGRpdiBjbGFzcz0iIj5IZWxsbyBBbGFuLDxiciBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+T24gMjkvMTEvMTkgLSAyMToxMzozOCwgQWxhbiBGb3JkIHdy
b3RlOjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5PbiAyOCBOb3YgMjAxOSwgYXQgMTk6NDksIENocmlz
dG9waCBQYWFzY2ggJmx0OzxhIGhyZWY9Im1haWx0bzpjcGFhc2NoQGFwcGxlLmNvbSIgY2xhc3M9
IiI+Y3BhYXNjaEBhcHBsZS5jb208L2E+Jmd0OyB3cm90ZTo8YnIgY2xhc3M9IiI+PGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+T24gTm92IDI4LCAyMDE5LCBhdCA4OjE2IEFNLCBBbGFu
IEZvcmQgJmx0OzxhIGhyZWY9Im1haWx0bzphbGFuLmZvcmRAZ21haWwuY29tIiBjbGFzcz0iIj5h
bGFuLmZvcmRAZ21haWwuY29tPC9hPiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFsYW4uZm9yZEBnbWFp
bC5jb20iIGNsYXNzPSIiPm1haWx0bzphbGFuLmZvcmRAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdy
b3RlOjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5PbiAyNyBO
b3YgMjAxOSwgYXQgMTk6MjksIENocmlzdG9waCBQYWFzY2ggJmx0OzxhIGhyZWY9Im1haWx0bzpj
cGFhc2NoQGFwcGxlLmNvbSIgY2xhc3M9IiI+Y3BhYXNjaEBhcHBsZS5jb208L2E+ICZsdDs8YSBo
cmVmPSJtYWlsdG86Y3BhYXNjaEBhcHBsZS5jb20iIGNsYXNzPSIiPm1haWx0bzpjcGFhc2NoQGFw
cGxlLmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8YnIgY2xhc3M9IiI+U2VjdGlvbiAzLjMuMSwgcGFn
ZSAzMiAmYW1wOyAzMywgIkEgZGF0YSBzZXF1ZW5jZSBtYXBwaW5nIGRvZXMgbm90IG5lZWQuLi4i
PGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGlzIHBhcmFncmFwaCBzdGF0ZXMgdGhhdCBpdCBp
cyBwZXJtaXNzaXZlIHRvIHNlbmQgYSBtYXBwaW5nIGluIGFkdmFuY2UuIExhdGUtbWFwcGluZyBp
cyBzcGVjaWZpZWQgYSBiaXQgaGlnaGVyIGFyb3VuZCB0aGUgc2VudGVuY2UgPGJyIGNsYXNzPSIi
PiJJbXBsZW1lbnRhdGlvbnMgTUFZIGhvbGQgb250byBzdWNoIHVubWFwcGVkIGRhdGEgZm9yIGEg
c2hvcnQgd2hpbGUgaW4gdGhlIGV4cGVjdGF0aW9uIHRoYXQgYSBtYXBwaW5nIHdpbGwgYXJyaXZl
IHNob3J0bHkiPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5UaGlzIGtpbmQgb2YgZWFybHkvbGF0
ZSBtYXBwaW5nIGFubm91bmNlbWVudHMgYXJlIGRpZmZpY3VsdCB0byBoYW5kbGUgaW4gYW4gaW1w
bGVtZW50YXRpb24uIFRoZSBMaW51eCBLZXJuZWwgaW1wbGVtZW50YXRpb24gb2YgPGEgaHJlZj0i
aHR0cDovL211bHRpcGF0aC10Y3Aub3JnLyIgY2xhc3M9IiI+bXVsdGlwYXRoLXRjcC5vcmc8L2E+
ICZsdDs8YSBocmVmPSJodHRwOi8vbXVsdGlwYXRoLXRjcC5vcmcvIiBjbGFzcz0iIj5odHRwOi8v
bXVsdGlwYXRoLXRjcC5vcmcvPC9hPiZndDsgaGFzIGFsd2F5cyBkaXNhbGxvd2VkIHN1Y2gga2lu
ZCBvZiBtYXBwaW5ncy4gTWVhbmluZywgd2hlbmV2ZXIgYSBEU1Mtb3B0aW9uIGlzIHJlY2VpdmVk
IHN1Y2ggdGhhdCB0aGUgcmFuZ2Ugc3BlY2lmaWVkIGJ5IHRoZSByZWxhdGl2ZSBzdWJmbG93LXNl
cXVlbmNlIG51bWJlciBpbiB0aGUgRFNTLW9wdGlvbiBhbmQgdGhlIGRhdGEtbGVuZ3RoIGRvZXMg
bm90IChwYXJ0aWFsbHkpIGNvdmVyIHRoZSBUQ1Agc2VxdWVuY2UgbnVtYmVyIG9mIHRoZSBwYWNr
ZXQgaXRzZWxmLCB0aGUgc3ViZmxvdyB3aWxsIGJlIGtpbGxlZCB3aXRoIGEgVENQLVJTVC4gVGhl
IHByb2JsZW0gYXJvdW5kIGhhbmRsaW5nIHN1Y2ggZWFybHkvbGF0ZSBtYXBwaW5ncyBpcyB0aGF0
IGl0IGlzIHVuY2xlYXIgZm9yIGhvdyBsb25nIHRoZSBzdGFjayBuZWVkcyB0byByZW1lbWJlciB0
aGVzZSBtYXBwaW5ncyAoaW4gdGhlIGVhcmx5LW1hcHBpbmcgY2FzZSksIG9yIGZvciBob3cgbG9u
ZyBoZSBuZWVkcyB0byBob2xkIG9uIHRvIHRoZSBkYXRhIChpbiB0aGUgbGF0ZS1tYXBwaW5nIGNh
c2UpLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+V2UgdGh1cyBzdWdnZXN0IHRvIGNoYW5nZSB0
aGlzIHRvIHRoZSBmb2xsb3dpbmc6PGJyIGNsYXNzPSIiPldoZW5ldmVyIGEgRFNTLW9wdGlvbiBp
cyByZWNlaXZlZCBvbiBhIHBhY2tldCBzdWNoIHRoYXQgdGhlIG1hcHBpbmcgb2YgdGhlIHN1YmZs
b3ctc2VxdWVuY2Ugc3BhY2UgZG9lcyBub3QgcGFydGlhbGx5IGNvdmVyIHRoZSBUQ1Atc2VxdWVu
Y2UgbnVtYmVyIG9mICZuYnNwO3RoZSBwYWNrZXQgaXRzZWxmLCB0aGUgaG9zdCBNVVNUIGRpc2Nh
cmQgdGhpcyBtYXBwaW5nIGFuZCBNQVkgZGVzdHJveSB0aGUgc3ViZmxvdyB3aXRoIGEgVENQLVJT
VC4gSXQgc2hvdWxkIGJlIG5vdGVkIHRoYXQgYSBEQVRBX0ZJTiB0aGF0IGRvZXMgbm90IGNvbWUg
d2l0aCBkYXRhIGhhcyBhIHJlbGF0aXZlIHN1YmZsb3ctc2VxdWVuY2UgbnVtYmVyIG9mIDAgYW5k
IHRodXMgc2hvdWxkIGJlIGhhbmRsZWQgc2VwYXJhdGVseS48YnIgY2xhc3M9IiI+PC9ibG9ja3F1
b3RlPjxiciBjbGFzcz0iIj5UaGlzIG9uZSBJIGRvIGhhdmUgYW4gaXNzdWUgd2l0aDo8YnIgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPi0gSXQgaXMgYSB0ZWNobmljYWwgY2hhbmdlPGJyIGNsYXNzPSIi
Pi0gV29yZGluZyB0byB0aGlzIGVmZmVjdCBoYXMgYmVlbiBpbiB0aGUgZG9jdW1lbnQgc2luY2Ug
cHJldHR5IG11Y2ggdGhlIGJlZ2lubmluZzxiciBjbGFzcz0iIj4tIEl0IGlzIGEgTUFZIHdoaWNo
IG1pZ2h0IGFzIHdlbGwgc2F5IOKAnHRoZXJlIGlzIG5vIGd1YXJhbnRlZSB0aGlzIHdvdWxkIHdv
cmvigJ08YnIgY2xhc3M9IiI+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj5UaGUgcHJvYmxlbSB3
aXRoIHRoZSBNQVkgaXMgdGhhdCB0aGUgc2VuZGVyIGNhbid0IHJlYWxseSBrbm93IGlmIHRoZSBy
ZWNlaXZlciBhY2NlcHRzIGl0IChtb3JlIHJlZ2FyZGluZyB0aGlzIGJlbG93KTxiciBjbGFzcz0i
Ij48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+TW9zdCBpbXBv
cnRhbnRseSwgdGhlIHJlcGxhY2VtZW50IHRleHQgc2VlbXMgbm90IHRvIGFkZHJlc3MgdGhpcyBp
c3N1ZSBhdCBhbGwuIElmIEkgcmVhZCBpdCBjb3JyZWN0bHksIGl0IHNheXMgdGhhdCB0aGUgZGF0
YSBzZXF1ZW5jZSBtYXBwaW5nIG9wdGlvbiBNVVNUIHBhcnRpYWxseSBjb3ZlciB0aGUgc3ViZmxv
dyBzZXF1ZW5jZSBzcGFjZSBvZiB0aGUgcGFja2V0IGl0c2VsZi4gQnV0IHRoYXQgaGFzIG5vdGhp
bmcgdG8gZG8gd2l0aCBsYXRlIG9yIGVhcmx5IG1hcHBpbmcsIGJvdGggY291bGQgcGFydGlhbGx5
IGNvdmVyIHRoZSBzdWJmbG93IHNlcXVlbmNlIHNwYWNlIGFuZCBwcmVjZWRpbmcgZGF0YS48YnIg
Y2xhc3M9IiI+PGJyIGNsYXNzPSIiPkNhbiB5b3UgY2xhcmlmeSBleGFjdGx5IHdoYXQgeW91IHdh
bnQgdG8gcGVybWl0IGFuZCBwcmV2ZW50LCBoZXJlPzxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+
PGJyIGNsYXNzPSIiPkxldCBtZSB0cnkgdG8gY2xhcmlmeSB3aGF0IGV4YWN0bHkgd2UgbWVhbiB3
aXRoIGVhcmx5L2xhdGUgbWFwcGluZyBzbyB0aGF0IHdlIGFyZSBhbGwgb24gdGhlIHNhbWUgdGVy
bXMgaGVyZTo8YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPkVhcmx5IG1hcHBpbmc6PGJyIGNsYXNz
PSIiPjxiciBjbGFzcz0iIj5BIFRDUC1zZWdtZW50IHdpdGggc2VxdWVuY2UtbnVtYmVyIDEgaG9s
ZHMgYSBEU1Mtb3B0aW9uIHdpdGggc3ViZmxvdy1zZXF1ZW5jZSBudW1iZXIgMTAwMSBhbmQgZGF0
YS1sZW5ndGggMTAwLiBUaGlzIG1lYW5zIHdlIG5lZWQgdG8gYWxsb2NhdGUgc3BhY2UgdG8gc3Rv
cmUgdGhpcyBEU1Mtb3B0aW9uIHNvIHRoYXQgd2hlbiB0aGUgVENQLXNlZ21lbnQgd2l0aCBzZXFu
byAxMDAxIGFycml2ZXMgd2UgY2FuIGtub3cgdGhlIG1hcHBpbmcuIFRoZXJlIG1heSBiZSBjb21p
bmcgbW9yZSBvZiB0aGVzZSBEU1Mtb3B0aW9ucyB3aGljaCBhbGwgbmVlZCB0byBiZSBzdG9yZWQg
aW4gYWxsb2NhdGVkIG1lbW9yeS4gSXQgaXMgdW5jbGVhciB3aGF0IHRoZSBsaW1pdCB0byB0aGlz
IGlzIGFuZCB0aGVyZSBpcyBubyB3YXkgdG8gY29tbXVuaWNhdGUgdGhpcyBsaW1pdCB0byB0aGUg
c2VuZGVyLjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPkkgZG9u4oCZdCB0
aGluayB3ZSBoYXZlIGV2ZXIgaW50ZW5kZWQgdG8gc3VwcG9ydCBhIG1hcHBpbmcgbGlrZSB0aGlz
LiBJZiB0aGUgdGV4dCBpcyBub3QgY2xlYXIgaGVyZSB0aGVuIHllcywgd2UgbWlnaHQgaGF2ZSBh
biBpc3N1ZS48YnIgY2xhc3M9IiI+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj5ZZXMsIEkgZG8g
dGhpbmsgdGhhdCB0aGUgdGV4dCBpcyBub3QgdmVyeSBjbGVhciBvbiB0aGF0ICZuYnNwOy0gd2Ug
c2hvdWxkIGNsYXJpZnk8YnIgY2xhc3M9IiI+dGhhdC48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIi
PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPldlIGludGVuZCBvbmx5IHRvIHN1cHBv
cnQ6IEEgVENQIHNlZ21lbnQgd2l0aCBzZXF1ZW5jZS1udW1iZXIgMSBob2xkcyBhIERTUyBvcHRp
b24gZm9yIFNTTiAxIGFuZCBsZW5ndGggMTAwMDAgKHNvIG11bHRpcGxlIHNlZ21lbnRzIGluIHRo
ZSBmdXR1cmUpLjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPlNvdW5kcyBn
b29kITxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xh
c3M9IiI+T3IsIHNsaWdodGx5IG1vcmUgY29udm9sdXRlZCwgYSBUQ1Agc2VnbWVudCB3aXRoIFNO
IDEwMCwgbGVuZ3RoIDEwMCwgd2hpY2ggaG9sZHMgYSBEU1Mgb3B0aW9uIGZvciAxNTEtMjUwLCBh
bmQgYnl0ZXMgNTAtMTUwIHdlcmUgYWxyZWFkeSBjb3ZlcmVkIGJ5IGEgcHJldmlvdXMgbWFwcGlu
Zy48YnIgY2xhc3M9IiI+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj5BbHNvIGdvb2QuPGJyIGNs
YXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5JIGRv
IG5vdCBiZWxpZXZlIHdlIGhhdmUgZXZlciBpbnRlbmRlZCBtYXBwaW5ncyBvbiBkYXRhIHNlZ21l
bnRzIHdoZXJlIHRoZSBzZWdtZW50cyBkbyBub3QgaW5jbHVkZSBhbnkgb2YgdGhlIG1hcHBlZCBk
YXRhLiBXZSBkaWQsIGhvd2V2ZXIsIGludGVuZCB0byBzdXBwb3J0IG1hcHBpbmdzIG9uIHB1cmUg
QUNLcyBpbiBvcmRlciB0byBhdm9pZCBhbnkgb3B0aW9uIHNwYWNlIGxpbWl0cy48YnIgY2xhc3M9
IiI+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj5NYXBwaW5ncyBvbiBhIHB1cmUgQUNLIGFyZSBh
biB1bmxpa2VseSB1c2UtY2FzZS4gVGhlIHByb2JsZW0gaXMgdGhhdCBpbiB0aGU8YnIgY2xhc3M9
IiI+ZW5kIHRoZSBtYXBwaW5nIG5lZWRzIHRvIHJlbGlhYmx5IG1ha2UgaXQgdG8gdGhlIHJlY2Vp
dmVyIGFzIG90aGVyd2lzZSBoZTxiciBjbGFzcz0iIj5uZWVkcyB0byB0aHJvdyB0aGUgZGF0YSBh
d2F5LiBDb21iaW5pbmcgaXQgd2l0aCBkYXRhIGltcGxpY2l0bHkgbWFrZXMgaXQ8YnIgY2xhc3M9
IiI+cmVsaWFibGUuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj5JbiBjYXNlIG9mIG9wdGlvbi1z
cGFjZSBsaW1pdHMsIGl0IGlzIGJldHRlciB0byBzZW5kIHRoZSBvcHRpb25zIHRoYXQgZG88YnIg
Y2xhc3M9IiI+Y29uc3VtZSBhIGxvdCBvZiBzcGFjZSAoQUREX0FERFIsLi4uKSBvbiB0aGUgcHVy
ZSBBQ0suPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+TGF0
ZSBtYXBwaW5nOjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+VGhlIHJlY2VpdmVyIHJlY2VpdmVz
IGRhdGEgd2l0aG91dCBEU1Mtb3B0aW9ucyB3aXRoIFRDUC1zZXF1ZW5jZSAxIHRvIDEwMDEuIFRo
ZSBjb3JyZXNwb25kaW5nIERTUy1vcHRpb24gaG93ZXZlciBhcnJpdmVzIHdpdGggdGhlIFRDUC1z
ZWdtZW50IHdpdGggc2Vxbm8gMjAwMS4gSGVyZSwgdGhlIHJlY2VpdmVyIG5lZWRzIHRvIGhvbGQg
b24gdG8gdGhpcyBkYXRhLCB3YWl0aW5nIGZvciB0aGUgVENQLXNlZ21lbnQgd2l0aCB0aGUgRFNT
LW9wdGlvbi4gQXQgb25lIHBvaW50IHRoZSByZWNlaXZlciBuZWVkcyB0byBkcm9wIHRoZSBkYXRh
IGR1ZSB0byBtZW1vcnkgbGltaXRzLiBBZ2FpbiwgdGhlIHNlbmRlciBoYXMgbm8gd2F5IGZvciBr
bm93aW5nIHdoYXQgdGhpcyBsaW1pdCBpcy48YnIgY2xhc3M9IiI+PC9ibG9ja3F1b3RlPjxiciBj
bGFzcz0iIj5TbyB0aGlzIGlzIHNsaWdodGx5IG1vcmUgcHJvYmxlbWF0aWMsIGFuZCB0aGlzIGlz
IHdoYXQgdGhlIE1BWSBpbiB0aGUgdGV4dCBpcyBkZXNpZ25lZCB0byBkaXNjdXNzLjxiciBjbGFz
cz0iIj48YnIgY2xhc3M9IiI+SSBiZWxpZXZlIHdlIGhhZCBpbnRlbmRlZCB0byBzdXBwb3J0IGEg
c2l0dWF0aW9uIHdoZXJlIHlvdSBjb3VsZCBoYXZlIGEgc2VnbWVudCAxLTEwMDAgd2l0aG91dCBh
IERTUyBvcHRpb24sIGFuZCAxMDAxLTIwMDAgYWxzbyB3aXRob3V0LCBhbmQgdGhlbiAyMDAxLTMw
MDAgd2l0aCB0aGUgb3B0aW9uIHRoZW4gcHJvdmlkaW5nIGEgbWFwcGluZyBmb3IgMSB0byAyMDAx
IG9yIGhpZ2hlci48YnIgY2xhc3M9IiI+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj5JIHRoaW5r
IHRoaXMgc2NlbmFyaW8gaXMgZmluZSB0byBzb21lIGV4dGVuZCB3aXRoIGEgc2xpZ2h0IGNoYW5n
ZSB0aGF0IHRoZTxiciBjbGFzcz0iIj5wcm92aWRlZCBtYXBwaW5nIHNob3VsZCBiZSBmb3IgMSB0
byAyMDAyIG9yIGhpZ2hlciAodGh1cywgaW5jbHVkaW5nIHRoZSBieXRlPGJyIGNsYXNzPSIiPm9m
IHRoZSAyMDAxLTMwMDAgc2VnbWVudCkuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBjbGFzcz0iIj5UaGlzIHdvdWxkIGFsbG93IGEgc2VuZGVyIHRvIHN0
YXJ0IHB1c2hpbmcgb3V0IGRhdGEgYmVmb3JlIGl0IGtuZXcgd2hhdCBhIG1hcHBpbmcgbWlnaHQg
bG9vayBsaWtlLjxiciBjbGFzcz0iIj5JdCBkb2VzLCBob3dldmVyLCBzZWVtIGFuIHVubGlrZWx5
IHNpdHVhdGlvbiBidXQgeW91IGFzIGEgcmVjZWl2ZXIgY291bGQgb2YgY291cnNlIHJlZHVjZSB0
aGUgc3ViZmxvdyB3aW5kb3cgc2l6ZSBpbiBvcmRlciB0byBsaW1pdCBidWZmZXJpbmcuIFRoZSB0
ZXh0IGRvZXMgcmVjb2duaXNlIHRoZSBtZW1vcnkgaXNzdWUgYW5kIHBvaW50IG91dCB0aGF0IHRo
aXMgd29u4oCZdCBiZSBEQVRBIEFDS2VkIGFuZCBhcyBzdWNoIGEgc2VuZGVyIHNob3VsZCBzb29u
IHJlYWxpc2UgYW5kIHJldHJhbnNtaXQgb24gYSBzZXBhcmF0ZSBzdWJmbG93IGFuZCB0aGVuIHRo
aXMgc3ViZmxvdyBtYXkgZXZlbnR1YWxseSBiZSBjbG9zZWQuPGJyIGNsYXNzPSIiPjwvYmxvY2tx
dW90ZT48YnIgY2xhc3M9IiI+WWVzLCBpdCBzZWVtcyBsaWtlIGFuIHVubGlrZXJseSBzaXR1YXRp
b24gYW5kIEknbSBub3Qgc3VyZSBhYm91dCB0aGU8YnIgY2xhc3M9IiI+dXNlLWNhc2UgZm9yIGRv
aW5nIHRoaXMuPGJyIGNsYXNzPSIiPjxiciBjbGFzcz0iIj48YmxvY2txdW90ZSB0eXBlPSJjaXRl
IiBjbGFzcz0iIj5Bbm90aGVyIHNpdHVhdGlvbiB3b3VsZCBpbnZvbHZlIHR3byBtYXBwaW5ncyBv
biB0aGUgc2FtZSBUQ1Agc2VnbWVudC4gSWYgdGhlIGZpcnN0IDUwIGJ5dGVzIG9mIGEgc2VnbWVu
dCBhcmUgY292ZXJlZCBieSB0aGUgbWFwcGluZyBwcm92aWRlZCBpbiB0aGF0IHNlZ21lbnQsIGJ1
dCB0aGVyZSBhcmUgdGhlbiBhbHNvIGFub3RoZXIgNTAgYnl0ZXMsIHRoZW4gdGhlIG1hcHBpbmcg
Y2Fu4oCZdCBiZSBwcm92aWRlZCB1bnRpbCB0aGUgbmV4dCBzZWdtZW50LjxiciBjbGFzcz0iIj48
L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPlllcywgdHdvIG1hcHBpbmdzIG9uIGEgc2luZ2xlIHBh
Y2tldCBhcmUgcHJvYmxlbWF0aWMgc2ltcGx5IGJlY2F1c2Ugb2YgdGhlPGJyIGNsYXNzPSIiPmxh
Y2sgb2Ygb3B0aW9uLXNwYWNlLjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+PGJsb2NrcXVvdGUg
dHlwZT0iY2l0ZSIgY2xhc3M9IiI+SSBndWVzcyBteSBpbml0aWFsIHRob3VnaHQgaGVyZSBpcyB0
aGF0IHRoaXMgd2FzIGludGVuZGVkIHRvIGNvdmVyIGEgbnVtYmVyIG9mIGNvcm5lciBjYXNlcyBi
dXQgaWYgaXQgZG9lcyBub3Qgd29yayBmb3IgeW91IHRoZW4gdGhlcmUgYXJlIHNldmVyYWwgY29t
cGxpYW50IHdheXMgb2YgZGVhbGluZyB3aXRoIGl0LjxiciBjbGFzcz0iIj48YnIgY2xhc3M9IiI+
PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+V2hlbiB0aGUgRFNTLW9wdGlvbiBjb21l
cyB0b2dldGhlciB3aXRoIHRoZSBjb3JyZXNwb25kaW5nIFRDUC1zZXF1ZW5jZSBpdCBpcyBzdHJh
aWdodC1mb3J3YXJkIHRvIHN0b3JlIGl0IHRvZ2V0aGVyIHdpdGggdGhlIGRhdGEuIFRoZXJlIGFy
ZSBubyBpc3N1ZXMgd2l0aCBtZW1vcnktYWxsb2NhdGlvbiwuLi4gYXMgYWxsIG9mIHRoaXMgaXMg
YWNjb3VudGVkIHRvZ2V0aGVyIHdpdGggdGhlIGFubm91bmNlZCB3aW5kb3cgKHllcywgdGhlIG1l
bW9yeSBpcyBub3QgY291bnRlZCBhZ2FpbnN0IHRoZSB3aW5kb3csIGJ1dCB0aGUgcmVjZWl2ZXIg
Y2FuIGZvcmVzZWUgdGhlIERTUy1vcHRpb24gb3ZlcmhlYWQgd2hlbiBjb21wdXRpbmcgd2hhdCB3
aW5kb3cgaGUgc2hvdWxkIGFubm91bmNlKS48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPldoZW4g
YSByZWNlaXZlciBnZXRzIGRhdGEgd2l0aG91dCBhIERTUy1vcHRpb24sIGhlIGNhbiBzdG9yZSBp
dCBmb3IgdXAgdG8gNjRLQiBvZiBkYXRhIGFzIHRoYXQgaXMgdGhlIG1heGltdW0gZGF0YS1sZXZl
bCBsZW5ndGggYW5kIHRoZSBsYXN0IHNlZ21lbnQgb2YgdGhlIDY0S0ItdHJhaW4gY291bGQgYmUg
aG9sZGluZyB0aGUgRFNTLW9wdGlvbi4gQWZ0ZXIgdGhhdCBoZSBoYXMgdG8gZHJvcCB0aGUgZGF0
YS48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPldoZW4gdGhlIG1hcHBpbmcgcGFydGlhbGx5IGNv
dmVycyB0aGUgc2VnbWVudCBpdCBhbHNvIGlzbid0IGEgcHJvYmxlbSBhcyB0aGUgdW5tYXBwZWQg
cGFydCBjYW4gc2FmZWx5IGJlIGRyb3BwZWQgYW5kIHRoZSBtYXBwZWQgcGFydCBjYW4gYmUgcGFz
c2VkIG9uIHRvIHRoZSBNUFRDUC1sYXllci48YnIgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPkFsbCBv
ZiB0aGlzIGRvZXMgbm90IGltcGx5IHRoYXQgZXZlcnkgc2VnbWVudCBvZiBhIG1hcHBpbmcgbmVl
ZHMgdG8gaG9sZCB0aGUgRFNTLW9wdGlvbi4gSnVzdCBvbmUgb2YgdGhlbSBuZWVkcyB0byBoYXZl
IGl0LjxiciBjbGFzcz0iIj48L2Jsb2NrcXVvdGU+PGJyIGNsYXNzPSIiPlRoYXQgbGFzdCBzdGF0
ZW1lbnQgYWxpZ25zIHdpdGggd2hhdCB3YXMgaW50ZW5kZWQgaW4gdGhlIHRleHQuIEJ1dCBhcmUg
eW91IHJlYWxseSBzYXlpbmcgdGhhdCwgb3IgYXJlIHlvdSBzYXlpbmcgdGhhdCB0aGUgZmlyc3Qg
b25lIG5lZWRzIHRvIGhhdmUgaXQ/IEJlY2F1c2UgdGhhdCB3b3VsZCBiZSBhIGNoYW5nZS48YnIg
Y2xhc3M9IiI+PC9ibG9ja3F1b3RlPjxiciBjbGFzcz0iIj5ObywgdGhlIGZpcnN0IG9uZSBkb2Vz
IG5vdCBuZWVkIHRvIGhhdmUgaXQuIEp1c3Qgb25lIG9mIHRoZW0uPGJyIGNsYXNzPSIiPjxiciBj
bGFzcz0iIj48YnIgY2xhc3M9IiI+Q2hlZXJzLDxiciBjbGFzcz0iIj5DaHJpc3RvcGg8YnIgY2xh
c3M9IiI+PGJyIGNsYXNzPSIiPjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48YnIgY2xh
c3M9IiI+PC9kaXY+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGFzcz0iIj48
L2JvZHk+PC9odG1sPg==
--===============1547239798235377115==--
