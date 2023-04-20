Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4153E8C1F
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 16:20:07 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-2fa47de5b04so723935f8f.1
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682007606; x=1684599606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5W7I6T+Lbxo5QN5hv5rfoj2DWsCzq6IRUstEIZeeEw=;
        b=J5AwrxOHdSW2eQxsTgdoSUUoriYRf6fptQHF0YPV8/a52CUEbbKksw7CRaB6b+uhD5
         AaDFiYtzAqtBHWvB7SQkXCE9137ihb+lr0d3n2/1pvqcyMtyTE39RTYRmPTRY+g/I0Y9
         WzY3KOpvv7oGjikXQYnbEghkjYYv3x0dEFV22Whm2inadqD0jsgEhTF56gfqrUtyZvsi
         3l7u4WiioDO1czgovIEhPQ4JBo0f7lsBIfBztsWgNCTo99RqoCA5QId9C+0Bj8u5AlYS
         utdsmYHCBKlQKVFzyKLZiln7eU+5WC1Ux15RGru0jUDEh41skD9h+Lja0pV7tjyKssz3
         IVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007606; x=1684599606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5W7I6T+Lbxo5QN5hv5rfoj2DWsCzq6IRUstEIZeeEw=;
        b=AKSqfhWFj3o8sMPMcLvXrUufHSiKsXFUJx3V5SpfUDQmVhkqw9WKjQ0ZN/gJqIyDar
         9bbh81yfcCfGlYixnDw4wWSkm2FLsPD/WsOd0uU62VHt0KbHV89ceqi8t5BGuQwfB9I4
         RDsM5UdiHyJ7aBCb3mRlRbLqdbV/pVuprID8p96oeuR5JL41IZxhY54fXhHVYWOsjkWe
         ziR5WbMp0S4ZWbY3gzs0JCivQxXR/Z/m4KKJ3Xc3pfVOW76cXVbI8nE6h2CGgtEX56dC
         p6tfjP170fakuwpkY7/5k5Ns0Si+iF9gc5NVZwkKNqZwjSTILUiPFmxaJx1QDhccYH2Z
         dQwQ==
X-Gm-Message-State: AAQBX9dnQFUSVXErkPe8F8RmIcevZwH/9Nb+VvabwRIb51B/RAegGzdO
	TXp3Hk+tiiFVM4QlWroqRluqzGhEp/rBIdFdcQ60n+VA
X-Google-Smtp-Source: AKy350YX5gTDM4+PXiTotAaO7vkRepMDwIl1BNroRVqgMplMcr0cbFr15v4LNk/pzIfIqFpLQDC3jg==
X-Received: by 2002:adf:f084:0:b0:2f5:1e06:3fe4 with SMTP id n4-20020adff084000000b002f51e063fe4mr1743611wro.44.1682007605923;
        Thu, 20 Apr 2023 09:20:05 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z18-20020adfe552000000b002f3e1122c1asm2371335wrm.15.2023.04.20.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:20:05 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/2] Squash to "selinux: Implement mptcp_add_subflow hook"
