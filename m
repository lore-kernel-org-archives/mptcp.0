Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84C15495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:58 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so43299785e9.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542616; x=1688134616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FL8W8z9o/ipYuFx+8LfLlRAHUbvdR6biAlqyuRduKrE=;
        b=mqQ5X8FM9H55C5acDkFX40vGJvGk97ah90KvKuEARxpw535u8D+10CgIx+unXxdHl1
         BtY5r1//Xv0CRfdQ7HrLj+633FgX5uz2Xo2e5lKRsc+mbXEocLlsMzAL2JwHEj+O/nks
         tVK7jIXjtJcR1idfKeTKPfr9Au5/VU5QC3i6REvKxgTRNmhIbdAwy74HmhI9TvlhUSuR
         +Rz+soxRoxqtVRFcdNcWVzIqT5RRapkQNTQTb/gKazLHMH4sgLiFGAPEE4C4Yq5TpSnT
         vpHL9kZsuuxDT8lyWXz5AW+7wQeZHeqd5cJhrhLfQC/L0KSFTN9eACqWIbUkYsYDOjzz
         b73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542616; x=1688134616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL8W8z9o/ipYuFx+8LfLlRAHUbvdR6biAlqyuRduKrE=;
        b=BlWEJujMufkVq7cffNZLgB+zOTe9GHKfkHnmkg3D9vxw2WQwXwQKEeEUv44prmCoXn
         u94eMXCsqSoSRoKK8EkNw+GsSdsHPMey0OzsCqTqiFPbvLydAnIN3rBhBDvaUVFTatq8
         UhaGRYWqn9NPKLT1OAX/KoX/cGVUGZYkpnr6Yc8ed5YT4q6G+JqUmFqHgs8+KePQDC/e
         u+Smld6ObIvHl6iopY/kfjGHGcB1bGb/WgHMiIs2+StRxfvL0hk+nTDTDjkTSevpBdBh
         f21wKaKSiHDTWl+5Rokhvm1mjrmb1NpXmSV1ljJPhHqeZltDR1uVDxwH1lPV7SnvLSM0
         RUpw==
X-Gm-Message-State: AC+VfDxcNZv7WLUqfn9WDPZcxMxSOwqR+y+1ukpeolQfyrvymrce51a+
	3vrFKBgkUOtsUhREaxJkq40ls0UEwqrgRNEXP5uOE1XF
X-Google-Smtp-Source: ACHHUZ4AEGN+wo5M6sIMp0mRCAGxAgFdOxR+IV2XNHs9Z339AfxFz9IEgsGfSk3kWNaoXmGkFtgi1A==
X-Received: by 2002:a7b:c4d7:0:b0:3f5:ffe7:bf11 with SMTP id g23-20020a7bc4d7000000b003f5ffe7bf11mr4586760wmk.36.1685542616794;
        Wed, 31 May 2023 07:16:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:56 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:47 +0200
Subject: [PATCH mptcp-net v3 27/32] selftests: mptcp: join: skip fail tests
 if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-27-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=1uPa5TCKXv9ShFyUOEwMWeSkBp6bH1KV+L8Me7r22BY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bEIasR/IG9jT8c652dGPQ8vw41wfn00Rj+W
 VoVebcMPLWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWxAAKCRD2t4JPQmmg
 c0e5D/9ja0Mmy4isDRSeaax7nwHX/0785Ac3ZzTF5uo1Lgucb+ZkE1bAMoDAQyxmYqCSe89jvfP
 uWDzDJ3R1at1F0dxykCnDaZ8RkO0kWKEyFKrSj47mTBfa8vXTEf1Yo+tMHIo0R8GFRRGQvybLaK
 mwMSiC7VnR+xfOLxNL6mJJB2LO52N/3DLm3ifK9iyULSDEncqRcdgx+q0mmioI5TTE8/L6px7Bc
 pr1SvZjJ2MEmdjKu2k7eVjWhd/s6ZV3PsYS/MvhuuQwatB5qKsfY1M1jkMFegVN238/sIEGC7Y7
 h/aEDp9Yr2H3AXnVEmzNdzhOOngUqcnOoy0eE+UNJwYc8VzPVS10012912NPmVzrL6Ni1yLWSw0
 DQHR8bdVk0fg3RRw60ehqSMrgDxZulJOMU7nU3lkOEJy4t2RrxAK5K3gei1as1khDUxK8bR9l+V
 Uzdy796ac1lrqzG/t/x6+UqfD/d+GdxHsG5XEnpaqNeEglprT6GfFkuzEzqmyjVh3egWLjI8vyz
 4a5XQEN1dVXqaBXow+Ob5MT/mE6wm8FfBptbp5iYGfb66CDcBKypGIGbryqidLYqerAKu/EQ6ch
 bj2+JllhXKqazfe5593RHU7ivPLwrw1v/piMhX1vGClj4ocSVRbLAmmAoJOa6wSN2mvJyHL8VGX
 BrXmfLO4e1gOoyA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of the MP_FAIL / infinite mapping introduced
by commit 1e39e5a32ad7 ("mptcp: infinite mapping sending") and the
following ones.

It is possible to look for one of the infinite mapping counters to know
in advance if the this feature is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b6e074e171bc ("selftests: mptcp: add infinite map testcase")
Fixes: 2ba18161d407 ("selftests: mptcp: add MP_FAIL reset testcase")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9c7b620a5c12..0ad8cce088d8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -386,7 +386,7 @@ setup_fail_rules()
 
 reset_with_fail()
 {
-	reset "${1}" || return 1
+	reset_check_counter "${1}" "MPTcpExtInfiniteMapTx" || return 1
 	shift
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1

-- 
2.39.2

