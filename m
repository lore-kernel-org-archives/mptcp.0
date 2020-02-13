Content-Type: multipart/mixed; boundary="===============3492561270070612465=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 0/5] mptcp: perform mptcp ack update from work queue
Date: Thu, 13 Feb 2020 11:27:37 +0100
Message-ID: <20200213102742.18937-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 3643

--===============3492561270070612465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This series adds support for async draining of subflow rx queue.

This allows mptcp to send up-to-data mptcp-level ack sequence
even if userspace doesn't call recv for some time.

Originally I wanted to keep skbs accounted to the subflow socket,
so as to not open the tcp receive window.
Problem with that is that we can trip over debug asserts via tcp_done()
path, as in that case it might observe non-zero forward alloc counter
to the tcp sk.

Therefore, this series orphans the skb instead and then charges it
vs. the mptcp socket.

Note that the 2nd patch is not a must-have, if gets rejected patch 4
needs to be reworked to clone the skb.  In such case we could consider
using a delayed work queue to give the mptcp-program a head start to
just drain the ssk directly.

See individual patches for more details, and as usual:
Comments welcome.


--===============3492561270070612465==--
