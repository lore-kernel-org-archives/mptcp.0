Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8F25FA0E
	for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 08:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368332; cv=none; b=A6c03HJF4kPPSExP22GFG4LO6W8OkeyC42YRx163TjMSRp0aaPRelgsy+c37cmF5lZylBz37gSGKxfx/H3fOhJjFLOR3mQyNR0ObjJpmytMYXkBV7dpfYdDbDNoFGZWAWfThXWkDipsKEU2l4jRdXbRYql9JCio3Myv65uLyD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368332; c=relaxed/simple;
	bh=AUlAivcEHi5L6wRavWTe9ZXTTU+8BH4fDz/miIiqsPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0QqPVKBo1Ozc/X4Pw/0ZzCWaE3aYNU52hyZnJjEl2xTrNqUPzqa3Kj5zDiJ/dOSxEkaa3ilwdxDquz0Kq3/Q9Dgt8SfWYZAgHMD4j/TmPTDg8xpaLU9L0qOS5DYxMhuDd8QXdBFFf+ixVux5mSMN2n387I45hjDGIXerVMBx9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5tpfBu2; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5tpfBu2"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b272a4ca78so556962785a.1
        for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 00:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763368329; x=1763973129; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NFjawquwtBKi9dRPXkr3le19aibIbXrAivqnHmuCQ0=;
        b=n5tpfBu2mUj0RNqR4swyaAId2KeUrU2KELeAThPHh9RvzVRfACjB3hp40VrgDXUeQC
         zNGDLUZL3fUfuRYeE5r/Z1h7PLMaH1wvKnCDXZttvRIHqjDcmwP0YiX5WbnSGp59JFxT
         Uj+d0tlEpyXyBRCEDzEZud0xCpHM6ZQHRp/2miOhekArG51rhH/+pW7VlOV87a/mp+1I
         42MgyL8ycBC91+GceYNmAWiXRlWtK0DnyFZmSZUGkE17+U4kSmi7bg73AYd1/l5qbpUx
         WJamNWN5OTZBsZKZmfQloZbcksxqaqtm1/8IdxofqMGqo2/xF3JudkoJaUvEKPjgvaln
         Lm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763368329; x=1763973129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9NFjawquwtBKi9dRPXkr3le19aibIbXrAivqnHmuCQ0=;
        b=Mok+r0vEzhpGiQkp3s5cITTmhGiU995qK+ykyipgxZUBkdpls9vj+2z+SWTCklH6is
         3B+T3bzn7ZU5bNgBMDv2MPfbk6GC3094BLDTl5utmlHxXiFAVKW1Y5FuimPhM6SlVwSR
         yXrqwhGBVbfzVH2emy7YKOX6lf55+0+qogcmTRTDf2cfmYPQF7+hUA4zTtKVDhgxMFI5
         M2ygnOzGanYPqjXAfAuhv9g/Y4479OuNfd/hbQUe6nMDlEbzdk+F+cz5sXaB/PH9ca+c
         fXWt2QN32f1l1LobwyffguXwEkmtpcgUz8vcVgoy4VAJ0FuWAgxiv3VvEPKA9XOK55v8
         ePgw==
X-Forwarded-Encrypted: i=1; AJvYcCWRehdwJNd1l81suVJB7ubw4wWuc/8EwPeinsMI0Zaj1DgbEOQtQNj+KW5q8ans8N+PlksbLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4VeeQUyzRyFQMmSKrYmsUmhzDLaIE4WMNJc+RlEwB2qeNbzul
	Ln/3QQIAzHOjcBqIa7eUpMzR9myIWnrn7UoqT0qcRblGzN8pGPulwVKHLKNMr5Zwgvvj6jNOzsP
	hZq5khmY27AAa+Q9NXB41WgKnckoPs02AusCGD37d
X-Gm-Gg: ASbGncvnDvqf4V8xHxi1Qu/zeCcRaie1y0rGjKx+ZK1FQrW5OtS7NdpIsQ138htSE8K
	XjadaCN2b8XVTMinvF0xgXP5+5asM1uBG616wJ1mAKpNkOEbR3odfM5tfXD58L+h32akUVw3zGy
	c2W7/SEvzAJEX5b43U3cP8VO7Ccj94ByTrBkQPKFkKAHmi2uX2/RPMleabafC9/TFYnu4e8maC6
	sX6xeWsPherpKGpnC8gNb5Z8ftDCqfUVTp2BHZCZFEx+jO+O8q5P/hD6kVZcTDj3MZ3ZZU=
X-Google-Smtp-Source: AGHT+IEp6BfXepOVS6/t8BlYEU9QQqZs/Z5E/+w6lk14z6d9MriVg8ZmUeHwF81lEkJ0EJjNohlhk96VO7ReWhiaznw=
X-Received: by 2002:ac8:7f91:0:b0:4dd:7572:216f with SMTP id
 d75a77b69052e-4edf208640dmr135520951cf.32.1763368329152; Mon, 17 Nov 2025
 00:32:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <691ad3c3.a70a0220.f6df1.0004.GAE@google.com>
In-Reply-To: <691ad3c3.a70a0220.f6df1.0004.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 00:31:57 -0800
X-Gm-Features: AWmQ_blmoUn12CUhwP5gywrP_yV8V1eZfjn35erz9AxT71V-1mWZ2YI5vSZvd0w
Message-ID: <CANn89iJmyNNQEmy714JqYey=P5JKgzmPvOSaZVV4OUfy5e1xGw@mail.gmail.com>
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in mptcp_pm_del_add_timer
To: syzbot <syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 11:50=E2=80=AFPM syzbot
<syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    98ac9cc4b445 Merge tag 'f2fs-fix-6.18-rc2' of git://git.k=
e..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1712bdcd98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daf9170887d81d=
ea1
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2a6fbf0f0530375=
968df
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/aa708867a71c/dis=
k-98ac9cc4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5d853b65c8dc/vmlinu=
x-98ac9cc4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f0f012153d60/b=
zImage-98ac9cc4.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com

I can post a V2 of
https://lore.kernel.org/netdev/20251114223136.113011-1-edumazet@google.com/=
T/#u
including two more tags.
