Content-Type: multipart/mixed; boundary="===============8290541932295383593=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20200222: 2 conflicts
Date: Sat, 22 Feb 2020 09:08:20 +0100
Message-ID: <b2d2245b-389b-8149-20b1-4b8fedfab5e8@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 3744

--===============8290541932295383593==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Recently, 'net-next' has been synced with Linus tree including recent =

changes in 'net', creating 2 conflicts:


diff --cc net/mptcp/protocol.h
index 0518978ae9dc,9f2440192e18..000000000000
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@@ -78,9 -78,8 +78,14 @@@
   #define MPTCP_ADDR_IPVERSION_6        6

   /* MPTCP socket flags */
++<<<<<<< t/mptcp-implement-and-use-MPTCP-level-retransmission
  +#define MPTCP_DATA_READY      BIT(0)
  +#define MPTCP_SEND_SPACE      BIT(1)
  +#define MPTCP_WORK_RTX                BIT(2)
++=3D=3D=3D=3D=3D=3D=3D
+ #define MPTCP_DATA_READY      0
+ #define MPTCP_SEND_SPACE      1
++>>>>>>> top-bases/t/mptcp-implement-and-use-MPTCP-level-retransmission

   static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
   {



and:



diff --cc net/mptcp/protocol.h
index ff896336bffc,8af603e05cb2..000000000000
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@@ -78,10 -78,9 +78,16 @@@
   #define MPTCP_ADDR_IPVERSION_6        6

   /* MPTCP socket flags */
++<<<<<<< t/subflow-check-parent-mptcp-socket-on-subflow-state-change
  +#define MPTCP_DATA_READY      BIT(0)
  +#define MPTCP_SEND_SPACE      BIT(1)
  +#define MPTCP_WORK_RTX                BIT(2)
  +#define MPTCP_WORK_EOF                BIT(3)
++=3D=3D=3D=3D=3D=3D=3D
+ #define MPTCP_DATA_READY      0
+ #define MPTCP_SEND_SPACE      1
+ #define MPTCP_WORK_RTX                2
++>>>>>>> =

top-bases/t/subflow-check-parent-mptcp-socket-on-subflow-state-change

   static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
   {



simple to resolve:

- ffe33d75448d: conflict in =

t/mptcp-implement-and-use-MPTCP-level-retransmission
- 30dc32a44780: conflict in =

t/subflow-check-parent-mptcp-socket-on-subflow-state-change

Tests + export are in progress!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============8290541932295383593==--
