Content-Type: multipart/mixed; boundary="===============5545536845545087653=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 1/3] mptcp: add reuseaddr/port and
 v6only setsockopts
Date: Tue, 16 Jun 2020 08:46:21 -0700
Message-ID: <20200616154621.GH3048@MacBook-Pro-64.local>
In-Reply-To: 20200616122531.2443-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4701

--===============5545536845545087653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/16/20 - 14:25, Florian Westphal wrote:
> Paolo says he prefers direct hooking of SOL_SOCKET instead of copying
> values in bind/listen/connect, so do that here.
> =

> Similar to the v1 patchset, except that first patch is new (adds
> needed 'do not use generic handler' for mptcp sake),
> second patch adds minimal SOL_SOCKET support (rest yields -EOPNOTSUPP).
> Last patch is almost the same as v1 (only fixes an error check and
> extends scope of sk lock).

Nice! I gave it a shot and restarting sshd now works fine on my test-machin=
es!

I also am running syzkaller on these to see if anything breaks.


Christoph

--===============5545536845545087653==--
