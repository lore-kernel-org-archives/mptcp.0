Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FE322A
	for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 14:21:24 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id n21so34118222ejb.9
        for <mptcp@lists.linux.dev>; Tue, 29 Nov 2022 06:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5+CdrWKRGk7pFDrCwfXp8atNgSCAXgUbtBIk/gTEOTY=;
        b=4MTpyW9DUdouo4QEl4ppNqNyX3RbsU1rHNnmTdUxnZCTY9sxPGlV8V4aJXZevkIduK
         jS2AgGyWPwkL5bmyVcJSXb+MB/WDTgMLiUEFfE44wUUyD9t4F5d89zSqVqpQRl+BJH/d
         L8yVQk4IaeLg13G2d5PTPcMSruz/LEcZydq3ncb2HpYQw3Fi6Yz6dAkZv3t+PggTB5w5
         mrhTFGO6p6x/heBAsB5IAF92HSU+KUDEMrN/s2CZii3w/oAhsFmdD8sy/IMuh5IYBqrc
         mBBRAkJnmGgi4VbDDj9HW6niT9I/Z9Q8YbMD1RgN8vydhf3rBK4lcDVz6su4s5eLrbgw
         UbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+CdrWKRGk7pFDrCwfXp8atNgSCAXgUbtBIk/gTEOTY=;
        b=jG+ne1h/s5umdaNE8MzTZV/k/CSRt4J7l+eQgB4ORcTXx3topZZYs0JnY5anyXfJIO
         VLj7GLSzYAnlnA7Wyf+nQy7ywscNIyqGt5qDhTv2Lm0VMwH3P5ybNV5alaX05pjwTGiA
         MGkcNdTZ2WfVXu3+fc0nRTLt/hHKQFIeELCnvXFBEgUqTntgDdSGF+OOwdz9rXJTKaMT
         Vux4EjNjv6/NDGZg5Tf5VPLlWoLwBfgFhHc8/yOo0KVuVBZCXQFHTMcAYzhM6ggWcQuS
         n6dN0jHFCW8RsO2PJCQUfZe3E/ibn5mshzs0/PGvYiCSEpBfMMuvRAIXDdn/RCpg/j3y
         1rtw==
X-Gm-Message-State: ANoB5pkfTe3+LTpin7O7n/VII4oHroDOky2unA64IxwvyzcbWCSlqu0u
	QCl9UYo0AdJ1Kvk2aG4blc7NYwbGLTCiNcwV
X-Google-Smtp-Source: AA0mqf7iHG3ulr5mLGUkeVHHat7iPGp7VU/gMp7F7T5saqUv8N4Mo61gdFsiwRJUoK/rtWbcpXFjwQ==
X-Received: by 2002:a17:906:29cf:b0:7c0:8101:7bb5 with SMTP id y15-20020a17090629cf00b007c081017bb5mr4803658eje.87.1669731682606;
        Tue, 29 Nov 2022 06:21:22 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id d24-20020a50fb18000000b0045bccd8ab83sm6331185edq.1.2022.11.29.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 06:21:22 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>
Subject: [PATCH mptcp-next] Squash-to "bpf: Add bpf_mptcp_sched_ops"
Date: Tue, 29 Nov 2022 15:20:11 +0100
Message-Id: <20221129142010.2886747-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5580; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=tCuDVkD0cvj39YM1ErJhWAVnXQIU2y8jCy2169yGZk8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjhhUOFisG7ib7ssfri9NJ5ttrK5kuaGSvoYACNLDo
 sKVxNxKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY4YVDgAKCRD2t4JPQmmgc7y7D/
 9W3hok6xuvowUmJ0VBWAuGeFzAUigh1ULbKExwyZnIaE+VVuJlM487rinMfijpNFqb0srZJB6n/4xN
 mpf8ql9iAKqZH+m/+5Ff5+bQEcvD+iviXz3qcX3rnoOs889/apMT41OqBt4szxtkQIf0J6rkc7pxM1
 I9i/gGqV6/JjcsD3mFZ7v2ZXJbna/+V2eBY0hSHDq2SWP3fOK0ObeS2u+AogVc4v3VSVTxntbQwPZK
 kVVgdpxoeZhIqYddtevw+58Ob+tkqUX0StWEu26a1EpWPG6xkU7cH2NmcXL3E7wC7wd/tjKH5J5eym
 a6B67TAD24khyKxj6rhiw3LgC9S5it7m1lmYdNgtBo/idenBFyr8EK4dopdzbN5gO3kLNWJfQ6yoJ5
 5goVrK7bbk9eGDmLZd6EV9uejfTCEvS+TZP37pTUEphA2lbOsWuh4nR/1ZUncqKIi5YSvvylXeO8MZ
 l8XIyhhCevMOBNFDLF9h+GvjCGt0exUdZlN+xJAqItDOK4DL3X+1j0MM1msIOZyGcgl2gz6Uz9K9ke
 W/X4d1ZtSVMZo7GWCsiz/jpOQ4JxTlPHGEzeVlFGvwYFBBKbzpIFNxPfr4S4unGTi03ciJHutngLJ0
 PNSC3BbLz4SsIaX4Vn43S2qUbZ+Vg8ShtJ+6FKx1kJtyXMfIQe07jYrVTuNw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

