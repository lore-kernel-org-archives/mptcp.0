Content-Type: multipart/mixed; boundary="===============6322075924278258565=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH/RFC 0/7] improve subflow join handling
Date: Mon, 25 Nov 2019 03:15:01 +0100
Message-ID: <20191125021508.29153-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 2672

--===============6322075924278258565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This set aims to improve handling of multiple subflows.
There are multiple remaining problems, see below, but I wanted to send what
I have now rather than keep this back.

The first 3 patches are fixes to handle refcount leaks found while working
on this, I've added the commit name of where they could be squashed to.

The remaining part of this work is to make the msk->conn_list contain
tcp_sock structs without an outer 'struct socket'.

The problem is that for incoming join requests (which are not subject
to accept/request socket queue), there is no 'struct socket', i.e.
sk->sk_socket is NULL.

As tcp stack will assume that such tcp sk is already detached from
userspace, SOCK_NOSPACE wakeups do not work for them.

The solution here (suggested by Paolo) is to have sk->sk_socket refer
to the mptcp parent socket structure.  This assignment is done by
a private function similar to sock_graft().

For incoming connects, tcp-level connectivity works, i.e. mptcp-next can
accept a few subflows from the peer and on exit of the test program
all resources are cleaned up correctly.

MPTCP-Level connectivity will probably not work, as nothing sets up
ssn_offset for joins (both incoming or outgoing).

mptcp.org kernel will not consider the joins as established, as the
"4th Ack" is missing.
A simple "tcp_send_ack" is enough, but there are two problems with this:
1. It can be lost
2. Given we are not expecting to receive any data on such flows this
   doesn't seem to be a problem.

During testing I saw that sometimes mptcp.org kernel will emit further
join requests to mptcp-next but those trigger no response (and those
packets do not even show up in perfs network drop monitor, sigh).

For outgoing connects, there is one remaining memory leak that I have
not located so far.

--===============6322075924278258565==--
