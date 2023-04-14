Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94C81E
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:29:45 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id s12so8361628wrb.1
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681464584; x=1684056584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bP/vRvbQ2WBZVvw/J6SbilIu314UT/gIgR1hgV3hQFI=;
        b=pu01AnfQpT42HmVFsqvtaXisd2geXnyTHgkftkmNtYqaxZ1UuM+hfdxBhJgvJV/UFJ
         W2ysEaQ06Xl95V7wrrh3TZU3jVcapHiTlEdBQg61I165fgue2k/c+ZxoGEhVasUrdKFh
         CiSQnzqT7DSluSGnvpBoiqbXDoCAj6jcqM1RXdAcBZ7dt2DFRpyGJOwU/ZWb+7hjeZgd
         vxDqp6ZWCFmp2SlAiRoWzVe6ZgFGYnfZl9xYYu9jYqOEJk+hWDQ7qxCZhTyQasP1AeFJ
         capp8VYOQUrX5eLzPW7OO6zrXC93x/R8wxNfZnCfEx+HUV1uUTbJOB0pfsJXdZ15uj+S
         TZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464584; x=1684056584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP/vRvbQ2WBZVvw/J6SbilIu314UT/gIgR1hgV3hQFI=;
        b=TSIAJYK0iugc3LWUkyflSKXV1s9nEZI+d3FIvgqCJO2n7yZbC20CmidrfX3q/X+iMn
         qn7weUu473ymY6zWsY/q+F3huz9caiam/UcCPTzYB0kBag/XqR7/QwqvTvFaIBKTO0kO
         p4kVhhBxQZLw+6zXVddgY3yW236865LSiVtV0DbhyK9KGCPOsHDg0GtimFkI2L9gqh6T
         kOOOXZglVHJG2638zuYCCLtRBXES8rxCmkRM1iLG6eNC6d7mZ80TJ47ufOyAZGN0LJtb
         8wTwNjNEZIA+h8N3yxkvtEvLCkTd57nW+KNSfTAvbWc3vXKWkCr2XA2st6X6iZ4jVh4B
         m/sQ==
X-Gm-Message-State: AAQBX9esgiCuCKBgypo0hobckM6ZwarWk5J2yzd2EG6OyTtvihzdagVQ
	96pksqscEbiGqOUM/Zafdwajo5uSRWtcueVXf0w/fE/n
X-Google-Smtp-Source: AKy350aHUGTsUxBLbRe2/4T1iIu5yk5+r8moLacXCoNPp1FoquQ5s0a4mKygB6UQaIIgY5HCPg/rfA==
X-Received: by 2002:a5d:5691:0:b0:2f4:77e9:997c with SMTP id f17-20020a5d5691000000b002f477e9997cmr3658147wrv.52.1681464583778;
        Fri, 14 Apr 2023 02:29:43 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f09d51a4edsm7620035wmo.48.2023.04.14.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:29:43 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/2] mptcp: bpf: Invoke btf_struct_access() callback only for writes
Date: Fri, 14 Apr 2023 11:29:33 +0200
Message-Id: <20230414092934.4065227-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414092934.4065227-1-matthieu.baerts@tessares.net>
References: <20230414092934.4065227-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=927; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=u4ermjqsb6cwMhnUVEBljs8s5nbIJxsMUmdX5Bi2wKI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkORy1U3/e8pKzLVijct/En1wjVTm23QOZJ6wZ7
 NSO+D7HDU2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDkctQAKCRD2t4JPQmmg
 cxy/D/9xAm96NgiQY1AMChPQLVhCFU+qhPzNEoZM7lygqjvq+V1Xwq6aztfhYFkmfrQe5qMtJVc
 IM/cNwkLSbWxIeokhBIW2KU3WrVhKROMlvRuES5FUN/wo5M2OQBhWcYgYcvtyLw3nNUDnpJG1Yx
 JCrGDx83tnH9vJASw9JiwM3TDgMjOtazpli6ZjubyKHX+jM0H6pCIVl9z9F4XcTVKA4r8YfYfqF
 +LRtZxPKC/4zgkpLfvq42Uax//iiG6fQg7rwNzdjjyZUsyY9a5U6/3ErF46nZ4lVOVZxQnbJL3S
 FG5AeBjJ3j2SpGaapHtYvhcn0Bz7Stx6VYePf/WBjlVtTrmPt02cFJ73Jj4TiH0GGvo4F+hrzMf
 +Iv2PfuvTD5pIgRVHEeWUEn6Y9Fdh3W7g11032Ngd9BR5UsCkETd5fFVYOy0IMOI/5hLxYtHQCT
 S4L+lc9avZv8dwK0flMKHpvwU1XYdEj+3hi0xjvwtPYkFjmduwzCkxOIU2ma2k6EmYWYyiM5q3i
 d8v3LXJ/uNQja/SoDwjbU3KZssANCIKPT1sJOfO5UpEdP4oVJk22ZZkm96JV3TnGgQYfFyPXEwu
 OD0e8ImYjmE5zox9tANSVrSqjGg6aGn/NRvvuXSDQcVG/SkDtg0/OPT4W5h2clc6edtxLXAogQY GSbcBm4NYZMOXPA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This is a Squash-to patch for commit "bpf: Add bpf_mptcp_sched_ops",
similar to what has been done upstream for BPF TCP CA, see the commit
below.

Fixes: 7d64c5132844 ("bpf: Invoke btf_struct_access() callback only for writes.")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/bpf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 14ea1342598a..60f60868187f 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -43,11 +43,6 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	const struct btf_type *t;
 	size_t end;
 
-	if (atype == BPF_READ) {
-		return btf_struct_access(log, reg, off, size, atype,
-					 next_btf_id, flag);
-	}
-
 	t = btf_type_by_id(reg->btf, reg->btf_id);
 	if (t != mptcp_sched_type) {
 		bpf_log(log, "only access to mptcp_subflow_context is supported\n");
-- 
2.39.2

