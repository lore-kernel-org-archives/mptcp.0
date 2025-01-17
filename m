Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E319ADA4
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135126; cv=none; b=PkBZbyoZ/J9rKrS6P5/+g4tSvJn74Pl3j8U0+LIHkV0YAoiikmMxyjbHFC7gJDgkFpd4h9+4GFFzJDwmd+V9jZFCuG/jXDWt+v5qi9Ae25YQN06OVfxrTJON3s06lpc+7txubquZvdME/y03iX7L6cq77uEViQm1p+ivHHfKVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135126; c=relaxed/simple;
	bh=2Nk2Oy1IWVAKqUUJi2SAb+QprDPIbFPfhxGF+Nkq5bw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=To5+7c7gnNPDvbshAZs/zMudA2h3PNlRNXFMq1zd801Qt8I9fW48T/hS2NF7W49N5XiiBHr87LRN10Ec6KP3Gs46Xw9GzBmzvX9AL6Gq1OSoe5ct0SljMN6VPtuzbHCILQX3w+j0eUgjZdglk8cXjzm6yeX9JOoTlTSShcj3Rvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ce8868a7a5so18748965ab.1
        for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 09:32:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737135123; x=1737739923;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axNUQUDH1jvBaGJQhc6GPaD1iNkdOyagDPhgOxI6o10=;
        b=q0br/3npLfBr4Gnm7v7W+13cYBZzIAzqBeoGgvqw0wjVz7buQJJVyz+PiAz7PREdzA
         83m9YQ9ct1BcuLudqrxFNjI+ennmrMAMbsx9rNb05/dd8G9Br0SgyvmBIi1Ar+oA2aH1
         qrfVSyvkthtZ0XP/2xD0XeIHfrkKhyhFafPvltMOxWDBmBnU4JEHsenpvgylgj4oB47d
         2JOWjyU1U80wGRNfX6pp6Ff8e/7rLlnP2Knw0S4Fj3f/FmjozDk2PM5qWKwMZkRdznnU
         Z4AgnNlfmPiO/RZXPm6eeF2zM+oVuohS9P7AwONP46S3FOQ3+cbErIhrJa55ehEGMr6E
         jrKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKT1qjHKT5xE2CoQwId0RcGYlqp2dkiKu4XvgJTlZ3VNy6nskwqF2tv/H4A1qC7A5ywkqNCA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz90ZyGUbFcw6qHYX1ilsHzHG/jCq610jUNs+LLgRn9I8n7i9Zh
	q4hKyosbJ69DPMimwidCAd6Hy37tPIhTxrM+OuFdG6P3Y1ZIdwYD55/T+WGVVkb7pHEJSLWiSTx
	NCmDDoeucliKKMvv/DdnXLkJAW+s6u8+8sgfYA6wx7h0Hrs9R4ByqE54=
X-Google-Smtp-Source: AGHT+IGo3YxZCNQ/w3Z1ipsSeX4bR/eBqKzP/x6yGR1c20N50Nr9fqm006172S4TfgbGkDD9mp3faP9wzzce+9oZyLBLfNmUd+bT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8e:b0:3ce:7b33:8c3b with SMTP id
 e9e14a558f8ab-3cf747e2027mr28485745ab.5.1737135123486; Fri, 17 Jan 2025
 09:32:03 -0800 (PST)
Date: Fri, 17 Jan 2025 09:32:03 -0800
In-Reply-To: <66fa6c80-4383-479d-b17e-234bee6ed7ad@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678a9413.050a0220.303755.0011.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
From: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Tested-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com

Tested on:

commit:         5d6a361d Merge branch 'realtek-link-down'
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=151669df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10983a18580000

Note: testing is done by a robot and is best-effort only.
