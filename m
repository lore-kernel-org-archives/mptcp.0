Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D4F37B97
	for <mptcp@lists.linux.dev>; Tue,  6 Jun 2023 15:30:12 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f6ffc2b314so53323255e9.0
        for <mptcp@lists.linux.dev>; Tue, 06 Jun 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686065410; x=1688657410;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wE2Hu4eqia7b01VcfgEZSH07oE1+ss9QwloqrbsDJg=;
        b=v33GChUOTQ211zq8OktF7783CKHrWZtOwbh4Jl0NRQhBaxJMdb6LUQ1WltXxvdT7To
         3D7UC8noBrgmOycw0HopnIKFOAZD4OcZj+bSczoBGndvqx6oa08U0TwQAWA8yPfPKern
         kGndb2igoHavikQr/wRohO6j9QQJcHjtwMH1Lm6NiQevQ322WnD0N32SIEV7btBC8XQ1
         YqBCZczM9LB/t3V1xjy0LCEQhw9T8fYnwaUqcGhECe9/afuOw0pYZ/Wm1Yt9BSeXufzg
         xKdwxfrrEM0ipjPy1aGdkthC4uobIZ3BbCM3ZV4JDVzso8xOa0fWL+/5W+XekO+21za/
         /+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065410; x=1688657410;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wE2Hu4eqia7b01VcfgEZSH07oE1+ss9QwloqrbsDJg=;
        b=Ms4FG3rjltITWVHZuIBKGwP0wqUJTkbv/uaVetsKZTd6jG+Q9N7Ko5zqamRrlACMnm
         d4VACSUACRNiVpwfvNPuEkYEU8g5/b+PWPJ+LOCJsyj5mnzqta9S95CIA7k2Yi7vwyWZ
         PKgzcMSYAfUhLvo4NEia46qfboUzB+Da2VdK82Y8QaavczYo+Ck+Irf/5QL0bTt1XUxU
         +E8rdFu4BJJWH/s229ArZxi1i37k6KTfeeCfuMkQewMcHcaUIVN6X6kSIpHFfDBnAFPp
         +h9IfwJtAEFono1ozGJwyi0C32XUQe2KRGWyOGbnmmW8dLEQexMUEg+neP9fo9Q3HGdC
         n/mA==
X-Gm-Message-State: AC+VfDx44xQQWrivFJWka0lYEfJrvO+8HFOMj3N9onc6qbo+PFxf+djH
	UZtYI4+kVtECcwTQa5La1USL1CTuxv9PpX88pQGTvA==
X-Google-Smtp-Source: ACHHUZ5XeDuZKLaP7nhnIyapX3z4pMgi7kmDj37oIS53S4pCpzMxwzJNyMwV1yGUb1oPDOBPrm1ERA==
X-Received: by 2002:adf:fb82:0:b0:30a:efcc:f89a with SMTP id a2-20020adffb82000000b0030aefccf89amr2146345wrr.2.1686065409446;
        Tue, 06 Jun 2023 08:30:09 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id j6-20020a5d6186000000b002ffbf2213d4sm12881374wru.75.2023.06.06.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:30:09 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 06 Jun 2023 17:29:51 +0200
Subject: [PATCH mptcp-next] Revert "Merge tag '9p-6.4-for-linus' of
 git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-mptcp-revert-9p-features-v1-1-1d7ea4b3749d@tessares.net>
X-B4-Tracking: v=1; b=H4sIAO5Qf2QC/yWNQQ7CMAwEv1L5jEVaSCT4CuohCQ7NoSGyXVSp6
 t9J4Tja3dkNhDiTwL3bgOmTJb9Lg/7UQZx8eRHmZ2MYzHAxzjicq8aKrUqseKuYyOvCJGhdINs
 n29twhTYPXggD+xKnQ6DnpYoy+fkIK1PK6+/3AX9loVVh3PcvfzSbYJMAAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=54404;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=TyqBKGPXpOeBhciWw3f8LnqTt3XebJqqwQ7W/4s1Q7I=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkf1EA3Le578OJjZuvuCWQBY5Os5kz2yHFfJfqJ
 JdMuyuS7iiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZH9RAAAKCRD2t4JPQmmg
 cwQxEACMzALPG/T+PncB64P0kNEf+IY63yc0VhVvI0PXPQp127tn548KpY8nERm1cBXupjw90MC
 h7B9K49z2SFR/LwHjQ4RAMIWwfsrd7n2j6qEOSJUYeM4dDFY1vLeCRw3xrCpOKvlLPXDjtNtno5
 qbhBrlIoHVCn8+x2vtYz7Sf4OSNgtJKRHBCWBK4zVMZatOdExBOfDyrct4OP0k3ha53nUEKWrb4
 q6bjln/Vv2pJk3dWJQBM6VD44WlTV6Uo8JiS0AzwxLtZVeXqgQleSV74TK5te6lpuPJh0e8AhL/
 eZ5Rcf8rb0MxXmsIY7leF4CRZ0lGHUoAy09yr2u3raAmHnuoY9XIhZiBRiUn5GRbKLR/zCNdPjN
 FNMSY+4kb7C6h+8+jwbawL7TJTnB9umOZPVkkNPA3o0GD9Ts2MzPO1XbfbdVWC0T36o7go385pR
 Qb3nE4iL2X6HvJ60lBCuY26shuXXDkM5Z/FhEdTA5ucyWK36XF9498MKxQYPNR0sfdHEyVvI895
 hYmhc/dMzoz0TJaQtftOdhasvLwaszzNpx9Dd5IgeU3FYwQuTq3bJGLK8IxmkS5ncvgRRd2vuSm
 RyUZ6BfFNvMYQqy1N3kdZnaapbubZ62WjNrDc3tL2ahKpFbYG9POKyuGIDUKkmhmM4wXCbLIgys
 cW5s4xoqnv7zONQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This reverts commit 8e15605be8baeb9e3957c268c7d6f901c327ad5c which
includes:

  d9bc0d11e33b fs/9p: Consolidate file operations and add readahead and writeback
  740b8bf87322 fs/9p: Remove unnecessary superblock flags
  8142db4f2792 fs/9p: allow disable of xattr support on mount
  46c30cb8f539 9p: Add additional debug flags and open modes
  6deffc8924b5 fs/9p: Add new mount modes
  1543b4c5071c fs/9p: remove writeback fid and fix per-file modes
  4eb3117888a9 fs/9p: Rework cache modes and add new options to Documentation
  21e26d5e54ab fs/9p: Fix bit operation logic error

These modifications and mainly the first one with commit d9bc0d11e33b
("fs/9p: Consolidate file operations and add readahead and writeback")
seem to cause instabilities in MPTCP tests, see the linked ticket for
more details.

As a temporarily solution, these modifications are reverted here.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/400
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 Documentation/filesystems/9p.rst |  50 +++-------
 fs/9p/cache.h                    |   3 +-
 fs/9p/fid.c                      |  48 +++++----
 fs/9p/fid.h                      |  31 +-----
 fs/9p/v9fs.c                     |  59 ++++++-----
 fs/9p/v9fs.h                     |  62 ++++--------
 fs/9p/v9fs_vfs.h                 |   4 +
 fs/9p/vfs_addr.c                 |  50 +++++-----
 fs/9p/vfs_dir.c                  |  10 +-
 fs/9p/vfs_file.c                 | 206 +++++++++++++++++++++++++++++++--------
 fs/9p/vfs_inode.c                | 111 ++++++++++-----------
 fs/9p/vfs_inode_dotl.c           |  90 ++++++++---------
 fs/9p/vfs_super.c                |  42 +++++---
 include/net/9p/9p.h              |   6 --
 net/9p/client.c                  |   8 +-
 15 files changed, 414 insertions(+), 366 deletions(-)

diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesystems/9p.rst
index 1b5f0cc3e4ca..7b5964bc8865 100644
--- a/Documentation/filesystems/9p.rst
+++ b/Documentation/filesystems/9p.rst
@@ -78,39 +78,19 @@ Options
   		offering several exported file systems.
 
   cache=mode	specifies a caching policy.  By default, no caches are used.
