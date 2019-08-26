Content-Type: multipart/mixed; boundary="===============3049718232217626381=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] mptcp: fall back to tcp when dss checksum are
 requested
Date: Mon, 26 Aug 2019 14:48:12 +0200
Message-ID: <20190826124812.17481-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 1708

--===============3049718232217626381==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No other choice.  Without this, peer that requested DSS checksum will reset
the connection as soon as DSS options without checksums arrive.

squashto: mptcp: Handle MPTCP TCP options

Cc: Peter Krystad <peter.krystad(a)linux.intel.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/options.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 9f892478d336..deee4394c4c5 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -37,6 +37,22 @@ void mptcp_parse_option(const unsigned char *ptr, int op=
size,
 		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
 			break;
 =

+		/* RFC 6824, Section 3.1:
+		 * "For the Checksum Required bit (labeled "A"), if either
+		 * host requires the use of checksums, checksums MUST be used.
+		 * In other words, the only way for checksums not to be used
+		 * is if both hosts in their SYNs set A=3D0."
+		 *
+		 * Section 3.3.0:
+		 * "If a checksum is not present when its use has been
+		 * negotiated, the receiver MUST close the subflow with a RST as it is
+		 * considered broken."
+		 *
+		 * We don't implement DSS checksum - fall back to TCP.
+		 */
+		if (mp_opt->flags & MPTCP_CAP_CHECKSUM_REQD)
+			break;
+
 		mp_opt->mp_capable =3D 1;
 		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
 		ptr +=3D 8;
-- =

2.21.0


--===============3049718232217626381==--