The BPF API around btf_struct_access() has been modified recently, see
commit 6728aea7216c ("bpf: Refactor btf_struct_access").

Adaptations have been done, similar to what was done in the mentioned
commit, e.g. by looking at changes around bpf_tcp_ca_btf_struct_access().

Without this modification, we have compilation errors:

    net/mptcp/bpf.c: In function 'bpf_mptcp_sched_btf_struct_access':
    net/mptcp/bpf.c:46:47: error: passing argument 2 of 'btf_struct_access' from incompatible pointer type [-Werror=incompatible-pointer-types]
     46 |                 return btf_struct_access(log, btf, t, off, size, atype,
        |                                               ^~~
        |                                               |
        |                                               const struct btf *
  In file included from   net/mptcp/bpf.c:12:
    include/linux/bpf.h:2155:51: note: expected 'const struct bpf_reg_state *' but argument is of type 'const struct btf *'
   2155 |                       const struct bpf_reg_state *reg,
        |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
    net/mptcp/bpf.c:46:52: error: passing argument 3 of 'btf_struct_access' makes integer from pointer without a cast [-Werror=int-conversion]
     46 |                 return btf_struct_access(log, btf, t, off, size, atype,
        |                                                    ^
        |                                                    |
        |                                                    const struct btf_type *
  In file included from   net/mptcp/bpf.c:12:
    include/linux/bpf.h:2156:27: note: expected 'int' but argument is of type 'const struct btf_type *'
   2156 |                       int off, int size, enum bpf_access_type atype,
        |                       ~~~~^~~
    net/mptcp/bpf.c:46:66: error: incompatible type for argument 6 of 'btf_struct_access'
     46 |                 return btf_struct_access(log, btf, t, off, size, atype,
        |                                                                  ^~~~~
        |                                                                  |
        |                                                                  enum bpf_access_type
  In file included from   net/mptcp/bpf.c:12:
    include/linux/bpf.h:2157:28: note: expected 'u32 *' {aka 'unsigned int *'} but argument is of type 'enum bpf_access_type'
   2157 |                       u32 *next_btf_id, enum bpf_type_flag *flag);
        |                       ~~~~~^~~~~~~~~~~
    net/mptcp/bpf.c:46:24: error: too many arguments to function 'btf_struct_access'
     46 |                 return btf_struct_access(log, btf, t, off, size, atype,
        |                        ^~~~~~~~~~~~~~~~~
  In file included from   net/mptcp/bpf.c:12:
    include/linux/bpf.h:2154:5: note: declared here
   2154 | int btf_struct_access(struct bpf_verifier_log *log,
        |     ^~~~~~~~~~~~~~~~~
    net/mptcp/bpf.c: At top level:
    net/mptcp/bpf.c:76:35: error: initialization of 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, int,  int,  enum bpf_access_type,  u32 *, enum bpf_type_flag *)' {aka 'int (*)(struct bpf_verifier_log *, const struct bpf_reg_state *, int,  int,  enum bpf_access_type,  unsigned int *, enum bpf_type_flag *)'} from incompatible pointer type 'int (*)(struct bpf_verifier_log *, const struct btf *, const struct btf_type *, int,  int,  enum bpf_access_type,  u32 *, enum bpf_type_flag *)' {aka 'int (*)(struct bpf_verifier_log *, const struct btf *, const struct btf_type *, int,  int,  enum bpf_access_type,  unsigned int *, enum bpf_type_flag *)'} [-Werror=incompatible-pointer-types]
     76 |         .btf_struct_access      = bpf_mptcp_sched_btf_struct_access,
        |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    net/mptcp/bpf.c:76:35: note: (near initialization for 'bpf_mptcp_sched_verifier_ops.btf_struct_access')

Fixes: 6728aea7216c ("bpf: Refactor btf_struct_access")
Link: https://cirrus-ci.com/task/5509843558072320?logs=test#L3300-L3262
Cc: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    I suggest not to wait before applying this patch to be able to continue
    compiling and validating the export branch.

 net/mptcp/bpf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 03decb05755f..f632c2f828e8 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -34,19 +34,21 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 }
 
 static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
-					     const struct btf *btf,
-					     const struct btf_type *t, int off,
-					     int size, enum bpf_access_type atype,
+					     const struct bpf_reg_state *reg,
+					     int off, int size,
+					     enum bpf_access_type atype,
 					     u32 *next_btf_id,
 					     enum bpf_type_flag *flag)
 {
+	const struct btf_type *t;
 	size_t end;
 
 	if (atype == BPF_READ) {
-		return btf_struct_access(log, btf, t, off, size, atype,
+		return btf_struct_access(log, reg, off, size, atype,
 					 next_btf_id, flag);
 	}
 
+	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != mptcp_sched_type) {
 		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
 		return -EACCES;

base-commit: 8c1a5e594de5220c783bb99a683a5c7e8f656632
-- 
2.37.2