-		The mode can be specified as a bitmask or by using one of the
-		prexisting common 'shortcuts'.
-		The bitmask is described below: (unspecified bits are reserved)
 
-			==========  ====================================================
-			0b00000000  all caches disabled, mmap disabled
-			0b00000001  file caches enabled
-			0b00000010  meta-data caches enabled
-			0b00000100  writeback behavior (as opposed to writethrough)
-			0b00001000  loose caches (no explicit consistency with server)
-			0b10000000  fscache enabled for persistent caching
-			==========  ====================================================
-
-		The current shortcuts and their associated bitmask are:
-
-			=========   ====================================================
-			none        0b00000000 (no caching)
-			readahead   0b00000001 (only read-ahead file caching)
-			mmap        0b00000101 (read-ahead + writeback file cache)
-			loose       0b00001111 (non-coherent file and meta-data caches)
-			fscache     0b10001111 (persistent loose cache)
-			=========   ====================================================
-
-		NOTE: only these shortcuts are tested modes of operation at the
-		moment, so using other combinations of bit-patterns is not
-		known to work.  Work on better cache support is in progress.
-
-		IMPORTANT: loose caches (and by extension at the moment fscache)
-		do not necessarily validate cached values on the server.  In other
-		words changes on the server are not guaranteed to be reflected
-		on the client system.  Only use this mode of operation if you
-		have an exclusive mount and the server will modify the filesystem
-		underneath you.
+                        none
+				default no cache policy, metadata and data
+                                alike are synchronous.
+			loose
+				no attempts are made at consistency,
+                                intended for exclusive, read-only mounts
+                        fscache
+				use FS-Cache for a persistent, read-only
+				cache backend.
+                        mmap
+				minimal cache that is only used for read-write
+                                mmap.  Northing else is cached, like cache=none
 
   debug=n	specifies debug level.  The debug level is a bitmask.
 
@@ -157,12 +137,6 @@ Options
   		This can be used to share devices/named pipes/sockets between
 		hosts.  This functionality will be expanded in later versions.
 
-  directio	bypass page cache on all read/write operations
-
-  ignoreqv	ignore qid.version==0 as a marker to ignore cache
-
-  noxattr	do not offer xattr functions on this mount.
-
   access	there are four access modes.
 			user
 				if a user tries to access a file on v9fs
diff --git a/fs/9p/cache.h b/fs/9p/cache.h
index ee1b6b06a2fd..1923affcdc62 100644
--- a/fs/9p/cache.h
+++ b/fs/9p/cache.h
@@ -8,9 +8,10 @@
 #ifndef _9P_CACHE_H
 #define _9P_CACHE_H
 
-#ifdef CONFIG_9P_FSCACHE
 #include <linux/fscache.h>
 
+#ifdef CONFIG_9P_FSCACHE
+
 extern int v9fs_cache_session_get_cookie(struct v9fs_session_info *v9ses,
 					  const char *dev_name);
 
diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index de009a33e0e2..805151114e96 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -41,24 +41,14 @@ void v9fs_fid_add(struct dentry *dentry, struct p9_fid **pfid)
 	*pfid = NULL;
 }
 
-static bool v9fs_is_writeable(int mode)
-{
-	if (mode & (P9_OWRITE|P9_ORDWR))
-		return true;
-	else
-		return false;
-}
-
 /**
  * v9fs_fid_find_inode - search for an open fid off of the inode list
  * @inode: return a fid pointing to a specific inode
- * @want_writeable: only consider fids which are writeable
  * @uid: return a fid belonging to the specified user
- * @any: ignore uid as a selection criteria
  *
  */
-struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
-	kuid_t uid, bool any)
+
+static struct p9_fid *v9fs_fid_find_inode(struct inode *inode, kuid_t uid)
 {
 	struct hlist_head *h;
 	struct p9_fid *fid, *ret = NULL;
@@ -68,12 +58,7 @@ struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
 	spin_lock(&inode->i_lock);
 	h = (struct hlist_head *)&inode->i_private;
 	hlist_for_each_entry(fid, h, ilist) {
-		if (any || uid_eq(fid->uid, uid)) {
-			if (want_writeable && !v9fs_is_writeable(fid->mode)) {
-				p9_debug(P9_DEBUG_VFS, " mode: %x not writeable?\n",
-							fid->mode);
-				continue;
-			}
+		if (uid_eq(fid->uid, uid)) {
 			p9_fid_get(fid);
 			ret = fid;
 			break;
@@ -133,7 +118,7 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		spin_unlock(&dentry->d_lock);
 	} else {
 		if (dentry->d_inode)
-			ret = v9fs_fid_find_inode(dentry->d_inode, false, uid, any);
+			ret = v9fs_fid_find_inode(dentry->d_inode, uid);
 	}
 
 	return ret;
@@ -314,3 +299,28 @@ struct p9_fid *v9fs_fid_lookup(struct dentry *dentry)
 	return v9fs_fid_lookup_with_uid(dentry, uid, any);
 }
 
+struct p9_fid *v9fs_writeback_fid(struct dentry *dentry)
+{
+	int err;
+	struct p9_fid *fid, *ofid;
+
+	ofid = v9fs_fid_lookup_with_uid(dentry, GLOBAL_ROOT_UID, 0);
+	fid = clone_fid(ofid);
+	if (IS_ERR(fid))
+		goto error_out;
+	p9_fid_put(ofid);
+	/*
+	 * writeback fid will only be used to write back the
+	 * dirty pages. We always request for the open fid in read-write
+	 * mode so that a partial page write which result in page
+	 * read can work.
+	 */
+	err = p9_client_open(fid, O_RDWR);
+	if (err < 0) {
+		p9_fid_put(fid);
+		fid = ERR_PTR(err);
+		goto error_out;
+	}
+error_out:
+	return fid;
+}
diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 0c51889a60b3..8a4e8cd12ca2 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -7,16 +7,14 @@
 #ifndef FS_9P_FID_H
 #define FS_9P_FID_H
 #include <linux/list.h>
-#include "v9fs.h"
 
-struct p9_fid *v9fs_fid_find_inode(struct inode *inode, bool want_writeable,
-	kuid_t uid, bool any);
 struct p9_fid *v9fs_fid_lookup(struct dentry *dentry);
 static inline struct p9_fid *v9fs_parent_fid(struct dentry *dentry)
 {
 	return v9fs_fid_lookup(dentry->d_parent);
 }
 void v9fs_fid_add(struct dentry *dentry, struct p9_fid **fid);
+struct p9_fid *v9fs_writeback_fid(struct dentry *dentry);
 void v9fs_open_fid_add(struct inode *inode, struct p9_fid **fid);
 static inline struct p9_fid *clone_fid(struct p9_fid *fid)
 {
@@ -34,31 +32,4 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
 	p9_fid_put(fid);
 	return nfid;
 }
-/**
- * v9fs_fid_addmodes - add cache flags to fid mode (for client use only)
- * @fid: fid to augment
- * @s_flags: session info mount flags
- * @s_cache: session info cache flags
- * @f_flags: unix open flags
- *
- * make sure mode reflects flags of underlying mounts
- * also qid.version == 0 reflects a synthetic or legacy file system
- * NOTE: these are set after open so only reflect 9p client not
- * underlying file system on server.
- */
-static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
-	int s_cache, unsigned int f_flags)
-{
-	if (fid->qid.type != P9_QTFILE)
-		return;
-
-	if ((!s_cache) ||
-	   ((fid->qid.version == 0) && !(s_flags & V9FS_IGNORE_QV)) ||
-	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
-		fid->mode |= P9L_DIRECT; /* no read or write cache */
-	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
-				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
-		fid->mode |= P9L_NOWRITECACHE;
-	}
-}
 #endif
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index c7f774fe398f..61a51b90600d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -38,7 +38,9 @@ enum {
 	/* String options */
 	Opt_uname, Opt_remotename, Opt_cache, Opt_cachetag,
 	/* Options that take no arguments */
-	Opt_nodevmap, Opt_noxattr, Opt_directio, Opt_ignoreqv,
+	Opt_nodevmap,
+	/* Cache options */
+	Opt_cache_loose, Opt_fscache, Opt_mmap,
 	/* Access options */
 	Opt_access, Opt_posixacl,
 	/* Lock timeout option */
@@ -55,10 +57,10 @@ static const match_table_t tokens = {
 	{Opt_uname, "uname=%s"},
 	{Opt_remotename, "aname=%s"},
 	{Opt_nodevmap, "nodevmap"},
-	{Opt_noxattr, "noxattr"},
-	{Opt_directio, "directio"},
-	{Opt_ignoreqv, "ignoreqv"},
 	{Opt_cache, "cache=%s"},
+	{Opt_cache_loose, "loose"},
+	{Opt_fscache, "fscache"},
+	{Opt_mmap, "mmap"},
 	{Opt_cachetag, "cachetag=%s"},
 	{Opt_access, "access=%s"},
 	{Opt_posixacl, "posixacl"},
@@ -66,30 +68,32 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
+static const char *const v9fs_cache_modes[nr__p9_cache_modes] = {
+	[CACHE_NONE]	= "none",
+	[CACHE_MMAP]	= "mmap",
+	[CACHE_LOOSE]	= "loose",
+	[CACHE_FSCACHE]	= "fscache",
+};
+
 /* Interpret mount options for cache mode */
 static int get_cache_mode(char *s)
 {
 	int version = -EINVAL;
 
 	if (!strcmp(s, "loose")) {
-		version = CACHE_SC_LOOSE;
+		version = CACHE_LOOSE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: loose\n");
 	} else if (!strcmp(s, "fscache")) {
-		version = CACHE_SC_FSCACHE;
+		version = CACHE_FSCACHE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: fscache\n");
 	} else if (!strcmp(s, "mmap")) {
-		version = CACHE_SC_MMAP;
+		version = CACHE_MMAP;
 		p9_debug(P9_DEBUG_9P, "Cache mode: mmap\n");
-	} else if (!strcmp(s, "readahead")) {
-		version = CACHE_SC_READAHEAD;
-		p9_debug(P9_DEBUG_9P, "Cache mode: readahead\n");
 	} else if (!strcmp(s, "none")) {
-		version = CACHE_SC_NONE;
+		version = CACHE_NONE;
 		p9_debug(P9_DEBUG_9P, "Cache mode: none\n");
-	} else if (kstrtoint(s, 0, &version) != 0) {
-		version = -EINVAL;
-		pr_info("Unknown Cache mode or invalid value %s\n", s);
-	}
+	} else
+		pr_info("Unknown Cache mode %s\n", s);
 	return version;
 }
 
@@ -117,9 +121,9 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 	if (v9ses->nodev)
 		seq_puts(m, ",nodevmap");
 	if (v9ses->cache)
-		seq_printf(m, ",cache=%x", v9ses->cache);
+		seq_printf(m, ",%s", v9fs_cache_modes[v9ses->cache]);
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cachetag && (v9ses->cache & CACHE_FSCACHE))
+	if (v9ses->cachetag && v9ses->cache == CACHE_FSCACHE)
 		seq_printf(m, ",cachetag=%s", v9ses->cachetag);
 #endif
 
@@ -139,16 +143,9 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 		break;
 	}
 
