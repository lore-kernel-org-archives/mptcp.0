Content-Type: multipart/mixed; boundary="===============9022382267430459878=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 8/9] Restructure TCP code so that it can be shared
 primarily with MPTCP
Date: Mon, 09 Apr 2018 22:42:10 -0700
Message-ID: <8fb0cc8b-4f60-c42b-a2a6-940e72fad2ac@oracle.com>
In-Reply-To: 20180409045814.GX16289@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 531

--===============9022382267430459878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/08/2018 09:58 PM, Christoph Paasch wrote:
>>> are needed.
>>>
>>> You would need to explain this in the commit-message as otherwise the r=
eview
>>> is very difficult.
>> These changes are part of restructuring as the title says. MPTCP is very
>> intrusive to TCP code. Where possible I have re-factored TCP functions i=
nto
>> common code and separated out the code where MPTCP and TCP differ. The
>> calling function calls the socket type specific function that uses the
>> common function.
> Yes, I see that. What I mean is that the commit-message has to describe w=
hy
> a certain change is needed, not only what the change is doing.
>
> For MPTCP, the problem is that the interface might not support
> scatter-gather because a connection is no more "linked" to a single
> interface.
>
> To reduce the amount of code-changes needed for MPTCP in a patch-submissi=
on
> to netdev (even if such a submission would be just for feedback), we could
> simply make MPTCP always do sock_no_sendpage().
>
>
> Christoph
>
As I said before I was not sending it to netdev. If I were sending it to =

netdev everything would be different. If anyone has any questions please =

ask, truly I thought I would be insulting the reviewers by providing =

this kind of details.

I submitted the following patch which makes changes that are not =

obvious, not one person has said that I have not described the changes =

in detail.

https://lkml.org/lkml/2018/4/2/13

Shoaib

--===============9022382267430459878==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPGJyPgog
ICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAwNC8wOC8yMDE4IDA5OjU4IFBNLCBD
aHJpc3RvcGgKICAgICAgUGFhc2NoIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOjIwMTgwNDA5MDQ1ODE0LkdYMTYyODlATWFj
Qm9vay1Qcm8tNi5sb2NhbCI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJj
b2xvcjogIzAwMDAwMDsiPgogICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJj
b2xvcjogIzAwMDAwMDsiPgogICAgICAgICAgPHByZSB3cmFwPSIiPmFyZSBuZWVkZWQuCgpZb3Ug
d291bGQgbmVlZCB0byBleHBsYWluIHRoaXMgaW4gdGhlIGNvbW1pdC1tZXNzYWdlIGFzIG90aGVy
d2lzZSB0aGUgcmV2aWV3CmlzIHZlcnkgZGlmZmljdWx0Lgo8L3ByZT4KICAgICAgICA8L2Jsb2Nr
cXVvdGU+CiAgICAgICAgPHByZSB3cmFwPSIiPlRoZXNlIGNoYW5nZXMgYXJlIHBhcnQgb2YgcmVz
dHJ1Y3R1cmluZyBhcyB0aGUgdGl0bGUgc2F5cy4gTVBUQ1AgaXMgdmVyeQppbnRydXNpdmUgdG8g
VENQIGNvZGUuIFdoZXJlIHBvc3NpYmxlIEkgaGF2ZSByZS1mYWN0b3JlZCBUQ1AgZnVuY3Rpb25z
IGludG8KY29tbW9uIGNvZGUgYW5kIHNlcGFyYXRlZCBvdXQgdGhlIGNvZGUgd2hlcmUgTVBUQ1Ag
YW5kIFRDUCBkaWZmZXIuIFRoZQpjYWxsaW5nIGZ1bmN0aW9uIGNhbGxzIHRoZSBzb2NrZXQgdHlw
ZSBzcGVjaWZpYyBmdW5jdGlvbiB0aGF0IHVzZXMgdGhlCmNvbW1vbiBmdW5jdGlvbi4KPC9wcmU+
CiAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgPHByZSB3cmFwPSIiPlllcywgSSBzZWUgdGhhdC4g
V2hhdCBJIG1lYW4gaXMgdGhhdCB0aGUgY29tbWl0LW1lc3NhZ2UgaGFzIHRvIGRlc2NyaWJlIHdo
eQphIGNlcnRhaW4gY2hhbmdlIGlzIG5lZWRlZCwgbm90IG9ubHkgd2hhdCB0aGUgY2hhbmdlIGlz
IGRvaW5nLgoKRm9yIE1QVENQLCB0aGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBpbnRlcmZhY2UgbWln
aHQgbm90IHN1cHBvcnQKc2NhdHRlci1nYXRoZXIgYmVjYXVzZSBhIGNvbm5lY3Rpb24gaXMgbm8g
bW9yZSAibGlua2VkIiB0byBhIHNpbmdsZQppbnRlcmZhY2UuCgpUbyByZWR1Y2UgdGhlIGFtb3Vu
dCBvZiBjb2RlLWNoYW5nZXMgbmVlZGVkIGZvciBNUFRDUCBpbiBhIHBhdGNoLXN1Ym1pc3Npb24K
dG8gbmV0ZGV2IChldmVuIGlmIHN1Y2ggYSBzdWJtaXNzaW9uIHdvdWxkIGJlIGp1c3QgZm9yIGZl
ZWRiYWNrKSwgd2UgY291bGQKc2ltcGx5IG1ha2UgTVBUQ1AgYWx3YXlzIGRvIHNvY2tfbm9fc2Vu
ZHBhZ2UoKS4KCgpDaHJpc3RvcGgKCjwvcHJlPgogICAgPC9ibG9ja3F1b3RlPgogICAgQXMgSSBz
YWlkIGJlZm9yZSBJIHdhcyBub3Qgc2VuZGluZyBpdCB0byBuZXRkZXYuIElmIEkgd2VyZSBzZW5k
aW5nCiAgICBpdCB0byBuZXRkZXYgZXZlcnl0aGluZyB3b3VsZCBiZSBkaWZmZXJlbnQuIElmIGFu
eW9uZSBoYXMgYW55CiAgICBxdWVzdGlvbnMgcGxlYXNlIGFzaywgdHJ1bHkgSSB0aG91Z2h0IEkg
d291bGQgYmUgaW5zdWx0aW5nIHRoZQogICAgcmV2aWV3ZXJzIGJ5IHByb3ZpZGluZyB0aGlzIGtp
bmQgb2YgZGV0YWlscy4gPGJyPgogICAgPGJyPgogICAgSSBzdWJtaXR0ZWQgdGhlIGZvbGxvd2lu
ZyBwYXRjaCB3aGljaCBtYWtlcyBjaGFuZ2VzIHRoYXQgYXJlIG5vdAogICAgb2J2aW91cywgbm90
IG9uZSBwZXJzb24gaGFzIHNhaWQgdGhhdCBJIGhhdmUgbm90IGRlc2NyaWJlZCB0aGUKICAgIGNo
YW5nZXMgaW4gZGV0YWlsLjxicj4KICAgIDxicj4KICAgIDxhIGNsYXNzPSJtb3otdHh0LWxpbmst
ZnJlZXRleHQiIGhyZWY9Imh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzQvMi8xMyI+aHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMTgvNC8yLzEzPC9hPjxicj4KICAgIDxicj4KICAgIFNob2FpYjxi
cj4KICA8L2JvZHk+CjwvaHRtbD4K

--===============9022382267430459878==--
