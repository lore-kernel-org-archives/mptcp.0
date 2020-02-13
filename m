Content-Type: multipart/mixed; boundary="===============5483178592860329568=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net v2 0/3] MPTCP fallback fixes
Date: Thu, 13 Feb 2020 12:38:33 -0800
Message-ID: <20200213203836.225812-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 3653

--===============5483178592860329568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a follow-up to the "Protect subflow socket options before
connection completes" patch I sent last week. It has two more patches to
address race conditions where __mptcp_tcp_fallback() is used before
calling TCP functions on a fallback subflow.

Self tests pass.

I plan to send this to netdev tomorrow, but a pre-review on this list
would be great!


Mat Martineau (3):
  mptcp: Keep TCP fallback subflow valid after lookup
  mptcp: Protect subflow socket options before connection completes
  mptcp: Use TCP sendmsg/recvmsg for fallback subflows

 net/mptcp/protocol.c | 78 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 30 deletions(-)


base-commit: b9287f2ac321ecac56eb51e6231f6579683dcdae
-- =

2.25.0

--===============5483178592860329568==--
