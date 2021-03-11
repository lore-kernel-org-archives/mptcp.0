Content-Type: multipart/mixed; boundary="===============0828404084902173588=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/3] mptcp: only admit explicitly
 supported sockopt
Date: Thu, 11 Mar 2021 09:25:34 +0100
Message-ID: <05d59b20-0e7f-77d4-0d39-b8b0c1572e10@tessares.net>
In-Reply-To: 6bde45df6832e151e57ef75e493b6375cbac9384.1614965103.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8094

--===============0828404084902173588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 05/03/2021 18:31, Paolo Abeni wrote:
> Unrolling mcast state at msk dismantel time is bug prone, as
> syzkaller reported:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.11.0-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor905/8822 is trying to acquire lock:
> ffffffff8d678fe8 (rtnl_mutex){+.+.}-{3:3}, at: ipv6_sock_mc_close+0xd7/0x=
110 net/ipv6/mcast.c:323
> =

> but task is already holding lock:
> ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/ne=
t/sock.h:1600 [inline]
> ffff888024390120 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp6_release+0x57/=
0x130 net/mptcp/protocol.c:3507
> =

> which lock already depends on the new lock.
> =

> Instead we can simply forbit any mcast-related setsockopt
> =

> Fixes: 717e79c867ca5 ("mptcp: Add setsockopt()/getsockopt() socket operat=
ions")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> v1 -> v2:
>   - switch from blacklist to whitelist
> =

> A note on optname order. For each sol level, I tried to follow the
> order used by the corresponding relevant setsockopt(), with the
> following additional contraint:
> [1] opt which should currently work correctly with no changes come first
> [2] than opt that need some impl effort, but should not cause bugs/splat
>    ATM
> [3] then opt that are really a no-op - and currently work as intended
> [4] (commented out) unsupported opt come last, with related reasoning.
> =

> Note that [2] is likely too wide. This is intended as to start discussion.
> Looks like fixing issue/170 will require a bit of time :(

Out of curiosity, how did you define this first list? I mean: is it =

normal that some sockopts are not present there: not in a "case" or in =

the comments?

For example, Geliang noticed that when launching eBPF selftests, =

SO_SNDTIMEO* was not allowed for MPTCP sockets. But there is nothing =

about them.

Maybe this patch is enough: https://paste.centos.org/view/854d7e07

It is under testing by Geliang. At least to have the test passing, not =

sure if SO_SNDTIMEO is properly supported yet :)

But should we check (and have a test executed by the CI) to make sure =

all sockopts are at least written somewhere in the new sockopt.c file?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0828404084902173588==--
