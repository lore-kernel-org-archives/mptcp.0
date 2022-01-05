Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355A168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 02:41:07 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id j13-20020a0566022ccd00b005e9684c80c6so21250251iow.10
        for <mptcp@lists.linux.dev>; Tue, 04 Jan 2022 18:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=SvtF0I+CMMXZK9yl9EQVJsCqsRxI4mbf9Td/nSTM0dU=;
        b=as73Kw21kp8emiKjOGY/ldW9KUc7oN27y0uirdvm7v7d/95OziETdA7MrxhX7ftjbm
         DMqrbWFS+ZtXgrQpGH6OfaobBZB7JUuRbuWfYmEsG4lKN2/JF7we4yqi1S16LfSau51/
         Iu9r1b5f47tR8uhkzzO3fajTAF3JTKgBezLZ6icLRZCtGz1xWQAoyWcnGWMQwzPY95Lw
         t6nerL1l33Jf/72WyonVjk4GYHOXn9GPHRHDUae0AZlZYMuEKB4E100+ZSF3t/W14qoU
         3PxRmdsUlpeCXQBr4p4oMz/l6lbgteTZ21Vs3/3sAFV7r1kSnFf7vqS+Bb78VFGnsSg4
         Zo/g==
X-Gm-Message-State: AOAM530X6PYJeKA/cyNgQdTdxVZFUvyuBJpY7pyfx0lxXNayWSzKsnnN
	auJya5AykJ3+Qo4gZETO2ffqyotoi71Yz+U43ggYDS/V7Z24
X-Google-Smtp-Source: ABdhPJzNRiro9fKvg+qCgyEjaL+YBQ7zHaZdkw4H2E5uthC58IEYF6kEXXqHMc7y8lcZJQQJupY4KmESsXJGG3VIAnZ3UQ7xh1Zg
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1348:: with SMTP id k8mr20953535ilr.297.1641350466439;
 Tue, 04 Jan 2022 18:41:06 -0800 (PST)
Date: Tue, 04 Jan 2022 18:41:06 -0800
In-Reply-To: <a5afc6d7-fb4b-fed0-bb66-444b11fb680@linux.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000810fdd05d4ccaf0f@google.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
From: syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
To: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/mptcp/protocol.c
patch: **** unexpected end of file in patch



Tested on:

commit:         ffd32ea6 Revert "net: wwan: iosm: Keep device at D0 fo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1050454fb00000

