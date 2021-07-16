Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F670
	for <mptcp@lists.linux.dev>; Fri, 16 Jul 2021 03:04:56 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id m83so7692168pfd.0
        for <mptcp@lists.linux.dev>; Thu, 15 Jul 2021 20:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJBVTOs7RdLp8t7IInvkiv7Djlj4Aux1tWyvL1guTA0=;
        b=lkW3tTXcOGRnSfrywVT2dDTXpA74zXPq3tTyYYcfJ5BAUsgJjXBTeVSBX/WkYeiZcw
         7pofoYCgOyltpBauCpfpJpht3wbCWUpY7K4BBRvenrKafnKIQ4vGLvbkmKHkkoOxb+IB
         u9EQV8fLWyzwOb6pfDtfSrrTlZm4UtPa0CtB/UfPxlytBbzQ3GbnYwkOr+3REJfBlI/G
         RAZs5kfKUNYP5l6yhyqfk08+ZJKayeFTKuJcLIt8zf/cAmrlOeFD4KmmKcpLMvr5ue7/
         8e5yeV/T8sqJYbhLgR+o1Z6H7kGoHF0jUS8M0VV1xWg66k44p/TWgvmEXUEaC6uGHbGx
         sgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xJBVTOs7RdLp8t7IInvkiv7Djlj4Aux1tWyvL1guTA0=;
        b=jX6tGQk8BrvukuMVcya+7X2NwrdN67lDg+7Ld6ctdiG40WTAWu/DJz1WsfNgtGo9QA
         H5hIu1dlY99v9kzg+YSjWU+q+nWBv/qHbLhbAjjwuFlKPt/+ChEEe7TaJdrdC5rkd9Ji
         HUOhkXJzfnHJ8eInwolATAQMDslYK+7GwvsyUSvlCTccn4/ZjRvRXN+JhoVv2ertj5a1
         rH5ua3eUcmMtify932fa/Mrt3gd3yAaafYNGeOcOsSQTzPHkUfsBTpyTTcqrlAvmHJmO
         zCaK8bSVOZKaHsKqlk4pskRcr0sfipEeZGNP1Zs2Jn2AkDeHtlIQ+dn79sz14fCdW45P
         KAEw==
X-Gm-Message-State: AOAM531SjH2CLPno4n1vYSdINPqPlsAuN0ecRyDgbqKqlUHAn1q1tlFd
	yE6reYE6nAUPs/u/hMjd5vOXofCIVjaQLA==
X-Google-Smtp-Source: ABdhPJwXgAqR/aQyChuUlCbRZgf7Ipssh/UATY8quTfnyHEIK5ax9a5/8BXnE4E6WKZtDoWskPhtpw==
X-Received: by 2002:aa7:8707:0:b029:306:7e78:ee7a with SMTP id b7-20020aa787070000b02903067e78ee7amr8019328pfo.29.1626404695976;
        Thu, 15 Jul 2021 20:04:55 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id s15sm8344119pfu.97.2021.07.15.20.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 20:04:55 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Yonglong Li <liyonglong@chinatelecom.cn>
Subject: [MPTCP][PATCH v9 mptcp-next 0/6] mptcp: fix conflicts when using pm.add_signal in ADD_ADDR/echo and RM_ADDR process
Date: Fri, 16 Jul 2021 11:04:32 +0800
Message-Id: <cover.1626404090.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yonglong Li <liyonglong@chinatelecom.cn>

fix issue: ADD_ADDR and RM_ADDR use pm.add_signal to mark event, so
in some case pm.add_signal will be flush when ADD_ADDR/RM_ADDR in
process.

fix issue: if ADD_ADDR and ADD_ADDR-echo process at the same time,
only one event can write pm.add_signal. so ADD_ADDR will process
after add_timer timeout or ADD_ADDR-echo will not be process.

Patch 1 fix ADD_ADDR and RM_ADDR maybe clear addr_signal each other.

Patch 2 and 3 deal ADD_ADDR and ADD_ADDR-echo with separately to fix
conflicts in using pm.addr_signal porcess.

Patch 4 MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT is not necessary.

v1->v2:
 - remove READ_ONCE under the pm spin lock.

v2->v3:
 - Patch 2: mptcp_pm_should_add_addr => mptcp_pm_should_add_signal_addr
 - Patch 3: avoid read-modify-write of msk->pm.addr_signal and change 
   mptcp_pm_add_addr_signal to return void.

v3->v4:
 - Patch 1: use ~(BIT(MPTCP_ADD_ADDR_SIGNAL) | BIT(MPTCP_ADD_ADDR_ECHO))
   instead of BIT(MPTCP_RM_ADDR_SIGNAL)
 - Patch 3: simple the code; init flags; fix wrong goto logic code;

v4->v5:
 - Patch 3: simple the code of 'mptcp_established_options_add_addr'

v5->v6:
 - Patch2: fix fails of 'mptcp_join.sh -t'. In mptcp_pm_add_addr_send_ack
   without MPTCP_ADD_ADDR_SIGNAL check so pure ack can not be sent for
   ADD_ADDR. That cause ADD_ADDR can not be sent in time.
 - Patch3: refactor some code according Geliang's suggestions.
 - Patch4: modify commit comment

v6->v7:
 - Patch1: use reverse xmas tree order for variables definition
 - Patch3: refactor some code according Geliang's suggestions.
 - add a Patch4: remove some double-check

v7->v8:
 - Patch1,2: exchange patch1 and patch2
 - Patch3: refactor some code according Geliang's suggestions.
 - remove patch "remove some double check", Geliang think it's unnecessary

v8->v9:
 - Keep mptcp_add_addr_len unchanged.
 - populate opts->local or opts->remote after the length check, don't
   populate both of them.
 - add back 'echo' and 'port' arguments of mptcp_pm_add_addr_signal().
 - add a new arguments drop_other_suboptions for
   mptcp_pm_add_addr_signal(), and do the drop_other_suboptions check in it.
 - drop other suboptions in mptcp_established_options_add_addr() after the
   length check.
 - split the drop_other_suboptions code into a new patch.
 - add a new selftest case.

Yonglong Li (6):
  mptcp: move drop_other_suboptions check under pm lock
  mptcp: make MPTCP_ADD_ADDR_SIGNAL and MPTCP_ADD_ADDR_ECHO separate
  mptcp: fix ADD_ADDR and RM_ADDR maybe flush addr_signal each other
  mptcp: build ADD_ADDR/echo-ADD_ADDR option according pm.add_signal
  mptcp: remove MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT
  selftests: mptcp: add_addr and echo race test

 include/net/mptcp.h                           |  3 +-
 net/mptcp/options.c                           | 54 +++++++++---------
 net/mptcp/pm.c                                | 57 +++++++++++++------
 net/mptcp/pm_netlink.c                        | 10 ++--
 net/mptcp/protocol.h                          | 24 ++++----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++
 6 files changed, 97 insertions(+), 66 deletions(-)

-- 
2.31.1

