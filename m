Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E6337B97
	for <mptcp@lists.linux.dev>; Sat, 30 May 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780127448; cv=none; b=FaayFAuKnu3K1bQgDQB0Yjh7hfn6CmuibfGWT+y/NGR7apIPAwQ2+OMyyyPHD+eZwsCUm2fjP0ey4Wbf7sU+TAB9ljLQLKB2q93KyXWMhnHoJpZ/ExA7Lo1SZvXZSOrDjP6a8uBu1pxRYpEAIlmhvlY1DdLNIf6KjFeyEIBN6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780127448; c=relaxed/simple;
	bh=/rZmJR6yifVUPVHPjtrXjyieNQkKpUS/mZSyFkg7W7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ucd6Nbw+E0eoJYphzYOJKGzeSIR8ldwikZormFJDSWMdHmO2GTNM5ZM/ihfg18HIpz+Lkne586AiZvsPSXXlMCmpUUUqAcV/Pdl3Qc5gsCM8QfzO2JnvK0XenOzMnKdrjtSHMs3/qxbQDmu6zzg4+5Y270JY9G32kVaqwJsAM8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooJYA8CE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooJYA8CE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90A11F00898;
	Sat, 30 May 2026 07:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780127447;
	bh=w14KsHrOlH/HAVfBJsbHWhszse0UmtOfPr3ZNsUzvSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ooJYA8CEEYQ2++giJna4Z6gmyB3UePRwydj5t91Jhl9ShGeR9CQELtViliKDr3Evv
	 HxCX9GHIhimelerwVsHerFIq0AgBMdqOo7yh+AisOvZrLHkjo8UytaYffqb6K1KAUE
	 Op0EZBU9hxZGVFXpKB5qAQfiImfhO+McxsimfzKnQIrgdi7kAXdPql/W6Izvx5PEU1
	 OpYR89YAvhcCwKi9YpOto595gKbLCrJ/I5No68BzWbxiyeSFTEiH+/CVnTOWq/GeYl
	 lPz0QEtAIGOPHZbWTd05GXPisSyQxiWYwrTfHyF5bfieI85xGnZRj8hH3xx3gOgi3a
	 02ti59T8chgYg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 3/5] tls: fix concurrency in TOE device list iterations
Date: Sat, 30 May 2026 15:50:09 +0800
Message-ID: <a8c28c3db89e63d120f55b70737136d58d179fc6.1780127277.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780127277.git.tanggeliang@kylinos.cn>
References: <cover.1780127277.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

tls_toe_hash() and tls_toe_unhash() iterate over the global device list
while temporarily dropping the spinlock to call the device callbacks.
If a concurrent tls_toe_unregister_device() removes a device during this
window, the list pointers become poisoned (LIST_POISON1/LIST_POISON2),
causing a crash when the iteration resumes even if the device object is
still referenced via kref.

Fix by replacing the lock-dropping iteration with a safe two-pass
approach: first count the number of devices that need the operation,
then allocate a dynamic array, collect device pointers under the lock
with a reference increment, and finally call the callbacks after the
lock is released. This eliminates the window where the list could be
mutated while iteration is in progress.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/tls/tls_toe.c | 63 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_toe.c b/net/tls/tls_toe.c
index 825669e1ab47..c588c702296f 100644
--- a/net/tls/tls_toe.c
+++ b/net/tls/tls_toe.c
@@ -84,41 +84,84 @@ int tls_toe_bypass(struct sock *sk)
 void tls_toe_unhash(struct sock *sk)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
-	struct tls_toe_device *dev;
+	struct tls_toe_device *dev, **devs;
+	int ndev = 0, i = 0;
+
+	spin_lock_bh(&device_spinlock);
+	list_for_each_entry(dev, &device_list, dev_list) {
+		if (dev->unhash)
+			ndev++;
+	}
+	spin_unlock_bh(&device_spinlock);
+
+	if (!ndev)
+		goto out;
+
+	devs = kmalloc_array(ndev, sizeof(*devs), GFP_KERNEL);
+	if (!devs)
+		goto out;
 
 	spin_lock_bh(&device_spinlock);
 	list_for_each_entry(dev, &device_list, dev_list) {
 		if (dev->unhash) {
 			kref_get(&dev->kref);
-			spin_unlock_bh(&device_spinlock);
-			dev->unhash(dev, sk);
-			kref_put(&dev->kref, dev->release);
-			spin_lock_bh(&device_spinlock);
+			devs[i++] = dev;
 		}
 	}
 	spin_unlock_bh(&device_spinlock);
+
+	for (i = 0; i < ndev; i++) {
+		dev = devs[i];
+		dev->unhash(dev, sk);
+		kref_put(&dev->kref, dev->release);
+	}
+	kfree(devs);
+
+out:
 	ctx->sk_proto->unhash(sk);
 }
 
 int tls_toe_hash(struct sock *sk)
 {
 	struct tls_context *ctx = tls_get_ctx(sk);
-	struct tls_toe_device *dev;
+	struct tls_toe_device *dev, **devs;
+	int ndev = 0, i = 0;
 	int err;
 
 	err = ctx->sk_proto->hash(sk);
+	spin_lock_bh(&device_spinlock);
+	list_for_each_entry(dev, &device_list, dev_list) {
+		if (dev->hash)
+			ndev++;
+	}
+	spin_unlock_bh(&device_spinlock);
+
+	if (!ndev)
+		goto out;
+
+	devs = kmalloc_array(ndev, sizeof(*devs), GFP_KERNEL);
+	if (!devs) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	spin_lock_bh(&device_spinlock);
 	list_for_each_entry(dev, &device_list, dev_list) {
 		if (dev->hash) {
 			kref_get(&dev->kref);
-			spin_unlock_bh(&device_spinlock);
-			err |= dev->hash(dev, sk);
-			kref_put(&dev->kref, dev->release);
-			spin_lock_bh(&device_spinlock);
+			devs[i++] = dev;
 		}
 	}
 	spin_unlock_bh(&device_spinlock);
 
+	for (i = 0; i < ndev; i++) {
+		dev = devs[i];
+		err |= dev->hash(dev, sk);
+		kref_put(&dev->kref, dev->release);
+	}
+	kfree(devs);
+
+out:
 	if (err)
 		tls_toe_unhash(sk);
 	return err;
-- 
2.53.0

