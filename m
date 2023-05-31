Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11315495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:17:02 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f68fc6b479so59938215e9.2
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542621; x=1688134621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GTuUi9gxRLsh8kswWgOW9PlaqkRS5+59fPDJtvK0qU=;
        b=OlvNJc3hPKuTBzDvnX3O6lDm/1VenlEdz9kIY43t2JjboeIGmtvSzJ0TMUhcMtkujS
         GRxklB1c6NfcLxxyAAoBCK3UMSfoXU3rlAOSwp9wGnZy/TlRDnFyp6ES0yd13M/i/kmO
         7HTTjUHHjM8AoFrmBWnAYDiWmg1sABhEhFlbbQiKtAwKj5tdjGKyHUOPPZpVIBcNPmX0
         E6Tsts8eymvsb8F9D4SZ0oX25Bu88RMpmtbmvesfy733aQGXu2ql5WTKPU84gBCpxFas
         LHtBVx1t3Mrn5/yOUYdPGShO0QzJOyqHOUCN+fyXj79qeqfuxYnsqDgety8ZO0e23bnL
         s7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542621; x=1688134621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GTuUi9gxRLsh8kswWgOW9PlaqkRS5+59fPDJtvK0qU=;
        b=QsjmGJ0j2NiYvQmvDe5oAcHnMREDB5n4rLh3REwLjIUNrMMluFtrP/9HyU3KGIs3vI
         kttHOzKUWSGl/p7+iGSZqEfmRjOrEWUN7YxEouBlmSssbaEeCbRmb+ClFi8FONpYr9XC
         mzFVCqU+d2WZiLzurXA+6bhFaWjZ8UJ1IF0b62iydgN5b4H5bVcGe6uZUCoqRvKDD860
         G7AtS4q6qa+MA7/8xqySDamlEKfF1a5j0nPkcksT3EralCmCuZ1laGjWzLECQHN+BYRa
         X4/Cwjloi7Gq/jtm7z+kkL7Caje6QuJDWmyqxYoRqOZrzCtlcwHKD3jxYevYDjwSZ6+E
         65LQ==
X-Gm-Message-State: AC+VfDyKmXM5IJcix5PvAne9KZjjomYI3tftXiefnRYPd8zfXkaYy+qV
	0X4L+VawEy8317Qv1HU3xa8LxU4S9UjG0my2c53Aj/5+
X-Google-Smtp-Source: ACHHUZ4ADGN8xIwtJeZP9Du/huVvJ90Dc1n86HejLGussR4hPZLRoN3U607u9nxgpdAAXvg6fxR8KQ==
X-Received: by 2002:a05:600c:2283:b0:3f6:1317:ca71 with SMTP id 3-20020a05600c228300b003f61317ca71mr4259681wmf.14.1685542620905;
        Wed, 31 May 2023 07:17:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:17:00 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:52 +0200
Subject: [PATCH mptcp-net v3 32/32] Squash to "selftests: mptcp: add
 MPTCP_FULL_INFO testcase"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-32-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1666;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ziktV6RHZdI6610ED5mMHdiYrmlClKYN622Wg6NS3Y0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bEZN+BUesbfqmbSduBjn1P2B5NCTvimJ0Tw
 DBmqikTb8mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWxAAKCRD2t4JPQmmg
 cw+jD/90FNy45uyS1z/v+xhgWZw4J+KYXU/a0ca9RaiMeYvdN7xb6A43w9tlwxfbscsmVqngJKv
 vvlDYY/Ko8HPJxEUarYK2edo9Tl+E8vPS5rHkSVdCQD5Ro5oq/T428+ilPpV41O/0ONiUrQni2I
 OftOd3TKiZc9q2YV7CMDtHLEQEqb/MyrxebWe0rYHE/ogT1DuLxHyqytZcDMh6EfdItKFVv0QFn
 JN1OaVHbJs/rRroyFZim/m++fKem2G9jMPT5drJmwHeZwQHUfMd4boZuwdIT17qmRqIdtaSjG5B
 7uNaq789iHv2s1CC4rtpxOmb8g46vkR9rywd42aSO2pygZOtzDSeqdjEYEApOZiYC5tW27y7yhP
 /Wuo+2LZG4i4oc5z6U2SHqTTJn5bp0rjo+enQeYTdgUz0lFyj9GBlCP8TF3Ve9Emd9ZOMCUu/mn
 tHspx6dp5XMAngVr3i0OiCgnvKJmbV+Uo/V8SBLQ6YwGfhc17eDuBt5Bo3s3yI6jsRWQFkhmTKk
 Yt+mv6PivmDzIJFB1yofVv1OvsR4VwEEy8S5eVGo4FV82ydiSNlaSMQVcu2EvMjWr8JeST+auek
 oFVGjZYXHHw16fygqicsBFuxGLaYtKtcR9cEMDRgIaTTeB88kLADcOCNN0NsqfuXgpgHsfphbZy
 3ldPp9WSyXaYXWg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Relax the expected returned sizes from a getsockopt(MPTCP_FULL_INFO):
the sizes should be positive and the user one should be the min between
the one given by the userspace and the one from the kernelspace.

By doing that, we support new fields added on the userspace or the
kernelspace sides.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - new patch (the mentioned patch has been sent and applied while the
    v2 was still in review)
---
 tools/testing/selftests/net/mptcp/mptcp_sockopt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index de897f77e174..5994a078a65d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -519,10 +519,12 @@ static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
 	}
 
 	assert(olen <= data_size);
-	assert(mfi.size_tcpinfo_user == mfi.size_tcpinfo_kernel);
-	assert(mfi.size_tcpinfo_user == sizeof(struct tcp_info));
-	assert(mfi.size_sfinfo_user == mfi.size_sfinfo_kernel);
-	assert(mfi.size_sfinfo_user == sizeof(struct mptcp_subflow_info));
+	assert(mfi.size_tcpinfo_kernel > 0);
+	assert(mfi.size_tcpinfo_user ==
+	       MIN(mfi.size_tcpinfo_kernel, sizeof(struct tcp_info)));
+	assert(mfi.size_sfinfo_kernel > 0);
+	assert(mfi.size_sfinfo_user ==
+	       MIN(mfi.size_sfinfo_kernel, sizeof(struct mptcp_subflow_info)));
 	assert(mfi.num_subflows == 1);
 
 	/* Tolerate future extension to mptcp_info struct and running newer

-- 
2.39.2

