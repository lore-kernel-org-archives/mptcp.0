Content-Type: multipart/mixed; boundary="===============8983903591560263709=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in dst_release
Date: Thu, 18 Feb 2021 15:06:28 +0100
Message-ID: <20210218140628.GD22944@breakpoint.cc>
In-Reply-To: 00000000000002cc3e05bb9c8436@google.com
X-Status: 
X-Keywords:                  
X-UID: 7845

--===============8983903591560263709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

syzbot <syzbot+b53bbea2ad64f9cf80d8(a)syzkaller.appspotmail.com> wrote:
> Hello,
> =

> syzbot has tested the proposed patch and the reproducer did not trigger a=
ny issue:
> =

> Reported-and-tested-by: syzbot+b53bbea2ad64f9cf80d8(a)syzkaller.appspotma=
il.com

#syz-fix: mptcp: reset last_snd on subflow close

[ This patch is currently in mptcp-next ]
--===============8983903591560263709==--
