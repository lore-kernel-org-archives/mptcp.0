Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A801385
	for <mptcp@lists.linux.dev>; Thu, 23 Nov 2023 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so435581a12.0
        for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 17:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700702226; x=1701307026;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5oBx7EjQL2+FbBjMi5y16gf4kuvyAnZ3JgFtexzBUA=;
        b=fZS/a6phKaEc9PhRTCldo1IJ9DfUl0Y3ixkHTmgq41Wece/F61zJ2j6BMqK9/Gybtv
         fGEfcvP1+E60/Cu1ftxzIGgBBe7s/1+OOV4NYVpxFQklhQfuP3x8n+Moacp9SwmDYRbS
         ZDNoa6dDvBubpkB5RlrjmlUjzLg0Ei3qMnDbLKPmh0a7tiCkSTcjBa7CnV7XZI6+WmWs
         wt88RM0r+r7RxLw9gcrYX5GYGnO2PsB9OoE1MGXMdIBL4+zF/fPfV9cwkPjLwC+7K9wX
         3b/qni0BZb52K68cxtAi6NZ/jhIVWI1hFwZwtwerZTF68XwoTuUHktcyaq7VZWMPMAiB
         Plzw==
X-Gm-Message-State: AOJu0YwwLjitoYLGmP3IivsKPLsr5JnPiI4zSOcjFyFbhMWLSXiBTviE
	3X8rbuifgYIh+STqvz230/A+HJDJ5XYeRUdo9/HZP/Xs9YmB
X-Google-Smtp-Source: AGHT+IGXO5tqvvyFWeJuKfwoIvQQp80K0szbB+GMH4jb8p0owJcdFApPgUPNAO08rqecCguHLqOIIprIGXF+tKVG4F2v1Pote9Tj
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a17:90a:bf10:b0:280:cd15:9692 with SMTP id
 c16-20020a17090abf1000b00280cd159692mr916159pjs.6.1700702226078; Wed, 22 Nov
 2023 17:17:06 -0800 (PST)
Date: Wed, 22 Nov 2023 17:17:05 -0800
In-Reply-To: <20231123004834.58534-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000de140060ac798cb@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_incoming_options
From: syzbot <syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, martineau@kernel.org, 
	matthieu.baerts@tessares.net, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com

Tested on:

commit:         c2d5304e Merge tag 'platform-drivers-x86-v6.7-2' of gi..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f3d6c8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e32016b84cf917ca
dashboard link: https://syzkaller.appspot.com/bug?extid=b834a6b2decad004cfa1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139ddc4f680000

Note: testing is done by a robot and is best-effort only.
