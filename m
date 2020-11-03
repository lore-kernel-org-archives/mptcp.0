Content-Type: multipart/mixed; boundary="===============0849064507434014378=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next] docs: networking: mptcp: Add MPTCP sysctl
 entries
Date: Mon, 02 Nov 2020 17:55:42 -0800
Message-ID: <20201103015542.16615-1-mathew.j.martineau@linux.intel.com>
X-Status: 
X-Keywords:                  
X-UID: 6518

--===============0849064507434014378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Describe the two MPTCP sysctls, what the values mean, and the default
settings.

Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
---

Jakub requested sysctl documentation for the 'add_addr_timeout' setting,
and we didn't have our 'enabled' sysctl documented either.

If this looks good to everyone I can add it to v2 the miscellaneous
series on the netdev list.


 Documentation/networking/index.rst        |  1 +
 Documentation/networking/mptcp-sysctl.rst | 24 +++++++++++++++++++++++
 MAINTAINERS                               |  1 +
 3 files changed, 26 insertions(+)
 create mode 100644 Documentation/networking/mptcp-sysctl.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/=
index.rst
index 63ef386afd0a..70c71c9206e2 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -70,6 +70,7 @@ Contents:
    lapb-module
    mac80211-injection
    mpls-sysctl
+   mptcp-sysctl
    multiqueue
    netconsole
    netdev-features
diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/netw=
orking/mptcp-sysctl.rst
new file mode 100644
index 000000000000..70c076eb361d
--- /dev/null
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+MPTCP Sysfs variables
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+/proc/sys/net/mptcp/* Variables:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+enabled - INTEGER
+	Control whether MPTCP sockets can be created.
+
+	MPTCP sockets can be created if the value is nonzero.
+
+	Default: 1
+
+add_addr_timeout - INTEGER (seconds)
+	Set the timeout after which an ADD_ADDR control message will be
+	resent to an MPTCP peer that has not acknowledged a previous
+	ADD_ADDR message.
+
+	The default value matches TCP_RTO_MAX.
+
+	Default: 120
diff --git a/MAINTAINERS b/MAINTAINERS
index 17f5571788c9..badaaa815aa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12265,6 +12265,7 @@ L:	mptcp(a)lists.01.org
 S:	Maintained
 W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
+F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/uapi/linux/mptcp.h
 F:	net/mptcp/
-- =

2.29.2

--===============0849064507434014378==--
