Content-Type: multipart/mixed; boundary="===============8040941029461656198=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/6] mptcp: add and use wmem accounting for rtx
 queue
Date: Fri, 08 Nov 2019 23:09:47 +0100
Message-ID: <20191108220953.30904-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2449

--===============8040941029461656198==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds wmem accounting and makes mptcp sockets block once
the sndbuf size is reached.  rtx cleanup is changed to wakeup any
blocked mptcp socket once enough wmem is available again.

sndbuf is set to the maximum allowed size of the tcp wmem.
There is no auto-tuning, I think we can add that later on as an
enhancement.

This is an RFC series in order to prevent the patches from getting
applied, I will send a v2 as soon as the open questions are sorted
out.  Everthing continues to work for me.

I've tested these patches with an 4k-sized sndbuf, which results
in frequent wmem blocks and mptcp connection recovers once the acks
come in.

1.  (see patch 5): add a new work queue or re-use existing one?
2.  Should all patches get squashed or should there be a
    "add wmem accouting" patch?  A mix of both?

2, 3 and 4 would be squash candidates for example even if we add
a extra "wmem patch".

I will send the next iteration of the scheduler patches after the above
is sorted out.
The scheduler patches have no major changes aside from addressing a
comment from Paolo.

Meanwhile I am working on removal of __tcp_poll and on make the mptcp
socket conn list store tcp_sk structs rather than require a 'struct socket'.

Florian Westphal (6):
      mptcp: add wmem_queued accounting
      mptcp: allow partial cleaning of rtx head dfrag
      subflow: store known available bytes in subflow
      options: ack pending sequence
      mptcp: add ack work queue
      sendmsg: block until mptcp sk is writeable

 net/mptcp/options.c  | 13 ++++++--
 net/mptcp/protocol.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++-=
----
 net/mptcp/protocol.h |  5 +--
 net/mptcp/subflow.c  | 18 ++++++++---
 4 files changed, 105 insertions(+), 17 deletions(-)


--===============8040941029461656198==--