Date: Thu, 20 Apr 2023 18:19:57 +0200
Message-Id: <20230420161957.664328-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420161957.664328-1-matthieu.baerts@tessares.net>
References: <20230420161957.664328-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3345; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=TZLSSeC4XXBUaUSjGdkIBqMTicwsUlIUjqbT+wOz4ug=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkQWX5MxDxB4NSzXcz9eFzovmDZjf6vZY0MarGJ
 QYCHjuYCLmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZEFl+QAKCRD2t4JPQmmg
 c0TzEACwLOZrU+Ai5d454oL6U2uE9M9T0/1TR1kBz/XzFGfqRwypBjZRvhHoi7NOD3pzm0/LQ6P
 WwiZ+rtCgPi8LwunZNItT4h6siKjXVP+47tncG5c7TTus4jF0yHrKDd1sPsuehFXUnNBvgBWXBE
 ARTA10OvNfj6CfVFmRq6jFTyKXvXtpR6CRzhrU980XVNkgUJsYkoIEMZg68JLuxnwn0Y60ofbK9
 kcwttgE1jS25WkJDCSpE1VkIR8eoL7zpqlfbGlnz3S2eB+0XzbDQfbIRO41RcRnjmBJFMxpQT6U
 knZRXfZAAxuZjaOahn/RuQLR8Gey09sCXhievBbUYZT37B/gpWw9E0M6nwfRf0UX0XUCm4uXiCJ
 XuwvA2bmXvfnOKl9EYbfblYjHg1Xi2ma8AuzYNtZ/Eb/xVC1yDtOBTO/K8WI97hif9JkBj2/U+h
 j0lcHQV5bZYp1XNcW/q12QmQlmcPco/GRZqQxA+x/B22Wcd6UUrZhE8N8ygZ2acB3e1e+qxLLho
 kC7PfZh/ay4pCoHleo9bkGPZF1QgxMo9bCpToNKPHrnG6P6b6oBYCX/TZLSFI1q/f00Zg6CnA2U
 cw1gurWGZOM07YfSPl+3PyVA7gIV+l87O3B5tW1FHOJiTZ1Ol+2c2q5fJ5g5shaAOiaJe0vIYBp SKu1eYjzZhVXhKQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Apply Paul's comments from [1].

For the commit message:

  > Newly added subflows should inherit the LSM label from the associated
  > msk socket regarless current context.

  "... from the associated main MPTCP socket regardless of the current context."

  Us SELinux folks may not always be able to make the jump from "msk" to
  "main MPTCP socket" when we are looking through the git log in the
  future, let's make it easier on us/me ;)

  > This patch implements the above copying sid and class from the msk
  > context, deleting the existing subflow label, if any, and then

  "... from the main MPTCP socket context, deleting ..."

  > re-creating a new one.

And for security/selinux/hooks.c:

  > +       /* replace the existing subflow label deleting the existing one
  > +        * and re-recrating a new label using the current context

  "... new label using the updated context"

  Let's avoid the phrase "current context" as that could imply the
  current task, which is exactly what we are trying not to do.

Link: https://lore.kernel.org/mptcp/CAHC9VhQz_ZUot1Sxa6zhzXh_ECz+rR=Nq3zzDEEL7GKvzYQziA@mail.gmail.com/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "selinux: Implement mptcp_add_subflow hook"

 .topmsg                  | 13 +++++++++----
 security/selinux/hooks.c |  2 +-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/.topmsg b/.topmsg
index d10caa1fec26..f3b93eefbcf6 100644
--- a/.topmsg
+++ b/.topmsg
@@ -2,11 +2,11 @@ From: Paolo Abeni <pabeni@redhat.com>
 Subject: [PATCH] selinux: Implement mptcp_add_subflow hook
 
 Newly added subflows should inherit the LSM label from the associated
-msk socket regarless current context.
+MPTCP socket regardless of the current context.
 
-This patch implements the above copying sid and class from the msk
-context, deleting the existing subflow label, if any, and then
-re-creating a new one.
+This patch implements the above copying sid and class from the MPTCP
+socket context, deleting the existing subflow label, if any, and then
+re-creating the correct one.
 
 The new helper reuses the selinux_netlbl_sk_security_free() function,
 and the latter can end-up being called multiple times with the same
@@ -14,3 +14,8 @@ argument; we additionally need to make it idempotent.
 
 Signed-off-by: Paolo Abeni <pabeni@redhat.com>
 Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
+---
+v2:
+ - Address Paul's comments:
+   - use "MPTCP socket" instead of "msk" in the commit message
+   - "updated" context instead of "current" one in the comment
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 53cfc1cb67d2..67e6cd18ad59 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5485,7 +5485,7 @@ static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
 	ssksec->sid = sksec->sid;
 
 	/* replace the existing subflow label deleting the existing one
-	 * and re-recrating a new label using the current context
+	 * and re-recreating a new label using the updated context
 	 */
 	selinux_netlbl_sk_security_free(ssksec);
 	return selinux_netlbl_socket_post_create(ssk, ssk->sk_family);

base-commit: 3756c91778d89cc8a342ef4dd6df4d93c6a32c2a
-- 
2.39.2

