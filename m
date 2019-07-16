Content-Type: multipart/mixed; boundary="===============5847129898851503246=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] about self-tests failures
Date: Tue, 16 Jul 2019 15:21:48 +0200
Message-ID: <590f30b41103f8b1096afafe7865966a215a6506.camel@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1495

--===============5847129898851503246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I spent some time debugging the self-test failures, and I think I got
the root cause.

The tests fails when, due to netem, the 3 way handshake final ack
packet is dropped.

When that happen, the sender never emit the MP_CAPABLE option in later
retrasmission (has the '!subflow->fourth_ack' condition in
mptcp_established_options_mp() is always false).

As a result, on the server side, subflow_syn_recv_sock() always returns
NULL - the session keys check fails - the connection is never
established, and the server's select() never returns.

I'm trying to address the issue forcing MP_CAPABLE option in
retransmitted 3 way handshake ack packets, but I'm facing several
issues, as the TCP stack tries hard to avoid retransmitting 'pure ack',
preferring the following data packet, instead.

We can't attach the MP_CAPABLE opt to the next data segment, or such
segment will lack the require DSS - unless we place both DSS and
MP_CAPABLE in the same pkt.

@Christoph: can you please describe how this issue (3way hs ack drop)
is handled from the mptcp.org implementation?

Thanks,

Paolo


--===============5847129898851503246==--
