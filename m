Content-Type: multipart/mixed; boundary="===============8473813129879774638=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 00/13] mptcp: multiple xmit substreams support
Date: Wed, 05 Aug 2020 19:56:59 +0200
Message-ID: <cover.1596649926.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 5479

--===============8473813129879774638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This covers the feedback from Florian on the RFC series, please see
the individual patches changelog for the details.

The only exception is: I'm retaining the MPTCP_SEND_SPACE bit, which looks
required as per ML discussion.

The MPTCP window code is now more conservative and I do not see out of wind=
ow
errors.

Some self-tests cases are still failing - do not reach the expected aggrega=
ted
bwidth - but I've not investigated yet. multiple stream self-tests are not
enabled yet.

It would be great if we could starting merging this in the export branch,
and improve incrementally.

Paolo Abeni (13):
  mptcp: rethink 'is writable' conditional
  mptcp: set data_ready status bit in subflow_check_data_avail()
  mptcp: trigger msk processing even for OoO data
  mptcp: basic sndbuf autotuning
  mptcp: introduce and use mptcp_try_coalesce()
  mptcp: move ooo skbs into msk out of order queue.
  mptcp: cleanup mptcp_subflow_discard_data()
  mptcp: add OoO related mibs
  mptcp: move address attribute into mptcp_addr_info
  mptcp: allow creating non-backup subflows
  mptcp: allow picking different xmit subflows
  mptcp: simult flow self-tests
  mptcp: cache subflow write status in subflow ctx

 net/mptcp/mib.c                               |   5 +
 net/mptcp/mib.h                               |   5 +
 net/mptcp/pm_netlink.c                        |  38 +-
 net/mptcp/protocol.c                          | 518 ++++++++++++++----
 net/mptcp/protocol.h                          |  22 +-
 net/mptcp/subflow.c                           |  93 ++--
 .../selftests/net/mptcp/simult_flows.sh       | 290 ++++++++++
 7 files changed, 791 insertions(+), 180 deletions(-)
 create mode 100755 tools/testing/selftests/net/mptcp/simult_flows.sh

-- =

2.26.2

--===============8473813129879774638==--