-	if (v9ses->flags & V9FS_IGNORE_QV)
-		seq_puts(m, ",ignoreqv");
-	if (v9ses->flags & V9FS_DIRECT_IO)
-		seq_puts(m, ",directio");
 	if (v9ses->flags & V9FS_POSIX_ACL)
 		seq_puts(m, ",posixacl");
 
-	if (v9ses->flags & V9FS_NO_XATTR)
-		seq_puts(m, ",noxattr");
-
 	return p9_show_client_options(m, v9ses->clnt);
 }
 
@@ -269,14 +266,14 @@ static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
 		case Opt_nodevmap:
 			v9ses->nodev = 1;
 			break;
-		case Opt_noxattr:
-			v9ses->flags |= V9FS_NO_XATTR;
+		case Opt_cache_loose:
+			v9ses->cache = CACHE_LOOSE;
 			break;
-		case Opt_directio:
-			v9ses->flags |= V9FS_DIRECT_IO;
+		case Opt_fscache:
+			v9ses->cache = CACHE_FSCACHE;
 			break;
-		case Opt_ignoreqv:
-			v9ses->flags |= V9FS_IGNORE_QV;
+		case Opt_mmap:
+			v9ses->cache = CACHE_MMAP;
 			break;
 		case Opt_cachetag:
 #ifdef CONFIG_9P_FSCACHE
@@ -471,7 +468,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 
 #ifdef CONFIG_9P_FSCACHE
 	/* register the session for caching */
-	if (v9ses->cache & CACHE_FSCACHE) {
+	if (v9ses->cache == CACHE_FSCACHE) {
 		rc = v9fs_cache_session_get_cookie(v9ses, dev_name);
 		if (rc < 0)
 			goto err_clnt;
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 06a2514f0d88..f3f74d197b5d 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -31,54 +31,29 @@
 #define V9FS_ACL_MASK V9FS_POSIX_ACL
 
 enum p9_session_flags {
-	V9FS_PROTO_2000U    = 0x01,
-	V9FS_PROTO_2000L    = 0x02,
-	V9FS_ACCESS_SINGLE  = 0x04,
-	V9FS_ACCESS_USER    = 0x08,
-	V9FS_ACCESS_CLIENT  = 0x10,
-	V9FS_POSIX_ACL      = 0x20,
-	V9FS_NO_XATTR       = 0x40,
-	V9FS_IGNORE_QV      = 0x80, /* ignore qid.version for cache hints */
-	V9FS_DIRECT_IO      = 0x100,
-	V9FS_SYNC           = 0x200
+	V9FS_PROTO_2000U	= 0x01,
+	V9FS_PROTO_2000L	= 0x02,
+	V9FS_ACCESS_SINGLE	= 0x04,
+	V9FS_ACCESS_USER	= 0x08,
+	V9FS_ACCESS_CLIENT	= 0x10,
+	V9FS_POSIX_ACL		= 0x20
 };
 
+/* possible values of ->cache */
 /**
- * enum p9_cache_shortcuts - human readable cache preferences
- * @CACHE_SC_NONE: disable all caches
- * @CACHE_SC_READAHEAD: only provide caching for readahead
- * @CACHE_SC_MMAP: provide caching to enable mmap
- * @CACHE_SC_LOOSE: non-coherent caching for files and meta data
- * @CACHE_SC_FSCACHE: persistent non-coherent caching for files and meta-data
+ * enum p9_cache_modes - user specified cache preferences
+ * @CACHE_NONE: do not cache data, dentries, or directory contents (default)
+ * @CACHE_LOOSE: cache data, dentries, and directory contents w/no consistency
  *
+ * eventually support loose, tight, time, session, default always none
  */
 
-enum p9_cache_shortcuts {
-	CACHE_SC_NONE       = 0b00000000,
-	CACHE_SC_READAHEAD  = 0b00000001,
-	CACHE_SC_MMAP       = 0b00000101,
-	CACHE_SC_LOOSE      = 0b00001111,
-	CACHE_SC_FSCACHE    = 0b10001111,
-};
-
-/**
- * enum p9_cache_bits - possible values of ->cache
- * @CACHE_NONE: caches disabled
- * @CACHE_FILE: file caching (open to close)
- * @CACHE_META: meta-data and directory caching
- * @CACHE_WRITEBACK: write-back caching for files
- * @CACHE_LOOSE: don't check cache consistency
- * @CACHE_FSCACHE: local persistent caches
- *
- */
-
-enum p9_cache_bits {
-	CACHE_NONE          = 0b00000000,
-	CACHE_FILE          = 0b00000001,
-	CACHE_META          = 0b00000010,
-	CACHE_WRITEBACK     = 0b00000100,
-	CACHE_LOOSE         = 0b00001000,
-	CACHE_FSCACHE       = 0b10000000,
+enum p9_cache_modes {
+	CACHE_NONE,
+	CACHE_MMAP,
+	CACHE_LOOSE,
+	CACHE_FSCACHE,
+	nr__p9_cache_modes
 };
 
 /**
@@ -87,7 +62,7 @@ enum p9_cache_bits {
  * @nodev: set to 1 to disable device mapping
  * @debug: debug level
  * @afid: authentication handle
- * @cache: cache mode of type &p9_cache_bits
+ * @cache: cache mode of type &p9_cache_modes
  * @cachetag: the tag of the cache associated with this session
  * @fscache: session cookie associated with FS-Cache
  * @uname: string user name to mount hierarchy as
@@ -137,6 +112,7 @@ struct v9fs_inode {
 	struct netfs_inode netfs; /* Netfslib context and vfs inode */
 	struct p9_qid qid;
 	unsigned int cache_validity;
+	struct p9_fid *writeback_fid;
 	struct mutex v_mutex;
 };
 
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index cdf441f22e07..75106b9f293d 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -36,6 +36,10 @@ extern const struct file_operations v9fs_dir_operations;
 extern const struct file_operations v9fs_dir_operations_dotl;
 extern const struct dentry_operations v9fs_dentry_operations;
 extern const struct dentry_operations v9fs_cached_dentry_operations;
+extern const struct file_operations v9fs_cached_file_operations;
+extern const struct file_operations v9fs_cached_file_operations_dotl;
+extern const struct file_operations v9fs_mmap_file_operations;
+extern const struct file_operations v9fs_mmap_file_operations_dotl;
 extern struct kmem_cache *v9fs_inode_cache;
 
 struct inode *v9fs_alloc_inode(struct super_block *sb);
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 8a635999a7d6..425956eb9fde 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -56,6 +56,8 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
  */
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	struct inode *inode = file_inode(file);
+	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct p9_fid *fid = file->private_data;
 
 	BUG_ON(!fid);
@@ -63,8 +65,11 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 	/* we might need to read from a fid that was opened write-only
 	 * for read-modify-write of page cache, use the writeback fid
 	 * for that */
-	WARN_ON(rreq->origin == NETFS_READ_FOR_WRITE &&
-			!(fid->mode & P9_ORDWR));
+	if (rreq->origin == NETFS_READ_FOR_WRITE &&
+			(fid->mode & O_ACCMODE) == O_WRONLY) {
+		fid = v9inode->writeback_fid;
+		BUG_ON(!fid);
+	}
 
 	p9_fid_get(fid);
 	rreq->netfs_priv = fid;
@@ -114,6 +119,8 @@ const struct netfs_request_ops v9fs_req_ops = {
 
 static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
 {
+	struct inode *inode = folio_inode(folio);
+
 	if (folio_test_private(folio))
 		return false;
 #ifdef CONFIG_9P_FSCACHE
@@ -122,8 +129,8 @@ static bool v9fs_release_folio(struct folio *folio, gfp_t gfp)
 			return false;
 		folio_wait_fscache(folio);
 	}
-	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(folio_inode(folio))));
 #endif
+	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(inode)));
 	return true;
 }
 
