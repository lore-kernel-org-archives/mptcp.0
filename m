Content-Type: multipart/mixed; boundary="===============4823311673172780975=="
MIME-Version: 1.0
From: Christoph Hellwig <hch at lst.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH 01/22] net/atm: remove the atmdev_ops {get,
 set}sockopt methods
Date: Fri, 17 Jul 2020 08:23:10 +0200
Message-ID: <20200717062331.691152-2-hch@lst.de>
In-Reply-To: 20200717062331.691152-1-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5051

--===============4823311673172780975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All implementations of these two methods are dummies that always
return -EINVAL.

Signed-off-by: Christoph Hellwig <hch(a)lst.de>
---
 drivers/atm/eni.c        | 17 -----------------
 drivers/atm/firestream.c |  2 --
 drivers/atm/fore200e.c   | 27 ---------------------------
 drivers/atm/horizon.c    | 40 ----------------------------------------
 drivers/atm/iphase.c     | 16 ----------------
 drivers/atm/lanai.c      |  2 --
 drivers/atm/solos-pci.c  |  2 --
 drivers/atm/zatm.c       | 16 ----------------
 include/linux/atmdev.h   |  9 ---------
 net/atm/common.c         | 14 ++------------
 10 files changed, 2 insertions(+), 143 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 17d47ad03ab79e..b3d8e00e76716c 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -2027,21 +2027,6 @@ static int eni_ioctl(struct atm_dev *dev,unsigned in=
t cmd,void __user *arg)
 	return dev->phy->ioctl(dev,cmd,arg);
 }
 =

-
-static int eni_getsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,int optlen)
-{
-	return -EINVAL;
-}
-
-
-static int eni_setsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,unsigned int optlen)
-{
-	return -EINVAL;
-}
-
-
 static int eni_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	enum enq_res res;
