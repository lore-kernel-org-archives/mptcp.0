Content-Type: multipart/mixed; boundary="===============0242016588988331675=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] mptcp_poll should not block on each
 subflow
Date: Tue, 01 Oct 2019 13:57:40 +0200
Message-ID: <20191001115743.2807-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1971

--===============0242016588988331675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a (very simplified) version of the mptcp poll refactoring.

I've removed all of the code from mptcp_should_wake_parent(), the reason
is that Paolo is working on moving more code from mptcp_recvmsg to the
subflow data_ready callback so we can weed out duplicate data before
waking up userspace.

So this only contains the new 'subflow_write_space' callback to notify
mptcp layer when a subflow isn't blocked anymore on write-side, plus the
__tcp_poll split so we can call the tcp layer from mptcp without placing
the subflow socket on a wait list.

Comments welcome.


--===============0242016588988331675==--