@@ -133,7 +140,6 @@ static void v9fs_invalidate_folio(struct folio *folio, size_t offset,
 	folio_wait_fscache(folio);
 }
 
-#ifdef CONFIG_9P_FSCACHE
 static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
 				     bool was_async)
 {
@@ -147,19 +153,17 @@ static void v9fs_write_to_cache_done(void *priv, ssize_t transferred_or_error,
 				   i_size_read(&v9inode->netfs.inode), 0);
 	}
 }
-#endif
 
 static int v9fs_vfs_write_folio_locked(struct folio *folio)
 {
 	struct inode *inode = folio_inode(folio);
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	struct fscache_cookie *cookie = v9fs_inode_cookie(v9inode);
 	loff_t start = folio_pos(folio);
 	loff_t i_size = i_size_read(inode);
 	struct iov_iter from;
 	size_t len = folio_size(folio);
-	struct p9_fid *writeback_fid;
 	int err;
-	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
-	struct fscache_cookie __maybe_unused *cookie = v9fs_inode_cookie(v9inode);
 
 	if (start >= i_size)
 		return 0; /* Simultaneous truncation occurred */
@@ -168,33 +172,25 @@ static int v9fs_vfs_write_folio_locked(struct folio *folio)
 
 	iov_iter_xarray(&from, ITER_SOURCE, &folio_mapping(folio)->i_pages, start, len);
 
-	writeback_fid = v9fs_fid_find_inode(inode, true, INVALID_UID, true);
-	if (!writeback_fid) {
-		WARN_ONCE(1, "folio expected an open fid inode->i_private=%p\n",
-			inode->i_private);
-		return -EINVAL;
-	}
+	/* We should have writeback_fid always set */
+	BUG_ON(!v9inode->writeback_fid);
 
 	folio_wait_fscache(folio);
 	folio_start_writeback(folio);
 
-	p9_client_write(writeback_fid, start, &from, &err);
+	p9_client_write(v9inode->writeback_fid, start, &from, &err);
 
-#ifdef CONFIG_9P_FSCACHE
 	if (err == 0 &&
-		fscache_cookie_enabled(cookie) &&
-		test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
+	    fscache_cookie_enabled(cookie) &&
+	    test_bit(FSCACHE_COOKIE_IS_CACHING, &cookie->flags)) {
 		folio_start_fscache(folio);
 		fscache_write_to_cache(v9fs_inode_cookie(v9inode),
-					folio_mapping(folio), start, len, i_size,
-					v9fs_write_to_cache_done, v9inode,
-					true);
+				       folio_mapping(folio), start, len, i_size,
+				       v9fs_write_to_cache_done, v9inode,
+				       true);
 	}
-#endif
 
 	folio_end_writeback(folio);
-	p9_fid_put(writeback_fid);
-
 	return err;
 }
 
@@ -301,6 +297,7 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	loff_t last_pos = pos + copied;
 	struct folio *folio = page_folio(subpage);
 	struct inode *inode = mapping->host;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
 
 	p9_debug(P9_DEBUG_VFS, "filp %p, mapping %p\n", filp, mapping);
 
@@ -320,10 +317,7 @@ static int v9fs_write_end(struct file *filp, struct address_space *mapping,
 	if (last_pos > inode->i_size) {
 		inode_add_bytes(inode, last_pos - inode->i_size);
 		i_size_write(inode, last_pos);
-#ifdef CONFIG_9P_FSCACHE
-		fscache_update_cookie(v9fs_inode_cookie(V9FS_I(inode)), NULL,
-			&last_pos);
-#endif
+		fscache_update_cookie(v9fs_inode_cookie(v9inode), NULL, &last_pos);
 	}
 	folio_mark_dirty(folio);
 out:
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 45b684b7d8d7..52bf87934650 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -196,9 +196,9 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 
 /**
- * v9fs_dir_release - close a directory or a file
- * @inode: inode of the directory or file
- * @filp: file pointer to a directory or file
+ * v9fs_dir_release - called on a close of a file or directory
+ * @inode: inode of the directory
+ * @filp: file pointer to a directory
  *
  */
 
@@ -213,11 +213,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
 		 inode, filp, fid ? fid->fid : -1);
