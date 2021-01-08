Content-Type: multipart/mixed; boundary="===============8223984650582609513=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] mptcp: re-enable snd buf autotune
Date: Fri, 08 Jan 2021 12:50:00 +0100
Message-ID: <cover.1610106588.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 7284

--===============8223984650582609513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was lost in a recent refactor.

With great power come great responsability, so we need a more
accurate packet scheduler decision, or b/w usage for assimetric links
will be sub-optimal.

Patches 2 && 3 are the minimal changes I was able to cook somehow
addressing the above =


There are still some sporadic self-test failures for assimetric links.
Looks like they are caused by retransmissions/receiver dropping packets
due to MPTCP level OoO check.

I'll try to address that asap, but I still consider this series for
inclusion, so that it can stage a bit in the export branch.

Note: patch 3 re-introduces the workqueue usage for the datapath (yes,
it makes me feel sick, sad and tired :(. I was unable to avoid it.

There is weird and convoluted schema to possibly avoiding (again) the
workqueue usage. If you don't feel too scaring using a fake NAPI instance
to delegate actions to other mptcp subflows, I can try to cook that... =


Paolo Abeni (3):
  mptcp: re-enable sndbuf autotune
  mptcp: do not queue excessive data on subflows.
  mptcp: schedule work for better snd subflow selection

 net/mptcp/protocol.c | 85 +++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h | 20 +++++++++++
 net/mptcp/subflow.c  | 10 +++++-
 3 files changed, 77 insertions(+), 38 deletions(-)

-- =

2.26.2

--===============8223984650582609513==--
