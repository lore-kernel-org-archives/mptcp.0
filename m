Content-Type: multipart/mixed; boundary="===============6044638621950972182=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next v2 1/3] mptcp: add reuseaddr/port and
 v6only setsockopts
Date: Tue, 16 Jun 2020 14:25:28 +0200
Message-ID: <20200616122531.2443-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4695

--===============6044638621950972182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo says he prefers direct hooking of SOL_SOCKET instead of copying
values in bind/listen/connect, so do that here.

Similar to the v1 patchset, except that first patch is new (adds
needed 'do not use generic handler' for mptcp sake),
second patch adds minimal SOL_SOCKET support (rest yields -EOPNOTSUPP).
Last patch is almost the same as v1 (only fixes an error check and
extends scope of sk lock).


--===============6044638621950972182==--
