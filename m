Content-Type: multipart/mixed; boundary="===============5673175734054842360=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Fwd: Re: Few questions about submitting patches
Date: Wed, 21 Mar 2018 10:01:13 -0700
Message-ID: <3b8f175a-3485-6725-ebc3-52f6d2e6ce47@oracle.com>
In-Reply-To: 20180321.124617.2106770550516986973.davem@davemloft.net
X-Status: 
X-Keywords:                  
X-UID: 388

--===============5673175734054842360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There has been some misunderstanding on what an RFC patch is and what =

standards it needs to meet. Following is the official response of David =

Miller.

Based on those guidelines the RFC patch we submitted meets and exceeds =

the requirements. So please review it. Replacement of function pointers =

will be addressed later as a separate issue.

In case there are other procedural issues that would prohibit technical =

discussion please site the written rules or first ask David Miller.

There are a lot of technical issues to discuss, so if possible lets not =

get tied up on process and bureaucracy. Looking forward to detailed =

technical comments.

Shoaib


-------- Forwarded Message --------
Subject: 	Re: Few questions about submitting patches
Date: 	Wed, 21 Mar 2018 12:46:17 -0400 (EDT)
From: 	David Miller <davem(a)davemloft.net>
To: 	rao.shoaib(a)oracle.com
CC: 	netdev(a)vger.kernel.org, eric.dumazet(a)gmail.com



From: Rao Shoaib <rao.shoaib(a)oracle.com>
Date: Wed, 21 Mar 2018 09:41:13 -0700

> I am new to Linux. I would like to understand the rules and etiquettes
> of engaging with the community. I have read the materials that I could
> find. As I work with Linux I come across situations for which I can
> not seem to find any answers. Hopefully folks on the list can answer
> them.
> =

> * Submitting an RFC Patch
> =

> As I understand, an RFC patch is submitted to solicit comments and is
> not for inclusion. Is it sufficient for an RFC patch to have the
> correct coding style and compile, or does it need more? For example,
> If the patch consists of a series of patches, does each patch have to
> compile independently etc etc.

It should build and function, unless you explicitly state that the
patch is not build nor functionally tested and is intended to show
the design of the change.

> * #ifdef FOO
> =

> In a regular patch consisting of a series of patches, can the above
> #ifdef be used in a patch before the patch that allows the selection
> of FOO. That patch is part of the series but comes later.

It is better to introduce them at the same time.

But if it is prohibitively difficult to do so, yet at the same
time properly split up your changes into manageable pieces, it
can be OK.

It is definitely determined on a case by case basis.


