Content-Type: multipart/mixed; boundary="===============2405818843446141182=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20191006: 1 conflict
Date: Mon, 07 Oct 2019 10:15:25 +0200
Message-ID: <f4934121-0e0b-a987-da57-fde39353ca9e@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 2027

--===============2405818843446141182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Just to inform you that we got a conflict when integrating last changes
from net-next:



diff --cc include/net/netns/mib.h
index 59fcaef98fb8,b5fdb108d602..000000000000
--- a/include/net/netns/mib.h
+++ b/include/net/netns/mib.h
@@@ -24,9 -24,9 +24,12 @@@ struct netns_mib
  #ifdef CONFIG_XFRM_STATISTICS
        DEFINE_SNMP_STAT(struct linux_xfrm_mib, xfrm_statistics);
  #endif
+ #if IS_ENABLED(CONFIG_TLS)
+       DEFINE_SNMP_STAT(struct linux_tls_mib, tls_statistics);
+ #endif
 +#ifdef CONFIG_MPTCP
 +      DEFINE_SNMP_STAT(struct mptcp_mib, mptcp_statistics);
 +#endif
  };

  #endif



Again very easy to fix, it is due to d26b698dd3cd (net/tls: add skeleton
of MIB statistics) by Jakub Kicinski. It is fixed with 6ba3c8c3fd81 in
t/mptcp-add-MIB-counter-infrastructure.

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============2405818843446141182==--
