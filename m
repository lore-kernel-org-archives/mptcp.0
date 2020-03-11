Content-Type: multipart/mixed; boundary="===============6547911586735578414=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v4 0/5] Add support for v1 of ADD_ADDR option
Date: Wed, 11 Mar 2020 10:25:55 -0700
Message-ID: <20200311172600.4185-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3918

--===============6547911586735578414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support parsing and writing the new option format, with hmac generation
and validation.

Support for echoing ADD_ADDR still to come.

v2: check msg len in mptcp_crypto_hmac_sha().
    remove obsolete casts
v3: Rebase and split for squashing, patches ready to be applied.
v4: Get the first two patches of the set right

Peter Krystad (5):
  mptcp: Re-factor mptcp_crypto_hmac_sha()
  mptcp: v1 ADD_ADDR changes: options and parsing
  mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
  mptcp: v1 ADD_ADDR changes: add subflow_generate_hmac()
  mptcp: v1 ADD_ADDR changes: use subflow_generate_hmac()

 include/linux/tcp.h  |  19 ++++---
 include/net/mptcp.h  |   2 +
 net/mptcp/crypto.c   |  17 ++++--
 net/mptcp/options.c  | 132 +++++++++++++++++++++++++++++++++----------
 net/mptcp/protocol.h |  19 +++++--
 5 files changed, 140 insertions(+), 49 deletions(-)

-- =

2.17.2

--===============6547911586735578414==--