-
 	if (fid) {
-		if ((S_ISREG(inode->i_mode)) && (filp->f_mode & FMODE_WRITE))
-			retval = filemap_fdatawrite(inode->i_mapping);
-
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 6c31b8c8112d..367a851eaa82 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -28,6 +28,7 @@
 #include "fid.h"
 #include "cache.h"
 
+static const struct vm_operations_struct v9fs_file_vm_ops;
 static const struct vm_operations_struct v9fs_mmap_file_vm_ops;
 
 /**
@@ -40,11 +41,13 @@ static const struct vm_operations_struct v9fs_mmap_file_vm_ops;
 int v9fs_file_open(struct inode *inode, struct file *file)
 {
 	int err;
+	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid;
+	struct p9_fid *fid, *writeback_fid;
 	int omode;
 
 	p9_debug(P9_DEBUG_VFS, "inode: %p file: %p\n", inode, file);
+	v9inode = V9FS_I(inode);
 	v9ses = v9fs_inode2v9ses(inode);
 	if (v9fs_proto_dotl(v9ses))
 		omode = v9fs_open_to_dotl_flags(file->f_flags);
@@ -57,19 +60,7 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		if (IS_ERR(fid))
 			return PTR_ERR(fid);
 
-		if ((v9ses->cache & CACHE_WRITEBACK) && (omode & P9_OWRITE)) {
-			int writeback_omode = (omode & ~P9_OWRITE) | P9_ORDWR;
-
-			p9_debug(P9_DEBUG_CACHE, "write-only file with writeback enabled, try opening O_RDWR\n");
-			err = p9_client_open(fid, writeback_omode);
-			if (err < 0) {
-				p9_debug(P9_DEBUG_CACHE, "could not open O_RDWR, disabling caches\n");
-				err = p9_client_open(fid, omode);
-				fid->mode |= P9L_DIRECT;
-			}
-		} else {
-			err = p9_client_open(fid, omode);
-		}
+		err = p9_client_open(fid, omode);
 		if (err < 0) {
 			p9_fid_put(fid);
 			return err;
@@ -81,14 +72,36 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		file->private_data = fid;
 	}
 
+	mutex_lock(&v9inode->v_mutex);
+	if ((v9ses->cache) && !v9inode->writeback_fid &&
+	    ((file->f_flags & O_ACCMODE) != O_RDONLY)) {
+		/*
+		 * clone a fid and add it to writeback_fid
+		 * we do it during open time instead of
+		 * page dirty time via write_begin/page_mkwrite
+		 * because we want write after unlink usecase
+		 * to work.
+		 */
+		writeback_fid = v9fs_writeback_fid(file_dentry(file));
+		if (IS_ERR(writeback_fid)) {
+			err = PTR_ERR(writeback_fid);
+			mutex_unlock(&v9inode->v_mutex);
+			goto out_error;
+		}
+		v9inode->writeback_fid = (void *) writeback_fid;
+	}
+	mutex_unlock(&v9inode->v_mutex);
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cache & CACHE_FSCACHE)
-		fscache_use_cookie(v9fs_inode_cookie(V9FS_I(inode)),
+	if (v9ses->cache == CACHE_FSCACHE)
+		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
 #endif
-	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
 	v9fs_open_fid_add(inode, &fid);
 	return 0;
+out_error:
+	p9_fid_put(file->private_data);
+	file->private_data = NULL;
+	return err;
 }
 
 /**
@@ -355,13 +368,8 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct p9_fid *fid = iocb->ki_filp->private_data;
 	int ret, err = 0;
 
-	p9_debug(P9_DEBUG_VFS, "fid %d count %zu offset %lld\n",
-		 fid->fid, iov_iter_count(to), iocb->ki_pos);
-
-	if (!(fid->mode & P9L_DIRECT)) {
-		p9_debug(P9_DEBUG_VFS, "(cached)\n");
-		return generic_file_read_iter(iocb, to);
-	}
+	p9_debug(P9_DEBUG_VFS, "count %zu offset %lld\n",
+		 iov_iter_count(to), iocb->ki_pos);
 
 	if (iocb->ki_filp->f_flags & O_NONBLOCK)
 		ret = p9_client_read_once(fid, iocb->ki_pos, to, &err);
@@ -384,18 +392,10 @@ static ssize_t
 v9fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct p9_fid *fid = file->private_data;
 	ssize_t retval;
 	loff_t origin;
 	int err = 0;
 
-	p9_debug(P9_DEBUG_VFS, "fid %d\n", fid->fid);
-
-	if (!(fid->mode & (P9L_DIRECT | P9L_NOWRITECACHE))) {
-		p9_debug(P9_DEBUG_CACHE, "(cached)\n");
-		return generic_file_write_iter(iocb, from);
-	}
-
 	retval = generic_write_checks(iocb, from);
 	if (retval <= 0)
 		return retval;
@@ -477,18 +477,45 @@ static int
 v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	int retval;
-	struct inode *inode = file_inode(filp);
-	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 
-	p9_debug(P9_DEBUG_MMAP, "filp :%p\n", filp);
 
-	if (!(v9ses->cache & CACHE_WRITEBACK)) {
-		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
-		if (vma->vm_flags & VM_MAYSHARE)
-			return -ENODEV;
-		invalidate_inode_pages2(filp->f_mapping);
-		return generic_file_readonly_mmap(filp, vma);
+	retval = generic_file_mmap(filp, vma);
+	if (!retval)
+		vma->vm_ops = &v9fs_file_vm_ops;
+
+	return retval;
+}
+
+static int
+v9fs_mmap_file_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	int retval;
+	struct inode *inode;
+	struct v9fs_inode *v9inode;
+	struct p9_fid *fid;
+
+	inode = file_inode(filp);
+	v9inode = V9FS_I(inode);
+	mutex_lock(&v9inode->v_mutex);
+	if (!v9inode->writeback_fid &&
+	    (vma->vm_flags & VM_SHARED) &&
+	    (vma->vm_flags & VM_WRITE)) {
+		/*
+		 * clone a fid and add it to writeback_fid
+		 * we do it during mmap instead of
+		 * page dirty time via write_begin/page_mkwrite
+		 * because we want write after unlink usecase
+		 * to work.
+		 */
+		fid = v9fs_writeback_fid(file_dentry(filp));
+		if (IS_ERR(fid)) {
+			retval = PTR_ERR(fid);
+			mutex_unlock(&v9inode->v_mutex);
+			return retval;
+		}
+		v9inode->writeback_fid = (void *) fid;
 	}
+	mutex_unlock(&v9inode->v_mutex);
 
 	retval = generic_file_mmap(filp, vma);
 	if (!retval)
@@ -500,6 +527,7 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
 static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
+	struct v9fs_inode *v9inode;
 	struct folio *folio = page_folio(vmf->page);
 	struct file *filp = vmf->vma->vm_file;
 	struct inode *inode = file_inode(filp);
@@ -508,6 +536,8 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	p9_debug(P9_DEBUG_VFS, "folio %p fid %lx\n",
 		 folio, (unsigned long)filp->private_data);
 
+	v9inode = V9FS_I(inode);
+
 	/* Wait for the page to be written to the cache before we allow it to
 	 * be modified.  We then assume the entire page will need writing back.
 	 */
@@ -520,6 +550,7 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* Update file times before taking page lock */
 	file_update_time(filp);
 
+	BUG_ON(!v9inode->writeback_fid);
 	if (folio_lock_killable(folio) < 0)
 		return VM_FAULT_RETRY;
 	if (folio_mapping(folio) != inode->i_mapping)
@@ -532,6 +563,35 @@ v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 	return VM_FAULT_NOPAGE;
 }
 
+/**
+ * v9fs_mmap_file_read_iter - read from a file
+ * @iocb: The operation parameters
+ * @to: The buffer to read into
+ *
+ */
+static ssize_t
+v9fs_mmap_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	/* TODO: Check if there are dirty pages */
+	return v9fs_file_read_iter(iocb, to);
+}
+
+/**
+ * v9fs_mmap_file_write_iter - write to a file
+ * @iocb: The operation parameters
+ * @from: The data to write
+ *
+ */
+static ssize_t
+v9fs_mmap_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	/*
+	 * TODO: invalidate mmaps on filp's inode between
+	 * offset and offset+count
+	 */
+	return v9fs_file_write_iter(iocb, from);
+}
+
 static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 {
 	struct inode *inode;
@@ -554,6 +614,13 @@ static void v9fs_mmap_vm_close(struct vm_area_struct *vma)
 	filemap_fdatawrite_wbc(inode->i_mapping, &wbc);
 }
 
