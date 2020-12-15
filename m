Content-Type: multipart/mixed; boundary="===============0043511887199439975=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 net-next] mptcp: clear use_ack and
 use_map when dropping other suboptions
Date: Tue, 15 Dec 2020 10:42:31 +0100
Message-ID: <a513667f-5d6b-6789-895a-f56e1416e803@tessares.net>
In-Reply-To: ccca4e8f01457a1b495c5d612ed16c5f7a585706.1608010058.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7172

--===============0043511887199439975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Paolo,

On 15/12/2020 06:32, Geliang Tang wrote:
> This patch cleared use_ack and use_map when dropping other suboptions to
> fix the following syzkaller BUG:

(...)

> Reported-by: Christoph Paasch <cpaasch(a)apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/104
> Fixes: 84dfe3677a6f (mptcp: send out dedicated ADD_ADDR packet)
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Good catch, thank you for this fix and the review!

- 281bc5ad92db: mptcp: clear use_ack and use_map when dropping other =

suboptions
- Results: 663af8abf571..d73b2c933a85

Tests + export have been queued (sync with net-next job is in progress)

> ---
>   Obsoletes: v1 (mptcp: avoid using the main socket to send ack)

Thanks for this note, it is useful for me updating Patchwork!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0043511887199439975==--
