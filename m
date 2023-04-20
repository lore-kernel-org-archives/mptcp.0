Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EB8C15
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 16:20:06 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f09b9ac51dso23842515e9.0
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682007604; x=1684599604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nyyg3T7y0P8qBkSyFA5E6NNLqB3eayIMN8iFz7bJdNQ=;
        b=Jix6/xVApTlWz0jyL0PoG/8fHcL1AWXS7qLQwr0U+ZWScAp++CyRIgd94pjzKfvme0
         +HHYBXy61Y3f0FKLDH/FSVPi22JAM9crNZAW8k5SiDpPW3ASS1OkdTkxLV5Gc2s7Rm5i
         QUFDhaJ2Bb03xkKt1L6taTfvejLmD0X/qQwt8HPYTxosoiV/mucbONsXQWjDaScF6JFK
         iW4NKw73J+F6BIaWnob3DIppoNzmDhw7ob/rzp1dg52rzjfb8dEEP2j/RrnS+qHLyZHN
         e4LFXz8xTZRw3d9wUGtmwQ8B4Gvx+/KwTx/WR7imtvagHm/znZ8hDMRQaht+6Ps7Ig5l
         p/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007604; x=1684599604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nyyg3T7y0P8qBkSyFA5E6NNLqB3eayIMN8iFz7bJdNQ=;
        b=C4TbrKSmYgr7YTkG3gwI8n3aJITaf085GlMzN8/VecIm9VSCRemNE8MgDdYA+OlTFI
         8/QUs7aqGgzGL0GGRIsbUKXSI+H2hrbNEjIFuaZLwg7dN9hRHnrOOAdE/MPR9l2xcg8K
         Q/yrb+x8cF1Oz107KiF6v2n9NgISIKl80sj3R5GLoTNikDLgHnk41csTbqHpx8hDePwY
         KOil3N+S3tpJslx9nebnUiw27kkER8iQNe9hCY2fAfW8CugNFZ9sLVQcsrxsou35wPpt
         TriI4lnrHWMjoxQxmL/GIA4aBjQQ2ttNpb65kgNRo6MqZEUAP9qb0sawhq651c8mdy6e
         MfgA==
X-Gm-Message-State: AAQBX9cTN0uLfelA2M5m2n2W+Bv0QI8kJ4dqiIdXK/LgJr0Q+X+Q/kS2
	4pXvxnOE3mbYO32tjQXOK+FI5bg7wXg8MjoghiooXGiZ
X-Google-Smtp-Source: AKy350akQ/g9wk/PdB2zm0IF+cO4ZlUgymEQ4XvSk8km3oMg9H8LxWvJ3CZ1Wd3hC9OCLfwunnmIjA==
X-Received: by 2002:adf:ed87:0:b0:2fb:a0eb:feaa with SMTP id c7-20020adfed87000000b002fba0ebfeaamr5500961wro.17.1682007604385;
        Thu, 20 Apr 2023 09:20:04 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z18-20020adfe552000000b002f3e1122c1asm2371335wrm.15.2023.04.20.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:20:04 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] Squash to "security: SELinux/LSM label with MPTCP and accept "
Date: Thu, 20 Apr 2023 18:19:55 +0200
Message-Id: <20230420161957.664328-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=fBHwr4oJSB8RJHK7H45QWlcKhm23hpBJVDYyAwf8aPo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkQWX5zmWnv6floIBZZSNusNvFzo+lf9lOu/UkF
 IJqRShoxmOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZEFl+QAKCRD2t4JPQmmg
 c2f5D/oD0KFwaDbkKyjqeXVQ4x9fkRA8PmuPtVTmrV9neEJdX8z4ZH23xUIY3AV6jsCniX5+lax
 xDthuYb6xjBU3oOQRvyzAh7TNLRXV0RZS7or5dFHkGTpns8fHaDNT0PneG2/ey93WaM9RFqC/2n
 YkIF9mvgulFGy4lB3qRPXG+OILag4oG57wdFXFWE2aqSxal7cl/JSO/hNSecONLmlSqTXAVS6nQ
 KuoLHPVZf3F9x3Qe1NaD1PS4XtoL46O4Ge1sffu4NPbg5PqN+rvv+qeKka460qr1AJqsZQz1VpX
 Q/G3HeG6wfaPkgHfUb2JGO9v7NvzdoUUFFVAqImRs9CXgBqMruv9wMdoc70eB6gkPrH722YPN3x
 XzZfISiJD22IS5NwHIlnmrmNZz2Q1GKFlSyLUBrp8rBJiczD8YHDtF2mSBJ3o6qetZ4lQXAxC+p
 ECxCdCirCTbpY9/GZtoz/v0WOMZl7xHyYcMSVguW8niHjCZPcSievaNGCV7GlOJI+Ci4TKWWSxW
 ugEDdvZzIwd3sNeIw2CpUzLcm+Sud8PAFJTaVRw2v2qmNuK06xtuiLzbwz8rRbSKujGxlZ+dSNc
 VpsWEm9PDYbBeJx41t/K7PkbGcC2At2msC8hD2WPNBXhQJR5XrW26nKcr4o34kxqOQEt1CQ1n9C vX1v3U7vIICbHRw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

These two patches address the comments from Paul Moore on the series I
sent yesterday containing Paolo's patches.

Note that I used 'MPTCP socket' instead of 'main MPTCP socket' as
suggested: there is only one MPTCP socket owning subflows (TCP) sockets,
no main MPTCP ones.

These patches will likely be applied on lsm/next after the next merge
window:

  As far as potential merge issues with netdev/net-next and lsm/next, I
  think we'll be okay.  I have a general policy[1] of not accepting new
  patchsets, unless critical bugfixes, past rc5/rc6 so this would be
  merged into lsm/next *after* the current merge window closes and
  presumably after the netdev/net-next branch finds its way into Linus'
  tree.

Link: https://lore.kernel.org/mptcp/20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net/

Matthieu Baerts (2):
  Squash to "security, lsm: Introduce security_mptcp_add_subflow()"
  Squash to "selinux: Implement mptcp_add_subflow hook"

 .topmsg                  | 15 +++++++++++----
 security/security.c      |  4 +++-
 .topmsg                  | 13 +++++++++----
 security/selinux/hooks.c |  2 +-
 4 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.39.2