+
+static const struct vm_operations_struct v9fs_file_vm_ops = {
+	.fault = filemap_fault,
+	.map_pages = filemap_map_pages,
+	.page_mkwrite = v9fs_vm_page_mkwrite,
+};
+
 static const struct vm_operations_struct v9fs_mmap_file_vm_ops = {
 	.close = v9fs_mmap_vm_close,
 	.fault = filemap_fault,
@@ -561,6 +628,34 @@ static const struct vm_operations_struct v9fs_mmap_file_vm_ops = {
 	.page_mkwrite = v9fs_vm_page_mkwrite,
 };
 
+
+const struct file_operations v9fs_cached_file_operations = {
+	.llseek = generic_file_llseek,
+	.read_iter = generic_file_read_iter,
+	.write_iter = generic_file_write_iter,
+	.open = v9fs_file_open,
+	.release = v9fs_dir_release,
+	.lock = v9fs_file_lock,
+	.mmap = v9fs_file_mmap,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
+	.fsync = v9fs_file_fsync,
+};
+
+const struct file_operations v9fs_cached_file_operations_dotl = {
+	.llseek = generic_file_llseek,
+	.read_iter = generic_file_read_iter,
+	.write_iter = generic_file_write_iter,
+	.open = v9fs_file_open,
+	.release = v9fs_dir_release,
+	.lock = v9fs_file_lock_dotl,
+	.flock = v9fs_file_flock_dotl,
+	.mmap = v9fs_file_mmap,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
+	.fsync = v9fs_file_fsync_dotl,
+};
+
 const struct file_operations v9fs_file_operations = {
 	.llseek = generic_file_llseek,
 	.read_iter = v9fs_file_read_iter,
@@ -582,7 +677,34 @@ const struct file_operations v9fs_file_operations_dotl = {
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock_dotl,
 	.flock = v9fs_file_flock_dotl,
-	.mmap = v9fs_file_mmap,
+	.mmap = generic_file_readonly_mmap,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
+	.fsync = v9fs_file_fsync_dotl,
+};
+
+const struct file_operations v9fs_mmap_file_operations = {
+	.llseek = generic_file_llseek,
+	.read_iter = v9fs_mmap_file_read_iter,
+	.write_iter = v9fs_mmap_file_write_iter,
+	.open = v9fs_file_open,
+	.release = v9fs_dir_release,
+	.lock = v9fs_file_lock,
+	.mmap = v9fs_mmap_file_mmap,
+	.splice_read = generic_file_splice_read,
+	.splice_write = iter_file_splice_write,
+	.fsync = v9fs_file_fsync,
+};
+
+const struct file_operations v9fs_mmap_file_operations_dotl = {
+	.llseek = generic_file_llseek,
+	.read_iter = v9fs_mmap_file_read_iter,
+	.write_iter = v9fs_mmap_file_write_iter,
+	.open = v9fs_file_open,
+	.release = v9fs_dir_release,
+	.lock = v9fs_file_lock_dotl,
+	.flock = v9fs_file_flock_dotl,
+	.mmap = v9fs_mmap_file_mmap,
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 36b466e35887..502ac74e4959 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -229,6 +229,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb)
 	v9inode = alloc_inode_sb(sb, v9fs_inode_cache, GFP_KERNEL);
 	if (!v9inode)
 		return NULL;
+	v9inode->writeback_fid = NULL;
 	v9inode->cache_validity = 0;
 	mutex_init(&v9inode->v_mutex);
 	return &v9inode->netfs.inode;
@@ -285,10 +286,24 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 	case S_IFREG:
 		if (v9fs_proto_dotl(v9ses)) {
 			inode->i_op = &v9fs_file_inode_operations_dotl;
-			inode->i_fop = &v9fs_file_operations_dotl;
+			if (v9ses->cache == CACHE_LOOSE ||
+			    v9ses->cache == CACHE_FSCACHE)
+				inode->i_fop =
+					&v9fs_cached_file_operations_dotl;
+			else if (v9ses->cache == CACHE_MMAP)
+				inode->i_fop = &v9fs_mmap_file_operations_dotl;
+			else
+				inode->i_fop = &v9fs_file_operations_dotl;
 		} else {
 			inode->i_op = &v9fs_file_inode_operations;
-			inode->i_fop = &v9fs_file_operations;
+			if (v9ses->cache == CACHE_LOOSE ||
+			    v9ses->cache == CACHE_FSCACHE)
+				inode->i_fop =
+					&v9fs_cached_file_operations;
+			else if (v9ses->cache == CACHE_MMAP)
+				inode->i_fop = &v9fs_mmap_file_operations;
+			else
+				inode->i_fop = &v9fs_file_operations;
 		}
 
 		break;
@@ -370,23 +385,20 @@ struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode, dev_t rdev)
  */
 void v9fs_evict_inode(struct inode *inode)
 {
-	struct v9fs_inode __maybe_unused *v9inode = V9FS_I(inode);
-	__le32 __maybe_unused version;
+	struct v9fs_inode *v9inode = V9FS_I(inode);
+	__le32 version;
 
 	truncate_inode_pages_final(&inode->i_data);
-
-#ifdef CONFIG_9P_FSCACHE
 	version = cpu_to_le32(v9inode->qid.version);
 	fscache_clear_inode_writeback(v9fs_inode_cookie(v9inode), inode,
 				      &version);
-#endif
-
 	clear_inode(inode);
 	filemap_fdatawrite(&inode->i_data);
 
-#ifdef CONFIG_9P_FSCACHE
 	fscache_relinquish_cookie(v9fs_inode_cookie(v9inode), false);
-#endif
+	/* clunk the fid stashed in writeback_fid */
+	p9_fid_put(v9inode->writeback_fid);
+	v9inode->writeback_fid = NULL;
 }
 
 static int v9fs_test_inode(struct inode *inode, void *data)
@@ -766,7 +778,7 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 		inode = NULL;
 	else if (IS_ERR(fid))
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	else if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
 	else
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
@@ -795,12 +807,11 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	int err;
 	u32 perm;
-	struct v9fs_inode __maybe_unused *v9inode;
+	struct v9fs_inode *v9inode;
 	struct v9fs_session_info *v9ses;
-	struct p9_fid *fid;
+	struct p9_fid *fid, *inode_fid;
 	struct dentry *res = NULL;
 	struct inode *inode;
-	int p9_omode;
 
 	if (d_in_lookup(dentry)) {
 		res = v9fs_vfs_lookup(dir, dentry, 0);
@@ -819,14 +830,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 
 	v9ses = v9fs_inode2v9ses(dir);
 	perm = unixmode2p9mode(v9ses, mode);
-	p9_omode = v9fs_uflags2omode(flags, v9fs_proto_dotu(v9ses));
-
-	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
-		p9_debug(P9_DEBUG_CACHE,
-			"write-only file with writeback enabled, creating w/ O_RDWR\n");
-	}
-	fid = v9fs_create(v9ses, dir, dentry, NULL, perm, p9_omode);
+	fid = v9fs_create(v9ses, dir, dentry, NULL, perm,
+				v9fs_uflags2omode(flags,
+						v9fs_proto_dotu(v9ses)));
 	if (IS_ERR(fid)) {
 		err = PTR_ERR(fid);
 		goto error;
@@ -835,18 +841,33 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	v9fs_invalidate_inode_attr(dir);
 	inode = d_inode(dentry);
 	v9inode = V9FS_I(inode);
+	mutex_lock(&v9inode->v_mutex);
+	if ((v9ses->cache) && !v9inode->writeback_fid &&
+	    ((flags & O_ACCMODE) != O_RDONLY)) {
+		/*
+		 * clone a fid and add it to writeback_fid
+		 * we do it during open time instead of
+		 * page dirty time via write_begin/page_mkwrite
+		 * because we want write after unlink usecase
+		 * to work.
+		 */
+		inode_fid = v9fs_writeback_fid(dentry);
+		if (IS_ERR(inode_fid)) {
+			err = PTR_ERR(inode_fid);
+			mutex_unlock(&v9inode->v_mutex);
+			goto error;
+		}
+		v9inode->writeback_fid = (void *) inode_fid;
+	}
+	mutex_unlock(&v9inode->v_mutex);
 	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto error;
 
 	file->private_data = fid;
-#ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cache & CACHE_FSCACHE)
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
-#endif
-
-	v9fs_fid_add_modes(fid, v9ses->flags, v9ses->cache, file->f_flags);
 	v9fs_open_fid_add(inode, &fid);
 
 	file->f_mode |= FMODE_CREATED;
@@ -1008,24 +1029,15 @@ v9fs_vfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		 struct kstat *stat, u32 request_mask, unsigned int flags)
 {
 	struct dentry *dentry = path->dentry;
-	struct inode *inode = d_inode(dentry);
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
 	struct p9_wstat *st;
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		generic_fillattr(&nop_mnt_idmap, inode, stat);
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 		return 0;
-	} else if (v9ses->cache & CACHE_WRITEBACK) {
-		if (S_ISREG(inode->i_mode)) {
-			int retval = filemap_fdatawrite(inode->i_mapping);
-
-			if (retval)
-				p9_debug(P9_DEBUG_ERROR,
-				    "flushing writeback during getattr returned %d\n", retval);
-		}
 	}
 	fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
@@ -1057,6 +1069,7 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 {
 	int retval, use_dentry = 0;
 	struct inode *inode = d_inode(dentry);
+	struct v9fs_inode *v9inode = V9FS_I(inode);
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid = NULL;
 	struct p9_wstat wstat;
@@ -1101,12 +1114,8 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 	}
 
 	/* Write all dirty data */
-	if (d_is_reg(dentry)) {
-		retval = filemap_fdatawrite(inode->i_mapping);
-		if (retval)
-			p9_debug(P9_DEBUG_ERROR,
-			    "flushing writeback during setattr returned %d\n", retval);
-	}
+	if (d_is_reg(dentry))
+		filemap_write_and_wait(inode->i_mapping);
 
 	retval = p9_client_wstat(fid, &wstat);
 
@@ -1117,17 +1126,9 @@ static int v9fs_vfs_setattr(struct mnt_idmap *idmap,
 		return retval;
 
 	if ((iattr->ia_valid & ATTR_SIZE) &&
-		 iattr->ia_size != i_size_read(inode)) {
+	    iattr->ia_size != i_size_read(inode)) {
 		truncate_setsize(inode, iattr->ia_size);
-		truncate_pagecache(inode, iattr->ia_size);
-
-#ifdef CONFIG_9P_FSCACHE
-		if (v9ses->cache & CACHE_FSCACHE) {
-			struct v9fs_inode *v9inode = V9FS_I(inode);
-
-			fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
-		}
-#endif
+		fscache_resize_cookie(v9fs_inode_cookie(v9inode), iattr->ia_size);
 	}
 
 	v9fs_invalidate_inode_attr(inode);
@@ -1411,7 +1412,7 @@ int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
 	 * We don't want to refresh inode->i_size,
 	 * because we may have cached data
 	 */
-	flags = (v9ses->cache & CACHE_LOOSE) ?
+	flags = (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) ?
 		V9FS_STAT2INODE_KEEP_ISIZE : 0;
 	v9fs_stat2inode(st, inode, inode->i_sb, flags);
 out:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 5361cd2d7996..a7da49906d99 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -231,12 +231,12 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	int err = 0;
 	kgid_t gid;
 	umode_t mode;
-	int p9_omode = v9fs_open_to_dotl_flags(flags);
 	const unsigned char *name = NULL;
 	struct p9_qid qid;
 	struct inode *inode;
 	struct p9_fid *fid = NULL;
-	struct p9_fid *dfid = NULL, *ofid = NULL;
+	struct v9fs_inode *v9inode;
+	struct p9_fid *dfid = NULL, *ofid = NULL, *inode_fid = NULL;
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 	struct dentry *res = NULL;
@@ -281,19 +281,14 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	/* Update mode based on ACL value */
 	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
 	if (err) {
-		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in create %d\n",
+		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in creat %d\n",
 			 err);
 		goto out;
 	}
-
-	if ((v9ses->cache & CACHE_WRITEBACK) && (p9_omode & P9_OWRITE)) {
-		p9_omode = (p9_omode & ~P9_OWRITE) | P9_ORDWR;
-		p9_debug(P9_DEBUG_CACHE,
-			"write-only file with writeback enabled, creating w/ O_RDWR\n");
-	}
-	err = p9_client_create_dotl(ofid, name, p9_omode, mode, gid, &qid);
+	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
+				    mode, gid, &qid);
 	if (err < 0) {
-		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in create %d\n",
+		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
 			 err);
 		goto out;
 	}
