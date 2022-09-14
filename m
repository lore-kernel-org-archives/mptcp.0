Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FD3D77
	for <mptcp@lists.linux.dev>; Wed, 14 Sep 2022 11:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663155123; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=LhXqwIO52qM/uMtPOv1S/YaztolBhdL9MMWemq9GM4d42I9XhF2OpumYvytuWiOcKU6xLaOsjoYJ64SBg5fXvuP2ZCzyStlKU8NLYREqWqcXXm2bh1WZ5sfLvTByVDtnZqUT2oYQAxrCBVzyMbu4Y7ClOfZMdPnIvpbArmg++bE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663155123; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=cu3YmmThJMZGOKLkyPAa2fKHu+wJyLPOEt7uWzKa6y0=; 
	b=dnt4RuORCic6mITIHbGSe13n6FQ2rHKDbXrkUSHPMeFTniqVhMJRIPtc3lVejNn+ywrt85codc7DmR5B/sJnhN1vekDoqejLpee4VzrD8tVARSS6I4yrJJJ8sonGdt0AyyqWdFUml2v5FFdtCp1d1RONqZ4jqzFZAQgD7py4SGw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663155123;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cu3YmmThJMZGOKLkyPAa2fKHu+wJyLPOEt7uWzKa6y0=;
	b=CntNJ10hI83/0imt5Nn+jeDKW0JuHophaIBJC2FRIkTftpfU/6j+/kcVKCoXWZDY
	CWOd8PfTXs3hj85vdzFvaJa+ETvvWok3fGYo2kG90g83JK4VSEBqbF1hQKerPa6nfwf
	dKkR6DWj2pKzr3Hv8nAlQsQwt/ELEQWGo5MXxSMg=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663155120403279.09212300088984; Wed, 14 Sep 2022 13:32:00 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220914113151.9898-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v5 01/10] mptcp: Fast Open Mechanism
Date: Wed, 14 Sep 2022 13:31:42 +0200
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

This set of patches will bring "Fast Open" Option support to MPTCP.
The aim of Fast Open Mechanism is to eliminate one round trip
time from a TCP conversation by allowing data to be included as
part of the SYN segment that initiates the connection.

IETF RFC 8684: Appendix B. TCP Fast Open and MPTCP.

[PATCH v5] includes "client-server" partial support for :
1. MPTCP cookie request from client (seems OK).
2. MPTCP cookie offering from server (seems OK).
3. MPTCP SYN+DATA+COOKIE from client (seems OK).
4. subsequent write + read on the opened socket (seems OK).

=3D=3D=3DChanges between v4 and v5:
- All data sent by the initiator received by listener in userspace.
- No more infinite re-transmissions of the same packet in the
end of the second connection.
- =E2=80=9DWARNING in sk stream kill queues=E2=80=9D, when skb is added to
msk queue - is fixed.
- Fix the second (discarded) packet that is re-transmitted in the
end of 2nd session.
- We have (in the v4 it is not present) the FIN in the end of the
2nd (TFO data+cookie+syn) session.
=3D=3D=3DTradeoffs of v5:
-Minimal impact on existing TCP code in linux kernel.
-Icreased size of the patch. Some functions are inspired from
existing code in fastopen.c and others.
=3D=3D=3DFuture work:
-Address the appearence of =E2=80=9DMPTCP FIN=E2=80=9D as ducplicated acks.

Add separate *.c file. Function prototypes are coming to protocol.h
(Suggestion of @palbeni (JUN 17))

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
 net/mptcp/Makefile   | 2 +-
 net/mptcp/fastopen.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 net/mptcp/fastopen.c

diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
index 8a7f68efa35f..c42ad8609876 100644
--- a/net/mptcp/Makefile
+++ b/net/mptcp/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_MPTCP) +=3D mptcp.o
=20
 mptcp-y :=3D protocol.o subflow.o options.o token.o crypto.o ctrl.o pm.o d=
iag.o \
-=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o
+=09   mib.o pm_netlink.o sockopt.o pm_userspace.o sched.o fastopen.o
=20
 obj-$(CONFIG_SYN_COOKIES) +=3D syncookies.o
 obj-$(CONFIG_INET_MPTCP_DIAG) +=3D mptcp_diag.o
diff --git a/net/mptcp/fastopen.c b/net/mptcp/fastopen.c
new file mode 100644
index 000000000000..0c9ef6f5d528
--- /dev/null
+++ b/net/mptcp/fastopen.c
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * MPTCP Fast Open Mechanism. Copyright (c) 2021-2022, Dmytro SHYTYI
+ */
+
+#include "protocol.h"
--=20
2.25.1


