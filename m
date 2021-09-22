Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C953FC8
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 18:48:14 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id i78-20020a6b3b51000000b005b8dd0f9e76so3567111ioa.9
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 11:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=IbGr53PjLNYe172TbUQuQc+vEWUkhPYjKTBi/bu3bbw=;
        b=nqdAwrp01JUP0kKqPTKqeKZMskbCSNW8zg0HEY5Cfb96HwO5/VKYFy1jlVufApe2w8
         YIz/ciumACIHDrSt0Uyw1L6ZvOhEB750Bz3d7IYOML0cWme1YAB87dyX+F2ZxAWRSPwQ
         ngvR4fjYkh/QIGcspuHiiByAP693C/f+igxP+BczDrAJMTH9EL1HUNqhvFrR/P8Jhtvi
         WtfCWLDQ3LvtAUTPillxigDBHrgetrCmO+mI2pRn0YZoBucwjdnnL86tbqVe/yXnlOKU
         DF2w5SCw1ntDCazKqqIFbSm9CZJKRmrAFQdpcp7vsUDpxpDaMyuc5emLaaLRqW9bVhsR
         lkfw==
X-Gm-Message-State: AOAM533eNldRnU77Z2hxOh6YCcj6lIyeOOOg3hO4nHRRYD328U1edUJi
	9xhfMoVSVQPbEemCkAqg6uZwXzAGgzBi39zxh39LfTvKYAL/
X-Google-Smtp-Source: ABdhPJzOB6K6EJH2p3/X/14F91tn/w6UezO1kG8fZhZ0dnHHGiIVdhNzG1AJ0jYaLCR+6V7GaPlByjqTb5zVCzdOxJcaT5pvJTk6
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a5e:870f:: with SMTP id y15mr441211ioj.80.1632336494210;
 Wed, 22 Sep 2021 11:48:14 -0700 (PDT)
Date: Wed, 22 Sep 2021 11:48:14 -0700
In-Reply-To: <e973fea7d5aa864281a6b39913585518097ce67e.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4348605cc99f464@google.com>
Subject: Re: [syzbot] possible deadlock in mptcp_close
From: syzbot <syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

ERROR: modpost: "lock_sock_fast" [vmlinux] is a static EXPORT_SYMBOL


Tested on:

commit:         977d293e mptcp: ensure tx skbs always have the MPTCP ext
git tree:       net
dashboard link: https://syzkaller.appspot.com/bug?extid=1dd53f7a89b299d59eaf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=152aa7f3300000

