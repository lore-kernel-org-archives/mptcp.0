Content-Type: multipart/mixed; boundary="===============1829473770411731546=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 0/2] Fix bug processing options
Date: Tue, 22 Oct 2019 15:54:57 -0700
Message-ID: <20191022225459.15312-1-peter.krystad@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 2268

--===============1829473770411731546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do not process incoming options if the subflow is not MPTCP.

Observed crash when running against out-of-tree kernel with
mis-matched checksum options.

Peter Krystad (2):
  mptcp: Ignore incoming MPTCP options when not MP_CAPABLE
  mptcp: Ignore incoming MPTCP options when not MP_CAPABLE

 net/mptcp/options.c | 3 +++
 1 file changed, 3 insertions(+)

-- =

2.17.2

--===============1829473770411731546==--
