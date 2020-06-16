Content-Type: multipart/mixed; boundary="===============0091255631330145776=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next 0/3] add MP_PRIO,
 MP_FAIL and MP_FASTCLOSE suboptions handling
Date: Tue, 16 Jun 2020 14:47:35 +0800
Message-ID: <cover.1592289629.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 4690

--===============0091255631330145776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add handling for sending and receiving the MP_PRIO, MP_FAIL, and
MP_FASTCLOSE suboptions.

Geliang Tang (3):
  mptcp: add MP_PRIO suboption handling
  mptcp: add MP_FAIL suboption handling
  mptcp: add MP_FASTCLOSE suboption handling

 net/mptcp/options.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |  9 +++++++++
 2 files changed, 57 insertions(+)

-- =

2.17.1

--===============0091255631330145776==--