--===============5673175734054842360==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CgogICAgPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBjb250
ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9d2luZG93cy0xMjUyIj4KICA8L2hlYWQ+CiAgPGJvZHkg
dGV4dD0iIzAwMDAwMCIgYmdjb2xvcj0iI0ZGRkZGRiI+CiAgICA8cD5UaGVyZSBoYXMgYmVlbiBz
b21lIG1pc3VuZGVyc3RhbmRpbmcgb24gd2hhdCBhbiBSRkMgcGF0Y2ggaXMgYW5kCiAgICAgIHdo
YXQgc3RhbmRhcmRzIGl0IG5lZWRzIHRvIG1lZXQuIEZvbGxvd2luZyBpcyB0aGUgb2ZmaWNpYWwK
ICAgICAgcmVzcG9uc2Ugb2YgRGF2aWQgTWlsbGVyLjwvcD4KICAgIDxwPkJhc2VkIG9uIHRob3Nl
IGd1aWRlbGluZXMgdGhlIFJGQyBwYXRjaCB3ZSBzdWJtaXR0ZWQgbWVldHMgYW5kCiAgICAgIGV4
Y2VlZHMgdGhlIHJlcXVpcmVtZW50cy4gU28gcGxlYXNlIHJldmlldyBpdC4gUmVwbGFjZW1lbnQg
b2YKICAgICAgZnVuY3Rpb24gcG9pbnRlcnMgd2lsbCBiZSBhZGRyZXNzZWQgbGF0ZXIgYXMgYSBz
ZXBhcmF0ZSBpc3N1ZS48L3A+CiAgICA8cD5JbiBjYXNlIHRoZXJlIGFyZSBvdGhlciBwcm9jZWR1
cmFsIGlzc3VlcyB0aGF0IHdvdWxkIHByb2hpYml0CiAgICAgIHRlY2huaWNhbCBkaXNjdXNzaW9u
IHBsZWFzZSBzaXRlIHRoZSB3cml0dGVuIHJ1bGVzIG9yIGZpcnN0IGFzawogICAgICBEYXZpZCBN
aWxsZXIuPGJyPgogICAgPC9wPgogICAgPHA+VGhlcmUgYXJlIGEgbG90IG9mIHRlY2huaWNhbCBp
c3N1ZXMgdG8gZGlzY3Vzcywgc28gaWYgcG9zc2libGUKICAgICAgbGV0cyBub3QgZ2V0IHRpZWQg
dXAgb24gcHJvY2VzcyBhbmQgYnVyZWF1Y3JhY3kuIExvb2tpbmcgZm9yd2FyZAogICAgICB0byBk
ZXRhaWxlZCB0ZWNobmljYWwgY29tbWVudHMuPGJyPgogICAgPC9wPgogICAgPHA+U2hvYWliPC9w
PgogICAgPGRpdiBjbGFzcz0ibW96LWZvcndhcmQtY29udGFpbmVyIj48YnI+CiAgICAgIC0tLS0t
LS0tIEZvcndhcmRlZCBNZXNzYWdlIC0tLS0tLS0tCiAgICAgIDx0YWJsZSBjbGFzcz0ibW96LWVt
YWlsLWhlYWRlcnMtdGFibGUiIGNlbGxzcGFjaW5nPSIwIgogICAgICAgIGNlbGxwYWRkaW5nPSIw
IiBib3JkZXI9IjAiPgogICAgICAgIDx0Ym9keT4KICAgICAgICAgIDx0cj4KICAgICAgICAgICAg
PHRoIHZhbGlnbj0iQkFTRUxJTkUiIGFsaWduPSJSSUdIVCIgbm93cmFwPSJub3dyYXAiPlN1Ympl
Y3Q6CiAgICAgICAgICAgIDwvdGg+CiAgICAgICAgICAgIDx0ZD5SZTogRmV3IHF1ZXN0aW9ucyBh
Ym91dCBzdWJtaXR0aW5nIHBhdGNoZXM8L3RkPgogICAgICAgICAgPC90cj4KICAgICAgICAgIDx0
cj4KICAgICAgICAgICAgPHRoIHZhbGlnbj0iQkFTRUxJTkUiIGFsaWduPSJSSUdIVCIgbm93cmFw
PSJub3dyYXAiPkRhdGU6IDwvdGg+CiAgICAgICAgICAgIDx0ZD5XZWQsIDIxIE1hciAyMDE4IDEy
OjQ2OjE3IC0wNDAwIChFRFQpPC90ZD4KICAgICAgICAgIDwvdHI+CiAgICAgICAgICA8dHI+CiAg
ICAgICAgICAgIDx0aCB2YWxpZ249IkJBU0VMSU5FIiBhbGlnbj0iUklHSFQiIG5vd3JhcD0ibm93
cmFwIj5Gcm9tOiA8L3RoPgogICAgICAgICAgICA8dGQ+RGF2aWQgTWlsbGVyIDxhIGNsYXNzPSJt
b3otdHh0LWxpbmstcmZjMjM5NkUiIGhyZWY9Im1haWx0bzpkYXZlbUBkYXZlbWxvZnQubmV0Ij4m
bHQ7ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldCZndDs8L2E+PC90ZD4KICAgICAgICAgIDwvdHI+CiAgICAg
ICAgICA8dHI+CiAgICAgICAgICAgIDx0aCB2YWxpZ249IkJBU0VMSU5FIiBhbGlnbj0iUklHSFQi
IG5vd3JhcD0ibm93cmFwIj5UbzogPC90aD4KICAgICAgICAgICAgPHRkPjxhIGNsYXNzPSJtb3ot
dHh0LWxpbmstYWJicmV2aWF0ZWQiIGhyZWY9Im1haWx0bzpyYW8uc2hvYWliQG9yYWNsZS5jb20i
PnJhby5zaG9haWJAb3JhY2xlLmNvbTwvYT48L3RkPgogICAgICAgICAgPC90cj4KICAgICAgICAg
IDx0cj4KICAgICAgICAgICAgPHRoIHZhbGlnbj0iQkFTRUxJTkUiIGFsaWduPSJSSUdIVCIgbm93
cmFwPSJub3dyYXAiPkNDOiA8L3RoPgogICAgICAgICAgICA8dGQ+PGEgY2xhc3M9Im1vei10eHQt
bGluay1hYmJyZXZpYXRlZCIgaHJlZj0ibWFpbHRvOm5ldGRldkB2Z2VyLmtlcm5lbC5vcmciPm5l
dGRldkB2Z2VyLmtlcm5lbC5vcmc8L2E+LCA8YSBjbGFzcz0ibW96LXR4dC1saW5rLWFiYnJldmlh
dGVkIiBocmVmPSJtYWlsdG86ZXJpYy5kdW1hemV0QGdtYWlsLmNvbSI+ZXJpYy5kdW1hemV0QGdt
YWlsLmNvbTwvYT48L3RkPgogICAgICAgICAgPC90cj4KICAgICAgICA8L3Rib2R5PgogICAgICA8
L3RhYmxlPgogICAgICA8YnI+CiAgICAgIDxicj4KICAgICAgPHByZT5Gcm9tOiBSYW8gU2hvYWli
IDxhIGNsYXNzPSJtb3otdHh0LWxpbmstcmZjMjM5NkUiIGhyZWY9Im1haWx0bzpyYW8uc2hvYWli
QG9yYWNsZS5jb20iPiZsdDtyYW8uc2hvYWliQG9yYWNsZS5jb20mZ3Q7PC9hPgpEYXRlOiBXZWQs
IDIxIE1hciAyMDE4IDA5OjQxOjEzIC0wNzAwCgomZ3Q7IEkgYW0gbmV3IHRvIExpbnV4LiBJIHdv
dWxkIGxpa2UgdG8gdW5kZXJzdGFuZCB0aGUgcnVsZXMgYW5kIGV0aXF1ZXR0ZXMKJmd0OyBvZiBl
bmdhZ2luZyB3aXRoIHRoZSBjb21tdW5pdHkuIEkgaGF2ZSByZWFkIHRoZSBtYXRlcmlhbHMgdGhh
dCBJIGNvdWxkCiZndDsgZmluZC4gQXMgSSB3b3JrIHdpdGggTGludXggSSBjb21lIGFjcm9zcyBz
aXR1YXRpb25zIGZvciB3aGljaCBJIGNhbgomZ3Q7IG5vdCBzZWVtIHRvIGZpbmQgYW55IGFuc3dl
cnMuIEhvcGVmdWxseSBmb2xrcyBvbiB0aGUgbGlzdCBjYW4gYW5zd2VyCiZndDsgdGhlbS4KJmd0
OyAKJmd0OyAqIFN1Ym1pdHRpbmcgYW4gUkZDIFBhdGNoCiZndDsgCiZndDsgQXMgSSB1bmRlcnN0
YW5kLCBhbiBSRkMgcGF0Y2ggaXMgc3VibWl0dGVkIHRvIHNvbGljaXQgY29tbWVudHMgYW5kIGlz
CiZndDsgbm90IGZvciBpbmNsdXNpb24uIElzIGl0IHN1ZmZpY2llbnQgZm9yIGFuIFJGQyBwYXRj
aCB0byBoYXZlIHRoZQomZ3Q7IGNvcnJlY3QgY29kaW5nIHN0eWxlIGFuZCBjb21waWxlLCBvciBk
b2VzIGl0IG5lZWQgbW9yZT8gRm9yIGV4YW1wbGUsCiZndDsgSWYgdGhlIHBhdGNoIGNvbnNpc3Rz
IG9mIGEgc2VyaWVzIG9mIHBhdGNoZXMsIGRvZXMgZWFjaCBwYXRjaCBoYXZlIHRvCiZndDsgY29t
cGlsZSBpbmRlcGVuZGVudGx5IGV0YyBldGMuCgpJdCBzaG91bGQgYnVpbGQgYW5kIGZ1bmN0aW9u
LCB1bmxlc3MgeW91IGV4cGxpY2l0bHkgc3RhdGUgdGhhdCB0aGUKcGF0Y2ggaXMgbm90IGJ1aWxk
IG5vciBmdW5jdGlvbmFsbHkgdGVzdGVkIGFuZCBpcyBpbnRlbmRlZCB0byBzaG93CnRoZSBkZXNp
Z24gb2YgdGhlIGNoYW5nZS4KCiZndDsgKiAjaWZkZWYgRk9PCiZndDsgCiZndDsgSW4gYSByZWd1
bGFyIHBhdGNoIGNvbnNpc3Rpbmcgb2YgYSBzZXJpZXMgb2YgcGF0Y2hlcywgY2FuIHRoZSBhYm92
ZQomZ3Q7ICNpZmRlZiBiZSB1c2VkIGluIGEgcGF0Y2ggYmVmb3JlIHRoZSBwYXRjaCB0aGF0IGFs
bG93cyB0aGUgc2VsZWN0aW9uCiZndDsgb2YgRk9PLiBUaGF0IHBhdGNoIGlzIHBhcnQgb2YgdGhl
IHNlcmllcyBidXQgY29tZXMgbGF0ZXIuCgpJdCBpcyBiZXR0ZXIgdG8gaW50cm9kdWNlIHRoZW0g
YXQgdGhlIHNhbWUgdGltZS4KCkJ1dCBpZiBpdCBpcyBwcm9oaWJpdGl2ZWx5IGRpZmZpY3VsdCB0
byBkbyBzbywgeWV0IGF0IHRoZSBzYW1lCnRpbWUgcHJvcGVybHkgc3BsaXQgdXAgeW91ciBjaGFu
Z2VzIGludG8gbWFuYWdlYWJsZSBwaWVjZXMsIGl0CmNhbiBiZSBPSy4KCkl0IGlzIGRlZmluaXRl
bHkgZGV0ZXJtaW5lZCBvbiBhIGNhc2UgYnkgY2FzZSBiYXNpcy4KPC9wcmU+CiAgICA8L2Rpdj4K
ICA8L2JvZHk+CjwvaHRtbD4K

--===============5673175734054842360==--
