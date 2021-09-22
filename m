Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1A3FC8
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 18:42:09 +0000 (UTC)
Received: by mail-il1-f197.google.com with SMTP id p14-20020a92d48e000000b0022cf3231b41so3273314ilg.16
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 11:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PhEs90yaMIvFX6f9H5Xc4pWeN4mGyXe+Y3s5O96iFKE=;
        b=sPicn+IQPB8eMYU0VWN+gc1sSW4dCxd8FmzbSbGazcc5cfznPMlYvmuWnCVoTwjVG6
         3L/t5uA0VjeRMTRfH9eHNunq+TF/CloxZyfZ0iADX7wibkG0tWfVTAN+arS/Xj4khBqp
         mCzJeXF5mkkrhlG9gwuweoFJQnizb0AS9WaCPWZlXje//EPd2N5fKrcQrvdNwxpPXCbX
         8soQnAeu/0mhcR5iVexrNjbPaTm6fadumEWKRL9tD518OioRntfTsRDY2ICs9lHjqiwE
         196x52FjfA92ZwE0mG4hLLhaz4KrqSgVpimbDLWTDljZ3qEd1YkEB3r5zDu4rEuQ3j1R
         kQOQ==
X-Gm-Message-State: AOAM530ub3XEk1usi7E+JH7kePMJRmnl8yE5ah/EcrXx2oEv9QeYjItB
	9CdFfjOh5m4ApTbcaQ2krZMF2ofxjAyIQII3WN+Jd1t7k5Ta
X-Google-Smtp-Source: ABdhPJz6ZCsaRCaYn0/dXpkoq0t89WS+I2eYL4k7wfEmf0HDv7qHAzqf0aiVh+1SZg68re8mchcLAzKME83pi6d8Ecr+NFKr7eF2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a5d:9c56:: with SMTP id 22mr440813iof.10.1632336128946;
 Wed, 22 Sep 2021 11:42:08 -0700 (PDT)
Date: Wed, 22 Sep 2021 11:42:08 -0700
In-Reply-To: <2df6fec0e28411f2caedb117965041f1d9d03992.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001eb58c05cc99df86@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_recvmmsg
From: syzbot <syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com

Tested on:

commit:         cf1d2c3e Merge tag 'nfsd-5.15-2' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=3360da629681aa0d22fe
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e0894b300000

Note: testing is done by a robot and is best-effort only.
