Content-Type: multipart/mixed; boundary="===============2352219549151985169=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 8/9] Restructure TCP code so that it can be shared
 primarily with MPTCP
Date: Mon, 09 Apr 2018 23:10:57 -0700
Message-ID: <7ed3fab1-3a2b-92aa-4b94-35dbef6090ba@oracle.com>
In-Reply-To: 8fb0cc8b-4f60-c42b-a2a6-940e72fad2ac@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 532

--===============2352219549151985169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/09/2018 10:42 PM, Rao Shoaib wrote:
>
>
>
> On 04/08/2018 09:58 PM, Christoph Paasch wrote:
>>>> are needed.
>>>>
>>>> You would need to explain this in the commit-message as otherwise the =
review
>>>> is very difficult.
>>> These changes are part of restructuring as the title says. MPTCP is very
>>> intrusive to TCP code. Where possible I have re-factored TCP functions =
into
>>> common code and separated out the code where MPTCP and TCP differ. The
>>> calling function calls the socket type specific function that uses the
>>> common function.
>> Yes, I see that. What I mean is that the commit-message has to describe =
why
>> a certain change is needed, not only what the change is doing.
>>
>> For MPTCP, the problem is that the interface might not support
>> scatter-gather because a connection is no more "linked" to a single
>> interface.
>>
>> To reduce the amount of code-changes needed for MPTCP in a patch-submiss=
ion
>> to netdev (even if such a submission would be just for feedback), we cou=
ld
>> simply make MPTCP always do sock_no_sendpage().
I did not address the above comment.

I understand the issues with MPTCP -- I implemented this change just to =

avoid a comment that my patch lacks this functionality. I do prefer that =

we just do sock_no_sendpage(), because this change is messy and I had =

planned to think about it more, I prefer if I do not have to.

Shoaib

>>
>>
>> Christoph
>>
> As I said before I was not sending it to netdev. If I were sending it =

> to netdev everything would be different. If anyone has any questions =

> please ask, truly I thought I would be insulting the reviewers by =

> providing this kind of details.
>
> I submitted the following patch which makes changes that are not =

> obvious, not one person has said that I have not described the changes =

