Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393F86327
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737726186; cv=none; b=kOFIgh+QXRdnrU11h7EfpRykbY7p8TkLQFBl+VHOHsnVc52aAdCcYLz7FLSeM5cehg+eOIzP1QCK8Y6OcoCl36pnhFL8ZoUWowyY7Zb/TFie1Z9z+MDBBR3wDA4Fns89GOPCGARoztSiW2FNbI9ne9TueyJykMRofzwhxq7MtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737726186; c=relaxed/simple;
	bh=n8OZ3b/yHRWJF9A8gcfHJ7tGWiWPREHXqrj4JQyfRFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R2TVRaEEMZQUmGXj5XisSGtoAoKKCpuC5GCmwENuoJ0i56P3jvxoqzZKo6KYHwqnziaQWTGWhNvtg2ZGQsfH7U02W8kdhAYRfWr2t58389vdb+JVS5ujXFtoN9axOmXoQI9MTVKz1NHZCWpPU7suw6U8m5/Q78cZ8ep6dqp/Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3cca581135dso29047215ab.3
        for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 05:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737726184; x=1738330984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pZe/q9uQMTJ1h6+AXXu51oqWvY3EGvpD1rhxTUhiCw=;
        b=G07UeUjrezyn58y9JNGXQPi1Vzj8wCBN9IsRcwX0zo/90WXuVDd7l4Q6A7Gpu8RX1z
         SkojyPjk4H5APVEwmqMvJweJQZGHWTBL5jMjTv2Vcx4PTStayojEoV6mj7yfO4AXW4sk
         ajynZAC5rMQaHX7i9+FbLS964NQcOLv9D5aanHEyQYYzE4L9UtS1Zd/pT8UqbhiZeD2w
         PkQsxveGq3hNp6XCc3anL0/viJtHrOOKAqIuaK+TvqYUGzMqoNhaTqeok2U8lQq+4xNL
         505BaP1OsBAJR03lVebyOBEGgup+sr+cvg1/5vvrGvwzlEHnECjawyzfQD5IQZmCdauK
         ofiw==
X-Forwarded-Encrypted: i=1; AJvYcCWgoyLHyWX+lQqQ8Xhd4WV1ejB2bhSgVOy5IXLbBRUmEduVE62a8R8dyCL5mZ8zuElncoufLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfU7/AtNMtLRV/K6ztHtzvO/z9x5CNAbnoRDh1URgwsRyaxZW5
	hvKCT/v/v6Vwf+PQxWSzqgbt6Rlmo1Lz5jA2qd1+WtpLBGkD1E9nLbBRDMsKFlMxWMQoUKIJkyu
	tsCYnQPYBqcopwMtZABkjZLzGTpIRTs3KJzTyRfnlPYFGZ9QRCWwsJrw=
X-Google-Smtp-Source: AGHT+IHK9J8OswljrqskgVtLCWuKfDYf9V/LMLUGMG1IR6LhNN3Im86vudLsPDVLvtHBMCmDTGo+FZJvCui01vqHBrHYGxG8x3MI
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4918:b0:3cf:b2b0:5d35 with SMTP id
 e9e14a558f8ab-3cfb2b05ec7mr102563925ab.7.1737726184066; Fri, 24 Jan 2025
 05:43:04 -0800 (PST)
Date: Fri, 24 Jan 2025 05:43:04 -0800
In-Reply-To: <6786ac51.050a0220.216c54.00a6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679398e8.050a0220.2eae65.001d.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_set_flags (2)
From: syzbot <syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 322ea3778965da72862cca2a0c50253aacf65fe6
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Mon Aug 19 19:45:26 2024 +0000

    mptcp: pm: only mark 'subflow' endp as available

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f0bab0580000
start commit:   d1bf27c4e176 dt-bindings: net: pse-pd: Fix unusual charact..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f0bab0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0bab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=cd16e79c1e45f3fe0377
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11262218580000

Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
Fixes: 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
