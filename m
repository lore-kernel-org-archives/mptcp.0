Content-Type: multipart/mixed; boundary="===============0632241390818394592=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: possible deadlock in ipv6_sock_mc_close
Date: Mon, 01 Mar 2021 16:04:13 +0100
Message-ID: <26b3858e-6e5e-d782-118b-c4d64e2532f2@tessares.net>
In-Reply-To: 974A6057-4DE8-4C9A-A71E-4EC08BD8E81B@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 7974

--===============0632241390818394592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

(+ cc: MPTCP list)

On 01/03/2021 15:52, Chuck Lever wrote:
>> On Mar 1, 2021, at 8:49 AM, syzbot <syzbot+e2fa57709a385e6db10f(a)syzkal=
ler.appspotmail.com> wrote:

(...)

>> syzbot found the following issue on:

(...)

> Hi, thanks for the report.
> =

> Initial analysis:
> =

> c8e88e3aa738 ("NFSD: Replace READ* macros in nfsd4_decode_layoutget()"
> changes code several layers above the network layer. In addition,
> neither of the stack traces contain NFSD functions. And, repro.c does
> not appear to exercise any filesystem code.
> =

> Therefore the bisect result looks implausible to me. I don't see any
> obvious connection between the lockdep splat and c8e88e3aa738. (If
> someone else does, please let me know where to look).

 From what I can see from the bisect logs, it looks like this issue is =

difficult to reproduce. But it really looks like the issue is on MPTCP =

side and not directly related to your patch.

Thanks to the syzbot team for reporting this!

It doesn't look very simple to fix but we are tracking this on our side: =

https://github.com/multipath-tcp/mptcp_net-next/issues/170

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0632241390818394592==--
