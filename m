Content-Type: multipart/mixed; boundary="===============7176295489566971182=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] Restructuring of TCP code for implementing MPTCP
Date: Fri, 09 Mar 2018 15:25:17 -0800
Message-ID: <73143413-688f-c7ee-98f6-76ed4c82faaf@oracle.com>
In-Reply-To: cba72947-007a-2312-aaf7-feb90b71a2e4@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 362

--===============7176295489566971182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 03/09/2018 03:01 PM, Rao Shoaib wrote:
>
>
> On 03/09/2018 02:19 PM, Mat Martineau wrote:
>>
>> Hi Rao -
>>
>> On Thu, 22 Feb 2018, Rao Shoaib wrote:
>>
>>> Hi Folks,
>>>
>>> When we met with David Miller and Eric Dumazet about a year ago to =

>>> discuss how to include MPTCP in the main Linux distribution, they =

>>> wanted to have some code that could be evaluated and used at the =

>>> basis for discussion.
>>>
>>> The patches that I have submitted are for starting that discussion =

>>> only and nothing else. If the approach is acceptable we can do more =

>>> cleanup, If not we will have a discussion and hopefully agree on =

>>> something.
>>>
>>> I would like to send the patches, perhaps a week from now to the =

>>> netdev mailing list to start a discussion there and come up with a =

>>> plan to implement MPTCP.
>>>
>>> Comments/Suggestions ?
>>>
>>
>> I saw that you posted some questions on netdev this week and got some =

>> maintainer feedback: https://marc.info/?t=3D152039384300002&r=3D1&w=3D2
>>
>> David mentions:
>>
>> """
>> Indirect calls are terrible and we are now looking at ways in which
>> we can remove them from as many parts of the networking as possible.
>> """
>>
> Yes against all objections I did post to net-dev and got some very =

> informative answers. David is not allowing indirect function calls =

> because of the security issues. You should see the comments that Linus =

> has made about the fixes and folks asking for an alternative as they =

> are heavily used.
>
> https://www.theregister.co.uk/2018/01/22/intel_spectre_fix_linux/
Sorry wrong url -- See

https://news.ycombinator.com/item?id=3D16066968

Edit: To give a bit more background, predicting indirect calls and =

speculating into them is absolutely critical to getting good performance =

from OOP-ish code which tends to use them a lot (virtual functions in =

C++, function pointers in C). *The Linux kernel is (thankfully?) not =

very OOP-ish, but it does rely on indirect calls (function pointers) =

extensively.

*Rao*.
*
>
>> It's not immediately clear which techniques are being looked at (and =

>> both Eric and David did not elaborate when you followed up). I'm =

>> trying to find out which alternatives he's referring to - anyone else =

>> seen information on this?
> Nope. It's not clear what the solution will be, but that should not =

> have any impact on the patch that we submitted. As a simple fix we can =

> add if/else as there are only two ways to go.
>
> Please see my email and comment.
>
> Rao.
>
>> Regards,
>>
>> -- =

