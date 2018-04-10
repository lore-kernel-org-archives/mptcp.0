Content-Type: multipart/mixed; boundary="===============6320579981088196418=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 0/9] Changes for implementing MPTCP
Date: Mon, 09 Apr 2018 22:33:55 -0700
Message-ID: <21ef15b3-fbb9-960a-5faf-2221144b4997@oracle.com>
In-Reply-To: 20180409050325.GY16289@MacBook-Pro-6.local
X-Status: 
X-Keywords:                  
X-UID: 530

--===============6320579981088196418==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 04/08/2018 10:03 PM, Christoph Paasch wrote:
>> Please also remember our initial goal is to implement a very simple MPTCP
>> implementation and we are not trying to be on par with mptcp-dev.
> Yes, I couldn't agree more with this. We should do a simple and minimal
> implementation of MPTCP. Which is why in some of my comments I ask why a
> certain change is needed as we could simplify things.
That is great. Please submit patches that simplify MPTCP's interaction =

with TCP or at least creates a clean API. That is what I have tried to =

do but there is still a lot of work to be done.
>
>>> * The patches are holding the meta-lock when processing incoming packet=
s or
>>>     timer-events. This will trigger a lot of RCU-warnings. Adressing th=
is is
>>>     not trivial and will require significant architectural changes.
>>>
>> I do not want any significant architectural changes. I have not seen any=
 RCU
>> warnings in my testing so I was not aware of that.
> You can simply enable LOCKDEP and then you will see plenty of them.
I have not addressed MPTCP=C2=A0 code yet. The patches that I have submitte=
d =

for Peter will show that I have changed it a lot. I will try to test =

with LOCKDEP and see if I can resolve the issue.

Shoaib