@@ -318,19 +313,36 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	v9fs_fid_add(dentry, &fid);
 	d_instantiate(dentry, inode);
 
+	v9inode = V9FS_I(inode);
+	mutex_lock(&v9inode->v_mutex);
+	if ((v9ses->cache) && !v9inode->writeback_fid &&
+	    ((flags & O_ACCMODE) != O_RDONLY)) {
+		/*
+		 * clone a fid and add it to writeback_fid
+		 * we do it during open time instead of
+		 * page dirty time via write_begin/page_mkwrite
+		 * because we want write after unlink usecase
+		 * to work.
+		 */
+		inode_fid = v9fs_writeback_fid(dentry);
+		if (IS_ERR(inode_fid)) {
+			err = PTR_ERR(inode_fid);
+			mutex_unlock(&v9inode->v_mutex);
+			goto out;
+		}
+		v9inode->writeback_fid = (void *) inode_fid;
+	}
+	mutex_unlock(&v9inode->v_mutex);
 	/* Since we are opening a file, assign the open fid to the file */
 	err = finish_open(file, dentry, generic_file_open);
 	if (err)
 		goto out;
 	file->private_data = ofid;
 #ifdef CONFIG_9P_FSCACHE
-	if (v9ses->cache & CACHE_FSCACHE) {
-		struct v9fs_inode *v9inode = V9FS_I(inode);
+	if (v9ses->cache == CACHE_FSCACHE)
 		fscache_use_cookie(v9fs_inode_cookie(v9inode),
 				   file->f_mode & FMODE_WRITE);
-	}
 #endif
-	v9fs_fid_add_modes(ofid, v9ses->flags, v9ses->cache, flags);
 	v9fs_open_fid_add(inode, &ofid);
 	file->f_mode |= FMODE_CREATED;
 out:
