Content-Type: multipart/mixed; boundary="===============7405698368919648814=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC 0/6] mptcp_poll rework preview
Date: Mon, 09 Sep 2019 17:53:12 +0200
Message-ID: <20190909155317.31119-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1799

--===============7405698368919648814==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch series is in need of a bit more work, f.e. there is too much
copypastry in patch 3.

However, it is functional as-is so I am sharing it to get earlier reviews.

Problem with current mptcp_poll() is that we can't block the task on each
subflow: subflow we're polling on might be idle while another one has data
ready for processing.

 include/net/tcp.h    |    1 =

 net/ipv4/tcp.c       |   12 +++-
 net/mptcp/protocol.c |  131 ++++++++++++++++++++++++++++++++++++++++++++++=
-----
 net/mptcp/protocol.h |    1 =

 net/mptcp/subflow.c  |   24 +++++++--
 5 files changed, 150 insertions(+), 19 deletions(-)



--===============7405698368919648814==--
