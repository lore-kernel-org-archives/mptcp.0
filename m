Content-Type: multipart/mixed; boundary="===============4198894034692086419=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/9] mptcp: cope better with mp_join storm
Date: Fri, 10 Jul 2020 19:22:09 +0200
Message-ID: <cover.1594401165.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4977

--===============4198894034692086419==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a rebase of the RFC, dropping old 5/5 and including a few somewhat
related bugfixes - all targeting net-next because the fixed commit is only
there or the buggy behavior can be triggered only enabling non backup subfl=
ows

Paolo Abeni (9):
  subflow: always init 'rel_write_seq'
  mptcp: avoid data corruption on reinsert
  mptcp: mark as fallback even early ones
  mptcp: zero token hash at creation time.
  mptcp: make msk established at remote key reception time
  mptcp: cleanup subflow_finish_connect()
  subflow: explicitly check for plain tcp rsk
  subflow: use rsk_ops->send_reset()
  subflow: introduce and use mptcp_can_accept_new_subflow()

 net/mptcp/options.c  |  4 +-
 net/mptcp/protocol.c | 20 +++++++---
 net/mptcp/protocol.h |  2 +
 net/mptcp/subflow.c  | 87 +++++++++++++++++++++++++-------------------
 net/mptcp/token.c    |  2 +-
 5 files changed, 69 insertions(+), 46 deletions(-)

-- =

2.26.2

--===============4198894034692086419==--
