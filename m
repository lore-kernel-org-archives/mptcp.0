Content-Type: multipart/mixed; boundary="===============7182575860168742078=="
MIME-Version: 1.0
From: Davide Caratti <dcaratti at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: selftests: fix .gitignore for mptcp selftests
Date: Thu, 11 Jul 2019 18:44:44 +0200
Message-ID: <3dc9dce8f6705744193d46d72786fc2caa1f2da6.1562863484.git.dcaratti@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 1483

--===============7182575860168742078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

since mptcp_connect.sh can generate pcap traces when the '-c' argument is
used, add *.pcap to .gitignore, to avoid untracked files in the output of
"git status".

 [root(a)rhel7 mptcp]# git status
 # HEAD detached at origin/mptcp-prova
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
 #       ns1-ns1-MPTCP-MPTCP-10.0.1.1.pcap
 #       ns1-ns1-MPTCP-TCP-10.0.1.1.pcap
 #       ns1-ns1-TCP-MPTCP-10.0.1.1.pcap
 [...]

Fixes: 4dc10c542166 ("mptcp: selftests: Add capture option")
Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
---
 tools/testing/selftests/net/mptcp/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/.gitignore b/tools/testing/s=
elftests/net/mptcp/.gitignore
index 3143fb05a511..d72f07642738 100644
--- a/tools/testing/selftests/net/mptcp/.gitignore
+++ b/tools/testing/selftests/net/mptcp/.gitignore
@@ -1 +1,2 @@
 mptcp_connect
+*.pcap
-- =

2.20.1


--===============7182575860168742078==--
