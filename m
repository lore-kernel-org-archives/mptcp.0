Content-Type: multipart/mixed; boundary="===============5027165406449036950=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/6] mptcp: just another complete datapath refactor
Date: Fri, 13 Nov 2020 17:27:30 +0100
Message-ID: <cover.1605283958.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 6715

--===============5027165406449036950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This itration addresses Mat's feedback and bring many bugfixes,
all noted in the individual patches.

Now it survives a few self-test iterations, and I would consider
this for merging.

Note: depend on "mptcp: refine MPTCP-level ack scheduling"

Paolo Abeni (6):
  mptcp: separate accouting for wmem forward alloc mem
  mptcp: protect the rx path with the msk socket spinlock
  mptcp: allocate TX skbs in msk context.
  mptcp: avoid a few atomic ops in the rx path
  mptcp: simplify mptcp_nospace
  mptcp: use mptcp backlog.

 net/mptcp/mptcp_diag.c |   2 +-
 net/mptcp/options.c    |  47 +--
 net/mptcp/protocol.c   | 659 +++++++++++++++++++++++++++++------------
 net/mptcp/protocol.h   |  23 +-
 net/mptcp/subflow.c    |  31 +-
 5 files changed, 534 insertions(+), 228 deletions(-)

-- =

2.26.2

--===============5027165406449036950==--
