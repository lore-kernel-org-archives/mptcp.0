Content-Type: multipart/mixed; boundary="===============6592983472965113684=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] [GIT] Sync with net-next on 20190907: 3 conflicts
Date: Sat, 07 Sep 2019 17:19:40 +0200
Message-ID: <4639aa18-8c10-fcc7-c90d-d582880954d5@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1797

--===============6592983472965113684==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Just to inform you that we got a conflict when integrating last changes
from net-next:



diff --cc include/linux/skbuff.h
index 2576cbb2dd48,22edd5a32c4e..000000000000
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@@ -4058,8 -4068,8 +4068,13 @@@ enum skb_ext_id
  #ifdef CONFIG_XFRM
        SKB_EXT_SEC_PATH,
  #endif
++<<<<<<< t/mptcp-Add-MPTCP-to-skb-extensions
 +#if IS_ENABLED(CONFIG_MPTCP)
 +      SKB_EXT_MPTCP,
++=3D=3D=3D=3D=3D=3D=3D
+ #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
+       TC_SKB_EXT,
++>>>>>>> top-bases/t/mptcp-Add-MPTCP-to-skb-extensions
  #endif
        SKB_EXT_NUM, /* must be last */
  };
diff --cc net/core/skbuff.c
index 0a1c174ac372,2b40b5a9425b..000000000000
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@@ -4088,8 -4087,8 +4088,13 @@@ static const u8 skb_ext_type_len[] =3D
  #ifdef CONFIG_XFRM
        [SKB_EXT_SEC_PATH] =3D SKB_EXT_CHUNKSIZEOF(struct sec_path),
  #endif
++<<<<<<< t/mptcp-Add-MPTCP-to-skb-extensions
 +#if IS_ENABLED(CONFIG_MPTCP)
 +      [SKB_EXT_MPTCP] =3D SKB_EXT_CHUNKSIZEOF(struct mptcp_ext),
++=3D=3D=3D=3D=3D=3D=3D
+ #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
+       [TC_SKB_EXT] =3D SKB_EXT_CHUNKSIZEOF(struct tc_skb_ext),
++>>>>>>> top-bases/t/mptcp-Add-MPTCP-to-skb-extensions
  #endif
  };

@@@ -4102,8 -4101,8 +4107,13 @@@ static __always_inline unsigned int skb
  #ifdef CONFIG_XFRM
                skb_ext_type_len[SKB_EXT_SEC_PATH] +
  #endif
++<<<<<<< t/mptcp-Add-MPTCP-to-skb-extensions
 +#if IS_ENABLED(CONFIG_MPTCP)
 +              skb_ext_type_len[SKB_EXT_MPTCP] +
++=3D=3D=3D=3D=3D=3D=3D
+ #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
+               skb_ext_type_len[TC_SKB_EXT] +
++>>>>>>> top-bases/t/mptcp-Add-MPTCP-to-skb-extensions
  #endif
                0;
  }



Again very easy to fix, it is due to 95a7233c452a (net: openvswitch: Set
OvS recirc_id from tc chain index) by Paul Blakey.

I re-added our new MPTCP extension at the end.

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============6592983472965113684==--
