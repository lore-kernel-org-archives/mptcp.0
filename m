Content-Type: multipart/mixed; boundary="===============5864527124975858687=="
MIME-Version: 1.0
From: Song Liu <song at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH bpf-next v2 3/5] bpf: add 'bpf_mptcp_sock'
 structure and helper
Date: Mon, 14 Sep 2020 14:00:47 -0700
Message-ID: <CAPhsuW7Qk8bea0efQspCOBbBaahgYt5eebvwvnGrA3xz9tw1Tg@mail.gmail.com>
In-Reply-To: 20200911143022.414783-3-nicolas.rybowski@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5863

--===============5864527124975858687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 8:15 AM Nicolas Rybowski
<nicolas.rybowski(a)tessares.net> wrote:
>
> In order to precisely identify the parent MPTCP connection of a subflow,
> it is required to access the mptcp_sock's token which uniquely identify a
> MPTCP connection.
>
> This patch adds a new structure 'bpf_mptcp_sock' exposing the 'token' fie=
ld
> of the 'mptcp_sock' extracted from a subflow's 'tcp_sock'. It also adds t=
he
> declaration of a new BPF helper of the same name to expose the newly
> defined structure in the userspace BPF API.
>
> This is the foundation to expose more MPTCP-specific fields through BPF.
>
> Currently, it is limited to the field 'token' of the msk but it is
> easily extensible.
>
> Acked-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Acked-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Nicolas Rybowski <nicolas.rybowski(a)tessares.net>

Acked-by: Song Liu <songliubraving(a)fb.com>
--===============5864527124975858687==--
