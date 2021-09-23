Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0C43FCD
	for <mptcp@lists.linux.dev>; Thu, 23 Sep 2021 01:19:06 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id o18-20020a0566022e1200b005c3adb2571fso4419467iow.3
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 18:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BtVl/a0FY8JKH/FSgWRHy3yJPdYUXkTtU6Y13UXQm6k=;
        b=UvHnX7k+pgNHFa0JvB7pJZZYa1h5pCGA2OckMKjuysSqE7+JthxrO7+t9PQc8w7rIZ
         BhWTXjI4h42CSDwSb0y+FHDPFbOl/B9fT/lZYciy4GF8IazmDvHdQ3ZebUMUSBFiN+Vi
         FDESquqp0n9Y+6/psB+goei25HrKsn5UJrNI1nC4RgcFhH+1V14/gmHsFDTUxeQdzrrI
         fXrHB7bgPpzhMn87/Us3PvKxjwIJmTl8tvZG3NTQFhCoMa7BIw1YI5DHYdwRQgeQ+w8o
         wl47GDRcGVJfugT5NXpFwwTJSrBMJaAdO55aAYwawjRO6XCVybNNMSdw6A2ekQkZZqmp
         jTWg==
X-Gm-Message-State: AOAM532+0+XQ8BIq44RbwjR+pNmtMu9DriOFtTmsEB3+5ZOJS5ogsMJQ
	tilhStncYJd+u+KLEu8rRTuSd3URSHEO9kmgiRXow+Ug70bA
X-Google-Smtp-Source: ABdhPJybG0wzvcdwqti358tmNLYHxPWpJf4CpeobC1WLwXv3xZrbrB86bltfA0STUGAD9uXR7BvV/6+UpTelcA73qi5nXa0D3zLu
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:b703:: with SMTP id k3mr1524987ili.95.1632359945648;
 Wed, 22 Sep 2021 18:19:05 -0700 (PDT)
Date: Wed, 22 Sep 2021 18:19:05 -0700
In-Reply-To: <f8b3bfc6173a9dca9b72ead1681cd6d052350170.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4bfdb05cc9f6a61@google.com>
Subject: Re: [syzbot] possible deadlock in mptcp_close
From: syzbot <syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com

Tested on:

commit:         977d293e mptcp: ensure tx skbs always have the MPTCP ext
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d93fe4341f98704
dashboard link: https://syzkaller.appspot.com/bug?extid=1dd53f7a89b299d59eaf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=132bc1d7300000

Note: testing is done by a robot and is best-effort only.
