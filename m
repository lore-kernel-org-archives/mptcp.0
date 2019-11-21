Content-Type: multipart/mixed; boundary="===============6914999295792848733=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC PATCH 0/3] sendmsg: fix pending issues.
Date: Thu, 21 Nov 2019 11:30:57 +0100
Message-ID: <cover.1574331014.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 2636

--===============6914999295792848733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series addresses the known pending issue in mptcp_sendmsg,
specifically:

* the crash repored by matt (patch 3/3)
* the possible data corruption on ext allocation failure - the "TODO"" in
  sendmsg_frag (patches 1,2/3)

uunfortunately none of the above is actually tested, since I can't
reproduce the issues - still the problems look real.

This is not squashed yet, as it will conflict with most patches, I'm just
trying to collect feedback.

Open points:

The patch 2/3 introduces a per socket cache of a single skb_ext. As per
recent upstream changes related to TCP rx/tx skb cache, that is debatable,
could have subtle performance and memory usage implications.
We could avoid such cache allways allocating the extension for each
sendmsg_frag() call, and than free it if unused. Both options looks
sub-optiomal to me do you have any preference? - I do have some for the
selected impl ;)

The new API exposed by patch 1/3 is open to misusage. e.g. the caller could
allocate a skb_ext, set arbitrary ext->offset[id] values and than call
__skb_ext_add(). That will lead to memory leak or GPF. I did no try to
address the issue, the '__' prefix should guide the users to extra care.
Can we do any better?

(this is a pre-existing topic) the sk_stream_wait_memory() calls in
sk_stream_wait_memory(), waits on the subflow. Should we wait on the mptcp
socket instead? Otherwise should we release the mptcp socket lock, before s=
uch
call?

Paolo Abeni (3):
  skb: add helpers to allocate ext independently from sk_buff
  mptcp: avoid data stream corruption on allocation failure.
  mptcp: properly detect skb collapsing

 include/linux/skbuff.h |  3 ++
 net/core/skbuff.c      | 16 ++++++++-
 net/mptcp/protocol.c   | 79 ++++++++++++++++++++++++++----------------
 net/mptcp/protocol.h   |  1 +
 4 files changed, 68 insertions(+), 31 deletions(-)

-- =

2.21.0

--===============6914999295792848733==--
