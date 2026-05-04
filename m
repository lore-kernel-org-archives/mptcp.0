Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BF3DE44E
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914844; cv=none; b=YrrpZdZNRC224x2SWm1x+MgbMOfLcc3WrPN92vzoqGWaByiDXhm+WkX01fYsxjEc9bq5HtqYfM/L/tbsRZoZ9dVvChuekO4D9ADFXsKtHKrg7afkiJmQJjupckhNSVb/GqgUjkucOwtdLkASTQXO4Eyr2dJIEoyGqr5Xk9Lmm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914844; c=relaxed/simple;
	bh=D+gXoeicY4zckpd5+/FUHgHwEoPTmd/fZgF3dl050Yk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X65IGUCiY+WcFQ0M+MyQ+buixPzb0KHi6g70a7k+Qn9hDsPScnJBUT0T3ARjlAMqthngPKAzOJ3cGT4H2A0e3RKmRAGvbCfNrHVakd+b/bfYJBlq+vWhEXGBY3t6RKZewUvcnieCChGrKN7yiKBAKe5h9orojwmw5SCbGHbgXVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dcc5fa38faso7392776a34.1
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 10:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914842; x=1778519642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihxbiXYXcarHct4N13aXdm5eSDtRNmDuuSbPeYyd0qw=;
        b=ignlSxABa/kucGD4QBXq6jAFQDARZLCQysepyCJIHK16KGnfDpJCzmJQcfvX0CGXiP
         k9GQ8rzveTWIU7sE38Ikog76cD1TKovgyulLdGMVACpiEAbYKBwg1lcIqh2rOsIE6yPI
         S9EQybftdLVj3B/b/FuRwiJsbMna5TfJHvbVKwX9JkuBhB2bcHiP6Rs9Vg5Wm2lZVnJN
         v4+5lXldNBfeqlWU1YC6/ul0w/TQEhzJaxndyW3P8KoJASza8fXEZ+m56vDyEt2aCwzc
         XI5mFKuxV9PIjDyuMUL+Zn9oSDBiHKB548jnEQuGo7P24AFi6pOVd+jarSPehV6wt40m
         apew==
X-Forwarded-Encrypted: i=1; AFNElJ/y/1J7NlDcXoJu8MgXXCdltavsybS0U0EaJyfu43XKXqGFswPil2uAFQRRZk/+aJSvFL6TwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC2jqrowVDXGE31DKS0T7HkKZ2pa7A7eSGaYCEA3HvlH/DBLNp
	eHhnwzjoBA6Jw/QAQrSOUYJga0p5vlHn7TSbY4lVIIM9F9H/w2XoGit6Npsi2G6Zz9h44WPuDH7
	g6frchUlX7Uyq9Qia2Oj7Z9r6804bcCqzxXWHXzyVNQvYT4dIfMpwm6XxsTo=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:211:b0:67b:c7a0:e4fa with SMTP id
 006d021491bc7-6969799e91cmr5219611eaf.4.1777914842489; Mon, 04 May 2026
 10:14:02 -0700 (PDT)
Date: Mon, 04 May 2026 10:14:02 -0700
In-Reply-To: <5841afcc-13ea-4bee-8645-634a02e76c4f@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f8d3da.170a0220.bb392.0003.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
From: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>
To: kuniyu@google.com, linux-kernel@vger.kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/net/mptcp.h
checking file net/mptcp/options.c
patch: **** unexpected end of file in patch



Tested on:

commit:         6d35786d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c3f61154f3bb7e5
dashboard link: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12558ad2580000

