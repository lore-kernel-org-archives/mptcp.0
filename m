Content-Type: multipart/mixed; boundary="===============7666847097041279624=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v1 0/5] squash and cleanup
Date: Fri, 20 Mar 2020 19:34:38 +0100
Message-ID: <cover.1584728931.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4026

--===============7666847097041279624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series contains a "squashable" version of:

subflow: place further subflows on new 'join_list'

and a bunch of minor cleanup (unneeded check after not so recent net-next
changes)

Rebased tree available at:

https://github.com/pabeni/mptcp/tree/mptcp_net-next_part3_14

this supersede the squashed branch posted previously.

Self-tests loop running. Will update here with results.

 options.c  |   11 +++--------
 protocol.c |   31 ++++++++++++++++++++++++++++++-
 protocol.h |    2 ++
 subflow.c  |    5 ++++-
 4 files changed, 39 insertions(+), 10 deletions(-)

--===============7666847097041279624==--
