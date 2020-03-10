Content-Type: multipart/mixed; boundary="===============4469379171055036781=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 0/5] Add support for v1 of ADD_ADDR option
Date: Tue, 10 Mar 2020 15:33:27 -0700
Message-ID: <20200310223332.3845-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3905

--===============4469379171055036781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Support parsing and writing the new option format, with hmac generation
and validation.

Support for echoing ADD_ADDR still to come.

v2: check msg len in mptcp_crypto_hmac_sha().
    remove obsolete casts
v3: Rebase and split for squashing, patches ready to be applied.

Peter Krystad (5):
  mptcp: v1 ADD_ADDR changes: use subflow_generate_hmac()
  mptcp: v1 ADD_ADDR changes: add subflow_generate_hmac()
  mptcp: v1 ADD_ADDR changes: add_addr_hmac_valid
  mptcp: Add ADD_ADDR handling
  mptcp: Re-factor mptcp_crypto_hmac_sha()

 include/linux/tcp.h  |  12 +++++
 include/net/mptcp.h  |   7 +++
 net/mptcp/crypto.c   |  17 +++---
 net/mptcp/options.c  | 121 ++++++++++++++++++++++++++++++++++++++++---
 net/mptcp/protocol.h |  20 ++++++-
 5 files changed, 161 insertions(+), 16 deletions(-)

-- =

2.17.2

--===============4469379171055036781==--
