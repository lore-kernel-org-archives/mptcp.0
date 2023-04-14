Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4281F
	for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 09:29:46 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id bd13-20020a05600c1f0d00b003f14c42cc99so224393wmb.2
        for <mptcp@lists.linux.dev>; Fri, 14 Apr 2023 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681464584; x=1684056584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSUgRBl6dul1wQA7/Nf2v59YLgl5n7etxyF/TgaSCww=;
        b=8XGwe9DhAKmS1sipXUz64Kl/MC/DSHOEvb/6pZUq6LsTVppWf5nSuuNbu/hQTtCf05
         WL08oyWIUxxF449qzORe1en/wclHFZuWsL7cL4XkkY/hX76IbQdTXYIvPN/vA8XkIuWu
         jchuKcHgChRz3txREAxparRpxRJyjhD2eOuEof+gyOlaZUr03QPAKjUB/axPKrstDdHZ
         aYdBm4TPcQ1qpF78KcIA+NC0gOQe87dVsuAMiddjsD+HFE3AVZyH3BV9LfjWceKy/xRS
         zzZwiyAo9TzNZF3WvLFwHscz+KFljUNXdtBACsX1DO3gJowySMLF7z6K0ejeeTGgrqRf
         8QxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464584; x=1684056584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSUgRBl6dul1wQA7/Nf2v59YLgl5n7etxyF/TgaSCww=;
        b=mEqGzzhG87G0j88YmU/7Uzuc5D7bzLjqtYMmvQOfsO69RANRNNz5mjSjZkpiLuqXLj
         svXKC0PZq3TM7PTJjR+uE/hzFZGHDGSScZ5PW11jNmT/44ICZz/0vrxTIjgh4dNiQKRh
         aMnqFCfpdTNN8ddJ7mJ0R/9wD5dvC9JURRER/u2j2l+Y4ll7m2evqhLdwylOmJj6uDgZ
         0YQANzm5uDbQUOlu2pJNa9GlmxVwiw9nk3La65MGQWV2h9CO1997FbM4EPdV4pzz+4/l
         qHz4C25FZS0b4hGjJ2crqVVKP+76jS/VNo5DwZ+cd3SKwK5igmEmdh+hsQWeYdhM5jat
         TUig==
X-Gm-Message-State: AAQBX9eYm4xPKUq7rauKkCGTI7Iemokpn97HKkGVpA9c4dY92SkVyhjE
	4ayVss7zjsOTZf8C2EVcAgQilmbWCipimyYjJdfRI2/i
X-Google-Smtp-Source: AKy350Z3o0i/jbu4uV58mi7yWSdNs0nos3QcAgEofr57CLH3uRH6jsaPJAYCqXuguhARE3NKd51oQA==
X-Received: by 2002:a7b:c8ce:0:b0:3f0:ad61:a980 with SMTP id f14-20020a7bc8ce000000b003f0ad61a980mr3220183wml.30.1681464584570;
        Fri, 14 Apr 2023 02:29:44 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f09d51a4edsm7620035wmo.48.2023.04.14.02.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 02:29:44 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] mptcp: bpf: Remove unused arguments from btf_struct_access()
Date: Fri, 14 Apr 2023 11:29:34 +0200
Message-Id: <20230414092934.4065227-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414092934.4065227-1-matthieu.baerts@tessares.net>
References: <20230414092934.4065227-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=p6kSxLi6sbsyqxpv8CMLPparF1YFfNC8NpxoxrUKjhU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkORy1DMi0Tk7G9f2AX4XROAczXdx74IXsnzvb+
 j4K9LzQKbmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDkctQAKCRD2t4JPQmmg
 c33WD/48ucY/pYSoGYNFctfAdzqw16YixgyNDVN6eIXGqlxg22IVSTcEVn7tV8Q+K5M+CHQcSU0
 6NZR7NnQCIRGzwOksji1g3fdBrJI886ARM7Jfb+DJzSR1b+3Cg0EyTl0LfvECtwqF0aPyX7dhl8
 jTdZb/3GSZK2uS+WQ6Ok7fhTWQqVqoyxnqb/hGy/aotTnOvhjcPZSvlMywQxVP+ieXFEzkYOpWu
 etmoqzd/W/3JswOaUmAiJ1iPm3DUrbIFNFR668lP21O8C2jsDTe8vLaXTH5nKgvvdrqHAIJrr2k
 NR0b1OQw/3foXsFk/SJFIMloJhLj4QZcCfM8oGLy18Bs98P/o/dZx1BOc5zGwxylYzynNME27p5
 hNtuYlDgRV7bqpPjgKdSppJsgLFruw1S+H+gwv6PtGF0Okgk/jyUpgB9h9GopkJjmbfoQ2PERyy
 1coWLZzMIvK4cf6dRh4FaUmSaBGuJTgi+Iilbjjz9lGhnbPQ93P5/vPR+YGV6V3HUIGCo6F0v3r
 nZIQLYlwLlfmeK0RtiOGGby6MNrZSLvWO6qFmGjwc4S0VA1dOtDDaedzbsEyHDmNOen05OBeTFo
 oibWPWEWk3D3dfFne6XJyeeVLB1wv0t7fSZirD0XMpQHX9h3SpZp0XWM5XWZ6WJ2lLyEoU0Mabu BEG6JUKmOxGXFZA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

This is a Squash-to patch for commit "bpf: Add bpf_mptcp_sched_ops",
similar to what has been done upstream for BPF TCP CA, see the commit
below.

Fixes: b7e852a9ec96 ("bpf: Remove unused arguments from btf_struct_access().")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/bpf.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 60f60868187f..f876c45aff27 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -35,10 +35,7 @@ bpf_mptcp_sched_get_func_proto(enum bpf_func_id func_id,
 
 static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 					     const struct bpf_reg_state *reg,
-					     int off, int size,
-					     enum bpf_access_type atype,
-					     u32 *next_btf_id,
-					     enum bpf_type_flag *flag)
+					     int off, int size)
 {
 	const struct btf_type *t;
 	size_t end;
-- 
2.39.2

