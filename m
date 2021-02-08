Content-Type: multipart/mixed; boundary="===============5247823258493963995=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 0/3] SYNRX: MPTCP -> MPTCP: expect x, got y
Date: Mon, 08 Feb 2021 18:45:45 +0100
Message-ID: <20210208174548.493800-1-matthieu.baerts@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 7683

--===============5247823258493963995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While working on issue #148, I also found a small typo: SYN info were
printed instead of ACK ones, see patch 1/3.

Then I put everything on one line and remove duplicated code, see patch
2/3.

The last patch marks the test as failed if we found less MPC SYN/3rd
ACK than expected. This will close:

  https://github.com/multipath-tcp/mptcp_net-next/issues/148

But at the end, just some small Bash modifications, nothing important
;-)

Matthieu Baerts (3):
  selftests: mptcp: fix ACKRX debug message
  selftests: mptcp: display warnings on one line
  selftests: mptcp: fail if not enough SYN/3rd ACK

 .../selftests/net/mptcp/mptcp_connect.sh      | 80 +++++++++++++------
 1 file changed, 54 insertions(+), 26 deletions(-)

-- =

2.29.2

--===============5247823258493963995==--
