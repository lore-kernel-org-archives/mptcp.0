Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6853FC5
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 12:44:14 +0000 (UTC)
Received: by mail-il1-f198.google.com with SMTP id u16-20020a926010000000b00248d5c778feso24605171ilb.7
        for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 05:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=j7W6IF32OLwCmsAyEN67q0eOkVTY2jGgLBmfWA2w3oM=;
        b=CseviCPlC2CfA/qig8pj8f68ReuSceDHBI3NMpICUHt378utNdv+h4NOBl0yCBDpKs
         yUv0/KL3eXKuSy97V2hEXEa2sLlnkbdnM1h6H6Udc4OpSl2NCqJYkkZPGdK/sTMZi+Ic
         WezSRSqZjpC3HsCreuSnRXZI84qO3AdEnwNmIr43CpBGc6jbXg+bBqKFnUxscUMMxTYL
         qO4rbPWjqhr8dQ5bVpnQw81jt4fQgOVU3WD7IBGVTWClRLAOqBZ+qg7AW5exwXgcvAtd
         ZN/Lk9i25e0YqfhX4mk2tnUpUyi4v0M+eto9a045Wlx1MNvanJADIjeF1ilzFz5zJ/H1
         nniw==
X-Gm-Message-State: AOAM530U/xVlnFQekN2Af2SDJJ5RtgXFiMe46QB5T1RfxFrBUQir4AFt
	OrTax0h/s4GOrDk57tiyf2VrLRChwZPFTc/INDAxvbR7HJiB
X-Google-Smtp-Source: ABdhPJwU0LxSU0Vs+OUR4SbcbRJW+6t0dmn6gDPWMLDOIMj8YlaKTuHAVxDdNrrXU6P/AV2udccRpCZkeHUBAjv4aolhKTENXqkW
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a5d:9488:: with SMTP id v8mr23013657ioj.195.1632228253961;
 Tue, 21 Sep 2021 05:44:13 -0700 (PDT)
Date: Tue, 21 Sep 2021 05:44:13 -0700
In-Reply-To: <416fd24503f6d489d76e3228e427968b2e72d53c.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004514e005cc80c124@google.com>
Subject: Re: [syzbot] WARNING in mptcp_sendmsg_frag
From: syzbot <syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com

Tested on:

commit:         92d5e767 DO-NOT-MERGE: mptcp: enabled by default
git tree:       https://github.com/multipath-tcp/mptcp_net-next.git export
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=263a248eec3e875baa7b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
