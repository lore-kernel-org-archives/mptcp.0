Content-Type: multipart/mixed; boundary="===============1156999131285422123=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] question on MP_CAPABLE v1 handshake
Date: Tue, 05 Nov 2019 13:18:33 +0100
Message-ID: <22911f4932b5cfcfe75a4a3f93af2305c46434c9.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2390

--===============1156999131285422123==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi,

while testing the v1 MP_CAPABLE handshake, I stumbled upon the
following scenario:

syn + MP_CAPABLE ->

	<- syn + ack + MP_CAPABLE(sndr key)

ack + MP_CAPABLE(sndr key, rcvr key)

	<- ack + DSS(map,data_ack)

At this point, is the client still supposed to send MP_CAPABLE(sndr
key, rcvr key, data_len)? or should it send a plain DSS? Since it
received a DSS from the peer, the client knows that the MP_CAPABLE
options has been successfully received, but reading =


https://datatracker.ietf.org/doc/draft-ietf-mptcp-rfc6824bis/?include_text=
=3D1

from section 3.1.:

"""
   If A does not
   immediately have data to send, it MUST include the MP_CAPABLE on the
   third ACK, but without the additional data parameters.  When A does
   have data to send, it must repeat the sending of the MP_CAPABLE
   option from the third ACK, with additional data parameters.
"""

it looks like the client should always use MP_CAPABLE+data for the
first data packet, is that right?

Thanks,

Paolo

--===============1156999131285422123==--
