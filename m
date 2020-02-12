Content-Type: multipart/mixed; boundary="===============4583302337241041430=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Wed, 12 Feb 2020 11:33:33 +0100
Message-ID: <c1706025c934a0ca3d6b5e2877759e93b00b7c96.camel@redhat.com>
In-Reply-To: 2feb5b6dd24cafd2cbd347b5029f7038220c8ea2.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3626

--===============4583302337241041430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-12 at 10:39 +0100, Davide Caratti wrote:
> On Tue, 2020-02-11 at 18:42 +0100, Paolo Abeni wrote:
> > BTW I'm wondering if we are behaving correctly WRT TCP fallback for
> > passive sockets (msk->subflow =3D NULL): __mptcp_tcp_fallback() current=
ly
> > returns NULL, even if the subflow has fallback to TCP. I think/fear
> > recvmsg should hang in that scenario?!? (as the server still does a
> > full bloat mptcp_recvmsg(), while the client does not provide the DSS
> > options).

from what I see, in the above case the server is not doing fallback to TCP
(see attachment). As I send to the server a packet without the DSS option,
the kernel answers with a TCP RST, that has a DSS option with DACK number
equal to the IDSN (that means probably that received data have been
discarded):

[root(a)f31 packetdrill]# cat ../mptcp/dss/fallback.pkt
`../common/defaults.sh`

+0    socket(..., SOCK_STREAM, IPPROTO_MPTCP) =3D 3
+0    setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
+0    bind(3, ..., ...) =3D 0
+0    listen(3, 1) =3D 0
+0      < S 0:0(0) win 32792 <mss 1460,sackOK,nop,nop,nop,wscale 7,mpcapabl=
e v1 flags[flag_h] nokey>
+0      > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8,mpcapable v=
1 flags[flag_h] key[skey] >
+0.01   < . 1:1(0) ack 1 win 257 <mpcapable v1 flags[flag_h] key[ckey=3D2,s=
key]>
+0    accept(3, ..., ...) =3D 4
+0      < . 1:101(100) ack 1 win 257
+0      > . 1:1(0) ack 101
+0    write(4, ..., 1000) =3D 1000
+0      > P. 1:1001(1000) ack 101
+0    close(4) =3D 0

[root(a)f31 packetdrill]# ./packetdrill -vvv ../mptcp/dss/fallback.pkt =

socket syscall: 1581502995.628410
setsockopt syscall: 1581502995.628771
bind syscall: 1581502995.629067
listen syscall: 1581502995.629135
inbound injected packet:  0.001306 S 0:0(0) win 32792 <mss 1460,sackOK,nop,=
nop,nop,wscale 7,mp_capable v1 flags: |H| >
outbound sniffed packet:  0.001768 S. 612568362:612568362(0) ack 1 win 6553=
5 <mss 1460,nop,nop,sackOK,nop,wscale 8,mp_capable v1 flags: |H| sender_key=
: 16291872690117590433>
inbound injected packet:  0.013829 . 1:1(0) ack 612568363 win 257 <mp_capab=
le v1 flags: |H| sender_key: 2 receiver_key: 16291872690117590433>
accept syscall: 1581502995.642149
inbound injected packet:  0.014330 . 1:101(100) ack 612568363 win 257 =

outbound sniffed packet:  0.014460 R. 612568363:612568363(0) ack 101 win 25=
6 <dss dack8 13263177308786788773 flags: Aa>
../mptcp/dss/fallback.pkt:13: error handling packet: live packet field ipv4=
_total_length: expected: 40 (0x28) vs actual: 52 (0x34)
script packet:  0.014478 . 1:1(0) ack 101 =

actual packet:  0.014460 R. 1:1(0) ack 101 win 256 <dss dack8 1326317730878=
6788773 flags: Aa>
[root(a)f31 packetdrill]# =


-- =

davide
=20

--===============4583302337241041430==
Content-Type: application/vnd.tcpdump.pcap
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="mptcp.pcap"

1MOyoQIABAAAAAAAAAAAAAAABABxAAAAHNNDXpRqAgBIAAAASAAAAAAA//4AAAAAAAAAAAAACABF
AAA4AAAAAP8GMvfAAAIBwKgGH67DH5AAAAAAAAAAAJACgBho0wAAAgQFtAQCAQEBAwMHHgQBARzT
Q17xawIAUAAAAFAAAAAABP/+AAAAAAAAAAAAAAgARQAAQAAAQABABrHvwKgGH8AAAgEfkK7DCeHE
UAAAAAGwEv//iPsAAAIEBbQBAQQCAQMDCB4MAQElKZMWpJyUXxzTQ17DmQIATAAAAEwAAAAAAP/+
AAAAAAAAAAAAAAgARQAAPAAAAAD/BjLzwAACAcCoBh+uwx+QAAAAAQnhxFGgEAEBJx4AAB4UAQEC
AAAAAAAAACUpkxaknJRfHNNDXgGdAgCcAAAAnAAAAAAA//4AAAAAAAAAAAAACABFAACMAAAAAP8G
MqPAAAIBwKgGH67DH5AAAAABCeHEUVAQAOGJPwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAABzTQ15anQIARAAAAEQAAAAABP/+AAAAAAAAAAAAAAgARQAANKzhQABA
BgUawKgGH8AAAgEfkK7DCeHEUQAAAGWAFAEAiO8AAB4MIAO4EEV9s0IJpQ==
--===============4583302337241041430==--
