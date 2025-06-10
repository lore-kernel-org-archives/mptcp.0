Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD592D3A88;
	Tue, 10 Jun 2025 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560404; cv=none; b=sLZnlNZSf+UGA+1YqUSyDr/z0bMbd+th9AcOx0xI/9XMlfayxq1Qc1yZywl9eHf5+Cj7pimB9eOHht6csIPYYdmUv4pgBqeP8d32XTTsWMl4MtrJtOdRS1y+iUfsIToH5Wc/5RLWgFeIhZPM38iF/uTpQx9qhLBzurGeAAUvA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560404; c=relaxed/simple;
	bh=Fle9/5/Kw6s4JzhtO4dO+lRTtSR28VmEFpyBncawRsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuP7RAP06SLsJzKnMJCzmegbR+to0t/2xDarR4k7Un4AdSRs5OtMfuQqvbChpCow6CMfcffa9ZfaTsrGIgN70bEBrpVdrvDByT/ZE5nH6m2LyMsG3j0fs6agesSH6mhs4jBEXfI0MGLMBnVei1TRoYxMi4sOAVplxTef6HAQcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSP+CzvZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSP+CzvZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so64942555e9.1;
        Tue, 10 Jun 2025 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749560401; x=1750165201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzoV36DGLFEr0TlLZ7ZuNJ5ZvgQ7mL/O4zsxTiHx7SQ=;
        b=DSP+CzvZjyrqUVXRYCLLOWhf5+soHlhPVnWNt1Nmyw85ao4lE0F55ROew4s6oNjuia
         +OghzbHZ70ZbCqSnb1C4AZCfwFzHSuR3xm81czw7xlDn75G6bawePe7Xi2csE78ud+cT
         wGiZVWLDelipTT9rJhoYIC89H4+bNdpTlPhGpwYv9qrihXrXgOsPBM0xZFFhDP3SUj9L
         9IGi5/L2iC0ZuczPZT+8h/O517F63wsvCyJm+epjm/x27XF86qNImoPjVc+R8xrmQtcw
         paGyUHgsneKfqrrKmhhcwS3rqhotqK4entr6bYUxT6KYAEtiNPDuAknq9/uwb5JrI0TA
         KePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560401; x=1750165201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzoV36DGLFEr0TlLZ7ZuNJ5ZvgQ7mL/O4zsxTiHx7SQ=;
        b=ESJsgxx+hjRnCqT+35sVkOkPExocu6u9j0NQVfoPbSUkMZgHzMofTXpWV4909UpL3T
         ZCcdZD2smNwVTE2kSBbo2MFim2bHR5YWEptc/9ho00A4avykhwOhxVpgVLSU0FgacGzk
         usO3lh875c4Iu9GSCTg7hsgTFN/pz2cJIPMtnRFFPl2/6VGOCOVyP6Y8jY8CGAdpWBs8
         xaFrBhFIj5TulRL5DlZubdkVNiZSGW41w9PSbMqUoUp9YltYq+EXYE0KfnYNZtbDhUgw
         dAKeW8sULF3bBJY3c7UhtfS7FhYd/ShjYwZiXptot2N/oFtj5gLQBC2tw8Xhj8CNJUye
         qGTg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0O/WMp6I0U8ItUtlAjVfA9lXbHZm5hykbd7uL7MeDyysmuBqwIV+GElGW+OeXc41Qbp2rW41wn05hXLsenkmm/1Ziw==@lists.linux.dev, AJvYcCXteVslfpgWMPS1dyNeFldA0uno8wT+HQIChAQHcrwWhKM/1nzjvLVCfgb6xF56PMF41N7Vie0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzHaKrcmui5Oe201C/4qBjZjDFqIVDSHFV6T2v2Q2h5XnrY62lM
	1XTWdGnO2+wDPRrDDjQ2mSMo51VW6dkU2ia0iYZZgEfyRBYWk9Ir2Dk6
X-Gm-Gg: ASbGncuQGM+IXh6notsRj/jokVKPy05ogS8Zg0xPFd+gfLiMvc8HWhfop1uf4cWY6R4
	cUWyNRPTwuzRQl1f5jpkJgwM+WGPoaWm5y4rvMxt8kMOfRk3UazwrrseMYBe3/xV9klm+pgAG/c
	L4X9kUNp8ZL+eX0+rzykj+9V3guXH0Ww31Mw0y5038n7eyQ2KLa849MV9RBqE2ZSvvTVJCmaoZV
	AhnbWaN3ptn72+beoKoevSU0jC8GLGuzPqNH5QrOKyQFdFJULmsBxgN4XvakDmDPAV1eaFgMXbS
	wwFhKsDVuvSMVVDx5J6qWVESRBsG6jKgw0WEwoc6QKtX59sjlvtilVvBNpXMTK8LwrDsUFt4lAi
	ITBezYi4nzZeok9I=
X-Google-Smtp-Source: AGHT+IHeslDW7TrDYFjTLS1WUYy8KcNXu0a/5bqFGKYi1tTcyCUMUHXRhABodi53HlW4wRTg2Az3ZA==
X-Received: by 2002:a05:600c:1c8b:b0:43d:2230:300f with SMTP id 5b1f17b1804b1-45201294a71mr163375615e9.0.1749560400829;
        Tue, 10 Jun 2025 06:00:00 -0700 (PDT)
Received: from imac.lan ([2a02:8010:60a0:0:6117:17d9:610b:9e0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-452fb381abfsm130563485e9.17.2025.06.10.05.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 06:00:00 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	mptcp@lists.linux.dev,
	kernel-tls-handshake@lists.linux.dev,
	bpf@vger.kernel.org
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 4/7] netlink: specs: fix up truthy values
Date: Tue, 10 Jun 2025 13:59:41 +0100
Message-ID: <20250610125944.85265-5-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125944.85265-1-donald.hunter@gmail.com>
References: <20250610125944.85265-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up all truthy value warnings reported by yamllint in the
netlink specs:

    warning  truthy value should be one of [false, true]  (truthy)

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/devlink.yaml | 8 ++++----
 Documentation/netlink/specs/nl80211.yaml | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index c3534e7e063e..939e7e12fe30 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -744,7 +744,7 @@ attribute-sets:
         name: flash-update-overwrite-mask
         type: bitfield32
         enum: flash-overwrite
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: reload-action
         type: u8
@@ -753,12 +753,12 @@ attribute-sets:
         name: reload-actions-performed
         type: bitfield32
         enum: reload-action
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: reload-limits
         type: bitfield32
         enum: reload-action
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: dev-stats
         type: nest
@@ -917,7 +917,7 @@ attribute-sets:
         name: caps
         type: bitfield32
         enum: port-fn-attr-cap
-        enum-as-flags: True
+        enum-as-flags: true
 
   -
     name: dl-dpipe-tables
diff --git a/Documentation/netlink/specs/nl80211.yaml b/Documentation/netlink/specs/nl80211.yaml
index ba0601474eff..55555038759f 100644
--- a/Documentation/netlink/specs/nl80211.yaml
+++ b/Documentation/netlink/specs/nl80211.yaml
@@ -680,7 +680,7 @@ attribute-sets:
         name: feature-flags
         type: u32
         enum: feature-flags
-        enum-as-flags: True
+        enum-as-flags: true
       -
         name: probe-resp-offload
         type: u32
-- 
2.49.0

