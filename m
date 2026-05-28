Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC13EF664
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971701; cv=none; b=RgcmHsYrVe0Yl2R01GwJ0F5n0X13924p1eCLoUSHjNTKo3Ol1ni6PauMGUVHLG60N8iqb/frcXOrZ2bYErk+wC7uVqX95eOs31NZF+wVwus+yDy3Q3kuAgH9j12sinhtuSAKo9vqypJGSm7wMvL/+N8j/RvrOpD0mR0/jyFeBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971701; c=relaxed/simple;
	bh=SAT87z3CEBmvQnFn0phld8dcgGRLcueDYlCQqX9PYUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd11HyihQeZGa3Se3kxQD5LguUNDD9zt+d/134BNXwEAEvxTRFJbXPwOWytMEUKtzhO7mehgeVnMH14tebRfV+MAVo2EfIcXrJQPPAQKgK8EMy39nf9zgaE0pY0mHBxuv7c8Jvu5qUs1quMXyrrqKA4XESRZS9U9gTocI19vuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUw53Ukm; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUw53Ukm"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2baca4df358so81441525ad.2
        for <mptcp@lists.linux.dev>; Thu, 28 May 2026 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779971699; x=1780576499; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAT87z3CEBmvQnFn0phld8dcgGRLcueDYlCQqX9PYUg=;
        b=WUw53Ukm1Rm82xOCpg/NyO49YPeuEe3vAHiQfc3AHpIfT1Ckg6T7q+xXPy8nWxujxc
         cgkFZvJxOLnTi2/5S6U8TfULmySZ/Fuk9Aoh0Ng0Ydpf8Hddzi7xGtb/a5H4DUoJ5Z2Q
         xAIaF3Cf7JGCwPY7/xEGPaUnqRI+PagZ7keCbSZfWyxjJm9GEGvReZavJdQUDbg4VJDf
         5SUZjDTck4rO8DJz/R8ug5Zq085yYUNsfcQfhBPRRAoye7Xs8a+VJvJ6+23xJe5u6em/
         YA7sBefCMoPRlSXsUoqzQVsdNQqGAM0TjJX6HiF2TzdNy+AtxhpbNsANdn0/ih6WBuJF
         +KfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779971699; x=1780576499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SAT87z3CEBmvQnFn0phld8dcgGRLcueDYlCQqX9PYUg=;
        b=pMlgB3B6PCx+CGRIMWTJg10y9Tc+vKR/P17GWgFhi2fBR5gh6wkSZh1dbxexT/4Xqx
         d6TaTT7rrEENFx0Zg/L2v/UJH1DiouYD57Yyp91+SXYPO2GZwtf8HXioWoCvOp2ADt5n
         jm0ccLh1y68UwM3qHC4X6ZPZCx2qHHHWx6flWuIUG/rq1+Jsh0zbNNJ+7cFfyDMcTJVx
         PrD7bvowcoHNa38cV27VCdr9icOqrl5ynHCupk6ev8v9Sgk0gLBesFRenPPFqOv+vPD6
         C0nsbaFy2A+pZPblklz1x7BdTrondfryRML5ctpE5hvcxSDFjAzkAn4BhG/N0hqvZZzK
         wNaQ==
X-Gm-Message-State: AOJu0Yx5Z5grhe1Z98SCMnuauxvlyA4qMajv0G+5OE8n4jBlA/1VEUF/
	tDHqyhg3QNLacaIOcLtlTRbpV12HcQQNMzLyaGv3sO1zWzFAwnJobMdu
X-Gm-Gg: Acq92OGAme8RJmLcsfn7sqG06fTyAOUkkg/Bf/3rOCxtNs6YAKor+6c/iuXXrdQa66V
	FWlPHZgHAcooHmhwLjutbQS2Y98qFffMGJTpVJ3+oOWdzJ3Lrsqx2FkV8ZzB7ochmEwbwxXlUkp
	sQQX3LU5I5++8kita76fsAs6CDgQCPn955SAfngJZhVVlCfG5MXKhF2hts9HWkjziineFsJMxxR
	t9HT7yDyzUUgI7GOX9MmyuNL6zCh+Cha6BEwW0biZK4o8uMg3xE5gO3VDR7W4efwVvWt4RCNW7q
	9IN/KSNIOrIkMBoSePG+vxOxSmpC+ts64Vj7djvpLW7IfQNZUQiX6R6HXsy7EkaUZJVWuS1aETP
	lhv9yHCeaXqO9ybqPP1iepWP56DQEJiclu58xmEwvYIu6pHPAuMSs+buODWC6JrMVbInLo9cRNM
	tjfp3V0+aRfezVDmWiWezZ1lOdcvKvfOhV4g==
X-Received: by 2002:a17:903:230a:b0:2bf:ab5:cc24 with SMTP id d9443c01a7336-2bf0ab5cd03mr27510585ad.33.1779971698804;
        Thu, 28 May 2026 05:34:58 -0700 (PDT)
Received: from iotshare.. ([125.119.77.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58d9ae2sm174706125ad.63.2026.05.28.05.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 05:34:58 -0700 (PDT)
From: Li Xiasong <xiasonglee@gmail.com>
X-Google-Original-From: Li Xiasong <xiasong.lee@gmail.com>
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev,
	lixiasong1@huawei.com
Subject: Re: [PATCH mptcp-net 2/2] mptcp: use sk_shutdown_timer_sync() for add_addr timer teardown
Date: Thu, 28 May 2026 12:33:38 +0000
Message-ID: <20260528123338.864181-1-xiasong.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d5c58002-fbef-451f-aedc-1bdda5ebc9bd@kernel.org>
References: <d5c58002-fbef-451f-aedc-1bdda5ebc9bd@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

> Sashiko is saying that if sk_reset_timer() is called after
> sk_shutdown_timer_sync(), it will not re-arm the timer, but in this
> case, mod_timer() will also return 0, and the socket refcount will be
> incremented.

Thanks for the review and for pointing this out.

You are right, and sashiko's concern is valid: with current semantics,
mod_timer() returns 0 both when an inactive timer is armed and when a
shutdown timer rejects re-arming. As a result, sk_reset_timer() cannot
reliably distinguish these two cases, which can break socket refcount
accounting.

So if we keep using shutdown on a socket timer, there is no simple fix
in MPTCP alone. A proper fix likely needs timer-core support (e.g. a
shutdown-aware API, or equivalent semantics).

> It is not clear to me how to solve that without checking whether
> timer->function is set or not after having called mod_timer(), because
> that seems quite hackish...

I also re-checked timer core behavior: timer_delete_sync() does more
than waiting for a running callback. If a callback re-arms the timer
before returning, timer_delete_sync() can still remove it before
sk_stop_timer_sync() returns.

I need to revisit the design with this in mind and do a deeper analysis
before sending v2.

Thanks again for the feedback.

Li Xiasong
