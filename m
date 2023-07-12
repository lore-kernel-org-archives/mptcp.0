Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E8214E0
	for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 16:03:28 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so76998425e9.2
        for <mptcp@lists.linux.dev>; Wed, 12 Jul 2023 09:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689177807; x=1691769807;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pVrDKVLrRoBIdmotwI0bl0cRtLE5t/gXvD0PdoVIlW0=;
        b=3d5D77DkJG/5PF3HJ1xCcbtAzf3FieOsoPpkBf/jt2NUBU7vHTA9/ctUW16EJzfubI
         rwLyIXRNarc33SMbS9jMov/IxChYmnTCl7s5cEmFrmCN1WTpoyzyCBfjPOlaIlsul/IS
         vZpLzGXHcdIVB3WHPKxVGn+i5gX3+WJKsBsxGso125uvnig+myb1SVKzPRIMl+NLDPxZ
         iMZvSoroR6D0/vE1fVqrkFjP2iW6kqgoZt/Z0ImpHpODP81GNP1KXwR5c7kSohuxV+8v
         RHf9sNLMLZ2paenx6rftISTg9XuuIUyjcLnBDLYY5/bsnSK0lEa6UH5Wm5LAA45Kqan4
         SDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689177807; x=1691769807;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVrDKVLrRoBIdmotwI0bl0cRtLE5t/gXvD0PdoVIlW0=;
        b=FigeipEc159fwHiwpV1oK5gg95ZlqZ/Adm1Bcg/MxNCQjNKWB30gaG/N8X3mVHPEW5
         RRM0c/WQaQWN9WmhCe0eoZ3cciZZZ2yMHFeZU8wkjer2eqyWnleln9kxKwSiIhlQX4lz
         OlQ6Jx/aUQrqhxKWXp6BpWaIhuqZWLlKm5a7/mHYv4YVLXoqeElbWvEyOtrI0l43FZj2
         sY5UrRglyeed7koNOnEilnffZ7sCz+VfPOh2WhR/GUytOWLacopyYjKcz1QvOV9fHpI5
         TCCfjlxs5EXpWHrzM/Ha7nCZl5nfAJqrbBSG3iDVAfbzgr/j9Fu8gBmyf8tY3hU9pnnb
         Ly3w==
X-Gm-Message-State: ABy/qLbfgI/O7Lm1jZIZAun90BLCKIWMnwGQ+zCFfGtf3LxLXyBM8Ggy
	WcI7evDbrC3nITMXCXF/vOD1Cg==
X-Google-Smtp-Source: APBJJlH+7sqLGE9pzV723LSbLp79MxZ1W5SgCdFDRaujJmlyRRZ+nJzzx2R2Gj5mnWyKLSZG/Xr6eg==
X-Received: by 2002:a05:600c:2143:b0:3fb:e58c:7758 with SMTP id v3-20020a05600c214300b003fbe58c7758mr17587183wml.3.1689177806872;
        Wed, 12 Jul 2023 09:03:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003fbb9339b29sm15972581wmr.42.2023.07.12.09.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:03:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 0/4] selftests: mptcp: join: pass args in new env
 vars
Date: Wed, 12 Jul 2023 18:03:15 +0200
Message-Id: <20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-v1-0-f1c8b62fbf95@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPOrmQC/z2NQQqDMBBFryKz7oBOpaW9Sukixm8b0Bgyowji3
 RsK7eIvHh/e20mRA5Tu1U4Za9AwxwLNqSL/dvEFDn1hklrO9bURXpJahps4wso24/+lGAeDmvK
 UzCdeFDzO3o2MuLLrb5dWpO28OCr6lDGE7Zt+0E9Gz+P4AGK7QEWUAAAA
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=GEejwFVT2b0O7wgcdRObluk8euMcTBWV4USRAcrr84Y=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkrs7N4/wB882a7Isr163i7YP4jUtzCkPe/7B09
 zxNDemgW/uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZK7OzQAKCRD2t4JPQmmg
 c9gLEAC2GPRKf9dmO0GS2t2aLk7wIMT6WFXf5FXrd15UvwlhYeuXMbrFTmY/DhM+SMG/mz24IlA
 xiHdS0np4QbZv+sbo8Y9yZ+q/ZD8Bf4DTZ+lZFV/39qSDiDGKZ5kaGH68mVNf6h3LR2GWZ3idq1
 mPjBD5cVaChh/7iZroHm1frwI83NT6P2pQzSEOo07ejgj6CtjpZa8nSQ0k87BJwBroD2yL4gig+
 2NY6FnQ6Oz8xhJbsw8dVnNxq5unB3IO03gImLC6e6yxikfrCBMqI5Xiil8ncuzFE3mdqvGSxDUI
 dl5m6eG1fdcs4MEwDPjxo8d7P+tsjrRdy5Jft/e2bhyxVlXylPubul7YCzM5mmcPf2TGcsYiuTj
 AkMJbFVzYCfl4wkj8mDd63tvJHQiSJIcglCVST+nQSCkmkPKnqobeG3Vraq83nBWEd67Lu8x//D
 EcPeVYeRCRWMAeOyS7KqZ0DZ66i6SG4A7eFjPoEj1V9EPq5yLMmts++AbngcvSkjzlGdtH2iyif
 gPZqO6nofmvyW5qyQqCqOIlbWLDxCyzrH7eI2ZS8IirCftSLmLjh03qQZ90+xcZgKmyg1BMwaqF
 yFZWn+JHmQEo7dmkFiAQNBZlp6Ongh3uD+0EHTxmOMemVt3ZeZHYU+mtLADvQIcCxi0A5BBsW0J
 88fNNmj2hE36/Yw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In this series, Geliang did some refactoring in the mptcp_join.sh file.

Patch 1 reduces the scope of some global env vars, only used by some
tests: easier to deal with.

Patch 2 uses a dedicated env var for fastclose case instead of re-using
addr_nr_ns2 with embedded info, clearer.

Patch 3 is similar but for the fullmesh case.

Patch 4 moves a positional but optional argument of run_tests() to an
env var like it has already been done with the other args, cleaner.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Geliang Tang (4):
      selftests: mptcp: set all env vars as local ones
      selftests: mptcp: add fastclose env var
      selftests: mptcp: add fullmesh env var
      selftests: mptcp: add speed env var

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 271 +++++++++++++-----------
 1 file changed, 151 insertions(+), 120 deletions(-)
---
base-commit: e0f0a5db5f8c413cbbf48607f711c2a21023ee66
change-id: 20230712-upstream-net-next-20230712-selftests-mptcp-use-local-env-ad964224bc2a

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

