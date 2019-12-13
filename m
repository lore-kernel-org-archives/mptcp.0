Content-Type: multipart/mixed; boundary="===============6776361125841068625=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 2/2] .topmsg: mptcp: add basic kselftest for mptcp
Date: Fri, 13 Dec 2019 12:38:54 +0100
Message-ID: <20191213113854.1690771-3-matthieu.baerts@tessares.net>
In-Reply-To: 20191213113854.1690771-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2931

--===============6776361125841068625==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fix typos, add a note about NS, delays, losses, reordering and the
timeout.

Also remove the "changelog" of a previous rebase made by Florian.

Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
---

Notes:
    to be squashed in "mptcp: add basic kselftest for mptcp"

 .topmsg | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/.topmsg b/.topmsg
index 1cdc59deb36d..5eaa378264a1 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,8 +1,9 @@
 From: Florian Westphal <fw(a)strlen.de>
 Subject: [PATCH] mptcp: add basic kselftest for mptcp
 =

-Add mpcp_connect tool:
-xmit two files back and forth between two processes.
+Add mptcp_connect tool:
+xmit two files back and forth between two processes, several net
+namespaces including some adding delays, losses and reordering.
 Wrapper script tests that data was transmitted without corruption.
 =

 The "-c" command line option for mptcp_connect.sh is there for debugging:
@@ -24,10 +25,15 @@ io using read/write/poll.
 =

 Will run automatically on "make kselftest".
 =

-This patch merged following enhancements:
-From Mat Martineau: Add capture option
-From Matthieu Baerts: Add sysctl test
-From Paolo Abeni: Use tc/ethtool to test more skb handling code paths
+Note that the default timeout of 45 seconds is used even if there is a
+"settings" changing it to 450. 45 seconds should be enough in most cases
+but this depends on the machine running the tests.
+
+A fix to correctly read the "settings" file has been proposed upstream
+but not applied yet. It is not blocking the execution of these new tests
+but it would be nice to have it:
+
+  https://patchwork.kernel.org/patch/11204935/
 =

 Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
-- =

2.24.0

--===============6776361125841068625==--
