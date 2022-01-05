Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6274E2C9D
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 02:41:07 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id n80-20020a6b8b53000000b00601ac7398c3so21208650iod.22
        for <mptcp@lists.linux.dev>; Tue, 04 Jan 2022 18:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Cy6r195dpfXJNfaiZPWGgcwpgNcg/nhPUZcgJcF4ZPk=;
        b=Gf8NWUqGlVCcEsXIBlCBSLf5pA8UoucN1aA67tz+7nesd/NiVTWIdUjPETvwA+tYaO
         s1J/jFTE+z5QQbqiUQiaVWyIZMDJouAZNJt9vxtdMTNAn69AWYbYvR4qxHIjFyKYp/pX
         HaiIQ0Pramobe+Bt0t6vci3AnN1fV0F2OL4Dz77GEdqZJMzpWN75TWBKsHmAJ8U7aHZt
         pTfd+VgWcc+PioO0FA9ulAOmfjJrg8C6bFlUyjAVSZTtKrzqTy0bMz/AjGQ6yOZa+7xe
         autJH6Z48+f/Vno7/DB28EvznrDsgOyxD/dHaNUKnNk3/FjkGvMZ1PTtkTt17pyW3IYA
         PewA==
X-Gm-Message-State: AOAM5300MUm+XF04Irkx3rg0G5UKwe1Mg0hhEKWgcEXhVLa9DsaQKhnA
	tw/ZvBw15bx1cc6KHQw6sJznK46okwWEIQNGIBGR93hayW7H
X-Google-Smtp-Source: ABdhPJxaTEKquMy+jQCyV04zhMrAUHxaEaQzz1SPAgXbC0sT2RL/etD/WefdxKxysRRNgAbR/7ALhPBTvmH3RzCJEDeR613RGmj4
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a6b:907:: with SMTP id t7mr22512140ioi.10.1641350466605;
 Tue, 04 Jan 2022 18:41:06 -0800 (PST)
Date: Tue, 04 Jan 2022 18:41:06 -0800
In-Reply-To: <a5728775-6a82-ba4f-5186-a237f531dd1@linux.intel.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083950e05d4ccaf75@google.com>
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

commit:         ffd32ea6 Revert "net: wwan: iosm: Keep device at D0 fo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master
dashboard link: https://syzkaller.appspot.com/bug?extid=bc9e2d2dbcb347dd215a
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1216323bb00000

