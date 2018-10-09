Content-Type: multipart/mixed; boundary="===============8016242698567588421=="
MIME-Version: 1.0
From: Dejene Boru <dejene.boru at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP layer processing overhead?!
Date: Tue, 09 Oct 2018 23:59:19 +0200
Message-ID: <CAG40BELokRB53D3jdUP6kx8B1B=+J8Ycn3Y+rN5jBjKhyURA2g@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 799

--===============8016242698567588421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

My understanding from MPTCP protocol is that, if MPTCP has only one subflow
it behaves almost similar to regular TCP with Reno  congestion control.
This means that if I enable MPTCP but set the  congestion control for
example to BBR or DCTCP configuring the parameters required for the
respective congestion control, it should be able to achieve the same
throughput as when MPTCP is disabled and the corresponding congestion
control is configured. I have tested MPTCP with  one subflow  using DCTCP
congestion control and obtained a 10% reduced throughput compared with
MPTCP disabled.  Which part of the MPTCP code does result in this kind of
overhead?

Regards,

Dejene Boru

--===============8016242698567588421==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmO2NvbG9yOiMwYjUzOTQiPkhpIGFsbCw8L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVs
dmV0aWNhLHNhbnMtc2VyaWY7Y29sb3I6IzBiNTM5NCI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJp
Zjtjb2xvcjojMGI1Mzk0Ij5NeSB1bmRlcnN0YW5kaW5nIGZyb20gTVBUQ1AgcHJvdG9jb2wgaXMg
dGhhdCwgaWYgTVBUQ1AgaGFzIG9ubHkgb25lIHN1YmZsb3cgaXQgYmVoYXZlcyBhbG1vc3Qgc2lt
aWxhciB0byByZWd1bGFyIFRDUCB3aXRoIFJlbm8gwqBjb25nZXN0aW9uIGNvbnRyb2wuIFRoaXMg
bWVhbnMgdGhhdCBpZiBJIGVuYWJsZSBNUFRDUCBidXQgc2V0IHRoZSDCoGNvbmdlc3Rpb24gY29u
dHJvbCBmb3IgZXhhbXBsZSB0byBCQlIgb3IgRENUQ1AgY29uZmlndXJpbmcgdGhlIHBhcmFtZXRl
cnMgcmVxdWlyZWQgZm9yIHRoZSByZXNwZWN0aXZlIGNvbmdlc3Rpb24gY29udHJvbCwgaXQgc2hv
dWxkIGJlIGFibGUgdG8gYWNoaWV2ZSB0aGUgc2FtZSB0aHJvdWdocHV0IGFzIHdoZW4gTVBUQ1Ag
aXMgZGlzYWJsZWQgYW5kIHRoZSBjb3JyZXNwb25kaW5nIGNvbmdlc3Rpb24gY29udHJvbCBpcyBj
b25maWd1cmVkLiBJIGhhdmUgdGVzdGVkIE1QVENQIHdpdGggwqBvbmUgc3ViZmxvdyDCoHVzaW5n
IERDVENQIGNvbmdlc3Rpb24gY29udHJvbCBhbmQgb2J0YWluZWQgYSAxMCUgcmVkdWNlZCB0aHJv
dWdocHV0IGNvbXBhcmVkIHdpdGggTVBUQ1AgZGlzYWJsZWQuwqAgV2hpY2ggcGFydCBvZiB0aGUg
TVBUQ1AgY29kZSBkb2VzIHJlc3VsdCBpbiB0aGlzIGtpbmQgb2Ygb3ZlcmhlYWQ/wqA8L2Rpdj48
ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6YXJpYWwsaGVsdmV0
aWNhLHNhbnMtc2VyaWY7Y29sb3I6IzBiNTM5NCI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTphcmlhbCxoZWx2ZXRpY2Esc2Fucy1zZXJpZjtj
b2xvcjojMGI1Mzk0Ij5SZWdhcmRzLMKgPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmO2NvbG9yOiMwYjUz
OTQiPjxicj48L2Rpdj48ZGl2PjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUi
IGRhdGEtc21hcnRtYWlsPSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRp
diBkaXI9Imx0ciI+PGZvbnQgZmFjZT0idGltZXMgbmV3IHJvbWFuLCBzZXJpZiIgY29sb3I9IiM2
ZmE4ZGMiPkRlamVuZSBCb3J1PC9mb250PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2Pgo=

--===============8016242698567588421==--
