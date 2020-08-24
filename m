Content-Type: multipart/mixed; boundary="===============7944732743718497585=="
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH bpf-next 0/3] bpf: add MPTCP subflow support
Date: Mon, 24 Aug 2020 15:01:00 -0700
Message-ID: <20200824220100.y33yza2sbd7sgemh@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: 20200821151544.1211989-1-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5614

--===============7944732743718497585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 05:15:38PM +0200, Nicolas Rybowski wrote:
> Previously it was not possible to make a distinction between plain TCP
> sockets and MPTCP subflow sockets on the BPF_PROG_TYPE_SOCK_OPS hook.
> =

> This patch series now enables a fine control of subflow sockets. In its
> current state, it allows to put different sockopt on each subflow from a
> same MPTCP connection (socket mark, TCP congestion algorithm, ...) using
> BPF programs.
> =

> It should also be the basis of exposing MPTCP-specific fields through BPF.

Looks fine, but I'd like to see the full picture a bit better.
What's the point of just 'token' ? What can be done with it?
What are you thinking to add later?
Also selftest for new feature is mandatory.
--===============7944732743718497585==--
