Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940113FC8
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 10:58:07 +0000 (UTC)
Received: by mail-il1-f200.google.com with SMTP id i11-20020a92540b000000b0025456903645so2162487ilb.11
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 03:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sIEI9uk0jXLPg5tRngu0deQrqbcmRIPtQjNY17o0nVQ=;
        b=IKBmj3HLduLD8GIKJIDLYeYrwdqgY8cQjK/nTpG6RjrXPma7/9O7mFy/K6qGC/yVPo
         QMT05MOitB8exJIK3KNVnYPPA51Q7bJ7On9JaELFh9AL8L31gunRNdTy7Zexgp1X1/4z
         iygt9uDpibC++ijKjQZcvrb4GB8uztbfVO023fq1sin4luK43vhHLYrg3JVe9VY8gvZV
         yC3XfKPrXvFJvB7ZHfxQgWOx2ha2XJvO2qdLgs6ybzfW5U7u6jEPQN9KXr/drb7tR48p
         d20fdt103PZsJO5l+zR6NcK0nxh5LLiiNKJ+mG7h06iaSx2D+uOJcHIRIXN78mOy4yqx
         FIUg==
X-Gm-Message-State: AOAM5311QwUv0xoROsccvHB3Z82VTpBR7N5lT6Qc78xRWF5QOXDHIHr3
	yVnP2rnJbRfhHgRZnHo1s1OfPyJR5+rkdumoorrns+iKBcUY
X-Google-Smtp-Source: ABdhPJzrupLFuHWEUbPmU68bVPECDv0uWyy/kVwXi6sss4UKhYlFnfSOJL8EuF/CcQqBBCx0RPY2ctH++ZBK03DFe9VBkJalyAc3
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a5d:9958:: with SMTP id v24mr3929152ios.201.1632308286875;
 Wed, 22 Sep 2021 03:58:06 -0700 (PDT)
Date: Wed, 22 Sep 2021 03:58:06 -0700
In-Reply-To: <7de92627f85522bf5640defe16eee6c8825f5c55.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a729905cc93635a@google.com>
Subject: Re: [syzbot] WARNING in mptcp_sendmsg_frag
From: syzbot <syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com>
To: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	mathew.j.martineau@linux.intel.com, matthieu.baerts@tessares.net, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com

Tested on:

commit:         92477dd1 Merge tag 's390-5.15-ebpf-jit-fixes' of git:/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=263a248eec3e875baa7b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=142df1ab300000

Note: testing is done by a robot and is best-effort only.
