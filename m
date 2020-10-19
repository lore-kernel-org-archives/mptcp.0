Content-Type: multipart/mixed; boundary="===============2627414954572375224=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH net-next 0/2] init ahmac and port of
 mptcp_options_received
Date: Mon, 19 Oct 2020 18:23:14 +0800
Message-ID: <cover.1603102503.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 6346

--===============2627414954572375224==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patchset deals with initializations of mptcp_options_received's two
fields, ahmac and port.

Geliang Tang (2):
  mptcp: initialize mptcp_options_received's ahmac
  mptcp: move mptcp_options_received's port initialization

 net/mptcp/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- =

2.26.2

--===============2627414954572375224==--
