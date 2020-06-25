Content-Type: multipart/mixed; boundary="===============7642440262551509366=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH iproute2-next 1/2] include: update mptcp uAPI
Date: Thu, 25 Jun 2020 12:34:42 +0200
Message-ID: <dff98fe6bc0b41650413d04cd74c9a47e7056309.1593081210.git.pabeni@redhat.com>
In-Reply-To: cover.1593081210.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4801

--===============7642440262551509366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This pulls-in diag info definition

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 include/uapi/linux/inet_diag.h |  1 +
 include/uapi/linux/mptcp.h     | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

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
index 009b8f0b..a5fade2e 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -86,4 +86,19 @@ enum {
 	__MPTCP_PM_CMD_AFTER_LAST
 };
 =

+struct mptcp_info {
+	__u8	mptcpi_subflows;
+	__u8	mptcpi_add_addr_signal;
+	__u8	mptcpi_add_addr_accepted;
+	__u8	mptcpi_subflows_max;
+	__u8	mptcpi_add_addr_signal_max;
+	__u8	mptcpi_add_addr_accepted_max;
+	__u8	mptcpi_fallback;
+	__u8	mptcpi_can_ack;
+	__u32	mptcpi_token;
+	__u64	mptcpi_write_seq;
+	__u64	mptcpi_snd_una;
+	__u64	mptcpi_rcv_nxt;
+};
+
 #endif /* _MPTCP_H */
-- =

2.26.2

--===============7642440262551509366==--