--===============6320579981088196418==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+CiAgPC9oZWFkPgogIDxib2R5IHRleHQ9IiMw
MDAwMDAiIGJnY29sb3I9IiNGRkZGRkYiPgogICAgPHA+PGJyPgogICAgPC9wPgogICAgPGJyPgog
ICAgPGRpdiBjbGFzcz0ibW96LWNpdGUtcHJlZml4Ij5PbiAwNC8wOC8yMDE4IDEwOjAzIFBNLCBD
aHJpc3RvcGgKICAgICAgUGFhc2NoIHdyb3RlOjxicj4KICAgIDwvZGl2PgogICAgPGJsb2NrcXVv
dGUgdHlwZT0iY2l0ZSIKICAgICAgY2l0ZT0ibWlkOjIwMTgwNDA5MDUwMzI1LkdZMTYyODlATWFj
Qm9vay1Qcm8tNi5sb2NhbCI+CiAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJj
b2xvcjogIzAwMDAwMDsiPgogICAgICAgIDxwcmUgd3JhcD0iIj5QbGVhc2UgYWxzbyByZW1lbWJl
ciBvdXIgaW5pdGlhbCBnb2FsIGlzIHRvIGltcGxlbWVudCBhIHZlcnkgc2ltcGxlIE1QVENQCmlt
cGxlbWVudGF0aW9uIGFuZCB3ZSBhcmUgbm90IHRyeWluZyB0byBiZSBvbiBwYXIgd2l0aCBtcHRj
cC1kZXYuCjwvcHJlPgogICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxwcmUgd3JhcD0iIj5ZZXMs
IEkgY291bGRuJ3QgYWdyZWUgbW9yZSB3aXRoIHRoaXMuIFdlIHNob3VsZCBkbyBhIHNpbXBsZSBh
bmQgbWluaW1hbAppbXBsZW1lbnRhdGlvbiBvZiBNUFRDUC4gV2hpY2ggaXMgd2h5IGluIHNvbWUg
b2YgbXkgY29tbWVudHMgSSBhc2sgd2h5IGEKY2VydGFpbiBjaGFuZ2UgaXMgbmVlZGVkIGFzIHdl
IGNvdWxkIHNpbXBsaWZ5IHRoaW5ncy48L3ByZT4KICAgIDwvYmxvY2txdW90ZT4KICAgIFRoYXQg
aXMgZ3JlYXQuIFBsZWFzZSBzdWJtaXQgcGF0Y2hlcyB0aGF0IHNpbXBsaWZ5IE1QVENQJ3MKICAg
IGludGVyYWN0aW9uIHdpdGggVENQIG9yIGF0IGxlYXN0IGNyZWF0ZXMgYSBjbGVhbiBBUEkuIFRo
YXQgaXMgd2hhdCBJCiAgICBoYXZlIHRyaWVkIHRvIGRvIGJ1dCB0aGVyZSBpcyBzdGlsbCBhIGxv
dCBvZiB3b3JrIHRvIGJlIGRvbmUuPGJyPgogICAgPGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIKICAg
ICAgY2l0ZT0ibWlkOjIwMTgwNDA5MDUwMzI1LkdZMTYyODlATWFjQm9vay1Qcm8tNi5sb2NhbCI+
CiAgICAgIDxwcmUgd3JhcD0iIj4KCjwvcHJlPgogICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRl
IiBzdHlsZT0iY29sb3I6ICMwMDAwMDA7Ij4KICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRl
IiBzdHlsZT0iY29sb3I6ICMwMDAwMDA7Ij4KICAgICAgICAgIDxwcmUgd3JhcD0iIj4qIFRoZSBw
YXRjaGVzIGFyZSBob2xkaW5nIHRoZSBtZXRhLWxvY2sgd2hlbiBwcm9jZXNzaW5nIGluY29taW5n
IHBhY2tldHMgb3IKICAgdGltZXItZXZlbnRzLiBUaGlzIHdpbGwgdHJpZ2dlciBhIGxvdCBvZiBS
Q1Utd2FybmluZ3MuIEFkcmVzc2luZyB0aGlzIGlzCiAgIG5vdCB0cml2aWFsIGFuZCB3aWxsIHJl
cXVpcmUgc2lnbmlmaWNhbnQgYXJjaGl0ZWN0dXJhbCBjaGFuZ2VzLgoKPC9wcmU+CiAgICAgICAg
PC9ibG9ja3F1b3RlPgogICAgICAgIDxwcmUgd3JhcD0iIj5JIGRvIG5vdCB3YW50IGFueSBzaWdu
aWZpY2FudCBhcmNoaXRlY3R1cmFsIGNoYW5nZXMuIEkgaGF2ZSBub3Qgc2VlbiBhbnkgUkNVCndh
cm5pbmdzIGluIG15IHRlc3Rpbmcgc28gSSB3YXMgbm90IGF3YXJlIG9mIHRoYXQuCjwvcHJlPgog
ICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgIDxwcmUgd3JhcD0iIj5Zb3UgY2FuIHNpbXBseSBlbmFi
bGUgTE9DS0RFUCBhbmQgdGhlbiB5b3Ugd2lsbCBzZWUgcGxlbnR5IG9mIHRoZW0uCjwvcHJlPgog
ICAgPC9ibG9ja3F1b3RlPgogICAgSSBoYXZlIG5vdCBhZGRyZXNzZWQgTVBUQ1DCoCBjb2RlIHll
dC4gVGhlIHBhdGNoZXMgdGhhdCBJIGhhdmUKICAgIHN1Ym1pdHRlZCBmb3IgUGV0ZXIgd2lsbCBz
aG93IHRoYXQgSSBoYXZlIGNoYW5nZWQgaXQgYSBsb3QuIEkgd2lsbAogICAgdHJ5IHRvIHRlc3Qg
d2l0aCBMT0NLREVQIGFuZCBzZWUgaWYgSSBjYW4gcmVzb2x2ZSB0aGUgaXNzdWUuPGJyPgogICAg
PGJyPgogICAgU2hvYWliPGJyPgogICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============6320579981088196418==--
