Content-Type: multipart/mixed; boundary="===============4954692016892859261=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: fix double-unlock in mptcp_poll
Date: Sun, 12 Apr 2020 21:05:08 -0700
Message-ID: <20200412.210508.28307843911867097.davem@davemloft.net>
In-Reply-To: 20200411190501.13249-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4158

--===============4954692016892859261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Florian Westphal <fw(a)strlen.de>
Date: Sat, 11 Apr 2020 21:05:01 +0200

> mptcp_connect/28740 is trying to release lock (sk_lock-AF_INET) at:
> [<ffffffff82c15869>] mptcp_poll+0xb9/0x550
> but there are no more locks to release!
> Call Trace:
>  lock_release+0x50f/0x750
>  release_sock+0x171/0x1b0
>  mptcp_poll+0xb9/0x550
>  sock_poll+0x157/0x470
>  ? get_net_ns+0xb0/0xb0
>  do_sys_poll+0x63c/0xdd0
> =

> Problem is that __mptcp_tcp_fallback() releases the mptcp socket lock,
> but after recent change it doesn't do this in all of its return paths.
> =

> To fix this, remove the unlock from __mptcp_tcp_fallback() and
> always do the unlock in the caller.
> =

> Also add a small comment as to why we have this
> __mptcp_needs_tcp_fallback().
> =

> Fixes: 0b4f33def7bbde ("mptcp: fix tcp fallback crash")
> Reported-by: syzbot+e56606435b7bfeea8cf5(a)syzkaller.appspotmail.com
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  NB: Reproducer did not trigger for me, so i can't be 100% sure,
>  but looking at the 'Fixes' commit the change to
>  __mptcp_needs_tcp_fallback was broken.

Applied, thanks Florian.
--===============4954692016892859261==--
