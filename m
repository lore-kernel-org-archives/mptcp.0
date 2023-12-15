Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5145539D
	for <mptcp@lists.linux.dev>; Fri, 15 Dec 2023 03:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b725f0a886so35016139f.0
        for <mptcp@lists.linux.dev>; Thu, 14 Dec 2023 19:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702610404; x=1703215204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQyEELprIDEbtTkUwA4nnT0Wu1uDLHkRLspT1Fn6XJU=;
        b=kY+BEVKYZfF+b+cND9JTuF8o8aOquAYVyYSKgOJMfCYbqrxhVjW17AK74ueko8GJ0u
         VCcx3J3bSMf5ybKYNNmOW5QFryS57CN0zqUqxdlHbjXLEbd3j2efRVmkwA//9y2v2gZa
         FJ2PodNcaENScDKQ1JahSUA/aic0WLfi3nUC7gfuqcNNeyOOFZYrpbS40g+xqDlqK6Yw
         Q/o2H1Fm8DAka0afnSUlgfGh71gdj9AKcarQM7OPq3TGlnwqBTMNOQUBwNm3zKlD7Vyt
         f//g63+QuBBcy7J0N9iAKt3BolhfmnohCsDrJWjpTrIHOht8v1lv3FLJ+Z+dpJGaCCcT
         sQXg==
X-Gm-Message-State: AOJu0Yz0pMv4VP0ShqpDwUACZ4F10apE4v450+ewOVakYBDb5FJ01KD5
	bFaYd3eIpwQuVN1K1D9p4olPXh2FCdhb5akYm5YwVkvDpmAN
X-Google-Smtp-Source: AGHT+IFSmETvZ2PGKq7WWyYsYOvKShW8hfRpSuc2mR/bEUzi09+1SVucE9q4C1zxr0q4t9qCRzcJUHC049ncKK4A2KARey/PGRpF
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2720:b0:468:fbcd:15a9 with SMTP id
 m32-20020a056638272000b00468fbcd15a9mr184105jav.1.1702610404132; Thu, 14 Dec
 2023 19:20:04 -0800 (PST)
Date: Thu, 14 Dec 2023 19:20:04 -0800
In-Reply-To: <0000000000004f4579060c68431b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000544e17060c83e034@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_check_listen_stop
From: syzbot <syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matthieu.baerts@tessares.net, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 57fc0f1ceaa4016354cf6f88533e20b56190e41a
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Jun 20 16:24:23 2023 +0000

    mptcp: ensure listener is unhashed before updating the sk status

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1279cb71e80000
start commit:   2513974cc3e1 Merge branch 'stmmac-bug-fixes'
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1179cb71e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1679cb71e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50bd31249191be8
dashboard link: https://syzkaller.appspot.com/bug?extid=5a01c3a666e726bc8752
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1119061ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110ca006e80000

Reported-by: syzbot+5a01c3a666e726bc8752@syzkaller.appspotmail.com
Fixes: 57fc0f1ceaa4 ("mptcp: ensure listener is unhashed before updating the sk status")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
