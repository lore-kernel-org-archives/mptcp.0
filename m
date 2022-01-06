Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD538168
	for <mptcp@lists.linux.dev>; Thu,  6 Jan 2022 00:06:09 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso612053iov.16
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 16:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r3UgIIeLAzuNo0zu4RQCZua0uRW8zqCPvFjmrl53Xm8=;
        b=OCtfIBjeDgUFRhy2MTmqIXBctNP9iF28r8/WpCGJi8MdulxWykMUSt09FtefswkHng
         qpCXYvYejxwj0Ur2mgwNMC+hil4cASYKrem4q3wNYuU9xuAvHlMWrenVarUVZ9arQfn2
         0gV8QslSG6BdvyEikt/LVO3sHTBv85Kyq/5pbaV6mxPo1VtwVcmOF7euIbY7KJobeWTO
         yoV1itZ5fWUg8D+xo/UQEDpiKrr8v7DewiyQD1d1R2QvMMgfZtLVGudnTWivEFRKqIm1
         zKll0wetqtIiBKzZQJDZsNuSzv29gbpgyzNXVs8rTTK6xk+V0sog5uCsxWKUXDqxjSFa
         lbbw==
X-Gm-Message-State: AOAM532g0lLCWVaex6EYHcbx4NvFqHyOC+DwdhuoBtYJie3LA6ZBYxa0
	Eh4IGOdXoxFfWrWBt0gIsldUIJUX1S9CoyWlEua9jFOPZN5z
X-Google-Smtp-Source: ABdhPJzmQ3O2YcNIKTcyE/Ff+dHPw4K0l6O1W6w7GVv0rYu2jt/V1k5fjzsPynIXapVnISKr+7DAP14tlb4wIGBs/Yk4w4yi2fYx
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d01:: with SMTP id q1mr26764901jaj.248.1641427569036;
 Wed, 05 Jan 2022 16:06:09 -0800 (PST)
Date: Wed, 05 Jan 2022 16:06:09 -0800
In-Reply-To: <ae69b8c1-ce8f-5113-c5c-c7e296613534@linux.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d50c405d4dea33d@google.com>
Subject: Re: [syzbot] WARNING in page_counter_cancel (3)
From: syzbot <syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com>
To: mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+bc9e2d2dbcb347dd215a@syzkaller.appspotmail.com

Tested on:

commit:         7b501ffb mptcp: Test fix for syzkaller failure
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git syz-test-reclaim
kernel config:  https://syzkaller.appspot.com/x/.config?x=34274384f56cbb7e
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: testing is done by a robot and is best-effort only.
