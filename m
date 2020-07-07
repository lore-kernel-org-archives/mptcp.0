Content-Type: multipart/mixed; boundary="===============9066813710551345427=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: WARNING in warn_bad_map
Date: Tue, 07 Jul 2020 17:18:02 +0200
Message-ID: <0c2f021ca49f1eb12e87369e88f76bc9314511ea.camel@redhat.com>
In-Reply-To: 000000000000c6b93705a8a8e304@google.com
X-Status: 
X-Keywords:                  
X-UID: 4933

--===============9066813710551345427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[stripping some recipients, since the following should be syzbot-
specific]

On Mon, 2020-06-22 at 02:30 -0700, syzbot wrote:
> syzbot found the following crash on:
> =

> HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.or=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D11124521100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd195fe572fb15=
312
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D42a07faa5923cfa=
eb9c9
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> =

> Unfortunately, I don't have any reproducer for this crash yet.
> =

> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+42a07faa5923cfaeb9c9(a)syzkaller.appspotmail.com

This should be fixed by the combination of commit 0e7bc442b405 ("mptcp:
fix DSS map generation on fin retransmission") (currently on -net) and
commit 13f1555c1b4c49b8ab9dd80b7353deec0526ccac (currently only on net-
next).

In not clear to me how to communicate the above to syzbot. Any
suggestion more than welcome!

Thanks,

Paolo

--===============9066813710551345427==--