>> Mat Martineau
>> Intel OTC
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============7176295489566971182==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPGJyPgog
ICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAwMy8wOS8yMDE4IDAzOjAxIFBNLCBS
YW8gU2hvYWliCiAgICAgIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOmNiYTcyOTQ3LTAwN2EtMjMxMi1hYWY3LWZlYjkwYjcx
YTJlNEBvcmFjbGUuY29tIj4KICAgICAgPGJyPgogICAgICA8YnI+CiAgICAgIE9uIDAzLzA5LzIw
MTggMDI6MTkgUE0sIE1hdCBNYXJ0aW5lYXUgd3JvdGU6CiAgICAgIDxicj4KICAgICAgPGJsb2Nr
cXVvdGUgdHlwZT0iY2l0ZSI+CiAgICAgICAgPGJyPgogICAgICAgIEhpIFJhbyAtCiAgICAgICAg
PGJyPgogICAgICAgIDxicj4KICAgICAgICBPbiBUaHUsIDIyIEZlYiAyMDE4LCBSYW8gU2hvYWli
IHdyb3RlOgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSI+SGkgRm9sa3MsCiAgICAgICAgICA8YnI+CiAgICAgICAgICA8YnI+CiAgICAgICAg
ICBXaGVuIHdlIG1ldCB3aXRoIERhdmlkIE1pbGxlciBhbmQgRXJpYyBEdW1hemV0IGFib3V0IGEg
eWVhcgogICAgICAgICAgYWdvIHRvIGRpc2N1c3MgaG93IHRvIGluY2x1ZGUgTVBUQ1AgaW4gdGhl
IG1haW4gTGludXgKICAgICAgICAgIGRpc3RyaWJ1dGlvbiwgdGhleSB3YW50ZWQgdG8gaGF2ZSBz
b21lIGNvZGUgdGhhdCBjb3VsZCBiZQogICAgICAgICAgZXZhbHVhdGVkIGFuZCB1c2VkIGF0IHRo
ZSBiYXNpcyBmb3IgZGlzY3Vzc2lvbi4KICAgICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAg
ICAgICAgIFRoZSBwYXRjaGVzIHRoYXQgSSBoYXZlIHN1Ym1pdHRlZCBhcmUgZm9yIHN0YXJ0aW5n
IHRoYXQKICAgICAgICAgIGRpc2N1c3Npb24gb25seSBhbmQgbm90aGluZyBlbHNlLiBJZiB0aGUg
YXBwcm9hY2ggaXMKICAgICAgICAgIGFjY2VwdGFibGUgd2UgY2FuIGRvIG1vcmUgY2xlYW51cCwg
SWYgbm90IHdlIHdpbGwgaGF2ZSBhCiAgICAgICAgICBkaXNjdXNzaW9uIGFuZCBob3BlZnVsbHkg
YWdyZWUgb24gc29tZXRoaW5nLgogICAgICAgICAgPGJyPgogICAgICAgICAgPGJyPgogICAgICAg
ICAgSSB3b3VsZCBsaWtlIHRvIHNlbmQgdGhlIHBhdGNoZXMsIHBlcmhhcHMgYSB3ZWVrIGZyb20g
bm93IHRvCiAgICAgICAgICB0aGUgbmV0ZGV2IG1haWxpbmcgbGlzdCB0byBzdGFydCBhIGRpc2N1
c3Npb24gdGhlcmUgYW5kIGNvbWUKICAgICAgICAgIHVwIHdpdGggYSBwbGFuIHRvIGltcGxlbWVu
dCBNUFRDUC4KICAgICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAgICAgICAgIENvbW1lbnRz
L1N1Z2dlc3Rpb25zID8KICAgICAgICAgIDxicj4KICAgICAgICAgIDxicj4KICAgICAgICA8L2Js
b2NrcXVvdGU+CiAgICAgICAgPGJyPgogICAgICAgIEkgc2F3IHRoYXQgeW91IHBvc3RlZCBzb21l
IHF1ZXN0aW9ucyBvbiBuZXRkZXYgdGhpcyB3ZWVrIGFuZCBnb3QKICAgICAgICBzb21lIG1haW50
YWluZXIgZmVlZGJhY2s6CiAgICAgICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCIg
aHJlZj0iaHR0cHM6Ly9tYXJjLmluZm8vP3Q9MTUyMDM5Mzg0MzAwMDAyJmFtcDtyPTEmYW1wO3c9
MiI+aHR0cHM6Ly9tYXJjLmluZm8vP3Q9MTUyMDM5Mzg0MzAwMDAyJmFtcDtyPTEmYW1wO3c9Mjwv
YT4KICAgICAgICA8YnI+CiAgICAgICAgPGJyPgogICAgICAgIERhdmlkIG1lbnRpb25zOgogICAg
ICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgIiIiCiAgICAgICAgPGJyPgogICAgICAgIElu
ZGlyZWN0IGNhbGxzIGFyZSB0ZXJyaWJsZSBhbmQgd2UgYXJlIG5vdyBsb29raW5nIGF0IHdheXMg
aW4KICAgICAgICB3aGljaAogICAgICAgIDxicj4KICAgICAgICB3ZSBjYW4gcmVtb3ZlIHRoZW0g
ZnJvbSBhcyBtYW55IHBhcnRzIG9mIHRoZSBuZXR3b3JraW5nIGFzCiAgICAgICAgcG9zc2libGUu
CiAgICAgICAgPGJyPgogICAgICAgICIiIgogICAgICAgIDxicj4KICAgICAgICA8YnI+CiAgICAg
IDwvYmxvY2txdW90ZT4KICAgICAgWWVzIGFnYWluc3QgYWxsIG9iamVjdGlvbnMgSSBkaWQgcG9z
dCB0byBuZXQtZGV2IGFuZCBnb3Qgc29tZSB2ZXJ5CiAgICAgIGluZm9ybWF0aXZlIGFuc3dlcnMu
IERhdmlkIGlzIG5vdCBhbGxvd2luZyBpbmRpcmVjdCBmdW5jdGlvbiBjYWxscwogICAgICBiZWNh
dXNlIG9mIHRoZSBzZWN1cml0eSBpc3N1ZXMuIFlvdSBzaG91bGQgc2VlIHRoZSBjb21tZW50cyB0
aGF0CiAgICAgIExpbnVzIGhhcyBtYWRlIGFib3V0IHRoZSBmaXhlcyBhbmQgZm9sa3MgYXNraW5n
IGZvciBhbiBhbHRlcm5hdGl2ZQogICAgICBhcyB0aGV5IGFyZSBoZWF2aWx5IHVzZWQuCiAgICAg
IDxicj4KICAgICAgPGJyPgogICAgICA8YSBjbGFzcz0ibW96LXR4dC1saW5rLWZyZWV0ZXh0IiBo
cmVmPSJodHRwczovL3d3dy50aGVyZWdpc3Rlci5jby51ay8yMDE4LzAxLzIyL2ludGVsX3NwZWN0
cmVfZml4X2xpbnV4LyI+aHR0cHM6Ly93d3cudGhlcmVnaXN0ZXIuY28udWsvMjAxOC8wMS8yMi9p
bnRlbF9zcGVjdHJlX2ZpeF9saW51eC88L2E+CiAgICAgIDxicj4KICAgIDwvYmxvY2txdW90ZT4K
ICAgIFNvcnJ5IHdyb25nIHVybCAtLSBTZWUgPGJyPgogICAgPGJyPgogICAgPGEgY2xhc3M9Im1v
ei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly9uZXdzLnljb21iaW5hdG9yLmNvbS9p
dGVtP2lkPTE2MDY2OTY4Ij5odHRwczovL25ld3MueWNvbWJpbmF0b3IuY29tL2l0ZW0/aWQ9MTYw
NjY5Njg8L2E+PGJyPgogICAgPGJyPgogICAgRWRpdDogVG8gZ2l2ZSBhIGJpdCBtb3JlIGJhY2tn
cm91bmQsIHByZWRpY3RpbmcgaW5kaXJlY3QgY2FsbHMgYW5kCiAgICBzcGVjdWxhdGluZyBpbnRv
IHRoZW0gaXMgYWJzb2x1dGVseSBjcml0aWNhbCB0byBnZXR0aW5nIGdvb2QKICAgIHBlcmZvcm1h
bmNlIGZyb20gT09QLWlzaCBjb2RlIHdoaWNoIHRlbmRzIHRvIHVzZSB0aGVtIGEgbG90ICh2aXJ0
dWFsCiAgICBmdW5jdGlvbnMgaW4gQysrLCBmdW5jdGlvbiBwb2ludGVycyBpbiBDKS4gPGI+VGhl
IExpbnV4IGtlcm5lbCBpcwogICAgICAodGhhbmtmdWxseT8pIG5vdCB2ZXJ5IE9PUC1pc2gsIGJ1
dCBpdCBkb2VzIHJlbHkgb24gaW5kaXJlY3QgY2FsbHMKICAgICAgKGZ1bmN0aW9uIHBvaW50ZXJz
KSBleHRlbnNpdmVseS48YnI+CiAgICAgIDxicj4KICAgIDwvYj5SYW88Yj4uPGJyPgogICAgPC9i
Pjxicj4KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDpjYmE3Mjk0
Ny0wMDdhLTIzMTItYWFmNy1mZWI5MGI3MWEyZTRAb3JhY2xlLmNvbSI+CiAgICAgIDxicj4KICAg
ICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSI+SXQncyBub3QgaW1tZWRpYXRlbHkgY2xlYXIgd2hp
Y2gKICAgICAgICB0ZWNobmlxdWVzIGFyZSBiZWluZyBsb29rZWQgYXQgKGFuZCBib3RoIEVyaWMg
YW5kIERhdmlkIGRpZCBub3QKICAgICAgICBlbGFib3JhdGUgd2hlbiB5b3UgZm9sbG93ZWQgdXAp
LiBJJ20gdHJ5aW5nIHRvIGZpbmQgb3V0IHdoaWNoCiAgICAgICAgYWx0ZXJuYXRpdmVzIGhlJ3Mg
cmVmZXJyaW5nIHRvIC0gYW55b25lIGVsc2Ugc2VlbiBpbmZvcm1hdGlvbiBvbgogICAgICAgIHRo
aXM/CiAgICAgICAgPGJyPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIE5vcGUuIEl0J3Mgbm90
IGNsZWFyIHdoYXQgdGhlIHNvbHV0aW9uIHdpbGwgYmUsIGJ1dCB0aGF0IHNob3VsZAogICAgICBu
b3QgaGF2ZSBhbnkgaW1wYWN0IG9uIHRoZSBwYXRjaCB0aGF0IHdlIHN1Ym1pdHRlZC4gQXMgYSBz
aW1wbGUKICAgICAgZml4IHdlIGNhbiBhZGQgaWYvZWxzZSBhcyB0aGVyZSBhcmUgb25seSB0d28g
d2F5cyB0byBnby4KICAgICAgPGJyPgogICAgICA8YnI+CiAgICAgIFBsZWFzZSBzZWUgbXkgZW1h
aWwgYW5kIGNvbW1lbnQuCiAgICAgIDxicj4KICAgICAgPGJyPgogICAgICBSYW8uCiAgICAgIDxi
cj4KICAgICAgPGJyPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIj5SZWdhcmRzLAogICAg
ICAgIDxicj4KICAgICAgICA8YnI+CiAgICAgICAgLS3CoDxicj4KICAgICAgICBNYXQgTWFydGlu
ZWF1CiAgICAgICAgPGJyPgogICAgICAgIEludGVsIE9UQwogICAgICAgIDxicj4KICAgICAgPC9i
bG9ja3F1b3RlPgogICAgICA8YnI+CiAgICAgIF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCiAgICAgIDxicj4KICAgICAgbXB0Y3AgbWFpbGluZyBsaXN0CiAg
ICAgIDxicj4KICAgICAgPGEgY2xhc3M9Im1vei10eHQtbGluay1hYmJyZXZpYXRlZCIgaHJlZj0i
bWFpbHRvOm1wdGNwQGxpc3RzLjAxLm9yZyI+bXB0Y3BAbGlzdHMuMDEub3JnPC9hPgogICAgICA8
YnI+CiAgICAgIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQiIGhyZWY9Imh0dHBzOi8v
bGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3AiPmh0dHBzOi8vbGlzdHMuMDEub3Jn
L21haWxtYW4vbGlzdGluZm8vbXB0Y3A8L2E+CiAgICAgIDxicj4KICAgIDwvYmxvY2txdW90ZT4K
ICAgIDxicj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============7176295489566971182==--