@@ -402,7 +414,7 @@ static int v9fs_vfs_mkdir_dotl(struct mnt_idmap *idmap,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
@@ -445,22 +457,13 @@ v9fs_vfs_getattr_dotl(struct mnt_idmap *idmap,
 	struct dentry *dentry = path->dentry;
 	struct v9fs_session_info *v9ses;
 	struct p9_fid *fid;
-	struct inode *inode = d_inode(dentry);
 	struct p9_stat_dotl *st;
 
 	p9_debug(P9_DEBUG_VFS, "dentry: %p\n", dentry);
 	v9ses = v9fs_dentry2v9ses(dentry);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
-		generic_fillattr(&nop_mnt_idmap, inode, stat);
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
+		generic_fillattr(&nop_mnt_idmap, d_inode(dentry), stat);
 		return 0;
-	} else if (v9ses->cache) {
-		if (S_ISREG(inode->i_mode)) {
-			int retval = filemap_fdatawrite(inode->i_mapping);
-
-			if (retval)
-				p9_debug(P9_DEBUG_ERROR,
-				    "flushing writeback during getattr returned %d\n", retval);
-		}
 	}
 	fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
@@ -536,13 +539,12 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 			  struct dentry *dentry, struct iattr *iattr)
 {
 	int retval, use_dentry = 0;
-	struct inode *inode = d_inode(dentry);
-	struct v9fs_session_info __maybe_unused *v9ses;
 	struct p9_fid *fid = NULL;
 	struct p9_iattr_dotl p9attr = {
 		.uid = INVALID_UID,
 		.gid = INVALID_GID,
 	};
+	struct inode *inode = d_inode(dentry);
 
 	p9_debug(P9_DEBUG_VFS, "\n");
 
@@ -550,8 +552,6 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 	if (retval)
 		return retval;
 
-	v9ses = v9fs_dentry2v9ses(dentry);
-
 	p9attr.valid = v9fs_mapped_iattr_valid(iattr->ia_valid);
 	if (iattr->ia_valid & ATTR_MODE)
 		p9attr.mode = iattr->ia_mode;
@@ -582,12 +582,8 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 		return PTR_ERR(fid);
 
 	/* Write all dirty data */
-	if (S_ISREG(inode->i_mode)) {
-		retval = filemap_fdatawrite(inode->i_mapping);
-		if (retval < 0)
-			p9_debug(P9_DEBUG_ERROR,
-			    "Flushing file prior to setattr failed: %d\n", retval);
-	}
+	if (S_ISREG(inode->i_mode))
+		filemap_write_and_wait(inode->i_mapping);
 
 	retval = p9_client_setattr(fid, &p9attr);
 	if (retval < 0) {
@@ -596,17 +592,9 @@ int v9fs_vfs_setattr_dotl(struct mnt_idmap *idmap,
 		return retval;
 	}
 
-	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size !=
-		 i_size_read(inode)) {
+	if ((iattr->ia_valid & ATTR_SIZE) &&
+	    iattr->ia_size != i_size_read(inode))
 		truncate_setsize(inode, iattr->ia_size);
-		truncate_pagecache(inode, iattr->ia_size);
-
-#ifdef CONFIG_9P_FSCACHE
-		if (v9ses->cache & CACHE_FSCACHE)
-			fscache_resize_cookie(v9fs_inode_cookie(V9FS_I(inode)),
-				iattr->ia_size);
-#endif
-	}
 
 	v9fs_invalidate_inode_attr(inode);
 	setattr_copy(&nop_mnt_idmap, inode, iattr);
@@ -733,7 +721,7 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
 		/* Now walk from the parent so we can get an unopened fid. */
 		fid = p9_client_walk(dfid, 1, &name, 1);
 		if (IS_ERR(fid)) {
@@ -810,7 +798,7 @@ v9fs_vfs_link_dotl(struct dentry *old_dentry, struct inode *dir,
 	}
 
 	v9fs_invalidate_inode_attr(dir);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
 		/* Get the latest stat info from server. */
 		struct p9_fid *fid;
 
@@ -887,7 +875,7 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	/* instantiate inode and assign the unopened fid to the dentry */
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) {
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
 		if (IS_ERR(inode)) {
 			err = PTR_ERR(inode);
@@ -972,7 +960,7 @@ int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 	 * We don't want to refresh inode->i_size,
 	 * because we may have cached data
 	 */
-	flags = (v9ses->cache & CACHE_LOOSE) ?
+	flags = (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE) ?
 		V9FS_STAT2INODE_KEEP_ISIZE : 0;
 	v9fs_stat2inode_dotl(st, inode, flags);
 out:
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 73db55c050bf..10449994a972 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -63,8 +63,7 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 	sb->s_magic = V9FS_MAGIC;
 	if (v9fs_proto_dotl(v9ses)) {
 		sb->s_op = &v9fs_super_ops_dotl;
-		if (!(v9ses->flags & V9FS_NO_XATTR))
-			sb->s_xattr = v9fs_xattr_handlers;
+		sb->s_xattr = v9fs_xattr_handlers;
 	} else {
 		sb->s_op = &v9fs_super_ops;
 		sb->s_time_max = U32_MAX;
@@ -84,7 +83,9 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 		sb->s_bdi->io_pages = v9ses->maxdata >> PAGE_SHIFT;
 	}
 
-	sb->s_flags |= SB_ACTIVE;
+	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
+	if (!v9ses->cache)
+		sb->s_flags |= SB_SYNCHRONOUS;
 
 #ifdef CONFIG_9P_FS_POSIX_ACL
 	if ((v9ses->flags & V9FS_ACL_MASK) == V9FS_POSIX_ACL)
@@ -135,7 +136,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	if (retval)
 		goto release_sb;
 
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		sb->s_d_op = &v9fs_cached_dentry_operations;
 	else
 		sb->s_d_op = &v9fs_dentry_operations;
@@ -276,7 +277,7 @@ static int v9fs_drop_inode(struct inode *inode)
 	struct v9fs_session_info *v9ses;
 
 	v9ses = v9fs_inode2v9ses(inode);
-	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	if (v9ses->cache == CACHE_LOOSE || v9ses->cache == CACHE_FSCACHE)
 		return generic_drop_inode(inode);
 	/*
 	 * in case of non cached mode always drop the
@@ -289,30 +290,49 @@ static int v9fs_drop_inode(struct inode *inode)
 static int v9fs_write_inode(struct inode *inode,
 			    struct writeback_control *wbc)
 {
+	int ret;
+	struct p9_wstat wstat;
 	struct v9fs_inode *v9inode;
-
 	/*
 	 * send an fsync request to server irrespective of
 	 * wbc->sync_mode.
 	 */
 	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
-
 	v9inode = V9FS_I(inode);
-	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
+	if (!v9inode->writeback_fid)
+		return 0;
+	v9fs_blank_wstat(&wstat);
 
+	ret = p9_client_wstat(v9inode->writeback_fid, &wstat);
+	if (ret < 0) {
+		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
+		return ret;
+	}
+	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
 	return 0;
 }
 
 static int v9fs_write_inode_dotl(struct inode *inode,
 				 struct writeback_control *wbc)
 {
+	int ret;
 	struct v9fs_inode *v9inode;
-
+	/*
+	 * send an fsync request to server irrespective of
+	 * wbc->sync_mode.
+	 */
 	v9inode = V9FS_I(inode);
-	p9_debug(P9_DEBUG_VFS, "%s: inode %p\n", __func__, inode);
+	p9_debug(P9_DEBUG_VFS, "%s: inode %p, writeback_fid %p\n",
+		 __func__, inode, v9inode->writeback_fid);
+	if (!v9inode->writeback_fid)
+		return 0;
 
+	ret = p9_client_fsync(v9inode->writeback_fid, 0);
+	if (ret < 0) {
+		__mark_inode_dirty(inode, I_DIRTY_DATASYNC);
+		return ret;
+	}
 	fscache_unpin_writeback(wbc, v9fs_inode_cookie(v9inode));
-
 	return 0;
 }
 
diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 60cad0d200a4..429adf6be29c 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -42,8 +42,6 @@ enum p9_debug_flags {
 	P9_DEBUG_PKT =		(1<<10),
 	P9_DEBUG_FSC =		(1<<11),
 	P9_DEBUG_VPKT =		(1<<12),
-	P9_DEBUG_CACHE =	(1<<13),
-	P9_DEBUG_MMAP =		(1<<14),
 };
 
 #ifdef CONFIG_NET_9P_DEBUG
@@ -215,10 +213,6 @@ enum p9_open_mode_t {
 	P9_ORCLOSE = 0x40,
 	P9_OAPPEND = 0x80,
 	P9_OEXCL = 0x1000,
-	P9L_MODE_MASK = 0x1FFF, /* don't send anything under this to server */
-	P9L_DIRECT = 0x2000, /* cache disabled */
-	P9L_NOWRITECACHE = 0x4000, /* no write caching  */
-	P9L_LOOSE = 0x8000, /* loose cache */
 };
 
 /**
diff --git a/net/9p/client.c b/net/9p/client.c
index a3340268ec8d..2adcb5e7b0e2 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1230,9 +1230,9 @@ int p9_client_open(struct p9_fid *fid, int mode)
 		return -EINVAL;
 
 	if (p9_is_proto_dotl(clnt))
-		req = p9_client_rpc(clnt, P9_TLOPEN, "dd", fid->fid, mode & P9L_MODE_MASK);
+		req = p9_client_rpc(clnt, P9_TLOPEN, "dd", fid->fid, mode);
 	else
-		req = p9_client_rpc(clnt, P9_TOPEN, "db", fid->fid, mode & P9L_MODE_MASK);
+		req = p9_client_rpc(clnt, P9_TOPEN, "db", fid->fid, mode);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto error;
@@ -1277,7 +1277,7 @@ int p9_client_create_dotl(struct p9_fid *ofid, const char *name, u32 flags,
 		return -EINVAL;
 
 	req = p9_client_rpc(clnt, P9_TLCREATE, "dsddg", ofid->fid, name, flags,
-			    mode & P9L_MODE_MASK, gid);
+			    mode, gid);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto error;
@@ -1321,7 +1321,7 @@ int p9_client_fcreate(struct p9_fid *fid, const char *name, u32 perm, int mode,
 		return -EINVAL;
 
 	req = p9_client_rpc(clnt, P9_TCREATE, "dsdb?s", fid->fid, name, perm,
-			    mode & P9L_MODE_MASK, extension);
+			    mode, extension);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto error;

---
base-commit: 69716a8e21e42593f4086d26f3188be93df53a9c
change-id: 20230606-mptcp-revert-9p-features-56be51f515b4

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

