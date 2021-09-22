Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE73FC7
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 15:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632323629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EPOrsCXJCI2JISUvTnGCdXaDuxLEQ6pf0yprZLLbiA=;
	b=fgPN+RBNNUtlZSaKgWU57sefNrBqjkDUWF3LUMXN8wR9qJemWH2ORYuH/NEUhdEee/P0HL
	RZeHrOOgbWQhAmXB3XxhmiHu6L+cXWdOa22N0gojL07LjZvhHDq/q8e5GinRQgwBqDN5P3
	409A2+0cBPPNwjhEY2qd6DZKTOyAjp8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-BrK4yyngMn2ssxQwJYlBmQ-1; Wed, 22 Sep 2021 11:13:45 -0400
X-MC-Unique: BrK4yyngMn2ssxQwJYlBmQ-1
Received: by mail-wr1-f69.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so2483494wrv.6
        for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 08:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5EPOrsCXJCI2JISUvTnGCdXaDuxLEQ6pf0yprZLLbiA=;
        b=VBnmM3Q3NVKrNe1amtC99mS7fsjeoo4p6dpoblfxk+hbQ/fqqCHLGCDRl7vm0vzt3g
         8d0Yas4IM3UoZOranaEZy1yoot7UmwBLmjRwTGldi/QHnuhYhtLHlzU3duGAKiWog0tT
         KCzGCpIRmJhwlZ+gElwRRkwXI01cG8XkEh9MkhvQ0z036afgTDjaQ+SIGcqJMrB67IIq
         vQHAvrAgvsZMHHpmnbfTINVjPsAgkepIAjbLW/Pz3DPlhcKyaty9J5OQQBZ1AGnzxOmb
         jQ/jc6gCig9cbilZyVXQ2pid2McPcwkZM2283DbyrCBrQ9+LYxo0pegSQ1N7hXrJZlHZ
         nPwQ==
X-Gm-Message-State: AOAM530U8algbYbzEswKiomV3cPnr6w05kqMeE1W4Nw6W+Ar9vnQz5/c
	DPl+v9OMX9f/wKFrRTCrtwcwIhMfIiU5bFLNe4ZzkJAPY6rodfdiqYAbTv3VbUHE21e7I1p6h/0
	qRZURqkUK6BM+9RI=
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr26414wrz.337.1632323624402;
        Wed, 22 Sep 2021 08:13:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvnvC1X46a60tAUJjRFUNeH9O76Z4tTvV4A0XH/5wYBwm8hZIYhzLdFFgPJ1WG9X83xkic8A==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr26378wrz.337.1632323624166;
        Wed, 22 Sep 2021 08:13:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id m4sm6559554wml.28.2021.09.22.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:13:43 -0700 (PDT)
Message-ID: <89d72aca4e30335a03322612cf164420be11d8eb.camel@redhat.com>
Subject: Re: [syzbot] INFO: rcu detected stall in sys_recvmmsg
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com>, 
 axboe@kernel.dk, christian.brauner@ubuntu.com, davem@davemloft.net, 
 dkadashev@gmail.com, kuba@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mathew.j.martineau@linux.intel.com, 
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com,
 torvalds@linux-foundation.org,  viro@zeniv.linux.org.uk
Date: Wed, 22 Sep 2021 17:13:42 +0200
In-Reply-To: <0000000000003216d705cc8a62d6@google.com>
References: <0000000000003216d705cc8a62d6@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-09-21 at 17:13 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    1f77990c4b79 Add linux-next specific files for 20210920
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1383891d300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ab1346371f2e6884
> dashboard link: https://syzkaller.appspot.com/bug?extid=3360da629681aa0d22fe
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1625f1ab300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17eb1b3b300000
> 
> The issue was bisected to:
> 
> commit 020250f31c4c75ac7687a673e29c00786582a5f4
> Author: Dmitry Kadashev <dkadashev@gmail.com>
> Date:   Thu Jul 8 06:34:43 2021 +0000
> 
>     namei: make do_linkat() take struct filename
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f5ef77300000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f5ef77300000
> console output: https://syzkaller.appspot.com/x/log.txt?x=13f5ef77300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3360da629681aa0d22fe@syzkaller.appspotmail.com
> Fixes: 020250f31c4c ("namei: make do_linkat() take struct filename")

I'm unsure why the bisection points to this commit. This looks like an
MPTCP specific issue, due to bad handling of MSG_WAITALL recvmsg()
flag.

I'll test a fix with syzbot to confirm the above.

Cheers,

Paolo

