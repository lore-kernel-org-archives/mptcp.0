Content-Type: multipart/mixed; boundary="===============0921636903951840519=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] topmsg: mptcp: add netlink based PM
Date: Thu, 19 Mar 2020 17:23:07 -0700
Message-ID: <20200320002307.89947-5-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 4006

--===============0921636903951840519==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---
 .topmsg | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/.topmsg b/.topmsg
index bf371916f85e..e1be48166a8c 100644
--- a/.topmsg
+++ b/.topmsg
@@ -1,7 +1,7 @@
 From: Paolo Abeni <pabeni(a)redhat.com>
-Subject: [PATCH] mptcp: add netlink based PM
+Subject: [PATCH] mptcp: add netlink-based PM
 =

-Expose to U/S a netlink family to control the PM, setting:
+Expose a new netlink family to userspace to control the PM, setting:
 =

  - list of local addresses to be signalled.
  - list of local addresses used to created subflows.
@@ -12,35 +12,11 @@ announce the 'signal' list via the ADD_ADDR option. Sin=
ce we
 currently lack the ADD_ADDR echo (and related event) only the
 first addr is sent.
 =

-After exhausting the 'annunce' list, the PM tries to create
+After exhausting the 'announce' list, the PM tries to create
 subflow for each addr in 'local' list, waiting for each
 connection to be completed before attempting the next one.
 =

 Idea is to add an additional PM hook for ADD_ADDR echo, to allow
 the PM netlink announcing multiple addresses, in sequence.
 =

-v3  -> v4:
- - fixed several NL parsing issues
- - give announce priority to subflow creation
- - added '_PM' prefix to command names
- - renamed 'addr_list' to 'local_addr_list'
- - renamed mptcp_pm_create_subflow_or_signal ->
-	 mptcp_pm_create_subflow_or_signal_addr
- - renamed mptcp_pm_nl_add_addr ->
-	mptcp_pm_nl_add_addr_received
-
-v1  -> v2:
- - explicitly reset pm status to idle after processing a command
- - fix msk pm initialization
- - fix mptcp_pm_nl_add_addr bugs
- - added ifindex support
- - hopefully clearer local function names
- - always use  IS_ENABLED(CONFIG_MPTCP_IPV6) instead of
-    IS_ENABLED(CONFIG_IPV6)
-
-RFC -> v1:
- - simplified NL API
- - reduced {WRITE,READ}_ONCE boilerplate due to PM changes
- - add check for duplicate addresses
-
 Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
-- =

2.25.2

--===============0921636903951840519==--
