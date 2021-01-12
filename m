Content-Type: multipart/mixed; boundary="===============3738254792639316193=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-next 0/4] mptcp: re-enable snd buf autotune
Date: Tue, 12 Jan 2021 12:09:56 +0100
Message-ID: <cover.1610449705.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7322

--===============3738254792639316193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WRT to the previous iteration, this clean-up patch 2/4 dropping the
left over 'use_backup' field, as suggested by Mat. No other change =


Relevant bits from the previous cover letter:

There are still some sporadic self-test failures for assimetric links.
Looks like they are caused by retransmissions/receiver dropping packets
due to MPTCP level OoO check.

I'll try to address that asap, but I still consider this series for
inclusion, so that it can stage a bit in the export branch.

Note: the last patch re-introduces the workqueue usage for the datapath (ye=
s,
it makes me feel sick, sad and tired :(. I was unable to avoid it.


Paolo Abeni (4):
  mptcp: always graft subflow socket to parent.
  mptcp: re-enable sndbuf autotune
  mptcp: do not queue excessive data on subflows.
  mptcp: schedule work for better snd subflow selection

 net/mptcp/protocol.c | 104 +++++++++++++++++--------------------------
 net/mptcp/protocol.h |  20 +++++++++
 net/mptcp/subflow.c  |  13 +++++-
 3 files changed, 73 insertions(+), 64 deletions(-)

-- =

2.26.2

--===============3738254792639316193==--
