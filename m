Content-Type: multipart/mixed; boundary="===============3306436807857679579=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] packetdrill first breath on MPTCP v1
Date: Fri, 10 Jan 2020 11:13:39 +0100
Message-ID: <ba7ac027b8304885f85a101f3378dc2b055a9663.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3342

--===============3306436807857679579==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello,

as mentioned in yesterday's public meeting, I'm hosting on my github [1] a
rebase of Cristoph's packetdrill work [2] that uses the latest code
released by Google.

This tree contains some small modifications to support IPPROTO_MPTCP
sockets [3], and to support v1 handshake [4], trying to preserve
testability of v0 protocol. In the next days, I will try to add the logic
that uses SHA256 in place of SHA1 when protocol version is 1, so that also
DSS option can be validated as well.

Any feedback, any suggestion, any issue, all are welcome ;)

-- =

davide

*** notes ***

1) smoketests of the mp_capable handshake are available in the
'gtests/net/mptcp' folder. I observe systematic failures when IPv4-mapped-
v6 tests are ran: =


FAIL [/root/packetdrill-new/gtests/net/mptcp/mp_capable/v1_mp_capable_bind_=
no_cs.pkt (ipv4-mapped-v6)]                  =

stdout:                                                                    =
                                                                           =
        =

stderr:                                                                    =
                                                                           =
        =

v1_mp_capable_bind_no_cs.pkt:10: error handling packet: live packet field i=
pv4_total_length: expected: 64 (0x40) vs actual: 52 (0x34)
script packet:  0.000030 S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscal=
e 8,mp_capable v1 flags: |H| sender_key: 0>
actual packet: -0.000001 S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK=
,nop,wscale 8>

it appears that the fallback to TCP happens when the very first packet is
received by the kernel. Moreover, Paolo reports that a systematic KASAN
splat is visible when IPv4 mapped-v6 tests are ran. I didn't check this
personally, but I trust him enough ;)

2) I (intentionally) didn't integrate yet the support for mp_join. Before
doing this, I think we should agree with the packetdrill "official"
community on a way to test multiple sockets simultaneously, even
"interleaving" the 3WHS (that, AFAIU, is not possible with the current
code). =


*** links ****

[1] https://github.com/dcaratti/packetdrill
[2] https://github.com/cpaasch/packetdrill_mptcp
[3] https://github.com/dcaratti/packetdrill/tree/mptcp-net-next
[4] https://github.com/dcaratti/packetdrill/commits/mpcapable_v1

=20

--===============3306436807857679579==--
