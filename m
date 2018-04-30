Content-Type: multipart/mixed; boundary="===============0049127797648372427=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [Weekly meetings] MoM - 16th of April 2018
Date: Mon, 30 Apr 2018 11:35:10 -0700
Message-ID: <40dc095d-fbab-9b2e-b427-3a5a34a50425@oracle.com>
In-Reply-To: 20180430163451.GP19260@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 576

--===============0049127797648372427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/30/2018 09:34 AM, Christoph Paasch wrote:
> On 26/04/18 - 17:43:44, Rao Shoaib wrote:
>>
>> On 04/26/2018 03:20 PM, Christoph Paasch wrote:
>>> On 26/04/18 - 14:25:24, Rao Shoaib wrote:
>>>> On 04/26/2018 01:52 PM, Christoph Paasch wrote:
>>>>> This kind of lock-taking also causes trouble with RCU LOCKDEP debuggi=
ng - as
>>>>> I mentioned in a previous e-mail.
>>>> I have not looked into it so I can not comment. I am sure we will find=
 a way
>>>> to address it.
>>>>> And beyond that, it requires that everytime a TCP-change is being don=
e, one
>>>>> needs to take MPTCP into account. E.g., when upstream added the SOCK_=
DESTROY
>>>>> interface (and Samsung backported it to v4.4), there were panics on A=
ndroid
>>>>> devices (https://github.com/multipath-tcp/mptcp/issues/170).
>>>>>
>>>>> Avoid taking the meta-socket lock on subflow-work allows for much eas=
ier
>>>>> maintenance in the long-term.
>>>> The bug that you have pointed out is a run of the mill bug that we see
>>>> everyday, there is nothing special about it.
>>> Euh, you mean the issue #170 is happening frequently?
>>>
>>> It shouldn't! If it does, that's a big concern.
>> No we have not encountered the bug. What I meant to say was that when
>> changes or enhancements are made to the code it is quite common that
>> something breaks.
> This is exactly what should be avoided. See my below comment on
> maintainability.
>
>> That is the case in the bug that you pointed.
>>>> Taking meta lock actually simplifies things a lot and has reduced
>>>> maintainable cost, not taking the meta lock will create timing issues =
left
>>>> and right. So we are just trading one headache with another.
>>>>
>>>> Holding meta lock should not be piped up unnecessarily. Yes, if possib=
le if
>>>> should be changed, plus our patch has only 6 cases in TCP.
>>> I think, you are taking the MPTCP point-of-view here. Yes, taking the
>>> meta-level lock does reduce maintainability of MPTCP (which is why we d=
id it
>>> that way in the first place ;-))
>>>
>>> However, for upstreaming we have to think the other way around. TCP is =
the
>>> common-case, and MPTCP is the exotic corner-case only few care about.
>>>
>>> So, TCP-maintainability is of outmost importance. Way more important th=
an
>>> MPTCP's.
>> I agree that TCP stability and maintainability is of extreme importantan=
ce.
>> However, this code causes no instability or maintainability issues to TCP
>> code. Consider the bug that you pointed out, MPTCP fails not TCP. We hav=
e to
>> accept the fact that TCP changes will break=C2=A0 MPTCP no matter what t=
he
>> implementation is because TCP maintainers may or may not test MPTCP. So =
this
>> is nothing out of the extraordinary.
>> Our patch tries to maintain the stability of TCP. We have reduced MPTCP =
code
>> within TCP and anything that is left is under #ifdef MPTCP so that TCP
>> developers can enhance, build and test TCP without worrying about MPTCP.=
 Not
>> only that, we have tried to limit any performance impact to pure TCP when
>> MPTCP is enabled.
> The point-of-view you take here is that introducing bugs in MPTCP is more
> acceptable. Unfortunately, that's not the case once the code is upstream.
> Because, the upstream maintainers are responsible that the code is stable
> and has no security holes.
No, that is not what I said, it is how you interpreted it. I said