> in detail.
>
> https://lkml.org/lkml/2018/4/2/13
>
> Shoaib
>
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2352219549151985169==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPGJyPgog
ICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAwNC8wOS8yMDE4IDEwOjQyIFBNLCBS
YW8gU2hvYWliCiAgICAgIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOjhmYjBjYzhiLTRmNjAtYzQyYi1hMmE2LTk0MGU3MmZh
ZDJhY0BvcmFjbGUuY29tIj4KICAgICAgPG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBj
b250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9dXRmLTgiPgogICAgICA8cD48YnI+CiAgICAgIDwv
cD4KICAgICAgPGJyPgogICAgICA8ZGl2IGNsYXNzPSJtb3otY2l0ZS1wcmVmaXgiPk9uIDA0LzA4
LzIwMTggMDk6NTggUE0sIENocmlzdG9waAogICAgICAgIFBhYXNjaCB3cm90ZTo8YnI+CiAgICAg
IDwvZGl2PgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIgogICAgICAgIGNpdGU9Im1pZDoy
MDE4MDQwOTA0NTgxNC5HWDE2Mjg5QE1hY0Jvb2stUHJvLTYubG9jYWwiPgogICAgICAgIDxibG9j
a3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJjb2xvcjogIzAwMDAwMDsiPgogICAgICAgICAgPGJs
b2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9ImNvbG9yOiAjMDAwMDAwOyI+CiAgICAgICAgICAg
IDxwcmUgd3JhcD0iIj5hcmUgbmVlZGVkLgoKWW91IHdvdWxkIG5lZWQgdG8gZXhwbGFpbiB0aGlz
IGluIHRoZSBjb21taXQtbWVzc2FnZSBhcyBvdGhlcndpc2UgdGhlIHJldmlldwppcyB2ZXJ5IGRp
ZmZpY3VsdC4KPC9wcmU+CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8cHJlIHdy
YXA9IiI+VGhlc2UgY2hhbmdlcyBhcmUgcGFydCBvZiByZXN0cnVjdHVyaW5nIGFzIHRoZSB0aXRs
ZSBzYXlzLiBNUFRDUCBpcyB2ZXJ5CmludHJ1c2l2ZSB0byBUQ1AgY29kZS4gV2hlcmUgcG9zc2li
bGUgSSBoYXZlIHJlLWZhY3RvcmVkIFRDUCBmdW5jdGlvbnMgaW50bwpjb21tb24gY29kZSBhbmQg
c2VwYXJhdGVkIG91dCB0aGUgY29kZSB3aGVyZSBNUFRDUCBhbmQgVENQIGRpZmZlci4gVGhlCmNh
bGxpbmcgZnVuY3Rpb24gY2FsbHMgdGhlIHNvY2tldCB0eXBlIHNwZWNpZmljIGZ1bmN0aW9uIHRo
YXQgdXNlcyB0aGUKY29tbW9uIGZ1bmN0aW9uLgo8L3ByZT4KICAgICAgICA8L2Jsb2NrcXVvdGU+
CiAgICAgICAgPHByZSB3cmFwPSIiPlllcywgSSBzZWUgdGhhdC4gV2hhdCBJIG1lYW4gaXMgdGhh
dCB0aGUgY29tbWl0LW1lc3NhZ2UgaGFzIHRvIGRlc2NyaWJlIHdoeQphIGNlcnRhaW4gY2hhbmdl
IGlzIG5lZWRlZCwgbm90IG9ubHkgd2hhdCB0aGUgY2hhbmdlIGlzIGRvaW5nLgoKRm9yIE1QVENQ
LCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBpbnRlcmZhY2UgbWlnaHQgbm90IHN1cHBvcnQKc2Nh
dHRlci1nYXRoZXIgYmVjYXVzZSBhIGNvbm5lY3Rpb24gaXMgbm8gbW9yZSAibGlua2VkIiB0byBh
IHNpbmdsZQppbnRlcmZhY2UuCgpUbyByZWR1Y2UgdGhlIGFtb3VudCBvZiBjb2RlLWNoYW5nZXMg
bmVlZGVkIGZvciBNUFRDUCBpbiBhIHBhdGNoLXN1Ym1pc3Npb24KdG8gbmV0ZGV2IChldmVuIGlm
IHN1Y2ggYSBzdWJtaXNzaW9uIHdvdWxkIGJlIGp1c3QgZm9yIGZlZWRiYWNrKSwgd2UgY291bGQK
c2ltcGx5IG1ha2UgTVBUQ1AgYWx3YXlzIGRvIHNvY2tfbm9fc2VuZHBhZ2UoKS48L3ByZT4KICAg
ICAgPC9ibG9ja3F1b3RlPgogICAgPC9ibG9ja3F1b3RlPgogICAgSSBkaWQgbm90IGFkZHJlc3Mg
dGhlIGFib3ZlIGNvbW1lbnQuPGJyPgogICAgPGJyPgogICAgSSB1bmRlcnN0YW5kIHRoZSBpc3N1
ZXMgd2l0aCBNUFRDUCAtLSBJIGltcGxlbWVudGVkIHRoaXMgY2hhbmdlIGp1c3QKICAgIHRvIGF2
b2lkIGEgY29tbWVudCB0aGF0IG15IHBhdGNoIGxhY2tzIHRoaXMgZnVuY3Rpb25hbGl0eS4gSSBk
bwogICAgcHJlZmVyIHRoYXQgd2UganVzdCBkbyBzb2NrX25vX3NlbmRwYWdlKCksIGJlY2F1c2Ug
dGhpcyBjaGFuZ2UgaXMKICAgIG1lc3N5IGFuZCBJIGhhZCBwbGFubmVkIHRvIHRoaW5rIGFib3V0
IGl0IG1vcmUsIEkgcHJlZmVyIGlmIEkgZG8gbm90CiAgICBoYXZlIHRvLjxicj4KICAgIDxicj4K
ICAgIFNob2FpYjxicj4KICAgIDxicj4KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAg
IGNpdGU9Im1pZDo4ZmIwY2M4Yi00ZjYwLWM0MmItYTJhNi05NDBlNzJmYWQyYWNAb3JhY2xlLmNv
bSI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgICAgY2l0ZT0ibWlkOjIwMTgw
NDA5MDQ1ODE0LkdYMTYyODlATWFjQm9vay1Qcm8tNi5sb2NhbCI+CiAgICAgICAgPHByZSB3cmFw
PSIiPgoKCkNocmlzdG9waAoKPC9wcmU+CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgQXMgSSBz
YWlkIGJlZm9yZSBJIHdhcyBub3Qgc2VuZGluZyBpdCB0byBuZXRkZXYuIElmIEkgd2VyZSBzZW5k
aW5nCiAgICAgIGl0IHRvIG5ldGRldiBldmVyeXRoaW5nIHdvdWxkIGJlIGRpZmZlcmVudC4gSWYg
YW55b25lIGhhcyBhbnkKICAgICAgcXVlc3Rpb25zIHBsZWFzZSBhc2ssIHRydWx5IEkgdGhvdWdo
dCBJIHdvdWxkIGJlIGluc3VsdGluZyB0aGUKICAgICAgcmV2aWV3ZXJzIGJ5IHByb3ZpZGluZyB0
aGlzIGtpbmQgb2YgZGV0YWlscy4gPGJyPgogICAgICA8YnI+CiAgICAgIEkgc3VibWl0dGVkIHRo
ZSBmb2xsb3dpbmcgcGF0Y2ggd2hpY2ggbWFrZXMgY2hhbmdlcyB0aGF0IGFyZSBub3QKICAgICAg
b2J2aW91cywgbm90IG9uZSBwZXJzb24gaGFzIHNhaWQgdGhhdCBJIGhhdmUgbm90IGRlc2NyaWJl
ZCB0aGUKICAgICAgY2hhbmdlcyBpbiBkZXRhaWwuPGJyPgogICAgICA8YnI+CiAgICAgIDxhIGNs
YXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQiCiAgICAgICAgaHJlZj0iaHR0cHM6Ly9sa21sLm9y
Zy9sa21sLzIwMTgvNC8yLzEzIiBtb3otZG8tbm90LXNlbmQ9InRydWUiPmh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDE4LzQvMi8xMzwvYT48YnI+CiAgICAgIDxicj4KICAgICAgU2hvYWliPGJyPgog
ICAgICA8YnI+CiAgICAgIDxmaWVsZHNldCBjbGFzcz0ibWltZUF0dGFjaG1lbnRIZWFkZXIiPjwv
ZmllbGRzZXQ+CiAgICAgIDxicj4KICAgICAgPHByZSB3cmFwPSIiPl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCm1wdGNwIG1haWxpbmcgbGlzdAo8YSBjbGFz
cz0ibW96LXR4dC1saW5rLWFiYnJldmlhdGVkIiBocmVmPSJtYWlsdG86bXB0Y3BAbGlzdHMuMDEu
b3JnIj5tcHRjcEBsaXN0cy4wMS5vcmc8L2E+CjxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJlZXRl
eHQiIGhyZWY9Imh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3AiPmh0
dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3A8L2E+CjwvcHJlPgogICAg
PC9ibG9ja3F1b3RlPgogICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============2352219549151985169==--
