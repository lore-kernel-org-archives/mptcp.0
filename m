Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8836AA1
	for <mptcp@lists.linux.dev>; Fri, 22 Nov 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732260861; cv=none; b=sF95ZeNeH7JOtddznFLINtfAw3Tvd34LrH6zE57o5JZ4AIRw0BUFapLtsZYY2vvYe2ErRggY3LkV9Qt9iuNa1ajgq/HTwQiictzVqxfK2FEQ3d4Eq6Bk938xqDGjuFNMKCMWjBiaIowyShZy9bLgg71YNQJNZ6T9/lJnKxFAd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732260861; c=relaxed/simple;
	bh=aKHi2s7g0Yh57xPmgKbyOF+bAC1mWROyHR/WAGtBZsQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Y41FTpyJ4Z4cJFdYsJHB6PGO2xZytcVkSw2jqHl1+x/UQExNSCFJaL35zcGDNE6Km3YC8TZrNJoCFEHfZzFljDQZ1RBjcHlV0fVPL9toYkS7qfbUfKcjrmcHL/jpg2q2BHPFw/VVL/BKNTl6jj4FrF1Zy2flvPJrwb9bRhEWL5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTTu0eqr; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTTu0eqr"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5cfc0209eadso251419a12.0
        for <mptcp@lists.linux.dev>; Thu, 21 Nov 2024 23:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732260859; x=1732865659; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WP7Qyyn9P8aoIGhU2FYV6anw46pGQsyVROPp57hHtvU=;
        b=LTTu0eqrbe5vEiMeVjF8X6sCHCaIfdXf0s/kWb+kdbrryUUangVnmmjEj9/57O1d8Z
         XGimqNclp4xID42VIb0TOHfhxAuFrFVyTnef+v6mEQgxRdhcU/rTacnigNOkV9zySbsi
         CM3QcwyZ0cPh4bjgcbWA5629DU4/2BxELaGvl+sKyymAfWvBM1+kp5Dq+vY2EsnP9bTL
         bxDZ0Gx9hEhV7cXdT4c4cCHo4xjsDpp3Z7wT8L/IvvGgAupLpexVDvriMlGgG32riHcx
         e5oc7YNqdSO6tRzHtJ3m5EVKO0uYoDxyDBDHmrDvLRv3+hbbM/UwSR9zEpEv4ktHrnU7
         2ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732260859; x=1732865659;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WP7Qyyn9P8aoIGhU2FYV6anw46pGQsyVROPp57hHtvU=;
        b=hIQPOkewkhy2QQspC42wOoSdEs8HCC0NB4/8eBccGdtvYfXQGJb7fVV4Rqmss6LaMp
         PstEL/jG8MMovWXBL1oB5k8m6/77TtU6QqQLelGMhtud0+hXZCPFRpQb7zSdhijIlVMl
         wqeWEZNEFVKuHgv+d13lU+P08NjYXTDAkUhSJjg1t678j094u4woKAcBUkfNpO1PMAJZ
         pQdSAzbAJvtDHqKfHN7d8n6gXvbl71vO4fuOFhZvfCudJEaawP+AKukSfOVo6Iz599qw
         P0IkGubvkMY7d+0FPNBw0nUJUmyFCOwmcWb5n4ac8tLUqwCxpvfZU3CDPnmOHHFmCOIT
         Ddrw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5mqm96vq9YZEWnZHj6mYY+d3Loqa10qZxd2FMU/vThSN/4k9mPqNbbehW4HohGiqTQUjfg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzis8e1WTIUDDG0sunwj0EcBOnpJNuU2UNfy77BgHiPTqncLHNV
	bmHe3tiTiVzs0GWp6pdFJrF5dN3MlzcrgpHceTnXo7U2yRQdzk6NWahKGZFpqbbZfzpPMqwOBaA
	RZ3F0Ww3BTGSTId9FKOZmAnsX/Is=
X-Gm-Gg: ASbGnct/x4Lm5BSHYmXqAgihgTchDulvclGiV5bCOwwWZIkbHv/oBX0gEXz0YAwjwWJ
	MyTOxbuJMyH34drqAbUy6ol7QeVcErB2j
X-Google-Smtp-Source: AGHT+IGCtSvS2ymC3RmhAtG5dG3THBE+Z+tmCCHfo43Bgd+3ZuSnl0VmmL4EiEP5whUNpJGSziobzESuHMl33j7bQXA=
X-Received: by 2002:a05:6402:350e:b0:5cf:d24c:e7cc with SMTP id
 4fb4d7f45d1cf-5d0207cab69mr485385a12.8.1732260858540; Thu, 21 Nov 2024
 23:34:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: clingfei <clf700383@gmail.com>
Date: Fri, 22 Nov 2024 15:34:06 +0800
Message-ID: <CADPKJ-7==Bo=Wu6cHQ_y2qQVsPoJGeP3x0GztMXYcDaKCfmrkQ@mail.gmail.com>
Subject: Data race in net/mptcp/pm_netlink.c
To: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

linux-next weekly scan reports that there might be data race in
net/mptcp/pm_netlink.c, when mptcp_pm_nl_flush_addrs_doit
bitmap_zeroing pernet->id_bit_map at line 1748, there might be a
concurrent read at line 1864.
Should we add a lock to protect pernet->id_bit_map?

The report is listed below.
** CID 1601938:  Concurrent data access violations  (MISSING_LOCK)
/net/mptcp/pm_netlink.c: 1864 in mptcp_pm_nl_dump_addr()


________________________________________________________________________________________________________
*** CID 1601938:  Concurrent data access violations  (MISSING_LOCK)
/net/mptcp/pm_netlink.c: 1864 in mptcp_pm_nl_dump_addr()
1858     int i;
1859
1860     pernet = pm_nl_get_pernet(net);
1861
1862     rcu_read_lock();
1863     for (i = id; i < MPTCP_PM_MAX_ADDR_ID + 1; i++) {
>>>     CID 1601938:  Concurrent data access violations  (MISSING_LOCK)
>>>     Accessing "pernet->id_bitmap" without holding lock "pm_nl_pernet.lock". Elsewhere, "pm_nl_pernet.id_bitmap" is written to with "pm_nl_pernet.lock" held 1 out of 1 times.
1864     if (test_bit(i, pernet->id_bitmap)) {
1865     entry = __lookup_addr_by_id(pernet, i);
1866     if (!entry)
1867     break;
1868
1869     if (entry->addr.id <= id)