"implementation is because *TCP maintainers may or may not test MPTCP*. =

So this is nothing out of the extraordinary."

Maybe maintainers should be "submitters".

If the submission rules require that all features should be tested, =

MPTCP will be tested and MPTCP will be just fine.
It is very common to see a change break a feature, such breakage is =

caught during review or testing and in some cases after the release. =

There is nothing special here. Following are some examples on how things =

get broken/caught/fixed.

https://www.spinics.net/lists/netdev/msg470389.html
https://www.spinics.net/lists/netdev/msg474372.html
https://www.spinics.net/lists/netdev/msg469607.html
https://marc.info/?l=3Dlinux-netdev&m=3D152453932929411&w=3D2
https://marc.info/?l=3Dlinux-netdev&m=3D152345771702029&w=3D2
> So, the MPTCP code should be designed in such a way that it does not requ=
ire
> extensive MPTCP-testing for simple TCP-changes. That's what I mean with T=
CP
> maintainability is of high importance.
> #ifdefs don't protect against any such issues as distributions typically
> enable all kernel-configs.
Simple is subjective. If there is an MPTCP test suite, running it is the =

most easiest way to ensure MPTCP is not broken.
However a locking change is not simple with or without MPTCP and even a =

test suite may not expose the bug.

This is again coming down to the usual nit picking and that I know what =

the correct thing to do is.

I prefer upstream make the call, however that would require sharing the =

code and asking.

Shoaib

>
>
> Christoph
>
>
>> I really do not see any maintainability or stability issues for TCP. TCP
>> will work and behave as it does today without MPTCP.
>>
>> Rao.
>>
>>> Christoph
>>>
>>>> Shoaib.
>>>>
>>>> [1] If MPTCP is built on top of TCP, any change in TCP will always hav=
e to
>>>> worry about MPTCP particularly in the control path. There is a overhea=
d of
>>>> adding MPTCP on TCP and no one can argue against it.
>>>>
>>>>> Christoph
>>>>>


