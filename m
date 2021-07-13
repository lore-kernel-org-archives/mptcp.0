Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4C70
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 07:32:23 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id h1so10645065plf.6
        for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 00:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=bUhf4NRh7JoREpAQ6f8CE7AHsYHa6gG8ifkHubQ/lR8=;
        b=e0AQtnqOtT/NS4wZjCIaGrCZka0tKO1E20+w63y30oqftwa0wjVy+Vgr0ptH6TWSzT
         qCCfvfXgXpNdkXyXvbyX8u6Uub1kWNQnixx0K+HbMPUJ97EKLOMlQcb+NKP1k7IBMBSL
         l6AdgNeZbLZfROf2L2h1Xwch7t5v7IQIc3Yx5cLQ7fcGQcIRm/hYIAkSf4K06YOxpEqW
         oBY69Nub/pzVBphsI2NdU77axy46dudCC6h01QZ+6/F6u444qSYPmeRTfiw3SUB7Vfyt
         /boe09etm857BIiLIKrEBjX/+t/ZSagk8m4ulhxavljWfDS9BzqzIhHfAn5unaRC29Uw
         S+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=bUhf4NRh7JoREpAQ6f8CE7AHsYHa6gG8ifkHubQ/lR8=;
        b=oI0GU8ruBc309hhmL0EAgYyfa8ZKkqj9pWfsXBX7bLtGe/ZScWMaawEQMc10Ca2KR2
         xRD7qCwMSHTzxD2n3BLQMuk1iSkB/d309HsKan7bRm7rQd5LL3OsB5vaEcBH20hRkb7m
         cPeuLBEjZr2jXTEUNtNGYkKib6DncFbQE7TJYygu6h00GLsu957Y1KskRVdv0dyg5Ave
         O1ydnwktQNy11gzFcV8aQLk7QfAnuW6eOtszfkYKN1aLvSAgrUF+bMnWqOwW2n/p7TjN
         u83tyeeyBQq4OrmEr4Wh9Y2Lns/g4skAq6UwDenN9WpIwRRIftXMmHdnv09tCVy7Eh2z
         aZ5w==
X-Gm-Message-State: AOAM532Q/+RnPJIv54wlcAsPkQi9Ug6fAhsG4ZSyR7vUcdfGDNEA4ABR
	PMZPlsrX3pF1rk8TOAeZyM12hjQj6cJSkGB/0m5CdMXTbsfEOA==
X-Google-Smtp-Source: ABdhPJwVs0z/c1UmM9usTcqB7GiasnqRGTg0yGheeXwvTgg8tMYCjOsQzAntX9QzozhU/CQuWrFcTmpt8wLgqcGuN7w=
X-Received: by 2002:a17:90b:957:: with SMTP id dw23mr11848452pjb.123.1626161542888;
 Tue, 13 Jul 2021 00:32:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <756dcceaa255c54b7bd195c719ede1f7ae791eb3.1626158100.git.geliangtang@gmail.com>
 <f0920ba1126ff81aa1acbff47e805e5573c64abc.1626158123.git.geliangtang@gmail.com>
In-Reply-To: <f0920ba1126ff81aa1acbff47e805e5573c64abc.1626158123.git.geliangtang@gmail.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Tue, 13 Jul 2021 15:32:11 +0800
Message-ID: <CA+WQbwtGmfH7JtZUAUN7deZwVwJ=9o_7dZCk=7gC7h63sQMMZA@mail.gmail.com>
Subject: Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: build
 ADD_ADDR/echo-ADD_ADDR option according pm.add_signal"
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This squash-to patch will conflict with "mptcp: remove
MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT":

Auto-merging net/mptcp/protocol.h
CONFLICT (content): Merge conflict in net/mptcp/protocol.h
Auto-merging net/mptcp/pm.c
error: could not apply bf1fec79a2bf... mptcp: remove
MPTCP_ADD_ADDR_IPV6 and MPTCP_ADD_ADDR_PORT

Please fix it like this:

 <<<<<<< HEAD
 static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
 {
         return (mptcp_pm_should_add_signal_addr(msk) &&
msk->pm.local.family == AF_INET6) ||
                 (mptcp_pm_should_add_signal_echo(msk) &&
msk->pm.remote.family == AF_INET6);
 }

 static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
 {
         return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.port) ||
                 (mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote.port);
 }

 =======
 >>>>>>> bf1fec79a2bf (mptcp: remove MPTCP_ADD_ADDR_IPV6 and
MPTCP_ADD_ADDR_PORT)
 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }

->

 static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
 {
         return (mptcp_pm_should_add_signal_addr(msk) &&
msk->pm.local.family == AF_INET6) ||
                 (mptcp_pm_should_add_signal_echo(msk) &&
msk->pm.remote.family == AF_INET6);
 }

 static inline bool mptcp_pm_should_add_signal_port(struct mptcp_sock *msk)
 {
         return (mptcp_pm_should_add_signal_addr(msk) && msk->pm.local.port) ||
                 (mptcp_pm_should_add_signal_echo(msk) && msk->pm.remote.port);
 }

 static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
 {
         return READ_ONCE(msk->pm.addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
 }
