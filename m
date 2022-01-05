Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F9168
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 23:26:17 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id e2-20020a6bb502000000b00601c16cb405so558970iof.13
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 15:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TSjq2yzjfFkuT/ra58FoqgcF3Z9B/CZjdc3yhAGXQ/s=;
        b=vCjvwxhX6IcTZiMvKpe4S6+oaDACVxScNN0wyKBqM4vfdGHjHrBAh4gyibe0si7YUK
         7cBQr1kqJSHeiRrs8oQ9DWyilQx5dlqGQvam8TF7fG+/o4X35CmnbBmskoNbf1WNIs3X
         7llOK9ULieJqeZemCPbHyNENAnb50vIOK721K3wBz3hQagckKjMGiICfjfdk+a+MNqwG
         AMnvdINjtcn+k60n+8O8nckFljIEg1kjoppLCGigas38U9dHC0BvJKq74Y8L69gsXDIA
         8AgTMY5GIQkqEnu1Hq77xVHX6xtXp9bgE3f1D322Y1gzn4K8pgUNQgq67cO1+WGkzHBh
         m/1A==
X-Gm-Message-State: AOAM531/dUUfBhDLv06Mvq0TFvPs3rc2wgnQrpQfudm5KI7jWm5AfC85
	MqqsopLGFvihdBNK1U07fVHTwROaX8FAdCv/Xl87KjW7HZZO
X-Google-Smtp-Source: ABdhPJyizpDNl7OKfwwaKA0WczyZbmsDUs0SySJJN7GjfMnCAMHe5U7cyhNMwWg36Z3V8qbojKrYiNZ6MkpZUIvBvYz8ma0IuBU+
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a02:c4d8:: with SMTP id h24mr6252486jaj.84.1641425176662;
 Wed, 05 Jan 2022 15:26:16 -0800 (PST)
Date: Wed, 05 Jan 2022 15:26:16 -0800
In-Reply-To: <9a76976-60bd-4bd-fc8f-b3b5782535b6@linux.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094992d05d4de14b3@google.com>
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

commit:         b9adba35 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168e0c07b00000

