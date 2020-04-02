Content-Type: multipart/mixed; boundary="===============5993110713139300961=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [selftests] eedbc68532:
 kernel-selftests.net/mptcp.pm_netlink.sh.fail
Date: Thu, 02 Apr 2020 10:07:34 +0200
Message-ID: <7a1b24ac-73f2-bac1-f450-d8e6c802c0ce@tessares.net>
In-Reply-To: 20200402074609.GH8179@shao2-debian
X-Status: 
X-Keywords:                  
X-UID: 4128

--===============5993110713139300961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for the automatic bug report!

On 02/04/2020 09:46, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> =

> commit: eedbc685321b38fea58a14c9fbd258c4b2c2747c ("selftests: add PM netl=
ink functional tests")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

(...)

> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):

(...)

> # selftests: net/mptcp: pm_netlink.sh
> # defaults addr list                                 [ OK ]
> # defaults limits                                    [ OK ]
> # simple add/get addr                                [ OK ]
> # dump addrs                                         [FAIL] expected 'id =
1 flags  10.0.1.1
> # id 2 flags subflow dev lo 10.0.1.2
> # id 3 flags signal,backup 10.0.1.3 ' got 'id 1 flags  10.0.1.1

(...)

> not ok 2 selftests: net/mptcp: pm_netlink.sh # exit=3D1

This issue has already been fixed:

   3aeaaa59fd69 (selftests:mptcp: fix failure due to whitespace damage)

This commit -- making both Git AM and selftests happy :) -- has been =

quickly applied by David (thank you for that!) and it is already in =

Linus tree.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5993110713139300961==--
