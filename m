Content-Type: multipart/mixed; boundary="===============3596548155523843972=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/8] mptcp: non backup subflows pre-reqs
Date: Thu, 23 Jul 2020 13:02:28 +0200
Message-ID: <cover.1595431326.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5231

--===============3596548155523843972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series contains a bunch of MPTCP improvements loosely related to
concurrent subflows xmit usage, currently under development.

The first 3 patches are actually bugfixes for issues that will become appar=
ent
as soon as we will enable the above feature.

The later patches improve the handling of incoming additional subflows,
improving significantly the performances in stress tests based on a high new
connection rate.

Paolo Abeni (8):
  subflow: always init 'rel_write_seq'
  mptcp: avoid data corruption on reinsert
  mptcp: mark as fallback even early ones
  mptcp: explicitly track the fully established status
  mptcp: cleanup subflow_finish_connect()
  subflow: explicitly check for plain tcp rsk
  subflow: use rsk_ops->send_reset()
  subflow: introduce and use mptcp_can_accept_new_subflow()

 net/mptcp/options.c  |  5 +--
 net/mptcp/protocol.c | 23 ++++++++---
 net/mptcp/protocol.h |  8 ++++
 net/mptcp/subflow.c  | 91 ++++++++++++++++++++++++++------------------
 4 files changed, 81 insertions(+), 46 deletions(-)

-- =

2.26.2

--===============3596548155523843972==--
