Content-Type: multipart/mixed; boundary="===============0908905750745914292=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 1/2] include: update mptcp uAPI
Date: Thu, 02 Jul 2020 13:35:53 +0200
Message-ID: <5af10f506cf465abb052a23b960a22fad0716025.1593689647.git.pabeni@redhat.com>
In-Reply-To: cover.1593689647.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4902

--===============0908905750745914292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This pulls-in diag info definition

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
v1 -> v2:
 - update to new uapi
---
 include/uapi/linux/inet_diag.h |  1 +
 include/uapi/linux/mptcp.h     | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index f009abf1..cd83b4f8 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -65,6 +65,7 @@ enum {
 	INET_DIAG_REQ_NONE,
 	INET_DIAG_REQ_BYTECODE,
 	INET_DIAG_REQ_SK_BPF_STORAGES,
+	INET_DIAG_REQ_PROTOCOL,
 	__INET_DIAG_REQ_MAX,
 };
 =

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 009b8f0b..6f1fba2e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -86,4 +86,21 @@ enum {
 	__MPTCP_PM_CMD_AFTER_LAST
 };
 =

+#define MPTCP_INFO_FLAG_FALLBACK		_BITUL(0)
+#define MPTCP_INFO_FLAG_REMOTE_KEY		_BITUL(1)
+
+struct mptcp_info {
+	__u8	mptcpi_subflows;
+	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_subflows_max;
+	__u8	mptcpi_add_addr_signal_max;
+	__u8	mptcpi_add_addr_accepted_max;
+	__u32	mptcpi_flags;
+	__u32	mptcpi_token;
+	__u64	mptcpi_write_seq;
+	__u64	mptcpi_snd_una;
+	__u64	mptcpi_rcv_nxt;
+};
+
 #endif /* _MPTCP_H */
-- =

2.26.2

--===============0908905750745914292==--
