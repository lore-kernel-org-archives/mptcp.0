Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84064DDA8
	for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722391205; cv=none; b=johRCkizCbWDdMHx+SeHBpIkuS/vp4JuwtAmLrsp65KIGv68mDoRTZIB2ujJcvitwrbbx3T6ZVSQq2m0crtoqVFSkkReivZJmzIU3DiGCxZ6wri9CbYOa/NT0qCJmt0B1cXPkLWn8WGg1pSdn6v2zrujNdkGsz563etIaTHD1x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722391205; c=relaxed/simple;
	bh=K1qOC5tHUaMsNZMC1TjMJaYf6RAeKSo/0m0qrGDii54=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ghf2jZAc20j7QtP6QU2yXYwTqENrl4i/8kxNA/VKMqFffLcF2PvL9saE7CZfspv0I9TthLydgXXydjfl2ufAA+0l1MKE2EwsMgLZXUnLKpgrt3Me5xUCoNzWcappMqJCZG1a9jSQ/RSDoPibwpjxTaptpiqTcAsKRmH+zkiUi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39915b8e08dso106021315ab.0
        for <mptcp@lists.linux.dev>; Tue, 30 Jul 2024 19:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722391203; x=1722996003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oifXDfDa4Pc0Sdv5gbrkS91BTKOjBFXuRwSI5Vt+woE=;
        b=Y3NOe46j/mDPVETzUtfRrdM1OHgd8ENfKa1FqKo9kNzRtiB8I7IASwcCGLW8gZL4s/
         Pmtr9W9NCHiR594jPGzAU3A32RqBoXARa23PQlgkiH8O8AxQvqMOO9sZ3hHmhPlSr7OI
         kiz0ZajAOkpfwhi6eRQqAsrSUy4TAdYnqwINKPca0LxZ1TMaoVLKwnT5uR25VOHP6l+J
         e03utZUcvXYeoqUgKug5l1ePAXFKFzl2VFpuT3N5Lxfcb2IthFnvsndproNIAKB9+FwF
         Wma29+XljYKdTgNQybDShGiX4RRWfAeA3520jPRi+a+66YRbu3VDIp8yTj56kSQ2KwcV
         53JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWeoFlWFJe3gKEmNasJQa9e7PmsC9ymQWGnhirdM/G1QGk64Bp5zT4oWf4UZUe84XeoIwPEYdPr5UuNsDWlHKltbH6s8o=
X-Gm-Message-State: AOJu0YzjAb7EDIqUoNJPMb2Yww7Wa3C+HJGgP/Sns6HGHO6n3zWcKyYg
	rwTpjDc96sL/eD5O7hLZHfVHR35QifCqvouIcsG6E2UMInrPt6fK/JoFnN9ec1Ly33OepeAlJGp
	mkMXNKOLWMMj7w7P5Tt3egFUsFR1TcqP3s6h6fNhJ4hjFN79yqYNOm+E=
X-Google-Smtp-Source: AGHT+IEc9c926Yi+AT5PgUKRiu91sAVFQJ4tCQhhgGVLxxVCE3cfKmVkDEp3A00yLNByqBX3a4esm6+HSw2f3lbDf8KogXFJ5U+M
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1d:b0:397:95c7:6f72 with SMTP id
 e9e14a558f8ab-39aec448e1cmr10502905ab.6.1722391203729; Tue, 30 Jul 2024
 19:00:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 19:00:03 -0700
In-Reply-To: <0000000000005dc7ce0611833268@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dce735061e8173dc@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una
From: syzbot <syzbot+5b3e7c7a0b77f0c03b0d@syzkaller.appspotmail.com>
To: cpaasch@apple.com, davem@davemloft.net, edumazet@google.com, 
	geliang.tang@linux.dev, geliang@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fb7a0d334894206ae35f023a82cad5a290fd7386
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon Apr 29 18:00:31 2024 +0000

    mptcp: ensure snd_nxt is properly initialized on connect

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c8bdbd980000
start commit:   4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d7c92dd8d5c7a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=5b3e7c7a0b77f0c03b0d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc9c8a180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d0cc1c180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mptcp: ensure snd_nxt is properly initialized on connect

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
