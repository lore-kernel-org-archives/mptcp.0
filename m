Content-Type: multipart/mixed; boundary="===============5917822781124620753=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 0/2] Add support for v1 of ADD_ADDR option
Date: Mon, 24 Feb 2020 16:52:53 -0800
Message-ID: <20200225005255.14943-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3766

--===============5917822781124620753==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support parsing and writing the new option format, with hmac generation
and validation.

Support for echoing ADD_ADDR still to come.

v2: check msg len in mptcp_crypto_hmac_sha().
    remove obsolete casts

Peter Krystad (2):
  mptcp: Re-factor mptcp_crypto_hmac_sha()
  mptcp: Make v1 changes for ADD_ADDR and RM_ADDR options

 include/linux/tcp.h  |  24 +++---
 include/net/mptcp.h  |   2 +
 net/mptcp/crypto.c   |  17 ++--
 net/mptcp/options.c  | 180 ++++++++++++++++++++++++++++++++++---------
 net/mptcp/protocol.h |  20 +++--
 net/mptcp/subflow.c  |  19 ++++-
 6 files changed, 199 insertions(+), 63 deletions(-)

-- =

2.17.2

--===============5917822781124620753==--