@@ -2215,8 +2200,6 @@ static const struct atmdev_ops ops =3D {
 	.open		=3D eni_open,
 	.close		=3D eni_close,
 	.ioctl		=3D eni_ioctl,
-	.getsockopt	=3D eni_getsockopt,
-	.setsockopt	=3D eni_setsockopt,
 	.send		=3D eni_send,
 	.phy_put	=3D eni_phy_put,
 	.phy_get	=3D eni_phy_get,
diff --git a/drivers/atm/firestream.c b/drivers/atm/firestream.c
index cc87004d5e2d62..2ca9ec80273429 100644
--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -1277,8 +1277,6 @@ static const struct atmdev_ops ops =3D {
 	.send =3D         fs_send,
 	.owner =3D        THIS_MODULE,
 	/* ioctl:          fs_ioctl, */
-	/* getsockopt:     fs_getsockopt, */
-	/* setsockopt:     fs_setsockopt, */
 	/* change_qos:     fs_change_qos, */
 =

 	/* For now implement these internally here... */  =

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index f4ad7ce25ae8d1..a81bc49c14acc6 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1710,31 +1710,6 @@ fore200e_getstats(struct fore200e* fore200e)
     return 0;
 }
 =

-
-static int
-fore200e_getsockopt(struct atm_vcc* vcc, int level, int optname, void __us=
er *optval, int optlen)
-{
-    /* struct fore200e* fore200e =3D FORE200E_DEV(vcc->dev); */
-
-    DPRINTK(2, "getsockopt %d.%d.%d, level =3D %d, optname =3D 0x%x, optva=
l =3D 0x%p, optlen =3D %d\n",
-	    vcc->itf, vcc->vpi, vcc->vci, level, optname, optval, optlen);
-
-    return -EINVAL;
-}
-
-
-static int
-fore200e_setsockopt(struct atm_vcc* vcc, int level, int optname, void __us=
er *optval, unsigned int optlen)
-{
-    /* struct fore200e* fore200e =3D FORE200E_DEV(vcc->dev); */
-    =

-    DPRINTK(2, "setsockopt %d.%d.%d, level =3D %d, optname =3D 0x%x, optva=
l =3D 0x%p, optlen =3D %d\n",
-	    vcc->itf, vcc->vpi, vcc->vci, level, optname, optval, optlen);
-    =

-    return -EINVAL;
-}
-
-
 #if 0 /* currently unused */
 static int
 fore200e_get_oc3(struct fore200e* fore200e, struct oc3_regs* regs)
@@ -3026,8 +3001,6 @@ static const struct atmdev_ops fore200e_ops =3D {
 	.open       =3D fore200e_open,
 	.close      =3D fore200e_close,
 	.ioctl      =3D fore200e_ioctl,
-	.getsockopt =3D fore200e_getsockopt,
-	.setsockopt =3D fore200e_setsockopt,
 	.send       =3D fore200e_send,
 	.change_qos =3D fore200e_change_qos,
 	.proc_read  =3D fore200e_proc_read,
diff --git a/drivers/atm/horizon.c b/drivers/atm/horizon.c
index e5da51f907a25d..4f2951cbe69c08 100644
--- a/drivers/atm/horizon.c
+++ b/drivers/atm/horizon.c
@@ -2527,46 +2527,6 @@ static void hrz_close (struct atm_vcc * atm_vcc) {
   clear_bit(ATM_VF_ADDR,&atm_vcc->flags);
 }
 =

-#if 0
-static int hrz_getsockopt (struct atm_vcc * atm_vcc, int level, int optnam=
e,
-			   void *optval, int optlen) {
-  hrz_dev * dev =3D HRZ_DEV(atm_vcc->dev);
-  PRINTD (DBG_FLOW|DBG_VCC, "hrz_getsockopt");
-  switch (level) {
-    case SOL_SOCKET:
-      switch (optname) {
-//	case SO_BCTXOPT:
-//	  break;
-//	case SO_BCRXOPT:
-//	  break;
-	default:
-	  return -ENOPROTOOPT;
-      };
-      break;
-  }
-  return -EINVAL;
-}
-
-static int hrz_setsockopt (struct atm_vcc * atm_vcc, int level, int optnam=
e,
-			   void *optval, unsigned int optlen) {
-  hrz_dev * dev =3D HRZ_DEV(atm_vcc->dev);
-  PRINTD (DBG_FLOW|DBG_VCC, "hrz_setsockopt");
-  switch (level) {
-    case SOL_SOCKET:
-      switch (optname) {
-//	case SO_BCTXOPT:
-//	  break;
-//	case SO_BCRXOPT:
-//	  break;
-	default:
-	  return -ENOPROTOOPT;
-      };
-      break;
-  }
-  return -EINVAL;
-}
-#endif
-
 #if 0
 static int hrz_ioctl (struct atm_dev * atm_dev, unsigned int cmd, void *ar=
g) {
   hrz_dev * dev =3D HRZ_DEV(atm_dev);
diff --git a/drivers/atm/iphase.c b/drivers/atm/iphase.c
index 8c7a996d1f16cf..eef637fd90b323 100644
--- a/drivers/atm/iphase.c
+++ b/drivers/atm/iphase.c
@@ -2880,20 +2880,6 @@ static int ia_ioctl(struct atm_dev *dev, unsigned in=
t cmd, void __user *arg)
    return 0;  =

 }  =

   =

-static int ia_getsockopt(struct atm_vcc *vcc, int level, int optname,   =

-	void __user *optval, int optlen)  =

-{  =

-	IF_EVENT(printk(">ia_getsockopt\n");)  =

-	return -EINVAL;  =

-}  =

-  =

-static int ia_setsockopt(struct atm_vcc *vcc, int level, int optname,   =

-	void __user *optval, unsigned int optlen)  =

-{  =

-	IF_EVENT(printk(">ia_setsockopt\n");)  =

-	return -EINVAL;  =

-}  =

-  =

 static int ia_pkt_tx (struct atm_vcc *vcc, struct sk_buff *skb) {
         IADEV *iadev;
         struct dle *wr_ptr;
@@ -3164,8 +3150,6 @@ static const struct atmdev_ops ops =3D {
 	.open		=3D ia_open,  =

 	.close		=3D ia_close,  =

 	.ioctl		=3D ia_ioctl,  =

-	.getsockopt	=3D ia_getsockopt,  =

-	.setsockopt	=3D ia_setsockopt,  =

 	.send		=3D ia_send,  =

 	.phy_put	=3D ia_phy_put,  =

 	.phy_get	=3D ia_phy_get,  =

diff --git a/drivers/atm/lanai.c b/drivers/atm/lanai.c
index 645a6bc1df8886..986c1313694c66 100644
--- a/drivers/atm/lanai.c
+++ b/drivers/atm/lanai.c
@@ -2537,8 +2537,6 @@ static const struct atmdev_ops ops =3D {
 	.dev_close	=3D lanai_dev_close,
 	.open		=3D lanai_open,
 	.close		=3D lanai_close,
-	.getsockopt	=3D NULL,
-	.setsockopt	=3D NULL,
 	.send		=3D lanai_send,
 	.phy_put	=3D NULL,
 	.phy_get	=3D NULL,
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index b7646ae55942e6..94fbc3abe60e6a 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1179,8 +1179,6 @@ static const struct atmdev_ops fpga_ops =3D {
 	.open =3D		popen,
 	.close =3D	pclose,
 	.ioctl =3D	NULL,
-	.getsockopt =3D	NULL,
-	.setsockopt =3D	NULL,
 	.send =3D		psend,
 	.send_oam =3D	NULL,
 	.phy_put =3D	NULL,
diff --git a/drivers/atm/zatm.c b/drivers/atm/zatm.c
index 57f97b95a4531c..2788b985edbe48 100644
--- a/drivers/atm/zatm.c
+++ b/drivers/atm/zatm.c
@@ -1515,20 +1515,6 @@ static int zatm_ioctl(struct atm_dev *dev,unsigned i=
nt cmd,void __user *arg)
 	}
 }
 =

-
-static int zatm_getsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,int optlen)
-{
-	return -EINVAL;
-}
-
-
-static int zatm_setsockopt(struct atm_vcc *vcc,int level,int optname,
-    void __user *optval,unsigned int optlen)
-{
-	return -EINVAL;
-}
-
 static int zatm_send(struct atm_vcc *vcc,struct sk_buff *skb)
 {
 	int error;
@@ -1582,8 +1568,6 @@ static const struct atmdev_ops ops =3D {
 	.open		=3D zatm_open,
 	.close		=3D zatm_close,
 	.ioctl		=3D zatm_ioctl,
-	.getsockopt	=3D zatm_getsockopt,
-	.setsockopt	=3D zatm_setsockopt,
 	.send		=3D zatm_send,
 	.phy_put	=3D zatm_phy_put,
 	.phy_get	=3D zatm_phy_get,
diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 8124815eb1218b..5d5ff2203fa220 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -176,11 +176,6 @@ struct atm_dev {
 #define ATM_OF_IMMED  1		/* Attempt immediate delivery */
 #define ATM_OF_INRATE 2		/* Attempt in-rate delivery */
 =

-
-/*
- * ioctl, getsockopt, and setsockopt are optional and can be set to NULL.
- */
-
 struct atmdev_ops { /* only send is required */
 	void (*dev_close)(struct atm_dev *dev);
 	int (*open)(struct atm_vcc *vcc);
@@ -190,10 +185,6 @@ struct atmdev_ops { /* only send is required */
 	int (*compat_ioctl)(struct atm_dev *dev,unsigned int cmd,
 			    void __user *arg);
 #endif
-	int (*getsockopt)(struct atm_vcc *vcc,int level,int optname,
-	    void __user *optval,int optlen);
-	int (*setsockopt)(struct atm_vcc *vcc,int level,int optname,
-	    void __user *optval,unsigned int optlen);
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
 	int (*send_oam)(struct atm_vcc *vcc,void *cell,int flags);
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
diff --git a/net/atm/common.c b/net/atm/common.c
index 8575f5d52087d3..9b28f1fb3c69c8 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -782,13 +782,8 @@ int vcc_setsockopt(struct socket *sock, int level, int=
 optname,
 			vcc->atm_options &=3D ~ATM_ATMOPT_CLP;
 		return 0;
 	default:
-		if (level =3D=3D SOL_SOCKET)
-			return -EINVAL;
-		break;
-	}
-	if (!vcc->dev || !vcc->dev->ops->setsockopt)
 		return -EINVAL;
-	return vcc->dev->ops->setsockopt(vcc, level, optname, optval, optlen);
+	}
 }
 =

 int vcc_getsockopt(struct socket *sock, int level, int optname,
@@ -826,13 +821,8 @@ int vcc_getsockopt(struct socket *sock, int level, int=
 optname,
 		return copy_to_user(optval, &pvc, sizeof(pvc)) ? -EFAULT : 0;
 	}
 	default:
-		if (level =3D=3D SOL_SOCKET)
-			return -EINVAL;
-		break;
-	}
-	if (!vcc->dev || !vcc->dev->ops->getsockopt)
 		return -EINVAL;
-	return vcc->dev->ops->getsockopt(vcc, level, optname, optval, len);
+	}
 }
 =

 int register_atmdevice_notifier(struct notifier_block *nb)
-- =

2.27.0

--===============4823311673172780975==--
