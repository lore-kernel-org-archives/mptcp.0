Content-Type: multipart/mixed; boundary="===============2106951763835110033=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 2/2] mptcp: better msk-level shutdown.
Date: Tue, 12 Jan 2021 13:38:18 -0800
Message-ID: <f3965cdf-a9f8-b36e-cc1a-3d29ce3fadff@linux.intel.com>
In-Reply-To: 4cd18371d7caa6ee4a4e7ef988b50b45e362e177.1610471474.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7335

--===============2106951763835110033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Jan 2021, Paolo Abeni wrote:

> Instead of re-implementing most of inet_shutdown, re-use
> such helper, and implement the MPTCP-specific bits at the
> 'proto' level.
>
> The msk-level disconnect() can now be invoked, lets provide a
> suitable implementation.
>
> As a side effect, this fixes bad state management for listener
> sockets. The latter could lead to division by 0 oops since
> commit ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling").
>
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")
> Fixes: ea4ca586b16f ("mptcp: refine MPTCP-level ack scheduling")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 62 ++++++++++++--------------------------------
> 1 file changed, 17 insertions(+), 45 deletions(-)
>

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2106951763835110033==--
