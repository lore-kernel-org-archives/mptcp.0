Content-Type: multipart/mixed; boundary="===============3571319136357304829=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net] mptcp: set correct vfs info for subflows
Date: Thu, 07 May 2020 18:16:51 -0700
Message-ID: <20200507.181651.1434873497888506640.davem@davemloft.net>
In-Reply-To: a2fde8fb93863b0ffdeea94b5f44ba64b7601c5d.1588865446.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4348

--===============3571319136357304829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Thu,  7 May 2020 18:53:24 +0200

> When a subflow is created via mptcp_subflow_create_socket(),
> a new 'struct socket' is allocated, with a new i_ino value.
> =

> When inspecting TCP sockets via the procfs and or the diag
> interface, the above ones are not related to the process owning
> the MPTCP master socket, even if they are a logical part of it
> ('ss -p' shows an empty process field)
> =

> Additionally, subflows created by the path manager get
> the uid/gid from the running workqueue.
> =

> Subflows are part of the owning MPTCP master socket, let's
> adjust the vfs info to reflect this.
> =

> After this patch, 'ss' correctly displays subflows as belonging
> to the msk socket creator.
> =

> Fixes: 2303f994b3e1 ("mptcp: Associate MPTCP context with TCP socket")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Applied and queued up for -stable, thanks.
--===============3571319136357304829==--
