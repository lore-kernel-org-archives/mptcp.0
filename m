Content-Type: multipart/mixed; boundary="===============6788969763982472411=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 0/2] mptcp: simplify mptcp_accept()
Date: Tue, 10 Mar 2020 15:52:03 +0100
Message-ID: <e1552cda2f63fdcf68907599b3c2e47f2f765f06.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003091734550.11245@brhill-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3898

--===============6788969763982472411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-03-09 at 17:57 -0700, Mat Martineau wrote:
> On Fri, 6 Mar 2020, Paolo Abeni wrote:
> =

> > this is a rebase on top of net-next, with hopefully
> > more correct error handling - catches mptcp_token_new_accept()
> > errors and fallback to TCP freeing the newly create msk.
> > =

> > Additionally add a follow-up patch dropping unneeded
> > subflow->conn checks.
> > =

> > Idea is to send this upstream after that -net is merged back
> > into -net-next, to deal with conflicts in
> > mptcp_established_options_dss() due to 2398e3991bda ("mptcp:
> > always include dack if possible.")
> > =

> =

> I think there should be a merge from -net soon, as there's a conflict in =

> inet_diag.c that will likely trip up the linux-next merge.
> =

> The changes look good. With the cleanup in the second patch, there's one =

> additional area that I have a question about that wasn't modified. At the =

> end of mptcp_subflow_create_socket(), subflow->conn is assigned after the =

> subflow sock lock is released. Since the socket and context are newly =

> created it may be safe to modify subflow->conn without the lock, but it =

> would be simple to rearrange slightly and complete the subflow setup with =

> the lock held =


Agreed - even if it looks a bit unrelated from these patches ?!?

> (the lock is acquired for a reason, right?).

Uhm... thinking about it, the socket is not exposted to user-space and
is unconnected, unhashed, and not yet on conn_list/join_list, so I
think no other process/CPU can actually touch it before
mptcp_subflow_create_socket() completes ?!?

Cheers,

Paolo

--===============6788969763982472411==--
