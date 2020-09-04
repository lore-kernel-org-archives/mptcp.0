Content-Type: multipart/mixed; boundary="===============8021020085309608707=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2 0/5] bpf: add MPTCP subflow support
Date: Fri, 04 Sep 2020 17:28:29 +0200
Message-ID: <a062b8d9-2a37-eb45-7290-41446d9e5317@tessares.net>
In-Reply-To: 20200902170443.272113-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5722

--===============8021020085309608707==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 02/09/2020 19:04, Nicolas Rybowski wrote:
> Previously it was not possible to make a distinction between plain TCP
> sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
> =

> This patch series now enables a fine control of subflow sockets. In its
> current state, it allows to put different sockopt on each subflow from a
> same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
> BPF programs.
> =

> It should also be the basis of exposing MPTCP-specific fields through BPF.

Thank you for the v2. I just added these patches at the beginning of the =

tree. I did two small modifications, nothing big, see patch 4/5 for more =

details.

CI + export are in progress.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============8021020085309608707==--
