Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25363074B4
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 18:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183005; cv=none; b=SRNap/Vd+N83BMiuB9iO/gitouWPn4pOiqaNi1rYzAj93JJx7P4Ruu5zYWqhUF7N4ps9M40DY4QexFz1nrWGhy82xzo/BGCa2vB2CQKcvt2HCHyVX4U283hlsY7GLqgV2JVYCI/1ZOoUS/FMQm7zlGNtp5vTSjp3vsesjciGkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183005; c=relaxed/simple;
	bh=Y3qxYXNwrLCxS5uX+oOtrmpLOXCLfyHgCk+6C93IcGw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u0cJqFCtcWypOLFSfjZb8KJf1Bo+x5D6LXb07Ix/yn6kBOgzWS1rl94+qW0KRGa4QVNhZ+acTj9VldecMC4ssTQ3AMi1WMdV3CVmjOACXhfYPv/pb117HZ3UiEM8RvufLhGnK6Rs5lcNpTXTrHlKv8YCBfbPVZ5Bt9jBmhm1ulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43377f5ae6fso920295ab.1
        for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764183003; x=1764787803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpTZfaCdHpdpk5vh/sCVYCRhyEUc8PwJnSAosPxrvwY=;
        b=Pq5bsbmZGrbyAdbLC2yjVdhUUON7Nasg2LSiJswp7AE63N45Fh/UFuVGMu1yArwKch
         56vrkRcN9O7Pj7yAAmKry4cc/fl/ncJxGn/tEoY3pKEarQ+4XJFbU6AE1Ntct3sghDaT
         JXLCH40BL6rVp6ol0ZMO8GQiIrqz0noNeZW3cOWK3i/cdsDw1VKktI0wcrEGMVZoLVkM
         oo64EtKgFH3p5oTS6wFjuQCeNFBpK/czbs6vhksbzaooatuMaw/k3Lapuyd5SW3bv7Zr
         lkIpZDRxRbhAhnWKA/8k7v8TLHjaNyoEl/vUAlQLWEblAXt8DQBgWvct/l2/pR8fQ/HM
         otSw==
X-Forwarded-Encrypted: i=1; AJvYcCUi8mF5pvVXoL1L9fy8pQM+dV4pXokoWdR9MsluFnHphgUFoWz/gr3AUNHjQvHZG+APqefCPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpjcfmwmx9wdBdXbhSdpyZHnX4M6msHLK4bUquDXJNbEZ2OdYr
	vtmXgOkVYpcYWibTLm7UoGCTCP/SR9cJ6pgxZhwEIhw2sW6XgFZlgJhA/XGOc/wgS0lbJ20SiHQ
	NxJXqfM8DoRdxWzN/xKOxwmLJiQwNJS328HAcPZmfuGFm/nJouJ4XF9ehDtM=
X-Google-Smtp-Source: AGHT+IF59ewaSOLyfhRMQVwYdHqxCg5PUtdrMaXWTV5vXhylrbhik2kZN4W+benkCSV6ki0LsLOcmUHI3Du4Z5hXWniLMNnwEcgf
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2146:b0:433:7a5f:9439 with SMTP id
 e9e14a558f8ab-435b98c6abbmr168614705ab.24.1764183002959; Wed, 26 Nov 2025
 10:50:02 -0800 (PST)
Date: Wed, 26 Nov 2025 10:50:02 -0800
In-Reply-To: <f697f3a0-859e-48bb-b0cd-28f176a24e2f@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69274bda.a70a0220.d98e3.00e0.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready (4)
From: syzbot <syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com
Tested-by: syzbot+0ff6b771b4f7a5bce83b@syzkaller.appspotmail.com

Tested on:

commit:         ab084f0b drivers: net: fbnic: Return the true error in..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=153a1e92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cc75ad16015d162
dashboard link: https://syzkaller.appspot.com/bug?extid=0ff6b771b4f7a5bce83b
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121ba57c580000

Note: testing is done by a robot and is best-effort only.
