Content-Type: multipart/mixed; boundary="===============6691296541349053098=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 mptcp-next 0/2] mptcp: adjust tcp rcvbuf size
Date: Mon, 25 May 2020 14:02:41 +0200
Message-ID: <20200525120243.4160-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4483

--===============6691296541349053098==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a v2 of the patch I sent to netdev previously.
No change.  The second patch is new: It makes sure we track/use the
largest rcvbuf size of a subflow.

Futhermore, msk rcvbuf tracking is only done from the recvmsg path.
i.e., if userspace never calls recvmsg, the msk socket rcvbuffer won't
be adjusted.

This still provides the same benefits as 1/2 while preventing unbounded
growth to tcp_rmem[2].

--===============6691296541349053098==--
