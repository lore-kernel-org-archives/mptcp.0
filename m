Content-Type: multipart/mixed; boundary="===============0403334733161186608=="
MIME-Version: 1.0
From: Dejene Boru <dejene.boru at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] MPTCP layer processing overhead ?!
Date: Wed, 10 Oct 2018 00:03:33 +0200
Message-ID: <CAG40BEL5jmu4Bu4aCLhg0_yUT-iLphuRKV6phUGhy_7LYNt64w@mail.gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 800

--===============0403334733161186608==
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

--===============0403334733161186608==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmO2NvbG9yOnJnYigx
MSw4MywxNDgpIj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5IaSBhbGwsPC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCI+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQi
Pk15IHVuZGVyc3RhbmRpbmcgZnJvbSBNUFRDUCBwcm90b2NvbCBpcyB0aGF0LCBpZiBNUFRDUCBo
YXMgb25seSBvbmUgc3ViZmxvdyBpdCBiZWhhdmVzIGFsbW9zdCBzaW1pbGFyIHRvIHJlZ3VsYXIg
VENQIHdpdGggUmVubyDCoGNvbmdlc3Rpb24gY29udHJvbC4gVGhpcyBtZWFucyB0aGF0IGlmIEkg
ZW5hYmxlIE1QVENQIGJ1dCBzZXQgdGhlIMKgY29uZ2VzdGlvbiBjb250cm9sIGZvciBleGFtcGxl
IHRvIEJCUiBvciBEQ1RDUCBjb25maWd1cmluZyB0aGUgcGFyYW1ldGVycyByZXF1aXJlZCBmb3Ig
dGhlIHJlc3BlY3RpdmUgY29uZ2VzdGlvbiBjb250cm9sLCBpdCBzaG91bGQgYmUgYWJsZSB0byBh
Y2hpZXZlIHRoZSBzYW1lIHRocm91Z2hwdXQgYXMgd2hlbiBNUFRDUCBpcyBkaXNhYmxlZCBhbmQg
dGhlIGNvcnJlc3BvbmRpbmcgY29uZ2VzdGlvbiBjb250cm9sIGlzIGNvbmZpZ3VyZWQuIEkgaGF2
ZSB0ZXN0ZWQgTVBUQ1Agd2l0aCDCoG9uZSBzdWJmbG93IMKgdXNpbmcgRENUQ1AgY29uZ2VzdGlv
biBjb250cm9sIGFuZCBvYnRhaW5lZCBhIDEwJSByZWR1Y2VkIHRocm91Z2hwdXQgY29tcGFyZWQg
d2l0aCBNUFRDUCBkaXNhYmxlZC7CoCBXaGljaCBwYXJ0IG9mIHRoZSBNUFRDUCBjb2RlIGRvZXMg
cmVzdWx0IGluIHRoaXMga2luZCBvZiBvdmVyaGVhZD/CoDwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij5SZWdhcmRzLMKg
PC9kaXY+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5
OmFyaWFsLGhlbHZldGljYSxzYW5zLXNlcmlmO2NvbG9yOnJnYigxMSw4MywxNDgpIj48YnI+PC9k
aXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhl
bHZldGljYSxzYW5zLXNlcmlmO2NvbG9yOnJnYigxMSw4MywxNDgpIj48YnI+PC9kaXY+PGRpdiBj
bGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OmFyaWFsLGhlbHZldGljYSxz
YW5zLXNlcmlmO2NvbG9yOnJnYigxMSw4MywxNDgpIj48YnI+PC9kaXY+PGRpdj48ZGl2IGRpcj0i
bHRyIiBjbGFzcz0iZ21haWwtbV8tNDQ0Mzc1MTYyNzE0MDcwMTQ1NmdtYWlsX3NpZ25hdHVyZSI+
PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIj48Zm9udCBmYWNlPSJ0aW1lcyBuZXcg
cm9tYW4sIHNlcmlmIiBjb2xvcj0iIzZmYThkYyI+RGVqZW5lIEJvcnU8L2ZvbnQ+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+PC9kaXY+Cg==

--===============0403334733161186608==--
