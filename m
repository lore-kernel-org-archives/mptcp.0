Content-Type: multipart/mixed; boundary="===============7488300842959584986=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PRE-RFC 0/6] mptcp: implement retransmit infrastructure
Date: Fri, 16 Aug 2019 18:47:58 +0200
Message-ID: <cover.1565970525.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1645

--===============7488300842959584986==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As suggested by the subj prefix, this is a very early draft, mainly to
discuss design decisions and/or architectural issues. This is only
compile-tested so far.

In the current status:
- updates the MPTCP unacked sequence number (patches 1-3) on sendmsg()
  - also try to cope with 32 bit sequence number
- queue data (page frags) in MPTCP retransmission queue (patch 4)
- cleanup acked data from retransmission queue and schedule a timeout to
   update MPTCP unacked sequence number (patch 5)
- do memory accounting for the MPTCP rtx queue (patch 6)

TODO:
- do retransmissions in timer handler, with some heuristic - e.g. last seq_=
una
   update ts older than timeout*2 [1]

Open points:
- what about the current seq_una update schema (patch 2-3)? too much comple=
x?
   too much loose? too much generic?
- is it too early to plug any heuristic inside the code? (as done in patch =
3)
- do we really need a timer to update the unacked sequence?
  - we can avoid it with an additional atomic operation in
    mptcp_incoming_options() - either using an atomic type for 'snd_una' or
    use an additional spin lock to protect it (and possibly other fields)[2]
  - still we will likely need a timer to detect that a subflow has become
    unusable e.g. due to link down event on the peer side. Should we rely on
    explicit MPTCP notification only (e.g. DEL_ADDR sub-option)? =

- retransmission code needs to run in process context, as we will need to
  acquire msk socket lock and ssh socket lock in order.
  - As MPTCP-level retransmission should be considerably less frequent than
    TCP-level retransmission-timeout, we could use/schedule a workqueue for
    that.

Any kind of feedback more than welcome!

[1] After a better look at the current code, I see no issues in allocating =
the
sk_buff hdr at retransmission time - ensuring we do that in unblocking wait,
with GFP_ATOMIC, e.g. as tls_device_write_space() currently does.

[2] I choosed the current design to avoid such extra atomic operation: it =

will happen on a contented cache-line, while processing each MPTCP ack.

Paolo Abeni (6):
  mptcp: move before/after64 into the header file
  mptcp: update per subflow unacked sequence on pkt reception
  mptcp: update msk unacked sequence in sendmsg()
  mptcp: queue data for mptcp level retransmission
  mptcp: use retransmission timer to update msk una
  mptcp: implement memory accounting for mptcp rtx queue

 net/mptcp/options.c  |  31 ++++--
 net/mptcp/protocol.c | 240 +++++++++++++++++++++++++++++++++++++++++--
 net/mptcp/protocol.h |  30 ++++++
 3 files changed, 286 insertions(+), 15 deletions(-)

-- =

2.20.1


--===============7488300842959584986==--
