Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582923211
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:07:26 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id b21so5419028plz.7
        for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=aAK0Hk9sQplMbMVOahiEPT0zCG/bcZixhQUs6JjgYAE=;
        b=BoFLMHa6ESFwYtInqRtOotWiDMVxeEXVh+tV02Np1fXJpcj/TViVuluoBOh/clhLj0
         mSMVRRLxLHmk5HL3KAzIT+4csYUVRw+oQeB3EGzCuFuX0AhhtOH0CT94sc6hDoidMjVj
         9kxuid0dA72G3cLPTFn1HpldEwWGtQvGhhwJUuS8fIYxUdLM7gUMjXo4QbYN9pgFGNK1
         iEfsywUEEqnhJQ8pmOs6RAfR7c0IxFqPeMbPSa7H2jvdHQwWevmniOuVpwBEJEym1FwU
         BjioAeHrHbhS+2R+SRkod9PJSUa+QD1duuqMhadO1vrAtj3U5SkVMp+KTI0U8T1LUvS4
         B68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=aAK0Hk9sQplMbMVOahiEPT0zCG/bcZixhQUs6JjgYAE=;
        b=sfdZujilo91lL54l04bNFLN891JhH/yLtls6LJS5uBbjbpTG4S/dOQ8rWP9E+Fi/eB
         ZSzwcejXZuBmL8DIaExLyXrlQUcqJr3w7oZH15f6tM0BlYRLPt1kmxvPClKhYvgz80n9
         uIIyXN09nQ0ruZ+MNQ+EE6wAbI010wa/z2U25NzNh3f8eDZ0TVa4j//580m/t/OTbdaa
         r45t2cjQ8L9zWoB1ZmzubxNYmCFZT6Sd5qG7TYwIhEziEW2EI/I+l1xAnqx7/b0VQzcJ
         Q5rL7hiZoUf7hPwlPP0ePj+MtQGCO8Fc5nzO56TMebS9gZLVayPOGfy6ZD9sTe+sVjZC
         VHZQ==
X-Gm-Message-State: ACrzQf1Nj2PU15Su8jEip5LDPPjQmcjDZ1VAS9HnwqLKgXrXDxq4z3gG
	16dDL025Ih0C93dLsWwnl4iUu8Lxdm+PH/ol
X-Google-Smtp-Source: AMsMyM4V30pyHmUwD41fPmHk6SeEhdX9i/0uonliaRYEp05izLnVRoz3CP0l61iMsA/68dS2kPDn8g==
X-Received: by 2002:a17:90a:62c2:b0:202:fcca:60cf with SMTP id k2-20020a17090a62c200b00202fcca60cfmr9356049pjs.127.1663762045759;
        Wed, 21 Sep 2022 05:07:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b00174fa8cbf31sm1869233ple.303.2022.09.21.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 05:07:25 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To: mathew.j.martineau@linux.intel.com
Cc: mptcp@lists.linux.dev,
	Menglong Dong <imagedong@tencent.com>
Subject: [PATCH mptcp-next v2 0/2] mptcp: add statistics for mptcp socket in use
Date: Wed, 21 Sep 2022 20:04:40 +0800
Message-Id: <20220921120442.320727-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Menglong Dong <imagedong@tencent.com>

In the 1th patch, we do some code cleanup with replease 'sock->sk'
with 'sk'. In the 2th patch, we add statistics for mptcp socket in
use.

Changes since v1:
- split the code cleanup into the 1th patch.
- decrease the statistics for listening mptcp socket inuse with
  mptcp_listen_inuse_dec()
- add MPTCP_DESTROIED flags to store if mptcp_destroy_common() was
  called on the msk. For fallback case, we need to decrease the
  statistics only once, and mptcp_destroy_common() can be called
  more than once.

Menglong Dong (2):
  mptcp: introduce 'sk' to replace 'sock->sk' in mptcp_listen()
  mptcp: add statistics for mptcp socket in use

 net/mptcp/protocol.c | 34 +++++++++++++++++++++++++++-------
 net/mptcp/protocol.h |  1 +
 net/mptcp/subflow.c  |  3 +++
 3 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.37.2

