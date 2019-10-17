Content-Type: multipart/mixed; boundary="===============1431598193499548425=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/4] mptcp: recvmsg refactor follow-up
Date: Thu, 17 Oct 2019 11:00:35 +0200
Message-ID: <cover.1571258477.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2199

--===============1431598193499548425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series bring in a few fixes for the recent recevmsg refactor.
The patch addressing the reported failures is 2/4, while 1/4 avoids another
issue currently observable with debug enabled (recvmsg() do busy loop on so=
me
corner cases).
Patch 3/4 fixes another possible deadlock issue, currently not reported by
the self-tests
Finally patch 4/4 updates the MIB accounting to the new code.
patches 1-3 should be squashed into "mptcp: Implement MPTCP receive path", =
while
patch 4 should be quashed into "mptcp: increment MIB counters in a few plac=
es".

Notes:
- the last patch is a bit rough, at it abuses an existing MIB instead
of defining a new one, if there is no agreement about that it can be droppe=
d.
- regardless of that, "mptcp: increment MIB counters in a few places" will
 conflict on rebase, due to the changes introduced by the previous patches.
 =


Paolo Abeni (3):
  mptcp: clear data_avail flag if rtx queue is empty
  mptcp: relax map checking
  mptcp: deal better with out-of-sequence mapping
  mptcp: account unsupported DSS mapping

 net/mptcp/subflow.c | 63 +++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

-- =

2.21.0

--===============1431598193499548425==--
