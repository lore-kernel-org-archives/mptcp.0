Content-Type: multipart/mixed; boundary="===============6124184675826970220=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next 0/4] mptcp: re-enable snd buf autotune
Date: Mon, 11 Jan 2021 11:05:38 +0100
Message-ID: <cover.1610359105.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7306

--===============6124184675826970220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WRT to the previous iteration, this adds the first patch, which allow
cleaning-up the existing code and the sndbuf autotuning code more than
a bit.

Relevant bits from the previous cover letter:

There are still some sporadic self-test failures for assimetric links.
Looks like they are caused by retransmissions/receiver dropping packets
due to MPTCP level OoO check.

I'll try to address that asap, but I still consider this series for
inclusion, so that it can stage a bit in the export branch.

Note: the last patch re-introduces the workqueue usage for the datapath (ye=
s,
it makes me feel sick, sad and tired :(. I was unable to avoid it.

There is weird and convoluted schema to possibly avoiding (again) the
workqueue usage. If you don't feel too scaring using a fake NAPI instance
to delegate actions to other mptcp subflows, I can try to cook that...

Paolo Abeni (4):
  mptcp: always graft subflow socket to parent.
  mptcp: re-enable sndbuf autotune
  mptcp: do not queue excessive data on subflows.
  mptcp: schedule work for better snd subflow selection

 net/mptcp/protocol.c | 108 ++++++++++++++++++-------------------------
 net/mptcp/protocol.h |  21 +++++++++
 net/mptcp/subflow.c  |  13 +++++-
 3 files changed, 77 insertions(+), 65 deletions(-)

-- =

2.26.2

--===============6124184675826970220==--
