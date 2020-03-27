Content-Type: multipart/mixed; boundary="===============1477386211593722596=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 4/6] topmsg: mptcp: rework mptcp_sendmsg_frag to
 accept optional dfrag
Date: Fri, 27 Mar 2020 16:53:25 +0100
Message-ID: <20200327155327.605375-5-matthieu.baerts@tessares.net>
In-Reply-To: 20200327155327.605375-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4091

--===============1477386211593722596==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ChangeLog.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---
 .topmsg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.topmsg b/.topmsg
index a6886a686d9d..0060d6b54385 100644
--- a/.topmsg
+++ b/.topmsg
@@ -23,6 +23,9 @@ this the mptcp sk_sndbuf limit.
 In the future we could add experiment with autotuning as TCP does in
 tcp_sndbuf_expand().
 =

+v2 -> v3:
+ - remove 'inline' in foo.c files (David S. Miller)
+
 Co-developed-by: Florian Westphal <fw(a)strlen.de>
 Signed-off-by: Florian Westphal <fw(a)strlen.de>
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
-- =

2.25.1

--===============1477386211593722596==--
