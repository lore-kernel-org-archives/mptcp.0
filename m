Content-Type: multipart/mixed; boundary="===============5383679717006258383=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Change IPPROTO_MPTCP
Date: Wed, 12 Jun 2019 10:16:41 -0700
Message-ID: <20190612171643.21861-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 1347

--===============5383679717006258383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of using 99 for IPPROTO_MPTCP (which IANA defines as "any
private encryption scheme"), use 262 (0x100 | IPPROTO_TCP). The MPTCP
self tests continue to run successfully with these changes.

Earlier in development we used 262 for IPPROTO_SUBFLOW as it would get
truncated to 0x06 (IPPROTO_TCP) in the IP header. Now that
IPPROTO_SUBFLOW has been removed in favor of using ULP, 262 is freed up
for MPTCP.

Note that this does change the value of IPPROTO_MAX, and in reviewing
the occurrences of that around the kernel most uses look fine.
net/sunrpc/xprtrdma/svc_rdma_recvfrom.c has one instance of IPPROTO_MAX
where its meaning is not immediately obvious.

Mat Martineau (2):
  squash-to: Define IPPROTO_MPTCP
  squash-to: add basic kselftest program

 include/uapi/linux/in.h                           | 4 ++--
 tools/include/uapi/linux/in.h                     | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- =

2.22.0


--===============5383679717006258383==--
