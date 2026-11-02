Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578564;
	b=vOvJxKgFII+cOR1f5b3BILo5eCR/ZL7NgI7d3Mlpm/EoNuNSU7NsCyIWe+3gmUlk8/Zd
	 4DaQEzBQVTpEWm9JVNioJ50WchbcldEH7hX5gnJGVGr6UUfFblL1252d+b0yLIscxkqwb
	 XfG53TFvDGdztgS6ICrUGs4imGY3r0A0dcZqCOX8c/eIRJkD2rBVNkDpvFC7K7tndA8t4
	 kouTpAyjAolEt+Yhw9p8GKOE+R+HZkpOs2nS9y+rx0TU8vPqjBaODYuqR2QZYFOKyxmVD
	 PYSHhFTY6m5UkzIM2PvZLs/Fq8cXAtsjzPWWkUA1OSw5dBUj7pPirrtWOaEoN8ytS6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578564;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
	b=gmOKiZ2d6Qdl6DeOEwZ81UsVCqx2yu/6pBAYRTvPnGN10WUdwvfYOn/iXO5W9l8aZ34N
	 yEbtUmZr9ZSAXBwcrliHIKr8B4ESQ1bZsfcIw2PJcOoj32Ne+RS1B2A9w9xc4HxlSgKOj
	 cQyzRSTHQWdxYC4knmqbdN169iAN5oXBZ19ySsr0yLu5VZkD6dcIWrbax6PPZvBfFXjV6
	 1PiOREsz/IulIOk9MI1nb+woAVMxYkWoC34lb6lUgjHQD/6jlYtsoHeT1ERB6mIIrN0Sy
	 6vOhyGpbqF3U8y0a77ArwE1ueplYXcmhyhc3FMcZtnPBosvK+DReLsay+/cx1uRtE2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxKcnIn4;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089E606A326
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 00:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D089E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxKcnIn4
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2eb0f1b592bso7892225ad.1
        for <mptcp@lists.linux.dev>; Sun, 01 Nov 2026 16:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793578558; x=1794183358; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
        b=nxKcnIn46+Xg8m72uozvBotk8ebKw8Zx5+kAO68YmWHTfAKzW6I//1pCyy1FJqsS9M
         lkwIqoVE6BEVMh5wJZioJx3GbYydRAT7av8tFOFuTlTtHj8te6pSDoyWXoBojLADTbRl
         Qs8kCS4XqAhqCHhO7Oo+MsHm9Q5xUm9HXs8A+fD5sNiOC9KwBWW5JRBWo4MVoZ6GXuJT
         JylXOgtOTe7YxjcJeJffQXqxGOsOJu+dolKTasJ2T0P5zxPFa/0gUZrbIMLKA3lkIZRk
         VPpdyu2AOSYeSUrd19+E4uMY+6y4NKjF7/fKrKnKsmOfmgVFrPlfbSL5FfxNW/cPNBGp
         RIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793578558; x=1794183358;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOTk+4QV9R7r+hqcOhyi+ZUpTGPG1XQYb6SJ4CrnYRs=;
        b=uJKPNKPwG1F2rFnLVmC0aG9C0yVirrxthY5z5XPJcbPOvycsZB35TQERVhtDu+GTWR
         TzCrR+Lx3xcvLrp/IP7XGI1h67PVfk/FiY8kHQaq1BvCBmEQC/lMcy5hPmvKZTb5Gc1B
         7ZxvDWdEKOdq1B1lLPHY7sv37st9yUk6lVPAoi8I3viXQq9oTgqGBmfncnR8GAWoXyyI
         LEbQ3U2AyUh+j2wXhkMCpSZpC+ZgU6LLHtFlx2H49vUs94RLwnecbyKrL5LoGQAaZc7I
         ERjFJDxeUjqPBHcC1YaDe8xG5jA64i4y6cXN1HXb4ZBOaxu+mjrIGFA8sIPdFQUHogmp
         8QXA==
X-Forwarded-Encrypted: i=1; AKwUvBw/C/9A2CGGqh3Pl4bTW54hgdP64/4x3e1LfMkXkl7LdCdHD27I3U0e1txkH2BI0hD+xHcogA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Leh7iHpwmLL5s9xzeevXV4JIRkPPP5sgGQkUKx3UrPngeHVka
	moOZDnX8RNQlQTaXEqsu8eWjN8B6wadPN0w3b7K4uSw6FDCPgsfqxFe0
X-Gm-Gg: AYBFou07Ihculx1+yGRd1TwXb55lGT8qBGEniB+Y3kSQpuS8j6GzkH9v7H57dOTnQy+
	hD23nFW0mMalwfY5pK3Ls6gUujN3VdO2BdNOwluzwTF4kR/e1rDWos4mR25KLAHhiOaGtP7lH2w
	umHz4TMv5GWYVRSNVXOb0tGcGHwz0QMr59GzAOLmSK7c3MEWGb0xJYLZrhZgbCQX2YMCmgqKOYH
	0mPz2o54Ktya4hIgpdPiYdPIE4ISXdqtXsj8sSdGH1Efwg+K7oLJsMtTgBgwFtYsRMaGy/vl6Pc
	bt2DujqZvjCg5p1R9qAsqmyDCSNl/SLbURH+qc65Hgydwan6UQEgu40mhqJ6cpubj0Hewl344F1
	V9t7obVNV3QTkJiaHTcwn9I7mSbUgfjJRYsuD9OjVMKft9wYeKAXrERJQx7i80fRLiI/0snN7pt
	lJZfe12GTgNaBo2CZzwPM72TOWjqg++qtVo/BFUz8upl2eCBGfzNzbRig58zbQOcXr12kZjLhiD
	QzcFkUNlPHnc6AdHEllKKS6SecigfxAvSyt/Z2N5K5s+PiA7ZGbksF599/fKLnau5yEmYejCUz5
	QtFQ3ZjmqfszQ9fALB+DIpqv7RSsG8HJMjUVqva5oESSOP2DUIlVQrmHrjL8OkS3XWZQZo7L0pG
	MXBl2btGgQq3PUXIcFz5eJMwOGkKjTWfIHwRaexQemMFvVXp/YzSUfeIs
X-Received: by 2002:a17:902:ce04:b0:2df:9a7e:d41b with SMTP id d9443c01a7336-2eb36462d49mr84627265ad.37.1793578557953;
        Sun, 01 Nov 2026 16:15:57 -0800 (PST)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39052ec9sm20149455ad.6.2026.11.01.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 16:15:57 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 00:15:56 +0000
Message-Id: <DMKAJA4HTOBN.O8XO807UAB6Z@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict
 stick
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
In-Reply-To: <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
References: <20261101192057.2296489-3-alexei.starovoitov@gmail.com> <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Sun, Nov 01, 2026 at 11:39 AM bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> Now that an exhausted SK_DROP verdict resets psock->eval, the prog runs again
> for each later message.  Does that make an older accounting problem in this
> branch happen on every message instead of once per socket?

Only between patches 2 and 4.
The wrong return value is an old bug. Call 1 hits it without this patch.
Calls 2..N return -EACCES today only because the prog doesn't run again.
That's the bug that this patch fixes.

