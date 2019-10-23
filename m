Content-Type: multipart/mixed; boundary="===============6717024391403406394=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 2/2] selftests:mptcp: increase timeout
Date: Wed, 23 Oct 2019 08:48:54 +0200
Message-ID: <20191023064854.20453-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191023064854.20453-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2274

--===============6717024391403406394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of 45s, we switch to 450s.

In my tests, on a few years old machines with KASAN, etc. it took up to
3 minutes and 30 seconds. I then doubled the value and rounded it to 7.5
minutes.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    To squash in "mptcp: add basic kselftest for mptcp"
    =

    v2:
     - fixed a (stupid) typo, thanks Florian (and sorry for the noise)

 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 7 +++++++
 tools/testing/selftests/net/mptcp/settings         | 1 +
 2 files changed, 8 insertions(+)
 create mode 100644 tools/testing/selftests/net/mptcp/settings

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/tes=
ting/selftests/net/mptcp/mptcp_connect.sh
index f0528df9ac31..91f7be476504 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 =

+time_start=3D$(date +%s)
+
 ret=3D0
 sin=3D""
 sout=3D""
@@ -317,4 +319,9 @@ for sender in 1 2 3 4;do
 	run_tests ns4 ns$sender 10.0.3.1
 done
 =

+time_end=3D$(date +%s)
+time_run=3D$((time_end-time_start))
+
+echo "Time: ${time_run} seconds"
+
 exit $ret
diff --git a/tools/testing/selftests/net/mptcp/settings b/tools/testing/sel=
ftests/net/mptcp/settings
new file mode 100644
index 000000000000..026384c189c9
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/settings
@@ -0,0 +1 @@
+timeout=3D450
-- =

2.20.1

--===============6717024391403406394==--
