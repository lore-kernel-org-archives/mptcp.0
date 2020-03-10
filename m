Content-Type: multipart/mixed; boundary="===============1854551933999900553=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "mptcp: add netlink based PM"
Date: Tue, 10 Mar 2020 19:26:22 +0100
Message-ID: <6be08bc3c70b13306aeaee7f65163e9a349cb632.1583864759.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 3903

--===============1854551933999900553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove typo in enum name. It looks like anonymous enum
is the most common choice, so drop the enum type name
completely.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/mptcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index d061c5a6ae05..dfd6674c39b0 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -40,7 +40,7 @@ enum {
 /*
  * ATTR types defined for MPTCP
  */
-enum mptcp_pm_attrs {
+enum {
 	MPTCP_PM_ATTR_UNSPEC,
 =

 	MPTCP_PM_ATTR_ADDR,				/* nested address */
@@ -52,7 +52,7 @@ enum mptcp_pm_attrs {
 =

 #define MPTCP_PM_ATTR_MAX (__MPTCP_PM_ATTR_MAX - 1)
 =

-enum mptcp_pm_addr_addrs {
+enum {
 	MPTCP_PM_ADDR_ATTR_UNSPEC,
 =

 	MPTCP_PM_ADDR_ATTR_FAMILY,			/* u16 */
-- =

2.21.1

--===============1854551933999900553==--
