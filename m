Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC23FCB
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 15:06:13 +0000 (UTC)
Received: by mail-il1-f200.google.com with SMTP id f4-20020a056e0204c400b0022dbd3f8b18so5809180ils.2
        for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 08:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vmo32TLCnAUpPH6dpBRnBTO/9NixVmnEfLnfcZbaeqc=;
        b=rCt1CDfeRFD1K1Tk8WWuTJqeKX7GZhUU0gm5Kk0V6toWRWKUy+Ue1lSQM+lQLCFqPb
         P/16rN76x/D9ytWtqP2mVgLVfN/hAxTD6nbSbz7v1A0Q/eBeTmqdbgNkKGlqMNqahDa0
         Vq5M1ntj/YWMC19egSTv0DlNVNkeZffpu19k9BrMxNActD47en94hee/0htG/elSxHlx
         nVPXsfuvTj8nCASurT4p2JR2thPOL1Mfy+YLLJMTOYrGUmeixmcTMIGzmo7hurMUSO+u
         LNL1xzEfXqkIXcHnn9udqz5L6qeLtbstzFigplc1AX2uB9702HATe1lHP9AHtaPBmLWS
         mR4Q==
X-Gm-Message-State: AOAM533SZN7CotHjBbiJT1PYpRdC4bAYyDOcMqyoM2RFXXPmySkcLkia
	OIeJTlSuZ8IbChf9wZZyFZz3cKD34fgaXBFY6uqzhJXdm4PB
X-Google-Smtp-Source: ABdhPJxgj2qDbE7gIF58B/ial3aTsBeHdOJa5/IymT6qIGPiE/1arxolEkAqJYVV7gJjvNFoCsW2AScA6+s2+FWoItKxIBnfWHpz
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:: with SMTP id q8mr3810442ilv.202.1632409572417;
 Thu, 23 Sep 2021 08:06:12 -0700 (PDT)
Date: Thu, 23 Sep 2021 08:06:12 -0700
In-Reply-To: <c2b5f3d3ca524e1825965e81e4fbd5c6a3536b77.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1275505ccaaf886@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_recvmmsg
From: syzbot <syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com

Tested on:

commit:         58e2cf5d init: Revert accidental changes to print irqs..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=3360da629681aa0d22fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1379f923300000

Note: testing is done by a robot and is best-effort only.