--===============0049127797648372427==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPGJyPgog
ICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAwNC8zMC8yMDE4IDA5OjM0IEFNLCBD
aHJpc3RvcGgKICAgICAgUGFhc2NoIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOjIwMTgwNDMwMTYzNDUxLkdQMTkyNjBATWFj
Qm9vay1Qcm8tNi5sb2NhbCI+CiAgICAgIDxwcmUgd3JhcD0iIj5PbiAyNi8wNC8xOCAtIDE3OjQz
OjQ0LCBSYW8gU2hvYWliIHdyb3RlOgo8L3ByZT4KICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSI+CiAgICAgICAgPHByZSB3cmFwPSIiPgoKT24gMDQvMjYvMjAxOCAwMzoyMCBQTSwgQ2hyaXN0
b3BoIFBhYXNjaCB3cm90ZToKPC9wcmU+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+
CiAgICAgICAgICA8cHJlIHdyYXA9IiI+T24gMjYvMDQvMTggLSAxNDoyNToyNCwgUmFvIFNob2Fp
YiB3cm90ZToKPC9wcmU+CiAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAg
ICAgICAgPHByZSB3cmFwPSIiPgpPbiAwNC8yNi8yMDE4IDAxOjUyIFBNLCBDaHJpc3RvcGggUGFh
c2NoIHdyb3RlOgo8L3ByZT4KICAgICAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+CiAg
ICAgICAgICAgICAgPHByZSB3cmFwPSIiPlRoaXMga2luZCBvZiBsb2NrLXRha2luZyBhbHNvIGNh
dXNlcyB0cm91YmxlIHdpdGggUkNVIExPQ0tERVAgZGVidWdnaW5nIC0gYXMKSSBtZW50aW9uZWQg
aW4gYSBwcmV2aW91cyBlLW1haWwuCjwvcHJlPgogICAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAg
ICAgICAgICAgIDxwcmUgd3JhcD0iIj5JIGhhdmUgbm90IGxvb2tlZCBpbnRvIGl0IHNvIEkgY2Fu
IG5vdCBjb21tZW50LiBJIGFtIHN1cmUgd2Ugd2lsbCBmaW5kIGEgd2F5CnRvIGFkZHJlc3MgaXQu
CjwvcHJlPgogICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgICAg
ICA8cHJlIHdyYXA9IiI+QW5kIGJleW9uZCB0aGF0LCBpdCByZXF1aXJlcyB0aGF0IGV2ZXJ5dGlt
ZSBhIFRDUC1jaGFuZ2UgaXMgYmVpbmcgZG9uZSwgb25lCm5lZWRzIHRvIHRha2UgTVBUQ1AgaW50
byBhY2NvdW50LiBFLmcuLCB3aGVuIHVwc3RyZWFtIGFkZGVkIHRoZSBTT0NLX0RFU1RST1kKaW50
ZXJmYWNlIChhbmQgU2Ftc3VuZyBiYWNrcG9ydGVkIGl0IHRvIHY0LjQpLCB0aGVyZSB3ZXJlIHBh
bmljcyBvbiBBbmRyb2lkCmRldmljZXMgKDxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQi
IGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwL2lzc3Vlcy8xNzAi
Pmh0dHBzOi8vZ2l0aHViLmNvbS9tdWx0aXBhdGgtdGNwL21wdGNwL2lzc3Vlcy8xNzA8L2E+KS4K
CkF2b2lkIHRha2luZyB0aGUgbWV0YS1zb2NrZXQgbG9jayBvbiBzdWJmbG93LXdvcmsgYWxsb3dz
IGZvciBtdWNoIGVhc2llcgptYWludGVuYW5jZSBpbiB0aGUgbG9uZy10ZXJtLgo8L3ByZT4KICAg
ICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICA8cHJlIHdyYXA9IiI+VGhlIGJ1ZyB0
aGF0IHlvdSBoYXZlIHBvaW50ZWQgb3V0IGlzIGEgcnVuIG9mIHRoZSBtaWxsIGJ1ZyB0aGF0IHdl
IHNlZQpldmVyeWRheSwgdGhlcmUgaXMgbm90aGluZyBzcGVjaWFsIGFib3V0IGl0Lgo8L3ByZT4K
ICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgIDxwcmUgd3JhcD0iIj5FdWgsIHlvdSBt
ZWFuIHRoZSBpc3N1ZSAjMTcwIGlzIGhhcHBlbmluZyBmcmVxdWVudGx5PwoKSXQgc2hvdWxkbid0
ISBJZiBpdCBkb2VzLCB0aGF0J3MgYSBiaWcgY29uY2Vybi4KPC9wcmU+CiAgICAgICAgPC9ibG9j
a3F1b3RlPgogICAgICAgIDxwcmUgd3JhcD0iIj5ObyB3ZSBoYXZlIG5vdCBlbmNvdW50ZXJlZCB0
aGUgYnVnLiBXaGF0IEkgbWVhbnQgdG8gc2F5IHdhcyB0aGF0IHdoZW4KY2hhbmdlcyBvciBlbmhh
bmNlbWVudHMgYXJlIG1hZGUgdG8gdGhlIGNvZGUgaXQgaXMgcXVpdGUgY29tbW9uIHRoYXQKc29t
ZXRoaW5nIGJyZWFrcy4KPC9wcmU+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPHByZSB3cmFw
PSIiPgpUaGlzIGlzIGV4YWN0bHkgd2hhdCBzaG91bGQgYmUgYXZvaWRlZC4gU2VlIG15IGJlbG93
IGNvbW1lbnQgb24KbWFpbnRhaW5hYmlsaXR5LgoKPC9wcmU+CiAgICAgIDxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiPgogICAgICAgIDxwcmUgd3JhcD0iIj5UaGF0IGlzIHRoZSBjYXNlIGluIHRoZSBi
dWcgdGhhdCB5b3UgcG9pbnRlZC4KPC9wcmU+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSI+CiAgICAgICAgICA8cHJlIHdyYXA9IiI+CjwvcHJlPgogICAgICAgICAgPGJsb2NrcXVvdGUg
dHlwZT0iY2l0ZSI+CiAgICAgICAgICAgIDxwcmUgd3JhcD0iIj5UYWtpbmcgbWV0YSBsb2NrIGFj
dHVhbGx5IHNpbXBsaWZpZXMgdGhpbmdzIGEgbG90IGFuZCBoYXMgcmVkdWNlZAptYWludGFpbmFi
bGUgY29zdCwgbm90IHRha2luZyB0aGUgbWV0YSBsb2NrIHdpbGwgY3JlYXRlIHRpbWluZyBpc3N1
ZXMgbGVmdAphbmQgcmlnaHQuIFNvIHdlIGFyZSBqdXN0IHRyYWRpbmcgb25lIGhlYWRhY2hlIHdp
dGggYW5vdGhlci4KCkhvbGRpbmcgbWV0YSBsb2NrIHNob3VsZCBub3QgYmUgcGlwZWQgdXAgdW5u
ZWNlc3NhcmlseS4gWWVzLCBpZiBwb3NzaWJsZSBpZgpzaG91bGQgYmUgY2hhbmdlZCwgcGx1cyBv
dXIgcGF0Y2ggaGFzIG9ubHkgNiBjYXNlcyBpbiBUQ1AuCjwvcHJlPgogICAgICAgICAgPC9ibG9j
a3F1b3RlPgogICAgICAgICAgPHByZSB3cmFwPSIiPkkgdGhpbmssIHlvdSBhcmUgdGFraW5nIHRo
ZSBNUFRDUCBwb2ludC1vZi12aWV3IGhlcmUuIFllcywgdGFraW5nIHRoZQptZXRhLWxldmVsIGxv
Y2sgZG9lcyByZWR1Y2UgbWFpbnRhaW5hYmlsaXR5IG9mIE1QVENQICh3aGljaCBpcyB3aHkgd2Ug
ZGlkIGl0CnRoYXQgd2F5IGluIHRoZSBmaXJzdCBwbGFjZSA7LSkpCgpIb3dldmVyLCBmb3IgdXBz
dHJlYW1pbmcgd2UgaGF2ZSB0byB0aGluayB0aGUgb3RoZXIgd2F5IGFyb3VuZC4gVENQIGlzIHRo
ZQpjb21tb24tY2FzZSwgYW5kIE1QVENQIGlzIHRoZSBleG90aWMgY29ybmVyLWNhc2Ugb25seSBm
ZXcgY2FyZSBhYm91dC4KClNvLCBUQ1AtbWFpbnRhaW5hYmlsaXR5IGlzIG9mIG91dG1vc3QgaW1w
b3J0YW5jZS4gV2F5IG1vcmUgaW1wb3J0YW50IHRoYW4KTVBUQ1Ancy4KPC9wcmU+CiAgICAgICAg
PC9ibG9ja3F1b3RlPgogICAgICAgIDxwcmUgd3JhcD0iIj5JIGFncmVlIHRoYXQgVENQIHN0YWJp
bGl0eSBhbmQgbWFpbnRhaW5hYmlsaXR5IGlzIG9mIGV4dHJlbWUgaW1wb3J0YW50YW5jZS4KSG93
ZXZlciwgdGhpcyBjb2RlIGNhdXNlcyBubyBpbnN0YWJpbGl0eSBvciBtYWludGFpbmFiaWxpdHkg
aXNzdWVzIHRvIFRDUApjb2RlLiBDb25zaWRlciB0aGUgYnVnIHRoYXQgeW91IHBvaW50ZWQgb3V0
LCBNUFRDUCBmYWlscyBub3QgVENQLiBXZSBoYXZlIHRvCmFjY2VwdCB0aGUgZmFjdCB0aGF0IFRD
UCBjaGFuZ2VzIHdpbGwgYnJlYWvCoCBNUFRDUCBubyBtYXR0ZXIgd2hhdCB0aGUKaW1wbGVtZW50
YXRpb24gaXMgYmVjYXVzZSBUQ1AgbWFpbnRhaW5lcnMgbWF5IG9yIG1heSBub3QgdGVzdCBNUFRD
UC4gU28gdGhpcwppcyBub3RoaW5nIG91dCBvZiB0aGUgZXh0cmFvcmRpbmFyeS4KT3VyIHBhdGNo
IHRyaWVzIHRvIG1haW50YWluIHRoZSBzdGFiaWxpdHkgb2YgVENQLiBXZSBoYXZlIHJlZHVjZWQg
TVBUQ1AgY29kZQp3aXRoaW4gVENQIGFuZCBhbnl0aGluZyB0aGF0IGlzIGxlZnQgaXMgdW5kZXIg
I2lmZGVmIE1QVENQIHNvIHRoYXQgVENQCmRldmVsb3BlcnMgY2FuIGVuaGFuY2UsIGJ1aWxkIGFu
ZCB0ZXN0IFRDUCB3aXRob3V0IHdvcnJ5aW5nIGFib3V0IE1QVENQLiBOb3QKb25seSB0aGF0LCB3
ZSBoYXZlIHRyaWVkIHRvIGxpbWl0IGFueSBwZXJmb3JtYW5jZSBpbXBhY3QgdG8gcHVyZSBUQ1Ag
d2hlbgpNUFRDUCBpcyBlbmFibGVkLgo8L3ByZT4KICAgICAgPC9ibG9ja3F1b3RlPgogICAgICA8
cHJlIHdyYXA9IiI+ClRoZSBwb2ludC1vZi12aWV3IHlvdSB0YWtlIGhlcmUgaXMgdGhhdCBpbnRy
b2R1Y2luZyBidWdzIGluIE1QVENQIGlzIG1vcmUKYWNjZXB0YWJsZS4gVW5mb3J0dW5hdGVseSwg
dGhhdCdzIG5vdCB0aGUgY2FzZSBvbmNlIHRoZSBjb2RlIGlzIHVwc3RyZWFtLgpCZWNhdXNlLCB0
aGUgdXBzdHJlYW0gbWFpbnRhaW5lcnMgYXJlIHJlc3BvbnNpYmxlIHRoYXQgdGhlIGNvZGUgaXMg
c3RhYmxlCmFuZCBoYXMgbm8gc2VjdXJpdHkgaG9sZXMuPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+
CiAgICBObywgdGhhdCBpcyBub3Qgd2hhdCBJIHNhaWQsIGl0IGlzIGhvdyB5b3UgaW50ZXJwcmV0
ZWQgaXQuIEkgc2FpZDxicj4KICAgIDxicj4KICAgICJpbXBsZW1lbnRhdGlvbiBpcyBiZWNhdXNl
IDxiPlRDUCBtYWludGFpbmVycyBtYXkgb3IgbWF5IG5vdCB0ZXN0CiAgICAgIE1QVENQPC9iPi4g
U28gdGhpcyBpcyBub3RoaW5nIG91dCBvZiB0aGUgZXh0cmFvcmRpbmFyeS4iPGJyPgogICAgPGJy
PgogICAgTWF5YmUgbWFpbnRhaW5lcnMgc2hvdWxkIGJlICJzdWJtaXR0ZXJzIi48YnI+CiAgICA8
YnI+CiAgICBJZiB0aGUgc3VibWlzc2lvbiBydWxlcyByZXF1aXJlIHRoYXQgYWxsIGZlYXR1cmVz
IHNob3VsZCBiZSB0ZXN0ZWQsCiAgICBNUFRDUCB3aWxsIGJlIHRlc3RlZCBhbmQgTVBUQ1Agd2ls
bCBiZSBqdXN0IGZpbmUuPGJyPgogICAgSXQgaXMgdmVyeSBjb21tb24gdG8gc2VlIGEgY2hhbmdl
IGJyZWFrIGEgZmVhdHVyZSwgc3VjaCBicmVha2FnZSBpcwogICAgY2F1Z2h0IGR1cmluZyByZXZp
ZXcgb3IgdGVzdGluZyBhbmQgaW4gc29tZSBjYXNlcyBhZnRlciB0aGUgcmVsZWFzZS4KICAgIFRo
ZXJlIGlzIG5vdGhpbmcgc3BlY2lhbCBoZXJlLiBGb2xsb3dpbmcgYXJlIHNvbWUgZXhhbXBsZXMg
b24gaG93CiAgICB0aGluZ3MgZ2V0IGJyb2tlbi9jYXVnaHQvZml4ZWQuPGJyPgogICAgPGJyPgog
ICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly93d3cuc3Bp
bmljcy5uZXQvbGlzdHMvbmV0ZGV2L21zZzQ3MDM4OS5odG1sIj5odHRwczovL3d3dy5zcGluaWNz
Lm5ldC9saXN0cy9uZXRkZXYvbXNnNDcwMzg5Lmh0bWw8L2E+PGJyPgogICAgPGEgY2xhc3M9Im1v
ei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMv
bmV0ZGV2L21zZzQ3NDM3Mi5odG1sIj5odHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9uZXRk
ZXYvbXNnNDc0MzcyLmh0bWw8L2E+PGJyPgogICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVl
dGV4dCIgaHJlZj0iaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbmV0ZGV2L21zZzQ2OTYw
Ny5odG1sIj5odHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9uZXRkZXYvbXNnNDY5NjA3Lmh0
bWw8L2E+PGJyPgogICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0
cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbmV0ZGV2JmFtcDttPTE1MjQ1MzkzMjkyOTQxMSZhbXA7
dz0yIj5odHRwczovL21hcmMuaW5mby8/bD1saW51eC1uZXRkZXYmYW1wO209MTUyNDUzOTMyOTI5
NDExJmFtcDt3PTI8L2E+PGJyPgogICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCIg
aHJlZj0iaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtbmV0ZGV2JmFtcDttPTE1MjM0NTc3MTcw
MjAyOSZhbXA7dz0yIj5odHRwczovL21hcmMuaW5mby8/bD1saW51eC1uZXRkZXYmYW1wO209MTUy
MzQ1NzcxNzAyMDI5JmFtcDt3PTI8L2E+PGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIK
ICAgICAgY2l0ZT0ibWlkOjIwMTgwNDMwMTYzNDUxLkdQMTkyNjBATWFjQm9vay1Qcm8tNi5sb2Nh
bCI+CiAgICAgIDxwcmUgd3JhcD0iIj4KU28sIHRoZSBNUFRDUCBjb2RlIHNob3VsZCBiZSBkZXNp
Z25lZCBpbiBzdWNoIGEgd2F5IHRoYXQgaXQgZG9lcyBub3QgcmVxdWlyZQpleHRlbnNpdmUgTVBU
Q1AtdGVzdGluZyBmb3Igc2ltcGxlIFRDUC1jaGFuZ2VzLiBUaGF0J3Mgd2hhdCBJIG1lYW4gd2l0
aCBUQ1AKbWFpbnRhaW5hYmlsaXR5IGlzIG9mIGhpZ2ggaW1wb3J0YW5jZS4KI2lmZGVmcyBkb24n
dCBwcm90ZWN0IGFnYWluc3QgYW55IHN1Y2ggaXNzdWVzIGFzIGRpc3RyaWJ1dGlvbnMgdHlwaWNh
bGx5CmVuYWJsZSBhbGwga2VybmVsLWNvbmZpZ3MuPC9wcmU+CiAgICA8L2Jsb2NrcXVvdGU+CiAg
ICBTaW1wbGUgaXMgc3ViamVjdGl2ZS4gSWYgdGhlcmUgaXMgYW4gTVBUQ1AgdGVzdCBzdWl0ZSwg
cnVubmluZyBpdCBpcwogICAgdGhlIG1vc3QgZWFzaWVzdCB3YXkgdG8gZW5zdXJlIE1QVENQIGlz
IG5vdCBicm9rZW4uPGJyPgogICAgSG93ZXZlciBhIGxvY2tpbmcgY2hhbmdlIGlzIG5vdCBzaW1w
bGUgd2l0aCBvciB3aXRob3V0IE1QVENQIGFuZAogICAgZXZlbiBhIHRlc3Qgc3VpdGUgbWF5IG5v
dCBleHBvc2UgdGhlIGJ1Zy48YnI+CiAgICA8YnI+CiAgICBUaGlzIGlzIGFnYWluIGNvbWluZyBk
b3duIHRvIHRoZSB1c3VhbCBuaXQgcGlja2luZyBhbmQgdGhhdCBJIGtub3cKICAgIHdoYXQgdGhl
IGNvcnJlY3QgdGhpbmcgdG8gZG8gaXMuPGJyPgogICAgPGJyPgogICAgSSBwcmVmZXIgdXBzdHJl
YW0gbWFrZSB0aGUgY2FsbCwgaG93ZXZlciB0aGF0IHdvdWxkIHJlcXVpcmUgc2hhcmluZwogICAg
dGhlIGNvZGUgYW5kIGFza2luZy48YnI+CiAgICA8YnI+CiAgICBTaG9haWI8YnI+CiAgICA8YnI+
CiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIgogICAgICBjaXRlPSJtaWQ6MjAxODA0MzAxNjM0
NTEuR1AxOTI2MEBNYWNCb29rLVByby02LmxvY2FsIj4KICAgICAgPHByZSB3cmFwPSIiPgoKCkNo
cmlzdG9waAoKCjwvcHJlPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj4KICAgICAgICA8
cHJlIHdyYXA9IiI+CkkgcmVhbGx5IGRvIG5vdCBzZWUgYW55IG1haW50YWluYWJpbGl0eSBvciBz
dGFiaWxpdHkgaXNzdWVzIGZvciBUQ1AuIFRDUAp3aWxsIHdvcmsgYW5kIGJlaGF2ZSBhcyBpdCBk
b2VzIHRvZGF5IHdpdGhvdXQgTVBUQ1AuCgpSYW8uCgo8L3ByZT4KICAgICAgICA8YmxvY2txdW90
ZSB0eXBlPSJjaXRlIj4KICAgICAgICAgIDxwcmUgd3JhcD0iIj4KQ2hyaXN0b3BoCgo8L3ByZT4K
ICAgICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICA8cHJlIHdyYXA9
IiI+U2hvYWliLgoKWzFdIElmIE1QVENQIGlzIGJ1aWx0IG9uIHRvcCBvZiBUQ1AsIGFueSBjaGFu
Z2UgaW4gVENQIHdpbGwgYWx3YXlzIGhhdmUgdG8Kd29ycnkgYWJvdXQgTVBUQ1AgcGFydGljdWxh
cmx5IGluIHRoZSBjb250cm9sIHBhdGguIFRoZXJlIGlzIGEgb3ZlcmhlYWQgb2YKYWRkaW5nIE1Q
VENQIG9uIFRDUCBhbmQgbm8gb25lIGNhbiBhcmd1ZSBhZ2FpbnN0IGl0LgoKPC9wcmU+CiAgICAg
ICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiPgogICAgICAgICAgICAgIDxwcmUgd3JhcD0i
Ij4KQ2hyaXN0b3BoCgo8L3ByZT4KICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAg
PC9ibG9ja3F1b3RlPgogICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICA8cHJlIHdyYXA9IiI+
CjwvcHJlPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICA8L2Jsb2NrcXVvdGU+CiAgICA8YnI+CiAg
PC9ib2R5Pgo8L2h0bWw+Cg==

--===============0049127797648372427==--
